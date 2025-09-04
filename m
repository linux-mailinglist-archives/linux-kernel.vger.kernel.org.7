Return-Path: <linux-kernel+bounces-801841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE1CB44A96
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27FE85474D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B122EFDAB;
	Thu,  4 Sep 2025 23:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YjLypLiX"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C351A76BB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 23:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757030147; cv=none; b=tlvllWxY/P7PWsrgKLYp1Nbc8KdwlWDCJkU/bv67AWmHLjtdAzWX9Fe9CkM5UuhpqG/l/so0DFogpxpDMvr8ohUVYcrMirk8XBkPYfi0gmOHYKQMFn5wbtI41FGpkUnWbf8Ok9Pp/4+wMNYQiLAxJqJ9yNQTLzAaQVrpciTIX50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757030147; c=relaxed/simple;
	bh=e37MCHj4Ap7Be7HxFpu8iiHLdEXuvOo7oCxCgQr0ok4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UE9wO6j/5GxephavczEmyYOo8tocbl45Mk7D02OdDSueJ+dqPa+bjX5Fht9ml998zTzeh7XFG7CrnnN7Zm4X7S8bQWc6dL0AyR09PoXGnV60Fq0aCPHCwEM9Mnt7MaLbnT38UlHB6UUXf9nN9ylvoc1YAlByKtJAvXHIwjip12Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YjLypLiX; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 4 Sep 2025 16:55:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757030144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Pr14zv5u5Jg6s/TCR/mvY66VjHG8LpXuYMxg29uTMM=;
	b=YjLypLiXD6Ir2BWcVk0EcnqrPhfP+qYVCFd0BIO7aArwCRf3O5lYAuHvbK8RelTuh5bvTa
	3+YOoTZrVaKX8jWRIoUdj6YyYeEpTDCGFfI+mMnYRzHO9vrOkIQGf4HwxfQBz4eetrs0Zf
	dDEgi9Tb2Pi8clsCkKVVeCc5kDD58eA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples/cgroup: rm unused MEMCG_EVENTS macro
Message-ID: <izkhad3p62zbja2olzuqhsgbusbq5bfam5w7wsonand6ti3foo@gcc5xqhnfaac>
References: <20250903073100.2477-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903073100.2477-1-zhangjiao2@cmss.chinamobile.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 03, 2025 at 03:30:59PM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> MEMCG_EVENTS is never referenced in the code. Just remove it.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

