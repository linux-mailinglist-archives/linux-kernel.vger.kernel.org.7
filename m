Return-Path: <linux-kernel+bounces-854793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A673BDF675
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA4844E4A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116AD2FE569;
	Wed, 15 Oct 2025 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Ot+7cVD8"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0302163B2
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542466; cv=none; b=Z5bK6z+oF/0abrjN69PuREqmF2A5mU0/6HExctuj2Z1JZGteYP1pFEU1Bac/hfZglS5w1nC7c84C4E4Wp7FRK0hwb3S3jzdM44HJOxavV+0UCHi5FayOsQJgBGndEqik6RtkyKCHEn1vcYBqPQr6iqCr9L1B45hcNdVzgrlvhyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542466; c=relaxed/simple;
	bh=xaECLsYbzdKV3z+3+2V8JgNiU5THcYSCLOZkZdxCs74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6y280li5iqLga/8wee9TmNB6vQsSy9fcwdZAMc2nIVhL79pQlHkKpnw90nx+AtUIEnXXFTcNlfHpc079wPK0pTjvAgsiFYXvHuyPtzf4pdNCT/D20wd/B4tzbMTdwVhQpcfn03iqb2P3kE3Y6DA6KzN8SO5AyENbyv1Mz6DD+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Ot+7cVD8; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.72.64] ([218.1.208.81])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59FFY1YC2522533
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 15 Oct 2025 08:34:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59FFY1YC2522533
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1760542444;
	bh=udhGZrsRS6IcUlNd+DtgFqiIe7CGoJhRBC2C59sFlG4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ot+7cVD8D/B9Aeun/ADsDLNpBkZwQbVXwVCqC1xDncsH2dw+DM3CFsMFrKsR8m7Zt
	 flO5y1qiZJhdkFWXX3mU6Y8Ab4QapkJOIdjy/Xfm90Nw86TRvheJu5tzXpS7uWhAiS
	 lRxP7/ye2sSuPby5DdGDiayzPOrSEbtdXprBX4lRsiA1Y5pn7mHTzsv3IturWT5Sgg
	 ZjBBlg/MT7CFT5jIscLTMb/1ZHS/6uJsDFTEdyfx7GAKis5PNzsJKTWKMzM11kN7JD
	 qPXy/Kd4r9WJoRmpY1rNg/DiC/WswaMm34texnYfGJ9U48waAv0Xz/cRAY1wtMOc2j
	 MhgRmRn9v4lVw==
Message-ID: <b632fc82-bef4-456b-ba62-939bda5a4361@zytor.com>
Date: Wed, 15 Oct 2025 23:34:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpufeatures: Correct LKGS feature flag description
To: "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@kernel.org>,
        Xin Li <xin3.li@intel.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
References: <20251015103548.10194-1-bp@kernel.org>
 <2dd4dbee-dc7d-4118-be6d-94bd6d0d5030@zytor.com>
 <329BCA65-5152-4892-AFEA-DF72DCCE80B6@zytor.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <329BCA65-5152-4892-AFEA-DF72DCCE80B6@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/2025 11:18 PM, H. Peter Anvin wrote:
> On October 15, 2025 8:08:17 AM PDT, Xin Li <xin@zytor.com> wrote:
>> On 10/15/2025 6:35 PM, Borislav Petkov wrote:
>>> From: "Borislav Petkov (AMD)" <bp@alien8.de>
>>>
>>> Quotation marks in cpufeatures.h comments are special and when the
>>> comment begins with a quoted string, that string lands in /proc/cpuinfo,
>>> turning it into a user-visible one.
>>>
>>> The LKGS comment doesn't begin with a quoted string but just in case
>>> drop the quoted "kernel" in there to avoid confusion. And while at it,
>>> simply change the description into what the LKGS instruction does for
>>> more clarity.
>>>
>>> No functional changes.
>>>
>>> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>>> ---
>>>    arch/x86/include/asm/cpufeatures.h       | 2 +-
>>>    tools/arch/x86/include/asm/cpufeatures.h | 2 +-
>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>>> index 80b68f4726e7..4fb5e12dbdbf 100644
>>> --- a/arch/x86/include/asm/cpufeatures.h
>>> +++ b/arch/x86/include/asm/cpufeatures.h
>>> @@ -320,7 +320,7 @@
>>>    #define X86_FEATURE_FSRS		(12*32+11) /* Fast short REP STOSB */
>>>    #define X86_FEATURE_FSRC		(12*32+12) /* Fast short REP {CMPSB,SCASB} */
>>>    #define X86_FEATURE_FRED		(12*32+17) /* "fred" Flexible Return and Event Delivery */
>>> -#define X86_FEATURE_LKGS		(12*32+18) /* Load "kernel" (userspace) GS */
>>> +#define X86_FEATURE_LKGS		(12*32+18) /* MSR_KERNEL_GS_BASE = GS.base */
>>
>> Yes, the assignment is more clearer to us programmers.
>>
>> I'm just not sure if "correct" in the shortlog is accurate; it sounds the
>> existing one is wrong.  Otherwise,
>>
>> Reviewed-by: Xin Li (Intel) <xin@zytor.com>
>>
> 
> That "assignment" is rather wrong, though; it implies that the two are identical, which they are not; nor does it imply the relationship is fixed (that is provided by FRED, not LKGS). Perhaps just call it "Load user space GS".

I see your point, is the following assignment better?

     MSR_KERNEL_GS_BASE = gs_sel->base


