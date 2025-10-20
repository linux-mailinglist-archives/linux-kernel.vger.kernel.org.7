Return-Path: <linux-kernel+bounces-861834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A511BF3C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F0E3A2CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86752BDC15;
	Mon, 20 Oct 2025 21:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+lD1c9V"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C437D1DF985
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995858; cv=none; b=EGYvpOYsoN/a72d/sgZTDlrqsENc1LmL7PsuinPfkpSUbUUWabzQ5vix5cNRc9QK840OEQoNU5tlpT6O54RcSx03gzLBRHd7pDc1GyOSNLh8nzWpW3oIawYxrL4t3H6aK5zXkEvcAyuHsEvF1nWOaaCsk7tQRBIZ2cgJqsvPg84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995858; c=relaxed/simple;
	bh=gp/b0KsqLpgnPhP8Z/rp8/SKndJ7l3F+g4g1d9a5GZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwRudDOb02PZOYN8mTNOtsXs34b0wOcx0ZS64hcBVebtTK+OzJQ+s821vDFIabAYSiKeh1DEzY9qSkFAaxb241dU6f0iEWzhbtBRDxIBEBy+fp8Y8lzTvSC2dCGuCQqW/U8uh0560HEpBn9yFfbymcawwA8iIb7CH7+zKDQruTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+lD1c9V; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-269640c2d4bso8590455ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760995856; x=1761600656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ba6kY56LKajg5gR+mfYZ1l0Mti/V4+1lpEveR2gotOM=;
        b=d+lD1c9VFScQyTTIde9A4ObQS0UnPZOyBWxC0NlB2bcXi78V434pfh0Imz/7WXp0Jm
         sPuvs4KXxMiC9Zr4zqcqOMtYtTi3KYFfGnwLu2B4dkx9gaFjyiFfmZSEy54trQzG5Ar4
         BM407iZ8jaGFZ4wF+1pg2w4PHHrwrkXOYxs1zwEss0qVKtV/EmPUr+TwU6shhZflvomO
         iucODrogudIDUjGazbT3WYIkzVJ9ZGpaSgciY81mu8abcqXpHq6uPW/axGSsnu5ascZq
         8FJyAa6IaLzN1SJFYJfDmajEVFO4omft4/ocH4fimm0zkxOKXZ/2aTWr89Fb/8hWDbES
         I7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760995856; x=1761600656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ba6kY56LKajg5gR+mfYZ1l0Mti/V4+1lpEveR2gotOM=;
        b=SAI1gK6npfolhZqrZrA5X2NodE+BoPibMUrc8CEVfoVn5Xk9wTZ7FkdWWC8gZZu8lb
         p29Ym1oij+0RDOfVwI49SKQh6yDQOyCGrtElqcwfcypvoSbqh0Gnq2eS9MJaXHaPlGu3
         vX1x4GdOu6wogQJA1BxjmkJLr6zaU/6lyVm4H/L4b+foGAtR4NhhVobP4PfxA5dZviqb
         7ZBgMoIckZlI5312Hy5R5qNyGAXPYbg8fybOtM/gmwukP2FOHz47EZzq70cTe/5nGvwd
         Dlos/SuKMEn0+QOkXSQVu24CZkbJnslBcN27VJC8bTWFswiuC01tFaZPz7ujHnSCHE+U
         0VTQ==
X-Gm-Message-State: AOJu0YzvjhZq0prEXAesL7lOL0hFte2/ewi5QkJx1M2RJ7HBNcohK34r
	lRyx906ZtHA0INchjnsthA722nSg5Ye1i82pXlS58xnu6xwRjxW/RK90Yz/DTyP6FX1bH3Ihzx5
	CzziwMEAzn/bL46lwIeR3vn3xKcyRpK8=
X-Gm-Gg: ASbGncuwfjW3fiKQb4r/BBfT5YmRY/nKb8LhUC/YTmEFbthBZDh9+bR05qxKSY34wI6
	p4LBI8X+JO0EHkJnU7jncG+mPWmyULX4Cd3oY6pdLmK73IKJORUoLN/nMBE9gN/nrZGeOVkvdyw
	x7LV0Y+XWzFqI4X3kedg2xVCWX4UZCuGIfGEEWmWMGTqupa4mJ6ogLcvWs8tIQlORsWQ21ofl4e
	ZQUety+KgCEqsLjRbgE5Bm1Bz3XE3tTwRdZ3zyK6DkwjL3IJqBZHn3HYO65ly77qhM+6sPilyUx
	+yIx1K34BBXCu8stvUaQ4zfKVkwvDpcITdtg9iyVhcg3q9GDOus/qO5bn5+rqdFvPsMZinN4bQw
	kCBl9XETxyoM4Bw==
X-Google-Smtp-Source: AGHT+IGuIlogvO3qiXAz17lC+JAXlrcckH7vWCchmd8okkyTNJDWWsiiPF/LNLwVhABlkDWXY45TBR8ANM/9BveSOCo=
X-Received: by 2002:a17:903:8c3:b0:25a:4437:dbb7 with SMTP id
 d9443c01a7336-290c9d2debcmr99091045ad.4.1760995856042; Mon, 20 Oct 2025
 14:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020185539.49986-1-joelagnelf@nvidia.com> <20251020185539.49986-8-joelagnelf@nvidia.com>
In-Reply-To: <20251020185539.49986-8-joelagnelf@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 20 Oct 2025 23:30:43 +0200
X-Gm-Features: AS18NWBOQUVimKkWa1HJu_1dg-N_FwTUSitxLBjCaOz3GTuCAcSPB_k9_xk69eM
Message-ID: <CANiq72=SSQ5nSjt9yzX_A3Tgo2ByGM5CV0VqFnF1cTOzrZ-pbg@mail.gmail.com>
Subject: Re: [PATCH 7/7] nova-core: mm: Add data structures for page table management
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, dakr@kernel.org, acourbot@nvidia.com, 
	Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Daniel Almeida <daniel.almeida@collabora.com>, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joel,

A few nits below (I do sometimes this kind of docs review to try to
keep a consistent style across all Rust code).

On Mon, Oct 20, 2025 at 8:56=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> +//!     .set_table_frame_number(new_table.frame_number());
> +//! // Call a function to write PDE to VRAM address

Newline between these. Period ad the end.

> +//! ## Given a PTE, Get or allocate a PFN (page frame number).

In headers, no period at the end. Also, is "Get" intended to be capitalized=
?

> +//!     // Call a function to read 64-bit PTE value from VRAM address

Period at the end too (more of these elsewhere).

> +//!     if pte.valid() {
> +//!         // Return physical frame number from existing mapping
> +//!         Ok(Pfn::new(pte.frame_number()))

Early returns where possible, like in C, i.e. to avoid indentation on
big `else` branches.

> +/// Memory size constants
> +pub(crate) const KB: usize =3D 1024;
> +pub(crate) const MB: usize =3D KB * 1024;

The docs will only apply to the first item, so this probably was meant
to be a `//` instead of a `///`.

Or you could use a module to contain these (and then possibly `use`
them outside), and then you can have docs in the module itself, but
that is heavier.

> +/// Page size: 4 KiB
> +pub(crate) const PAGE_SIZE: usize =3D 4 * KB;

`rustdoc` would eventually render the value and the non-evaluated
expression, and in the source code it already says `4 * KB`, so I
think repeating the value isn't needed, unless you mean to show it is
really a multiple of 2.

> +pub(crate) enum PageTableLevel {
> +    Pdb, // Level 0 - Page Directory Base
> +    L1,  // Level 1
> +    L2,  // Level 2
> +    L3,  // Level 3 - Dual PDE (128-bit entries)
> +    L4,  // Level 4 - PTEs

In this case, I think you meant the other way around, i.e. actual
docs: `///` instead of `//`.

(Also, unless there is a particular reason (e.g. it is a big table),
please generally put comments on top of things, not at the side, which
matches closer to what is needed for docs.)

> +    /// Convert an Address to a frame number.

These should eventually be intra-doc links, but at least please use
for the moment backticks when referring to Rust items like types etc.

> +    /// # Example

We always use the plural for these section headers, even if there is a
single item (e.g. single example).

> +    /// ```no_run
> +    /// let va =3D VirtualAddress::default();
> +    /// let pte_idx =3D va.level_index(PageTableLevel::L4);
> +    /// ```

This will need some `use` lines -- not needed now, but just as a
reminder that these will get actually built eventually.

> +    /// Get raw u64 value.

Intra-doc link or at least backticks.

> +    /// The valid bit is inverted so add an accessor to flip it.
> +    pub(crate) fn set_valid(&self, value: bool) -> Pde {

This docs string sounds like a commit message.

> +/// Dual PDE at Level 3 - 128-bit entry containing both LPT and SPT poin=
ters.
> +/// Lower 64 bits =3D big/large page, upper 64 bits =3D small page.

It sounds like a few of these details should be on its own paragraph
to avoid having them in the short description (title).

> +/// // Call a function to read dual PDE from VRAM address
> +/// let mut dual_pde: DualPde =3D read_dual_pde(dpde_addr)?;
> +/// // Call a function to allocate a page table and return its VRAM addr=
ess
> +/// let spt_addr =3D allocate_page_table()?;
> +/// dual_pde.set_spt(Pfn::from(spt_addr), AperturePde::VideoMemory);
> +/// // Call a function to write dual PDE to VRAM address
> +/// write_dual_pde(dpde_addr, dual_pde)?;

Newlines before the comments, i.e. between "conceptual blocks".

> +    pub lpt: Pde, // Large/Big Page Table pointer (2MB pages) - bits 63:=
0 (lower)
> +    pub spt: Pde, // Small Page Table pointer (4KB pages) - bits 127:64 =
(upper)

Docs instead of comments.

> +    /// Check if has valid Small Page Table.

Missing word?

Thanks!

Cheers,
Miguel

