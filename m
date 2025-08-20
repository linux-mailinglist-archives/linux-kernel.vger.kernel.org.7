Return-Path: <linux-kernel+bounces-778675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C18BB2E8BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C88627B33D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F9D2E173B;
	Wed, 20 Aug 2025 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZxPOTpZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD642DE702;
	Wed, 20 Aug 2025 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733128; cv=none; b=NyTocBucg8cxTiYXj/6L3mLzsG0hTAtpLVDim55CaHDEkTSVJCNdqLNXCVA0z8lVr7Ifnuh4b470j0XABHW751IfKn/xY5i0HBdHGtEpZK9qW4WV+AjJYWovMud+/2rJA+lrOijTw68AY8cC1zDuLkD92MXeNp3HN9e/9VQIGr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733128; c=relaxed/simple;
	bh=XjKLPIJpPl8XNfbf0L8f2m+lNzBLHaWsnTNgo9GwnVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjgenLhOrW9TXo6PW0a8SDF/Uj3As7MHoYN1vaSjEVzWSBK/Nh/g5ylSWSVsuOpD0qskK7BGludFp+Tk1mpV5AtTET4Qmz38FMC/KVbe6RFmi+ymMjAENj7jd9uOaLjN48ue99PYcCmRrkXsY64DRXjmwReiGcJVj0PrrwPgA3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZxPOTpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9F2C4CEE7;
	Wed, 20 Aug 2025 23:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755733128;
	bh=XjKLPIJpPl8XNfbf0L8f2m+lNzBLHaWsnTNgo9GwnVE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BZxPOTpZJxvSFocTM9w9CIuObkM0bYYsWS2CYPaNUfIdG/Nd4Wl83e2ZR0kkxFnTi
	 c7uydLc9kmaKJEjtXr7XDmtoyQvgvdq85Cg/1+JJLBrmrQpkYApdgUq/zYXKwlqIt3
	 IDtxr17v74sWirsYaxBQD/Mn3mPcR4G6sTd5YStRpcTDEM96R7n8hEtKmePi49Wm+6
	 niLG1HW6pYuMQpjdprMHzF349b6YN1QTUdWZtEBYpIFLQHQL5xxLw1jLBZ2wFzyz8+
	 DuKKYLT/OglbAp6R0R4yVFQb1BOTyNBlGjkQ9pQVdCsJ7Wou2EhhHhjoFEE0tzKFh4
	 QyOkYh4V8KykA==
Message-ID: <e2bb7c12-235c-4b2b-823a-363d22c6a13e@kernel.org>
Date: Thu, 21 Aug 2025 01:38:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] rust: mm: update ARef and AlwaysRefCounted imports
 from sync::aref
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
 Shankari Anand <shankari.ak0208@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, linux-mm@kvack.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>
References: <20250716091158.812860-1-shankari.ak0208@gmail.com>
 <CAH5fLgiUfZG4e0k6ajkkKo+iaidWHu4dTRfBbgm4Y_CQPGLHpg@mail.gmail.com>
 <20250820162518.7dd218ef331618bea11e9c2b@linux-foundation.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250820162518.7dd218ef331618bea11e9c2b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/21/25 1:25 AM, Andrew Morton wrote:
> On Fri, 15 Aug 2025 15:51:31 +0200 Alice Ryhl <aliceryhl@google.com> wrote:
> 
>> On Wed, Jul 16, 2025 at 11:16 AM Shankari Anand
>> <shankari.ak0208@gmail.com> wrote:
>>>
>>> Update call sites in the mm subsystem to import `ARef` and
>>> `AlwaysRefCounted` from `sync::aref` instead of `types`.
>>>
>>> This aligns with the ongoing effort to move `ARef` and
>>> `AlwaysRefCounted` to sync.
>>>
>>> Suggested-by: Benno Lossin <lossin@kernel.org>
>>> Link: https://github.com/Rust-for-Linux/linux/issues/1173
>>> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
>>
>> Andrew, would you be able to pick up this patch? Thanks!
> 
> I prefer not to grab a single patch from the middle of a series, so
> please add
> 
> 	Acked-by: Andrew Morton <akpm@linux-foundation.org>
> 
> and merge this alongside the remainder of that series, thanks.

This patch was sent standalone. The reason for the "3/7" suffix is that the
author wasn't aware that this should be avoided for independent patches.

It was previously part of a treewide series, where the treewide changes have
been decided to do in multiple cycles instead, such that each subsystem can pick
up the corresponding patches.

