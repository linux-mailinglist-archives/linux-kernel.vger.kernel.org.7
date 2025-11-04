Return-Path: <linux-kernel+bounces-884183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF654C2F8D4
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7457D18C0F47
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4313016EE;
	Tue,  4 Nov 2025 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n50zHO4i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696DB35962
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762239977; cv=none; b=cq9i7kZBjV3kEsBGAYAE4aI05XVxP/9h7f7QkqKpgTNJwNBrWajjfhEr2aTkHhiniFXH6W/FvhJNHmX1N1DUMP0N+eFCQ83l8yxbClspTdWEdeSTQ9weQQETuA0CcLcAldRuSOjv1uRZyfLrteh71hVvLWdKyBhNm6pEfTtG/U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762239977; c=relaxed/simple;
	bh=fIyKczNc+/gJHY3D8lZta3HSckqeCpgbj6Z3Cd+opyA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r3VNO5CD5fiPWcHta8GVSSrMaFpRJMSRzQbCBPLW3J55Oa81vqVCGgF++ron0D85DEqO9KQ7F4NUrxbyLpTwMy2m/5iIC2TVspmY2jObyp/YIYYkWv95WjJ/sDLQuPsgjLwt47mlfPl//HwJxkeuK6/GDmOqzayKRBZcIFsqDrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n50zHO4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEBAC4CEF8;
	Tue,  4 Nov 2025 07:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762239976;
	bh=fIyKczNc+/gJHY3D8lZta3HSckqeCpgbj6Z3Cd+opyA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=n50zHO4ibdnL8QNAtgkvULKBfMp+LqaeRkadSgcghWqAt+V82eG5eOmEnVu1vxFbe
	 TPas0OsgPxzylaUTfP8YeZf5dkdqJl0nCA6O7AV8MybgpsN2LufXSBmh3pyjbShqUt
	 FAplT7SeU6ZFz/mHxRegLILlE5X9LRsXsGlGc0PZJxnXh+syRhr1o7cFrIlmOlKdd+
	 2adVUH9qM7aIq+AOUjDsvWS+oAdRAcCieMWdjI5DZawNT3B1D7QyfI0Hgn5nfbD4UY
	 wRmEIUL9HWpZZNGvT2cklJV0XWXxNsM3YwrtOI4NxGoUNhEvp8RaXtb4aEktufpgoy
	 u+UmTlknrPakw==
Message-ID: <1ecc25df-7009-47e5-98b8-957209763e31@kernel.org>
Date: Tue, 4 Nov 2025 15:06:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Robert Morris <rtm@csail.mit.edu>
Subject: Re: [PATCH] erofs: avoid infinite loop due to incomplete
 zstd-compressed data
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20251031054739.1814530-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251031054739.1814530-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/25 13:47, Gao Xiang wrote:
> Currently, the decompression logic incorrectly spins if compressed
> data is truncated in crafted (deliberately corrupted) images.
> 
> Fixes: 7c35de4df105 ("erofs: Zstandard compression support")
> Reported-by: Robert Morris <rtm@csail.mit.edu>
> Closes: https://lore.kernel.org/r/50958.1761605413@localhost
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

