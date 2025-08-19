Return-Path: <linux-kernel+bounces-775455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD56DB2BF55
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F89D1BA6EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7612322C8A;
	Tue, 19 Aug 2025 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiwspCeh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D201322C87;
	Tue, 19 Aug 2025 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600563; cv=none; b=mDcZ+S7YaHt/VF7/7HgEnoRCMrLOGk9tyLlPVWbROf7ztWr+GRQgyuOmNyIfKgjSZrfDvyknyG+9+6+7hSSpD/pch1qGIBiHTjxz3I9h6eCUrWGY/pZ+RTy7mlbKH518kGKWmnbk90MrvH/1J/9coLCgnuW+cHuoWEQcISKXui0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600563; c=relaxed/simple;
	bh=4C461uqkBRTf/VoyeMHeL/ZxhPm9u8aTbcJgO4Mzv+8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=loOh85ALMYJTDcLplfdsreyaiqGp+/EMQdH/00oUvimzCzSwERCVsoBdEAqqLJhuj/OZ5fJ0gPSjhIAwzjhksYnYKYBrKazRkBaOB6NVUxwNHKSV+Iao2EFfK//+l5o9DwE4biWbi/7FwF2Xe2F80olWt+vh3F5MczvoNtF2PqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiwspCeh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEADEC4CEF1;
	Tue, 19 Aug 2025 10:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755600562;
	bh=4C461uqkBRTf/VoyeMHeL/ZxhPm9u8aTbcJgO4Mzv+8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=hiwspCeh3vVliHN8vq/VHlFU49sh+i7/SjlHask+7oRb2UHt6bWFYGsnesOlpELXh
	 evXzZ4ZNG/1FXotVis6Swa4MkTFtcqLFe2hjp5MBeZ4MN4mDRVCxVm8NPWl7R3Ru3f
	 V/DwH+Ckea9ZBgkXXaw9+Uv0EgIaEjBP6mb0pKE1ZQDWe83wXUwQzW4svCWdrZWhaF
	 b65yJj9Ao4zLmj1kMyO7OoRh4dZCoWxwnPFvEBuU1KU9z2EgcRyGvRZ5uKBJpVzwY8
	 4kQ8Y6pQqVqK9iQfxwkgtSQSrhnmyTFzDIgypz6vBqyRIXpaGOU/vl74AzW8w9aYzI
	 Fd84CIuDMq2uA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 12:49:18 +0200
Message-Id: <DC6CGIFANVZ3.2J04CI984KNM0@kernel.org>
Subject: Re: [PATCH v2 1/5] maple_tree: remove lockdep_map_p typedef
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
 <20250819-maple-tree-v2-1-229b48657bab@google.com>
In-Reply-To: <20250819-maple-tree-v2-1-229b48657bab@google.com>

On Tue Aug 19, 2025 at 12:34 PM CEST, Alice Ryhl wrote:
> Having the ma_external_lock field exist when CONFIG_LOCKDEP=3Dn isn't use=
d
> anywhere, so just get rid of it. This also avoids generating a typedef
> called lockdep_map_p that could overlap with typedefs in other header
> files.
>
> With this change, bindgen will generate better definitions for this
> union, which makes it nicer to use from Rust. This avoids a cast in the
> Rust abstractions for the maple tree, ensuring that Rust's type checker
> will notice at build-time if ma_lock is changed from spinlock_t to
> something else.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

