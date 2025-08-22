Return-Path: <linux-kernel+bounces-782090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF22BB31AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B81D17F48C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C91305056;
	Fri, 22 Aug 2025 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLOQTGFn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283B02FDC3D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871618; cv=none; b=Og34Ffbuz0oSeOVzJOPQ37U2iVsHK6IsBhuZrdvAeJO+bA9tIpctoSa0LVHVoc+oXiZa1vBd8d48cciEn2NFdYFcnEdl5stOUHqFc8/3K0gMr4K6a36ZZFWU95u9gTcwin3us2v0JjOm3EoF02WQhyXCU9+uLXyGSyGTKL9IEVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871618; c=relaxed/simple;
	bh=4O1F1QLd0WBvFlW7a4rwY4rRJeJKtdwh8SPStmWdguo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9+N75AZZ/bqdU457QZAdwa8uxQ2m28tUhdnWrGnRX9yrIgnUpdwxdLK1sp/0zBJXa2XmoKEVIEcEQJBhLipef3q3WNBB7uznX/0/W9Ld5sb+4K4Clj4vCSpqzF8Oi6vWTG/5D7GQQTGHk+Q9R9odGLT5qqqAzGc7IpzxEhBsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FLOQTGFn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755871614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1OtBujDYhc4wh7yBHvledr0/XQqI3JjEgXQrd72WsM=;
	b=FLOQTGFnCtHIfGTKaN6/aN1rRCngm0j6SBHxnwxmSLnOoACJXdieeF1cf/6d58vMgpzoNX
	bPaQs/MEh78/oDP4HIMkozE7ZNhM4/f+a/GvyI36pHxC/GndJMyq6Hi2n8XToYzJcgpcm0
	NVPtg1bt1JIWzrxyVaRKXATtegT3Wp4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-jJ6nLL4XM4KSVa50QrVpbw-1; Fri, 22 Aug 2025 10:06:50 -0400
X-MC-Unique: jJ6nLL4XM4KSVa50QrVpbw-1
X-Mimecast-MFC-AGG-ID: jJ6nLL4XM4KSVa50QrVpbw_1755871610
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-afcb7338319so237811166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755871609; x=1756476409;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p1OtBujDYhc4wh7yBHvledr0/XQqI3JjEgXQrd72WsM=;
        b=c0AkbfAJxu8hW6Oisbc/yXRwmSSYlZjswdVs0YcncTikAUEs98yNAvE8Mr9OGaPcMg
         o7dfDuFQw7YB08fGcwcV+vmGUL7hq+ys+uJgwPp7+ehMJkZw9xz3uJNoROk5QkFcyIPb
         y8YKgtd0FQOYcfpP19MA5WJXwEWoBt76Rba5/V95EoLAYhf9ia3darJdpzukh8KwiMvK
         9niZw9ky8NmU+MvOhMlslmFtJz6I6Bb+NHHTxObywBRHDJVXXoR4KUnLLffxfB9nRsb+
         m+7Km0GRvhORyWyF5MF3Z+lMvNsFfDwMdqQOry8sR5uCQzM8AfeGC7m+pm5NEyqfwSvp
         7EcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZPBQcTRL1+JELDa75Zw3S79fqbppenwlj7+FWscYtoXmwBsOP8L1FXhyMPJG23hp2c1kXApcUGDiBR0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4UtDUYPiAIaYdWezYtlygvCllhxM52J3AW6I1oNbbOegDP8b5
	9Dq8KxEPypC8W0/GbJFgkNeQjkbBSPZVkAXCR8kHFotuUCbufV+dF46y/f3MeUaCacGeL+cDpI3
	tg5Qb6Ydls1nvJEAddUyMF2hXn1q/4p7PVj1VHX4X/7JTbsvnxCPTVTBOqJugTjWjWg==
X-Gm-Gg: ASbGncvFGmZIfkwEIiDvqRVhlnv2dgw9QUBU2DYxA+5POLAq3jC52pWy9SMDId0Q46F
	ebC+0iyj3XFXw9nGhmJGvCaqz47nW5x6hJvYNKFOiMbFjPVwuuo3lJDTcLQuen9dK9Dwzefv4eT
	De6ZFNWFvTOeTNDeHyic1AQQemkWapvAqBqHe60r1h4R5NNYRjYCfAix4YoZhhh9SEOtvsDWLg8
	U5KnzAAfHdVmILEv61PtIVx6cczZXnw0MJr3fPlpshcPAM/CrxYn+sY1TDzBp8Y7hItivbVj0IP
	p9EBJoaeFpQ4PY4BBy7iBwXxKmd2AegaTJ1dmKu95MbvNdR1sguGmiqzTPoG1MWULKjWdDtKbFm
	VXa0ZbS7v2XKidqEh2vmL6dUQtwHTqn21dpvVDY+mkEBicrBba+u6U+sYK03zAs9t+lOgO7GUaV
	NubB8hyeORem5jn88=
X-Received: by 2002:a17:907:da15:b0:afd:d94b:830d with SMTP id a640c23a62f3a-afe29511c01mr308752466b.62.1755871609550;
        Fri, 22 Aug 2025 07:06:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHboT2GlNrHsmLimww91Bi0N9+TLQk4nVZ6Qvih+Ksmmum3mgf3/wMdYhvXw4qqO59SH8tsxA==
X-Received: by 2002:a17:907:da15:b0:afd:d94b:830d with SMTP id a640c23a62f3a-afe29511c01mr308748666b.62.1755871609090;
        Fri, 22 Aug 2025 07:06:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe1367efbdsm308332566b.25.2025.08.22.07.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 07:06:48 -0700 (PDT)
Message-ID: <f383b86e-297e-4044-a0c0-8981b8a541fb@redhat.com>
Date: Fri, 22 Aug 2025 16:06:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] staging: rtl8723bs: get rid of os_dep/recv_linux.c
To: Michael Straube <straube.linux@gmail.com>, gregkh@linuxfoundation.org
Cc: Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250822135418.118115-1-straube.linux@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <20250822135418.118115-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 22-Aug-25 3:54 PM, Michael Straube wrote:
> This series moves/merges the functions/functionality of os_dep/recv_linux.c
> into the corresponding parts of the driver in the core directory to reduce
> "os dependent" code.
> 
> The patches have been compile-tested only due to lack of hardware.
> 
> Michael Straube (13):
>   staging: rtl8723bs: remove wrapper rtw_init_recv_timer
>   staging: rtl8723bs: move rtw_recv_indicatepkt to rtw_recv.c
>   staging: rtl8723bs: move rtw_handle_tkip_mic_err to rtw_recv.c
>   staging: rtl8723bs: merge rtw_os_free_recvframe into rtw_recv.c
>   staging: rtl8723bs: merge rtw_os_recv_resource_alloc into rtw_recv.c
>   staging: rtl8723bs: merge rtw_os_recv_resource_free into rtw_recv.c
>   staging: rtl8723bs: merge rtw_os_recvbuf_resource_free into
>     rtl8723bs_recv.c
>   staging: rtl8723bs: move rtw_os_alloc_msdu_pkt to rtw_recv.c
>   staging: rtl8723bs: rename rtw_os_alloc_msdu_pkt
>   staging: rtl8723bs: move rtw_os_recv_indicate_pkt to rtw_recv.c
>   staging: rtl8723bs: rename rtw_os_recv_indicate_pkt
>   staging: rtl8723bs: remove os_dep/recv_linux.c
>   staging: rtl8723bs: remove include/recv_osdep.h

Thanks, series looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

for the series.

Regards,

Hans


