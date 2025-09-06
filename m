Return-Path: <linux-kernel+bounces-804194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D08B46C6F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26F41898FC4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76692877F7;
	Sat,  6 Sep 2025 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MyJ3NIWb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0941C6FF6;
	Sat,  6 Sep 2025 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757160604; cv=none; b=m/O/GXOVL2udgd/qSaSxQapwCaIv7aqMCuul1nZuLtXcM2inSQu2H6whBfthfUYyq3W2hrYIKJbfmvvf+r5hCKafhiLn+idF86qAaB+L7NitMIzgkMTd3tSxMrXSl8WjwBfbEvPDnKqP5VGUcUl2Ifsf70PzvWiGObLmaY6uqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757160604; c=relaxed/simple;
	bh=5dQ1FHAiqFGqeRjhyzOo1dwscoGiMgElpqrF9vHE2so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9iUQxLXfWTsLuiB1LDGQn6vkJKSBMHzmRmoLiE/3tXct/vH81jpwvtZ8YRDOTqA/+9J7NSdFp91ETwTXcKkHDtKhwCiWvHk8oG5hKjjCzif2OeLznoAsncvqIYdMoPf7r6Ty5bMgMtqx/65C93UY7mgurHrVpMDipNizY+XXWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MyJ3NIWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF6AC4CEE7;
	Sat,  6 Sep 2025 12:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757160603;
	bh=5dQ1FHAiqFGqeRjhyzOo1dwscoGiMgElpqrF9vHE2so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MyJ3NIWb2jxVgGJCIndaOG/g4tbN0uCN0IgYwNwoUs/CwikrdYbW07XRa60E0XvXW
	 Ggttwu4M5CsLL787HjwDASx9PSPx9p+qLUaYaY3YL7vyl/Td8Em79XEPzCYhGjAB/9
	 Xo+iZO8c5vPzmMYMuKd3v3Ldqbv3OAnKXPK13oqc=
Date: Sat, 6 Sep 2025 14:10:01 +0200
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
Subject: Re: [PATCH 2/2] samples: rust: add a USB driver sample
Message-ID: <2025090601-iron-glitter-c77d@gregkh>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-2-7aa024de7ae8@collabora.com>
 <2025090618-smudgy-cringing-a7a4@gregkh>
 <D8EAF874-4FED-42EE-8FD8-E89B6CB0086A@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D8EAF874-4FED-42EE-8FD8-E89B6CB0086A@collabora.com>

On Sat, Sep 06, 2025 at 09:04:04AM -0300, Daniel Almeida wrote:
> Hi Greg,
> 
> […]
> 
> > 
> > Sorry for the delay.
> > 
> > But these bindings really are only for a usb interface probe/disconnect
> > sequence, right?  no real data flow at all?
> > 
> > I recommend looking at the usb-skeleton.c driver, and implementing that
> > as your sample driver for rust.  That will ensure that you actually have
> > the correct apis implemented and the reference count logic working
> > properly.  You have urb anchors and callbacks and other stuff as well to
> > ensure that you get right.  That driver pretty much should handle
> > everything that you need to do to write a usb driver for any type of
> > "real" device.
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> I thought that an iterative approach would work here, i.e.: merge this, then
> URBs, then more stuff, etc.

Ah, that makes sense, I didn't realize you want that here.  What USB
device do you want to write a rust driver for?  Are you going to need
bindings to the usb major number, or is it going to talk to some other
subsystem instead?

Right now, these bindings don't really do anything USB specific at all
except allow a driver to bind to a device.

thanks,

greg k-h

