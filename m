Return-Path: <linux-kernel+bounces-829099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A988B96489
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017AC188819F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A375632E724;
	Tue, 23 Sep 2025 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2D8G+sOr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEABC2367D6;
	Tue, 23 Sep 2025 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637376; cv=none; b=ngeWKg3MHlAUEm5K5hs203cezRmbDEubvxZKrA0fUP5hwixaDVNcNoChSCb6RA4hjoJBvujXxJrimqmBk4Ce6993tLJseg0EjzTjqqZaKAWv6aTORg3gh9jFYc1FpDVnCRGTXVJkXQhLWy9ZUEQDhzbyOXzBxPDK0aBdoP1G7Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637376; c=relaxed/simple;
	bh=GUrUrbdrDflhjzifhjiB3OX/fe/n3Y705AqF2mAh3GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNCoUCyEGQnt84a8dnZThe1pxIJLXbD6wqqPZJo2CqFVoBTZPXHZ4lfBEGzfoOx1drQKyAHMLq5pZYDrs8Dun89XWUU5g/JR5SLmgOFAx5ECLR9c1W2dHozHa209m2Nu6x+ssIJQL0P4F3xpTQHeyQw9IJMf4XNrnjcErCKbsqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2D8G+sOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339D3C4CEF5;
	Tue, 23 Sep 2025 14:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758637375;
	bh=GUrUrbdrDflhjzifhjiB3OX/fe/n3Y705AqF2mAh3GE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2D8G+sOrRgZZEbMytc9A6WDcJRVJMsb6YFyZ35CB5ziLCuguTWV8QC41izNYoAJH0
	 +Jer5xjx5na7f84tdrDITPw6a9OQ2A0a8w0UXYXBqgkmTYkEzIBVqxMlY/HnuzvpF+
	 enabW/eKNpxbrwn/5zf5CQiYfNkK7MNMMvTGdrGg=
Date: Tue, 23 Sep 2025 16:22:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
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
Message-ID: <2025092307-scoop-challenge-4054@gregkh>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-1-7aa024de7ae8@collabora.com>
 <DD07LUJXNZN9.3RHH9NJNRFVNN@kernel.org>
 <2025092356-rounding-eligibly-c4b7@gregkh>
 <f5a802a4-ac9b-4b45-8d1c-871e2e06d7ac@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5a802a4-ac9b-4b45-8d1c-871e2e06d7ac@suse.com>

On Tue, Sep 23, 2025 at 04:16:36PM +0200, Oliver Neukum wrote:
> On 23.09.25 16:13, Greg Kroah-Hartman wrote:
> 
> > Functions like usb_fill_bulk_urb() takes a pointer to a usb_device, not
> > an interface.  Yes, we should fix that, but that "mistake" dates way way
> > way back to the original USB api decades ago.  So much so that I didn't
> > even remember that we used that pointer there :)
> 
> How would we do that? We need to be able to send at least control
> request to devices before we have established which configurations
> or interfaces the device has.

Oops, I thought that usb_dev in struct usb_interface was a pointer to
struct usb_device, but no, it's something else...  So no, we need to
keep that as-is for now.

thanks,

greg k-h

