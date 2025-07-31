Return-Path: <linux-kernel+bounces-751859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AAEB16E57
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A3147A218B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73BA29E0EF;
	Thu, 31 Jul 2025 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uz7ACl2p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325191E571B;
	Thu, 31 Jul 2025 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953557; cv=none; b=Ige18S3JmEz6QoaMYR1wP0Ktr8hLZr48ERDK43hZjU/JVNwuPFRza1QpUeMY9nrYxn1qk46QhRcnxhu9QKRsGlmDKLHm6wQayRsAbKLpdh427bKBvNbfvfjnXJCMWiqaPm5RjtMOsUw/EaypWGlT3VMOPvb6VRWrjX7PEyIjiUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953557; c=relaxed/simple;
	bh=IzQM3tIFM174kzIiR7pD6odpuP6sYQLUGs0TfrEDGnU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ZAgpsUsFdC5DpEkKKj688Zb5HV/iym13xfZHttIU/j+AFHC7aE1fGE4RIBsHWKK1jIg8pmJ5VobdCG0V9OJHQ6FuCfdvegIuhcEgI+n51t8RGVMmas5WiNaqG4/0F6R0yrdN54hu2ZIxPeESOcbv4URI7WyNwWS0nnDeQujfQ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uz7ACl2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA07C4CEEF;
	Thu, 31 Jul 2025 09:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753953556;
	bh=IzQM3tIFM174kzIiR7pD6odpuP6sYQLUGs0TfrEDGnU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=uz7ACl2p+xVl7AquQs8bLHBUg7U/CyUt/sbGv/ykEOya8pttxW0qbUS+KhO2CwuWe
	 wf8r8DtY4oBxNQ6D2wM5A2c2ZFM7wOX9OD+jyeXpKhHosfVvy7LRrU73rFrqUS0WGR
	 /G3G6ZOVWcWcAz/qyzGQlqGEKMm+gahrAi7Spwq9Ecwcx+Yf4Qed6ABZxBdafVPFBE
	 wddpMWjtjM7HE8eNgE2MAEtJzlI8bXldVQ0vWCEqttpdOE3qjl9ng3O/ZxQzq8I2OQ
	 5RIdkMdKlKZWgtDUW1ebJ1s0l5TGWvDXKKlbfhiEMCLbPvvBUYVhb9fLWmDVha/Gi/
	 h9EDYhJ9kgsjA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Jul 2025 11:19:10 +0200
Message-Id: <DBQ4N5NCU8H5.356OH5T3KRGJ1@kernel.org>
Subject: Re: [PATCH v7 1/3] rust: allocator: add KUnit tests for alignment
 guarantees
Cc: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Vlastimil Babka"
 <vbabka@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <vitaly.wool@konsulko.se>, "Hui Zhu" <zhuhui@kylinos.cn>, "Geliang Tang"
 <geliang@kernel.org>, "Kunwu Chan" <chentao@kylinos.cn>
To: "Hui Zhu" <hui.zhu@linux.dev>, "Andrew Morton"
 <akpm@linux-foundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <cover.1753929369.git.zhuhui@kylinos.cn>
 <d2e3d6454c1435713be0fe3c0dc444d2c60bba51.1753929369.git.zhuhui@kylinos.cn>
In-Reply-To: <d2e3d6454c1435713be0fe3c0dc444d2c60bba51.1753929369.git.zhuhui@kylinos.cn>

On Thu Jul 31, 2025 at 4:50 AM CEST, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> Add a test module to verify memory alignment guarantees for Rust kernel
> allocators.
> The tests cover `Kmalloc`, `Vmalloc` and `KVmalloc` allocators
> with both standard and large page-aligned allocations.
>
> Key features of the tests:
> 1. Creates alignment-constrained types:
>    - 128-byte aligned `Blob`
>    - 8192-byte (4-page) aligned `LargeAlignBlob`
> 2. Validates allocators using `TestAlign` helper which:
>    - Checks address alignment masks
>    - Supports uninitialized allocations
> 3. Tests all three allocators with both alignment requirements:
>    - Kmalloc with 128B and 8192B
>    - Vmalloc with 128B and 8192B
>    - KVmalloc with 128B and 8192B
>
> Co-developed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> Reviewed-by: Kunwu Chan <chentao@kylinos.cn>

Acked-by: Danilo Krummrich <dakr@kernel.org>

@Andrew: Can you please pick this one up once we land Vitaly's series [1]? =
I'll
take the other two patches of the series through the Rust alloc tree once -=
rc1
is out.

[1] https://lore.kernel.org/lkml/20250730191921.352591-1-vitaly.wool@konsul=
ko.se/

