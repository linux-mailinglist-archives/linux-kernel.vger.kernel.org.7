Return-Path: <linux-kernel+bounces-815438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA26B56447
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 04:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7729342434D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 02:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F6D24728F;
	Sun, 14 Sep 2025 02:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="pZ/sCFcR"
Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn [202.108.3.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A382E6FBF
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 02:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757816638; cv=none; b=YBroiddylWbya2/VJjKcgVljlnD52rrPtrARPb5CuzUEh3UBcvP99SUHDwwW0/NTYe9hXJBLo6s/RLuQB5lAYHb3aqG+CzIkqrpFp7Y74mGc25cYToToJ5x+BbPIG1th6b6ORnpcgCSyBSSuFrF3jM/a5EbHdQaOuZKmXQb3IR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757816638; c=relaxed/simple;
	bh=02HLFsIIRx8d3iRj/vA5zzDKr1/xXzpo1w1/vekRvxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlJ+ULhO6VBu0p1NtkYSy0EbUjIIQRSl/oApD4WI3lA3s29aZzot5XkDDmFZ6c23l0uWkjX7tCxulKgqZmFf/ZLW5JL/vDtrR7i/eDiLhdulxZ2Cq5+gt8JoDBJuZrn8n/vjs4kjdWxaaMH/dkWvFxcrAFAOVJYMYWmolfR1WG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=pZ/sCFcR; arc=none smtp.client-ip=202.108.3.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1757816633;
	bh=soAVKL/6gGlvs7NpC/kFx/027hfgadBenVwkVqhKBAo=;
	h=From:Subject:Date:Message-ID;
	b=pZ/sCFcRPTRBhEXq1F+AraPGW+MsH2QZXJu3Fi4fRMptNqWSy3FWWGakfRCYwLONX
	 iAzOTgaC1NU7RxsrL83xOgJTEDVs2XgSkncWblOlLqsz0Mgc2WPKFWmR4BAgBO7W39
	 uBwJ62rpoEpufbtir/uAVxZM14OMnxDFd1bja9yY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68C6270A00007BBD; Sun, 14 Sep 2025 10:23:07 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9737014456621
X-SMAIL-UIID: 2DC8645A57844B7B918BD48ADEA49B19-20250914-102307-1
From: Hillf Danton <hdanton@sina.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/14] slab: add opt-in caching layer of percpu sheaves
Date: Sun, 14 Sep 2025 10:22:57 +0800
Message-ID: <20250914022258.7062-1-hdanton@sina.com>
In-Reply-To: <20250723-slub-percpu-caches-v5-1-b792cd830f5d@suse.cz>
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 23 Jul 2025 15:34:34 +0200 Vlastimil Babka wrote:
> +
> +/*
> + * Caller needs to make sure migration is disabled in order to fully flush
> + * single cpu's sheaves
> + *
This misguides, see below for a workqueue case.

> + * must not be called from an irq
> + *
> + * flushing operations are rare so let's keep it simple and flush to slabs
> + * directly, skipping the barn
> + */
> +static void pcs_flush_all(struct kmem_cache *s)
> +{
> +	struct slub_percpu_sheaves *pcs;
> +	struct slab_sheaf *spare;
> +
> +	local_lock(&s->cpu_sheaves->lock);
> +	pcs = this_cpu_ptr(s->cpu_sheaves);
> +
> +	spare = pcs->spare;
> +	pcs->spare = NULL;
> +
> +	local_unlock(&s->cpu_sheaves->lock);
> +
> +	if (spare) {
> +		sheaf_flush_unused(s, spare);
> +		free_empty_sheaf(s, spare);
> +	}
> +
> +	sheaf_flush_main(s);
> +}
> +
> @@ -3326,30 +3755,18 @@ struct slub_flush_work {
>  static void flush_cpu_slab(struct work_struct *w)
>  {
>  	struct kmem_cache *s;
> -	struct kmem_cache_cpu *c;
>  	struct slub_flush_work *sfw;
>  
>  	sfw = container_of(w, struct slub_flush_work, work);
>  
>  	s = sfw->s;
> -	c = this_cpu_ptr(s->cpu_slab);
>  
> -	if (c->slab)
> -		flush_slab(s, c);
> +	if (s->cpu_sheaves)
> +		pcs_flush_all(s);
>  
Migration is not disabled.

> -	put_partials(s);
> +	flush_this_cpu_slab(s);
>  }

