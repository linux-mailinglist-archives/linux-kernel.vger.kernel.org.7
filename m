Return-Path: <linux-kernel+bounces-771062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAA8B2825D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA06B174C11
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA47F26980E;
	Fri, 15 Aug 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVvXt5kV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7065021B9D9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755269267; cv=none; b=BgA2GVuTT5ZuQevacQseBspWM2I2TcWwY18w6JHq3NFysZNMCLvdEItlTOCfMHjjfds4G4wf+zuUgxdX50FU+CYLWqNsVksSGGfvjHHbHHcHjIA8pM+RhRhq8RY3Vv4smp0qfkgeRVoLpZJ0u4MsbJo5BtSeNZerUKzF1kPIsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755269267; c=relaxed/simple;
	bh=xdUZbvvP5BuoQWRRALt16onXn8klRRXQWbHlnbMJMpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOa08aG2m4mH/+t+HmUaDNOpFWteGMsPWVNS6ozc8Syc79avvxUkuZV3DKC+Qib2jjbbeZnIGiZipmy5t/vQqRd0Cqr6TQaTh1Jowc+PutyNKhNN+T6Q8W/0DpEF2CmGJf0JiwhpnS4jUuKhtOZg5B2cKGhBNg6z75w7jydw/1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jVvXt5kV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755269264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YuqZDz3UQP/cJfs1heoJRSAkHvqNoUXD6C69NSB5QLY=;
	b=jVvXt5kVPiR2p0++zvP24fCNw4i02kV7RKq97mOW3xjTSmY6iHurWxKrcmm81F3ja6Z9CJ
	zwgS8FwqkDgt+xCO6SwI6vphC8eUAlIYWMc1TNXQ/JqZzDhthldkJIq9/ce2/xoCRmcxB8
	TpfgILz0c/62v9EmJ+qbvSfu+q79veo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-Ae_nZQtWOHGra2erubygZA-1; Fri, 15 Aug 2025 10:47:43 -0400
X-MC-Unique: Ae_nZQtWOHGra2erubygZA-1
X-Mimecast-MFC-AGG-ID: Ae_nZQtWOHGra2erubygZA_1755269262
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9d41bda7bso1334466f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755269262; x=1755874062;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YuqZDz3UQP/cJfs1heoJRSAkHvqNoUXD6C69NSB5QLY=;
        b=Y2486QgEfbVQ5nk/qiBh74z9W58zQS7BmQb75+mv2gBLcplLFDjA0ZH8e9+o/EzRbI
         bfTuKGUxHzf+DQ+5kNuegjAqAqhFrrvWja3fRrJuJte5L5oBHDqXltfj/Khy7vaKd9Dw
         6emPE+fK6DN8PTCUh9VFjzot+9Irlm6rxLbBoaLkAGl+LgjrFU1kJrIl9xEiZcFbPZ7u
         NBD+FsXAdw6puUKAqAK6KvQQY4/+sV7euWzlDkGFsDh9bRVLDGgB3BAIOYbsCmYQOB8R
         NKDaFX3KyWsp+Deih5DRDWlo9tt1ayLolBaG8d62TUL4ZMbrZB17MQ04AEzFnv3l/iS0
         jwMQ==
X-Gm-Message-State: AOJu0YyRgLuVBFtmpJ2QtaYztbubohJNfRAe5+jzORvC3dlER4+awVPC
	kymlgfbTKGpVueVlt7weZrxhmlNgsdS01kp8B5Zo+uSu5pqX6XJeLP4qsN2qAKMBeoLhMtViMmt
	Iv6EWgUFQ+SjxY0ggIMx/dRy42q6SHFqMpmBOAIQeKTNSBl+xUlGdRsSSbVZMVA/WNg==
X-Gm-Gg: ASbGnctLXfqohDBr6GKCBz5lpT/ocEGpMlLa7UFtMYkgriUxzK5kqYuVHVWOKj5vC9D
	2Ev6egSn6YnawhcH1aYJhjYhjUBIcXUWJm82WYfRoY/GJMRDgUZ1kx0vGOifSQg4xtHALYdb54k
	/bXAROMMFZdonZfpby2hyKpdogue1/coR2a+Pv3hS+9/EGd4kf5UQ6EZiD5B1sndF0nsKIvkTQG
	DehvXXKK/Y2due1Zh8dVLug+hTK7Dc5/VaRWQxaDzcVeDpZXs1MDyizgEiFJr9YUqkiMmK4nc3u
	un8PJE/MNarBjV9X2jjNIpoukGbhr8LeBg==
X-Received: by 2002:a5d:5d0c:0:b0:3b8:d139:5357 with SMTP id ffacd0b85a97d-3bb68cfaa4cmr1953627f8f.31.1755269261770;
        Fri, 15 Aug 2025 07:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL7YFA7ELcAI91dmqrawXf77GigKKZ9eDDNnklWW6ArRAShXjy1BG7DllrlPAmeq2NzUELvQ==
X-Received: by 2002:a5d:5d0c:0:b0:3b8:d139:5357 with SMTP id ffacd0b85a97d-3bb68cfaa4cmr1953612f8f.31.1755269261331;
        Fri, 15 Aug 2025 07:47:41 -0700 (PDT)
Received: from [10.4.0.18] ([147.135.244.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb68079d3fsm2301890f8f.55.2025.08.15.07.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 07:47:40 -0700 (PDT)
Message-ID: <4c9a8296-d17e-48d8-8f57-580f0a2946df@redhat.com>
Date: Fri, 15 Aug 2025 16:47:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] vfio: Deprecate fsl-mc, platform, and amba
To: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, eric.auger@redhat.com
References: <20250806170314.3768750-1-alex.williamson@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250806170314.3768750-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/6/25 19:03, Alex Williamson wrote:
> The vfio-fsl-mc driver has been orphaned since April 2024 after the
> maintainer became unresponsive.  More than a year later, the driver
> has only received community maintenance.  Let's take the next step
> towards removal by marking it obsolete/deprecated.
> 
> The vfio-platform and vfio-amba drivers have an active maintainer,
> but even the maintainer has no ability to test these drivers anymore.
> The hardware itself has become obsolete and despite Eric's efforts to
> add support for new devices and presenting on the complexities of
> trying to manage and support shared resources at KVM Forum 2024, the
> state of the driver and ability to test it upstream has not advanced.
> The experiment has been useful, but seems to be reaching a conclusion.
> QEMU intends to remove vfio-platform support in the 10.2 release.
> Mark these drivers as obsolete/deprecated in the kernel as well.
> 
> Thanks,
> Alex
> 
> Alex Williamson (2):
>    vfio/fsl-mc: Mark for removal
>    vfio/platform: Mark for removal
> 
>   MAINTAINERS                           |  4 ++--
>   drivers/vfio/fsl-mc/Kconfig           |  5 ++++-
>   drivers/vfio/fsl-mc/vfio_fsl_mc.c     |  2 ++
>   drivers/vfio/platform/Kconfig         | 10 ++++++++--
>   drivers/vfio/platform/reset/Kconfig   |  6 +++---
>   drivers/vfio/platform/vfio_amba.c     |  2 ++
>   drivers/vfio/platform/vfio_platform.c |  2 ++
>   7 files changed, 23 insertions(+), 8 deletions(-)
> 


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



