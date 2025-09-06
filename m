Return-Path: <linux-kernel+bounces-804223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F69DB46D80
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A1FD7B4F87
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4898A2882BD;
	Sat,  6 Sep 2025 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wedqjB07"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9031D63F7;
	Sat,  6 Sep 2025 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164039; cv=none; b=PZ9kkanLW/54MP9nRE8jVq8B+a8bdIS3qp9uOB/wfybgp2T77MXHtCHTr0Kew/7RZ/h4LkVRs4luCAmIfUP8G14X3r9gY36E7pe5Ddl2IkaBwjDzoOz91uJrJiTt9J4hXuMGlte12aXjBBQL9NfLymHEhbs7rMtOsr+7xVHyBmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164039; c=relaxed/simple;
	bh=+SZwj8lw7NxyxU3M9m+UF/qjXAIvROvSpjknCmyQc7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJw+VPT10qbsf1QeoikxyX1hLV9hEyzXVtAYXyGpLCfb13nuj5BeNPqno/XociqYH9xP0YuZ8pz9hkxrJln4Iawwr1a508zjaA/LPApaKRfc+22bwTEXxVNlDaBNNX37u76po9AQfyfbvxh3JU9558/CVL+onuiUZS15O4Kj7L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wedqjB07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670CCC4CEE7;
	Sat,  6 Sep 2025 13:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757164039;
	bh=+SZwj8lw7NxyxU3M9m+UF/qjXAIvROvSpjknCmyQc7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wedqjB071dfq4TXHKcymLgsE00uIeI1B3BFmQ+pBpWqFct88YsDXKhaUfPUkFqG1V
	 hlDNDfJvo9gQqiEv+O24kIy4ovJMyWUCPF4qAjWbvvuBES3uX6Vw91wgGuhdVrbc2h
	 Lpo2MPrbwVKjNFyOOErvZSZpHNE2sCrZsKXZGfvI=
Date: Sat, 6 Sep 2025 15:07:16 +0200
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
Message-ID: <2025090629-economy-geologist-3548@gregkh>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-2-7aa024de7ae8@collabora.com>
 <2025090618-smudgy-cringing-a7a4@gregkh>
 <D8EAF874-4FED-42EE-8FD8-E89B6CB0086A@collabora.com>
 <2025090601-iron-glitter-c77d@gregkh>
 <831C4AE2-6964-4699-9E74-E4B721B87B17@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <831C4AE2-6964-4699-9E74-E4B721B87B17@collabora.com>

On Sat, Sep 06, 2025 at 09:41:16AM -0300, Daniel Almeida wrote:
> 
> 
> >> 
> >> I thought that an iterative approach would work here, i.e.: merge this, then
> >> URBs, then more stuff, etc.
> > 
> > Ah, that makes sense, I didn't realize you want that here.  What USB
> > device do you want to write a rust driver for?  Are you going to need
> > bindings to the usb major number, or is it going to talk to some other
> > subsystem instead?
> > 
> > Right now, these bindings don't really do anything USB specific at all
> > except allow a driver to bind to a device.
> > 
> > thanks,
> > 
> > greg k-h
> 
> To be honest, I'm trying to pave the way for others.
> 
> I often hear people saying that they would look into Rust drivers if only they
> did not have to write all the surrounding infrastructure themselves. On the
> other hand, there is no infrastructure because there are no drivers. It's a
> chicken and egg problem that I am trying to solve.

Sure, but a framework like this (probe/disconnect), really isn't USB,
it's just driver core stuff :)

> It's also a cool opportunity to learn about USB, but I don't have any plans
> for a driver at the moment other than a instructional sample driver in Rust.

Then let's not add bindings without a real user please.  We don't want
to maintain them for no good reason.

> Give me a few more weeks and I'll come up with the code for the other things
> you've pointed out.
> 
> By the way, I wonder how testing would work. I tested this by plugging in my
> mouse and fiddling around with /sys/bus/usb/drivers/rust_driver_usb/new_id. I
> am not sure how this is going to work once I start looking into data transfer
> and etc. Perhaps there's a simple device out there that I should target? Or
> maybe there's a way to "fake" a USB device that would work with the sample
> driver for demonstration purposes.

You can use the usb-gadget subsystem and dummy-hcd to create a loop-back
for a virtual USB device.  That's how syzbot does USB driver fuzz
testing, there should be some documentation on that somewhere in the
tree.

thanks

greg k-h

