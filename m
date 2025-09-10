Return-Path: <linux-kernel+bounces-810772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F484B51F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D254E188E369
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E0C32F76C;
	Wed, 10 Sep 2025 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="hSyzMtbI"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B0125394C;
	Wed, 10 Sep 2025 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526143; cv=pass; b=hQSpmw27kTYQ49I1hAXbF/aqEz6FCaWvQGC6n0Gm25NQMDWgHB3Nbkh+J8vlyWwchNNsOcOscWHNdRwtsWsrqFtTnoZlLAr8JA1WWWjbwj02bmxf5vCcJeU2mCTjIWmeijVbvg1M++JOiFzBqS1eIoGK6IzcwR49JVmW1zilWmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526143; c=relaxed/simple;
	bh=zQlaRWnJj//treAKuHkkFltrIxd6OaARQvwe7u4Q0xo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mJDildN4gbIi0wlxjjCGRbGj6Nie6Rb2e72t3RF1iLZUQvKBx4hk9CviHxbEfE0FF6bKiY2Z2S7jGqglOD29Wv+zX+6I9DaZOtm3w6VuFqDk/ZPhcIQTpMZvzcK3V7abaSEom9b87UPzyhtwLuNGdb8ga3u5mv+ljIUcYlYTz3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=hSyzMtbI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757526123; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QgdvFLG0j3zGxahGJgPE6/1/iCYVQ5m0cDkLw/9Ci/ug4jLAPVFQGrqY3mRZVaWRRkpnZNeC9VQdL6gf//gCh7IYPpXTh0SwMXbuF8crV6TVPLa0aw4ptYeARNQWdwDUMg9+Rl9CHGakp0OiU2aXF58HhLBAbl4PD9XBx3+bHP8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757526123; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iXbdojAjKEXOgDS7WOKFscZO2BncParlgyIfZRo+PFk=; 
	b=IL12XJRIMLWfe7diS5YOz61RrxBzo4pjG5z+z6KOI1hwubid3gpdezbb69rj6M8Z5p10+DRzuK3wrz3HzRrAJb3LOJ5Gh0Ye8LIFMehjY42Sw+748EJI8BkTyRRUFZsOSxzBSLCYYV1D33DxhLBiX+LWkswLJH3LLKRiulOGJD8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757526123;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=iXbdojAjKEXOgDS7WOKFscZO2BncParlgyIfZRo+PFk=;
	b=hSyzMtbI230VucF1XZC+3/W5QTlRo8EYQYwV+6tPO+I5bpfhb91f1mTIQs3Jomyf
	tiscb86x/raTY3DcGZw84yJkitlancHg803SevgdB7LttwPqAUMNDHEdBjnXLMaQlRo
	XuoIoRn+BH2S3YdzOqftqjJjCn0vriQoG7gMUyvo=
Received: by mx.zohomail.com with SMTPS id 1757526120000964.3048533621404;
	Wed, 10 Sep 2025 10:42:00 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] rust: clk: implement Send and Sync
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250904-clk-send-sync-v1-1-48d023320eb8@google.com>
Date: Wed, 10 Sep 2025 14:41:44 -0300
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A9F1293F-2C48-455E-9905-8519318011B0@collabora.com>
References: <20250904-clk-send-sync-v1-1-48d023320eb8@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 4 Sep 2025, at 06:03, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> These traits are required for drivers to embed the Clk type in their =
own
> data structures because driver data structures are usually required to
> be Send. See e.g. [1] for the kind of workaround that drivers =
currently
> need due to lacking this annotation.
>=20
> Link: =
https://lore.kernel.org/rust-for-linux/20250812-tyr-v2-1-9e0f3dc9da95@coll=
abora.com/ [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> I'm not sure if there was already sent a patch for this. I recall
> being told that one had been sent, but I could not find it. Maybe I
> mixed it up with the regulator change, so now I'm sending a change for
> clk.
> ---
> rust/kernel/clk.rs | 7 +++++++
> 1 file changed, 7 insertions(+)
>=20
> diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
> index =
1e6c8c42fb3a321951e275101848b35e1ae5c2a8..0a290202da69669d670ddad2b6762a1d=
5f1d912e 100644
> --- a/rust/kernel/clk.rs
> +++ b/rust/kernel/clk.rs
> @@ -129,6 +129,13 @@ mod common_clk {
>     #[repr(transparent)]
>     pub struct Clk(*mut bindings::clk);
>=20
> +    // SAFETY: It is safe to call `clk_put` on another thread than =
where `clk_get` was called.
> +    unsafe impl Send for Clk {}
> +
> +    // SAFETY: It is safe to call any combination of the `&self` =
methods in parallel, as the
> +    // methods are synchronized internally.
> +    unsafe impl Sync for Clk {}
> +
>     impl Clk {
>         /// Gets [`Clk`] corresponding to a [`Device`] and a =
connection id.
>         ///
>=20
> ---
> base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
> change-id: 20250904-clk-send-sync-3cfa7f4e1ce2
>=20
> Best regards,
> --=20
> Alice Ryhl <aliceryhl@google.com>
>=20
>=20

I=E2=80=99ve included this on my series here [0], as it would otherwise =
conflict with the type-state work.

I did not see anyone against the type-state patch itself, so perhaps =
both can go together.

=E2=80=94 Daniel

[0]: =
https://lore.kernel.org/rust-for-linux/20250910-clk-type-state-v2-0-1b97c1=
1bb631@collabora.com/T/#t


