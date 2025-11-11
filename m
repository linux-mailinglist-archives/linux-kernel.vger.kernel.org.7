Return-Path: <linux-kernel+bounces-896036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAF9C4F87A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692AE189CDED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908F2263F28;
	Tue, 11 Nov 2025 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zg6iOzgw"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BEA19258E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887731; cv=none; b=SLCGFIR3KW1HlHlEZSOHA8nKEuQ4tCRvTDFf6fWpauBlwpEGaSzdsa6X0k2l4IBZlHIJNr8afKdHsqmlDMrWCqZVK2r8i6CeJH8Wg/Vs3JfKRuCStpuhsEWHB0uS3G8S7zE0qvzDfBp0BanSPeoV6JtL0yMAaF5VUiFCGOEcCwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887731; c=relaxed/simple;
	bh=X3p0OHTe0vlUjyhDWhZhm6oTZ1C1L+keJX+PJWob0hk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hrDLs2qZ9Wl2cD0DHvKuM/CZYIMDRSGOTj9f+ujOuEQkusutLaelV2MnO7SzmIfdVYvv5OEhkkGWFjZQLZbLQn43aVoe4+7nRhfxLAf+psDyTnskYxQ9TOqvo5rF/m9XB4WDTEcaU1GV6GOsxIloy5jk1wYwGFHh58/cpwWI37I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zg6iOzgw; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762887714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X3p0OHTe0vlUjyhDWhZhm6oTZ1C1L+keJX+PJWob0hk=;
	b=Zg6iOzgwfbrFafmG6DBIIvIS6DBeLRm6Sopz75Lft2XojfXoTDjLb5lA4KUWmxyE+akzZq
	L3lqa9rGljR2bmGx6tMT30TfUHA7vjS3K2hsIgOxPH/lQ0f2S+Cqb4t4w5E9tZZz4qX8le
	gnjpDmDj0GMG5gDFQ0SkqBFkI7O/HRw=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,  Muchun Song
 <muchun.song@linux.dev>,  Harry Yoo <harry.yoo@oracle.com>,  Qi Zheng
 <qi.zheng@linux.dev>,  Vlastimil Babka <vbabka@suse.cz>,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/4] memcg: cleanup the memcg stats interfaces
In-Reply-To: <20251110232008.1352063-1-shakeel.butt@linux.dev> (Shakeel Butt's
	message of "Mon, 10 Nov 2025 15:20:04 -0800")
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
Date: Tue, 11 Nov 2025 11:01:47 -0800
Message-ID: <87pl9oqtpg.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> The memcg stats are safe against irq (and nmi) context and thus does not
> require disabling irqs. However for some stats which are also maintained
> at node level, it is using irq unsafe interface and thus requiring the
> users to still disables irqs or use interfaces which explicitly disables
> irqs. Let's move memcg code to use irq safe node level stats function
> which is already optimized for architectures with HAVE_CMPXCHG_LOCAL
> (all major ones), so there will not be any performance penalty for its
> usage.

Do you have any production data for this or it's theory-based?

In general I feel we need a benchmark focused on memcg stats:
there was a number of performance improvements and regressions in this
code over last years, so a dedicated benchmark can help with measuring
them.

Nice cleanup btw, thanks!

