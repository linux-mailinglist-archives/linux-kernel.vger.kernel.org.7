Return-Path: <linux-kernel+bounces-825232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B137BB8B5A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3061C25EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FEC2D2394;
	Fri, 19 Sep 2025 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hF8zs77A"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39EA267AF2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317598; cv=none; b=MA99eP/f/EvLcp5W+NfNhXIcQTnU5Uh8i0phZAr5g33rtojf0NZL9tY4vRd/SvRONMma8YSgzECBnL9WddWgTU7IFwrWTJl2kc0maJdT35zJMStTGm+exa1H9oWo1EPPzeI4wRQ6bvu7DU3zEP4H/IKbj2W41gYo2jX8kGsYL04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317598; c=relaxed/simple;
	bh=Ns/+VPk0JRgcfRhAmovRGTcun/6s1/Z3qmXA/COi+/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIgdHZy42HsDxmk4TYJqS9hZ/ekoHLRFFWRoTEmoCkLhAPaJ8ReWQ13k3HPADMxYQ17DdDWSY8DXgI5szlUSldUr1h/2wlloeSTvQKvrQLhetbzmCh+dJCCs1Snwqwx921ormQUzUO7Zmj6u7gRqbN/LQI7iI4S76F7LYZ2FXmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hF8zs77A; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Sep 2025 14:33:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758317594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Px33pcPC/3cjqyKF20QTwtd0R9MElM1aDgx8WhLopuE=;
	b=hF8zs77AfTFqlzlADpfZ/I7F7naSbcZ69FSeZIbmveId4wYFEwCfzXnvB5Tjn0Gobf3UdO
	hAdxcxsrW3C/Mg31+iUDWuwpH3FbvB/BbwVcwKoY6fvkgvd+00iOU5Gk4BYUEevJML37Wh
	qIjX/uLm5bn1uKBDZXMUdk1dq4tbzTM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 0/4] reparent the THP split queue
Message-ID: <svcphrpkfw66t6e4y5uso4zbt2qmgpplazeobnhikukopcz76l@ugqmwtplkbfj>
References: <cover.1758253018.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758253018.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

Hi Qi,

On Fri, Sep 19, 2025 at 11:46:31AM +0800, Qi Zheng wrote:
> Hi all,
> 
> In the future, we will reparent LRU folios during memcg offline to eliminate
> dying memory cgroups,

Will you be driving this reparent LRU effort or will Muchun be driving
it? I think it is really important work and I would really like to get
this upstreamed sooner than later.

thanks,
Shakeel

