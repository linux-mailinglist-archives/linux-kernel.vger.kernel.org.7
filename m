Return-Path: <linux-kernel+bounces-828937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AE0B95E41
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DC5177BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6984A323F78;
	Tue, 23 Sep 2025 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VPcgIzte"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC64721D3E6;
	Tue, 23 Sep 2025 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632117; cv=none; b=UErh33wzHoxsxx2EDCiGIilC3y7WaDwx0wowzqiFVXo7R17Ic2v4bV9Ff0tJR16NAPabN5cXgNotE7mpTI9JqXePeewcVvphvx5g8q968K3WUBTOFPgACjU/57NzV6n6H8z/vkSts0tDdADJtQmqHb7i3+JHrb1mus869OXhXLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632117; c=relaxed/simple;
	bh=pglM4rtOc+GxiNFy55yLqLYSq58E3VRrs1oRiRH5HLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ru//9NL1NIzncwvCoj2tOQvr5Ivhv2VbtcvRk2pahcKc/rSpKyivU/MYfSijMn2Gi1LedKEXnfyyqOQoC8Z0t1YQIQeXjenqLPbMCXyfJqYXs1CzA27k1Q4gnVubx/zKfrzbijmHTyVQVia6vglUQnQWmeNkEucrXgDB8EhOEj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VPcgIzte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4839C4CEF5;
	Tue, 23 Sep 2025 12:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758632115;
	bh=pglM4rtOc+GxiNFy55yLqLYSq58E3VRrs1oRiRH5HLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VPcgIzte/Pnz+35FtOdrKPFwKCM1TMPYW8eic7hpzrHs3EKhQP7Sn5Jq2e4T1jrjC
	 Bve7KqpHLKfRheQAUyTyNThqLviVG8EphZmqjzbV8FOU7r+l4moNGyxuhbcopGkD7D
	 oaut68iMjXg613ExUr7bFPTNgALA2ohk75olJ9uc=
Date: Tue, 23 Sep 2025 14:31:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/2] rust: usb: add initial USB abstractions
Message-ID: <2025092310-amiable-overflow-1614@gregkh>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <2025092338-elbow-dash-373d@gregkh>
 <CAH5fLghm-syjWRrj=G2==W4PorPq47bkAPfkeJ1UAsGbbRhPfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghm-syjWRrj=G2==W4PorPq47bkAPfkeJ1UAsGbbRhPfQ@mail.gmail.com>

On Tue, Sep 23, 2025 at 02:29:00PM +0200, Alice Ryhl wrote:
> On Tue, Sep 23, 2025 at 2:05 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Aug 25, 2025 at 03:18:04PM -0300, Daniel Almeida wrote:
> > > This adds initial support for USB Rust drivers, not only because I see a
> > > widespread use of module_usb_driver() in media (which is a subsystem I
> > > aim to support) but also because I want to learn about USB in general
> > > and this is a nice opportunity to start doing so.
> > >
> > > I tried to keep things as consistent with pci.rs and platform.rs as
> > > possible and tested it by manually binding a device (i.e.: my Logitech
> > > mouse) to the sample driver via:
> > >
> > > /sys/bus/usb/drivers/rust_driver_usb/new_id
> > >
> > > This initial patch is therefore comprised of the same patterns that are
> > > known to work for pci and platform already.
> > >
> > > Physically disconnecting the device also worked, i.e.: nothing bad
> > > showed up in dmesg.
> > >
> > > Note that I did not touch MAINTAINERS at all. The objective is to
> > > kickstart the discussion of what to do there here in v1.
> >
> > I tried to apply these, but I get the following build error when adding
> > to the char-misc-testing tree:
> >
> > ld.lld: error: undefined symbol: usb_get_intf
> > >>> referenced by kernel.1a949e63ee2acc6a-cgu.0
> > >>>               rust/kernel.o:(<kernel::usb::Interface as kernel::sync::aref::AlwaysRefCounted>::inc_ref) in archive vmlinux.a
> > >>> referenced by kernel.1a949e63ee2acc6a-cgu.0
> > >>>               rust/kernel.o:(<kernel::sync::aref::ARef<kernel::usb::Interface> as core::convert::From<&kernel::usb::Interface<kernel::device::CoreInternal>>>::from) in archive vmlinux.a
> >
> > ld.lld: error: undefined symbol: usb_put_intf
> > >>> referenced by kernel.1a949e63ee2acc6a-cgu.0
> > >>>               rust/kernel.o:(<kernel::usb::Interface as kernel::sync::aref::AlwaysRefCounted>::dec_ref) in archive vmlinux.a
> >
> > ld.lld: error: undefined symbol: usb_get_dev
> > >>> referenced by kernel.1a949e63ee2acc6a-cgu.0
> > >>>               rust/kernel.o:(<kernel::usb::Device as kernel::sync::aref::AlwaysRefCounted>::inc_ref) in archive vmlinux.a
> > >>> referenced by kernel.1a949e63ee2acc6a-cgu.0
> > >>>               rust/kernel.o:(<kernel::sync::aref::ARef<kernel::usb::Device> as core::convert::From<&kernel::usb::Device<kernel::device::CoreInternal>>>::from) in archive vmlinux.a
> >
> > ld.lld: error: undefined symbol: usb_put_dev
> > >>> referenced by kernel.1a949e63ee2acc6a-cgu.0
> > >>>               rust/kernel.o:(<kernel::usb::Device as kernel::sync::aref::AlwaysRefCounted>::dec_ref) in archive vmlinux.a
> >
> >
> > Any hints?
> 
> Did you enable CONFIG_USB?

Yes, CONFIG_USB=m



