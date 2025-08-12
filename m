Return-Path: <linux-kernel+bounces-764124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCADB21E55
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470EC504498
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7551E2834;
	Tue, 12 Aug 2025 06:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RA/CdNfX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E37311C18;
	Tue, 12 Aug 2025 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754980274; cv=none; b=iP59g9AVdKpd87nvg3f5IF7O1lIfs3HEMxsYzjRYpvHGSzi+5rG7SOiteDRi01NJ0UFWDrclL7yoGquwjG4v7DuhzmxO0f8M0nHHj7cMRNvaR1hZbfmhgAf/L/fH/0K0f8TJJS5/kMycXZntG7lkZkZ35D38+EA8tgh5hNXkRkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754980274; c=relaxed/simple;
	bh=7ntg7hCJndrDrkBOIgTar0qxh5TJTKhcARbugOihxew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbgoWhbeo6FeKkUIfW8gfl8lX7X3OwI0xmG/NPFXZ2deSZoSa9QibqNPuNARAuib5XgGTOx/StoJb5c9i5Ei3kTVWvAw4rCu2HZWskfBWH3/wJBe59PVOf3DnVu/9ii2ctWZ249StpeprOExE4fBVvWMYe9qtC9iGUUjKShQhXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RA/CdNfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3A8C4CEF0;
	Tue, 12 Aug 2025 06:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754980274;
	bh=7ntg7hCJndrDrkBOIgTar0qxh5TJTKhcARbugOihxew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RA/CdNfXpO0/L5y/fEQ7qUDSWLCGZCEx4xcI5l8D89VEOEV46wdaZqVB/n/csTjx5
	 T/m0u2xQHPSqn/2WZaoeH9EVEruSK+EbzPylI3fvf26xURbipijkGSmPgXTLy4xpZX
	 hV/P9EYzx4u42XtIpV7pAgo9tV8p9gjcJP+a1N2w=
Date: Tue, 12 Aug 2025 08:31:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: herculoxz <abhinav.ogl@gmail.com>
Cc: david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: auxiliary: Use `c_` types from prelude instead of
Message-ID: <2025081228-deskwork-runaround-3c99@gregkh>
References: <20250812035420.8123-1-abhinav.ogl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812035420.8123-1-abhinav.ogl@gmail.com>

On Tue, Aug 12, 2025 at 09:24:21AM +0530, herculoxz wrote:
> From: Abhinav Ananthu <abhinav.ogl@gmail.com>
> 
>  Update auxiliary FFI callback signatures to reference the `c_` types
>  provided by the kernel prelude, rather than accessing them via
>  `kernel::ffi::`.

Why is this indented?

Also, note that your "From:" line in your email client doesn't reflect
your name here.  That might be fine, but it's a bit odd and triggers my
checks.

thanks,

greg k-h

