Return-Path: <linux-kernel+bounces-785529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC731B34C15
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD57A207C44
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016BE265CCB;
	Mon, 25 Aug 2025 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="stu/4udB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438CD1448D5;
	Mon, 25 Aug 2025 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153977; cv=none; b=ZAiz+ih2wCuhaf01zlqLaM7gHBbYo39G96qoHtvsSzbf3TdB45MvykuY4nu74Dkv7mnS30zby4lr7SCsqtHY3gBxVoZHSI1S1NVybMlHLQS5t0qbFZhGwIwvgumnWroBb7jULyFjjgbGtZmLOwb19By7ZwB2/Y17wduQ6ICKv9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153977; c=relaxed/simple;
	bh=X+BeSsnNepBHHiG0qeK6h8b40M+NE10H+0lFLAU9+20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4VM1pvTjcP3bDAET9yXBQGiCqT0dKdbwUnyhCubIggwOse2lFLWj+psybb5US0+WRm4jVG5AAk6yIX8+srEoGbFS8lNF+0U4eJnQG81C14n0n/ozGSfSVaiOuU352ISoLtW3iAE3+9rq0eXIaKCyT544kHRymb68HeivdcHsxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=stu/4udB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D85BC4CEED;
	Mon, 25 Aug 2025 20:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756153976;
	bh=X+BeSsnNepBHHiG0qeK6h8b40M+NE10H+0lFLAU9+20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=stu/4udB3Bbh4bhwr3h1+9UkJo/ithOIbIJ0ZP3JDG92ntDneuAjPLC1uSPEqVR4U
	 0DFOAgPc+qd4NUSk3lpa8IkJpz45oCYMAqFU98FBwBd03ztpsG7DoAfyF3yU5U5G3h
	 Z6XZY2fcbgIHWzC2oKLY6WGOs5MwJUCHXx3OcQcs=
Date: Mon, 25 Aug 2025 22:32:53 +0200
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
Subject: Re: [PATCH 0/2] rust: usb: add initial USB abstractions
Message-ID: <2025082505-outsource-boxer-69ac@gregkh>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>

On Mon, Aug 25, 2025 at 03:18:04PM -0300, Daniel Almeida wrote:
> This adds initial support for USB Rust drivers, not only because I see a
> widespread use of module_usb_driver() in media (which is a subsystem I
> aim to support) but also because I want to learn about USB in general
> and this is a nice opportunity to start doing so.

Oh wow, I wasn't expecting this, nice!

I'm at a conference all this week so I can't review this just yet, give
me a week please.  But I am happy to see this happen, thanks for doing
it.

greg k-h

