Return-Path: <linux-kernel+bounces-896033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE8FC4F862
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207E8189815A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBFC2D1F4E;
	Tue, 11 Nov 2025 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NRm7sPR+"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F372D1F7B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887596; cv=none; b=GKV4wF+3huhoIDW9nT+pOu5mlpDfaPK/nD3n64C1Vv8y89dNAWBuiSzhQq95QTVkE4VcFq/n8WlIPcS6FFu6YjoWj7S6GTipTW6gwooJl0qnKGHl3733WeTmo6QuH+fmBNqskkM8dC/PTEtLH7SP7sXMx7kWdbSSUj7KqvYoC0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887596; c=relaxed/simple;
	bh=UMnEps90lDVVxQpCV0D0SupS08uIJn0CtLAQpVuX40E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kYOjeoTcv4hHKygVyvi/Reh/Kyk+dyk9IMiXeZ5KmlNinaranCi1FHPYWuz4/kcdl776iURn1qjPUb//62RZ1SSdKnmJKknB/tcfH70Ox6nMyKat0jwmsxqNcSVcpMzVnuAdjydl5zXkvf/KJj2lBvtzIKar2XYwp1RVo+54Gc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NRm7sPR+; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762887593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMnEps90lDVVxQpCV0D0SupS08uIJn0CtLAQpVuX40E=;
	b=NRm7sPR+NTC4j8oIQHpvopN6jNVoYW/ZMofwhUSzPQEo1Ux3CnCGioBiEM+9C6Q+Kdfh9c
	nrz1kfBvONTID8CAT+XGPRraT244HZrAO3hkwarmn1Tx3IOOutvqhPzYEGQlHQNVhlucOX
	KrIgBZbSrNylk/B/CLMxMDEOJICoQ9Y=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,  Muchun Song
 <muchun.song@linux.dev>,  Harry Yoo <harry.yoo@oracle.com>,  Qi Zheng
 <qi.zheng@linux.dev>,  Vlastimil Babka <vbabka@suse.cz>,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 4/4] memcg: remove __lruvec_stat_mod_folio
In-Reply-To: <20251110232008.1352063-5-shakeel.butt@linux.dev> (Shakeel Butt's
	message of "Mon, 10 Nov 2025 15:20:08 -0800")
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
	<20251110232008.1352063-5-shakeel.butt@linux.dev>
Date: Tue, 11 Nov 2025 10:59:39 -0800
Message-ID: <877bvws8dg.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> The __lruvec_stat_mod_folio is already safe against irqs, so there is no
> need to have a separate interface (i.e. lruvec_stat_mod_folio) which
> wraps calls to it with irq disabling and reenabling. Let's rename
> __lruvec_stat_mod_folio to lruvec_stat_mod_folio.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

