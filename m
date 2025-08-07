Return-Path: <linux-kernel+bounces-758809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCE5B1D41B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F24727EE9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24912550D4;
	Thu,  7 Aug 2025 08:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhPmoXBg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A0A2459D2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554377; cv=none; b=OMjH4PdbaYDIrHBdmIMYFvhwjYY+DnyVwkL2R0W7HrvJ5/rzOoF+uoYPXdlcvkkkZen/FtVSs42smGS8YFB9ANBrK5qehaLTeH81XF9vIOTaZcAqXSGYF2M7ELBYuVxWlUt8cvSaas1JgHwE3pP/eqRQnHhtV1lKBtSeTIVpWN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554377; c=relaxed/simple;
	bh=k/6tc9NbcaDu74J8Ujd5CIcZNK+IHGpjJSYSQ2uZnMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uavigqyUY8RC9c2XvbRXAzlXC4V0zFPQDPTLphkuZ4oU6KWjvYn3wI77zezI5+//v6sAL4vIUXkPL2IA2qorzXxiM6PiJF72LfITFGLRcXHu4hwjKiZiTR8Xq+vqB3FSifP5pq5hlUT9CNusJ3oVZO36WAJMNlv+hqhcDsrVBDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MhPmoXBg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754554374;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qvbx3D1NwDDjkwzVbaeev/eBkCMCtqgbfvWKeFB+QqE=;
	b=MhPmoXBgJOhYvbSvKRuDerIQoV7mwg0Jz9S8CazkntVgtrv7DzABg+W28bMn59HrzfQZKT
	NR70DCJm6OsSTuiZexoGvvzfhp9Kbw4EtqbRQe/Ziz5fAi5e6jOENy5POtXF1mQBQAPCBl
	M45fuA1lAa8XLLi62jVRHqN7gVxRf20=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-R0XImq-yMJ2QcKEUn2I-Zg-1; Thu, 07 Aug 2025 04:12:53 -0400
X-MC-Unique: R0XImq-yMJ2QcKEUn2I-Zg-1
X-Mimecast-MFC-AGG-ID: R0XImq-yMJ2QcKEUn2I-Zg_1754554373
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7073834cda0so14929886d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 01:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754554372; x=1755159172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qvbx3D1NwDDjkwzVbaeev/eBkCMCtqgbfvWKeFB+QqE=;
        b=N6/2/qmsTtQAUTUkpEnVj9RP6Np76/UQ2AfFCawlddF2vG8o98K3SP5hNkgdoLwLKB
         SOyZ1/wRl5+fPTfwirZhnf5YnupqHUndb6YQHE3NWte9/KcaM6HlXrlkO159EvB3ILvM
         kKHWUvWgZs0+7bwWI/hwB2xuwLTdwNQ5A6kEwbYrO97+j4GF7TDFyqTnUkC1T5ShzWYD
         ZVP2knkbKH8uctXnwl0Cv2H/iWppLes3umur7SVkYQ+GyIUZuvsujDTNX2wvsOZrtEXm
         LkcdNa28ZO8NEluWAXBfFkCQVKZcLs0OqF/bfESIn9Zm9GIfpfS3huDwuvL50g1kH0DJ
         i0iw==
X-Gm-Message-State: AOJu0YxlEL800xq+hF/aq7bEDmpyUkCsWyZFE2+iotFaQgOglfWRFE2i
	JNuW1OyHBituy7tcU2WrrEm4X+Fl/Hxk2I/XQkIzjxvOdrz3vmEFAaOcKCu8m8gvkZopy6LUaNz
	6Gyb8aa6s/xgtaLyfPM8Ync0h/NI6N32uDSxu0hzcOG1SjO1RlXt2q3N1lamrU3yYTQ==
X-Gm-Gg: ASbGncvm8b0VV5cWRZOU6LmZYsIODJw7xB5XKYcFZFBSpxGIGnGvLoevxGCNmkt9I7s
	AHuprEHq2DMBPRzivwTN8o6GW+Wvf4xvFZjzEbmhmdsb1VEZDOFMYvyrrj6HEqtI1SZr/no/bcl
	WgF5pvPxpApl8X+b9vvr82e+PhnqroRmnQ3iONpenzfqqFNyL0E0dV+lNgoyXGVaXv1VDnLBl/w
	l6g82tRPQcExaTOcmMyjXXsI2BXT+ItUPMlKrkt0Ju0tj2VPALgJWBzxbvX4dibtqENeyLl5sGF
	bUiV6aiuO8A/nHJ/M/W6wnzxkLSrCxYIGX6AFs+u6q0=
X-Received: by 2002:ad4:5cc2:0:b0:707:5ff2:ae87 with SMTP id 6a1803df08f44-709795648f0mr74596686d6.18.1754554372617;
        Thu, 07 Aug 2025 01:12:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwcZYfEQy6iy9UL2xTDhxg8p5mWd43fDI3rjApX13ozfe17GvhEWhlLZCOj6ouaWiLP3Fsdg==
X-Received: by 2002:ad4:5cc2:0:b0:707:5ff2:ae87 with SMTP id 6a1803df08f44-709795648f0mr74596496d6.18.1754554372130;
        Thu, 07 Aug 2025 01:12:52 -0700 (PDT)
Received: from [192.168.43.95] ([37.167.96.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cd56e1csm96276266d6.45.2025.08.07.01.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 01:12:50 -0700 (PDT)
Message-ID: <2cf5aed8-3636-40f3-9ecf-21270ad83f9b@redhat.com>
Date: Thu, 7 Aug 2025 10:12:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH 0/2] vfio: Deprecate fsl-mc, platform, and amba
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, clg@redhat.com
References: <20250806170314.3768750-1-alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250806170314.3768750-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alex,

On 8/6/25 7:03 PM, Alex Williamson wrote:
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

for the whole series:
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
>
> Thanks,
> Alex
>
> Alex Williamson (2):
>   vfio/fsl-mc: Mark for removal
>   vfio/platform: Mark for removal
>
>  MAINTAINERS                           |  4 ++--
>  drivers/vfio/fsl-mc/Kconfig           |  5 ++++-
>  drivers/vfio/fsl-mc/vfio_fsl_mc.c     |  2 ++
>  drivers/vfio/platform/Kconfig         | 10 ++++++++--
>  drivers/vfio/platform/reset/Kconfig   |  6 +++---
>  drivers/vfio/platform/vfio_amba.c     |  2 ++
>  drivers/vfio/platform/vfio_platform.c |  2 ++
>  7 files changed, 23 insertions(+), 8 deletions(-)
>


