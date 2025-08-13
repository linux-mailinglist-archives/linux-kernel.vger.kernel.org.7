Return-Path: <linux-kernel+bounces-767180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F32B2501A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82F03AF459
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E0E28936D;
	Wed, 13 Aug 2025 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RguiXv+U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D272DF68;
	Wed, 13 Aug 2025 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755103745; cv=none; b=GrdMyOYUXLlFeY8+R1qihVLXs/gjB86Jh+uyWe57lQlf5H/jb2k9Y4M6eRb3d9OGWZ8kWbjkfD3G19gVYxrdecX64j6yXUKb21//eVIymfEyeJgVE+w7Af8cC+nOVYZJZy+KfXsp3ZzQLRJxpYB7zC7Ru68n3njz4ase6Y8ygs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755103745; c=relaxed/simple;
	bh=cyLrFdqxg4ZcH8nvggubxn/CxJcfjbfe1JuA4ehDYXQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=FlScgC96Krz/mlLkiN5PrpIbI99vMPHdhPs5+AJHhtMbI+jpNpIX2ty/aEuDqDUdh+mnpu2NEDfGlWQq+q0dvppP6QiQd++QT2IkqsDSxQcZaYHBbM9ynTWfBqAFXp/MA46MNqzByVjU/zettxIlOkmCci9chjDjghucjVYOq5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RguiXv+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382C2C4CEEF;
	Wed, 13 Aug 2025 16:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755103745;
	bh=cyLrFdqxg4ZcH8nvggubxn/CxJcfjbfe1JuA4ehDYXQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=RguiXv+UZoL+5Vf31csyIKrWunI2aX3ipzcjHK5Kyy9/TsmFF46g5XjoQamZStLtI
	 eRMI0tsEpu1+rngNBb27ZSZAcg2XutpBc8Wh7jxBNkmljUEmXVrNV7nTxZSMoK4J+i
	 VrRmXeieHSnbweU3unIIizYq7jbHTbcNxjKoBeN7shrbvGnL8aZBbtVQ4NFTimeeIJ
	 zRWusjneQDhKYrdo5ws2NbSKAHUOSKOf6mhQjUY013m7N9hVBsoq0NBLIu8cQNJJ/5
	 s/aISnoOB2FxjhsjNUmox3r5TF4+V+DazWKzvgD4LkIydtpFX9oV0I2KKSZsxx1o26
	 H5IZsphCZYhBQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 18:48:59 +0200
Message-Id: <DC1GCMZDC5GE.2IJ4JAIWRO8HZ@kernel.org>
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
 <DBQ4N5NCU8H5.356OH5T3KRGJ1@kernel.org>
In-Reply-To: <DBQ4N5NCU8H5.356OH5T3KRGJ1@kernel.org>

On Thu Jul 31, 2025 at 11:19 AM CEST, Danilo Krummrich wrote:
> On Thu Jul 31, 2025 at 4:50 AM CEST, Hui Zhu wrote:
>> From: Hui Zhu <zhuhui@kylinos.cn>
>>
>> Add a test module to verify memory alignment guarantees for Rust kernel
>> allocators.
>> The tests cover `Kmalloc`, `Vmalloc` and `KVmalloc` allocators
>> with both standard and large page-aligned allocations.
>>
>> Key features of the tests:
>> 1. Creates alignment-constrained types:
>>    - 128-byte aligned `Blob`
>>    - 8192-byte (4-page) aligned `LargeAlignBlob`
>> 2. Validates allocators using `TestAlign` helper which:
>>    - Checks address alignment masks
>>    - Supports uninitialized allocations
>> 3. Tests all three allocators with both alignment requirements:
>>    - Kmalloc with 128B and 8192B
>>    - Vmalloc with 128B and 8192B
>>    - KVmalloc with 128B and 8192B
>>
>> Co-developed-by: Geliang Tang <geliang@kernel.org>
>> Signed-off-by: Geliang Tang <geliang@kernel.org>
>> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
>> Reviewed-by: Kunwu Chan <chentao@kylinos.cn>
>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
>
> @Andrew: Can you please pick this one up once we land Vitaly's series [1]=
? I'll
> take the other two patches of the series through the Rust alloc tree once=
 -rc1
> is out.

Just a reminder for this one to be picked up; I gave it a quick shot on top=
 of
mm-everything and everything looks fine..

> [1] https://lore.kernel.org/lkml/20250730191921.352591-1-vitaly.wool@kons=
ulko.se/

