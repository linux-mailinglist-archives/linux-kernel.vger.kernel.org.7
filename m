Return-Path: <linux-kernel+bounces-741266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBB8B0E230
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493811891607
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A63127E060;
	Tue, 22 Jul 2025 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UyoCtJY3"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2991E2576
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753203086; cv=none; b=ncYccVpHkDL5xCvZU8tntMnggPEmIHpZNojlV7E9yFJotBEXPUnaiEGYGQjRPh1f6PPaQnTJqaCRo5XIlHYTjWtssB9gpV98uNjbqxREvDG65Eij8ZLnrX0matgd95MD8/4qT7YV3UkybAJjUs6ZYeRy9S8ycXrl4qB5J1/YK5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753203086; c=relaxed/simple;
	bh=V5elDQiEfIqmvWUG5f4P/1dNbtk/UrKMvmZWcCKNjh4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=rVvofI1kZCNW4zM81K8dB9PqV1r7PRAHh07Wvdk5aqQUYMtvkwPGIIBP6Ue+i/c1XkpEYdiMsE6jhWb6M7ABfVA/Tt8BZn/CDeX+Bu87eDTVv475ZrDDjj675bm1mKaUoigNT26LuCT10E/4jMfGPV6buKe3RfpaN2jo4kdVCZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=UyoCtJY3; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56MGos1t655719
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 22 Jul 2025 09:50:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56MGos1t655719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1753203055;
	bh=ejWaz/V2Tr7b9Msh8siMnGrL7WaKr5JQiVrGTiLKlGY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=UyoCtJY3Xnm77cf5FPHjP942rKxlMYas5PZZ6hbdVwHFaccNGTqRaDvc78AoXcjbD
	 O0+0y96gL4KFNOG4/gHPqMWTFafaJD19RgPk7lRbj50XQ4zhkOnZKtJnaYrv38krMU
	 JJdWZC1wFEJFrVPdSjftAXXpsgslOpaVeAIDdnctgl8XC3NXsBbS0zKkBtqIatGb04
	 dm5t1au0ABU2B7M3i1pXAazMzYl7DQs/X9nLvFMakxKANv4WwZvx3aliXBV2+eA89t
	 oMZiUqUpFmXc8NOx+9T6ovKwZU+Fh2QU2UdHMSSl9V/3KGAuIwcSq7P8vF5TDZhgxu
	 k1AeqYVW7tLqw==
Date: Tue, 22 Jul 2025 09:50:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Oleg Nesterov <oleg@redhat.com>,
        David Laight <david.laight.linux@gmail.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Li,Rongqing" <lirongqing@baidu.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] x86/math64: handle #DE in mul_u64_u64_div_u64()
User-Agent: K-9 Mail for Android
In-Reply-To: <20250722105034.GA2845@redhat.com>
References: <20250721130422.GA31640@redhat.com> <20250721192053.58843751@pumpkin> <20250722105034.GA2845@redhat.com>
Message-ID: <0818676F-ED90-44B1-AB10-42DDB7F1B139@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 22, 2025 3:50:35 AM PDT, Oleg Nesterov <oleg@redhat=2Ecom> wrote:
>On 07/21, David Laight wrote:
>>
>> On Mon, 21 Jul 2025 15:04:22 +0200
>> Oleg Nesterov <oleg@redhat=2Ecom> wrote:
>>
>> > Change mul_u64_u64_div_u64() to return ULONG_MAX if the result doesn'=
t
>> > fit u64, this matches the generic implementation in lib/math/div64=2E=
c=2E
>>
>> Not quite, the generic version is likely to trap on divide by zero=2E
>
>I meant that the generic implementation returns -1ul too if the result
>doesn't fit into u64=2E
>
>> I think it would be better to always trap (eg BUG_ON(!div))=2E
>
>Well, I don't like adding a BUG_ON(), but OK=2E
>
>> The trouble there is that (an ignored) ~(u64)0 is likely to cause anoth=
er
>> arithmetic overflow with even more consequences=2E
>>
>> So I'm not at all sure what it should look like or whether 0 is a bette=
r
>> error return (esp for div =3D=3D 0)=2E
>
>I'm not sure either but x86/generic versions should be consistent=2E Let'=
s
>discuss this and possibly change both implementations later?
>
>> >  static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
>> >  {
>> > +	int ok =3D 0;
>> >  	u64 q;
>> >
>> > -	asm ("mulq %2; divq %3" : "=3Da" (q)
>> > -				: "a" (a), "rm" (mul), "rm" (div)
>> > -				: "rdx");
>> > +	asm ("mulq %3; 1: divq %4; movl $1,%1; 2:\n"
>>
>> The "movl $1,%1" is a 5 byte instruction=2E
>> Better to use either 'incl' or get the constraints right for 'movb'
>
>Agreed, thanks,
>
>> > +	if (ok)
>> > +		return q;
>> > +	WARN_ON_ONCE(!div);
>>
>> I think you need to WARN for overflow as well as divide by zero=2E
>
>The generic implementation doesn't WARN=2E=2E=2E OK, I won't argue=2E
>How about
>
>	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
>	{
>		char ok =3D 0;
>		u64 q;
>
>		asm ("mulq %3; 1: divq %4; movb $1,%1; 2:\n"
>			_ASM_EXTABLE(1b, 2b)
>			: "=3Da" (q), "+r" (ok)
>			: "a" (a), "rm" (mul), "rm" (div)
>			: "rdx");
>
>		if (ok)
>			return q;
>		BUG_ON(!div);
>		WARN_ON_ONCE(1);
>		return ~(u64)0;
>	}
>
>?
>
>Oleg=2E
>

Maybe the generic version *should* warn?

As far as the ok output, the Right Way=E2=84=A2 to do it is with an asm go=
to instead of a status variable; the second best tends to be to use the fla=
gs output=2E

