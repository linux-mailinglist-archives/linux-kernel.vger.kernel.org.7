Return-Path: <linux-kernel+bounces-854796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14558BDF69F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 018564E6140
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609343019D0;
	Wed, 15 Oct 2025 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GHk3E31l"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5CE2D24AC
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542616; cv=none; b=PjF/I+2Tfud+WuMLobzDFe7nlT/6GIo2VH+8y6mHjZyi+sHCX4M3dr5l9MmDtv/CF4m9GNNAoa7EFWj0L42VSh0jRQolSt0+y3Ub1eo3APhOHo1zvBC0lghPpxXWJ2gTgIBjhlzisGdgTZlPHEffl5Mr0oFtUiX9BrHR6Ngfhk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542616; c=relaxed/simple;
	bh=sNNXF2SmS6CWRtY6auWhe98gcPVAtn/Ljd2KMKbR5QI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Wp2dO5YGsCD1PyCEHvyRMOxrfnrr4rRusfC4WJ/QRrGrCi17BBiZeqJ3uEb3r4E2dkn6g/3MnmoTZqoNTEj8lngfRr/NTXxI1dP8XmOdQZP+ufE2lClWvWJDNIWvjYFdH/tQ3/St96K/isK8XPk6E+UxdJpt93gIF507y/PAuoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=GHk3E31l; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59FFaa4l2525200
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 15 Oct 2025 08:36:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59FFaa4l2525200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1760542597;
	bh=jareRpY3tUdQTG4RqaNcVG+sL6w5C72VkBpmob6YCZQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=GHk3E31lzZCjv/6SZAMe+b0qKxu9//IdJc3ev6mVBv2fmqUCcz4byAleeqhb5Ib5P
	 gobULHFo2FM/eLvtLqirTBNh9snVAe+qdyQE3/e54jsUWz5+sfWhIB/UkZ9x2Oe9Jf
	 doY8eHEReWWeyONaG9b1wxYUK/E39/RRp/TJymBPw+BBMgM/YUpgHAgsVg/8Fg8gzu
	 TdZq9H+dOs8FsMUamVfiIxa+mWQcGHhLbU2fQm52IjGNvAIVXyAm2iMPs8cJJMoxWC
	 Fh7uU2To58YHu4RxwisQ9JG3TbKoavU/VFVhovhwUsYb/gMYRtAjeVPnAjcb9y28qs
	 CXGnzvOmiTl0Q==
Date: Wed, 15 Oct 2025 08:36:36 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>, Borislav Petkov <bp@kernel.org>,
        Xin Li <xin3.li@intel.com>
CC: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: Re: [PATCH] x86/cpufeatures: Correct LKGS feature flag description
User-Agent: K-9 Mail for Android
In-Reply-To: <b632fc82-bef4-456b-ba62-939bda5a4361@zytor.com>
References: <20251015103548.10194-1-bp@kernel.org> <2dd4dbee-dc7d-4118-be6d-94bd6d0d5030@zytor.com> <329BCA65-5152-4892-AFEA-DF72DCCE80B6@zytor.com> <b632fc82-bef4-456b-ba62-939bda5a4361@zytor.com>
Message-ID: <B72756BE-F15B-46D6-B44E-2FBC79E837C3@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 15, 2025 8:34:00 AM PDT, Xin Li <xin@zytor=2Ecom> wrote:
>On 10/15/2025 11:18 PM, H=2E Peter Anvin wrote:
>> On October 15, 2025 8:08:17 AM PDT, Xin Li <xin@zytor=2Ecom> wrote:
>>> On 10/15/2025 6:35 PM, Borislav Petkov wrote:
>>>> From: "Borislav Petkov (AMD)" <bp@alien8=2Ede>
>>>>=20
>>>> Quotation marks in cpufeatures=2Eh comments are special and when the
>>>> comment begins with a quoted string, that string lands in /proc/cpuin=
fo,
>>>> turning it into a user-visible one=2E
>>>>=20
>>>> The LKGS comment doesn't begin with a quoted string but just in case
>>>> drop the quoted "kernel" in there to avoid confusion=2E And while at =
it,
>>>> simply change the description into what the LKGS instruction does for
>>>> more clarity=2E
>>>>=20
>>>> No functional changes=2E
>>>>=20
>>>> Signed-off-by: Borislav Petkov (AMD) <bp@alien8=2Ede>
>>>> ---
>>>>    arch/x86/include/asm/cpufeatures=2Eh       | 2 +-
>>>>    tools/arch/x86/include/asm/cpufeatures=2Eh | 2 +-
>>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>>=20
>>>> diff --git a/arch/x86/include/asm/cpufeatures=2Eh b/arch/x86/include/=
asm/cpufeatures=2Eh
>>>> index 80b68f4726e7=2E=2E4fb5e12dbdbf 100644
>>>> --- a/arch/x86/include/asm/cpufeatures=2Eh
>>>> +++ b/arch/x86/include/asm/cpufeatures=2Eh
>>>> @@ -320,7 +320,7 @@
>>>>    #define X86_FEATURE_FSRS		(12*32+11) /* Fast short REP STOSB */
>>>>    #define X86_FEATURE_FSRC		(12*32+12) /* Fast short REP {CMPSB,SCAS=
B} */
>>>>    #define X86_FEATURE_FRED		(12*32+17) /* "fred" Flexible Return and=
 Event Delivery */
>>>> -#define X86_FEATURE_LKGS		(12*32+18) /* Load "kernel" (userspace) GS=
 */
>>>> +#define X86_FEATURE_LKGS		(12*32+18) /* MSR_KERNEL_GS_BASE =3D GS=2E=
base */
>>>=20
>>> Yes, the assignment is more clearer to us programmers=2E
>>>=20
>>> I'm just not sure if "correct" in the shortlog is accurate; it sounds =
the
>>> existing one is wrong=2E  Otherwise,
>>>=20
>>> Reviewed-by: Xin Li (Intel) <xin@zytor=2Ecom>
>>>=20
>>=20
>> That "assignment" is rather wrong, though; it implies that the two are =
identical, which they are not; nor does it imply the relationship is fixed =
(that is provided by FRED, not LKGS)=2E Perhaps just call it "Load user spa=
ce GS"=2E
>
>I see your point, is the following assignment better?
>
>    MSR_KERNEL_GS_BASE =3D gs_sel->base
>

Except that that is also wrong, because that's not all of what the instruc=
tion does=2E "Load user space GS" is really what it does, despite the initi=
ate historical naming=2E

