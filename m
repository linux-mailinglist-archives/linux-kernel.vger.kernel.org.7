Return-Path: <linux-kernel+bounces-834557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D3CBA4F00
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146F82A7B77
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7771E51FA;
	Fri, 26 Sep 2025 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyKPOXGg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8FF2741AC;
	Fri, 26 Sep 2025 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758913268; cv=none; b=hq+IBrx9yw8p2Tar4egrs8Z/hQGTF/ZdpZmDR/+JvZcfH5EqW7FSBP2TevfBOUnI4KrD0nBimgBofMBKsdu1/24kOAJSwZvjdWyYNXHBJCr9bqWf86B4k4UYqdkyp+MffITMcyIz0CzznFiquak8qRUI1N2+gOV6tUrc+E9TlVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758913268; c=relaxed/simple;
	bh=E4rfPYVBSuJlFFzEr4OCEKQss3vgw3o4JIy7YvbOK0E=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=UlGHjA4ULU24ZH70WI5OEvlw7OtuNLbmBlpy4KugH2kCyJu2r9W/iw08dOlhEjIh2EQtv8Wq9vJ0kRJGNnmQ2TDBbZpuHAkcOSgVLvC7rtLZMUzAXK8f/35nJFkD1SfK60E/m9ZF6nHmiRZhT09ZsbWldfE/pS0yhoBtPyXIZmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyKPOXGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C21C4CEF4;
	Fri, 26 Sep 2025 19:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758913267;
	bh=E4rfPYVBSuJlFFzEr4OCEKQss3vgw3o4JIy7YvbOK0E=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=IyKPOXGgQmHBwfgnZgG+IY1ENE+o5qSwKicZbwt3OzyUr6pM8MKgo+lpt2ltR4MhK
	 x2vmCQC8qJQy7uX0g4pLPrC6pnMXgJsIxA6xW9EtSJ1hNkSmCf3jmjrFGqY3r1vHaS
	 NZ9OLfvEG7wPa72y8JsDJNmX1Fs36cPdwIX1bm5bhmUcYo2TBH0e+uyhkCH6bQ04rn
	 ljmhSRdPsh4DW47pRsdkOy4PARpzVou3y0Q2jhJAoqwzvVX+O6k2cYkQDrkVg8Ulwl
	 PmVj7RQjhxEJITZtGe9jr4wcap7U3uImOcz5uBR232g6RoVMZsO0ej+x2H5rLxfuu4
	 /CUx4cU1NXPuQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Sep 2025 21:01:02 +0200
Message-Id: <DD2YPPZ08RMC.2FCYC3HPWY3IC@kernel.org>
To: "Vlastimil Babka" <vbabka@suse.cz>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: slab: add basic slab module
Cc: "Elijah Wright" <git@elijahs.space>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Uladzislau Rezki" <urezki@gmail.com>, <linux-mm@kvack.org>
References: <20250924193643.4001-1-git@elijahs.space>
 <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
 <5f09b7f5-e7de-4333-8de5-322eb6d93aa9@suse.cz>
 <DD2UB5P01XW7.1GW33112S22Y@kernel.org>
 <DD2URCNO2P88.168J48GHSJRRL@kernel.org>
 <1f5ae3bd-db21-4042-b177-55464644ce2e@suse.cz>
 <DD2W3LCC7FWA.2X90YAPLI1FGC@kernel.org>
 <57b01f59-f4b1-4f5f-bb63-fd8eea19b7ba@suse.cz>
In-Reply-To: <57b01f59-f4b1-4f5f-bb63-fd8eea19b7ba@suse.cz>

On Fri Sep 26, 2025 at 7:11 PM CEST, Vlastimil Babka wrote:
> The rust wrapper side could do that so we don't have to add that check in
> all kmem_cache_free() calls, maybe?
> Also either way it could perhaps be difficult/expensive (memory barriers
> etc) to properly handle a racing kmem_cache_free() and kmem_cache_destroy=
()
> in a way that ensures the cache is always being destroyed, and not have t=
he
> kmem_cache_destroy() observe the destroy was premature, while the racing
> kmem_cache_free() doesn't yet observe that destroy was attempted, and not
> try to remove it.

Yeah, it's probably not much better than just using a reference count, but =
more
error prone.

