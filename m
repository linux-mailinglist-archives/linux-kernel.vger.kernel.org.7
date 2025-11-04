Return-Path: <linux-kernel+bounces-884446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE42C30303
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697791883D93
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67BD312802;
	Tue,  4 Nov 2025 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEY4aI3B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A64C3112C4;
	Tue,  4 Nov 2025 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247481; cv=none; b=F01sOxcZAtqoFDL0ZRbr02V5WGWYXhkYq4NTXdDGZl/uCRiAVfBLn+ZMF5eYtGgdVN3XrQC16QCIM+bXwEjxqrukVvD24y2xP34G9R4Wd79n23quro7JknUnrmNM90B7WeXt9TL0Rz411A4iPbQsHxGH59Epq8/x/gp5sNff6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247481; c=relaxed/simple;
	bh=9J+2Ncm8oVWBPd5VHBjHUmAAaRGBje5NyAVuz16rG2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUIpLpQ+3YbSC5w7mlKhfz0iENieGzoNj+r0hagpyI/9fdB+FJKMzULqpMJzNpivcBwvInsM0N6xYQ5uugXemFVgWrxa7jRXcNG5cN/roxyPyuJQxG4GKP8r1943rUteBvZZDUFO/wJTxbocjnfhawytEH8rH0h7fcpcx7a/HZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEY4aI3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611A4C4CEF7;
	Tue,  4 Nov 2025 09:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762247480;
	bh=9J+2Ncm8oVWBPd5VHBjHUmAAaRGBje5NyAVuz16rG2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aEY4aI3BsmqJaPusuATrULwlpRPoNmKwq5VpEgyucTSgNkgsfV10zhYZ//vWi/ppY
	 AiyfGXAHAT2jfq1YAZFBvgtky5fZhrNKS1XV6HOt2Ij8x+IYYBy8aUJcuSrvJan30s
	 COl5vbjO0oS6tB53CH0f8iejmvdbOigIkRg6Wjpzk+XlMSWj5SqYglvRkhv8EMGakz
	 haRdvpP4GVBcb4mrAbqfuj00PZE5FKuzNSLJ0WSQtWwlAW1x4Mh49evNVkFwH+jnG6
	 V0TTWvF6e63W96SoW83YVqO4GJBCt0NbVNuB9F38xY2eHPrzAgUxH7bAI7/l4BR1H9
	 h0GIepVvSOWvA==
Message-ID: <8461cbfb-b042-44d4-a71c-17559f2a1e21@kernel.org>
Date: Tue, 4 Nov 2025 10:11:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] rust: transmute: add `from_bytes_prefix` family of
 methods
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251101-b4-frombytes-prefix-v1-1-0d9c1fd63b34@nvidia.com>
 <DDZN5VK2OK1W.25NNI77Y315WW@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DDZN5VK2OK1W.25NNI77Y315WW@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 5:55 AM, Alexandre Courbot wrote:
> Rust core folks: if this looks ok to you, could I get an Acked-by to
> take this through the drm-rust tree along with the rest of the series?

For drm-rust:

Acked-by: Danilo Krummrich <dakr@kernel.org>

