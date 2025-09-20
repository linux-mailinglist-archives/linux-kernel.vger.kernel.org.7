Return-Path: <linux-kernel+bounces-825880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52858B8D076
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3513F1B26F82
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF017273D92;
	Sat, 20 Sep 2025 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaYl1prG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4355426CE2B;
	Sat, 20 Sep 2025 20:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758398975; cv=none; b=AHEC2IOZqgCdesON4gSPGD0BXNGMBjA+eA9tqNL5mX/Gfo3bjL2sqbs1ta8pcud5Rls4dQZsQ6fVpkmeIbSo/F1+D96t11QDaRyl/VyGsc1dN0ehFE3Qo6iuACxrTsrQpNk6xUOeOkRX3wBzeQySO1idoKuZFCPv9BX7QLO+bdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758398975; c=relaxed/simple;
	bh=UYczj238EMmXB06ZCFNW6qheTg84pIjeQnt1Pz4yV8s=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Kgffa3TaZ64EjJS5G0HKT/0REt+BjHlmGezhQWvc5FB9LUWO5DehDws5csIwIao2fCMaCDpyfqkN4Yo4/Nb9H4SvnQf+U6Q748l4tyOHFMEowxxcoz8GIZs4t8zUuDTrpz+NzxXKRrLyP5/tYFmNAUMNtGlIJ+fsw3bEoTcd8Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaYl1prG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CB7C4CEEB;
	Sat, 20 Sep 2025 20:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758398974;
	bh=UYczj238EMmXB06ZCFNW6qheTg84pIjeQnt1Pz4yV8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uaYl1prGw8JEbDcc6Dch+vMdCKShafg4pgW7JDBOu+a2W0W94IvAkPJSLj2m2lZWj
	 zCLzymDqYbBiMlWunyw9AYz+xVIeDw12waeT9K/1KUBR5VywG0STv91U6DV2uwSXg3
	 gJT6iegOtsiDI7ZNIH6i/GEfELRXDmNIaUTvPWwN+ZbvFdUQHYKvqxw9/noQ2rIuYL
	 jMWw/QT5//zWx70Gipaayl6pR60WQ/q+fKTtnvI25Ncr2/s9J9OxbJjuuTVy3SswBc
	 /nk/h9yH0/78w1I0ASKAp7cYXqmw2hKn7JNpbGRZi/Cpx1c4f8xQC4BG9SI/BVULYb
	 AWOa6mEKg2GdQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 20 Sep 2025 22:09:30 +0200
Message-Id: <DCXWEV3YO443.2EUZL32P96Z0D@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>,
 <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>
Cc: <acourbot@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] rust: print: Fix issue with rust_build_error
X-Mailer: aerc 0.21.0
References: <20250920161958.2079105-1-joelagnelf@nvidia.com>
In-Reply-To: <20250920161958.2079105-1-joelagnelf@nvidia.com>

On Sat Sep 20, 2025 at 6:19 PM CEST, Joel Fernandes wrote:
> When printing just before calling io.write32(), modpost fails due to
> build_assert's missing rust_build_error symbol. The issue is that, the
> printk arguments are passed as reference in bindings code, thus Rust
> cannot trust its value and fails to optimize away the build_assert.
>
> The issue can be reproduced with the following simple snippet:
>   let offset =3D 0;
>   pr_err!("{}", offset);
>   io.write32(base, offset);

I took a long time to understand this and I think I got it now, but
maybe I'm still wrong: passing `offset` to `printk` via a reference
results in the compiler thinking that the value of `offset` might be
changed (even though its a shared reference I assume). For this reason
the `build_assert!` used by `io.write32` cannot be optimized away.

> Fix it by just using a closure to call printk. Rust captures the
> arguments into the closure's arguments thus breaking the dependency.
> This can be fixed by simply creating a variable alias for each variable
> however the closure is a simple and concise fix.

I don't think this is the fix we want to have. In fact it already
doesn't compile all of the existing code:

    error[E0277]: the `?` operator can only be used in a closure that retur=
ns `Result` or `Option` (or another type that implements `FromResidual`)
        --> rust/doctests_kernel_generated.rs:3446:70
         |
    3446 |     pr_info!("The frequency at index 0 is: {:?}\n", table.freq(i=
ndex)?);
         |     ------------------------------------------------------------=
-----^-
         |     |                                                           =
     |
         |     |                                                           =
     cannot use the `?` operator in a closure that returns `()`
         |     this function should return `Result` or `Option` to accept `=
?`

(originating from `rust/kernel/cpufreq.rs:217`)

Can't we just mark the pointer properly as read-only?

---
Cheers,
Benno

> Another approach with using const-generics for the io.write32 API was
> investigated, but it cannot work with code that dynamically calculates
> the write offset.
>
> Disassembly of users of pr_err!() with/without patch shows identical
> code generation, thus the fix has no difference in the final binary.
>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

