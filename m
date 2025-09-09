Return-Path: <linux-kernel+bounces-807300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AE1B4A2B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0B11BC58DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B802C305065;
	Tue,  9 Sep 2025 06:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxOb+7SJ"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87B1433AC;
	Tue,  9 Sep 2025 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401030; cv=none; b=B3qBEXjifaZQzayuWusRuUnC7dB2MigeajfZkkHZgtQ2hpc5WktQFWF/3LTKUaqMu2tk8M/ucLr8vAlHHvA32tmsPMaYF3bj7pwpuT7rv7Fl9XcgKxZK3zHYmvDkCcR2vq1/eTKGthCUaVh199YMOTAmgOp3zcaPbSRliSkKQSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401030; c=relaxed/simple;
	bh=MX8kx1PFURjcrsajYuOXqj6jqPQhsIU5oON1ps0OxwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmbrxszmv6iLi5V72K44GMT5N9M6BTJMXeh5jznip+jobLg68ewugei4lPRyr9MkjyQLsKhQzBku20JD/G0lhQrbdNsX5tbxROrAv97We5MAcMhX36GnCFs1ZY8gXa6XmuH0Anj/YKp5HwLRc8E5jGohccdMusi2QhX8GLG8Iks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxOb+7SJ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-80a6937c8c6so640144285a.2;
        Mon, 08 Sep 2025 23:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757401028; x=1758005828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//MSmADP6gKCRtWELzwKMfe4T68wETkcrsk30pN5Lyc=;
        b=mxOb+7SJ+X+/wfurC5IzotC7JlkQN+A90qg9HcCrDeKzt1oSc3bdHFJicCm/NfH+Kd
         GVxTboBchCxgNpgGunRhBRMd4LF57zGyThSG78PO62zoUHB7uOhOtNQpGaxQehGHosnC
         3Kp9QgWFr8bYrdZUmd1dtQxBrMKZJed6THwwMfsYGyXxZ10BjXsCkEWcFDJXuGie++LO
         cGOFufoh2El87EohcAu3i8AxIEHvcqfHosEyaedF4OkGRepR8DRp1abkm489MHWFU8eE
         YxtrQleCsgsYNTU2gFyFtJPUIqKXzF2+OBjSRNU1kTp+Wy3R4X2PhdcwpVwOMQjn0xeR
         f3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757401028; x=1758005828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//MSmADP6gKCRtWELzwKMfe4T68wETkcrsk30pN5Lyc=;
        b=QSD4sH+UxfcJvAk5z6jWI1JHlSueqeIxiO1d+ocjfhCrBb2RF9JqPzdS0hhpM3n3dO
         NEHDKHorbb4/ZpRqyAbAPuxP/oYoWuJq7o5jEdwDEV4l9wI66eH8MBozy0PU8s2TNQSy
         Ius18eZWH99rrEHWEtD/LQsWCpvmxw6rysXHP9pElSof5pUcOG9EfqtBGFM/uUgX+iQp
         Qm1a9LWOi4kQll0wYLy7RdqI8NdhGmsyWlE2EFTOtGLS8xd55pKLu+vpUMcoqIdELLIF
         AX9C5VK1c1/GWZS4vuIV4wtu3RrmRq6uiazydM36Px+yY8L/LrxSglFxK3CklXheZs+Q
         xcbA==
X-Forwarded-Encrypted: i=1; AJvYcCWJiPnKFQ2sXnviz+SofmU0S7vDcI208s+88jjj3gJaCnWoyy/Ib5JLwa9PqRKMoI9XvN8NErvJ8whBk5s=@vger.kernel.org, AJvYcCXTmkm7fh+HIW/CPOuHF/q0NqaP+Ea/2OsUpQnRrNK4wGBwn5PjELY0Q3mKvQMMfQzLUaECTAU2K5M+3l9UzWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN+nFa5kDCGMTNfwD9tCpRWkfZwMelDDnz7owo+5V8CK7+Kb1P
	E9jS2vzOD//hGuSIrHPgOEYukCW03krIa8UZv6yR/xVEx9r6Rt9IMQt+
X-Gm-Gg: ASbGncuPp/0lqnzTivLEVLoaU8j76aXc6jJnlvUUoILb9jz1vksZYrl06C43WyuBpSU
	y5E0DBYOu0Uxn4zv4/QOvgrY27uqLHzUR2ZF0DH/l8DQPmxVVQIFqHVhxilkup5n8GBGbn2hRFb
	+5iul61cWjH+GHlg2zZgRvLpIAjoBkLactAAyXZnN2h3g2VlEKPZ07Xpacp/1c9FxavNu6jAoe7
	ivZOIAR7oVbLAz6b6jeHPpS59HdtEDCIZgTWR7y2iOMdmUjlkScucjykVuweZxmqIHrXGOEKdT8
	ET/5lHMIE/R+qC9xakfZCNPvNgL1YpGQmLBT9jkhZqXs0h/pwgCPnmcx3wQYUjXsqoB6g+3IIjE
	N5xWnekqingo1VYbuWrzpXbZ0n6guYAQ/klOdZvVgAJ7G8W3sIc6JWF50Pohn5Sb/tp5lrJSS5V
	TxkA4VwlXqHal2gFjmnWftYxMm/nMry6TmXg==
X-Google-Smtp-Source: AGHT+IFmd2lFtZzME+kOg2qHXDaRQ780Ymsaq276kO0+rpgh/CIVjsycRZ6lSSNZ7hV+wkqqfjDFgA==
X-Received: by 2002:a05:620a:190f:b0:80a:fc34:563c with SMTP id af79cd13be357-813c34d5f5bmr1023450485a.69.1757401027710;
        Mon, 08 Sep 2025 23:57:07 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b61ba6ee00sm5711991cf.5.2025.09.08.23.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 23:57:07 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id A3631F40066;
	Tue,  9 Sep 2025 02:57:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 09 Sep 2025 02:57:06 -0400
X-ME-Sender: <xms:ws-_aGuT91Veq8zg-PFZbivzMMdP7vILPicwqEsf88P4a0wWF9radQ>
    <xme:ws-_aHSGRmbqTz6alb29zc6hwf-zUIVcysd6lqEUBt-BVXC_z9kEPDUHyJrBKQj5U
    reGVXmM1kooNKgHlw>
X-ME-Received: <xmr:ws-_aIObKo8cbILCnj93--EaGhEnGC3p8rnznbxs1pbS8soakDp6FaXSn86j-07yxYu6pO0vPzmFZhxSDv9Hzljahy3chO0T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleejgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:ws-_aN7tysdN0np3AmVwiAl6XxGC_IUPP_E0p483J5WhnawKgMFBww>
    <xmx:ws-_aLUub2O05KGn3-8Csome8W9vsm3Ey4YgrhIgFUwUnEcUIpqhow>
    <xmx:ws-_aEPxDKCg8CK5YBciOYDJ_2FQbZXHtJHwJ66IaAtif45c0Qc48A>
    <xmx:ws-_aCi7mqBZ5jY9W62lpX6nhDK7CahVSXEZ48aj78cukd-oNasq9w>
    <xmx:ws-_aK6qkrm_30wUJ9R62CC-ybNrE9NE23zK5mX6N7vZVpf9UaGy5J5H>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 02:57:06 -0400 (EDT)
Date: Mon, 8 Sep 2025 23:57:05 -0700
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
Message-ID: <aL_PwXck1HsLp5wH@tardis-2.local>
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

These two functions are already EXPORT_SYMBOL_GPL(), so you won't need
to add rust_helper for them. Creating rust_helper_*() for them will just
export additional symbols.

Regards,
Boqun

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

