Return-Path: <linux-kernel+bounces-823332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89544B86246
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19487E1F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46935279354;
	Thu, 18 Sep 2025 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lEOl+PJ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A852242D97;
	Thu, 18 Sep 2025 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214998; cv=none; b=m8VththZLUh0XUI3IjKQWsfBc8kQzZlIf9TScuBo/7QuXnVebDaeV0tlhD39oYi8M4jT6b4FcfLt5VEIKjTf2Xu4jZTFk9F/VnMj5I+7AURCySS60HvS8PGFhhDFoaP8Pv30es1eh7zKPklNl/VUHKDa1IPLqpvkoGy4X/QGMgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214998; c=relaxed/simple;
	bh=umCnBCPvufCE5UrorOy7LLabi4FwQnYwSRE6wbc+/aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzrLdwiyqUXvfWCnUccr+oORWpZLdnmU39bMPtb3enfkn8p2GfWrgDtHoAD9G22abNny/4OMYAiGcLsaoa2Wwd0nVQLiHfejoTUMTWD7pNXpKL8+Alchu4QGqaXnvWLLFIWWZyyPoiuuZDV2F+T4dtb6R8npHRCH5Gr+0QjiEPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lEOl+PJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652CCC4CEE7;
	Thu, 18 Sep 2025 17:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758214998;
	bh=umCnBCPvufCE5UrorOy7LLabi4FwQnYwSRE6wbc+/aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lEOl+PJ1dZrTVWFC6kxUuxmJh+rrEvF0UyQ4SZW/qHSfYS8AJf/TRrCjz1tOdnGjV
	 644J0njdsspeX+zsB6GixVNHl3vLdSRhm/DjHREht1s0Itr1fGS+TKrS2ao703ZbMJ
	 mdhyzwtRTvWUJNCOH2bePkxnMXAAbSkX9qNmf4GQ=
Date: Thu, 18 Sep 2025 19:03:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Carlos Llamas <cmllamas@google.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Matt Gilbride <mattgilbride@google.com>
Subject: Re: [PATCH] rust_binder: add Rust Binder driver
Message-ID: <2025091804-attractor-impart-3084@gregkh>
References: <20250918-rust-binder-v1-1-7a5559e8c6bb@google.com>
 <aMwxLQubVOuGZGLf@google.com>
 <aMw5b7aNxoULilmg@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMw5b7aNxoULilmg@google.com>

On Thu, Sep 18, 2025 at 04:55:11PM +0000, Alice Ryhl wrote:
> On Thu, Sep 18, 2025 at 04:19:57PM +0000, Carlos Llamas wrote:
> > > +// SPDX-License-Identifier: GPL-2.0
> > 
> > I'm not sure if all these need to be "GPL-2.0-only" explicitly?
> 
> It should be the same.

To be specific, yes, they both mean exactly the same thing.
See the top of LICENSES/preferred/GPL-2.0 for this.

thanks,

greg k-h

