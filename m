Return-Path: <linux-kernel+bounces-771313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E35EB28569
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65AF07B65E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2114C24EAB1;
	Fri, 15 Aug 2025 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4KIXUh7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2E8317708;
	Fri, 15 Aug 2025 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755280388; cv=none; b=AsGk5blgSv0WzWvQJxoW789K2pVE+uOUPYt55uBN4J4v/aBzCWH8+96y4/VwBbALYBzORUOT8pzmyuPC2j1q+NJ1m5sJS80t/NWhkD3EUgrwuZPyT+EiRo2xicy56/R+JCoRfbdx/nJCe1PujZHC/VgA5ONFXk/F/arkpuHwDxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755280388; c=relaxed/simple;
	bh=I0SM7tGJd1g8plMRyHpN9cdRWH3CB7GXBW84nBIpmL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2zHusKM1gQrxlaiBqRAL23M6ajYouR3lcR9ZeoiUaQxjPYvNSJSdfH/0P4MvxQZtuNbTaBvE/DNNcoZxrqhQiAX3h483dR41RwudU427wPCkORVFhDuXc+r8qfXnd1+5KvkPmcdKjz0QwLBq9MMWGPWzJLWQ62fiJC35L02HSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4KIXUh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9263C4CEEB;
	Fri, 15 Aug 2025 17:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755280388;
	bh=I0SM7tGJd1g8plMRyHpN9cdRWH3CB7GXBW84nBIpmL0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q4KIXUh7hkOeVYioGCWAbrslaSjhPXyLKJu9XEzjyd531HNLFq285zvlBcmvW8mSp
	 rQ5Xq+5Yntlrcz/NMWkhQ3l7S+nrW7Eo1xn2SA6iNFvTDrPSsmqkPwi9t0JiyDn6sn
	 PJRjzpXppDXWo4wIeo0bHu2hglMseRmrChX9QBW9p3naWyl3jrMdJ5BZQAG1LTFxqU
	 UfvGd8WCFRzkNw+9Yvd9DWNjRbG4aJLJKZFymZiMt5QZXhUV/11ZASPIxVMfA3eoKA
	 msLQbm/PqSApA8bwhpngBEQcXcKKhm6CjLiJLVwKgXJNWAgd5Fnw4WrR2vdIkOKIKC
	 vq4o7SGEaMTHA==
Message-ID: <86bd9285-e01a-412d-82e7-3927222199ee@kernel.org>
Date: Fri, 15 Aug 2025 19:53:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] Rust allocator and kvec improvements
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 vitaly.wool@konsulko.se, Hui Zhu <zhuhui@kylinos.cn>
References: <cover.1753929369.git.zhuhui@kylinos.cn>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <cover.1753929369.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/25 4:50 AM, Hui Zhu wrote:
>    rust: alloc: kvec: add doc example for as_slice method
>    rust: alloc: kvec: simplify KUnit test module name to "rust_kvec"

Applied to alloc-next, thanks!

