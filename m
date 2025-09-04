Return-Path: <linux-kernel+bounces-800757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6156DB43BA6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E3927AD477
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6981D2EC088;
	Thu,  4 Sep 2025 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="DXSRcE13"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE67032F77B;
	Thu,  4 Sep 2025 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756989128; cv=pass; b=bIDleio4crpjcePiC4YrrINtzb9mntOKMRSVdY4+Pm1deB8E1lh1dxOn2fm+EB9ddUna4lARwn7WHcenTwqdafVXHBu/WJPLhrAAxNxWw/o8PPAcfWaGA85m1eHTkcQYlqKC/3GZjV10ddGqtIZCTJ4Dnpt7Bc2ZkauryhTaE84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756989128; c=relaxed/simple;
	bh=6FbDbPZobxC9svGYjuKWJ/ikHmQK3ctj8zeP21jLaCg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NRUv6/WyVd35c0yU++PsC6Nw80xhIJZgXeOyHljckGPOQXClKBUPq3ivLCZSgbjRDV+RiyArd5D6Zo+RGCeCmEwsB55lp15nzQF95qLu+HvF4mZLPc1Ju8sUNxnSkatWXrc0ia+PsET2pILedOM//NnxbRWVHkYQ8IIzFHmu/WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=DXSRcE13; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756989107; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HOWhScNr1wUvSa2o7O6Nrjk5oGJKC1MWxnfDk3MXMn7bSpJJpe4wHWrf+HFQsj76VqjQdHdtXw2IDZCB1cxHaFtSRPRWwDZITaPjfeUm5z68vf44I53UtjmaOV3LL/bjXV9upJ2EpnBEgynObqyHczbtYlf7pQofEFBlmXYKers=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756989107; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vOiTWYBCudswC5h85TFZHJnqluWo4OG28H4xN4hnraw=; 
	b=ZfpnbYVVbnGBwkjajb3iF7SXSwtTMiGL5LYHVKbsUgHEkysmqcp0MhtOj2Y4QlVYdaZdpYtJ3g+1i6JcTw3q7PRc0gk+vLUVeOWekYkkjMDNNDbtolmR6g9eB1qdYRU4IGxjewrqzcSDF6y/kZirfSeYF0m270m/jMerFE+EA80=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756989107;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=vOiTWYBCudswC5h85TFZHJnqluWo4OG28H4xN4hnraw=;
	b=DXSRcE133DVP4VHZCyFZ4QgZdH5ma3wFjoErAFCvUEPW0OgBk8GX4njBRNwH6hsE
	/REA+Nq4CqwuBy7kxO9pVOkA7MbyHTzpUarkQ6JMQvNzpeBajQLLVrSONme2UkTXzdB
	XxM/s7k66dHzVFhPtAJF4iHTrYFvoPegLdwSqEGM=
Received: by mx.zohomail.com with SMTPS id 1756989104182732.7086986239485;
	Thu, 4 Sep 2025 05:31:44 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] rust: clk: implement Send and Sync
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250904-clk-send-sync-v1-1-48d023320eb8@google.com>
Date: Thu, 4 Sep 2025 09:31:28 -0300
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
Message-Id: <CB9F3786-48F0-46EE-BE61-8823E437C786@collabora.com>
References: <20250904-clk-send-sync-v1-1-48d023320eb8@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Alice, good catch, this is indeed missing.

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

Can you base your change on top of [0]? Otherwise it will become stale =
rather
quickly, as this introduces new types, i.e.: Clk<Unprepared>, =
Clk<Prepared>
etc.

I will push out a new version today.

[0]: =
https://lore.kernel.org/rust-for-linux/20250729-clk-type-state-v1-1-896b53=
816f7b@collabora.com/=

