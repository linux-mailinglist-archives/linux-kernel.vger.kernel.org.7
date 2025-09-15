Return-Path: <linux-kernel+bounces-817147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8B5B57E75
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5453717236E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B1A31A57B;
	Mon, 15 Sep 2025 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwJUxQV8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0D73093C4;
	Mon, 15 Sep 2025 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945516; cv=none; b=tSYuYrx5yd6BEqAh2nopxPio+OSAUco3r3pv1dzZWNcx5HKfVcyqOVeG3sP5Wk/asqDtgztl8T8/mG+/r4vTdpS6sCrBxaw4r3F8WuIVYy+afwzaytvW4T56KWT8QjSIJU5p8IPC1iZz0NKxe94Mn0qOUVP4aTrukHUqXH00Y8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945516; c=relaxed/simple;
	bh=oGOOunK0PfxXrRUADZFrrgGhaNn8PL1UAVWMiQNouXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+mg4oGMX0FLjtOUktAE/2LxEjlrGpaOnxMfVRAyTwMA0/NUUfRM5dHGRsGyxgALF2rr7NI+Rcq+LWJS+hQH1KuQXHbh98c9RTAk3cm2ypRGAraYIc8yLMfizPqWM3KGR8GB5U8f9Y/MNss7/7ck3rfYm1E53p1PkP70XXHuEFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwJUxQV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E448C4CEF5;
	Mon, 15 Sep 2025 14:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757945516;
	bh=oGOOunK0PfxXrRUADZFrrgGhaNn8PL1UAVWMiQNouXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GwJUxQV8siDLGdpB2C0MzNpgUOqvlBfWj0YSHqd4QgiJZsgAJgxr3ffqM9dSQXiu9
	 KqnQq6BjCxOgby8JDped5Z2qKGQIEe9ysM0zreF1n87oFN4vFTOpHuje3R/h10wm7T
	 CcsxyF4EMaKAWeRjKbGjtq22Diy3Y+Wegm293uQ2vodrJS9wdWkQJ2KjlVaxnmekod
	 Rnk+73piDbMBLG6N3j5mEqSiiVVELy8jGwcFDR2Sw9g8f5y+/j63IOaVEJxvJfMmxU
	 bqpbFMgKexDsP06B/o4GWxsChbYP1Ud/5f91F4Fxv6nQ61Ngt6sSkR3Fhc4al16wWZ
	 /OFiY9fx+nlQw==
Date: Mon, 15 Sep 2025 16:11:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Simon Schuster <schuster.simon@siemens-energy.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20250915-apotheke-freuen-694e4fc923c6@brauner>
References: <20250904113334.18822d43@canb.auug.org.au>
 <20250908120229.7a4e6db9@canb.auug.org.au>
 <20250910104944.3e420e96@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250910104944.3e420e96@canb.auug.org.au>

> > I am still seeing this failure.
> 
> From today, I have instead just reverted these three commits:
> 
>   c6ac444ff20c ("nios2: implement architecture-specific portion of sys_clone3")
>   bbc46b23af5b ("arch: copy_thread: pass clone_flags as u64")
>   edd3cb05c00a ("copy_process: pass clone_flags as u64 across calltree")

Sorry about this, I was pretty sick for a bit and wasn't near a
computer. I'll pick the fix now.

