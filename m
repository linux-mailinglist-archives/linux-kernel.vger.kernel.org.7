Return-Path: <linux-kernel+bounces-739342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB60B0C500
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821063B8CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95E52D663B;
	Mon, 21 Jul 2025 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ek8K+2Fw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206B519AD89;
	Mon, 21 Jul 2025 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103855; cv=none; b=Wo+Q7GGEGrUhL69TnJnyqgobcup/ZXkKV9CKp2ShXGcXpjOQebzngfDxqmsNGmxcPUFwiHpQPP67VGmAkDXWQHHyW7QGRMuucZgsNqSUNJCnq2n2F4nBTvqjL/KLpikQ1o49eK5/5NW/SHsKDMV+Ysb2XpXI0iyg+Ch9+CI0Oq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103855; c=relaxed/simple;
	bh=ZbNrEK5Ac7aDXRD4X0QwLxogwtUOq3b2VY3XlStGeE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4jWOZau4ZzSV0U9cXFgKUrdN1ukZyxVlF6rYDH/ArdXVLZyN820S5vwJaBCwJOM2GwUvCsZU6wYtJYy2Lp6rnvyB4cEjaBu9qdy0qWySlEbFys2TE5BeqEoIlTrs4Yg7kfH6z5/10zCLdIOn4ykwjHvzfw3+9SfNY/mpUcu5g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ek8K+2Fw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F449C4CEED;
	Mon, 21 Jul 2025 13:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753103854;
	bh=ZbNrEK5Ac7aDXRD4X0QwLxogwtUOq3b2VY3XlStGeE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ek8K+2FwkjAJs45uIF9DxGomK3sl+BUXmYH9t858YrjdStAKpQdoL5JTsDIpkV8iU
	 tVN3L/h+Se9vo5be8ZUcdffoIShKNMO7E0SA4prmpA/1Khjf1MP3Ev5H9EHYIiA8z8
	 MeZBiJMZrC6FEEwT9tLzIpCfnzSkUjY2ZeGhuejs=
Date: Mon, 21 Jul 2025 15:17:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] device: rust: expand documentation for Device
Message-ID: <2025072110-buddhism-accompany-0682@gregkh>
References: <20250717224806.54763-1-dakr@kernel.org>
 <20250717224806.54763-3-dakr@kernel.org>
 <aH4juIVmj8euE1CA@google.com>
 <2025072125-twine-curling-db0b@gregkh>
 <aH4telYyyexiMbjx@google.com>
 <DBHQ2ZDUHLSW.LHWUTFQO1E60@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBHQ2ZDUHLSW.LHWUTFQO1E60@kernel.org>

On Mon, Jul 21, 2025 at 02:13:14PM +0200, Danilo Krummrich wrote:
> On Mon Jul 21, 2025 at 2:07 PM CEST, Alice Ryhl wrote:
> > The connection is that to request an irq you must have a &Device<Bound>,
> > so if you can only obtain a &Device<Bound> to a bus device, then that
> > means that you can never request an irq for a class device.
> 
> As mentioned in my other reply, a class device never owns resources of a "real"
> device such as an IRQ.
> 
> A USB device, which represents a real device on a bus, is a bus device, in your
> example the class device is the input device.
>

Just to confuse things a bit more (sorry), there are also "USB class
devices" that represent USB devices that use the "generic" USB interface
to userspace api.  You can find these by searching for
usb_register_dev().

Note, this is different from the drivers/usb/class/ drivers, which
represent various "USB class protocol" that the USB.org group defines,
and those talk to userspace through the various common class apis
depending on the specific device type (input, network, etc.) and are USB
bus drivers.

Naming is hard, wait until you learn about "usb gadget" a word we had to
invent to describe the thing :)

thanks,

greg k-h

