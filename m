Return-Path: <linux-kernel+bounces-805378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4329FB487C6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 667A67AD1C3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93BF2F0C6E;
	Mon,  8 Sep 2025 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tg3cx/6R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6DA2EC543;
	Mon,  8 Sep 2025 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322367; cv=none; b=rkevokLgmgErbLqXjQUYAoQcxxJqF0BIlF7YLr52G/FRvdPpDngtBeFh7hqmyOknXpzL5nuWtytna7rAicZ5whu129BEt05QSJADzfwcr35l/wBWimum6fdfg+eXPNZIj+mUMJBbDEf5eCP3OlxizubYOXti4Q/glAaCRofIgXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322367; c=relaxed/simple;
	bh=ng/UvLyp5kkP+RWA5z3Vs3tWg2c/GeleARlDyjY7mLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bS2PE2A04Cxw3GB65+d8PedHopX3IVXn55yc4WvcJM/iAIpocRDLY3F9JNlGQ4zxFbQlGY4KpsehyyesxaQfiNimzlYUN3XabP2csQ2GwikFit2/zUsmKyzyCo9MbAu27JkP/XCAOTyzKORZPrnDC0c4mRPdBKaOycIWMweRXS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tg3cx/6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC52C4CEFE;
	Mon,  8 Sep 2025 09:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757322367;
	bh=ng/UvLyp5kkP+RWA5z3Vs3tWg2c/GeleARlDyjY7mLQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tg3cx/6RZlSuZ8ZBZFbtH2rkQOUvsrE1ji1QgRI6ZR0U4JCmb7UAbUE4Tkrf2yC5M
	 puyUFtNvn3HJ7FSlkdfRX0u0fG7gbX8wo+/1+ZdHDor1tWDzzRUc8j5Bn1uQl5ZaW9
	 HNpBKd+tUd+AlPEmIvXnWE9Se5+Qs8qbpGFqy6XE0DyZKNE/YBs0USbpZlVvYT+eWS
	 H8TqmGbZjZ4TFysj/+2smN90Dk7pJrkBeq072V8nxeBsKGyga1/Jeow31aYM9mauT1
	 BvWfpXXyBeydiMqqy1hhuvMUKpchlYGO6taC/zAzzZshL52MNwvdR1cR06OmfQpxib
	 My61jS/6nCQmg==
Message-ID: <94252007-f389-41d0-b5a0-ed948225543a@kernel.org>
Date: Mon, 8 Sep 2025 11:06:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: rbtree: add immutable cursor
To: Alice Ryhl <aliceryhl@google.com>
Cc: Vitaly Wool <vitaly.wool@konsulko.se>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, =?UTF-8?Q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>
References: <20250906140256.3059395-1-vitaly.wool@konsulko.se>
 <aL6YHkF96ICqqbBZ@google.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <aL6YHkF96ICqqbBZ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/25 10:47 AM, Alice Ryhl wrote:
> On Sat, Sep 06, 2025 at 04:02:56PM +0200, Vitaly Wool wrote:
>> +        // SAFETY: `best` is a non-null node so it is valid by the type invariants.
>> +        let links = unsafe { addr_of_mut!((*best.as_ptr()).links) };
> 
> Since this is rawptr to rawptr, I don't think it matters but it seems
> more natural to use addr_of! here.

Why not use &raw? Consistency with the rest of the file?


