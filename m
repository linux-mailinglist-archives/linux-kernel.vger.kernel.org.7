Return-Path: <linux-kernel+bounces-751527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 002E3B16A92
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF27F567A55
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D923023AB95;
	Thu, 31 Jul 2025 02:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A9/kpAki"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BE2236A9F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753930454; cv=none; b=oMqMjRavcViQSNMdFuxBzJKFB79kBk/Ns/q+ZD5YNU4Rv/LOKhTyH/greecJz/Vk33ZDdGqG2hDciI69RZ8sAokEqHm5335m1n+qN6TL193gfumFDVvgSG5jZNatFKHwjbWaDWWfeMtt72ijXlI3c1GPmKJ4tKkDyPmLcDlGwGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753930454; c=relaxed/simple;
	bh=sYf7h63UXU5Ll7rDbTQJurmKzl8F/uHFnaMNebLZmZk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=getz5p+qDsx1Ggyr3+w+gACZDPLV0pDApLaL2apXRsS6iBCRaRS4/kvJvokMycapdyUPnqzHDkR8LNMEj/FbNkqGEFT3QKZr+dJ+Ldqv86T1Aa1m+uAhznotoczefM3+jmkHRapSrV/7V97XMTPxGlSf7chu2N2CYNEX3pc9Dh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A9/kpAki; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753930450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sYf7h63UXU5Ll7rDbTQJurmKzl8F/uHFnaMNebLZmZk=;
	b=A9/kpAkiwVAdckfymzW69ghz3lI9VqPxdLor7pldQ/lUlwUEfoAk3GSblaChyfScDaqRrM
	WnSBGhzNcwAgTyv8PEDSx1nHuNUyyBUYzdQXcaWLXekeW9aLQxGkqTyopjK4kcYvlJ6VZ4
	K+VjvPE2DRJMF0VqDrq4u8M9+IxcpQo=
Date: Thu, 31 Jul 2025 02:54:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Hui Zhu" <hui.zhu@linux.dev>
Message-ID: <95a767bbc1b136b1f3770965577a1072d75b8c68@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v6 1/2] rust: allocator: add KUnit tests for alignment
 guarantees
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>, "Liam R
 . Howlett" <Liam.Howlett@oracle.com>, "Uladzislau Rezki"
 <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, bjorn3_gh@protonmail.com, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, vitaly.wool@konsulko.se, "Hui Zhu"
 <zhuhui@kylinos.cn>, "Geliang Tang" <geliang@kernel.org>
In-Reply-To: <CANiq72n_RnW=zma48X-txV-4AUDU9j0YGmYNBFYQ1CG3oxROJQ@mail.gmail.com>
References: <cover.1753841900.git.zhuhui@kylinos.cn>
 <3ad14f15b6d2639d6e998ecd03158313414b69dd.1753841900.git.zhuhui@kylinos.cn>
 <CANiq72n_RnW=zma48X-txV-4AUDU9j0YGmYNBFYQ1CG3oxROJQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

2025=E5=B9=B47=E6=9C=8830=E6=97=A5 17:16, "Miguel Ojeda" <miguel.ojeda.sa=
ndonis@gmail.com mailto:miguel.ojeda.sandonis@gmail.com?to=3D%22Miguel%20=
Ojeda%22%20%3Cmiguel.ojeda.sandonis%40gmail.com%3E > =E5=86=99=E5=88=B0:


>=20
>=20On Wed, Jul 30, 2025 at 5:37 AM Hui Zhu <hui.zhu@linux.dev> wrote:
>=20
>=20>=20
>=20> +#[macros::kunit_tests(rust_allocator_kunit)]
> >=20
>=20Is there any reason for the `_kunit` suffix? If not, then we should
> avoid suffixing `_kunit` to every suite name.
>=20
>=20I see we already have `rust_kernel_kunit`, but that one is because it
> is the KUnit file itself.
>=20
>=20There is also `rust_kvec_kunit`, but we should clean that one up.
>=20
>=20>=20
>=20> + fn test_alignment() -> Result<()> {
> >=20
>=20`-> Result` since the prelude is available.
>=20
>=20>=20
>=20> + fn alignment_valid(&self, align: usize) -> bool {
> >=20
>=20We typically prefix these with `is_`.
>=20
>=20I would also call it `is_aligned_to`, to match the upstream Rust one,
> which we could perhaps use if it becomes stable.
>=20

Hi=20Miguel,

I sent the v7 version according to your comments.

Thanks,
Hui

> Cheers,
> Miguel
>

