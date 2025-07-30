Return-Path: <linux-kernel+bounces-750388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 354D4B15ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E5D16AE76
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3627D2698AF;
	Wed, 30 Jul 2025 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vF2pkR1H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EA5257AF8;
	Wed, 30 Jul 2025 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864267; cv=none; b=skBFx8YneWrVbnIClVmYVg+VxBwRJpctBS5aD4ze/tQa20pdU9smW4hecnDgDWdzqMopl2dhZ8IwFNSYFDSKcidFxAEX2QI9VBfLdK04oUpMYwvn9xZAGOqOi4QIbM7+kp+Topz3iVfCRkZvZqeckFDKvpSVTBiKSZXmhwdVPak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864267; c=relaxed/simple;
	bh=ImNBNJVfHOgZXj1R7QQgk2tUvC+ihptpElm/Eri/mE4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=NXEhW/kqhHFKezQmVpcmB7OA4R7zpXnQzjtRF7Qk4fClaJ6bP64tFcwTlboan6GNYKIvuxUPlvJLUQCcHUGxXZA6+VrpB5qiR0uPfpht9Q49ZraMxCkA1PTLq3P6aYMphVwIir6AfHiIrkMeuHfy70dPtLK2ZSzxI5TLJ9Je4s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vF2pkR1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6521DC4CEE7;
	Wed, 30 Jul 2025 08:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753864267;
	bh=ImNBNJVfHOgZXj1R7QQgk2tUvC+ihptpElm/Eri/mE4=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=vF2pkR1Hh2gOUnDYIlx2i8TooLmDcwpu7iaotOdaw6ePjD0S/jswecDxKrApzfTTm
	 NuhoQcGWwoCl+KClPb455smW3MW34h7fswjoRzV7JwXFPLug8kvuwAsFK1wNJmNtlV
	 uNx5ed4w8Pgp5Mdp8o+N0n0wiyuUVK4vLNGwrvwd1rPfTG4EkoJwPD9ra5tcsJYhtc
	 QDu/EX5m+jBsSQEDbaVps2P2OtAHacJwhPYlaPtpPKII+cd07qmtfROxxzLvu9Mydv
	 KZQUBsC216kZOrOa+hGMba/tnZV1718oJRJ8botMFVFHmd6zg64mhhDFmmFo4O6Rz7
	 H2K68mrPI6F4w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Jul 2025 10:31:01 +0200
Message-Id: <DBP8ZQROZGWT.2B5MMHSLJABRP@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v6 2/2] rust: alloc: kvec: add doc example for as_slice
 method
Cc: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Vlastimil Babka"
 <vbabka@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <akpm@linux-foundation.org>, <vitaly.wool@konsulko.se>, "Hui Zhu"
 <zhuhui@kylinos.cn>, "Geliang Tang" <geliang@kernel.org>
To: "Hui Zhu" <hui.zhu@linux.dev>
References: <cover.1753841900.git.zhuhui@kylinos.cn>
 <786e88abea2557080bde65fa9892df3b956731f2.1753841900.git.zhuhui@kylinos.cn>
In-Reply-To: <786e88abea2557080bde65fa9892df3b956731f2.1753841900.git.zhuhui@kylinos.cn>

On Wed Jul 30, 2025 at 5:35 AM CEST, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> Add a practical usage example to the documentation of KVec::as_slice()
> showing how to:
> Create a new KVec.
> Push elements into it.
> Convert to a slice via as_slice().
>
> Co-developed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>

Thanks -- I will pick this one up after -rc1 is out.

