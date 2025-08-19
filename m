Return-Path: <linux-kernel+bounces-774907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C41B2B90F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18E619606ED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7371863E;
	Tue, 19 Aug 2025 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="plPuqRGZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BFC1FC0E2;
	Tue, 19 Aug 2025 06:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755583476; cv=none; b=e+0Ygi4fz0VcZQqmOchpyNZkeorYcSDEgPSbvG4CMC2qp3nBapOQt3UPWfS7IBr+XdQ74/qXEMBdgEIA8KiFQmJpaOdBJ/TaMXzb19U09iBDPReld47CEx9jWvESN8So1hZOozQFuSvJ9bk2ADrT5Y8IywxBH+TJMmLG04/E+7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755583476; c=relaxed/simple;
	bh=hF7k0EFFjqu8Xwnr3JgLDoFCZrkZdoMKeBP5cMuVVpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaFo9n4fN+05M4C3E3NAupWlRkbjkYIHwZ+Nv8pDSE3AlZg+oxhmk3CDBLhxomQOlcGbpyEBt0fmS81GtXC6+vqNr0UpoFV6bwEe3E6WJs4JxCdHsWXnNsCsKLtmhP61+bVCG4kwT9jUWkGLOU5bDm9BrZk1KJVXdk9RTLDT9fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=plPuqRGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B8FC4CEF4;
	Tue, 19 Aug 2025 06:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755583476;
	bh=hF7k0EFFjqu8Xwnr3JgLDoFCZrkZdoMKeBP5cMuVVpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=plPuqRGZHRBDpB3LHhlICewp0+DqrEwkKW3y58eSaGa4iP7DZTZWtMByWX7NCeTkU
	 uoh/6zFQAkfOmDq3QlblhaHTiJVfJC3wTMomXKzzic5pnacYxAmN9sgms9krGHLPUM
	 lUMBLmwpnnk+Zv8Y1AWeuRO8eeso1kJPkEgPKXkk=
Date: Tue, 19 Aug 2025 08:04:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: arnd@arndb.de, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, lee@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rust-next 1/2] rust: miscdevice: add llseek support
Message-ID: <2025081935-railcar-playing-eb9d@gregkh>
References: <20250818135846.133722-1-ryasuoka@redhat.com>
 <20250818135846.133722-2-ryasuoka@redhat.com>
 <2025081836-unbraided-justness-4b43@gregkh>
 <aKQHQ4av5ZqfQ8Q1@zeus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKQHQ4av5ZqfQ8Q1@zeus>

On Tue, Aug 19, 2025 at 02:10:27PM +0900, Ryosuke Yasuoka wrote:
> On Mon, Aug 18, 2025 at 04:17:40PM +0200, Greg KH wrote:
> > On Mon, Aug 18, 2025 at 10:58:38PM +0900, Ryosuke Yasuoka wrote:
> > > Add the ability to write a file_operations->llseek hook in Rust when
> > > using the miscdevice abstraction.
> > > 
> > > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> > > ---
> > >  rust/kernel/miscdevice.rs | 36 ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 36 insertions(+)
> > 
> > What misc device driver needs any real llseek function?  The ones I see
> > in the tree are only using generic_llseek or noop_llseek.
> > 
> > Do you have a specific misc driver that you want to write in rust that
> > needs this call?
> 
> No, I'm not actually writing a practical misc driver. I'm just creating
> a toy misc driver to use for testing.
> 
> In my toy driver, I need read, write, lseek, and ioctl to verify the
> basic functionality of the device driver. I saw the Jones and Alice were
> already working on read/write functions [1] and I believe they will
> propose their patch soon. So I propose implementing lseek which
> anyone does not work on currently. This is the background of my patch.
> 
> As you mentioned, lseek by itself probably doesn't have much meaning.
> Should I wait for their read/write implementation to be finalized before
> proceeding this?
> 
> [1] https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/.E2.9C.94.20Miscdevice.20read.2Fwrite.20abstraction.3F/with/497953296

Yes, that would probably be best, because as-is, this patch can not
really do anything :(

Also, we really want an in-tree user for the new functionality (not just
in the sample driver), if at all possible going forward.

thanks,

greg k-h

