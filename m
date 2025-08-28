Return-Path: <linux-kernel+bounces-790701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608D3B3ABE2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABAF58011B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBFC299957;
	Thu, 28 Aug 2025 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tCkXWO2J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9484621CA0D;
	Thu, 28 Aug 2025 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413883; cv=none; b=ZYlKSKFt5Vu6k9iHwES9MHqxMiXdMWYqJUf28berVd73aRTLfizVk6klnsxrEnJFUSXU8rzLHGsm4byJbX8x6dbC6FydIGFhR7L7yuWTIk90apWrwyPFNuj6qZuoDgoo/wWuHyFThfJtUGgBx+HqJF/OkisFmA9jz8CdlJ5oM0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413883; c=relaxed/simple;
	bh=c89mH4stV6Zw6WSUN9mFaTaOy7zgcpvR4oJ9c7bESJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWtOUhx5zFav1PKTiiKaXFzhbgNU47h1Tx2R87y51Huq7rXgy4gHctvJX/VCfQu2gfQrktx6cWP3C6jX9jlqp8Wl6K65Nlkd7u6/oPR7I8qG8fwmtvOjUkeGvvUzDqKAZkFan+tCapsB+b+qQy7pUspe5byKeTUpDjvUmI4CVPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tCkXWO2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E175BC4CEEB;
	Thu, 28 Aug 2025 20:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756413883;
	bh=c89mH4stV6Zw6WSUN9mFaTaOy7zgcpvR4oJ9c7bESJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tCkXWO2J3IewsQYx55BhxEF7giI4rYr6qrTJLCIFVVrshlB1bWXdQlsi8RicotIKS
	 hUHU+S9ffKyJmwgkscaccilQ/WW1mCTanW44QGMapvpzgWz7Oci7qoxw4iySgcbujm
	 WoI3AkcwBVA2+owQxnMSQlc5kKc36eZTkrN7Z6LQ=
Date: Thu, 28 Aug 2025 16:44:41 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Alistair Popple <apopple@nvidia.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/8] gpu: nova-core: process and prepare more
 firmwares to boot GSP
Message-ID: <20250828-precise-python-of-witchcraft-9d9a8c@lemur>
References: <20250826-nova_firmware-v2-0-93566252fe3a@nvidia.com>
 <dc18894e-09d3-4088-9be0-22c2070b61f4@nvidia.com>
 <DCD2P4ORDLYV.2NSHXI305AF2E@nvidia.com>
 <79c7d5b5-5fe0-4306-b8c4-3c91758a4c00@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79c7d5b5-5fe0-4306-b8c4-3c91758a4c00@nvidia.com>

On Wed, Aug 27, 2025 at 02:56:26PM -0700, John Hubbard wrote:
> > Right, b4 is supposed to be able to help with this as well, but indeed a
> 
> It really doesn't quite, though.
> 
> It is true that "base" (git format-patch --base) helps "b4 am" set things
> up, but then a subsequent "git am" fails due to missing prerequisites.
> 
> b4 isn't set up to go retrieve those, on its own anyway.

Sure it is. :)

Try `b4 shazam -H` on this series.

-K

