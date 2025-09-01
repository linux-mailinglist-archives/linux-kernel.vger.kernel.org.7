Return-Path: <linux-kernel+bounces-793898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17714B3D9DA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C5C3ABCBC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20B3253F13;
	Mon,  1 Sep 2025 06:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RB/+3aVh"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD4027450
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707920; cv=none; b=Eb8egI6zWOpzNH79Skoc2ad4D0cPVrzeiB+TvDNe2VZcOWGPz++0m1a495CTtUvG5MPuAsCzlmKdUkVhLQB7lK9S+ZCn8fhVpDiaAvb9PKspJmpJ2mbATU6BXB44XjNVqdlVCY5ULcOtQmdAc5U7md6SoNcjnweX3FeMTxyI1hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707920; c=relaxed/simple;
	bh=jI9CKQB8DDMeM+unhLN0OWUkR8ka844WoswqOiks8oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lHCbmjAyqNYfGm/hYyuTp5zYk4rxGfAtwhwEjZa8GKRlnyD+wvPWJz69LL0CI1XNiaz/twz87bFN6GVmh9jN3bPfGkdDTJTN2UMpLaJlDk5YTBjzuhBKQcRP6DwoU+aNEEIRUnf1ixixHAfvbajYDlIAjIw+MU+KA3+iskgx9Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RB/+3aVh; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eae2404f-1244-44a3-b0a2-c5393a508765@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756707915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sOnv63QjSjHPCjFRfUrvkssYp2uqZNRCr8swyPDNqYM=;
	b=RB/+3aVh7OPnHwVSqw6gIAgQnLty3S/V04KeZ13/8Yx8seVLagHzzVZovDal9H5q9vrjnz
	beR/blaBywUfzvSDfeivAR+AHswPQ7qXoljLyqKcO5/2KtMdszswZ56VAZdLHJ3/3j7OkL
	ZeMBkkKRYgAXhaJdqtMhofzGMdL6LNQ=
Date: Mon, 1 Sep 2025 14:25:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] dm-pcache: use int type to store negative error codes
To: Qianfeng Rong <rongqianfeng@vivo.com>, Zheng Gu <cengku@gmail.com>,
 dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250829133748.104119-1-rongqianfeng@vivo.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dongsheng Yang <dongsheng.yang@linux.dev>
In-Reply-To: <20250829133748.104119-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 8/29/2025 9:37 PM, Qianfeng Rong 写道:
> Change the 'ret' variable from u32 to int to store negative error codes or
> zero returned by cache_kset_close().
>
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but it's ugly. Additionally, assigning negative error codes to
> unsigned type may trigger a GCC warning when the -Wsign-conversion flag
> is enabled.
>
> No effect on runtime.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>


Looks good to me.


Thanx

> ---
>   drivers/md/dm-pcache/cache_req.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/dm-pcache/cache_req.c b/drivers/md/dm-pcache/cache_req.c
> index bd5cace7de71..27f94c1fa968 100644
> --- a/drivers/md/dm-pcache/cache_req.c
> +++ b/drivers/md/dm-pcache/cache_req.c
> @@ -805,7 +805,8 @@ static int cache_write(struct pcache_cache *cache, struct pcache_request *pcache
>   int cache_flush(struct pcache_cache *cache)
>   {
>   	struct pcache_cache_kset *kset;
> -	u32 i, ret;
> +	int ret;
> +	u32 i;
>   
>   	for (i = 0; i < cache->n_ksets; i++) {
>   		kset = get_kset(cache, i);

