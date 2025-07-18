Return-Path: <linux-kernel+bounces-736714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E35EBB0A0DE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B17F5A65DA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531B82BCF47;
	Fri, 18 Jul 2025 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Vzdy5jYC"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E566313C695
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752835432; cv=none; b=fGcN2FPfEYClzCSLITAO8Kb7ntYVHCNUUmzAFOLpkt53/tojw7/dC16jIFV4RMeQsnBGaP3WB9DXdHDZUpxYVUXXVIJS2koKMCNz4nUHQ9zn2Dna2CUlSBVdJqvvFdGO8+D8vv/8qTDBrLt94MV2Njn48LnGskawM9O8h0vPS8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752835432; c=relaxed/simple;
	bh=48ZlNe4Xa5JgXaUkkACsp+Yzyve3KK7S+ogavvf74Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4IAAfHSn9sBc9PKYJ3rG5ggxFupf9Z4b5UhgMZQKY4A533B6RRF/h/vFKK7+G53/DYlpewG7Yh9Qq+KSRtebS5ZXCYFyuU/ErKTU57L3rv2na5VyJWqBwT4SEqouVlOa2Zzlnl93tLv0sqIAMmDAri5coVwQj6EdVx1ELlHZkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=Vzdy5jYC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45610582d07so15196925e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1752835429; x=1753440229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=48ZlNe4Xa5JgXaUkkACsp+Yzyve3KK7S+ogavvf74Lg=;
        b=Vzdy5jYCDUjzIA/Zc5SspgdWTz6KrX/O+PrBEpEaQ7iEnTkHIQggSXC921ekQA36Oy
         rEu7ejNbIfM7AS+mRqPaSGkx0w687uXGOb4RtWXMBedVt0Kytb6ah7LH2pnSaxY16+qj
         /gjrR+85SFwOvQ7u24FG5XEpQvB01cARRR6+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752835429; x=1753440229;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48ZlNe4Xa5JgXaUkkACsp+Yzyve3KK7S+ogavvf74Lg=;
        b=VyF4/AzRFyVl1pmq3Memh4ch6fM9Zu9QoI6ht8DUmpeMPO0EtD+vhsRFzkF8YM7ZYP
         MwCGEcrTR9gYEzvOX7iKjcZyrHPO51nNn4dOd3kToXaYy41FXOaV/Khou7xKmDfXW+sT
         oVFt9k47ihjBNg3P+MXAg2oAqlKRGnqCkN5WCdBtEFPm2WXuMJ3oDge0VTSjPfFRpUAU
         gMjYZk/PSQ/0P2+spMimPQ5PVEY1RWjGoNKpVRhK2Xdwm/8X5NnHbHBzSY2Ow19022Hk
         Nrxa5IAo244LInRwlbnACLvtKMGrUm3zFp4+U6lgm3ndQ39AQ165IMMaha3wzhoO2idm
         szXw==
X-Forwarded-Encrypted: i=1; AJvYcCXgkcTngJMc6LH9o/QzXqXPsw7aVaL8JuMJUPj0DcOCpnd2mOF6pEbmrFrJMB/iDcx0LsbQp9zuqaeWkfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycvNV/ClLNqBHBLWrkJctDOctDAflr90R/F2AbLZQmY/xaiJ+9
	5jl26nnxKaqAgwNf4GcP/hVxB8Vmpf1KbZxCP74cCZmMqKKMKEqgPuKkgihf8B+LwRc=
X-Gm-Gg: ASbGncsvZ/V1aM5n0uUjoEDpu6LHUsFlsVhw9dzhmTTqK8RxIeOhcfS1rqDSrz43k+J
	uWxAv30IvJ1nSXh74ubDkmbvxBES+/j9kQfJ5FwPRTZ8DDT1ZmMitCNh6H7Gq5OcEnLTD+Df0LO
	2Ztlxb0qCm9pmsQTepXWnyyaKeRqM3X95vtz9vP62PcxeardEIrJJrxzjpcSM+NGUVcxU2soAZ6
	YdQQ0B1EaAwF7PcpvwFqEUbjn0fgw511+YxL81wABm9Cq+/OCHge0KfK3NDVndFp1UDIakjCRJr
	5+8kbfVR/5j2u+U8hOX97E0k/0dM1hXnStzw37fnLmq3W8nEjF+O6WdSXh0dbH26XGlFtewz1+s
	yYcSj3wQrF/AiPectlXIJQfRwiOOEav+UEnF5xk5uBGTXEMDnWdj8jvLpH37YmpsVCGdP
X-Google-Smtp-Source: AGHT+IE2LaEpkXTf9HVR7hepOBi7Bbf9OVRrYRXo7Rjn9IaKV65KTHgEwUXgg84M+d9yQW69Qa5epQ==
X-Received: by 2002:a05:600c:4689:b0:453:6424:48a2 with SMTP id 5b1f17b1804b1-456352e7a28mr71806215e9.10.1752835429106;
        Fri, 18 Jul 2025 03:43:49 -0700 (PDT)
Received: from [192.168.1.183] (host-195-149-20-212.as13285.net. [195.149.20.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b76148asm16486245e9.35.2025.07.18.03.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 03:43:48 -0700 (PDT)
Message-ID: <a6d7becc-9971-4e35-982a-3e35af4c4666@citrix.com>
Date: Fri, 18 Jul 2025 11:43:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: x86/apic: Drop useless CXL/CPX row from the TSC deadline errata
 table
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Yuntao Wang <yuntao.wang@linux.dev>,
 Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>
References: <20250716160824.2167709-1-andrew.cooper3@citrix.com>
 <7fcede81-902c-4eaf-82be-cfaf3154bce9@intel.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <7fcede81-902c-4eaf-82be-cfaf3154bce9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/07/2025 9:25 pm, Sohil Mehta wrote:
> On 7/16/2025 9:08 AM, Andrew Cooper wrote:
>> A microcode revision of 0 is guaranteed to exit apic_validate_deadline_timer()
>> early, but a better way is with no row at all.
>>
> Yeah, not having an entry is much better. "exit" can be a bit ambiguous.
> Should we be slightly more precise?

It's "exit $foo early", although this is slightly hidden by the linebreak.

Alternatively, it could be phrased as "exit early from $foo" if you
think that's clearer?

>
> A microcode revision of 0 is guaranteed to return true for
> apic_validate_deadline_timer(), but a better way is with no row at all.
>
>> No functional change.
>>
>> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
>> ---
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

Thanks.

~Andrew

