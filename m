Return-Path: <linux-kernel+bounces-741295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F4AB0E283
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3550174D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDAB27E04F;
	Tue, 22 Jul 2025 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PpTMaOy1"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCD027A90A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753204947; cv=none; b=cu828cUP3fvdsKJKWTAZMy4dEaZgkZWLVwtipbqO1R4N5dd6hoEuXGIk6uyEAu/ly2yvGJcmkhEOIojZ1Sd3LmiXoxMF/6TOVsK5Sm8Tp0nhYMl2xAEfTyEPlBeCSY55dHGz/7p20m9HuYvYVaEPRw3Nz/c0vmlVzhyoeAzCl30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753204947; c=relaxed/simple;
	bh=5UEi2NC+5Xrit0iKinNdi3nmduJtK6vG27yCY7e8BhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRhNkUO+yTxh5vztMOeqDFma30vfm/YqqvPlh36k5WuIm8GBprBWJ36f5BKynuPXGKdqh961lu6mA/Og+Z2CxvmOiEBRJE8ooAK2AMNP8nR/5GQc38jDZ5IRHVZcShCpuZhAloqJtVu9kBKd1JHwJZLUar+nU6mHgQ6prilwwt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=PpTMaOy1; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56MHM1bn666510
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 22 Jul 2025 10:22:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56MHM1bn666510
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1753204922;
	bh=aqASFZb/hAVrA9isA+NHDa8/g4iNldjIhQygK7/qfY0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PpTMaOy1E1ZVpdZ8vJy7oAlGJrV2keXIkifpxVd9rtb1OwaIWyiJi/Fo+OY3v+UCn
	 JTno5ANvfEWhi1KVkct4I3T6b1odOX9yefV4Dh3mETwmPcI9fxuNXSzY92n+69zSxT
	 QQDgKA0tyfKIFhHlnYatH5hcseBN/zpTWBAihoa0pK41/1hs7eim/OGLDrGuYCdCsX
	 xE79OL25+4W2XPZwmHiDpsvetJdsDt4RgDEuapX7tWfRk7rxHw4BlhAlTAJD+FPrpX
	 D36huasW4+yGP8o+gi5a9C+XLcHkfvBKrwJVZeRUM7Pj800yKbazyPDcTUwi8kH8m6
	 5EGg2LK7cr8Fw==
Message-ID: <5654b3bc-15d4-443b-a7b1-2f9fd1d3e0aa@zytor.com>
Date: Tue, 22 Jul 2025 10:22:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: Clear LAM and FRED feature bits
To: "H. Peter Anvin" <hpa@zytor.com>,
        Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
Cc: Gleixner Thomas <tglx@linutronix.de>, Molnar Ingo <mingo@redhat.com>,
        Petkov Borislav <bp@alien8.de>,
        Hansen Dave <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20250722074439.4069992-1-maciej.wieczor-retman@intel.com>
 <32382f60-79fb-4cfa-87b4-581f92c980da@zytor.com>
 <A4EB1016-8CF7-4609-BBF1-9AEC83B52A4F@zytor.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <A4EB1016-8CF7-4609-BBF1-9AEC83B52A4F@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/2025 9:46 AM, H. Peter Anvin wrote:
>> The following code will work as a generic fix:
>>
>> 	c->x86_capability[i] &= ~DISABLED_MASK(i);
>>
>> And DISABLED_MASK(x) needs to be defined like DISABLED_MASK_BIT_SET(x).
>>
>> Thanks!
>>     Xin
> The easiest thing would be to initialize the setup disabled mask with the DISABLED bitmask instead of zero. This can be done statically; if it isn't already the awk script can produce the disabled bitmask in array form.

Yes, something like:

	void __init init_cpu_cap(void)
	{
		for (i = 0; i < NCAPINTS; i++) {
			cpu_caps_set[i] = REQUIRED_MASK(i);
			cpu_caps_cleared[i] = DISABLED_MASK(i);
		}
	}

And it would be better if it could be done at build time (to avoid
changing Xen which has a dedicated startup code path):

	__u32 cpu_caps_{set,cleared}[NCAPINTS + NBUGINTS] = {
		{REQUIRED,DISABLED}_MASK(i),
	};

And then apply_forced_caps() will do the rest automatically :)

