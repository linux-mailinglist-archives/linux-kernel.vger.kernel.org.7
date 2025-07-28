Return-Path: <linux-kernel+bounces-748019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FCFB13B70
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A3F189C563
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9182676DF;
	Mon, 28 Jul 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFqfYIKT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30E126658F;
	Mon, 28 Jul 2025 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753709155; cv=none; b=mhNZPHVHwsDajBWatS8nqfckYy3PSyE/X5Bh7jAH381eMmiGzQIXZ+AgHBMqa3g1vlm7YuCO5F4LlW3Zsf/9xqero8rDe7V4091GB2cYKXx73a4VP4y6fa3jBB01EF/YnBd8CwutIG0uQpneGEm3y/k1EztnWMGmyigqAlNAhJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753709155; c=relaxed/simple;
	bh=rDm3Fm72ZlOTFamAPbV74WlAfxnrI5Knrz05ONOH8G0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYSzRdtt+SOCR/Ee6W9AK9x922/H6zqbZga7pjPqfUHcWlV/JgbzdA5V0gLW0tkmZ4mNAnFS8AnBOB5IIdlC4hpZTFNR5W1VguISu6zCzVFqaEPSefaahEz5ezRhiUAhIaGyKKD2TFgrwWEwrIUJagVgWf5X7ke+0Zh4MYIxm+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFqfYIKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFA9C4CEE7;
	Mon, 28 Jul 2025 13:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753709154;
	bh=rDm3Fm72ZlOTFamAPbV74WlAfxnrI5Knrz05ONOH8G0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aFqfYIKTrLVYdxJWqRoIPRFA8BuxEJHgjBOIkETzsbWwRtpc/oJFwYAD1fOQWnngB
	 yCby1BEc0GxrVBeUZcXaaM3t18MDAylYsgEhB2cEC+5eHfjWCIA7VcFX+g8IRAZo4M
	 ir6+XnaYmsGS3vNQ0goe1TDCtUcoENZl/jLLe3ZOR2vp10ebGm1RKa3kM8AnWr+J41
	 eOaVwxrv20pdmrpoTM/a2gjmb9Yx820KuPezuMat4Cacv1vY3B9Sy6MYs9LQaLWb9Q
	 nU/pO5I7vium0CWWHweneRQS3k92rufVa1RBTZYnpulvzwnxJgm5BKwypcnJ0ufG4Q
	 PeXUa4+Wse7dQ==
Message-ID: <c0a91512-785a-418a-b8e4-b8994c497bbb@kernel.org>
Date: Mon, 28 Jul 2025 15:25:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] rust: transmute: add `as_bytes_mut` method to
 `AsBytes` trait
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg
 <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 "Christian S. Lima" <christiansantoslima21@gmail.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250728-as_bytes-v4-0-b9156af37e33@nvidia.com>
 <20250728-as_bytes-v4-2-b9156af37e33@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250728-as_bytes-v4-2-b9156af37e33@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/28/25 2:47 PM, Alexandre Courbot wrote:
> Types that implement both `AsBytes` and `FromBytes` can be safely
> modified as a slice of bytes. Add a `as_bytes_mut` method for that
> purpose.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

