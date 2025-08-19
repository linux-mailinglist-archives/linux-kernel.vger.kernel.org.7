Return-Path: <linux-kernel+bounces-775601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E645BB2C241
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49773BD9E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A765E3314C7;
	Tue, 19 Aug 2025 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0sgHGSs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1032232C323;
	Tue, 19 Aug 2025 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604172; cv=none; b=CF8Yct6uOSM4HHmGWE7vLRwpCxbtI2KSsHYYBx/LGaqPczDA2gKp7G/Gxv2t6wHBojUX4H+NI6VcT2xVCtOq4sfi6EyRZz7Xgj30+26fAb/NvBRStBlu65SL6ZL87vsrrtA9+3HqaVkF6//oH82353IsB1f0GidmwcHT54bsxvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604172; c=relaxed/simple;
	bh=I9+81pArqE7MexOVxf+17csPrj9JT4C0Iku6aEw9/vc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=kgW0O48eEqo2cblhX6lHofs+vjzGgJvi0KIvVDhzIXwsEhWiTtBvBq+wvkEgyC7UYGC+hPjj0jdSCGHLRvg6A1W7TPalV9mYOUxt7Joy6qvu/O1tAy9qZkP03dO3BGXFOxHC0TYGXYlhFqtR5ey6lidJCA0BuRsCWBqQqFhfinA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0sgHGSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC37FC4CEF1;
	Tue, 19 Aug 2025 11:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755604171;
	bh=I9+81pArqE7MexOVxf+17csPrj9JT4C0Iku6aEw9/vc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=m0sgHGSs550VMnsNyZqMx1V/yqwEthhAqTI0c4BU9iqzQAn/yYFh37WhdrYb1R6PD
	 G6KfDbtEiUmTqbWw2XwV8B2punfA8JIVR20RsugasPvzeTR6Gnr5Cz1Vfnc7HYUxpZ
	 gqXqnu26hgcehsaYgVfz6M0eM/Jb5qeGw6RGKS+5ZVUXwUr6/5x14OC/X+G7dNyRLd
	 xAEs2x+tgxEJldw9S4+lwxXta33mfrj5VfnHi/eB3/k1CnWVsRFBECzrOyoqfq8Sw7
	 vCdGz7Wlo2s4BNSzeAcmLjHt9Rva0JCUNEmuypy3F2MCU8f0kIH9++3fvAHsEWQ2fg
	 3ut3VeET5N5pw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 13:49:27 +0200
Message-Id: <DC6DQKE6LVNQ.3BBD8WF8XGROO@kernel.org>
Subject: Re: [PATCH v2 5/5] rust: maple_tree: add MAINTAINERS entry
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
 <20250819-maple-tree-v2-5-229b48657bab@google.com>
In-Reply-To: <20250819-maple-tree-v2-5-229b48657bab@google.com>

On Tue Aug 19, 2025 at 12:34 PM CEST, Alice Ryhl wrote:
> Similar to and just below the existing MAPLE TREE entry.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Liam: I'm not sure what you prefer for the MAINTAINERS entry, so let me
> know if you want anything changed. There are also a few other options,
> for example, I could just add the files under the existing MAPLE TREE
> entry? The get_maintainers script should still send any relevant patches
> my way because they also match the RUST entry that has a wildcard on the
> rust/ directory.

From v1 [1]:

	>> We should have another section for the maple tree, since it's not just
	>> used for mm.  Your stated plan is to use it for GPU allocations and the
	>> code doesn't live in mm/, wdyt?
=09
	> Sure, I can add a new section if you prefer that.

Maple tree is already used outside of mm, e.g. for regmap stuff and I also =
use
it in nouveau. Hence, I read this as moving maple tree to e.g. lib/ adjusti=
ng
the existing entry.

I personally think that - of course unless the affected people prefer other=
wise
- it is usually best to keep a single maintainers entry for the C and the R=
ust
code. Maybe Alice can simply be added to the existing maintainers entry?

What do you think?

[1] https://lore.kernel.org/all/aJW3L3SEVUl_AVvN@google.com/

> Which tree does maple tree patches usually land through?
>
> Andrew Ballance: You mentioned being interested in being listed here as
> well?
> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 26053163fe5aed2fc4b4e39d47062c93b873ac13..4a52d884e36eafe1c81922720=
7123c51caf02ee5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14674,6 +14674,16 @@ F:	lib/test_maple_tree.c
>  F:	tools/testing/radix-tree/maple.c
>  F:	tools/testing/shared/linux/maple_tree.h
> =20
> +MAPLE TREE [RUST]
> +M:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +M:	Alice Ryhl <aliceryhl@google.com>
> +L:	maple-tree@lists.infradead.org
> +L:	linux-mm@kvack.org
> +L:	rust-for-linux@vger.kernel.org
> +S:	Supported
> +F:	rust/helpers/maple_tree.c
> +F:	rust/kernel/maple_tree.rs
> +
>  MARDUK (CREATOR CI40) DEVICE TREE SUPPORT
>  M:	Rahul Bedarkar <rahulbedarkar89@gmail.com>
>  L:	linux-mips@vger.kernel.org
>
> --=20
> 2.51.0.rc1.167.g924127e9c0-goog


