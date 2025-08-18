Return-Path: <linux-kernel+bounces-774533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF70B2B3E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6121B27718
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF3627AC21;
	Mon, 18 Aug 2025 22:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGcthFca"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A2E27A903;
	Mon, 18 Aug 2025 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755554583; cv=none; b=GCRLAYkjly4KYslHZhWZK+V5o9K09bRZV4eB8l/CC4R9ugv/wE5COaLSyk1+7D8u1S8Zc9ankqlNRWEL7613TDdMUH5eUTGb5NDfwRqPtiePrcGuNCVlQacnfuqqCWBCfoAJZ54gHngyT8AGSEvvnThsXJOZeGGWYPTHz6HTvJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755554583; c=relaxed/simple;
	bh=y8ufLCIEHyBv54oAjiWlJZ7N3FAnkt/nbPctQS0m0iE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KpAQTMW0KH7Ni9ywxJRe+05W2zesDgI3BHImYH5oVYe0dUy2rA0peW+eLGfotZ9H/0MiICv08WfXBT9RjlHrYt09ZJffAhy5R9swYwgurXNee/GBUVsWUDfVcR8737HQa4KB06ED05Cx/aZDR3HQmFNPLV44+huRz/USqdDMyw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGcthFca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E68C4CEEB;
	Mon, 18 Aug 2025 22:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755554582;
	bh=y8ufLCIEHyBv54oAjiWlJZ7N3FAnkt/nbPctQS0m0iE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=vGcthFcanSkzBVs4NADi3ciBNIFn+QNsHQMXfZ0Sc2yi+Mnw6x/U9ZsBb7RBeCaXa
	 RZZh8ccdUspHiNyQIcrZ4y6ZOWrstyweK7Byqg3vJ8jnH1JACQEXJVXuMRTsNt0ZfJ
	 QAoOrgsSGYo2p2Ny9WPzV+r4hF236XQ4Hz1VUMBvYpO+eX1trWmhBytyrNXj5J4rHd
	 zO8gFRuVjuYX6oaV9BvnlnpIuE46mLmSDLjHjIiIzP4WuwbvKmO4p2kjIzf1Xj4M8L
	 VJxQoLf4JumhBK9fyqgPiNevljqwxkbelbLe5ZcBgtYu+HEAfu7hcA2dg7QV1pXMRs
	 SgEc20a+ytjMw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 00:02:58 +0200
Message-Id: <DC5W5RHB4YJ7.3IB4SLUKYP5FP@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: task: update ARef and AlwaysRefCounted imports
 from sync::aref
From: "Benno Lossin" <lossin@kernel.org>
To: "Shankari Anand" <shankari.ak0208@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250818132551.133410-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250818132551.133410-1-shankari.ak0208@gmail.com>

On Mon Aug 18, 2025 at 3:25 PM CEST, Shankari Anand wrote:
> Update call sites in `task.rs` to import `ARef` and
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
>
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> ---
> It part of a subsystem-wise split series, as suggested in:
> https://lore.kernel.org/rust-for-linux/CANiq72=3DNSRMV_6UxXVgkebmWmbgN4i=
=3DsfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
> This split series is intended to ease review and subsystem-level maintena=
nce.
>
> The original moving patch is here: (commit 07dad44aa9a93)
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D07dad44aa9a93b16af19e8609a10b241c352b440
>
> Gradually the re-export from types.rs will be eliminated in the
> future cycle.
> ---
>  rust/kernel/task.rs | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

