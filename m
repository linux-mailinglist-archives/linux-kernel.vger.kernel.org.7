Return-Path: <linux-kernel+bounces-765627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CC2B23B88
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E42097B786B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2B92D9ECF;
	Tue, 12 Aug 2025 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgjURPBB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7897523D7F2;
	Tue, 12 Aug 2025 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755036075; cv=none; b=ssST/iI3Xz9/zvd+i0FjJykh0jg1B+3qTpmj+eBp644Mb4JPs1mq0HA2e8ideSQSKdCDVzO9HRqYkEj4imbTlMg/nTq09V0lYIpOenqNmCXH5obo0hxdPaT412VN3Yo/NkmNoMPokmrM5ofQUHsDBzjv3LsvERgZfdfuwTmatbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755036075; c=relaxed/simple;
	bh=nmauN2trr2MqSwC7EVxjuakr7oqZi/jzkFSIDesD1Eg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=OBnHYDCQX0jMSLYL0zK5JchAOLyHTX9Z1aPCAyrPvM+3tmd+42qdSYu6Y3cMZtARzv+68niXnJJ/R25+nm3P2BSatLVLU7yvYRdIk89NZNKHkHnPhXjyg6KIB8lRlq9pT2erqui1McapC+qkO+PLuV72WRN1tn3tSdzknXEFxfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgjURPBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6FCC4CEF0;
	Tue, 12 Aug 2025 22:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755036075;
	bh=nmauN2trr2MqSwC7EVxjuakr7oqZi/jzkFSIDesD1Eg=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=DgjURPBB4aFl2oNJyvs0UxdK1fzXWdRruU65ddrQ8EK1Oebio6ob3u9tCtwoKaOzv
	 e8IDWteM2nCRKguixNMoN9OYhcx9h2AXvpZnP9cXWtCWN+mO5uJ14qniLycNGtwRYD
	 qwTH7rQdIjH3q+jCmiOTz4bCm4NmwDK5wmkCi7/vq017Xx+H7fvBGZCny7bS35bWnq
	 ihLXnAGDEfNEn810JLkiVJuSgj+SZOBk7lmDfaqTaq7clqquwU9PUW1iMIiHwGk2A4
	 JipWkJJUhk9gOvNdsdSB65zx5YY0sVpbDxktD8x4MNLdSDyHlwKCVM7if86pzBcaqj
	 HQKpKPoEYawzg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 00:01:10 +0200
Message-Id: <DC0SD4G19EOX.3V3LFT84NMMVP@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rust: devres: fix leaking call to devm_add_action()
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250812130928.11075-1-dakr@kernel.org>
In-Reply-To: <20250812130928.11075-1-dakr@kernel.org>

On Tue Aug 12, 2025 at 3:09 PM CEST, Danilo Krummrich wrote:
> When the data argument of Devres::new() is Err(), we leak the preceding
> call to devm_add_action().
>
> In order to fix this, call devm_add_action() in a unit type initializer i=
n
> try_pin_init!() after the initializers of all other fields.
>
> Fixes: f5d3ef25d238 ("rust: devres: get rid of Devres' inner Arc")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
> Changes in v2:
>   - Drop inner in-place when devm_add_action() fails.
>   - Document to remove drop_in_place() once we can switch to UnsafePinned=
.
> ---
>  rust/kernel/devres.rs | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)

