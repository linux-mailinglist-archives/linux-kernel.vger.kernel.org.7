Return-Path: <linux-kernel+bounces-741364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44845B0E341
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFECEAC06D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0309A28002B;
	Tue, 22 Jul 2025 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nWzapQgJ"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F16027FD4A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753207973; cv=none; b=nITFB3aYRmtLR/FlMg9aFKwUABNU7+tApHANRX0e45NPnWvyz3hvvjrv/S+7IDgYS2EGrlltxs3gEpVK0cv82nYy+/GTmK3UyX62DsfoCRgg/F2Cs58RefvSP8E/nF5Oq8r0XueeaLXd8a5isrzN99SharQoueQVpuwBOSKhMlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753207973; c=relaxed/simple;
	bh=b3oGMSbM7NELf9rS+gvfr+J+7D4AYCSgnlJgytfvKbY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=PIfp0PRy7zIMyfot4Fp1btFphGwbZ9jL+jXItgWtKbp1epA6oj1wL0EyRRA22pQ3jCZWlACi8c80gkgGOgPhmTaElDcJvk8bZw2mAwNiN5px4S3ZpC8r83943Jn7+clApals//2L2Kl7sC9bae/TPnxcVGevCnft3B/78lH4nUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=nWzapQgJ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56MICF1Z688042
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 22 Jul 2025 11:12:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56MICF1Z688042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1753207936;
	bh=Md7Xc6ncFRKoeRUKWpmSmp+jdO2ly50TYARqfYiDyT8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=nWzapQgJpAtwmH1vkju3XOv+KtSjKPbPMitRiKSCg2wIHKXaySKJnRRQ7x2HEB7h0
	 LoKNvDTBgUFuH3AUx9PLTxkG2+eMLJZma5sVVRmHu3GCeq1EWUOJXy/U+FKGLgvfKh
	 yK9+Qiab3Ze+0z6VMrCSzfQpdckUQM5e1SUDAU49DiuKF3/jOOZmNbfawNtyAHAK6x
	 PuvSHS1gJXWkBEcdxAIQ3PC0U/dCNNJC1g4qbojPzIfExqJ91vm/9u/knhAnOpKIJr
	 fLj18pVmaALNwZtbMV3oDAItL74i8yNXyB8jHoYzLusnfNZidPqL88EV5lrIqctdiI
	 GtKjSfHj0F1Kg==
Date: Tue, 22 Jul 2025 11:12:15 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Oleg Nesterov <oleg@redhat.com>
CC: David Laight <david.laight.linux@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Li,Rongqing" <lirongqing@baidu.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] x86/math64: handle #DE in mul_u64_u64_div_u64()
User-Agent: K-9 Mail for Android
In-Reply-To: <20250722175807.GC2845@redhat.com>
References: <20250721130422.GA31640@redhat.com> <20250721192053.58843751@pumpkin> <20250722105034.GA2845@redhat.com> <0818676F-ED90-44B1-AB10-42DDB7F1B139@zytor.com> <20250722175807.GC2845@redhat.com>
Message-ID: <548B24CC-2E58-4CC5-9025-950408BDCAA5@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 22, 2025 10:58:08 AM PDT, Oleg Nesterov <oleg@redhat=2Ecom> wrote:
>On 07/22, H=2E Peter Anvin wrote:
>>
>> On July 22, 2025 3:50:35 AM PDT, Oleg Nesterov <oleg@redhat=2Ecom> wrot=
e:
>> >
>> >The generic implementation doesn't WARN=2E=2E=2E OK, I won't argue=2E
>> >How about
>> >
>> >	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
>> >	{
>> >		char ok =3D 0;
>> >		u64 q;
>> >
>> >		asm ("mulq %3; 1: divq %4; movb $1,%1; 2:\n"
>> >			_ASM_EXTABLE(1b, 2b)
>> >			: "=3Da" (q), "+r" (ok)
>> >			: "a" (a), "rm" (mul), "rm" (div)
>> >			: "rdx");
>> >
>> >		if (ok)
>> >			return q;
>> >		BUG_ON(!div);
>> >		WARN_ON_ONCE(1);
>> >		return ~(u64)0;
>> >	}
>> >
>> >?
>> >
>> >Oleg=2E
>>
>> Maybe the generic version *should* warn?
>
>David is going to change the generic version to WARN=2E
>
>> As far as the ok output, the Right Way=E2=84=A2 to do it is with an asm=
 goto instead
>> of a status variable; the second best tends to be to use the flags outp=
ut=2E
>
>This is what I was going to do initially=2E But this needs
>CONFIG_CC_HAS_ASM_GOTO_OUTPUT
>
>Oleg=2E
>

But that's what you want to optimize for, since that is all the modern com=
pilers, even if you have to have two versions as a result=2E

