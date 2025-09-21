Return-Path: <linux-kernel+bounces-826188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 056FCB8DCA3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 15:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9626189E54A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434A6274B28;
	Sun, 21 Sep 2025 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSPYZM7Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B124146588;
	Sun, 21 Sep 2025 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758462483; cv=none; b=NHA0uV09Kxli6NUlvzoBQS7IL/gtwpzntWwVSO+hF7vAnfYDQQRLyldOHqqDWPnNHDu8oRpRBySSEmb4Ix5yyg7VojUV/ygbk5rP7m+ixIq9jKkrdrpHWJPl9ri7PRymkkHg3W38q/AQuqC99LyjmmfCT+iqR+vouJ9mAE/1YpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758462483; c=relaxed/simple;
	bh=WaSzBYYm7PaYd/6yU5zaiRxWjqVCre7xn6qFahF6TT0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=GJRzkbLt00uv8RUUy833sOAp94tKFGJwmPQr8LA87YuS7GoHjZ3//pVN5C0VayR4x9In9lKmD0hIHBkdivuYpN0bPuCN2cgNAXZFlaA/M1WZqWOg3pS9Hm8FXEbdzTX82syU88K1rQnyKsMS5iu04THAkTgowtDWBcl2ClaYXxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSPYZM7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B4BC4CEE7;
	Sun, 21 Sep 2025 13:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758462482;
	bh=WaSzBYYm7PaYd/6yU5zaiRxWjqVCre7xn6qFahF6TT0=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=lSPYZM7YBjQ02SeKD+OEOEKo/Iw/EV2PBWqmOPS/DK1hpYy3gByOSgccuVuYAHY9h
	 AijapyhOCr4JHrKzuEbm+x2Kg36L+oHphcpQLvrx63sFCYUHfXX5wNaRdjEcUKQ/54
	 vQAe4OCC0pXfVUBHQ6f8Q5DTMUlQJhDDxF3Ek9MfF3jtq56pV1TNm6eP0h16eqxXYG
	 0FuMDmLzjOeMdYncyof1bhdYzdGnGJLzvp9ZyPUGrD3tgiEzgwaGh/4PrBbgNZBoch
	 4dj2iHfkZc3YhyX4qaEcIMuCo9t4qTGX4+9ADvlZbyGEYOZT0KXZNliyDx1MO/Db1f
	 ZBh0w1GO1swkw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Sep 2025 15:47:55 +0200
Message-Id: <DCYIX8URVIWM.2ZK3GHH3J82XQ@kernel.org>
To: "Greg KH" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 1/6] nova-core: bitfield: Move bitfield-specific code
 from register! into new macro
Cc: "Benno Lossin" <lossin@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <acourbot@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <joel@joelfernandes.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>, "Yury
 Norov" <yury.norov@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, <nouveau@lists.freedesktop.org>
References: <20250920182232.2095101-1-joelagnelf@nvidia.com>
 <20250920182232.2095101-2-joelagnelf@nvidia.com>
 <2025092157-pauper-snap-aad1@gregkh>
 <DCYHCLM67KRZ.366VS9PDKLYKY@kernel.org>
 <2025092125-urban-muppet-1c2f@gregkh>
In-Reply-To: <2025092125-urban-muppet-1c2f@gregkh>

On Sun Sep 21, 2025 at 2:45 PM CEST, Greg KH wrote:
> Again, regmap handles this all just fine, why not just make bindings to
> that api here instead?

The idea is to use this for the register!() macro, e.g.

	register!(NV_PMC_BOOT_0 @ 0x00000000, "Basic revision information about th=
e GPU" {
	    28:24   architecture_0 as u8, "Lower bits of the architecture";
	    23:20   implementation as u8, "Implementation version of the architect=
ure";
	    8:8     architecture_1 as u8, "MSB of the architecture";
	    7:4     major_revision as u8, "Major revision of the chip";
	    3:0     minor_revision as u8, "Minor revision of the chip";
	});

(More examples in [1].)

This generates a structure with the relevant accessors; we can also impleme=
nt
additional logic, such as:

	impl NV_PMC_BOOT_0 {
	    /// Combines `architecture_0` and `architecture_1` to obtain the archi=
tecture of the chip.
	    pub(crate) fn architecture(self) -> Result<Architecture> {
	        Architecture::try_from(
	            self.architecture_0() | (self.architecture_1() << Self::ARCHIT=
ECTURE_0_RANGE.len()),
	        )
	    }
=09
	    /// Combines `architecture` and `implementation` to obtain a code uniq=
ue to the chipset.
	    pub(crate) fn chipset(self) -> Result<Chipset> {
	        self.architecture()
	            .map(|arch| {
	                ((arch as u32) << Self::IMPLEMENTATION_RANGE.len())
	                    | u32::from(self.implementation())
	            })
	            .and_then(Chipset::try_from)
	    }
	}

This conviniently allows us to read the register with

	let boot0 =3D regs::NV_PMC_BOOT_0::read(bar);

and obtain an instance of the entire Chipset structure with

	let chipset =3D boot0.chipset()?;

or pass it to a constructor that creates a Revision instance

	let rev =3D Revision::from_boot0(boot0);

Analogously it allows us to modify and write registers without having to me=
ss
with error prone shifts, masks and casts, because that code is generated by=
 the
register!() macro. (Of course, unless we have more complicated cases where
multiple fields have to be combined as illustrated above.)

Note that bar is of type pci::Bar<BAR0_SIZE> where BAR0_SIZE in our case is
SZ_16M.

However, the type required by read() as generated by the register!() macro
actually only requires something that implements an I/O backend, i.e
kernel::io::Io<SIZE>.

pci::Bar is a specific implementation of kernel::io::Io.

With this we can let the actual I/O backend handle the endianness of the bu=
s.

(Actually, we could even implement an I/O backend that uses regmap.)

So, I think the register!() stuff is rather orthogonal.

- Danilo

[1] https://gitlab.freedesktop.org/drm/rust/kernel/-/blob/drm-rust-next/dri=
vers/gpu/nova-core/regs.rs

