Return-Path: <linux-kernel+bounces-848884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1D2BCEC11
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68D864E433F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577A127FB30;
	Fri, 10 Oct 2025 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFTQwtB6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2A127D770;
	Fri, 10 Oct 2025 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760139112; cv=none; b=h0mfxt6sWGNwFCc3cMm3wN7t5Ce0nU0L4JEpLZcYw7zSbGLjb83nCIccxi/nS+b9aJ/d4EYTpCJREJjURmiy2iL7CSHTVxNe9lhID9fBwXWJLKzaXvmN122fKjUy9z+zVRjdAo/cLI3YNnsbY0L3+gjoPWb5UYwCyxSHhYnyBNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760139112; c=relaxed/simple;
	bh=TKRk43KEUUSuLlo1tb5wxFjSobEi0qjdp5/fqI8sX+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjCP4ZxqdcWyfRKT4Z0vk/ZMnig53VYcC9lf0yuEXj9wYEeUdiRFphL0io/EYk/SFWzp2wN6oYPm9GYPdbWBEzNTNajy6V0oHhelUc0aKpByyKuEDMNwd6vkMg+zK44YklqVauoaj1Blq6YDjRIKQ70HdyAi2ehIOBYOW7u72oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFTQwtB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9B0C4CEF1;
	Fri, 10 Oct 2025 23:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760139111;
	bh=TKRk43KEUUSuLlo1tb5wxFjSobEi0qjdp5/fqI8sX+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFTQwtB6UMXjP+PqNLMi3i6b4Bv6FSGzmyit4SAQlpC6jyh82ksqjKDkVMhm7VYrr
	 SDlZEjnkz3JmSXzbW5sPcLoOLgyWG1XESohyLN12FfdVAWqI6RhRbP5O8zDo4f2lrX
	 cIJibGpz8LSJXE9imYaCVjf2cOh9HtD8ClGnOLIoK90EYqWJPo8/ubdSjQvxF31/1e
	 Dfuw8jtCsMp8tQX64Tw8B1azr7KbNvzt/yCjW/1tlVhC0bK5OfdO1Rc5gGwhIYFwxL
	 phsKItwOgsOnRajVTJUe54OVx2qjeerVZ871NGd7TF6wU9G6wWKTZ6kedh0poTu/aJ
	 IJfp/szvbrCrg==
Date: Fri, 10 Oct 2025 16:31:49 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Joachim Vandersmissen <git@jvdsn.com>,
	David Howells <dhowells@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] lib/crypto: Add FIPS pre-operational self-test for SHA
 algorithms
Message-ID: <20251010233149.GA20823@quark>
References: <20251006172612.75240-1-ebiggers@kernel.org>
 <CAMj1kXFTbP9dGQmk9F-WFyoL_LjtfXHMCnGT0WUQwMnrn7DHCw@mail.gmail.com>
 <20251007011142.GA77681@sol>
 <CAMj1kXFFCgAqefvDLgCzU_wtSAS-aPzRLMBt1qPNw2hcXtQiGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFFCgAqefvDLgCzU_wtSAS-aPzRLMBt1qPNw2hcXtQiGQ@mail.gmail.com>

On Tue, Oct 07, 2025 at 10:52:06AM -0700, Ard Biesheuvel wrote:
> On Mon, 6 Oct 2025 at 18:13, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Tue, Oct 07, 2025 at 01:53:25AM +0200, Ard Biesheuvel wrote:
> > > On Mon, 6 Oct 2025 at 19:28, Eric Biggers <ebiggers@kernel.org> wrote:
> > > >
> > > > Add FIPS pre-operational self-tests for all SHA-1 and SHA-2 algorithms.
> > > > Following the "Implementation Guidance for FIPS 140-3" document, to
> > > > achieve this it's sufficient to just test a single test vector for each
> > > > of HMAC-SHA1, HMAC-SHA256, and HMAC-SHA512.
> > > >
> > > > Link: https://lore.kernel.org/linux-crypto/20250917184856.GA2560@quark/
> > > > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > > > ---
> > > >
> > > > Since there seemed to be more interest in complaining that these are
> > > > missing than actually writing a patch, I decided to just do it.
> > > >
> > > >  lib/crypto/fips.h                   | 38 +++++++++++++++++++++++++++++
> > > >  lib/crypto/sha1.c                   | 19 ++++++++++++++-
> > > >  lib/crypto/sha256.c                 | 19 ++++++++++++++-
> > > >  lib/crypto/sha512.c                 | 19 ++++++++++++++-
> > > >  scripts/crypto/gen-fips-testvecs.py | 33 +++++++++++++++++++++++++
> > > >  5 files changed, 125 insertions(+), 3 deletions(-)
> > > >  create mode 100644 lib/crypto/fips.h
> > > >  create mode 100755 scripts/crypto/gen-fips-testvecs.py
> > > >
> > > > diff --git a/lib/crypto/fips.h b/lib/crypto/fips.h
> > > > new file mode 100644
> > > > index 0000000000000..78a1bdd33a151
> > > > --- /dev/null
> > > > +++ b/lib/crypto/fips.h
> > > > @@ -0,0 +1,38 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > > +/* This file was generated by: gen-fips-testvecs.py */
> > > > +
> > > > +#include <linux/fips.h>
> > > > +
> > > > +static const u8 fips_test_data[] __initconst __maybe_unused = {
> > > > +       0x66, 0x69, 0x70, 0x73, 0x20, 0x74, 0x65, 0x73,
> > > > +       0x74, 0x20, 0x64, 0x61, 0x74, 0x61, 0x00, 0x00,
> > > > +};
> > > > +
> > > > +static const u8 fips_test_key[] __initconst __maybe_unused = {
> > > > +       0x66, 0x69, 0x70, 0x73, 0x20, 0x74, 0x65, 0x73,
> > > > +       0x74, 0x20, 0x6b, 0x65, 0x79, 0x00, 0x00, 0x00,
> > > > +};
> > > > +
> > > > +static const u8 fips_test_hmac_sha1_value[] __initconst __maybe_unused = {
> > > > +       0x29, 0xa9, 0x88, 0xb8, 0x5c, 0xb4, 0xaf, 0x4b,
> > > > +       0x97, 0x2a, 0xee, 0x87, 0x5b, 0x0a, 0x02, 0x55,
> > > > +       0x99, 0xbf, 0x86, 0x78,
> > > > +};
> > > > +
> > > > +static const u8 fips_test_hmac_sha256_value[] __initconst __maybe_unused = {
> > > > +       0x59, 0x25, 0x85, 0xcc, 0x40, 0xe9, 0x64, 0x2f,
> > > > +       0xe9, 0xbf, 0x82, 0xb7, 0xd3, 0x15, 0x3d, 0x43,
> > > > +       0x22, 0x0b, 0x4c, 0x00, 0x90, 0x14, 0x25, 0xcf,
> > > > +       0x9e, 0x13, 0x2b, 0xc2, 0x30, 0xe6, 0xe8, 0x93,
> > > > +};
> > > > +
> > > > +static const u8 fips_test_hmac_sha512_value[] __initconst __maybe_unused = {
> > > > +       0x6b, 0xea, 0x5d, 0x27, 0x49, 0x5b, 0x3f, 0xea,
> > > > +       0xde, 0x2d, 0xfa, 0x32, 0x75, 0xdb, 0x77, 0xc8,
> > > > +       0x26, 0xe9, 0x4e, 0x95, 0x4d, 0xad, 0x88, 0x02,
> > > > +       0x87, 0xf9, 0x52, 0x0a, 0xd1, 0x92, 0x80, 0x1d,
> > > > +       0x92, 0x7e, 0x3c, 0xbd, 0xb1, 0x3c, 0x49, 0x98,
> > > > +       0x44, 0x9c, 0x8f, 0xee, 0x3f, 0x02, 0x71, 0x51,
> > > > +       0x57, 0x0b, 0x15, 0x38, 0x95, 0xd8, 0xa3, 0x81,
> > > > +       0xba, 0xb3, 0x15, 0x37, 0x5c, 0x6d, 0x57, 0x2b,
> > > > +};
> > > > diff --git a/lib/crypto/sha1.c b/lib/crypto/sha1.c
> > > > index 5904e4ae85d24..001059cb0fce4 100644
> > > > --- a/lib/crypto/sha1.c
> > > > +++ b/lib/crypto/sha1.c
> > > > @@ -10,10 +10,11 @@
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/string.h>
> > > >  #include <linux/unaligned.h>
> > > >  #include <linux/wordpart.h>
> > > > +#include "fips.h"
> > > >
> > > >  static const struct sha1_block_state sha1_iv = {
> > > >         .h = { SHA1_H0, SHA1_H1, SHA1_H2, SHA1_H3, SHA1_H4 },
> > > >  };
> > > >
> > > > @@ -328,14 +329,30 @@ void hmac_sha1_usingrawkey(const u8 *raw_key, size_t raw_key_len,
> > > >         hmac_sha1_update(&ctx, data, data_len);
> > > >         hmac_sha1_final(&ctx, out);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(hmac_sha1_usingrawkey);
> > > >
> > > > -#ifdef sha1_mod_init_arch
> > > > +#if defined(sha1_mod_init_arch) || defined(CONFIG_CRYPTO_FIPS)
> > > >  static int __init sha1_mod_init(void)
> > > >  {
> > > > +#ifdef sha1_mod_init_arch
> > > >         sha1_mod_init_arch();
> > > > +#endif
> > > > +       if (fips_enabled) {
> > > > +               /*
> > > > +                * FIPS pre-operational self-test.  As per the FIPS
> > > > +                * Implementation Guidance, testing HMAC-SHA1 satisfies the test
> > > > +                * requirement for SHA-1 too.
> > > > +                */
> > > > +               u8 mac[SHA1_DIGEST_SIZE];
> > > > +
> > > > +               hmac_sha1_usingrawkey(fips_test_key, sizeof(fips_test_key),
> > > > +                                     fips_test_data, sizeof(fips_test_data),
> > > > +                                     mac);
> > > > +               if (memcmp(fips_test_hmac_sha1_value, mac, sizeof(mac)) != 0)
> > > > +                       panic("sha1: FIPS pre-operational self-test failed\n");
> > > > +       }
> > > >         return 0;
> > > >  }
> > > >  subsys_initcall(sha1_mod_init);
> > > >
> > >
> > > In the builtin case, couldn't this execute only after the first calls
> > > into the library? That would mean it does not quite fit the
> > > requirements of the pre-operational selftest.
> >
> > Only if other builtin code in the kernel actually calls it before
> > subsys_initcall, i.e. during very early boot long before userspace
> > starts.  Such calls can occur only from within the FIPS module (i.e. the
> > kernel) itself, so arbitrary external users need not be considered here.
> >
> 
> Good point. We should probably document this, i.e., the fact that this
> is before storage and network etc are even accessible and so panicking
> at that point is sufficient even in the presence of even earlier
> callers.

I'll leave a note in the commit message, but as I mentioned the strategy
of running FIPS self-tests in an initcall is already used in other
places such as crypto/kdf_sp800108.c.  This individual patch isn't a
great place to document the strategy that the kernel is using to meet
FIPS requirements.  That's something that belongs in the (nonexistent)
documentation file for fips=1...

- Eric

