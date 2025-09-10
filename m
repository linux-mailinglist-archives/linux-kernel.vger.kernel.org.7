Return-Path: <linux-kernel+bounces-809401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626F1B50D35
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9859F17A672
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C9A2BE620;
	Wed, 10 Sep 2025 05:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpduujWN"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F1926E158;
	Wed, 10 Sep 2025 05:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481993; cv=none; b=SHRAWQqHqG+sMoOvaokYwPd1+exZJcZ/6pkgRmu0rG+aFy+C4K7lRzveoMpb9TUPoUiu292g7FRH+JhUrMG6XUb5Pog6qji3xK9hav2f4/NL1Wb6Ktt9/yhfgTcaVowsSHVVzOR5V9Lfen27aeoC0u69a8aCY9kb098afrlDfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481993; c=relaxed/simple;
	bh=4yZ2rST2UKY00muX9AES1s9/UlYmUMPjpPoQig+Ides=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psFH2akfV87IhOe2MvovFptUB124dL80fBsji4h+cI20eWMOFDa1886W3FhC7n5Wot938x7q/6kv0IfHv2EsikelAfQag68zhXc38aZlMDgAD8efFmoVp121yGL3GV/I6TxJUM/wCRrfdiAHE5A6Q58ljD91oFmDBQr+nCu6GBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpduujWN; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b548745253so90109901cf.0;
        Tue, 09 Sep 2025 22:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757481990; x=1758086790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyr+IV7FPCVHdaf8zRYY227vT7ziTmzHtwDgeVYUzYw=;
        b=KpduujWN6giRRsESm+C0mfHW9+gqEeCuf+sfzUdW6RdFCoYvVEqcPIG03Whl7LL09h
         EGM7rIhSAWJowxzrlfG+QTwG9yaT+6hNE8bV/W64zOjrHavC7PsUzd10r9NizzG2b+PS
         JU/LWpPxMcF9BrY+7ZIUrquNXHsg9nlFmF1bMANRDtvgC8izkOGK3HHZyMiaoFMWiHuE
         YdCUoepkdHn3v1mg7f6wKHvdCcjkJqChNsWHfObLfGTdHzlXw4MnWvdo4zlhYfQX+sMV
         ++0hCQ/7IINv0H9PZRUpRdSyLLH74O9xJ7/ULXdr8+e07MTvjPPrbx+jOgA5aWDl9xHh
         HQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757481990; x=1758086790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyr+IV7FPCVHdaf8zRYY227vT7ziTmzHtwDgeVYUzYw=;
        b=ieE6cVpVDOaTUQUvISJX4SJ9WJcXpouDNKqLy0RG3Waufbx6X3m4TI9v5gvxDzjtwF
         FdMCOqcYqBfyy5igecQK9cHviFg31uS/3paZ4hWI0vr+oZX2e4YrMdPJzcEFh7DgUDkS
         2LjcTjMji2LC/Dhqhh6yjZM5WxATmsiPdMtgChr8YVzbmJRzDMiar2/JXj/nCsDpOWIP
         HOCri6pHZxdbiiw4uHL1dmIjF6NnQaIr/T+HCaRQjJkySjNFht39kU+jVq5xGZTtx3U4
         jGF6qXS4VWrPCO8s2Mv91ngTN1Du7mBci9bhf72EanZANKcNkh8wGGZRUQ7n5j8rbKXX
         Z1gA==
X-Forwarded-Encrypted: i=1; AJvYcCVbBd5gvd9jla0q2r3cno5f/DfwkY/S6tagX5tRImjlhbo7D2EJrZTEg8wUNu7psPp0gatAvSwuMbdcX5ZO11A=@vger.kernel.org, AJvYcCVw3KMlwZJ18YssPsS08bdpyjQNHzxltvnc44/1DxAlU7Mbq43mtwm48DOFTiOcqYUJTTCNzuEpoDsLoyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTobDDi4MHALxTO08Z5q36yWasDQa0QVEaekJCl9FPK2saG0Pw
	jgNl5XVxb7MMBrGhNQ8KUm0KNG4Uo6hOl3Oiml2/vHgplxiPNUvwDQ3/
X-Gm-Gg: ASbGncvreiIjx2Fe4UB0BYTN61rYAWS7mv7wlgnIVC3PzaRFxoTGZ+ovAHqcNqOKmax
	nYx1AFB6yj3b/aEIYAsUbV97sRYD45HxCBBb8s0O8i14RhNRuh7/p9+O8JdzCsyaFnOxe1WQZ/m
	radwpM9BZEW/IdNOafTAadCT21O4P1LAa97w+G+/ycpM+wVWfsJcXB0FX66uglqzpLq4zlN2nOF
	uVkxxeNy3AZ6JuVGmc94Ig6LWA5J4KqfE4D4+jcJFyq23tnypP/dI+S2/tQG5rtVykw8gmMDCWH
	c2AInTKtCL1I5p3r/ki9/gdybErWYb5eiwHdyDUV3dhwKPaaEuKgEQEzqFlNBulBK59b4Z0So5d
	LY2WP94UgGKf+yfqJJqNOsoyL7hnS1bogP1z6xLPQwVvDlcI0eogbr41pxlOV7UhAAlucNt20vr
	Uu9idSEVZJf8rdxNee83OWwG5ul4aK2q3Bkg==
X-Google-Smtp-Source: AGHT+IEF0d/lGD7HMmDVrWIieeymbvpb5+mbmY13DMbhG+67Dgq4CbkIaPlz3gr1N2RaPVrZm87TZQ==
X-Received: by 2002:a05:622a:199e:b0:4b5:e72d:dbbf with SMTP id d75a77b69052e-4b5f83977c2mr178929941cf.21.1757481989824;
        Tue, 09 Sep 2025 22:26:29 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720acdff859sm154428236d6.20.2025.09.09.22.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:26:29 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id E2345F40066;
	Wed, 10 Sep 2025 01:26:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 10 Sep 2025 01:26:28 -0400
X-ME-Sender: <xms:BAzBaBPs47Q1bwW3vr6hE1O7cJnCDsy_ttNn_F5fCQxO66wn-DMCPw>
    <xme:BAzBaPw1b5OcJ9MgLJd5LxZ-JFCSIiLU4XRPMMLdQK8JZLEtZ__tFryU5Ob7dn4Bf
    eP2IqteOaTl_JXIVw>
X-ME-Received: <xmr:BAzBaGuIkRjamaS87IX3VRj1IAHBkVPIwV-jt0O-VWS_bfJ1wqHWDgW9YGp0vI7wASZTneOcMPG0qFGFy6tTOvLSQ6UtqwZz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    udehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnihgvlhdrrghlmhgvih
    gurgestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehlghhirhgufihoohgusehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgig
    rdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihgh
    huohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdr
    tghomhdprhgtphhtthhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BAzBaKY8VldCosNx8PkSlTXt2OsDNV7DZEBL2_DELgc5-64rR9vOrA>
    <xmx:BAzBaN1p57o53990bpU_prGzHH0Yi3t-Xdji5ZiDaECa3gMLm3EmKA>
    <xmx:BAzBaEsRRBzH0X_-EPKNlM9Y2n67upR2-W_3cZWfTC29nUyOSJ4rZA>
    <xmx:BAzBaJCOOoLev3pnkbUXSwyCJJLDkbgc-wHZ7XdSshGk61WvpfgUgw>
    <xmx:BAzBaPYdb3bT43LN3ANZFAK6ZUc3NduGRkUfYmfbqcUlYiZcwXTXmv_s>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 01:26:28 -0400 (EDT)
Date: Tue, 9 Sep 2025 22:26:27 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: regulator: add devm_enable and
 devm_enable_optional
Message-ID: <aMEMA78TkL0jGv62@tardis-2.local>
References: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com>
 <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>

On Mon, Sep 08, 2025 at 08:10:28PM -0300, Daniel Almeida wrote:
> A lot of drivers only care about enabling the regulator for as long as
> the underlying Device is bound. This can be easily observed due to the
> extensive use of `devm_regulator_get_enable` and
> `devm_regulator_get_enable_optional` throughout the kernel.
> 
> Therefore, make this helper available in Rust. Also add an example
> noting how it should be the default API unless the driver needs more
> fine-grained control over the regulator.
> 
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  rust/helpers/regulator.c | 10 +++++++++
>  rust/kernel/regulator.rs | 58 +++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/helpers/regulator.c b/rust/helpers/regulator.c
> index cd8b7ba648ee33dd14326c9242fb6c96ab8e32a7..11bc332443bd064f4b5afd350ffc045badff9076 100644
> --- a/rust/helpers/regulator.c
> +++ b/rust/helpers/regulator.c
> @@ -40,4 +40,14 @@ int rust_helper_regulator_is_enabled(struct regulator *regulator)
>  	return regulator_is_enabled(regulator);
>  }
>  
> +int rust_helper_devm_regulator_get_enable(struct device *dev, const char *id)
> +{
> +	return devm_regulator_get_enable(dev, id);
> +}
> +
> +int rust_helper_devm_regulator_get_enable_optional(struct device *dev, const char *id)
> +{
> +	return devm_regulator_get_enable_optional(dev, id);
> +}
> +
>  #endif
> diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
> index 5ea2307f02df4a10c1c8c07b3b8c134d13519b69..d1c8c7308cdd9ae398883ddac52ff093b97764cd 100644
> --- a/rust/kernel/regulator.rs
> +++ b/rust/kernel/regulator.rs
> @@ -18,7 +18,7 @@
>  
>  use crate::{
>      bindings,
> -    device::Device,
> +    device::{Bound, Device},
>      error::{from_err_ptr, to_result, Result},
>      prelude::*,
>  };
> @@ -70,6 +70,39 @@ pub struct Error<State: RegulatorState> {
>      pub regulator: Regulator<State>,
>  }
>  
> +/// Enables a regulator whose lifetime is tied to the lifetime of `dev` through
> +/// [`devres`].

This description seems a bit wordy to me. How about "Obtains and
enables a [`devres`]-managed regulator for a device"? And if you want,
you could explain the `regulator_disable()` and `regulator_put()` in the
second paragraph.

The rest looks good to me. Feel free to add:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> +///
> +/// This calls `regulator_disable()` and `regulator_put()` automatically on
> +/// driver detach.
> +///
> +/// This API is identical to `devm_regulator_get_enable()`, and should be
> +/// preferred if the caller only cares about the regulator being on.
> +///
> +/// [`devres`]: https://docs.kernel.org/driver-api/driver-model/devres.html
> +pub fn devm_enable(dev: &Device<Bound>, name: &CStr) -> Result {
> +    // SAFETY: `dev` is a valid and bound device, while `name` is a valid C
> +    // string.
> +    to_result(unsafe { bindings::devm_regulator_get_enable(dev.as_raw(), name.as_ptr()) })
> +}
> +
> +/// Same as [`devm_enable`], but calls `devm_regulator_get_enable_optional`
> +/// instead.
> +///
> +/// This enables a regulator whose lifetime is tied to the lifetime of `dev`
> +/// through [`devres`], but does not print a message nor provides a dummy if the
> +/// regulator is not found.
> +///
> +/// This calls `regulator_disable()` and `regulator_put()` automatically on
> +/// driver detach.
> +///
> +/// [`devres`]: https://docs.kernel.org/driver-api/driver-model/devres.html
> +pub fn devm_enable_optional(dev: &Device<Bound>, name: &CStr) -> Result {
> +    // SAFETY: `dev` is a valid and bound device, while `name` is a valid C
> +    // string.
> +    to_result(unsafe { bindings::devm_regulator_get_enable_optional(dev.as_raw(), name.as_ptr()) })
> +}
> +
>  /// A `struct regulator` abstraction.
>  ///
>  /// # Examples
> @@ -146,6 +179,29 @@ pub struct Error<State: RegulatorState> {
>  /// }
>  /// ```
>  ///
> +/// If a driver only cares about the regulator being on for as long it is bound
> +/// to a device, then it should use [`devm_enable`] or [`devm_enable_optional`].
> +/// This should be the default use-case unless they need more fine-grained
> +/// control over the regulator's state.
> +///
> +/// [`devm_enable`]: crate::regulator::devm_enable
> +/// [`devm_optional`]: crate::regulator::devm_enable_optional
> +///
> +/// ```
> +/// # use kernel::prelude::*;
> +/// # use kernel::c_str;
> +/// # use kernel::device::{Bound, Device};
> +/// # use kernel::regulator;
> +/// fn enable(dev: &Device<Bound>) -> Result {
> +///     // Obtain a reference to a (fictitious) regulator and enable it. This
> +///     // call only returns whether the operation succeeded.
> +///     regulator::devm_enable(dev, c_str!("vcc"))?;
> +///
> +///     // The regulator will be disabled and put when `dev` is unbound.
> +///     Ok(())
> +/// }
> +/// ```
> +///
>  /// ## Disabling a regulator
>  ///
>  /// ```
> 
> -- 
> 2.51.0
> 

