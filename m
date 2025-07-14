Return-Path: <linux-kernel+bounces-729377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE4FB035C1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C3DA7A91E1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 05:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2331FDE39;
	Mon, 14 Jul 2025 05:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gBfZOh0d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9082E371B;
	Mon, 14 Jul 2025 05:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471050; cv=none; b=r8IK63VNZZl43rymAJxs3FB5psuEjXOSuKpl7125ANV2SLuQEBai2+3dRChN7IsCSvIn0gK74UGG9FiRZr3ea+oxW7CfvxYFYgQUiLr6UA/7ZNVlOCpvnP+xk1zJ0yNKaGR0Zb8hXNu5kQYUi+jepUJV3/DC1FtxkyZYMcK/uSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471050; c=relaxed/simple;
	bh=Yx5NEUty5oO1GdlaH9fou767Oi52Fn8/lUwDKLgep2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtiJ5TUfkV3Vr6yfcn7ACvLEfth4Bktxwdy8o5jLA5BE8JDOnbvhIgWQ+mlHCRGsxXDzRQgLyfvoffWimSEau165/ehthgyq9DvXiYmquIL+/OfciTbY5j1AEOjvl+1ecRTkTOGAeSVrIVwBd/AjxFwQ9tRTaH1m2Cdkk5Tcfpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gBfZOh0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3E4C4CEED;
	Mon, 14 Jul 2025 05:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752471050;
	bh=Yx5NEUty5oO1GdlaH9fou767Oi52Fn8/lUwDKLgep2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gBfZOh0dtbiCAXudES7k6vbmHjonqXPFad9pEIaFuUqCAusfIKs1H+VM+9QhTQEGw
	 oZZzJcHQwpZdfN/73h2lE5O8a1QkFGFYYs7Xt2nfOICabCdIbVa89nq46FPv/y3QC4
	 syEfa9FT0q9ojplSgl6cnhbGkpd8iprrCuD+gFDk=
Date: Mon, 14 Jul 2025 07:30:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, daniel.almeida@collabora.com,
	m.wilczynski@samsung.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: devres: provide an accessor for the device
Message-ID: <2025071437-repeater-thank-6ae4@gregkh>
References: <20250713182737.64448-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713182737.64448-1-dakr@kernel.org>

On Sun, Jul 13, 2025 at 08:26:53PM +0200, Danilo Krummrich wrote:
> Provide an accessor for the Device a Devres instance has been created
> with.
> 
> For instance, this is useful when registrations want to provide a
> &Device<Bound> for a scope that is protected by Devres.
> 
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/devres.rs | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

