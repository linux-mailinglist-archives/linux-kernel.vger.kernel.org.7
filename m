Return-Path: <linux-kernel+bounces-786494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0163B35A86
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E2D7C0507
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC73330F55C;
	Tue, 26 Aug 2025 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpjsMpJj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DB130146A;
	Tue, 26 Aug 2025 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756205870; cv=none; b=rKvj6sL3DVmm+GfQoaxu1NNVFFITHL6c9tRsGgbvsGxhm11kkqAz7Fqr8BcTnBwI64dYlcdkQl6GbRDMmxbnzNUG0luNBZ/0gMJFz76AQdnJYv8QsEtEIYbITUOPwj6hQUJTr0TxALaHh0dRFogGUYQu1xYn6gLbH5lyKg15mSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756205870; c=relaxed/simple;
	bh=uyrxk6x5endfgPWV1unzyAKLaF962HHKgN9da8/FKKs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=E+qYfvV7j8hhNoysAAx8F0WsYWQhCkVQl0uNxQ43AvMJbamQUtywOHrJQ01wTL+/thpNLS7q87ipsamSu3QHdTr+zQsxdQHpnHHflCqI6ce2Kloc0m/M7LN6MKyvHJ/JZkt/dmpy6sBgSAmhuAk5Nsgugv6DNQXrz81GJAAGwkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpjsMpJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC94C4CEF1;
	Tue, 26 Aug 2025 10:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756205869;
	bh=uyrxk6x5endfgPWV1unzyAKLaF962HHKgN9da8/FKKs=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=WpjsMpJjsBtNATzL7Df/XfKezd9fKPIfPD55b76UExPKSjxg0UjACnw7Uw62Z5aEZ
	 LjghjDxcM8/mR3k0lI63BcIcz5IStg54rDXg1udfSR9vCLSzmJMlfE/FQVRyu3lOnt
	 ZgWbxQ6g+SupQmQFfMqSw76nITdx531IH4gxvclOk6rR26TsBedtlycUjNlYBnaHLN
	 ajQsJdTr09ROul4jZtkXySnC2U4UfRELbVyW2WjzrMR7cODqLxa7VpYHOXZwSQ1za6
	 YSDbxmb7L+yeENclwWZGHdbRUfxVq+8gWoNvXLax0tEoDoa/hAwzV6KZ1RB8au7CWP
	 6OH1eUpWzBNDw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 12:57:44 +0200
Message-Id: <DCCB0SA6QXWD.3KAR8P6LK9BYF@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 1/2] rust: alloc: add from_raw method to Flags
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Uladzislau Rezki" <urezki@gmail.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Bjorn
 Roy Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor Gross"
 <tmgross@umich.edu>, "Johannes Weiner" <hannes@cmpxchg.org>, "Yosry Ahmed"
 <yosry.ahmed@linux.dev>, "Nhat Pham" <nphamcs@gmail.com>,
 <linux-mm@kvack.org>
To: "Vitaly Wool" <vitaly.wool@konsulko.se>
References: <20250823130420.867133-1-vitaly.wool@konsulko.se>
 <20250823130508.867235-1-vitaly.wool@konsulko.se>
In-Reply-To: <20250823130508.867235-1-vitaly.wool@konsulko.se>

On Sat Aug 23, 2025 at 3:05 PM CEST, Vitaly Wool wrote:
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index b39c279236f5..808bd4281164 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -41,6 +41,11 @@
>  pub struct Flags(u32);
> =20
>  impl Flags {
> +    /// Create from the raw representation
> +    pub(crate) fn from_raw(f: u32) -> Self {

The argument shoould probably be of type bindings::gfp_t instead. However, =
the
alloc::Flags type itself uses u32. So, for this patch using u32 is fine. Bu=
t I
think in general we should fix this up.

> +        Self(f)
> +    }
> +

I think you forgot to document that the given value must be a valid combina=
tion
of GFP flags.

Please also write full sentences and end them with a period.

