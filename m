Return-Path: <linux-kernel+bounces-864629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F284BFB388
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D293AC39E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ACB3128A4;
	Wed, 22 Oct 2025 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gI4Empip"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903511A317D;
	Wed, 22 Oct 2025 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761126731; cv=none; b=AMfAkxxcnO9I5z+hXNTMfHvniYyh8rGezfni9pta4Iz8AfUvUGXcji6oB6J7vt5Q+6cBUepk9WzuKAiPvEQ5gHp9Sk5XJ0P+0N0o6chxFkmmT0ZUS8Q6kzTHzOPt16gmHlzhMysjhRKYSbP6DOgXVFfmB6A/nNW+Yd9FR6ksnOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761126731; c=relaxed/simple;
	bh=XVL+tO1aDcRrp8dvOXL0WKHcuGPe1DqF2y3yJhLSRgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J3HCZ/LELfpwi5B9sopOSYlDuBib8J8a3YTpbDdU16cxiwCTXnuE3CMRvU3n531DOUlqRDzfk30UGGpDLwF7irP6AkZ6Ut68w5gP4rJn0ST4gKgXzPHcJSo9OTH/hEqwAUGJTa0AgvmS+8ZfM+BxT4QBKn/a6Yn0M6Ux6G5qrq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gI4Empip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC608C4CEE7;
	Wed, 22 Oct 2025 09:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761126731;
	bh=XVL+tO1aDcRrp8dvOXL0WKHcuGPe1DqF2y3yJhLSRgU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gI4Empipj9V7gn80WPgULy8ScTQIVrNAQxwiqteON5U78chDy4nZwiFfT6iErAS8h
	 xLkupgfRyHuwoJALEqWCn/t+WAv38u35+NoeR3d3PP58BZbRBgNhfyzfeFKpe+8Xpw
	 Xn8KPPbRy8oUcgVuH0zYy1oP6BuVuUe4WXW45LVx5WIq8nRqFhpin272szr4VkFcgk
	 mZom1nzSZJKv/9nrVudvlGHEBiF5+qmEQ0Kj9fWdHRf1lRrqg0iUAu9Yv+p1T2VO2Z
	 +J2DVDz7eOe9Fff1gzzIMuzPVvBTrj/anJokK0zfzXUxf1AiESGYPiw/8X09Ps2lP3
	 ISy89YJ0uNpbQ==
Message-ID: <0f065454-34a2-42bf-ac9e-ad503bdca85d@kernel.org>
Date: Wed, 22 Oct 2025 11:52:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rust: debugfs: Replace the usage of Rust native
 atomics
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthew Maurer <mmaurer@google.com>
References: <20251022035324.70785-1-boqun.feng@gmail.com>
 <20251022035324.70785-4-boqun.feng@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251022035324.70785-4-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 5:53 AM, Boqun Feng wrote:
> Rust native atomics are not allowed to use in kernel due to the mismatch
> of memory model with Linux kernel memory model, hence remove the usage
> of Rust native atomics in debufs.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>

