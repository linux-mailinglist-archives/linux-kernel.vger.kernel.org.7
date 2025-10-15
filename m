Return-Path: <linux-kernel+bounces-854760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD44BDF4FE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55F0421095
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51DF2FB97F;
	Wed, 15 Oct 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UUGi8yK7"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E922C1DE8AF
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541557; cv=none; b=myJaxTAYspAtIoDQ0c4pZ8ospPdp22RIN+ATYoplJFrBzmt837tW2ZozOwm/o2eu7n4eB4nqeN7/0qACt7bLSk4fUb46kCPiWs4dL9uV4ZzyGoHgdB9WDt1WC1vVVWkbYr/y+nxP6fRvJ49Cf9o5Xe+e4a0t/JO3siuE/HVtlHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541557; c=relaxed/simple;
	bh=GmZ/UpKdg5ha/5pA0ipiThelD0yC8oWi349y4Q90IGo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pd9u61LUepPHlvD6Kp47fGvAqoZzlhZEji95uiFJ5APjH4CyJjlxmUKXrPuD2OYCTnn2riWD6rkdFdA3F38eVx3X7y976afw2Lnf1ndz7LwchnYg0IJaREP1ZHfIOOQII/q9OgxJ7VXD/u9w34GwpapNKnzLEUB3STYKpi2kPNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=UUGi8yK7; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 59FFIku92517719
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 15 Oct 2025 08:18:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 59FFIku92517719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1760541527;
	bh=dQjhWEzcvm8gSHGkG3+/XlxrWUH3WG0aRWE1xdw8TIw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=UUGi8yK7pBGvO5v13xWBIpZ0j6w19czSTGfMKJ0NKMK5MYoa6z98+bBfHJ7lCA2Wz
	 1orhU8ThgTUgbtA5FUW0sD1Y9vTdBG/yafx+KG/zJJOJQhXj3Z6GDCeunsVSrmxtUv
	 BJPGEfmfDSAUrHYyG9X25j1jc518lVG5+un5srw3oX+G4Zz/xlJ3bm5tWiy2O6h4YV
	 Vl8ih2t5+4rCtXww8MieoTPVUgtt1ftiaDfCkSt5LQznEP8ohVmm62ErytIeG2NcLD
	 Ti4ynR1P/pakTZk+YQpcBh9lukab78WgGQSAo54VJ47lzaXmWDVKSaIZ7ZEBxHDV63
	 DpZzJAzTYA5vg==
Date: Wed, 15 Oct 2025 08:18:45 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>, Borislav Petkov <bp@kernel.org>,
        Xin Li <xin3.li@intel.com>
CC: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: Re: [PATCH] x86/cpufeatures: Correct LKGS feature flag description
User-Agent: K-9 Mail for Android
In-Reply-To: <2dd4dbee-dc7d-4118-be6d-94bd6d0d5030@zytor.com>
References: <20251015103548.10194-1-bp@kernel.org> <2dd4dbee-dc7d-4118-be6d-94bd6d0d5030@zytor.com>
Message-ID: <329BCA65-5152-4892-AFEA-DF72DCCE80B6@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 15, 2025 8:08:17 AM PDT, Xin Li <xin@zytor=2Ecom> wrote:
>On 10/15/2025 6:35 PM, Borislav Petkov wrote:
>> From: "Borislav Petkov (AMD)" <bp@alien8=2Ede>
>>=20
>> Quotation marks in cpufeatures=2Eh comments are special and when the
>> comment begins with a quoted string, that string lands in /proc/cpuinfo=
,
>> turning it into a user-visible one=2E
>>=20
>> The LKGS comment doesn't begin with a quoted string but just in case
>> drop the quoted "kernel" in there to avoid confusion=2E And while at it=
,
>> simply change the description into what the LKGS instruction does for
>> more clarity=2E
>>=20
>> No functional changes=2E
>>=20
>> Signed-off-by: Borislav Petkov (AMD) <bp@alien8=2Ede>
>> ---
>>   arch/x86/include/asm/cpufeatures=2Eh       | 2 +-
>>   tools/arch/x86/include/asm/cpufeatures=2Eh | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/x86/include/asm/cpufeatures=2Eh b/arch/x86/include/as=
m/cpufeatures=2Eh
>> index 80b68f4726e7=2E=2E4fb5e12dbdbf 100644
>> --- a/arch/x86/include/asm/cpufeatures=2Eh
>> +++ b/arch/x86/include/asm/cpufeatures=2Eh
>> @@ -320,7 +320,7 @@
>>   #define X86_FEATURE_FSRS		(12*32+11) /* Fast short REP STOSB */
>>   #define X86_FEATURE_FSRC		(12*32+12) /* Fast short REP {CMPSB,SCASB} =
*/
>>   #define X86_FEATURE_FRED		(12*32+17) /* "fred" Flexible Return and Ev=
ent Delivery */
>> -#define X86_FEATURE_LKGS		(12*32+18) /* Load "kernel" (userspace) GS *=
/
>> +#define X86_FEATURE_LKGS		(12*32+18) /* MSR_KERNEL_GS_BASE =3D GS=2Eba=
se */
>
>Yes, the assignment is more clearer to us programmers=2E
>
>I'm just not sure if "correct" in the shortlog is accurate; it sounds the
>existing one is wrong=2E  Otherwise,
>
>Reviewed-by: Xin Li (Intel) <xin@zytor=2Ecom>
>
>
>
>
>
>
>>   #define X86_FEATURE_WRMSRNS		(12*32+19) /* Non-serializing WRMSR */
>>   #define X86_FEATURE_AMX_FP16		(12*32+21) /* AMX fp16 Support */
>>   #define X86_FEATURE_AVX_IFMA            (12*32+23) /* Support for VPM=
ADD52[H,L]UQ */
>> diff --git a/tools/arch/x86/include/asm/cpufeatures=2Eh b/tools/arch/x8=
6/include/asm/cpufeatures=2Eh
>> index bd655e100395=2E=2Ed5f091babf96 100644
>> --- a/tools/arch/x86/include/asm/cpufeatures=2Eh
>> +++ b/tools/arch/x86/include/asm/cpufeatures=2Eh
>> @@ -320,7 +320,7 @@
>>   #define X86_FEATURE_FSRS		(12*32+11) /* Fast short REP STOSB */
>>   #define X86_FEATURE_FSRC		(12*32+12) /* Fast short REP {CMPSB,SCASB} =
*/
>>   #define X86_FEATURE_FRED		(12*32+17) /* "fred" Flexible Return and Ev=
ent Delivery */
>> -#define X86_FEATURE_LKGS		(12*32+18) /* Load "kernel" (userspace) GS *=
/
>> +#define X86_FEATURE_LKGS		(12*32+18) /* MSR_KERNEL_GS_BASE =3D GS=2Eba=
se */
>>   #define X86_FEATURE_WRMSRNS		(12*32+19) /* Non-serializing WRMSR */
>>   #define X86_FEATURE_AMX_FP16		(12*32+21) /* AMX fp16 Support */
>>   #define X86_FEATURE_AVX_IFMA            (12*32+23) /* Support for VPM=
ADD52[H,L]UQ */
>

That "assignment" is rather wrong, though; it implies that the two are ide=
ntical, which they are not; nor does it imply the relationship is fixed (th=
at is provided by FRED, not LKGS)=2E Perhaps just call it "Load user space =
GS"=2E

