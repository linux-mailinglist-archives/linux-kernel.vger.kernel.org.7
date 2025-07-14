Return-Path: <linux-kernel+bounces-729376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 800DCB035C0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B033A5B92
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 05:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA1D1FDA82;
	Mon, 14 Jul 2025 05:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A1Qs9MeN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580811FB3;
	Mon, 14 Jul 2025 05:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471039; cv=none; b=vBikr7HQuf8gYitBps5Uez2L2TnVcwTW3SMSRnigIe0XwlSCA+z7ulm4tnOcvm1PorLpRQCovHemT0HRotrGEdenxF+P5wxgg0ubo0thsKi/tQH7GU1ht5I3888YB7UMTRR99li0xay7fkdnYX6ToxI1Duhy7S0deL7ojDYPG3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471039; c=relaxed/simple;
	bh=5BEh2YAaOPvO/E8CYy9PSFejUQ7XAL4/7BFAj30sgog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duqBd32WZCu7a5vN7F6pJa8SFsxgFE07Alws2e18r+UrSHqhxE4+cphLypGoO7MItginpzXn5OlSvKYcbJore4/edN4ATLq6Kh/6KVcjCBXULapbWKTcciIM1DLbNDmCzkKTQt2SQ48E6WTg6LS1zejNE3RHUkHcMOlIWak2qkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A1Qs9MeN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E11C4CEED;
	Mon, 14 Jul 2025 05:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752471038;
	bh=5BEh2YAaOPvO/E8CYy9PSFejUQ7XAL4/7BFAj30sgog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A1Qs9MeNrMI6bR1jdfqA3d6P2i2Ng5ZsYuuyJhfQlpDTBXNDHhwCVXFQSupcThIkD
	 WaLA3smV7BKms9u6nel0wnDMh4UOn4Z5aEzulNBByKvvaoQkCVCgr+y6eZ0aWE3skK
	 gtAyG5qiFRMH9+OrWymTuZtBnS3de8/OyR54TZbY=
Date: Mon, 14 Jul 2025 07:30:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, daniel.almeida@collabora.com,
	m.wilczynski@samsung.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: device: implement Device::as_bound()
Message-ID: <2025071411-casually-cold-6aff@gregkh>
References: <20250713182737.64448-1-dakr@kernel.org>
 <20250713182737.64448-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713182737.64448-2-dakr@kernel.org>

On Sun, Jul 13, 2025 at 08:26:54PM +0200, Danilo Krummrich wrote:
> Provide an unsafe functions for abstractions to convert a regular
> &Device to a &Device<Bound>.
> 
> This is useful for registrations that provide certain guarantees for the
> scope of their callbacks, such as IRQs or certain class device
> registrations (e.g. PWM, miscdevice).

Do we have an example where this can be used today in the tree, or is
this only for new stuff going forward that would use it?

thanks,

greg k-h

