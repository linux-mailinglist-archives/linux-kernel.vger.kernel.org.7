Return-Path: <linux-kernel+bounces-743460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F2CB0FEEA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 04:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0A1189B448
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB33B1A08A3;
	Thu, 24 Jul 2025 02:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4LyW45Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2655A22097
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753325202; cv=none; b=c+hlMrRhSU5o2KdJ4FJ8VDDdJp0XJWWrESW8vomQK95afy5MTMjUZzjARrlUrrSDYpfTynNbIV4TIEoZuHv42f8OT5pvp18kWvsEwxYfaealP2h3Ls1kvU/MHca0O6gFQVNL+tDmaab3MUKoOVHK9rT9gpGx8qgEf0z0N/iQ7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753325202; c=relaxed/simple;
	bh=RoGREyvQX46BI4rqJDbPiq+FWilpC4T7ezMdDi9ps/g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GfQyTwaqFwhv1fjZQMVyMKABfkC7s8Rq2PXTHGToGONntUThdPeiguc0PoUR2ChUaJjXufNkJwBxyWsU1wD8w8l+zZrYug+LQItKxvOA/xm8ASmoPhDfwG3P96p32DHdre7O1uAKeuxKdKVBKLU5Wce3X0V7EUtk4rrNUc9EcG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4LyW45Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E08C4CEE7;
	Thu, 24 Jul 2025 02:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753325201;
	bh=RoGREyvQX46BI4rqJDbPiq+FWilpC4T7ezMdDi9ps/g=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=p4LyW45QyOedF+O6tQkHww3GvG9xYjq+QBxGZXKDpzLoj7k/hEnqZTV1jtww0lMhW
	 0K8/+ZyxJfUEPNuALyAWa1NVj00B1OsCIhGIPJa7W3+bCk7fFMe7cXNLTTJgiIeIoy
	 6OBdIK6+XdPXJkP9XfYm6fHRkPntSMBI60Ukq+xHfGHVvkm6VPKv6C+tZBiiSUMhKv
	 K9O3aIeLMh6fAzNyiTQTE63VnDIxDSBr0Xzhq+puQtKzT73/jTgNt3SsVZVeOb1jAD
	 +ysQFheHkI7yJH+J4nkh/XR3UVT+DxRl7JUhR9ErqqMnPo3yYrlDbZJqvJwaveCu3r
	 Cn6bxlFPu1g9Q==
Message-ID: <a42ac7e6-765a-448e-803c-ea4b8691f3a1@kernel.org>
Date: Thu, 24 Jul 2025 10:46:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Sheng Yong <shengyong1@xiaomi.com>
Subject: Re: [PATCH] f2fs: remove unnecessary tracepoint enabled check
To: Sheng Yong <shengyong2021@gmail.com>, jaegeuk@kernel.org
References: <20250723142456.2328461-1-shengyong1@xiaomi.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250723142456.2328461-1-shengyong1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/25 22:24, Sheng Yong wrote:
> From: Sheng Yong <shengyong1@xiaomi.com>
> 
> There is no extra work before trace_f2fs_[dataread|datawrite]_end(),
> so there is no need to check trace_<tracepoint>_enabled().
> 
> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

