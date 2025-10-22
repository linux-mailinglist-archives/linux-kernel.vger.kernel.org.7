Return-Path: <linux-kernel+bounces-864723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B622FBFB68B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E59E1507C39
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E66324B14;
	Wed, 22 Oct 2025 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oy4bm+o3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B03322A3E;
	Wed, 22 Oct 2025 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128971; cv=none; b=SMQJXfafwREsMTIMu2WZnrwQZMu0eCVA74HbKNN+dnGep3lz3dB7/Ba2quyQ968WDg7BP15lEQK7NyGpIkYc0hq23kFZxBH6C+s4GQvmq3SZPsejkSy0iMtIxi5Hsuv8y82TN23atqre561L55W8PCRDG8u9fJe9hjTccURqCNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128971; c=relaxed/simple;
	bh=Duc2YVinMOzAYODjlacpSUDdlcarprDCjYc1ecKII1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoJJoBxekVj6XSMzLlZ5l32NjX4y5P2JogRMZV6ktBJ15GXCz7XO7y6kNm4i67mAofBdVmVTTMvUVqnPGgm3f6Bj+zZ8qZ4AVmkSFagEiFifC7sn2Oub0irTUg6sKjugBK0DqPvPzZIJkGrVXW8s9HWG6tSGzx4jlgUDRUkNNkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oy4bm+o3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23AFC4CEE7;
	Wed, 22 Oct 2025 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761128970;
	bh=Duc2YVinMOzAYODjlacpSUDdlcarprDCjYc1ecKII1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oy4bm+o3OxyfTl+f3/eh3v2VqXBMKZvukSx+NAEsasWyfeLJJeXenLAjOwDh0mTE1
	 1R4pR6J8BSu6JSHFqxJ6+Xy4X8hJjmmWFQxft3tYp2U3qB2HzE/i5Jvd192m85vPp9
	 krMFZjmlJcCF/4/eOm120p52EkzF3xv8ga1BV1fw=
Date: Wed, 22 Oct 2025 12:29:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Maurer <mmaurer@google.com>
Subject: Re: [PATCH 0/3] Remove the usage of Rust native atomics in debugfs
Message-ID: <2025102219-jab-footpad-76ee@gregkh>
References: <20251022035324.70785-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022035324.70785-1-boqun.feng@gmail.com>

On Tue, Oct 21, 2025 at 11:53:21PM -0400, Boqun Feng wrote:
> Rust native atomics are not supposed to be used in kernel due to the
> mismatch of memory model, since we now have the LKMM atomics in Rust,
> remove the usage of Rust native atomics in debugfs.
> 
> (help is appreciated if anyone wants to help in other subsystem)
> 
> Boqun Feng (3):
>   rust: sync: atomic: Make Atomic*Ops pub(crate)
>   rust: sync: atomic: Implement Debug for Atomic<Debug>
>   rust: debugfs: Replace the usage of Rust native atomics
> 
>  rust/kernel/debugfs/traits.rs       | 53 +++++++++--------------------
>  rust/kernel/sync/atomic.rs          | 12 ++++++-
>  samples/rust/rust_debugfs.rs        | 12 +++----
>  samples/rust/rust_debugfs_scoped.rs |  6 ++--
>  4 files changed, 36 insertions(+), 47 deletions(-)
> 
> -- 
> 2.51.0
> 
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

