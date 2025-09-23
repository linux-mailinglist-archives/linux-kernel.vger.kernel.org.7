Return-Path: <linux-kernel+bounces-829128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF44CB96597
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310B816FDA0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0114274B5C;
	Tue, 23 Sep 2025 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="19EyBstD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7D3267714;
	Tue, 23 Sep 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638279; cv=none; b=L5YYvizD9Y3x7LSgJqf0uTBPRr9L9ISYg/U9FmsXXeqWLWM7RMRdASBc1KM5k4pbPzlb2xAZuEq5kXOoFVEfG16wJ6W5Q3aB6M6F5Kx7QYInETbLW/kXqvmqPJyqXVjR39hW9xY1cfNA17/Z16D6tIq2H37v/6ss9/Ia3i/71aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638279; c=relaxed/simple;
	bh=ySrzWqWgRs5Al/DjD2iRLdRwsWlgoAxOmYEAtqVqR4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqYTUgwPwCqEKfWO6B0adcZTKQHvDdWN5SIqVKKSi/4D4Eu+2RfKwUKHKEoinfsPj6oNkZgJoytnjSru3cKn4MIWjPK8Q+BMWyQYO4wBg8XqKnG+Yr7FqP10JFXsAofxDVeVQ+j/PNAoVKa1SodTQN0WiSzSzodmWeK2DQPbVCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=19EyBstD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DF5C19421;
	Tue, 23 Sep 2025 14:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758638279;
	bh=ySrzWqWgRs5Al/DjD2iRLdRwsWlgoAxOmYEAtqVqR4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=19EyBstDL/Ncwc5PcM6pc+DeSkKXaizUjM/Tj3vW/6pZFoI3Q2bMzKkx26Tnd0GEH
	 +A2y5A4OpDnlmFs6DBn29eLFcII1z091DqS9M+fsuCcT72slU4l3fGDhFWtWHS/aRA
	 P9ieUGF7YngkcNsn3NNrM2JAkF8zDr7Q1HT8x4dg=
Date: Tue, 23 Sep 2025 16:37:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: usb: add basic USB abstractions
Message-ID: <2025092356-glorious-unbundle-58f6@gregkh>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-1-7aa024de7ae8@collabora.com>
 <DD07LUJXNZN9.3RHH9NJNRFVNN@kernel.org>
 <2025092356-rounding-eligibly-c4b7@gregkh>
 <f5a802a4-ac9b-4b45-8d1c-871e2e06d7ac@suse.com>
 <2025092307-scoop-challenge-4054@gregkh>
 <13ce0ad0-f0d5-4579-9a48-db727baa177f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13ce0ad0-f0d5-4579-9a48-db727baa177f@kernel.org>

On Tue, Sep 23, 2025 at 04:25:46PM +0200, Danilo Krummrich wrote:
> On 9/23/25 4:22 PM, Greg Kroah-Hartman wrote:
> > On Tue, Sep 23, 2025 at 04:16:36PM +0200, Oliver Neukum wrote:
> >> On 23.09.25 16:13, Greg Kroah-Hartman wrote:
> >>
> >>> Functions like usb_fill_bulk_urb() takes a pointer to a usb_device, not
> >>> an interface.  Yes, we should fix that, but that "mistake" dates way way
> >>> way back to the original USB api decades ago.  So much so that I didn't
> >>> even remember that we used that pointer there :)
> >>
> >> How would we do that? We need to be able to send at least control
> >> request to devices before we have established which configurations
> >> or interfaces the device has.
> > 
> > Oops, I thought that usb_dev in struct usb_interface was a pointer to
> > struct usb_device, but no, it's something else...  So no, we need to
> > keep that as-is for now.
> 
> You can still get it via interface_to_usbdev(), no?

Sigh, this is what I get for writing emails while sitting in a
conference...

Yes, you are right, it can be gotten that way.  But I can't wait to see
how you wrap that C macro in rust :)

thanks,

greg k-h

