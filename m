Return-Path: <linux-kernel+bounces-746215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBA3B12441
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66D83AA8C2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EE0246BA7;
	Fri, 25 Jul 2025 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DpUkpJ/I"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBFF111BF
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469229; cv=none; b=OxiYf9E1s8EVG00PzsVmTHHCoo/uHuFv5Rc4G8CLk5zdpbCAxfUxDFE470Baa5XvoAupZGUu7bPX6IXhCZSxjnIJ1If6vxTd/KKOSOXDmwVx4HEdjWm4XwpBKeMddt7KjUY0GXBvpx2A9clrZ++eRc69vu9FX79X7wOL8a/hKYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469229; c=relaxed/simple;
	bh=EGkW/C+4hWEaA0d3bON2slcM922fbVtxtPeh7Ud0hI4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Zgn/XQr9wXJbviEedEGzDQ5dupdRUnHIZnNbOPb3ycwKxsPu8pNaK2cMsfNoRND24paap+fVdQIuPy9jauQSEbnFeXyvOMQXZYqZS4HW8Pnu+EvS/zOQ9H7bFW1pd2F97gwJ8RKuBSuwUgFWHsOZW6LV2uqzw3QVdrGZTjZO/Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DpUkpJ/I; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b7766698eeso114095f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753469226; x=1754074026; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PcwJfFG0dMINHTXL+EGs7wi5PgpNiUrzuZGSnnkqAU=;
        b=DpUkpJ/I+KTR27nWP2ZTIQTH33GCaUJEbl7FZTNv+l0GXki+jASCcczgMkAfbPssil
         MliCwxYGHc3iW5AjyCnhrkhPFjfLcq/XRUJMPsTPVK3N4Mna6igXGqu4nFyR8kU5Q9rI
         pMgbrwASRs6+5U2zvd3OixNN5r2RN2XARz7xiRmfc4/vDRgx9TFPgdZbLp0vXuOrDaX3
         FxUV507zz5RoyWX0zM5jUqxnhNlHSZHUzaCrn9HH4WLmdyCMKkJcNT8YzNHlQW0Pm6Ue
         hHqE/sqvWfOrmcFNEiDqm4R4SU9iIU6x+1YARfiNOjve3dkDLOja4rglRqFZxFTm6gd8
         xu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469226; x=1754074026;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2PcwJfFG0dMINHTXL+EGs7wi5PgpNiUrzuZGSnnkqAU=;
        b=VLuJumqfzDmszymW4ZeepNmHH4OjTGsPhl7JhrWqStiS+APDDP0JFbh2QZkJPi7Z1R
         iZuJWSh8M86agm76Q7so8mhMt2DA0A3IlbruOCXmLYvwBJ3Vxsjlvuxw1BmIP7aGTl0c
         MWMiiS0aNHqIQW8VBv5kQmdb+yGFFfJ4Tm1+KkA5jT/TFiApEzvQ9AkfwvUkBMA6ss2p
         4aoCW1OPsJ7M6odT1CoiAQgCZ8c2AUInna5LEMKg2EqdHscclRzrHpem13COmE6do6a2
         P6nPDEaXlUU4GKk5lQL/vFgMK0w6PajVt+ShIm8zBXtFf+7MpXqU13kSdVO28HHe+q9v
         Nolw==
X-Forwarded-Encrypted: i=1; AJvYcCXcYQN+nkHyTm1BIn6FCmYvsqDAbOGbc4Q9+0Z0YZKq8u/X1cigYtyIHxbKoFNaJci3/huZudDb6kYxcN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ15EqDXx72HRsXccJiGdTjHzzapo3kcI09TtnjGNWdPp1Zl3Z
	BU3lNlOm0bMeLl8j/FSHLpBfIP+d95p2kvpk7EtB6BrXZ8ZQrtqDfx1PlJGYlke2Tdw=
X-Gm-Gg: ASbGncuDiQ26c/f3pKaBhmVvDMpogQvR2vIAFBXaX0h6ik+tijoFFROIbF6arSSexSc
	M6MLgBwah7/V2Qx5AKwuxUNd6zUL2XuT0bbMrwZAzf4i43au0qzykrGZVdmgjiD5fiic5iVhtFM
	wR+D9enOMn3Mc+GU3Mm63zgH3i8vMR1EnBfopxZfTM9aiRAwIkpTHfFJ6j17MOqB6wweC9Xc4wk
	APWstsWSDx4cWhWwBnNPR6TNgMeebM82u7nm5CuC2kQxg+JvBEiHGvM/BFHBrwzAiisWg3mHE2n
	0ev/WPtFQvpq93zIhfi4e/mmDe2ZFZyRatyhn7DTBdi3sdNtoBktgnEZ6fmAUtpKXajn/kQjEl2
	YSKYCcq1ZazUgdAx/Ldz73io9P5pvMw==
X-Google-Smtp-Source: AGHT+IERcnhDoDHJATyBIDHX/Fz368IlSTKTvTxrXpoOV1OgdXYCGFXhA0fSjBPI2vbo+UxnHhV7RQ==
X-Received: by 2002:a05:6000:1889:b0:3a3:61ab:86c2 with SMTP id ffacd0b85a97d-3b776732d2cmr1202211f8f.7.1753469225927;
        Fri, 25 Jul 2025 11:47:05 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8c15:2281:5347:b367])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b778f26cc1sm574187f8f.82.2025.07.25.11.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Jul 2025 20:47:04 +0200
Message-Id: <DBLCYPBLQBSQ.170ND7Z93GPK4@ventanamicro.com>
Subject: Re: [PATCH] riscv: Add sysctl to control discard of vstate during
 syscall
Cc: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
To: "Vivian Wang" <wangruikang@iscas.ac.cn>, "Drew Fustini"
 <fustini@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, "Alexandre Ghiti"
 <alex@ghiti.fr>, "Paul Walmsley" <paul.walmsley@sifive.com>, "Samuel
 Holland" <samuel.holland@sifive.com>, "Drew Fustini"
 <dfustini@tenstorrent.com>, "Andy Chiu" <andybnac@gmail.com>, "Conor
 Dooley" <conor.dooley@microchip.com>, <linux-riscv@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250719033912.1313955-1-fustini@kernel.org>
 <cc82c938-def3-4df6-9fc9-fc321af7d54a@iscas.ac.cn>
 <DBL2588APTCA.2XUKQCJ0DW89C@ventanamicro.com>
 <feb3549f-da91-4eaa-a624-b9f35db6ba3c@iscas.ac.cn>
In-Reply-To: <feb3549f-da91-4eaa-a624-b9f35db6ba3c@iscas.ac.cn>

2025-07-25T23:01:03+08:00, Vivian Wang <wangruikang@iscas.ac.cn>:
> On 7/25/25 18:18, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
>> 2025-07-24T05:55:54+08:00, Vivian Wang <wangruikang@iscas.ac.cn>:
>>> On 7/19/25 11:39, Drew Fustini wrote:
>>>> From: Drew Fustini <dfustini@tenstorrent.com>
>>>> Clobbering the vector registers can significantly increase system call
>>>> latency for some implementations. To mitigate this performance impact,=
 a
>>>> policy mechanism is provided to administrators, distro maintainers, an=
d
>>>> developers to control vector state discard in the form of a sysctl kno=
b:
>>> So I had an idea: Is it possible to avoid repeatedly discarding the
>>> state on every syscall by setting VS to Initial after discarding, and
>>> avoiding discarding when VS is Initial? So:
>>>
>>> if (VS =3D=3D Clean || VS =3D=3D Dirty) {
>>> =C2=A0 =C2=A0 clobber;
>>> =C2=A0 =C2=A0 VS =3D Initial;
>>> }
>>>
>>> This would avoid this problem with syscall-heavy user programs while
>>> adding minimum overhead for everything else.
>> I think your proposal improves the existing code, but if a userspace is
>> using vectors, it's likely also restoring them after a syscall, so the
>> state would immediately get dirty, and the next syscall would again
>> needlessly clobber vector registers.
>
> Without any data to back it up, I would say that my understanding is
> that this should be a rare case, only happening if e.g. someone is
> adding printf debugging to their vector code. Otherwise, vector loops
> should not have syscalls in them.
>
> A more reasonable worry would be programs using RVV everywhere in all
> sorts of common operations. In that case, alternating syscalls and
> vectors would make the discarding wasteful.

Good point.  Yeah, auto-vectorization might be hindered.

In the worst case, users could just notice that it's slowing programs
down, and disable it without looking for the cause.

>> Preserving the vector state still seems better for userspaces that use
>> both vectors and syscalls.
>
> If we can expect e.g. userspace programs to primarily repeatedly use RVV
> with no syscalls between loops, *or* primarily repeatedly use syscalls
> with rare occurrences of RVV between syscalls. This way, the primarily
> syscall programs can benefit from slightly switching, since there's no
> need to save and restore state for those most of the time. In effect,
> syscalls serves as a hint that RVV is over.

This would need deeper analysis, and we will probably never be correct
with a system-wide policy regardless -- a room for prctl?

I think there might be a lot of programs that have a repeating pattern
of compute -> syscall (e.g. to write results), and clobbering is losing
performance if a program does more than a single loop per switch.

>                                             The primarily RVV programs
> should not be switching as much - if they are, that's a sign of CPU
> resources being oversubscribed.

Yes, but clobbering only gives benefits on a switch, so we don't want to
clobber if there are more syscall than switches.

Well, there is a way: a syscall could just set VS=3DInitial, and if
userspace doesn't dirty vector registers, a restore would set the
registers to whatever the initial state is.
No vector registers touched on syscall, or save.

This works as we don't have to do anything when "clobbering" -- the
registers are unspecified after a syscall.
The downside is that users might (incorrectly) depend on the unspecified
value without dirtying, so the unspecified value could change at an
arbitrary point, which would provide some interesting debugging cases.

(And it's still suboptimal if software actually wants to preserve
 vectors across syscalls.)

> Having said all of that, I am actually slightly more interested in why
> vmv.v.vi is *so slow* on SiFive X280. I wonder if there would be a more
> microarchitectural favorable ways to just put a bunch of ones in some
> vector registers? Would 0 be better?

No idea, and there are a lot of options to try, but it would be quite
sad if we had to have special case for each implementation.

Thanks.

