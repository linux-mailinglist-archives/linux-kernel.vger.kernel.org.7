Return-Path: <linux-kernel+bounces-742577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F629B0F3EC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B6718836A7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC972E6118;
	Wed, 23 Jul 2025 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcBA451l"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BDD283138;
	Wed, 23 Jul 2025 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277044; cv=none; b=W+qsGnUYR1yLr6nZ4LclJd9b1p3ew533h3lqL4yGSXwtOoRncvFfXsLispflqRw2xCH4j9GlpfxUwpn5S886o2VoIlMkH4WJXL3wICBlJHcaQpKGEIHF1BkjSCJJ4juGxMhYlHzH4RsOLEGRaPF9Om38Lm3WWfenWs06tNqVp84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277044; c=relaxed/simple;
	bh=g325tVK4oCmVy8BazrF60y4Ub/2vaJobxM9gJAh3M5I=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dn7a4i0QDDQekV1DALnxfAFG6+w3WCiQztTqDxmIV4tfV8jRBiow9K6H2oFKdmuYTBA2i3XP0BLrXv6GUcuWTlN91HkkftQkmBzihwDIK0Gnz3wFDxo/p6xG5LQ2vKz0gD8Hitw9mHwkZdfxv7DBSXy/p15tRQJM7d/7BWz2HS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcBA451l; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23636167afeso63977335ad.3;
        Wed, 23 Jul 2025 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753277042; x=1753881842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxSF6lnsSAWsI4yFBGjBR+eKMGMyYNRUTfnKAxfWQFc=;
        b=TcBA451lcifjWBo5dQBzT+erN2OqNqbr5oCkVesSP33lNqaWna4rrpmwNxKHRQDISZ
         Scd5lOAKiZE4W6RBn62G7CmvLFoO6BmQiu/QUzJvuWs7obq9TQqFXmy+y+vpGJhixq38
         X+AeXb+g0961651itacf+V3vArroTpaP9hAeZgKEorUZtsgXGFz5bHZZiQHvO74ESyOt
         qcgqT1sG5emGjuUuVvi6ngM+gFQO8GGJY4lx/pVEUc8Rgxf4BGAvS2IRjYCM5VRtLXjN
         F/cL79oVn07LBErDa2ttF+ApQmwU0/PEkXF87gxMCyWzkkZL6hQUqEF9e1DNHO9cakrp
         bibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753277042; x=1753881842;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AxSF6lnsSAWsI4yFBGjBR+eKMGMyYNRUTfnKAxfWQFc=;
        b=iQUQt3n0goEEi+UtB+TlKrwcXCoJdzD93xYPGe76HVcoiC4x5akf+aef7ORyTBSBoJ
         LiykuNMaB+gsktmyupKwgylCqh9N5CfMxskJXTamEFriku8gDfsu55axgc3RZspNPYF5
         HJosnzFwz34yzOh+KqWdnmA/D2QYeDRyD+7e7aIeEAmzA+GyuqEs0Xe/C6fxgVyorAEw
         e/J6oqh8HhlhSTPWe5JVooCNV6cNctPxW2hlpCIt8RQEinHaaCU4WX8pa+2LHO/BFr6s
         B1H1KCAXoMyoRsW+p3GJ8eU8gbChcVgFYrU/ic2VFYCLmGZ4UZLKoAuAcwCRW5FNSYWh
         Awuw==
X-Forwarded-Encrypted: i=1; AJvYcCUcMcoTBy3P0H1PugIyTdLlNoXEAbc8tBvdR3+Ecl7Ft0qeHkgEbhzAvU2Kl5QFJ8Khj+4WrrkbXqYyviE=@vger.kernel.org, AJvYcCUdl6kGKcy8yPPOnZW7vwHZsKi8SbwA3DvM6r1ceM0c7bZwup7ycikTjAE4DiaLKj9W7m5StkSK2IpCmhs3Egk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqITbGuyvuOzvwKRAB3shEQZRsxf7NHYy/wb0+8Asj7K15cShN
	Y8lB7K1CkAlJOB1Q1dtNtLThPSx8Cpg0Voc/sDTzH7JiG6PCrQVKqRPT
X-Gm-Gg: ASbGnctwyCrNR9jPoXOzWkGB3YIbRtzvnIvIsIpSAAfEJAvd2QIgCQObCKefGaMKFEq
	7j5kYGZ9e/J0RYlxzrQ6/RyIPThQQLEMPHZtY49wGWkFTJF1IIBxAaBHE4UQuaMMY4hJOLmkN8f
	TB2nvpUXChL3gc6fuZmKlJUxTVyH2khgzPER2s9iB1IjHYzXIGtb+OpY9yxxK0CemKkb2mkJGDY
	5l9kurYIvpkX+tkTc7h4qLJiCRgV1BG+SmVYAPADRbeYrqlFVNGzev4HRFPiGb8ZrdXqLqep4Yt
	15IkK1qRj/NDudxJP4YAZpTyjIEsYntySz/WKXCg2kRixa0WdpYW0ek+JJxN31PTQwhj++Jg5Aa
	2Vk3OeBmGxT9j7oqBUlEgX33lXmbZCk0s2FNGbgdis5uWsrMVRmh7kaOAsMQbvJCkwyjmQimV2a
	ho
X-Google-Smtp-Source: AGHT+IHeJqmBBFuJxJuYzYQrFS3o4VgCeV81DU3JpPQ+6NIF4D1yK+R8kibmHclHfqnrmsxDYjwysQ==
X-Received: by 2002:a17:902:e887:b0:234:bca7:2920 with SMTP id d9443c01a7336-23f981b42c1mr48016245ad.24.1753277042029;
        Wed, 23 Jul 2025 06:24:02 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e4750sm97384825ad.6.2025.07.23.06.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 06:24:01 -0700 (PDT)
Date: Wed, 23 Jul 2025 22:23:43 +0900 (JST)
Message-Id: <20250723.222343.803840555288624865.fujita.tomonori@gmail.com>
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
In-Reply-To: <CANiq72nLQkJo8voGONJBEgE8st7=A4RW7VP+W++SVCWse49n=Q@mail.gmail.com>
References: <CANiq72=Hr5rg7tYta8aUoxt8hOPjR2ik5_-xMWZwacr63=-7KA@mail.gmail.com>
	<20250723.152042.1300024463910400.fujita.tomonori@gmail.com>
	<CANiq72nLQkJo8voGONJBEgE8st7=A4RW7VP+W++SVCWse49n=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 11:52:04 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

>> The patch for arm64? I tried to minimize changes to the original code
>> so not intentional.
> 
> The riscv one, i.e. from the range diff:
> 
>     @@ arch/riscv/include/asm/bug.h: typedef u32 bug_insn_t;
>                 "2:\n\t"                                        \
>      -                  __BUG_ENTRY "\n\t"                      \
>      -                  ".org 2b + %3\n\t"                      \
>     --                  ".popsection"                           \
>      +          __BUG_ENTRY(file, line, flags) "\n\t"           \
>      +                  ".org 2b + " size "\n\t"                \
>     -+                  ".popsection\n"                         \
>     +                   ".popsection"                           \
>      +
>      +#define __BUG_FLAGS(flags)                                        \
>      +do {                                                              \
> 
> If you look into the `.popsection` line, your patch adds a newline,
> but I guess it was not intentional. In x86 there is a newline after
> the directive, but there we have `extra` afterwards.

Oops, indeed it's not intentional.

> (I noticed since I went to expand the macros in a dummy file, given it
> can be something tricky to spot differences in the normal diff, but it
> is visible in the normal diff.)
> 
>> Yeah, I followed the original code style.
> 
> And here I meant (i.e. the first part of that paragraph) that:
> 
>     -                    "\t.org 2b+%c1\n"                                  \
> 
> now generated those two spaces around it:
> 
>     +       "\t.org 2b + " size "\n"                                        \
> 

Ah, not intentional again.

