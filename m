Return-Path: <linux-kernel+bounces-837739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97371BAD142
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD16179452
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADE03043C5;
	Tue, 30 Sep 2025 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVg3YPvJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7EF303A28;
	Tue, 30 Sep 2025 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759239202; cv=none; b=W6SHi5NzGESAAi6ml18NO/jyAHdyacx4KJiR30G3mkuim/xzawMkOvg+k3McxyahbRHa+pZHBj6Ar/Foan0U4XjEayzPz0RkszF6pFJEtNti+6oOWdoN9Tzho/5g+H76hgntVVFZjlhyI8fC0lgbgktAXXm3UVpXVrTgDJQy5OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759239202; c=relaxed/simple;
	bh=NY2y7Jz5GgASnYRyJboqRCOUSD4T65Ns4wrXLNI5n+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z45QnDEmfvLn6YqRzk/8+JX+myedxkX1bXw9aqJoJlLoVyX14fl234YH5bjZLDzxmD01aUFHVH/Z1dtqgJDYUNooKLhXiDMpu7vTR6rD/4Ukz1mczEgMwRf22gYkwgdr9d2/SZcnguYEuMxVdwwS9OM3Qu8F1/WNLF3DCeGO4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVg3YPvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6581FC4CEF0;
	Tue, 30 Sep 2025 13:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759239199;
	bh=NY2y7Jz5GgASnYRyJboqRCOUSD4T65Ns4wrXLNI5n+o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EVg3YPvJCc2gS1ugHk6BS2W/KEICBXpEe1SI6JQtpLRH+ZuKL7FW8Yu/lPFS/aQc4
	 5YKn6t4ac5QdR3F4pGwY6oCk2gs/3c6jE4FoxW+BQsqZbTiZ7zpJwheP4vgNx7od/Z
	 ZAUTQJD11urfAHI7QyQ6MtCHtRv6sJ6YjJPO1I/7JhAeeTDhn3PNm+Q3zHeTSZW1Xm
	 KHEIQ/c9uyuKEoAw2v/ucxn7hwE1NTiFbTwQxkcj7cqIS2gGU9Y4LnPDJqMtLJl6ZV
	 Ese7mMZBAPa1tg6yqBC3tGJuwVahzGVHoOLQSG1EE0ZVUYT2bh62fmg+m8PrBX1yLc
	 xmgOqFAyOu0TA==
Message-ID: <5bd04709-55ff-4d4d-9559-3ae55fb42c9a@kernel.org>
Date: Tue, 30 Sep 2025 15:33:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] gpu: nova-core: Add GSP command queue bindings
To: Alistair Popple <apopple@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 acourbot@nvidia.com, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 John Hubbard <jhubbard@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org
References: <20250930131648.411720-1-apopple@nvidia.com>
 <20250930131648.411720-6-apopple@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250930131648.411720-6-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/25 3:16 PM, Alistair Popple wrote:
> +impl GspRpcHeader {
> +    pub(crate) fn new(cmd_size: u32, function: u32) -> Self {
> +        Self(bindings::rpc_message_header_v {
> +            // TODO: magic number
> +            header_version: 0x03000000,
> +            signature: bindings::NV_VGPU_MSG_SIGNATURE_VALID,
> +            function,
> +            // We don't ever expect to send a command large enough to overflow.
> +            length: (size_of::<Self>() as u32).checked_add(cmd_size).unwrap(),

This is pretty much equivalent to "we never expect to make any mistakes, hence
just crash the kernel". Please handle errors gracefully.

