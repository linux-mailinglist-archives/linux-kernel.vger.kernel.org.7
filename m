Return-Path: <linux-kernel+bounces-812556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 020D2B539B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6135188A194
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF92635CEBA;
	Thu, 11 Sep 2025 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLKbfIob"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927CE35AADA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609693; cv=none; b=Gei/R52cn28LUvG4elBeO/07uAQsEZWZL5+dOZDNtMMHnc1LcVcpwHNDFrSMql5pvLq0idOFj+WDxeddfADPauAyhh0JsM2bwCHD2086KxqPOLiL50BweG3gEQD7FoI+R/UWKAta1C/higbRdGNn9Y6YQ50FxMmthUNg1lADRw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609693; c=relaxed/simple;
	bh=XTBXEstd6PB9WyzlM8/xiw+x+UCwbaYFeIr5kI+4iIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLfaNsivvvlJpfZODxt0/FqUgv/1UWsGGSdbuTUUsaRnRUUm/59Mixcqti4ik2znerzc/Xv7eFT9wcIPwKWquznkHSOG7itBG86o7U5NsRmb+Xyds0y6Xnv3slWTl1oWsSuhM37B6WIqo2f4FU29B9o9zkybV+jjlUZQqYOGShE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLKbfIob; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-570088480f7so47949e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757609690; x=1758214490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bfboHB9qu5xk51JT6CFCORwu42mssq00krwKtD4BSs0=;
        b=iLKbfIobnkjsOEm/jx0C/KfUlcslwY/4x/qHD1FjtSs53TwiLilvg4HhhUsHbfRxA2
         sb41iT1S/wArJwf6//RUkHLhGRBolvioJ9Yp0+xMGRxU5xhsQpBEIauyCjOGxULBTjRG
         82jN1j5gN8sEoaISb49Wmfcqek+VeTALhgEVncq4tX0rvJXmmsfL7FC8bb/w2npmFB1r
         ACUe2PGsUNRC6LKkr2YFvdh6Ou36WODOGWFSSaWI0qGNYn5aDLsvflTv68H5NoD6yo8l
         uuGwG7026sTyELdmyP77jGeuk6RnAyZcDarz0O466HVyz/uZeqraQpg3rzGh3PBxSPH3
         kx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757609690; x=1758214490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfboHB9qu5xk51JT6CFCORwu42mssq00krwKtD4BSs0=;
        b=Tkj3oCFAMF8rsva/5MVZ1C+XDPXPpxAuH/kpyHGvXIQs9sHngZACAUsZE/gbtgaKJQ
         k4km1OuEMQ97MIdH/jwS5ozMLcjICqUg+NVX1rusXTka9vFDbUR0T9+e2L2uX/ztZgpp
         raLx1sNWkYGQlM9HjxpRzdLfJSVGHd8mfXQip/mHEaZD8cE8trDrUsfkfk13s6WQkrfF
         HQ/fstjQ0pBSkR55aLpfRPtAAiqJNdTEkxYJ4tX0wBewA5EB0JApHbM3jiEN8eVnn5UA
         ZouVqVgP28T7Zn89W5bxkU5TT+w7arUgVIbXzAUgRL+IBXTf3ZedzJPFLf4EdCFS19uJ
         pHGg==
X-Gm-Message-State: AOJu0YxAn4MfzXgcXaoLm3fRU3bedVPfYqTjv/p6/6RbffkJwhcYGJWk
	oVaro2ugwHK57ngR7qzzM6m6iZk6lEf1H68fibFcBX4u3YKjj5z3cREB
X-Gm-Gg: ASbGncveFtKb4ZXO70alQXbBY065oMJwY/1aOnlgNJ7MkMnQU4rm/2PLasZgvELjB4g
	h6u9uDBveFAIUxHq2rPqRbUaWgbG+UhDY/VDv+tOknn8r8WMom2JKfANKrmSxJ1W5M62Yspg13U
	KxXMxweB1mM0ZOUDMigxf9MpZYirbo9t9UNDWMWBF+BUFQ2MEYE6XpY/gFw91SSmON0iP9Gyjm4
	Dismr/AhZmUrMAVVsUekaXfOJiInBNOOpgf0k9uQsS9oJtv/y/IgRsMpzh9moGP3WCVvTfkYwrK
	NIyTmWf0r5E3nS3cxKR9S+qljMOHN6XL7QkXQxDIwhDOQHj2h+ULCTIH5THRjlR+kCAxdWGr8qW
	0LUttoTvwvd21/sYx/3Jc42g3npMmCGMkYK+hrhDnVTe6QAe0sg==
X-Google-Smtp-Source: AGHT+IGXwBdnwsXC7werXS6c6WUS/jEPrEOGwp0IA8NfmoP+ydSr3eKuUztbpRmkqaooT6lTRRravA==
X-Received: by 2002:a05:651c:19a3:b0:336:527a:5b45 with SMTP id 38308e7fff4ca-33b52b71534mr29335971fa.5.1757609689465;
        Thu, 11 Sep 2025 09:54:49 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1a8211d6sm3931581fa.43.2025.09.11.09.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 09:54:48 -0700 (PDT)
Message-ID: <6673f66b-e854-4502-bfb5-4b46b16fa457@gmail.com>
Date: Thu, 11 Sep 2025 18:54:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] kho: replace KHO FDT with kstate metadata
To: Rob Herring <robh@kernel.org>, Andrey Ryabinin <arbn@yandex-team.com>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Mike Rapoport <rppt@kernel.org>, James Gowans <jgowans@amazon.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Baoquan He
 <bhe@redhat.com>, kexec@lists.infradead.org,
 Pratyush Yadav <ptyadav@amazon.de>, Jason Gunthorpe <jgg@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Rientjes <rientjes@google.com>, Pratyush Yadav <pratyush@kernel.org>,
 Changyuan Lyu <changyuanl@google.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Chris Li <chrisl@kernel.org>,
 Ashish.Kalra@amd.com, William Tu <witu@nvidia.com>,
 David Matlack <dmatlack@google.com>, Saravana Kannan <saravanak@google.com>,
 devicetree@vger.kernel.org
References: <20250909201446.13138-1-arbn@yandex-team.com>
 <20250909201446.13138-5-arbn@yandex-team.com>
 <20250910165010.GA223810-robh@kernel.org>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250910165010.GA223810-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/10/25 6:50 PM, Rob Herring wrote:
> On Tue, Sep 09, 2025 at 10:14:39PM +0200, Andrey Ryabinin wrote:
>> Store KSTATE physical address & size instead of FDT in kho_data.
>> and initialize KSTATE from kho_populate().
>> To be able to use FDT in parallel with KSTATE place FDT
>> address&size into 'struct kho_fdt' and save/restore it using KSTATE.
>>
>> This finishes wiring KSTATE with KHO, making it fully functional.
>>
>> Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
>> ---
>>  arch/x86/include/uapi/asm/setup_data.h |  4 +-
>>  arch/x86/kernel/kexec-bzimage64.c      |  6 +--
>>  arch/x86/kernel/setup.c                |  3 +-
>>  drivers/of/fdt.c                       |  6 +--
>>  include/linux/kexec.h                  |  2 +-
>>  include/linux/kstate.h                 |  1 +
>>  kernel/liveupdate/kexec_handover.c     | 60 +++++++++++++++++++++-----
>>  7 files changed, 61 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/x86/include/uapi/asm/setup_data.h b/arch/x86/include/uapi/asm/setup_data.h
>> index 2671c4e1b3a0..844f5b93473f 100644
>> --- a/arch/x86/include/uapi/asm/setup_data.h
>> +++ b/arch/x86/include/uapi/asm/setup_data.h
>> @@ -83,8 +83,8 @@ struct ima_setup_data {
>>   * Locations of kexec handover metadata
>>   */
>>  struct kho_data {
>> -	__u64 fdt_addr;
>> -	__u64 fdt_size;
>> +	__u64 kstate_addr;
>> +	__u64 kstate_size;
>>  	__u64 scratch_addr;
>>  	__u64 scratch_size;
>>  } __attribute__((packed));
> 
> Isn't this part of the ABI which you can't just change.
> 
> Rob

Yes, it is part of the ABI and layout of this struct can't be changed.
But this change only affects semantics of fields, layout stays the same,
so this should be ok.

If we kexec from an old kernel and kho_data contains FDT address,
the initialization of KSTATE will just fail and boot should continue as
if there was no kho_data at all. At current stage of KHO development,
without real users, change like this should be fine.


