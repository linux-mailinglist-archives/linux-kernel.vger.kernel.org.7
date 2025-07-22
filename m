Return-Path: <linux-kernel+bounces-741267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8204B0E232
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072D654826C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B173327E07A;
	Tue, 22 Jul 2025 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lbucLWkC"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859302576
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753203232; cv=none; b=pAYQefgM17ROeCFfWjlMzf7GBo2LfSx2hQpIUh8qWkoct65P3NAgkxrrfnF55l5WX2Z499891MZ3Yn7I68yD6brSQKeYC5kHxPH+FMsZkfvHTBPPuP59IPQN/st9mb7CHKIGlrraS6y8qZQ6/ZMugn2xnHSBvbRUBQZkCo0dc7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753203232; c=relaxed/simple;
	bh=tvyOEdY65TwoXGZIsqzDzK0IPCwqGz8MXo9LCIsIPc8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=iTQnUqdtP53mtKG2orgvh9FT48S6bzTpnEV2FlVW0qeHk1tDn3awxgQbpzcQ3ZXp+QxPawE13p3x6mMPDj7x7bjSvWa9JRutGifYlgmpFTCNrnohPYSXKMzgULVpn02yFJ1FZbuBkWYqH6lVBMNpGwhvm+J8mC3NLzykv6PvxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=lbucLWkC; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56MGrLrT656305
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 22 Jul 2025 09:53:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56MGrLrT656305
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1753203202;
	bh=8oke0UyJZg2483dhXqv3xHcnGo9WCRrX0jVW3c5To6c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=lbucLWkCejobtWRbvlIbfNciijpb3gHI2cGhT6QCzdeAVDSKa/LrVojQhJJq7Yvq7
	 BsZ0MdAsOqPlKNFgKxMADkXy39iNRyA3qDoDTzNY62yBPygdIk/mUgp50t2EPhhqIo
	 luhg75eyam513AapWssxJ0IMHlQkMTBa4JT9Kj+744QWvjCetCCYdpsKdpTVCQP/O6
	 E0PnLixtLeD/mywM66COBChyvBFv+J8/DBl04N5pJT1K1cElnyI/+BQZW6UpVUgUm9
	 Tf6Nkydbg1yyc59TOEv7LicZDNzKtqKH2TrVLxUDWhivxSMc4TFusXX7qWWHBUqYgl
	 Do8CpDT7BTqFw==
Date: Tue, 22 Jul 2025 09:53:21 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Laight <david.laight.linux@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Li,Rongqing" <lirongqing@baidu.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] x86/math64: handle #DE in mul_u64_u64_div_u64()
User-Agent: K-9 Mail for Android
In-Reply-To: <20250722130947.0c97c96a@pumpkin>
References: <20250721130422.GA31640@redhat.com> <20250721192053.58843751@pumpkin> <20250722105034.GA2845@redhat.com> <20250722130947.0c97c96a@pumpkin>
Message-ID: <B22E6B1E-9569-4267-87E0-F442B86A49A8@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 22, 2025 5:09:47 AM PDT, David Laight <david=2Elaight=2Elinux@gmail=
=2Ecom> wrote:
>On Tue, 22 Jul 2025 12:50:35 +0200
>Oleg Nesterov <oleg@redhat=2Ecom> wrote:
>
>> On 07/21, David Laight wrote:
>> >
>> > On Mon, 21 Jul 2025 15:04:22 +0200
>> > Oleg Nesterov <oleg@redhat=2Ecom> wrote:
>> > =20
>> > > Change mul_u64_u64_div_u64() to return ULONG_MAX if the result does=
n't
>> > > fit u64, this matches the generic implementation in lib/math/div64=
=2Ec=2E =20
>> >
>> > Not quite, the generic version is likely to trap on divide by zero=2E=
 =20
>>=20
>> I meant that the generic implementation returns -1ul too if the result
>> doesn't fit into u64=2E
>>=20
>> > I think it would be better to always trap (eg BUG_ON(!div))=2E =20
>>=20
>> Well, I don't like adding a BUG_ON(), but OK=2E
>>=20
>> > The trouble there is that (an ignored) ~(u64)0 is likely to cause ano=
ther
>> > arithmetic overflow with even more consequences=2E
>> >
>> > So I'm not at all sure what it should look like or whether 0 is a bet=
ter
>> > error return (esp for div =3D=3D 0)=2E =20
>>=20
>> I'm not sure either but x86/generic versions should be consistent=2E Le=
t's
>> discuss this and possibly change both implementations later?
>
>My thought as well=2E
>Getting both to agree is a start=2E
>
>My latest thought is to add another parameter for the return value
>when the result overflows or is infinity/NaN=2E
>So the calling code can get 0, 1, ~0 (or any other 'safe' value) returned=
=2E
>A special 'magic' value could be used to mean BUG()=2E
>
>>=20
>> > >  static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
>> > >  {
>> > > +	int ok =3D 0;
>> > >  	u64 q;
>> > >
>> > > -	asm ("mulq %2; divq %3" : "=3Da" (q)
>> > > -				: "a" (a), "rm" (mul), "rm" (div)
>> > > -				: "rdx");
>> > > +	asm ("mulq %3; 1: divq %4; movl $1,%1; 2:\n" =20
>> >
>> > The "movl $1,%1" is a 5 byte instruction=2E
>> > Better to use either 'incl' or get the constraints right for 'movb' =
=20
>>=20
>> Agreed, thanks,
>>=20
>> > > +	if (ok)
>> > > +		return q;
>> > > +	WARN_ON_ONCE(!div); =20
>> >
>> > I think you need to WARN for overflow as well as divide by zero=2E =
=20
>>=20
>> The generic implementation doesn't WARN=2E=2E=2E OK, I won't argue=2E
>
>I've a set of patches I need to do a new version of=2E
>I'll add a WARN_ON_ONCE() to the generic version=2E
>I'll also put a copy of this patch in my set so that the later patches
>will apply after this is applied without too much hastle=2E
>
>> How about
>>=20
>> 	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
>> 	{
>> 		char ok =3D 0;
>> 		u64 q;
>>=20
>> 		asm ("mulq %3; 1: divq %4; movb $1,%1; 2:\n"
>> 			_ASM_EXTABLE(1b, 2b)
>> 			: "=3Da" (q), "+r" (ok)
>
>That needs to be "+q" (ok)
>
>> 			: "a" (a), "rm" (mul), "rm" (div)
>> 			: "rdx");
>>=20
>> 		if (ok)
>> 			return q;
>> 		BUG_ON(!div);
>> 		WARN_ON_ONCE(1);
>
>I know there are are a lot of WARN_ON_ONCE(1) out there,
>but maybe WARN_ON_ONCE("muldiv overflow") would be better?
>(The linker will merge the strings)=2E
>
>	David
>
>> 		return ~(u64)0;
>> 	}
>>=20
>> ?
>>=20
>> Oleg=2E
>>=20
>

Note that -1 for division by zero (not necessarily for overflow) follows f=
rom most natural division algorithms, and so architectures which don't trap=
 on division overflow tend to behave that way=2E

