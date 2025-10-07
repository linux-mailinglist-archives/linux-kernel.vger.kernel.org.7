Return-Path: <linux-kernel+bounces-844592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC6FBC24D5
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 19:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCF619A383D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 17:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4EB2E7BBC;
	Tue,  7 Oct 2025 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiN4Z1Fz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D6A2D3EDF
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759859541; cv=none; b=P06X3BSjZbmMC/E22yIo4f6eFFv+fZhtQ1Pts+VByOC+C8WBhBkPbnna/7gLc7OxapR+d37e63VaWEMbfIXeBExNgbBhgU4jIyIZn3fw0qqdKbmDAOEoY9abxwWianDZNZyq9ZzXjCJg1QGbjP2fVOaQklzWRpxTjEilbVmb0XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759859541; c=relaxed/simple;
	bh=1dzITc0msTixzwZngkIAM0+kMjxc7Sjk7Svpl/USKvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIUDaFM38UtVrkZiMNRrdA7VqJ2OziN3vG+I5+hi7tRfwH3PTFvrFefEid/Dj170OkoldhNIxPST9wk8b66PW5DcGJmSaOluwdP9BrQQUZ56+Y8sy8YuHganRvmb/AuWhkVDdWqsgewC65rFlWWlipGfB1QbtPbG+/1+dG1RaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiN4Z1Fz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6F2C113D0
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 17:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759859541;
	bh=1dzITc0msTixzwZngkIAM0+kMjxc7Sjk7Svpl/USKvE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FiN4Z1FzegMnpIdXu/henNP7ZUJcNBLMMmrHvvzP5C+mGOTUN6+kclR+Lx00tijfF
	 t/d/YbuqpvH4lv85TMLYPoFTYdU4D4rGAD2SgXtz/zsirQzF3NpkGKM+aQmd65Gncd
	 /pEKD2T9lve8GELdYQ3xAiYRTz+HMMQmwYziX5LxhfUSrpm4oiZ+poyg41hxLfSXVs
	 /6wdbN3FVdrE6tGfxJ5EX8UJzjhDz8XX9RqcsKXDDWszJ/4HDNHxGN2Oo9aAexdlpz
	 Jx53c+jF+IKMnXS277WPVGzb8P3hYdQnODqh+7wqjIjoNXABLLw/3gtRGP7arGAFyj
	 7nwIc6Wy9b1IA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3635bd94f3eso56481951fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:52:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXThn0fF9J7bJkK+Ts50QH9DfB6nGKPJkL75yNqxgNXRhsaTxG/tnuf3rgRq7SV46Yvf7TsRDRpqFn6ywM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlhxyX3WM7gwAd2ac2AitCLFsSO6nWgrfmY1r9bd11z8f9HJ4K
	3oIJ1L7ieIS7zao/p9KTMo+Dtuw5FEd69/CHLMkr/EQKHpBeNANZ2HJa2WyuT4Q+FazLXILD2+s
	q8vMjjO0bRmYGGbvprGaligK3uHpEywY=
X-Google-Smtp-Source: AGHT+IGmT4ZXu0FIyWwOvLIp9E5AG1zHlsLdLMdm3sCt/oKNhuNYMmRFgZ+17usOiWCpsTsbb2hliWIukTOoogfQj3c=
X-Received: by 2002:a2e:be0c:0:b0:36e:9e8f:ba4d with SMTP id
 38308e7fff4ca-37609d40fc1mr773271fa.14.1759859539625; Tue, 07 Oct 2025
 10:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006172612.75240-1-ebiggers@kernel.org> <CAMj1kXFTbP9dGQmk9F-WFyoL_LjtfXHMCnGT0WUQwMnrn7DHCw@mail.gmail.com>
 <20251007011142.GA77681@sol>
In-Reply-To: <20251007011142.GA77681@sol>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 7 Oct 2025 10:52:06 -0700
X-Gmail-Original-Message-ID: <CAMj1kXFFCgAqefvDLgCzU_wtSAS-aPzRLMBt1qPNw2hcXtQiGQ@mail.gmail.com>
X-Gm-Features: AS18NWDbe0Y3rDs4kMdLZ1kGNB-J3m7IwGG8MiiQtstVfSyZemTGskbaT0Ajn5g
Message-ID: <CAMj1kXFFCgAqefvDLgCzU_wtSAS-aPzRLMBt1qPNw2hcXtQiGQ@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: Add FIPS pre-operational self-test for SHA algorithms
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Joachim Vandersmissen <git@jvdsn.com>, David Howells <dhowells@redhat.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 18:13, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Oct 07, 2025 at 01:53:25AM +0200, Ard Biesheuvel wrote:
> > On Mon, 6 Oct 2025 at 19:28, Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > Add FIPS pre-operational self-tests for all SHA-1 and SHA-2 algorithms.
> > > Following the "Implementation Guidance for FIPS 140-3" document, to
> > > achieve this it's sufficient to just test a single test vector for each
> > > of HMAC-SHA1, HMAC-SHA256, and HMAC-SHA512.
> > >
> > > Link: https://lore.kernel.org/linux-crypto/20250917184856.GA2560@quark/
> > > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > > ---
> > >
> > > Since there seemed to be more interest in complaining that these are
> > > missing than actually writing a patch, I decided to just do it.
> > >
> > >  lib/crypto/fips.h                   | 38 +++++++++++++++++++++++++++++
> > >  lib/crypto/sha1.c                   | 19 ++++++++++++++-
> > >  lib/crypto/sha256.c                 | 19 ++++++++++++++-
> > >  lib/crypto/sha512.c                 | 19 ++++++++++++++-
> > >  scripts/crypto/gen-fips-testvecs.py | 33 +++++++++++++++++++++++++
> > >  5 files changed, 125 insertions(+), 3 deletions(-)
> > >  create mode 100644 lib/crypto/fips.h
> > >  create mode 100755 scripts/crypto/gen-fips-testvecs.py
> > >
> > > diff --git a/lib/crypto/fips.h b/lib/crypto/fips.h
> > > new file mode 100644
> > > index 0000000000000..78a1bdd33a151
> > > --- /dev/null
> > > +++ b/lib/crypto/fips.h
> > > @@ -0,0 +1,38 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > +/* This file was generated by: gen-fips-testvecs.py */
> > > +
> > > +#include <linux/fips.h>
> > > +
> > > +static const u8 fips_test_data[] __initconst __maybe_unused = {
> > > +       0x66, 0x69, 0x70, 0x73, 0x20, 0x74, 0x65, 0x73,
> > > +       0x74, 0x20, 0x64, 0x61, 0x74, 0x61, 0x00, 0x00,
> > > +};
> > > +
> > > +static const u8 fips_test_key[] __initconst __maybe_unused = {
> > > +       0x66, 0x69, 0x70, 0x73, 0x20, 0x74, 0x65, 0x73,
> > > +       0x74, 0x20, 0x6b, 0x65, 0x79, 0x00, 0x00, 0x00,
> > > +};
> > > +
> > > +static const u8 fips_test_hmac_sha1_value[] __initconst __maybe_unused = {
> > > +       0x29, 0xa9, 0x88, 0xb8, 0x5c, 0xb4, 0xaf, 0x4b,
> > > +       0x97, 0x2a, 0xee, 0x87, 0x5b, 0x0a, 0x02, 0x55,
> > > +       0x99, 0xbf, 0x86, 0x78,
> > > +};
> > > +
> > > +static const u8 fips_test_hmac_sha256_value[] __initconst __maybe_unused = {
> > > +       0x59, 0x25, 0x85, 0xcc, 0x40, 0xe9, 0x64, 0x2f,
> > > +       0xe9, 0xbf, 0x82, 0xb7, 0xd3, 0x15, 0x3d, 0x43,
> > > +       0x22, 0x0b, 0x4c, 0x00, 0x90, 0x14, 0x25, 0xcf,
> > > +       0x9e, 0x13, 0x2b, 0xc2, 0x30, 0xe6, 0xe8, 0x93,
> > > +};
> > > +
> > > +static const u8 fips_test_hmac_sha512_value[] __initconst __maybe_unused = {
> > > +       0x6b, 0xea, 0x5d, 0x27, 0x49, 0x5b, 0x3f, 0xea,
> > > +       0xde, 0x2d, 0xfa, 0x32, 0x75, 0xdb, 0x77, 0xc8,
> > > +       0x26, 0xe9, 0x4e, 0x95, 0x4d, 0xad, 0x88, 0x02,
> > > +       0x87, 0xf9, 0x52, 0x0a, 0xd1, 0x92, 0x80, 0x1d,
> > > +       0x92, 0x7e, 0x3c, 0xbd, 0xb1, 0x3c, 0x49, 0x98,
> > > +       0x44, 0x9c, 0x8f, 0xee, 0x3f, 0x02, 0x71, 0x51,
> > > +       0x57, 0x0b, 0x15, 0x38, 0x95, 0xd8, 0xa3, 0x81,
> > > +       0xba, 0xb3, 0x15, 0x37, 0x5c, 0x6d, 0x57, 0x2b,
> > > +};
> > > diff --git a/lib/crypto/sha1.c b/lib/crypto/sha1.c
> > > index 5904e4ae85d24..001059cb0fce4 100644
> > > --- a/lib/crypto/sha1.c
> > > +++ b/lib/crypto/sha1.c
> > > @@ -10,10 +10,11 @@
> > >  #include <linux/kernel.h>
> > >  #include <linux/module.h>
> > >  #include <linux/string.h>
> > >  #include <linux/unaligned.h>
> > >  #include <linux/wordpart.h>
> > > +#include "fips.h"
> > >
> > >  static const struct sha1_block_state sha1_iv = {
> > >         .h = { SHA1_H0, SHA1_H1, SHA1_H2, SHA1_H3, SHA1_H4 },
> > >  };
> > >
> > > @@ -328,14 +329,30 @@ void hmac_sha1_usingrawkey(const u8 *raw_key, size_t raw_key_len,
> > >         hmac_sha1_update(&ctx, data, data_len);
> > >         hmac_sha1_final(&ctx, out);
> > >  }
> > >  EXPORT_SYMBOL_GPL(hmac_sha1_usingrawkey);
> > >
> > > -#ifdef sha1_mod_init_arch
> > > +#if defined(sha1_mod_init_arch) || defined(CONFIG_CRYPTO_FIPS)
> > >  static int __init sha1_mod_init(void)
> > >  {
> > > +#ifdef sha1_mod_init_arch
> > >         sha1_mod_init_arch();
> > > +#endif
> > > +       if (fips_enabled) {
> > > +               /*
> > > +                * FIPS pre-operational self-test.  As per the FIPS
> > > +                * Implementation Guidance, testing HMAC-SHA1 satisfies the test
> > > +                * requirement for SHA-1 too.
> > > +                */
> > > +               u8 mac[SHA1_DIGEST_SIZE];
> > > +
> > > +               hmac_sha1_usingrawkey(fips_test_key, sizeof(fips_test_key),
> > > +                                     fips_test_data, sizeof(fips_test_data),
> > > +                                     mac);
> > > +               if (memcmp(fips_test_hmac_sha1_value, mac, sizeof(mac)) != 0)
> > > +                       panic("sha1: FIPS pre-operational self-test failed\n");
> > > +       }
> > >         return 0;
> > >  }
> > >  subsys_initcall(sha1_mod_init);
> > >
> >
> > In the builtin case, couldn't this execute only after the first calls
> > into the library? That would mean it does not quite fit the
> > requirements of the pre-operational selftest.
>
> Only if other builtin code in the kernel actually calls it before
> subsys_initcall, i.e. during very early boot long before userspace
> starts.  Such calls can occur only from within the FIPS module (i.e. the
> kernel) itself, so arbitrary external users need not be considered here.
>

Good point. We should probably document this, i.e., the fact that this
is before storage and network etc are even accessible and so panicking
at that point is sufficient even in the presence of even earlier
callers.

