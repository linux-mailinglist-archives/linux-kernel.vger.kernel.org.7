Return-Path: <linux-kernel+bounces-770484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F42B27B96
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852555A6A96
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4E12417C6;
	Fri, 15 Aug 2025 08:44:41 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E0225A4F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247481; cv=none; b=T+Su7B5iCUSW+ySNkoLpJJiTGpICK3yG5nynCEfkOgPS7bMXxjrilBYAaHwYRm4CGouBq+OI9TcU4wPlZr1mMZ4ddM9IesF5Uf0H54A4G+ttw9Caev2ZaNQL/xZJe+T4vRw/Iq5PDEEGaxUBF7+Bo2YWxFJs8VPkUCPdmzpg0NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247481; c=relaxed/simple;
	bh=vs3F8XMODuBJXP26XM8SiJiomSjtbAoSC7LNBgrpNmw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rERBgHDOIl4MG2ZKzsxhx/JVV2tFBi4USbBA5b5HgFsRF9kTblDObWg585fFg94XEawqiNuepS2lOu5GnV4dG1nh+QsbK7TXCZ6N9+PABVP1QSS0M3upxdTib75FDy1k1JshAKeQI6bkoaEK1G4xyZAif4UIjQu+qSrPn2YPYfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4c3Fys37nxzYl7Cm;
	Fri, 15 Aug 2025 16:44:21 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 15 Aug
 2025 16:44:29 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 15 Aug
 2025 16:44:29 +0800
From: wangzijie <wangzijie1@honor.com>
To: <xiang@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<bintian.wang@honor.com>, <feng.han@honor.com>, wangzijie
	<wangzijie1@honor.com>
Subject: [PATCH] erofs-utils: avoid redundant memcpy and sha256() for dedupe
Date: Fri, 15 Aug 2025 16:44:28 +0800
Message-ID: <20250815084428.4157034-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w010.hihonor.com (10.68.28.113) To a011.hihonor.com
 (10.68.31.243)

We have already use xxh64() for filtering first for dedupe, when we
need to skip the same xxh64 hash, no need to do memcpy and sha256(),
relocate the code to avoid it.

Signed-off-by: wangzijie <wangzijie1@honor.com>
---
 lib/dedupe.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/dedupe.c b/lib/dedupe.c
index 074cae3..bdd890c 100644
--- a/lib/dedupe.c
+++ b/lib/dedupe.c
@@ -162,18 +162,9 @@ int z_erofs_dedupe_insert(struct z_erofs_inmem_extent *e,
 	if (!di)
 		return -ENOMEM;
 
-	di->original_length = e->length;
-	erofs_sha256(original_data, window_size, di->prefix_sha256);
-
 	di->prefix_xxh64 = xxh64(original_data, window_size, 0);
 	di->hash = erofs_rolling_hash_init(original_data,
 			window_size, true);
-	memcpy(di->extra_data, original_data + window_size,
-	       e->length - window_size);
-	di->pstart = e->pstart;
-	di->plen = e->plen;
-	di->partial = e->partial;
-	di->raw = e->raw;
 
 	/* skip the same xxh64 hash */
 	p = &dedupe_tree[di->hash & (ARRAY_SIZE(dedupe_tree) - 1)];
@@ -183,6 +174,15 @@ int z_erofs_dedupe_insert(struct z_erofs_inmem_extent *e,
 			return 0;
 		}
 	}
+
+	di->original_length = e->length;
+	erofs_sha256(original_data, window_size, di->prefix_sha256);
+	memcpy(di->extra_data, original_data + window_size,
+	       e->length - window_size);
+	di->pstart = e->pstart;
+	di->plen = e->plen;
+	di->partial = e->partial;
+	di->raw = e->raw;
 	di->chain = dedupe_subtree;
 	dedupe_subtree = di;
 	list_add_tail(&di->list, p);
-- 
2.25.1


