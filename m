Return-Path: <linux-kernel+bounces-862326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEF0BF5010
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A5DA4E73A0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211DB280024;
	Tue, 21 Oct 2025 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="IcSZPJAX"
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 3683A246762
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032437; cv=none; b=qb8qW99nXvcruPOC8sXHBKUJ6gauwL2BTA7ka/RhwAZAdHu6TYWtzvezqTS0spUgkjLAkKqq1Q2uz4AXPtI/Ng0Z5XolVDM2JWm/lx4mMWUAqco0V+0D+UXoNV56kZPjWO60WRgKi73zoiyQfqTEk7qEvraDAmCg5BEDMN9vnZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032437; c=relaxed/simple;
	bh=1Fae+9kDgarwteFz3rVD4NDlZJfYEw7ZwZwiEpnAcx8=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SQDA8Sq2O+8JsZZ/PrfOL4+x310MG0XB+EUWo0mz7IR5Ug+ZegDSp6OhWk99GEyboCiS/oYnlynWW1lb99wNn7XwGA9m0wqqtAZrx0+h0k1EEUM4Vxr8LILdGJW7tb5HG05mTvZLA1kXQexPCn/SMz5JIWHZ0KHry78zNUyTmRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=IcSZPJAX; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.71.38])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id F2854181D0F585;
	Tue, 21 Oct 2025 15:35:09 +0800 (CST)
Received: from BJ02-ACTMBX-07.didichuxing.com (10.79.65.14) by
 BJ03-ACTMBX-02.didichuxing.com (10.79.71.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 21 Oct 2025 15:37:14 +0800
Received: from pilot-ThinkCentre-M930t-N000 (10.79.71.101) by
 BJ02-ACTMBX-07.didichuxing.com (10.79.65.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Tue, 21 Oct 2025 15:37:14 +0800
Date: Tue, 21 Oct 2025 15:37:07 +0800
X-MD-Sfrom: jingsusu@didiglobal.com
X-MD-SrcIP: 10.79.71.38
From: Jing Su <jingsusu@didiglobal.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<jinnasujing@gmail.com>
Subject: [PATCH] mm/vmstat: Fix indentation in fold_diff function.
Message-ID: <aPc4I/8zXCGyiapN@pilot-ThinkCentre-M930t-N000>
Mail-Followup-To: akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	jinnasujing@gmail.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: BJ02-PUBMBX-01.didichuxing.com (10.79.65.22) To
 BJ02-ACTMBX-07.didichuxing.com (10.79.65.14)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=didiglobal.com;
	s=2025; t=1761032114;
	bh=bz2COxVLbbO+0xNIIj1XYl4plzJn4e3cBaijQkcaMjs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type;
	b=IcSZPJAXydXPbYEMdNbAAPnOydi0mtyZz3M6Ys8VsX7K8VYicsrB5j/38Ze/L3IsZ
	 5+NWrgvZQMwBeX6PfBkVm/fjlAsg8XUlACkXuqwsPEfqRL1zp7S3ocMQuB/qRkNfPb
	 3JmAqo2BWK7vngrURKKfGtKAjs0RbJtdCNQvnHiA=

Adjust misaligned braces in the fold_diff function to improve
code readability and maintain consistent coding style.

Signed-off-by: Jing Su <jingsusu@didiglobal.com>
---
 mm/vmstat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index bb09c032eecf..63860c3d22e6 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -782,13 +782,13 @@ static int fold_diff(int *zone_diff, int *node_diff)
 		if (zone_diff[i]) {
 			atomic_long_add(zone_diff[i], &vm_zone_stat[i]);
 			changes++;
-	}
+		}
 
 	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
 		if (node_diff[i]) {
 			atomic_long_add(node_diff[i], &vm_node_stat[i]);
 			changes++;
-	}
+		}
 	return changes;
 }
 
-- 
2.34.1


