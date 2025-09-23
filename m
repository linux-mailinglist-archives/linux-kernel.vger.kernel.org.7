Return-Path: <linux-kernel+bounces-828893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA06AB95C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6613AB5E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41046323402;
	Tue, 23 Sep 2025 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d0pypABu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5945E322C87;
	Tue, 23 Sep 2025 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758629109; cv=none; b=PfyZTHOqomhJjf5JKc1CuI737Y7SpfAdPUuCG500Mpns3tCqRMGJJRBWJG/s1XOC0Wswna2k1lOroEN4pOW6Ih2DA1fzke+0dxsU6SMsZRHB46I3R/BmVwOJSA6MZNPbWmrwrgQtiOKNottgDPZE1gINdAy79BBXpTxh3/TUNGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758629109; c=relaxed/simple;
	bh=0msSo4fg/hc2N6geIprPCq94IsgEelg6pwxGWnUqShE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iU6sedLyozqn/7VmYpkdqyzlUsjgWrE/xfIJ5/MEMMFVrEoPRPae+rE3AEi2SEXgCbmrwZedcqMujE19TCVFlgTJvU/CeuXmHvjr4gtX5BbaXRpbR2iz/0YkP3STGasvuRAHCbcQii+z1FUIcqlLpaNgM9zJw0Eqa4evp9lXGfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d0pypABu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB13C4CEF5;
	Tue, 23 Sep 2025 12:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758629108;
	bh=0msSo4fg/hc2N6geIprPCq94IsgEelg6pwxGWnUqShE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0pypABuk7z/EvZo95dllRbH144Dn1haMGtx2S4Neo1V3Fw5KAjmBf8y96WnRBYdT
	 MP4UBag1uakbGbOjXhsT3EsHTu12HeyMa62YjgXwlP0PFhprTOgfwZrBbph1WFFN78
	 5sVt1FPGH58eOfPHnfeaZrHl+4P3Y5scA5D1xgvs=
Date: Tue, 23 Sep 2025 14:05:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/2] rust: usb: add initial USB abstractions
Message-ID: <2025092338-elbow-dash-373d@gregkh>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>

On Mon, Aug 25, 2025 at 03:18:04PM -0300, Daniel Almeida wrote:
> This adds initial support for USB Rust drivers, not only because I see a
> widespread use of module_usb_driver() in media (which is a subsystem I
> aim to support) but also because I want to learn about USB in general
> and this is a nice opportunity to start doing so.
> 
> I tried to keep things as consistent with pci.rs and platform.rs as
> possible and tested it by manually binding a device (i.e.: my Logitech
> mouse) to the sample driver via:
> 
> /sys/bus/usb/drivers/rust_driver_usb/new_id
> 
> This initial patch is therefore comprised of the same patterns that are
> known to work for pci and platform already.
> 
> Physically disconnecting the device also worked, i.e.: nothing bad
> showed up in dmesg.
> 
> Note that I did not touch MAINTAINERS at all. The objective is to
> kickstart the discussion of what to do there here in v1.

I tried to apply these, but I get the following build error when adding
to the char-misc-testing tree:

ld.lld: error: undefined symbol: usb_get_intf
>>> referenced by kernel.1a949e63ee2acc6a-cgu.0
>>>               rust/kernel.o:(<kernel::usb::Interface as kernel::sync::aref::AlwaysRefCounted>::inc_ref) in archive vmlinux.a
>>> referenced by kernel.1a949e63ee2acc6a-cgu.0
>>>               rust/kernel.o:(<kernel::sync::aref::ARef<kernel::usb::Interface> as core::convert::From<&kernel::usb::Interface<kernel::device::CoreInternal>>>::from) in archive vmlinux.a

ld.lld: error: undefined symbol: usb_put_intf
>>> referenced by kernel.1a949e63ee2acc6a-cgu.0
>>>               rust/kernel.o:(<kernel::usb::Interface as kernel::sync::aref::AlwaysRefCounted>::dec_ref) in archive vmlinux.a

ld.lld: error: undefined symbol: usb_get_dev
>>> referenced by kernel.1a949e63ee2acc6a-cgu.0
>>>               rust/kernel.o:(<kernel::usb::Device as kernel::sync::aref::AlwaysRefCounted>::inc_ref) in archive vmlinux.a
>>> referenced by kernel.1a949e63ee2acc6a-cgu.0
>>>               rust/kernel.o:(<kernel::sync::aref::ARef<kernel::usb::Device> as core::convert::From<&kernel::usb::Device<kernel::device::CoreInternal>>>::from) in archive vmlinux.a

ld.lld: error: undefined symbol: usb_put_dev
>>> referenced by kernel.1a949e63ee2acc6a-cgu.0
>>>               rust/kernel.o:(<kernel::usb::Device as kernel::sync::aref::AlwaysRefCounted>::dec_ref) in archive vmlinux.a


Any hints?

thanks,

greg k-h

