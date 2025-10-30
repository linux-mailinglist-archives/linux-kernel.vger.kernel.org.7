Return-Path: <linux-kernel+bounces-878503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 075C6C20D65
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02BE94EC6AE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799F22E8B9C;
	Thu, 30 Oct 2025 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iK3X3H0C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E3A2E764C;
	Thu, 30 Oct 2025 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836777; cv=none; b=Hcs/69c09fDz/GnVMu3rPABi+nuXBIaV9VgyCwUxk4/XkoIJ0g60P81OdcWrR+Is5OSq3oSxcuxtTIaYaEVp8YgYffupQcWYLS7rEGnBVH5/nUdXC8nP1mGidEEqMGemcx3hUivKr34I56zDY15w4gNzUMNInr/Gh5Rpp6X9xpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836777; c=relaxed/simple;
	bh=AEzEyVySA2Xgebyu1JxowEscJUTQoS58os36dQ/uQkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBNag+jdVt1R7K9RLophbMLjG1xZih7kHxdPEp4oBKmWNbYjMYP4cGldo1t/+W7tOMcatoaasL6yNy+aqGbigDcV3xc/2eaGJYJG5vFHbypAqM9+6kBE2TzyXiH4avYCwE8ahXpLtAyfYkwtbju0NJLnPf9Imtk2kTRN/lUTzOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iK3X3H0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3540C116B1;
	Thu, 30 Oct 2025 15:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761836777;
	bh=AEzEyVySA2Xgebyu1JxowEscJUTQoS58os36dQ/uQkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iK3X3H0CVcFRATUp1L86BontxlBhmMwHSu2kqpVy4h4ymGlhVhIx5r7K1d6cqYWPc
	 APfZ0WjuzHF594ukH5dvA8oAd3nChieJ1UWW5Ev6u5mG/xGygyqzxfJTXouKZz8ddG
	 blRZU2xGPebdqeZfuoRY469XPFCAA9xo4mm3kWGo=
Date: Thu, 30 Oct 2025 16:06:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Carlos Llamas <cmllamas@google.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust_binder: use compat_ptr_ioctl
Message-ID: <2025103009-sixfold-peculiar-496c@gregkh>
References: <20251030-binder-compatptrioctl-v1-1-64875010279e@google.com>
 <2025103017-driller-implant-849e@gregkh>
 <aQNnP6FWv8dA2_1o@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQNnP6FWv8dA2_1o@google.com>

On Thu, Oct 30, 2025 at 01:25:19PM +0000, Alice Ryhl wrote:
> On Thu, Oct 30, 2025 at 01:38:56PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Oct 30, 2025 at 10:41:04AM +0000, Alice Ryhl wrote:
> > > This is commit 1832f2d8ff69 ("compat_ioctl: move more drivers to
> > > compat_ptr_ioctl") but for Rust Binder.
> > 
> > You might want to spell out why this is happening, not just refer to
> > another commit to try to find that information to make it more clear
> > here as to how to attempt to review this :)
> 
> I can replace the commit message with:
> 
> Binder always treats the ioctl argument as a pointer. In this scenario,
> the idiomatic way to implement compat_ioctl is to use compat_ptr_ioctl.
> Thus update Rust Binder to do that.

Sounds good to me!

