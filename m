Return-Path: <linux-kernel+bounces-898760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F424C55F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03D3E34E082
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C71322A13;
	Thu, 13 Nov 2025 06:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fq/cANEo"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE4E320CCD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763016047; cv=none; b=jszIcbhgP5MVMKajEyUCnxs7l/OQZ+wBOM8UlsFqYw0jArzMtuiB8/EyP/GwcMJM+sgvFFN17m6vNLUmnwGa4yvdyIWySlOU1XNQYxZgPpZ8Rk0zm+/Yaq+g3GLf3cMg9LlLPpr3KPmxXLBiObdgALs0PqPblq2f48IU8xVXkUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763016047; c=relaxed/simple;
	bh=YV5TspKFRq+OhrJyi6EvPKd+wYWRrbdPUuz4/OpJ54I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SpWUTqLaohA0/NkD4wUnfkU+J1TaYSGdu4hGUw3+CKOrP8geA6XoEy5h62e1RLJX+Stitdms5n3cFoD4dden7Pb+ZXWIXbhNELDndzGeS3HwenPc+HSQ+SuLDMLh7awmiAzft1XYrXmLx/XGwOkqUxjjR5Q5iUJPVVYI/ALnpZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fq/cANEo; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b24702f2-ea70-4c45-b0a9-dae9cc6104a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763016043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkCE1gInQuvvwwsk2xlmj60hAQZ+WgZJydh2PsbRcuA=;
	b=Fq/cANEoPniBM6TdaWoHRi5OatCcmxKo/i1m6O3mqKUMAr6dhgSx44agkRugeV6mxcoAhY
	QRMyRNDPxcsJmSmfJeWS6ganiQdEycMzn0+KuXhgekgCoBT6LGKmHcf3tDLTvYVwzL2kw2
	vAlNp3upKThiymPc0nRsO7Y2EE1bMV8=
Date: Thu, 13 Nov 2025 14:40:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] dm-pcache: zero cache_info before default init
To: Li Chen <me@linux.beauty>, dm-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, Zheng Gu <cengku@gmail.com>
References: <20251111121337.1063443-1-me@linux.beauty>
 <20251111121337.1063443-4-me@linux.beauty>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dongsheng Yang <dongsheng.yang@linux.dev>
In-Reply-To: <20251111121337.1063443-4-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 11/11/2025 8:13 PM, Li Chen 写道:
> From: Li Chen <chenl311@chinatelecom.cn>
>
> pcache_meta_find_latest() leaves whatever it last copied into the
> caller’s buffer even when it returns NULL. For cache_info_init(),
> that meant cache->cache_info could still contain CRC-bad garbage when
> no valid metadata exists, leading later initialization paths to read
> bogus flags.
>
> Explicitly memset cache->cache_info in cache_info_init_default()
> so new-cache paths start from a clean slate. The default sequence
> number assignment becomes redundant with this reset, so it drops out.
>
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>

Reviewed-by： Dongsheng Yang <dongsheng.yang@linux.dev>

> ---
>   drivers/md/dm-pcache/cache.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/dm-pcache/cache.c b/drivers/md/dm-pcache/cache.c
> index d516d4904227..698697a7a73c 100644
> --- a/drivers/md/dm-pcache/cache.c
> +++ b/drivers/md/dm-pcache/cache.c
> @@ -181,7 +181,7 @@ static void cache_info_init_default(struct pcache_cache *cache)
>   {
>   	struct pcache_cache_info *cache_info = &cache->cache_info;
>   
> -	cache_info->header.seq = 0;
> +	memset(cache_info, 0, sizeof(*cache_info));
>   	cache_info->n_segs = cache->cache_dev->seg_num;
>   	cache_info_set_gc_percent(cache_info, PCACHE_CACHE_GC_PERCENT_DEFAULT);
>   }

