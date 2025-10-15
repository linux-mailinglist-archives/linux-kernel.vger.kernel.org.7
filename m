Return-Path: <linux-kernel+bounces-854814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E36BDF753
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E597419A26B9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC10432ED4B;
	Wed, 15 Oct 2025 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cpIm7KsP"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B004132ED38
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543117; cv=none; b=fRWf40aw6hW1UGfA6Y0fAlmNYyBm9PSby0vz/sZiU7YUsCBskr0iwG1r9NMJsLdqBFtGYWygtbxEbyZeao1VFygDuaOCPSlWhLMgBdGUm0Fr8uhSghetfvdqz5IInyr9xDUemdbq/6uOvGqZNMwb7ZM6BI5tiTGrHM5gd1a1W+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543117; c=relaxed/simple;
	bh=D4HBN/HzwPMLi6TcE549r7SP77qD97+VHRD6Ag8byKk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=O4pkNIJpaQpI9c4oj0nQISzGS9mLbvMakYVPu8r7lRLuZl6mA73yeCmubVSM3aRuiW4BFurU560yGXkO1o8DPIvXJEulPdR5O2r7SCvv2r6RCOF8rw0RLqgUH2WFl0NvoEufjxnCWG++GTbmIVvqR1dJA29NPWTq+q7hh7gLMgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=cpIm7KsP; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59FFis4E2528471
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 15 Oct 2025 08:44:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59FFis4E2528471
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1760543095;
	bh=966O6JR8UVT3zZ/CZ4sTwQNyfG0vu3mIGDhUv227K18=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=cpIm7KsPG7ujYiBUE6SEYsufDqQUZuHvdrE7q/AZdgi1kCmoknKprJZnlGe9CS1il
	 PPeSVWIImupb9K5j9UeCeoM92M6LXFEytGpAVt56L6fvvk/XeCJbz32PW3NKDD2sbs
	 0D67GjEuzpYZaYoQ8aSPFFZbLF5+17H6EmEaX3uUsK9nRj+9Sbm2yGN3c+yCtKYu0A
	 hZq3oDLVee4gks0OLJHDSs+z+QbeGy6mkjX6QbulW1fIea6a3hES4LqPQYQ7aLePEH
	 mOCLeCgZY9WLxBzdPg40Urti/RljGPhAA193veu9qJadNO3ZTjrEJ7U8bwDuJfhlPH
	 +M39YND2Q5mzA==
Date: Wed, 15 Oct 2025 08:44:55 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>, Borislav Petkov <bp@kernel.org>,
        Xin Li <xin3.li@intel.com>
CC: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: Re: [PATCH] x86/cpufeatures: Correct LKGS feature flag description
User-Agent: K-9 Mail for Android
In-Reply-To: <530c3c1a-5fab-4798-830b-1fe0e8522bc9@zytor.com>
References: <20251015103548.10194-1-bp@kernel.org> <2dd4dbee-dc7d-4118-be6d-94bd6d0d5030@zytor.com> <329BCA65-5152-4892-AFEA-DF72DCCE80B6@zytor.com> <b632fc82-bef4-456b-ba62-939bda5a4361@zytor.com> <B72756BE-F15B-46D6-B44E-2FBC79E837C3@zytor.com> <530c3c1a-5fab-4798-830b-1fe0e8522bc9@zytor.com>
Message-ID: <9B0843ED-5207-4A42-A95B-1DB5314DE747@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 15, 2025 8:41:03 AM PDT, Xin Li <xin@zytor=2Ecom> wrote:
>On 10/15/2025 11:36 PM, H=2E Peter Anvin wrote:
>> On October 15, 2025 8:34:00 AM PDT, Xin Li <xin@zytor=2Ecom> wrote:
>>> On 10/15/2025 11:18 PM, H=2E Peter Anvin wrote:
>>>> On October 15, 2025 8:08:17 AM PDT, Xin Li <xin@zytor=2Ecom> wrote:
>>>>> On 10/15/2025 6:35 PM, Borislav Petkov wrote:
>>>>>> From: "Borislav Petkov (AMD)" <bp@alien8=2Ede>
>>>>>>=20
>>>>>> Quotation marks in cpufeatures=2Eh comments are special and when th=
e
>>>>>> comment begins with a quoted string, that string lands in /proc/cpu=
info,
>>>>>> turning it into a user-visible one=2E
>>>>>>=20
>>>>>> The LKGS comment doesn't begin with a quoted string but just in cas=
e
>>>>>> drop the quoted "kernel" in there to avoid confusion=2E And while a=
t it,
>>>>>> simply change the description into what the LKGS instruction does f=
or
>>>>>> more clarity=2E
>>>>>>=20
>>>>>> No functional changes=2E
>>>>>>=20
>>>>>> Signed-off-by: Borislav Petkov (AMD) <bp@alien8=2Ede>
>>>>>> ---
>>>>>>     arch/x86/include/asm/cpufeatures=2Eh       | 2 +-
>>>>>>     tools/arch/x86/include/asm/cpufeatures=2Eh | 2 +-
>>>>>>     2 files changed, 2 insertions(+), 2 deletions(-)
>>>>>>=20
>>>>>> diff --git a/arch/x86/include/asm/cpufeatures=2Eh b/arch/x86/includ=
e/asm/cpufeatures=2Eh
>>>>>> index 80b68f4726e7=2E=2E4fb5e12dbdbf 100644
>>>>>> --- a/arch/x86/include/asm/cpufeatures=2Eh
>>>>>> +++ b/arch/x86/include/asm/cpufeatures=2Eh
>>>>>> @@ -320,7 +320,7 @@
>>>>>>     #define X86_FEATURE_FSRS		(12*32+11) /* Fast short REP STOSB */
>>>>>>     #define X86_FEATURE_FSRC		(12*32+12) /* Fast short REP {CMPSB,S=
CASB} */
>>>>>>     #define X86_FEATURE_FRED		(12*32+17) /* "fred" Flexible Return =
and Event Delivery */
>>>>>> -#define X86_FEATURE_LKGS		(12*32+18) /* Load "kernel" (userspace) =
GS */
>>>>>> +#define X86_FEATURE_LKGS		(12*32+18) /* MSR_KERNEL_GS_BASE =3D GS=
=2Ebase */
>>>>>=20
>>>>> Yes, the assignment is more clearer to us programmers=2E
>>>>>=20
>>>>> I'm just not sure if "correct" in the shortlog is accurate; it sound=
s the
>>>>> existing one is wrong=2E  Otherwise,
>>>>>=20
>>>>> Reviewed-by: Xin Li (Intel) <xin@zytor=2Ecom>
>>>>>=20
>>>>=20
>>>> That "assignment" is rather wrong, though; it implies that the two ar=
e identical, which they are not; nor does it imply the relationship is fixe=
d (that is provided by FRED, not LKGS)=2E Perhaps just call it "Load user s=
pace GS"=2E
>>>=20
>>> I see your point, is the following assignment better?
>>>=20
>>>     MSR_KERNEL_GS_BASE =3D gs_sel->base
>>>=20
>>=20
>> Except that that is also wrong, because that's not all of what the inst=
ruction does=2E "Load user space GS" is really what it does, despite the in=
itiate historical naming=2E
>>=20
>
>Do you mean the load of GS attributes by LKGS is still missing?

Yes=2E It's really a modified MOV GS,=2E=2E=2E instruction that loads the =
base, limit, selector, and attributes; it just loads the base into a differ=
ent place=2E

