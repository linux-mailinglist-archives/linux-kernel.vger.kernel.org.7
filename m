Return-Path: <linux-kernel+bounces-801399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D60B44499
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A55482D15
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044633115AF;
	Thu,  4 Sep 2025 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhwL4Svj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFB423278D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007725; cv=none; b=gSk4KZ9p1s8rQ0qggZ5Gz/IySHN/kBy1Fgu/R7uZWDgZUtgNaVnRs5D9q65a2rzhqMVhevObIzS67A1rRxxYGdtE5mtJT4wnoXdJrUJiaKT2jsdsmGnnI/ftRjpYneiu9deBlKE7HRX27F2MVWcWR7kLaTSfkVRt2LCTjsuPaV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007725; c=relaxed/simple;
	bh=yx0zBWaRu6cw3icG0CeXgREh0ynyNB3A8lzrt88/Qnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ii+bSzXTZp0vhb/AkMjR+Ty8VDtZaV1eZK/mB8i9EcmAo6i821cAMw0uJm67JKEmDOrW9qaY7vzxZYDlalHIKrM+8xCTSAShcGKWU9JP9NfV1HY5PnFQ2o8cf9CePgsVYTZ8DDT9Bljnr9fM9Bu+xMu5o6xvYetem1eNZdlKgSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XhwL4Svj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757007722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7OW0fmMmok+4qM9nyuF69XKa0Kr2dqRhaneU5e3QgPQ=;
	b=XhwL4Svj2tcIQgwG5ZMfJYEoTHc9iQZhgosWaBcqcLOtYb4B4NiIF2+qcqIMESco+1y+nc
	g5qL3VeuWsy0/OKeB6IN/0e1m7wMRE3li/EtowyJmL1FO6q4ENGbmEdf3tq1RvwXVgyVA7
	LyG/nhfvcc3tsr/HQoKjPPWbXWySidE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-P5eKQT1mPIiCGBNLo0uU3w-1; Thu, 04 Sep 2025 13:42:01 -0400
X-MC-Unique: P5eKQT1mPIiCGBNLo0uU3w-1
X-Mimecast-MFC-AGG-ID: P5eKQT1mPIiCGBNLo0uU3w_1757007721
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7fc5584a2e5so331187485a.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 10:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757007721; x=1757612521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OW0fmMmok+4qM9nyuF69XKa0Kr2dqRhaneU5e3QgPQ=;
        b=udogjlcG4naZrCp+JR0LFOqz9qzVrPlMygGFDgnBS9Wlx50pLNus/coIXLk+28Wgrs
         hdCVljmNk11fureY/+7LnwF14ygRLWWNyosgzSUxfX53b6Istv2HGJvnKnB38t2NrAOv
         Miwg9/GrwPgEMntE/h1VFxjrLwBLvHbqWfa0zVOtmqZbgk/IUPXJnuxUr6bSIESC25ng
         qjibLChTsCH8SO6QllyzlaByLJGXVU/EeBU8acTahGAhwU3vA+gEmBPwaE5fIiFDoBPn
         81hUVVTy69c5dUhLATW+0zJpHrxlyAKCg5X11/iIrtKMOS+zwiEBfPRVenQQxWT/pH8O
         ou+A==
X-Gm-Message-State: AOJu0YxKcADGtT1787VvzB6iZyECo22mQOfQQV/0Zr6FEWPgP1f+fwo8
	cLi6Q5lp7k91tVl8wSZoCSmZRpWSHk8AzHB3OOb32yStMli6M4XcM4l8lZeimDOh9KOuEZB4O8h
	20RIN3sF7/U+QUWPXrnzHlB2IhBJtVpjcO2dClXGp9nAi/yrFkQIrHglmxi1Ik9jii4DbBl8aHI
	yUJZhgu9zXfkbIf0xWdUjUVIyNluidXuVWYwR+ht4BCvDh34sv
X-Gm-Gg: ASbGncuWuk8whTdi8qI/i9lixZfyBAyuN1INCPIK6j8gLIY0mEWRwPJnu7DIJYAY11t
	b1t61+z6bw0jaTXC7LGEBp+UKOVOFjFNRc2h6DH3OxIi8Ai7avTFFT58KFiEO/oGJ0ZxjuJyUo+
	80qVH6YcMO6jgpxW/SBzcMj0mo7eaTqzFshQTqvxqmEJ0g3YYNjZsx2Dhr8P6hl/2PMqJVYjSF7
	SbLoXYMH7x38sQLC1JnHSy3QoTn0jmc4cWcxJYbcsd8K4/4781X8dObcFMamBMP+wjoqo3pLNVA
	YKqYGfK4JugyegdwBm6IwBw6jB2e45f4mrXzcH0=
X-Received: by 2002:a05:620a:a510:b0:7ff:5a10:b461 with SMTP id af79cd13be357-7ff5a20085fmr1891880985a.81.1757007720501;
        Thu, 04 Sep 2025 10:42:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKqJNBGWDVyE/ZYDYaZTm43V9zlufAPTiO2T2c77SZHFQK96cZUJ93g+qmbFuyaCQAipvPRg==
X-Received: by 2002:a05:620a:a510:b0:7ff:5a10:b461 with SMTP id af79cd13be357-7ff5a20085fmr1891875985a.81.1757007719781;
        Thu, 04 Sep 2025 10:41:59 -0700 (PDT)
Received: from [10.26.1.94] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aa62c789esm315635085a.11.2025.09.04.10.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 10:41:59 -0700 (PDT)
Message-ID: <342d698c-c352-4b2f-9e28-52e385cf6579@redhat.com>
Date: Thu, 4 Sep 2025 13:41:58 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_th: core: fix null pointer dereference in
 intel_th_irq
To: linux-kernel@vger.kernel.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jerry Hoemann <jerry.hoemann@hpe.com>
References: <20250825174554.925679-1-darcari@redhat.com>
Content-Language: en-US
From: David Arcari <darcari@redhat.com>
In-Reply-To: <20250825174554.925679-1-darcari@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

On 8/25/25 1:45 PM, David Arcari wrote:
> In certain cases intel_th_irq can reference a null entry in
> the th->thdev array.  This results in the splat shown below.
> The problem is that intel_th_output_enable() can modify the
> thdev[] array at the same time intel_th_irq is referencing
> the same array.  This can be fixed by disabling interrupts
> during the call to intel_th_output_enable().
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000304
> Oops: Oops: 0000 [#1] SMP NOPTI
> RIP: 0010:intel_th_irq+0x26/0x70 [intel_th]
> Call Trace:
>   <IRQ>
>   ? show_trace_log_lvl+0x1b0/0x2f0
>   ? show_trace_log_lvl+0x1b0/0x2f0
>   ? __handle_irq_event_percpu+0x4a/0x180
>   ? __die_body.cold+0x8/0x12
>   ? page_fault_oops+0x148/0x160
>   ? exc_page_fault+0x73/0x160
>   ? asm_exc_page_fault+0x26/0x30
>   ? intel_th_irq+0x26/0x70 [intel_th]
>   __handle_irq_event_percpu+0x4a/0x180
>   handle_irq_event+0x38/0x80
> handle_fasteoi_irq+0x78/0x200
> __common_interrupt+0x3e/0x90
> common_interrupt+0x80/0xa0
> </IRQ>
> 
> Fixes: a753bfcfdb1f ("intel_th: Make the switch allocate its subdevices")
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Jerry Hoemann <jerry.hoemann@hpe.com>
> Signed-off-by: David Arcari <darcari@redhat.com>
> ---
>   drivers/hwtracing/intel_th/core.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
> index 47d9e6c3bac0..c6f6153fcc88 100644
> --- a/drivers/hwtracing/intel_th/core.c
> +++ b/drivers/hwtracing/intel_th/core.c
> @@ -715,7 +715,9 @@ intel_th_subdevice_alloc(struct intel_th *th,
>   int intel_th_output_enable(struct intel_th *th, unsigned int otype)
>   {
>   	struct intel_th_device *thdev;
> -	int src = 0, dst = 0;
> +	int src = 0, dst = 0, ret = 0;
> +
> +	disable_irq(th->irq);
>   
>   	for (src = 0, dst = 0; dst <= th->num_thdevs; src++, dst++) {
>   		for (; src < ARRAY_SIZE(intel_th_subdevices); src++) {
> @@ -730,7 +732,7 @@ int intel_th_output_enable(struct intel_th *th, unsigned int otype)
>   
>   		/* no unallocated matching subdevices */
>   		if (src == ARRAY_SIZE(intel_th_subdevices))
> -			return -ENODEV;
> +			goto nodev;
>   
>   		for (; dst < th->num_thdevs; dst++) {
>   			if (th->thdev[dst]->type != INTEL_TH_OUTPUT)
> @@ -750,16 +752,19 @@ int intel_th_output_enable(struct intel_th *th, unsigned int otype)
>   			goto found;
>   	}
>   
> +nodev:
> +	enable_irq(th->irq);
>   	return -ENODEV;
>   
>   found:
>   	thdev = intel_th_subdevice_alloc(th, &intel_th_subdevices[src]);
>   	if (IS_ERR(thdev))
> -		return PTR_ERR(thdev);
> -
> -	th->thdev[th->num_thdevs++] = thdev;
> +		ret = PTR_ERR(thdev);
> +	else
> +		th->thdev[th->num_thdevs++] = thdev;
>   
> -	return 0;
> +	enable_irq(th->irq);
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(intel_th_output_enable);
>   

I suspect there may be a better approach to this problem, but I did
want to add that after extensive testing this did resolve the issue.

-DA


