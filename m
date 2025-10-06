Return-Path: <linux-kernel+bounces-842541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C80BBCF77
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 03:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD8204E7AA2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 01:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608DF1D63D3;
	Mon,  6 Oct 2025 01:40:57 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06B21D6187
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 01:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759714857; cv=none; b=TIpIIbeiZDTegBeoc8u5yt1Lb5I4YmiUbgnbRfwZUg7fXlL/Xl3uyL2hu0CoESonf7YkWGXIons9yxWfC04eSYhaq9bmLu8lmvkM6myZLnbqG61uSNzVCJgKnwLp1Dcg1LhkEU1ePXxvQb2pCkJD/8Fwf4l5Dtd37zmpUEMfUiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759714857; c=relaxed/simple;
	bh=kcNiQxSb9NXNJj+PhSS89AWquyZ+0G4O1HGDWej9+9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NPmGy1aorR4Vh9M7PXbL2VZ/XVmQnEKVPBgfxNV7Zuq7oGrvWh53LLE3KY/8dbVPyh/6MgEnmutvKjE56YB0EnENyfRNPkNx/WmW1V7iTk9ArGCI5131KjGoGL18pAy2hHYtFccDMtLRGSA97ALsMlaxWFjPqBowDZPqrll5DEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <willy@infradead.org>
CC: <akpm@linux-foundation.org>, <axelrasmussen@google.com>,
	<david@redhat.com>, <hannes@cmpxchg.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <lorenzo.stoakes@oracle.com>, <mhocko@kernel.org>,
	<shakeel.butt@linux.dev>, <wangfushuai@baidu.com>, <weixugc@google.com>,
	<yuanchu@google.com>, <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH] mm/vmscan: Remove redundant __GFP_NOWARN
Date: Mon, 6 Oct 2025 09:39:11 +0800
Message-ID: <20251006013911.43917-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <aOLfOUgoEskd8jyE@casper.infradead.org>
References: <aOLfOUgoEskd8jyE@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc2.internal.baidu.com (172.31.3.12) To
 bjkjy-exc17.internal.baidu.com (172.31.50.13)
X-FEAS-Client-IP: 172.31.50.13
X-FE-Policy-ID: 52:10:53:SYSTEM

>> -		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOWARN |
>> -			__GFP_NOMEMALLOC | GFP_NOWAIT,
>> +		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOMEMALLOC |
>> +			GFP_NOWAIT,
>
> Please just remove the NOWARN.  There's no need to reflow the other
> flags and break the 80 column limit.

OK, I will send a v2 shortly.

Regards,
Wang.

