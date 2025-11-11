Return-Path: <linux-kernel+bounces-894931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D6CC4C79B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 260E84E6B60
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5092DF14A;
	Tue, 11 Nov 2025 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rz2DgqJg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6219A757EA;
	Tue, 11 Nov 2025 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851194; cv=none; b=QQERjL5v/v9kuV+ljWk1nUwLqYwAQWS9EgxNJ7bzJVHK+wvpk3ZOMh3jSWSHLHjCvplEHWyQmxyZ8xisTwr5iEFEpAvvnb58DSVOrK8nE8SI135UqBzteY0jDquUIkfFJliF5XKgEySd/v7gt7BewRt5L9hw2pPy9jKI8J2BlNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851194; c=relaxed/simple;
	bh=9CmY6ggLRsP/ZfUwsNgbdwlQUOAib45FvdL0W/S9YoI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=TVXjQrVE5vRuExyB11fFYJtcDdJAy46v9CA7RjHjDwzPmXTnXK1RtIRN2QME6Xo/hhZMWkuPiHGEc7XRqLHZCE0e8aLUO3ahVz776sl67pmM/UPUWt74U7SvmpGNuqid6AbPGWVfLo0R3f+A6/B89Da0FEOyaV+wLV1U591qt00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rz2DgqJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67789C4CEFB;
	Tue, 11 Nov 2025 08:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762851194;
	bh=9CmY6ggLRsP/ZfUwsNgbdwlQUOAib45FvdL0W/S9YoI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=rz2DgqJgWmskNYCHg4H5lvdrlRr7M0uH/wmC0axq+12Lq0T8otZ1LLTw8X2N6ntjR
	 vyRkwFjwXXhjsyiphq85sf3YUlIPh+cy/XFGXpnKjPe6lgWdGhmOacF/QCTAOCqvTw
	 Lz773RETmwVd/DMZ5d28fWlRhswr0TFfeFHWP4akvckmJujLwr4WuCPglmFX/YEUCx
	 lsZCx2XgG0SXMP2xkwnUoWZLeaVa8OXPZov4ktggq7iFi4+/lN2bEar53swxFhLv/t
	 Av1ymX0iHH6hbMEWlgdzIAboiJ2uHnnZc2asAHVTtFFpOVRcSHrJFDhcQHua9gRqmA
	 rMl6IEfNoO1Mw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Nov 2025 19:53:03 +1100
Message-Id: <DE5QL9NMQON4.V7MWURBS3RSQ@kernel.org>
Subject: Re: [PATCH] rust: io: cleanup imports and use "kernel vertical"
 style
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>
To: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251104133301.59402-1-dakr@kernel.org>
In-Reply-To: <20251104133301.59402-1-dakr@kernel.org>

On Wed Nov 5, 2025 at 12:32 AM AEDT, Danilo Krummrich wrote:
> Commit 46f045db5a94 ("rust: Add read_poll_timeout_atomic function")
> initiated the first import change in the I/O module using the agreed
> "kernel vertical" import style [1].
>
> For consistency throughout the module, adjust all other imports
> accordingly.
>
> While at it, drop unnecessary imports covered by prelude::*.
>
> Link: https://docs.kernel.org/rust/coding-guidelines.html#imports [1]
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Applied to driver-core-testing, thanks!

    [ Use prelude::* in io/poll.rs. - Danilo ]

