Return-Path: <linux-kernel+bounces-775572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F479B2C0B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B981188A6D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5719632BF3E;
	Tue, 19 Aug 2025 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5KMksjk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C67320CC1;
	Tue, 19 Aug 2025 11:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603527; cv=none; b=Q0kdWPdVp9pH+bFuNj/6ZhqSltmcwek2muKa4sOnDFAN5dvHP6hCzAOA/NAQldz6pP08k/QSqQsamlsckTEtCqBi6O94rXw3tfn4lfPSI8j09GZ6PQIHN3599Ok9qppAFuuRS5ZUM5BP39S/OcmbYXUA3vZ9qOnsBZuvKlsPLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603527; c=relaxed/simple;
	bh=SmknYLVSkkmQvTAgrwu7Xj06gw6T6+yw90I07oFg6nQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=uIN4zQyyjlPAJonwua7tbCkUfqOFmvzAUUAEm0+y1+Q3XrtbmfzwydFCxGIUanAwBHuSo95azqKVf3g5ZWgn5bX6ce0Obwsax+sGPNGcEVgJ6AwWNlwlDhpaEbPlSKn7eBASHKzwyNmXgTJJxhVt9pJD4W2kBy9NrlOgzMRJxUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5KMksjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44445C113D0;
	Tue, 19 Aug 2025 11:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755603527;
	bh=SmknYLVSkkmQvTAgrwu7Xj06gw6T6+yw90I07oFg6nQ=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=t5KMksjkKQGQvtKIXsF08vRcMOGRNJx4qAdUT19jHQJRROLuu6xu3pWPsOqm/1l05
	 C+Fixuldjsot6XFSXzcqyqkoZn7VubA6V6zdOMTlqZW3eMH0ntWhwPTZ2YG8OmCe4u
	 Pf6h/UBGE6izIBGUFeAn0CA9u7bXwH9eUSyU6IY4G8roIGcip3WMm9pi9sKlZtEGrS
	 UpMTMU4KW0kW3RaAZNYubkNAAi3v56rojwQWgkXE3EbBdpgyn4rgdQU9eR2tRFvm6E
	 1y2JMCKDTYPPs9K6h15OB6HXZQYde3cZ0jXJEyG42nV1z5lmWCGvwuq8AW9SkXj0to
	 r7BSm9tueG/Bg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 13:38:42 +0200
Message-Id: <DC6DICA9SWYI.2XF7QB1FL32YP@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Andrew Ballance"
 <andrewjballance@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <maple-tree@lists.infradead.org>,
 <rust-for-linux@vger.kernel.org>, <linux-mm@kvack.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 4/5] rust: maple_tree: add MapleTreeAlloc
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
 <20250819-maple-tree-v2-4-229b48657bab@google.com>
In-Reply-To: <20250819-maple-tree-v2-4-229b48657bab@google.com>

On Tue Aug 19, 2025 at 12:34 PM CEST, Alice Ryhl wrote:
> To support allocation trees, we introduce a new type MapleTreeAlloc for
> the case where the tree is created using MT_FLAGS_ALLOC_RANGE. To ensure
> that you can only call mtree_alloc_range on an allocation tree, we
> restrict thta method to the new MapleTreeAlloc type. However, all
> methods on MapleTree remain accessible to MapleTreeAlloc as allocation
> trees can use the other methods without issues.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Without the unwrap() calls in the examples,

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

