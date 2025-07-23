Return-Path: <linux-kernel+bounces-741905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9315B0EA81
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98813B5F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75DC26B766;
	Wed, 23 Jul 2025 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFVZLDxy"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16732E36F8;
	Wed, 23 Jul 2025 06:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753251663; cv=none; b=Ft++huPwhh22jZatm0/oVEc5cxlWsJS82Xup54mIblzwkPcFhK/uNMEw6mVVhPrF5v6nCK2oi+VAKQGKMQK7aNWurV1Faexvy4SU603z2Flgg23JuMgrSrVyeMdWOzEaA4VidaXUq1Ycj8W/fho7/beBQVOjHZvE2d4hCYyQe/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753251663; c=relaxed/simple;
	bh=dOYO8tpnU06dNy4P4TYEwSAL4PiOkzLs2WaCif6tl8Q=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WGJdLFVsmg0odbJWPFcLsQeQ9k1bE0C02hi5SXzAFqKwP8BU23QJI1sPSEq1Dn2rAla/0wJHl4fyvKklYmEHVoeN6yIGo09ast3vwClcBrGtpTYoPWZU4RKnCPAipXlGpJN4RNvChi4kbweZWX2PNwUibKqha8XkPdpNsHNSPPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFVZLDxy; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b350704f506so491837a12.0;
        Tue, 22 Jul 2025 23:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753251661; x=1753856461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uTJIJErGkkgE26dleTTxRjWov2b7YHYQZlVlu/+KP64=;
        b=LFVZLDxyYpPo9bE0Y8JFs04DWV2QF/7/Pb+HfN4uEWj7srUQ/GCC8RkMbwHN0JKukO
         dpebXlJpKg6qyUkG6G7+x+vV00dercETSNPQTebo51UZdUesXws7J0yMXd06T9j9GF8Q
         3qZoo9bK+xgBMxyEXTjtPR7HHAopq5Mcel2eIDEyAnWxxYdF3/xAxzv9lUXoLUTU1N62
         kox8I0F/82N0c3UlTDUmmzfGwe3LOLr7i8OVojFLHR4mTvvCrNozzO/ILg/obgnssPuf
         H6vGm8+K40coTFi74rXexjFguo3/o3Xnyk9BvOsHTSUA13o7A+2mHYcCvTwR/P2hlyCb
         +P0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753251661; x=1753856461;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uTJIJErGkkgE26dleTTxRjWov2b7YHYQZlVlu/+KP64=;
        b=BRxtTuYQjkOUDqn9brykxIB67p7/jyr3NOY7vimjTzXP9Sbfu4isQB54FxM8n8nlxO
         Hz9UsiJwOaZqdcxhP5vwUr39NgluHY1Xp9dEo68dV/x+oFioyDkfvxZc1dfa9SRjMuOi
         AP1OaxqmgH3e4VazXRMCezfxVxQGRt2S8knsFyPnVQJ8bjVboodDBVoe0Amwsv858EIe
         CM3fxrdqdsze4T+u5UkMnoOWFuQ9rfS53gZN4iUhFHg7/PjFbZYHajehCwPFdJ7tdNIi
         kNFQdnNpmsvtEq7EWH408hWtQBC/Y34ysILNxUA5kWHqdJxK2GLzvW6pXyba7O0F3xK8
         uEvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf2LBCF54ZZ8FVx5x8BM49jhnFbuTk87Da3J9STxFWjxEIJnqpKc0+23HaxaTGq4PXa68yE18052GxfJI=@vger.kernel.org, AJvYcCWqFlegpuYHVGUGZHmMZSRkVgPoTdC8tgDe+q7MySadc0Le4Vwb5JlBHdY0+OGiIh+hfMrnwu7AElh3KUdqw2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeppHhCcePxaEYk/oj8nWO0BFCA/0s0j1dsR4xuO+oH+KC2w1b
	OMHOjHSfCue2Ba/FONx9/+OodpKE3CyhtSh5qubYyjoVCL6ICC54V++g
X-Gm-Gg: ASbGncsd2OE25wSaIsi5hbJquEsrQCokDDUYkW39X+FUWNdk22i1PsyyGuh5OvDEnMK
	LizSotutd8hnoDFEg4E2w0yTQUb2ztaGd5EMoNgoSpzWAasuN53NBEjHWe3V41tGNuFkAMWD3EU
	409FCy6b6AUGSi6/3oLhQAMJix4+WMpQpMy3djqdYrsSZ3QPFAPToOFXXDFBjVHXkkcqSNKaCIn
	UyKIvpKZsWufzhQO1HbMvYyrfAmF+xpqYvN0Ujy2zKHUyAub/iajK0oz9VEZEV6S1a/ubGWv+wD
	Z86XK8jklr7oyW3QfPm6cgjKiXOpIvlNCK3Nlsa5ewDeYvmLRZWiOLqOA6pbutLtR1LDVOVILGx
	DtrjZaNdLlgJPh8Z6gU2T3e4Mu66JD3NDB8jBTSTxNwPw0KxgvyPTckJrLqSpMwofvdeYRsLi1d
	o69sn1y1umGNs=
X-Google-Smtp-Source: AGHT+IGCxo7rpM1rfk9awKmH6T4kvUglH+Vv6jkf+KqhCJfICKASDS6UxOL8YDc9W4DbQD/ruOaxfA==
X-Received: by 2002:a05:6a21:1fc3:b0:225:ba92:447d with SMTP id adf61e73a8af0-23d48dbeaf4mr3003123637.9.1753251660919;
        Tue, 22 Jul 2025 23:21:00 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb67901csm8977248b3a.100.2025.07.22.23.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 23:21:00 -0700 (PDT)
Date: Wed, 23 Jul 2025 15:20:42 +0900 (JST)
Message-Id: <20250723.152042.1300024463910400.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, peterz@infradead.org,
 hpa@zytor.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, tangyouling@loongson.cn,
 hejinyang@loongson.cn, yangtiezhu@loongson.cn, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org
Subject: Re: [PATCH v6 0/4] rust: Add bug/warn abstractions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72=Hr5rg7tYta8aUoxt8hOPjR2ik5_-xMWZwacr63=-7KA@mail.gmail.com>
References: <20250502094537.231725-1-fujita.tomonori@gmail.com>
	<CANiq72=Hr5rg7tYta8aUoxt8hOPjR2ik5_-xMWZwacr63=-7KA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 02:48:20 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

>> This patchset adds warn_on macro with the bug/warn abstraction that
>> utilizes the kernel's BUG/WARN feature via assembly.
> 
> Ok, let's move forward with this.
> 
> I took a look at the first three patches and compared the expanded
> output for the existing macros, to make sure we (hopefully) don't
> break anything else.

Thanks a lot!

> It seems OK, I only noticed a removed newline. Was that intentional?

The patch for arm64? I tried to minimize changes to the original code
so not intentional.

> There was also a bad parameter name, but that was not hurting anything
> since it was unused.
> 
> (For the x86 one could be closer removing a couple spaces, but it
> should not matter and other x86 files format it that way, so I didn't
> change it. I also noticed unexpected spaces used for aligning the
> macro, but it turned out it was in the original already, so I left it
> also unchanged.)

Yeah, I followed the original code style.

> Then I found a few more bits on the last patch.
> 
> Tomo, could you please double-check you are OK with all the changes,
> and please run the tests you did back then on `rust-next` again for
> all arches, given it has been a while since you posted it (plus I did
> a few changes on top, after all)? I would appreciate it, thanks in
> advance!

I've just tested rust-next. Looks like all arches (x86, riscv, and
arm64) works as expected.

> To be clear, I didn't re-check every single thing/combination, but
> hopefully what I caught helps. Since there are no users anyway (of the
> last patch) right now, it should be fairly safe.
> 
> Applied to `rust-next` -- thanks everyone!
> 
>     [ Fixed typo in macro parameter name. - Miguel ]
> 
>     [ Remove ending newline in `ARCH_WARN_ASM` content to be closer to the
>       original. - Miguel ]
> 
>     [ Avoid evaluating the condition twice (a good idea in general,
>       but it also matches the C side). Simplify with `as_char_ptr()`
>       to avoid a cast. Cast to `ffi` integer types for
>       `warn_slowpath_fmt`. Avoid cast for `null()`. - Miguel ]
> 

All the changes look good.

Thanks!

