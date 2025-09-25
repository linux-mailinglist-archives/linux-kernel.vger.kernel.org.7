Return-Path: <linux-kernel+bounces-832526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA19BB9F977
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CE5C7BC385
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2364B239591;
	Thu, 25 Sep 2025 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPvEPnMC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DFF1946DA;
	Thu, 25 Sep 2025 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806970; cv=none; b=FkXGj7jK854fi26KbsgRTSGpyQMu9yptFgQ9GrVXRMw5/92nELfrMK2eIj+1yDmqQEbN6ZxmBAXBEB3a7rNqHywRiv0sQEPwW0Yfq/AItqPiiUbTnNhRRNocdeNin64e9Gk+iZDpkqx8sWQ5Aks60z9evTFU+eLaY2/RcQOaVEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806970; c=relaxed/simple;
	bh=ntsP/lf0pDuf+6FSvu7I+awI1G4RPlugS0jioDccajE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=RWjjPI3Y4dNN2rrVLN1/mv/hs7WHgQE99ILUo00ZJVeGIaBCNeJrQtPL5SmvAkW3+48nfz4p+h1IIqexbljUQ2ix7lNdMYKDL3eE/pTSbEbtP+43cKwEuKRCNMz2HK8eJLo8WuKMfkrPVS2dJL9y9AFydxaQp9Rv8rbXkN85kLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPvEPnMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75094C4CEF0;
	Thu, 25 Sep 2025 13:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758806970;
	bh=ntsP/lf0pDuf+6FSvu7I+awI1G4RPlugS0jioDccajE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=fPvEPnMCHdAYiWMVNJZ87TYkp+sBqu6O68tOjgl0rhUCt5YRNEqAdHcZNB7wVOjHa
	 jQyjA3EfIOfNeo1CU92Kl+O9zYuTpVvDEews2bfhsl3lH+2JtMe/AqLKsJuG6CHa2O
	 L0Sq4JxEIJ8WL+0bDVVSxSppYT3WmYzPhHNtdKQmuAoD9es0B5p8WkoUGxXVz0KFwM
	 J4HUMJoTubLcM4DOYHNfVxyvenAsFWsup50spHkq4k90fc33xy0AvHWXYUSozIgoie
	 GOW54VMxN4Gz28aMpKQ1KreBeF5SmTRwlbbO4sJOSApNMZCY5Tff6JCs19iWCClZr+
	 FMI/2azNJlJ5Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Sep 2025 15:29:25 +0200
Message-Id: <DD1X19KZHSEF.1W9SU66HVJM9V@kernel.org>
Subject: Re: [PATCH 0/2] rust: usb: add initial USB abstractions
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-usb@vger.kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <2025092520-sharply-everyone-4a5d@gregkh>
In-Reply-To: <2025092520-sharply-everyone-4a5d@gregkh>

On Thu Sep 25, 2025 at 2:52 PM CEST, Greg Kroah-Hartman wrote:
> Yes, this is not a normal way that bindings will probably be merged into
> the tree, but as I consulted deeply with the USB maintainer about this
> topic while eating some good Paris pizza and French wine this week while
> at the Kernel Recipes conference, I think that this deserves an
> exception as they agree this can be merged now and they will be
> responsible for any fallout.[1]

If you rather have it "staging" in-tree that's of course up to you. :)

But, I'd prefer not to expose the incorrect conversion between a
&usb::Interface<Ctx> and a &usb::Device<Ctx> for a full release in Linus' t=
ree.

Besides other implications, this conversation also implies that
&usb::Device<Core> can be derived from &usb::Interface<Core>, which semanti=
cally
means that if the USB interface's device lock is held we infer that the dev=
ice
lock of the USB device is held as well.

I know the code isn't even built, but I don't want people reading the code =
to
take wrong conclusions from that.

Also, it's dead code anyways, so maybe just apply the following hunk?

Thanks,
Danilo

diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 8899e7520b58..9bc3478cf561 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -340,18 +340,6 @@ fn as_ref(&self) -> &device::Device<Ctx> {
     }
 }

-impl<Ctx: device::DeviceContext> AsRef<Device<Ctx>> for Interface<Ctx> {
-    fn as_ref(&self) -> &Device<Ctx> {
-        // SAFETY: `self.as_raw()` is valid by the type invariants. For a =
valid interface,
-        // the helper should always return a valid USB device pointer.
-        let usb_dev =3D unsafe { bindings::interface_to_usbdev(self.as_raw=
()) };
-
-        // SAFETY: The helper returns a valid interface pointer that share=
s the
-        // same `DeviceContext`.
-        unsafe { &*(usb_dev.cast()) }
-    }
-}
-
 // SAFETY: Instances of `Interface` are always reference-counted.
 unsafe impl AlwaysRefCounted for Interface {
     fn inc_ref(&self) {


