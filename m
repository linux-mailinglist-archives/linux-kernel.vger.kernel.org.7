Return-Path: <linux-kernel+bounces-873024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85214C12D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8381A22C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423F029B8D9;
	Tue, 28 Oct 2025 04:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=miraclelinux-com.20230601.gappssmtp.com header.i=@miraclelinux-com.20230601.gappssmtp.com header.b="E9PuKh3g"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9594F286D57
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761625228; cv=none; b=t4Eea6iH2DTVSefn9CRwPILwDY8trCJUaPocs4FG9v02mgK7VrsCmbayDhq9LxHw7Qjww+5juFXWf1o/zAeUBG1U8Ktz9QUE1U3T7JEHJOdE3JvDSmBblaW8GChsrs2eI9arUNWs4gturkSt9PPW5MLywJHBgoe4RKczfMYFIp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761625228; c=relaxed/simple;
	bh=msohZkr+NwwmB2EqQFrMg6mu8sGsicKi4jgyZx6qKy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ns5sOILovcKlxUfkgkt6fZ4lillRg96sGo2lh1J4APO4qAMmrS/n5ixlhMwSKtVLHAHefbj0cUlR0M9DGe9PEWebqtlGO56JbSVd7e1gBpLDeZfh95H1rx3f34zmzW7cBkWI+belDAG5Lj556qT38iwFhQvdic7bNo+okEq1bQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com; spf=pass smtp.mailfrom=miraclelinux.com; dkim=pass (2048-bit key) header.d=miraclelinux-com.20230601.gappssmtp.com header.i=@miraclelinux-com.20230601.gappssmtp.com header.b=E9PuKh3g; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraclelinux.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33bc2178d6aso4034902a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1761625222; x=1762230022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/Eh6XRAI4h4SqD+6bp/Xm+SamBxx+Vd9V0BI45M2O8=;
        b=E9PuKh3gFZ0bgLli/XQX7V1fqI2YmYlUN1wfPBhgFWhRZKy5eT4/QEc+/VbOw6UC8L
         Nr0DHNc1Mk/Jr/uflE3XQvKLzumkCi3dW089XmIsEdmqLbJTYqXvmsS+D0b+6bm4cSkT
         COg+k6PwqtDcw1zf+yCqxFvOG69WxvsRI7q5E8xDvqQxmC3lBf2XN5ozBlKINSzrO6Zo
         cbePeOidBnsX4nC81ndnTpiBX96NJpFgws9ErXi/LZ2Il+nrptUFAVCRQ7/bsdo7jtNQ
         b1smbIBD+loYVOF4HVPCKDAeOEbhn8x8eNklsxyUv1sATclP4UW6kuEVvc3ySbDyyFYx
         X6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761625222; x=1762230022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/Eh6XRAI4h4SqD+6bp/Xm+SamBxx+Vd9V0BI45M2O8=;
        b=tXz0CWgRQwWllkCak9mW9HiH3/uLF5goQMkwNkWjDOxtsFwedlV6W5S0MYKNyGHq6d
         uypJQ+DluJ6S2/PQvp6Rgat1Il2pCOyb83QjmBP9ZWoK6FCtfFD2+bZbA0b/InVBQucd
         LZ4pDtZJ1fuMnyTFH+oV4bbRFETXKjQTuhJa69nTp7En0K2d0thinsbSMEzoWmKhYJke
         3vUaMZ/amGHFaeL0MVPNDf4SGBIBFyE+SrHtAXCgfYvLY1UWgwV+fA1T1QgCNVk/s5gV
         wzPg3cichJfo/X6dliU95wgznzFMy8LSfCufyAC+bmq9jBSA6n4aZESCeqq5vbfFwXh9
         ZOEA==
X-Forwarded-Encrypted: i=1; AJvYcCUBy9Orp/7sTRZS/oORVRwIwLTC9+FYTqd3z+7z4rpuqhkXd1FrjDq8Pl0jdkH5rPxDXDPIHJsCF9NZG+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/2OQnk+akk10EEC/E+tlQTl4gLdpzlvv8EYRdkoZqnoiBktEe
	nAsBj1U3+0KuMtL6wxWvfXJhpfqfZSmDzM1WuOmYsjz39I+Tt1jevssWeTashTndc6zkdseeckP
	R0hsoGtMAuSbhHBF76CRJmeLTNy5XxvXRJR/ZwQa9
X-Gm-Gg: ASbGncvRgEl8u3TNpes8WfcoUOGamzFajwbbibUY08ysfgwk6CyrHSIP/12jcwVLmV3
	W2/nDM4n8uyaAGd7tLHcDmSKcRf9kvQoSyKuGvAV1DhrNCyM3gcOKq4j2iFPPp3fQeuQFqsw1/H
	Fj6/ATMNEKHfJH2t8U+YsUAIhbou4meVcwrUX3q4D0nUi13gsOe4LJDTiPDXv72VwHeu4hfVeNz
	zHNPGHCLAv0D5D46DymFfKgN3IPCTLgKlWh+12mHl/Q7kux7uVpeXb+nICHG0H7MGigp7I=
X-Google-Smtp-Source: AGHT+IHS/IBQykuSSTKjZtqlOLHI9siIng09XyLFjE6uQY7ZhwlxLCu9x57ghAVVRzsQdJcQdz1jjmH+MlZJfuxRj+s=
X-Received: by 2002:a17:90b:1811:b0:338:2c90:1540 with SMTP id
 98e67ed59e1d1-34027bd6b50mr2591985a91.20.1761625221764; Mon, 27 Oct 2025
 21:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027114059.GJ3245006@noisy.programming.kicks-ass.net> <20251027124049.GAaP9oUaUtzzHUK4j4@fat_crate.local>
In-Reply-To: <20251027124049.GAaP9oUaUtzzHUK4j4@fat_crate.local>
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Tue, 28 Oct 2025 13:19:45 +0900
X-Gm-Features: AWmQ_bkXI8e_c3dH8yzTXrwvQTQmlQnn7-84xRQZVbYmndNGIUZXhzyINWMYKVA
Message-ID: <CANgtXuN-grBSdVfhtZ0xBk8pWyh6tUiMtAWOaPHBApQ3wrUy6w@mail.gmail.com>
Subject: Re: x86: Disable SSE4A
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org, Leyvi Rose <leyvirose@gmail.com>, 
	Samuel Holland <samuel.holland@sifive.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 9:41=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Mon, Oct 27, 2025 at 12:40:59PM +0100, Peter Zijlstra wrote:
> > Leyvi Rose reported that his X86_NATIVE_CPU=3Dy build is failing becaus=
e
> > our instruction decoder doesn't support SSE4A and the AMDGPU code seems
> > to be generating those with his compiler of choice (CLANG+LTO).
> >
> > Now, our normal build flags disable SSE MMX SSE2 3DNOW AVX, but then
> > CC_FLAGS_FPU re-enable SSE SSE2.
> >
> > Since nothing mentions SSE3 or SSE4, I'm assuming that -msse (or its
> > negative) control all SSE variants -- but why then explicitly enumerate
> > SSE2 ?
> >
> > Anyway, until the instruction decoder gets fixed, explicitly disallow
> > SSE4A (an AMD specific SSE4 extension).
> >
> > Fixes: ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU opti=
on to locally optimize the kernel with '-march=3Dnative'")
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >
> > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > index 4db7e4bf69f5..8fbff3106c56 100644
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -75,7 +75,7 @@ export BITS
> >  #
> >  #    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D53383
> >  #
> > -KBUILD_CFLAGS +=3D -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
> > +KBUILD_CFLAGS +=3D -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -mn=
o-sse4a
> >  KBUILD_RUSTFLAGS +=3D --target=3D$(objtree)/scripts/target.json
> >  KBUILD_RUSTFLAGS +=3D -Ctarget-feature=3D-sse,-sse2,-sse3,-ssse3,-sse4=
.1,-sse4.2,-avx,-avx2
>
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
>

 Acked-by: Arisu Tachibana <arisu.tachibana@miraclelinux.com>


--
thanks,
arisut

