Return-Path: <linux-kernel+bounces-810434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF63B51AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C87188EA29
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F4C3375D1;
	Wed, 10 Sep 2025 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ydi+fp1J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8618345759;
	Wed, 10 Sep 2025 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515655; cv=none; b=P6Ystt3swgnKstz2cPK0W+LJ4q4sl5MnQw1TH81O4/+A50JXE3kE6d8pFaAaVl6kfaGF0ExrEoFb3SpBU4NiqcbWSMR6bKszk7Ye7jIGIaVVCuatC1OatrcWyxup5M3bRNXSB+k/y8ZAPFs9nH6LpOoqm8kdoRF2wc6zSqpHY/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515655; c=relaxed/simple;
	bh=zTgMOjpepBy/l2UTo0fo6Ntsz4DK/OWhGhpf4R9a+4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6xsLsEpLKrHpcfIxLLsf0nPIDL6km+sChoch8nY0eK9atP/yifLIr8yOI6ERdwZxNYHzFcH+MoO/Pmw8VCOEStASoaEN5dnXvoCv+I1OQnkGr45Y+ETGcX3qDb/icVNxc0gEdplpMakRXX80Vh/7SC+UZyXmtv3vL4DecF8E18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ydi+fp1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F3FC4CEEB;
	Wed, 10 Sep 2025 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515655;
	bh=zTgMOjpepBy/l2UTo0fo6Ntsz4DK/OWhGhpf4R9a+4k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ydi+fp1Jt87eJIKw8OFpw6tqu5Ch9Xe+ed5u5rKbNYXbeiJj01R2EEYYCcZvVED7Z
	 kCSgvu08M9lTjNORFJ/abqMnjgCBSymroRe2aYkpEIDXk1sr4LJ0QKUq5EUxXQZZIh
	 EfocJdkvV8gq15uqw5vP8eGlUphjSvBoOBUhWc39RlNXVcY4j136finQanDvzcSTVO
	 XAmmLe890dR7Yg9Yg77vM9J49jXZ0ZLYyjmzcZT3M2VdyBlO6mcBPg4KO9zwcKfJ0q
	 qXkCreeNAnKE4gYgtruK9cBQ/wXwLnyvYhW1te+QoT32dkdJ8KcfEflTZVaL+YjfSX
	 CKcGg8txQGOOg==
Message-ID: <a82b9810-c3f5-4351-a796-e639c937f4d7@kernel.org>
Date: Wed, 10 Sep 2025 16:47:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rust: drm: Introduce the Tyr driver for Arm Mali GPUs
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Daniel Stone <daniels@collabora.com>, Rob Herring <robh@kernel.org>,
 Beata Michalska <beata.michalska@arm.com>,
 Carsten Haitzler <carsten.haitzler@foss.arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Ashley Smith <ashley.smith@collabora.com>,
 Steven Price <steven.price@arm.com>, Jeffrey Vander Stoep
 <jeffv@google.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, kernel@collabora.com
References: <20250910-tyr-v3-1-dba3bc2ae623@collabora.com>
 <b44ca395-102e-4780-949d-9d656ba18ec0@kernel.org>
 <50CC05D3-CCF5-44AA-9E8A-71DA8733B78E@collabora.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <50CC05D3-CCF5-44AA-9E8A-71DA8733B78E@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 4:43 PM, Daniel Almeida wrote:
> Fair enough, perhaps a quick v4 then?

In case this remains to be the only change you could also fix it up on apply.

