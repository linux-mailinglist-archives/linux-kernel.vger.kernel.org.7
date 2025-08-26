Return-Path: <linux-kernel+bounces-786926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66507B36DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD241BA792E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B0E2C3265;
	Tue, 26 Aug 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmfDqmai"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76362797B3;
	Tue, 26 Aug 2025 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222795; cv=none; b=VXGKlkBXaRgKTIoIxO7CKniC+vOdBITteYqF+iYL+BaPmfPXqdMio5CVhSukVdRyp2iJfztm1K448o9SSpzdfkk44UwGkXqaQKKsUJLL1mMew9tzFTCLi+9FuF17ThwCIQ98BsaMm626/VZB0bGt1qrVyFbu2AbF6eW6Eew9K3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222795; c=relaxed/simple;
	bh=LIlYpHk9qF6XY81zBj/SEOoCLlV10tDVfzwmMsC1AaY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=Gvw/hdwrkMMGNy03jZVGLfHv5VnJ5TKfecGcz/yZcdKZpBTxc7rcd0ybtVOhs/CCLuP9Yel81uLmdTjVYBVZl/a5V0DLdgR5qCsr39Ow+a+uGI2ttxeY21Uo6MrM8pGiqujbPCZDFI1YbNYx8S/zDWHkDtxB+Bqfdv67DFpxHi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmfDqmai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22075C116B1;
	Tue, 26 Aug 2025 15:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756222795;
	bh=LIlYpHk9qF6XY81zBj/SEOoCLlV10tDVfzwmMsC1AaY=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=NmfDqmaidR7XZOYpdK8kIAwyb5Zse2hjdsjCkj8QPiMiiSBD5jBWVTO619s4KaHd8
	 waYnxD/8b5TOteheOwpgky2u5MpM+LTExsiVYFVtcWl08o40B3UH82G6gbkKT3KQ94
	 UYrW94SZ/OWAmiHjKAS+IuYm+vEnO353cZnMdG112qnWWNo64T7pRfQUU9ONG7kfYM
	 1YzMPXZMNwL/kdBVjqqSuWlnzz0RXEtCSfUPfZAnQ2L5XfkGuisxQVFO83YXpcWVYx
	 N4hlgy08ipFSBfsNWoqMedTA3PVXMW8UavX9npwU0qzPDnWfE2GqYNi7axGyGxOa2Q
	 zHMstxRdSrM6A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 17:39:50 +0200
Message-Id: <DCCH0RWOX4UX.2ZO1CWHE1SQZB@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Benno Lossin" <lossin@kernel.org>, "Dirk Beheme"
 <dirk.behme@de.bosch.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Matthew Maurer" <mmaurer@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v10 1/7] rust: debugfs: Add initial support for
 directories
References: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
 <20250819-debugfs-rust-v10-1-86e20f3cf3bb@google.com>
In-Reply-To: <20250819-debugfs-rust-v10-1-86e20f3cf3bb@google.com>

On Wed Aug 20, 2025 at 12:53 AM CEST, Matthew Maurer wrote:
> +/// Owning handle to a DebugFS directory.
> +///
> +/// This directory will be removed when this handle has been dropped *an=
d* all children have been

I'd say "The directory in the filesystem represented by [`Dir`] will be
removed..." to be extra clear.

> +/// removed.
> +// We hold a reference to our parent if it exists in the `Entry` to prev=
ent the dentry we point
> +// to from being cleaned up when our parent is removed.

Please check punctuation, I think this is a bit hard to parse.

