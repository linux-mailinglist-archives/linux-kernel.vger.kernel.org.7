Return-Path: <linux-kernel+bounces-828938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDD1B95E47
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA052E4E87
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7861324B12;
	Tue, 23 Sep 2025 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FW2I1bxo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C696320380;
	Tue, 23 Sep 2025 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632119; cv=none; b=l7vej3Z5agljAPn/ud4JGTZhKnBc65EIF0xfTb3d7qCCEtNErwcUNdxBqWfVnkXA//XlrYyUGYebAwuYLsUpN7zUCHjeEMwdow07b5/jsItc40dgdCA16fRIKRX3rdVqjr/kD1DcmbvM3p++E/M98v9Qi/pl48byWGWxMebVF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632119; c=relaxed/simple;
	bh=ME3qBbegNDpQuw1mbSTRNM6utlqztErhmAOvHV8ivf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PF2xO5hPsSA/q9BjrceaLRgW+LHzyxyMBC/SaJSqcjNdl4gsoAHsaqcd3LHXi73Jh/FGEif6+PtivPccG0MJNJ/dtbWI0O7M2SvSAigz5+WmlmPBFL+uMCVa1YlVLCJ4CjhaK7wQsTg33pCS2G5QzfE5r46Ox+fqOnkTBhroMFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FW2I1bxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62632C113CF;
	Tue, 23 Sep 2025 12:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758632119;
	bh=ME3qBbegNDpQuw1mbSTRNM6utlqztErhmAOvHV8ivf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FW2I1bxo+4X+7TyFN3n0zWaVEr5KpqFYnZdAVnJVaXmixF0PbegK7/OoEkC9/Fv3P
	 Ei6xWxPLAfNvdCnvdNUDo5SRgWqnfMlMajX9kCS+zVLwZbolM3JbcR8ygl8zdIkFVQ
	 w4tLxJDaJQkkJTnv6CUGPiv6FctfuBn6RaAhokv4=
Date: Tue, 23 Sep 2025 14:41:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/2] rust: usb: add initial USB abstractions
Message-ID: <2025092333-happening-eggnog-66ce@gregkh>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <2025092338-elbow-dash-373d@gregkh>
 <CAH5fLghm-syjWRrj=G2==W4PorPq47bkAPfkeJ1UAsGbbRhPfQ@mail.gmail.com>
 <B4D07104-0A10-4B04-88CC-3F138A783811@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B4D07104-0A10-4B04-88CC-3F138A783811@collabora.com>

On Tue, Sep 23, 2025 at 02:34:27PM +0200, Daniel Almeida wrote:
> […]
> 
> >> 
> >> I tried to apply these, but I get the following build error when adding
> >> to the char-misc-testing tree:
> >> 
> >> ld.lld: error: undefined symbol: usb_get_intf
> >>>>> referenced by kernel.1a949e63ee2acc6a-cgu.0
> >>>>>              rust/kernel.o:(<kernel::usb::Interface as kernel::sync::aref::AlwaysRefCounted>::inc_ref) in archive vmlinux.a
> >>>>> referenced by kernel.1a949e63ee2acc6a-cgu.0
> >>>>>              rust/kernel.o:(<kernel::sync::aref::ARef<kernel::usb::Interface> as core::convert::From<&kernel::usb::Interface<kernel::device::CoreInternal>>>::from) in archive vmlinux.a
> >> 
> >> ld.lld: error: undefined symbol: usb_put_intf
> >>>>> referenced by kernel.1a949e63ee2acc6a-cgu.0
> >>>>>              rust/kernel.o:(<kernel::usb::Interface as kernel::sync::aref::AlwaysRefCounted>::dec_ref) in archive vmlinux.a
> >> 
> >> ld.lld: error: undefined symbol: usb_get_dev
> >>>>> referenced by kernel.1a949e63ee2acc6a-cgu.0
> >>>>>              rust/kernel.o:(<kernel::usb::Device as kernel::sync::aref::AlwaysRefCounted>::inc_ref) in archive vmlinux.a
> >>>>> referenced by kernel.1a949e63ee2acc6a-cgu.0
> >>>>>              rust/kernel.o:(<kernel::sync::aref::ARef<kernel::usb::Device> as core::convert::From<&kernel::usb::Device<kernel::device::CoreInternal>>>::from) in archive vmlinux.a
> >> 
> >> ld.lld: error: undefined symbol: usb_put_dev
> >>>>> referenced by kernel.1a949e63ee2acc6a-cgu.0
> >>>>>              rust/kernel.o:(<kernel::usb::Device as kernel::sync::aref::AlwaysRefCounted>::dec_ref) in archive vmlinux.a
> >> 
> >> 
> >> Any hints?
> > 
> > Did you enable CONFIG_USB?
> > 
> > Alice
> 
> +#[cfg(CONFIG_USB)]
> +pub mod usb;
> 
> Hmm, but the USB module is gated by #[cfg(CONFIG_USB) in lib.rs, so not having
> CONFIG_USB enabled should not return any errors and instead skip the USB
> bindings completely.
> 
> I wonder if this has to be CONFIG_USB=y?

It passes if CONFIG_USB=y, but it is good to keep the USB subsystem as a
module if at all possible :)

thanks,

greg k-h

