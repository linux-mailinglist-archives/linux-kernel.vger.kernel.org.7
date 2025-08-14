Return-Path: <linux-kernel+bounces-768362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DBDB26054
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BFA3A7184
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A445F2F39B9;
	Thu, 14 Aug 2025 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BdfHpxoO"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989782FC874
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162072; cv=none; b=TejfWaIUKeTnSj9wanweTnC0uL/KCStBe0LZTPEk46W3+L8KhD/m9uXaTe1oWqst7idzB0WRroBchIQ68FuZSCNqkrknq02N3HbLnGzyclgcdbn26FCJmrWte8Mided02H5q6EqSrlD1SZ0721RRW4CUDTfdHkkch5mwGNcsUgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162072; c=relaxed/simple;
	bh=OMC5vtHDSGAcCPpKmBuEdztGENOVe3mqLwas+FE/K7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ltvhR/ueHuloCT96Ogex2Hz0K+Y3d94xjsbKsr5k3gWiGMCl1RyhZb3F0Gh9V6gn/3hVW1bjFDU1DTSh6418797Qxkwaa/IKQE0s9XlFgqNhGnp9kqceZRCH24FrzIei4+bV/U6/6YTCPkElS7J5JFz0JJzvcurckPOuihbU0nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BdfHpxoO; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755162064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GvViAVeacLDX8WWUbGDCX8LCi1iC8wegTPXSZtNYfrE=;
	b=BdfHpxoOCdyja8JdJtxD32B+sd/Mck3Bz2yfO8RL9lPcby7An7OoztfDK5zfZ7YR+vwVsX
	Q4SQwoHRM7UpXVgPkERTWfIoHCRXBR7svCzoYvwm+Y5ezt8Uq4LXkpXH3opW6EOeb29TP4
	7aEyXx+m4cI+84AtSejfsJ6kMjZDR0A=
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Ye Liu <liuye@kylinos.cn>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc: simplify lowmem_reserve max calculation
Date: Thu, 14 Aug 2025 17:00:52 +0800
Message-ID: <20250814090053.22241-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

Use max() macro to simplify the calculation of maximum lowmem_reserve
value in calculate_totalreserve_pages(), instead of open-coding the
comparison. The functionality remains identical.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 64872214bc7d..8a55a4951d19 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6236,8 +6236,7 @@ static void calculate_totalreserve_pages(void)
 
 			/* Find valid and maximum lowmem_reserve in the zone */
 			for (j = i; j < MAX_NR_ZONES; j++) {
-				if (zone->lowmem_reserve[j] > max)
-					max = zone->lowmem_reserve[j];
+				max = max(max, zone->lowmem_reserve[j]);
 			}
 
 			/* we treat the high watermark as reserved pages. */
-- 
2.43.0


