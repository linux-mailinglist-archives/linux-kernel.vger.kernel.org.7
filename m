Return-Path: <linux-kernel+bounces-775569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A027B2C0AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65CC8725DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C3732BF5C;
	Tue, 19 Aug 2025 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/SnfIKX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6254232BF3A;
	Tue, 19 Aug 2025 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603392; cv=none; b=fK9gwFxmL5aqw4CeS3AtbNQxtPNILSZjcZR3LnTGH/j/Aq8mWpkuxtMwyfbZywVt3hHlr2/YJdeMiI1z4nqKlf8O4u2vtvKBLyGjJBc/T/yZ68cvypsmdkFnzRs5gSRzA9SrIiuT+POGsoLeJkOOEj3xkT4Mhf3lQjw2cm7f2z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603392; c=relaxed/simple;
	bh=gq15a1KyR2usNE5P/FqGOXri8nl83V2RQdCy/awNuG4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=m8CqWGXOZeq1cQG+AW7nPEUZB2zs1U2b/DkrH8W4+4ZanasckCqqqV3dFJppz6ImDrI5rGve25MkiUsemMHgPrLgdg6kzkQTckCmGhwU2nBIMRlze/ALMk9RM/r76tfYLZfi2HEea+z0TftJ5+1Mr800WmvVT4DJNid5BAU+N1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/SnfIKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB6AC113D0;
	Tue, 19 Aug 2025 11:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755603392;
	bh=gq15a1KyR2usNE5P/FqGOXri8nl83V2RQdCy/awNuG4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Z/SnfIKXBq+C1lpj76Ja2GJGykvaxpekFx/OzepNZgSlbwqq0mcmraTWD2dHctzDd
	 yknCbUfF11LgEzF1JJt+WeJ4BkqBA8cTXKlxc7uK49QurnBMC9DcC/wibGkypdgO4y
	 WvnBJlUY8QsX5EFH4givhy0NAl+FBAFHzgSfoKipybjPQDt3W0bUc0JihHx88q6yb5
	 XewjUWK+7Fp3STtrfZP6vn+TbJ/3tP3tJLuW+1TkbqEaOq4WpQWDI1uTo86LnVEih5
	 X9p149XOj9EE5C4DsQ1HKhXR5YVSdvzyceUeze2wcftEzih16Itw9l48G4IXPeimHc
	 iN7mVjJgx4jOA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 13:36:27 +0200
Message-Id: <DC6DGM7E728G.3KM1EOLVJNR24@kernel.org>
Subject: Re: [PATCH v2 3/5] rust: maple_tree: add MapleTree::lock() and
 load()
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
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
 <20250819-maple-tree-v2-3-229b48657bab@google.com>
In-Reply-To: <20250819-maple-tree-v2-3-229b48657bab@google.com>

On Tue Aug 19, 2025 at 12:34 PM CEST, Alice Ryhl wrote:
> To load a value, one must be careful to hold the lock while accessing
> it. To enable this, we add a lock() method so that you can perform
> operations on the value before the spinlock is released.
>
> This adds a MapleGuard type without using the existing SpinLock type.
> This ensures that the MapleGuard type is not unnecessarily large, and
> that it is easy to swap out the type of lock in case the C maple tree is
> changed to use a different kind of lock.
>
> Co-developed-by: Andrew Ballance <andrewjballance@gmail.com>
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> Reviewed-by: Andrew Ballance <andrewjballance@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Without the unwrap() calls in the examples,

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

