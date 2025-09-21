Return-Path: <linux-kernel+bounces-826158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C93B8DB40
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 14:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7CD441117
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 12:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FCB2D0630;
	Sun, 21 Sep 2025 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LQROPRi4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452DB26D4ED;
	Sun, 21 Sep 2025 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758458730; cv=none; b=mcoODTMPf084mzH5wWm+zYvWAEphW5X/N2ftaErnDKQIu3nFizy5qENYhBeB+LrrIkKX4XmBZ2c9exEE1W+uvdaOZVAtxcAoCxTkXWx0uxZFylMFqgpCJwa5FZU08hoPQxbGsZOZaUI+w3WE4upsBmm/a7bRgr49RKaQ1Vtze2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758458730; c=relaxed/simple;
	bh=huQmlHKRTQZek7WYSnFFmutaGBi6vQEpnrzRtyNwm2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isdZGcnC1RjQkBDc/XX+EaRpqPwjrPhqh9p3gGuK396jScSrPdkg0Waw2zbMvryg1kObCecB79Vc+Bk8lIvmkgzFnMNN9+Lompx9oJg6zgukg+voxKD04jWcRztP1NX5VOCkkOkekbx9AJSPTwVY7eINbwsIy7WXHYk9gdycuYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LQROPRi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEBCC4CEE7;
	Sun, 21 Sep 2025 12:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758458729;
	bh=huQmlHKRTQZek7WYSnFFmutaGBi6vQEpnrzRtyNwm2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LQROPRi4nwu0JZhMCC2VI5+xAcmCIDjJBJ9LJvAXrzv/HxMAVfBaJHO2Ztz42Sxn+
	 uEkkLujhLgCFlgaKoGqYNrd/BY3okpCiPaP7eDQveqoFh25vUSgBdyzlfjytSsajO3
	 qo5Jo6joHrY+0/vyGj18NiER0T9AGA8kaqrohCSg=
Date: Sun, 21 Sep 2025 14:45:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Benno Lossin <lossin@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
	dakr@kernel.org, acourbot@nvidia.com,
	Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com, Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>,
	Yury Norov <yury.norov@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	nouveau@lists.freedesktop.org
Subject: Re: [PATCH v4 1/6] nova-core: bitfield: Move bitfield-specific code
 from register! into new macro
Message-ID: <2025092125-urban-muppet-1c2f@gregkh>
References: <20250920182232.2095101-1-joelagnelf@nvidia.com>
 <20250920182232.2095101-2-joelagnelf@nvidia.com>
 <2025092157-pauper-snap-aad1@gregkh>
 <DCYHCLM67KRZ.366VS9PDKLYKY@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCYHCLM67KRZ.366VS9PDKLYKY@kernel.org>

On Sun, Sep 21, 2025 at 02:33:56PM +0200, Benno Lossin wrote:
> On Sun Sep 21, 2025 at 11:36 AM CEST, Greg KH wrote:
> > On Sat, Sep 20, 2025 at 02:22:27PM -0400, Joel Fernandes wrote:
> >> The bitfield-specific into new macro. This will be used to define
> >> structs with bitfields, similar to C language.
> >> 
> >> Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
> >> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> >> ---
> >>  drivers/gpu/nova-core/bitfield.rs    | 314 +++++++++++++++++++++++++++
> >>  drivers/gpu/nova-core/nova_core.rs   |   3 +
> >>  drivers/gpu/nova-core/regs/macros.rs | 259 +---------------------
> >>  3 files changed, 327 insertions(+), 249 deletions(-)
> >>  create mode 100644 drivers/gpu/nova-core/bitfield.rs
> >> 
> >> diff --git a/drivers/gpu/nova-core/bitfield.rs b/drivers/gpu/nova-core/bitfield.rs
> >> new file mode 100644
> >> index 000000000000..ba6b7caa05d9
> >> --- /dev/null
> >> +++ b/drivers/gpu/nova-core/bitfield.rs
> >> @@ -0,0 +1,314 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +//! Bitfield library for Rust structures
> >> +//!
> >> +//! Support for defining bitfields in Rust structures. Also used by the [`register!`] macro.
> >> +//!
> >> +//! # Syntax
> >> +//!
> >> +//! ```rust
> >> +//! #[derive(Debug, Clone, Copy)]
> >> +//! enum Mode {
> >> +//!     Low = 0,
> >> +//!     High = 1,
> >> +//!     Auto = 2,
> >> +//! }
> >> +//!
> >> +//! impl TryFrom<u8> for Mode {
> >> +//!     type Error = u8;
> >> +//!     fn try_from(value: u8) -> Result<Self, Self::Error> {
> >> +//!         match value {
> >> +//!             0 => Ok(Mode::Low),
> >> +//!             1 => Ok(Mode::High),
> >> +//!             2 => Ok(Mode::Auto),
> >> +//!             _ => Err(value),
> >> +//!         }
> >> +//!     }
> >> +//! }
> >> +//!
> >> +//! impl From<Mode> for u32 {
> >> +//!     fn from(mode: Mode) -> u32 {
> >> +//!         mode as u32
> >> +//!     }
> >> +//! }
> >> +//!
> >> +//! #[derive(Debug, Clone, Copy)]
> >> +//! enum State {
> >> +//!     Inactive = 0,
> >> +//!     Active = 1,
> >> +//! }
> >> +//!
> >> +//! impl From<bool> for State {
> >> +//!     fn from(value: bool) -> Self {
> >> +//!         if value { State::Active } else { State::Inactive }
> >> +//!     }
> >> +//! }
> >> +//!
> >> +//! impl From<State> for u32 {
> >> +//!     fn from(state: State) -> u32 {
> >> +//!         state as u32
> >> +//!     }
> >> +//! }
> >> +//!
> >> +//! bitfield! {
> >> +//!     struct ControlReg {
> >> +//!         3:0       mode        as u8 ?=> Mode;
> >> +//!         7         state       as bool => State;
> >> +//!     }
> >> +//! }
> >
> > As discussed at the conference this week, I do object to this as it
> > will allow the same mistakes to happen that we used to do in the kernel
> > for a long time before the regmap() api happened, along with GENMASK().
> 
> Have you read the following macro arm of the implementation?
> 
>     // Generates the accessor methods for a single field.
>     (
>         @leaf_accessor $name:ident $hi:tt:$lo:tt $field:ident
>             { $process:expr } $to_type:ty => $res_type:ty $(, $comment:literal)?;
>     ) => {
>         ::kernel::macros::paste!(
>         const [<$field:upper _RANGE>]: ::core::ops::RangeInclusive<u8> = $lo..=$hi;
>         const [<$field:upper _MASK>]: u32 = ((((1 << $hi) - 1) << 1) + 1) - ((1 << $lo) - 1);
>         const [<$field:upper _SHIFT>]: u32 = Self::[<$field:upper _MASK>].trailing_zeros();
>         );
>     
>         $(
>         #[doc="Returns the value of this field:"]
>         #[doc=$comment]
>         )?
>         #[inline(always)]
>         pub(crate) fn $field(self) -> $res_type {
>             ::kernel::macros::paste!(
>             const MASK: u32 = $name::[<$field:upper _MASK>];
>             const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
>             );
>             let field = ((self.0 & MASK) >> SHIFT);
> 
> Here you can see that it's just a mask + shift operation internally to
> access the field.
>     
>             $process(field)
>         }
>     
>         ::kernel::macros::paste!(
>         $(
>         #[doc="Sets the value of this field:"]
>         #[doc=$comment]
>         )?
>         #[inline(always)]
>         pub(crate) fn [<set_ $field>](mut self, value: $to_type) -> Self {
>             const MASK: u32 = $name::[<$field:upper _MASK>];
>             const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
>             let value = (u32::from(value) << SHIFT) & MASK;
>             self.0 = (self.0 & !MASK) | value;
>     
>             self
>         }
>         );
>     };

Yes, that's great, but that is all done in "native cpu" endian, and
might not actually represent what the hardware does at all, which is
what I was trying to get at here, sorry for not being more specific.

> Now I too would like to see how exactly this will be used to read data
> from hardware. But at least in theory if the conversion from hardware
> endianness to native endianness is done correctly, this will do the
> right thing :)

That's great, so we are close, but it's not quite correct.  How about
something like:

	0:7	reg_X	as __le32
	8:15	reg_y	as __le32

and the like.  There has to be a way to actually specify the
representation here and for C, that is using the "__" types that express
the endianness (i.e. __le32, __be32, and so on).  Then we have type
checks that enforce accesses to those variables to always turn the data
into "native" values when the cpu accesses them.

Again, regmap handles this all just fine, why not just make bindings to
that api here instead?

thanks,

greg k-h

