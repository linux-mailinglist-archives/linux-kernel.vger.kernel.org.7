Return-Path: <linux-kernel+bounces-805864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E844EB48E92
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA911341791
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E1930ACF5;
	Mon,  8 Sep 2025 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2wIxDK0W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2F53081A6;
	Mon,  8 Sep 2025 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336669; cv=none; b=guKlzKh9+R3EXM5dqxoG8WyOdPNN013Cc88E/J5D0/vJBT3qW6vO0MhjVzGYBcJN8bQLP05sRWfZqCuZOh/V/jv+JWrnLSsrDUJQG4p9UfIchPpR8mv/WDLtfd6Fz1q37SUjOqNLRoaAXZpLQE3hKPpxfBEu+cUpCg28SXgEwag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336669; c=relaxed/simple;
	bh=0O5hcKIVpFSNb8EgN1a/zqavVOx3Xsq/vYvcIbaTbUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDEVH92UnznAX9XlynBhoLonJozXIWp1sDnz8Ny7/F0qyYX1vK9oVV2Uj/YzXPZ0XSK/MFGVhs7KanXjgW7iS86nV8n3dACwFA/ur8ZOFbC0CgWRZENd1XmAbglCkWe9Ai5DI5Vo5Lht7GPgnVxs7Pu99zQSYpvzKCTIVoVBWoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2wIxDK0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C528C16AAE;
	Mon,  8 Sep 2025 13:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757336668;
	bh=0O5hcKIVpFSNb8EgN1a/zqavVOx3Xsq/vYvcIbaTbUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2wIxDK0Wz1HYMffQ6rkSkBR6MG1ZZ3ppTn+mxBxtNfkUNS2OuOPAAhLIK7sErUMiU
	 akpEpV6/34nMmiASjSspcNm76vRNnRHIw2Aem0iELo+baRZAO+5zoYRIM7D79DRoQn
	 I0ozCDNIq91ARPs/MESDMWHibDW0+wgYQQeYlVOM=
Date: Mon, 8 Sep 2025 15:04:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthew Maurer <mmaurer@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>,
	Dirk Beheme <dirk.behme@de.bosch.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v11 7/7] samples: rust: Add scoped debugfs sample driver
Message-ID: <2025090821-saturate-phoney-3f53@gregkh>
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-7-7d12a165685a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-debugfs-rust-v11-7-7d12a165685a@google.com>

On Thu, Sep 04, 2025 at 09:13:58PM +0000, Matthew Maurer wrote:
> Adds a new sample driver `rust_scoped_debugfs` that demonstrates the
> use of the scoped debugfs APIs.
> 
> The driver creates a `control` directory with two write-only files,
> `create` and `remove`. Writing a name and a series of numbers to
> `create` will create a new subdirectory under a `dynamic` directory.
> This new subdirectory will contain files that expose the numbers as
> atomic values.
> 
> Writing a name to `remove` will remove the corresponding subdirectory
> from the `dynamic` directory.
> 
> This sample serves as an example of how to use the `debugfs::Scope`
> and `debugfs::ScopedDir` APIs to create and manage debugfs entries
> that are tied to the lifetime of a data structure.
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
>  MAINTAINERS                         |   1 +
>  samples/rust/Kconfig                |  11 +++
>  samples/rust/Makefile               |   1 +
>  samples/rust/rust_scoped_debugfs.rs | 134 ++++++++++++++++++++++++++++++++++++

Nit, should be called "rust_debugfs_scoped.rs" to make it more obvious
this is a debugfs thing (noun-verb).

thanks,

greg k-h

