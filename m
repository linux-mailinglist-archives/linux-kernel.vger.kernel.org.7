Return-Path: <linux-kernel+bounces-800833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9BEB43CC3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51F71C20C8C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715D730102A;
	Thu,  4 Sep 2025 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO98OgSS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13D02356C9;
	Thu,  4 Sep 2025 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991587; cv=none; b=DIH14zQzC4UoPbjWBTQ2mW6avcrRBIvtnufMZFuTyFuUdcZOSCtvKx2UujIMXMPak0hr1I5PQ4SLonYtaEef5aQYrMSGsNf7NeFMeYaE/My4vrTrDnzFMIsifA1sxe0xzxCLj4y5uhAtZ6+Xu8vcJrSancGF2sPJsgIN7iBd0S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991587; c=relaxed/simple;
	bh=LtDWtmqJ+7LA5Gh7HYgsRMlM+zIYR1O1RoF4bWFUYgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGRtQdVhCuHmmiPveUbl91XWoUH0ueWZ4rOOh0aTshZLrMfAntC8y5PM7xe7h0VAEc2HC9AmK6e523x7Bmp4PjDzzMBDG6oG22BV35dou/zbKEvzd44kWtbAbbGymTEWJZ2WPhn63BXs2Lsq8ZLD2XRjzwQqWGj5dSnGUq6ZO5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WO98OgSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A24C4CEF0;
	Thu,  4 Sep 2025 13:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756991587;
	bh=LtDWtmqJ+7LA5Gh7HYgsRMlM+zIYR1O1RoF4bWFUYgI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WO98OgSS8w5E7FedQegN/sAsy6HUSnkxuJHsaxeDcVwhU2i3F9Bas+CD9QL8vJPTo
	 cT0DPLd6c+UDZHnLB6unultWBaNZcL/QqvYFLBd626tZ8mnevNqnC5kW2owhooSv+l
	 l9bVKuzz5EbCuq1pB8ioXtxE0m06WnkmijCG1rmSt6yW/dzED9l5BZhHdDq3pzcY9U
	 RGqTM9nrC/tNdhZR7elFDkzGew6/N4ad2xG/s58SzfsQAWRdH0uIJ0ulebdF4uZL+/
	 RZ3B0l2i+0qh+iuFIqLKY/pvLE/E4HfMzCwXKr9OUs7qOamWNfzSlpyPSI5U7EK7yg
	 jal/JEJuTFE/w==
Message-ID: <19c28f99-b41c-428b-af04-a5914df6fec8@kernel.org>
Date: Thu, 4 Sep 2025 15:13:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: clk: implement Send and Sync
To: Alice Ryhl <aliceryhl@google.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>, linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904-clk-send-sync-v1-1-48d023320eb8@google.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250904-clk-send-sync-v1-1-48d023320eb8@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/25 11:03 AM, Alice Ryhl wrote:
> These traits are required for drivers to embed the Clk type in their own
> data structures because driver data structures are usually required to
> be Send. See e.g. [1] for the kind of workaround that drivers currently
> need due to lacking this annotation.
> 
> Link: https://lore.kernel.org/rust-for-linux/20250812-tyr-v2-1-9e0f3dc9da95@collabora.com/ [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

