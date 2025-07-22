Return-Path: <linux-kernel+bounces-741262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEEBB0E21C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0BB1C83776
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D3C27B4E1;
	Tue, 22 Jul 2025 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="i4l1Qk3m"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB5525A34F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753202834; cv=none; b=RK4IY9LeEqOHriCS4+Oxl0Y9ycvd12TVPdXb5vqzju8Qq3J7d8q8bmWYFAK+vWPUqjU1ZuI33hafn9hB2Rm2NaPDCKTtVj7/5IFrfrxDMGyHi/94EM5enP1fOYJCvLyGj13LnJvfXzocYjwBvHBtlt+kGA/yYvzvHqTSyQawEgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753202834; c=relaxed/simple;
	bh=Ia94kDUHJcFg9SJaS19n/II3WZ4k+ReHg4b57kC36Us=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=V15+Qd8wxh2SHvKvNvM+/0uV2gzo+HMHB9l0PthSWUaF5M1N1KCTiGY3I9a9Km8HaFRK6E3sQKx0oCLSDykirQb85Ccyi35ByLOGFDQQnTijSvMwK9yjr7EgCoXYyh/lFQYy1Tg8Ted5tzrhvhWw5M5imDgexBLQ7wlN4gM3rVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=i4l1Qk3m; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56MGkh7S654694
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 22 Jul 2025 09:46:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56MGkh7S654694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1753202803;
	bh=yShWTRzGXRjd09CNumkI3wqDGiiokHPybwysGnPQOuY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=i4l1Qk3m+uBPf8fp3WigGlqjKaJmprEtWl9lXxDnoKdLfsj1jLse3rxB4a66e5TuH
	 CTIqudhOV6cFZyDhKNB0fjGoxDEXJDAuqoINz0nSFZJksgzcNbX9s+gBqgDQw16Hxp
	 mH1s7w4/YTXgl1/GA9uCi/8YS0lyH3YPjHIBHJ55fgJmGtRiSoT4TmpR/77ZgFM/Jd
	 RajLuVDVLboihlwZ1hwUZpGQZrAcUaPdt3fpxkUT7lOzInis2LHHNs8LOlAvtVTRTI
	 vKQCIOr8V/lWEC7Ov/U/s8jJpGHQ6YRID0pkYw2aFuoAKuPu3RNMkNQ+/HXZARNVl7
	 bDoeeUILGPTig==
Date: Tue, 22 Jul 2025 09:46:42 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>,
        Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
CC: Gleixner Thomas <tglx@linutronix.de>, Molnar Ingo <mingo@redhat.com>,
        Petkov Borislav <bp@alien8.de>,
        Hansen Dave <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Clear LAM and FRED feature bits
User-Agent: K-9 Mail for Android
In-Reply-To: <32382f60-79fb-4cfa-87b4-581f92c980da@zytor.com>
References: <20250722074439.4069992-1-maciej.wieczor-retman@intel.com> <32382f60-79fb-4cfa-87b4-581f92c980da@zytor.com>
Message-ID: <A4EB1016-8CF7-4609-BBF1-9AEC83B52A4F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 22, 2025 2:08:28 AM PDT, Xin Li <xin@zytor=2Ecom> wrote:
>
>> On Jul 22, 2025, at 12:54=E2=80=AFAM, Maciej Wieczor-Retman <maciej=2Ew=
ieczor-retman@intel=2Ecom> wrote:
>>=20
>> =EF=BB=BFIf LAM (CONFIG_ADDRESS_MASKING) or FRED (CONFIG_X86_FRED) are =
disabled
>> during compile time, they still are enumerated in macros such as
>> cpu_has() or this_cpu_has() that use the x86_capability bitmask=2E The
>> features are also visible in /proc/cpuinfo even though they are not
>> enabled - which is contrary to what the documentation states about the
>> file=2E
>
>I'm curious how this bug is introduced with my patch set that adds the
>AWK script which automatically generates the CPU feature mask header=2E
>
>>=20
>> The documentation for x86/cpuinfo=2Erst also states how to handle featu=
res
>> disabled at compile time:
>>=20
>>    The kernel disabled support for it at compile-time
>>    --------------------------------------------------
>>=20
>>    For example, if Linear Address Masking (LAM) is not enabled when
>>    building (i=2Ee=2E, CONFIG_ADDRESS_MASKING is not selected) the flag
>>    "lam" will not show up=2E Even though the feature will still be
>>    detected via CPUID, the kernel disables it by clearing via
>>    setup_clear_cpu_cap(X86_FEATURE_LAM)=2E
>>=20
>> Clear feature bits if they are present in the DISABLED_MASK=2E
>>=20
>> Signed-off-by: Maciej Wieczor-Retman <maciej=2Ewieczor-retman@intel=2Ec=
om>
>
>And we need a Fixes tag and CC stable=2E
>
>> ---
>> arch/x86/kernel/cpu/common=2Ec | 10 ++++++++++
>> 1 file changed, 10 insertions(+)
>>=20
>> diff --git a/arch/x86/kernel/cpu/common=2Ec b/arch/x86/kernel/cpu/commo=
n=2Ec
>> index 77afca95cced=2E=2E1c5af795cedc 100644
>> --- a/arch/x86/kernel/cpu/common=2Ec
>> +++ b/arch/x86/kernel/cpu/common=2Ec
>> @@ -1782,6 +1782,16 @@ static void __init early_identify_cpu(struct cpu=
info_x86 *c)
>>    if (!pgtable_l5_enabled())
>>        setup_clear_cpu_cap(X86_FEATURE_LA57);
>>=20
>> +    /*
>> +     * If a feature is disabled during compile time clear its feature
>> +     * bit to prevent it from showing up in the x86_capability bitmask=
=2E
>> +     */
>> +    if (!cpu_feature_enabled(X86_FEATURE_LAM))
>> +        setup_clear_cpu_cap(X86_FEATURE_LAM);
>> +
>> +    if (!cpu_feature_enabled(X86_FEATURE_FRED))
>> +        setup_clear_cpu_cap(X86_FEATURE_FRED);
>> +
>
>The following code will work as a generic fix:
>
>	c->x86_capability[i] &=3D ~DISABLED_MASK(i);
>
>And DISABLED_MASK(x) needs to be defined like DISABLED_MASK_BIT_SET(x)=2E
>
>Thanks!
>    Xin

The easiest thing would be to initialize the setup disabled mask with the =
DISABLED bitmask instead of zero=2E This can be done statically; if it isn'=
t already the awk script can produce the disabled bitmask in array form=2E

