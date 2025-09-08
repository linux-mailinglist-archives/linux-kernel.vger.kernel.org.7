Return-Path: <linux-kernel+bounces-805591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B46E3B48A9C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC343C6380
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540CD224B12;
	Mon,  8 Sep 2025 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ru/psgNw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9239189;
	Mon,  8 Sep 2025 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757328892; cv=none; b=k3xlcXWA6sr9ZOBRAZ2Rc+zRe9uxF1eiFb7SQGQkaS1u+LhwrLULBHwcLw1VJuAY3rC5Lws9bTNcl9v3MV8Ku+7tpPDz98tSbHaDM6gW0ak5HI25fOmgKE1iuiYudZmSPdgzNvMln5rzqE9O27x2H152ERA4tzrPb0DkBhnXe2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757328892; c=relaxed/simple;
	bh=hlWRmP89svceQHxhWRC8JmwmeGVsWRQ8ttOXrLBPQaI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=iF9byY/vdhFEsLEiVABWUxE/8N/YoNeeITEFilhWQ4HOPFpe1Hv4x7HdC7g7T/Z7mEcnIwuRj2QJecDJ1MfaiZOBR2NmpSuS7zH5h7OqHNse5xswNC3SEUhTJd0XX0yq5JNwH37Ej4b1OrGaOUetRPRA+eRW9LgRubZROxOj994=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ru/psgNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E58C4CEF1;
	Mon,  8 Sep 2025 10:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757328891;
	bh=hlWRmP89svceQHxhWRC8JmwmeGVsWRQ8ttOXrLBPQaI=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=ru/psgNwnsQURHU7EB4hRIrfDMZIjIFIs+UysEYBN+Rv0uXyOPVaQ0pxwhkeAFLmf
	 F+E2fqKln9Q5y45IC2hUaNLExi2LSDxuXjs6+ayh6S9aP6O7aBvq24uyvFUyDpg3ri
	 vuDQxmNCSz9RtwWt+o3Z+y2HU4e617Y2jaQqcVXfRL7Gdh7l/kjm8SVptCMsrC4EQQ
	 TM3LMK58yt4uZdJkoXlKE+bZf203HqluJ1LDA1YgfGsqXQejEZj58q+MI96DeFghiU
	 2l+MxgGCLDi1Bgniwm2fqLeArciv9OY5NM7MjDry6HB53UTaYkCRiCyjpKO7l40K6W
	 YD8W8tg8k9jcg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 12:54:46 +0200
Message-Id: <DCND3LBZ0Y2J.377ZTOSOUXMOB@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v11 2/7] rust: debugfs: Add support for read-only files
Cc: "Matthew Maurer" <mmaurer@google.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Benno Lossin" <lossin@kernel.org>, "Dirk Beheme"
 <dirk.behme@de.bosch.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-2-7d12a165685a@google.com>
 <2025090807-bootleg-trophy-a031@gregkh>
In-Reply-To: <2025090807-bootleg-trophy-a031@gregkh>

On Mon Sep 8, 2025 at 12:17 PM CEST, Greg Kroah-Hartman wrote:
> I tried using this in a "tiny" test module I had written, and I get the
> following build error:
>
>    --> samples/rust/rust_debugfs2.rs:64:53
>     |
> 64  |         _file =3D root.read_only_file(c_str!("name"), &hw_soc_info.=
name);
>     |                      --------------                 ^^^^^^^^^^^^^^^=
^^ expected `&u32`, found `&&CStr`
>     |                      |
>     |                      arguments to this method are incorrect
>     |
>     =3D note: expected reference `&u32`
>                found reference `&&'static kernel::prelude::CStr`
>
> I'm trying to "just" print a CStr, which is defined as:
>
> struct HwSocInfo {
>     id: u32,
>     ver: u32,
>     raw_id: u32,
>     foundry: u32,
>     name: &'static CStr,
> }
>
> Is this just a "user is holding it wrong" error on my side, or can this a=
pi not
> handle CStr values?

What you're doing should fundamentally work.

The above error suggests that your declaration of `_file` is File<&u32> rat=
her
than File<&'static CStr>.

Also note the double reference you create with `&hw_soc_info.name`, this sh=
ould
just be `hw_soc_info.name`.

You can also test this case by applying the following diff the the sample i=
n v5:

diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
index b26eea3ee723..475502f30b1a 100644
--- a/samples/rust/rust_debugfs.rs
+++ b/samples/rust/rust_debugfs.rs
@@ -59,6 +59,8 @@ struct RustDebugFs {
     #[pin]
     _compatible: File<CString>,
     #[pin]
+    _test: File<&'static CStr>,
+    #[pin]
     counter: File<AtomicUsize>,
     #[pin]
     inner: File<Mutex<Inner>>,
@@ -140,6 +142,7 @@ fn new(pdev: &platform::Device<Core>) -> impl PinInit<S=
elf, Error> + '_ {
                         .property_read::<CString>(c_str!("compatible"))
                         .required_by(dev)?,
                 ),
+                _test <- debugfs.read_only_file(c_str!("test"), c_str!("so=
me_value")),
                 counter <- Self::build_counter(&debugfs),
                 inner <- Self::build_inner(&debugfs),
                 _debugfs: debugfs,


