Return-Path: <linux-kernel+bounces-729663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE0FB039E0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA34F189C768
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5178923D29A;
	Mon, 14 Jul 2025 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I3n8Eymi"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD6023BF9F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752482931; cv=none; b=m5j6INHMDaxqGuQftRhPGSs1/g1HkkpsBEBPuxZ3R6xdUH2BZMT0I85Qc327RfLjLGe5p6yamlw1GVQ0qYV0msIQc9IG3vqticR2aHCm9OFtStV4OH1ZP0FcbLnHEipOYn2YxgbQO2TMaX8rh3deNIaCd8HukBTbSyzTkdZRN0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752482931; c=relaxed/simple;
	bh=uEb/0VR0iaHwMvhSvE890850NYx60tZHhru27ZS4cjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGEdtP0i+hIGv9r6GhaU+HejNLjr4CJ13kTgqVVddjbvlYGi1t4ICHZoSFL1FCen8idMSFQHcwU4tQrxocwtt4T9A7u3ZV1WcSmJZTKxr8q5ab8mwpc/D5cZlvCEL/MOe7OZOEOZ9HccptOozUYnYb6kskpDh09hhDNobOfLYQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I3n8Eymi; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso2483842f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 01:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752482928; x=1753087728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2eqVvWUGyRNHCflMNysYozlpMXxPdhkCEbZuAC8Zek=;
        b=I3n8EymihNmdglcYcNwsS2/MPGOG7vVXFBzibnHNvjm5lkfjhFSAjzqaUtmm2e6BlD
         9fo+j/Z+dvGxdk19LI0S9aPjkEcTCaLZpfuRkFZZtxTH/C0aK8F9ET4AZgUu3GYWZG5b
         NWLz9fIlLEUU60YcQik9hrjrXzyo8Mdht053meqDCbLvH8E0gtqK92jVlKTMhlZEqXM4
         zE7GZRaCRfI0ii97ruG7F1pTvtnSBpuAcUF8DnxOggZgeKPbP8qE4mmy8tU4Ad6KlO2F
         U0Wh4lelHhyMnHwTYD7/7FhMIi7zeY1jkNijJBcN5O7tvMe9am1kRFqr5LB2LiB6JqnA
         MRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752482928; x=1753087728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2eqVvWUGyRNHCflMNysYozlpMXxPdhkCEbZuAC8Zek=;
        b=ZbHUSkkzFGDUMrqNsQVxoqes+fNypGulmaqTH9l4zj1xOxGdd/IgaCUyiIi0HJU9+0
         cvO7avsNFf+zHn1KSX7guS+O1HoXljta8+zEOCMQMPiyIGlCZ1pVhiPTF8dC3ogdGFiZ
         xkjygY9+hmyEf4+O1V/qz+0TqK+p+S8DaeuAuS9NlMSI4YVTbV6W8IEfDo8gfb7pGTBT
         JhCRp1xjn8OJp3CyRt9K31RPJCQzSJRQwc5RhvELnnSwrRaAQunjPcbeWXTN75a8i0dE
         yQGs6oZkPAme0Hm8KHih7c/i4QBjzVY86lz3b8x60vR6lePgjfJ4eupgwc6eCdw0dkIT
         43Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWlWcmT0efGEaBxjn6zJtefRMjvoUhXg/VJ0qNnWo4/GL40L4xkmge480KJ5nLb63E9oBsJtcoX0YbJ4uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMPisZElxoPLGZYLUnz/N/QmZZdUXgQdqv2PL4WL+q8iP6govz
	+4TzQ+fh/ZXVveXG/N1QJ6gObLogofu7g+ton39609VjGDp7GY9WSwsDSwWhrpNzBENcJn4ndJK
	kHFLeLjY6E5bCgLXD37UNoRz+ebzx5AOZf/xSfQhF
X-Gm-Gg: ASbGncsMv87H+lZ9x+BfauXDSBUQoJnlVIHzE5kB85n+T7IHVTrL2zOoMU5wzi+byAy
	rxultppMadZiZs+CmB6lTHhMXDbnpsHOT/mVjYHmVbXRGritHzp6KcMEMMA0vvo230w1QhWnHhp
	GH30g8tRs7/zlTZhhs/JAU1HGnTSEWXeicULCquCd5fFH8c1lrLfW6SqilvKIe6dnYmqIfkY5oN
	lzzW6j6JPN9G1n2FaBY1pufdAsCpy3Pigd2SQ==
X-Google-Smtp-Source: AGHT+IFbanDs448XsjcCBuRD1OV+c4gYqU1GnCMBsm0XxQ4lxhrcMIJOjMNwYVAs8QqAaAg2E2jmgkH/HpU2k0t6Gys=
X-Received: by 2002:a05:6000:1ac5:b0:3a5:58a5:6a83 with SMTP id
 ffacd0b85a97d-3b5f187e264mr10159893f8f.13.1752482927867; Mon, 14 Jul 2025
 01:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712160103.1244945-1-ojeda@kernel.org> <20250712160103.1244945-2-ojeda@kernel.org>
 <20250714084638.GL905792@noisy.programming.kicks-ass.net>
In-Reply-To: <20250714084638.GL905792@noisy.programming.kicks-ass.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 14 Jul 2025 10:48:33 +0200
X-Gm-Features: Ac12FXxMqzqa-86YzzJsOO2IogpXRlxWKeLa1kAAYOw4KPVk-KLgMAKuFCR7SWg
Message-ID: <CAH5fLgjtU1u=h8FY3im364AsC21GitnrjhBT=YJMmipH_ZWnQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] objtool/rust: add one more `noreturn` Rust function
 for Rust 1.89.0
To: Peter Zijlstra <peterz@infradead.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 10:46=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Sat, Jul 12, 2025 at 06:01:02PM +0200, Miguel Ojeda wrote:
> > Starting with Rust 1.89.0 (expected 2025-08-07), under
> > `CONFIG_RUST_DEBUG_ASSERTIONS=3Dy`, `objtool` may report:
> >
> >     rust/kernel.o: warning: objtool: _R..._6kernel4pageNtB5_4Page8read_=
raw()
> >     falls through to next function _R..._6kernel4pageNtB5_4Page9write_r=
aw()
> >
> > (and many others) due to calls to the `noreturn` symbol:
> >
> >     core::panicking::panic_nounwind_fmt
> >
> > Thus add the mangled one to the list so that `objtool` knows it is
> > actually `noreturn`.
> >
> > See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions"=
)
> > for more details.
> >
> > Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned=
 in older LTSs).
> > Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> > ---
> >  tools/objtool/check.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index f23bdda737aa..3257eefc41ed 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -224,6 +224,7 @@ static bool is_rust_noreturn(const struct symbol *f=
unc)
> >              str_ends_with(func->name, "_4core9panicking14panic_explici=
t")                            ||
> >              str_ends_with(func->name, "_4core9panicking14panic_nounwin=
d")                            ||
> >              str_ends_with(func->name, "_4core9panicking18panic_bounds_=
check")                        ||
> > +            str_ends_with(func->name, "_4core9panicking18panic_nounwin=
d_fmt")                        ||
> >              str_ends_with(func->name, "_4core9panicking19assert_failed=
_inner")                       ||
> >              str_ends_with(func->name, "_4core9panicking30panic_null_po=
inter_dereference")            ||
> >              str_ends_with(func->name, "_4core9panicking36panic_misalig=
ned_pointer_dereference")      ||
>
> Just having "_4core9panicking" substring is not sufficient?

That prefix just means it is defined in the panicking.rs file, which
also has a few functions that are not noreturn.

Alice

