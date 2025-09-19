Return-Path: <linux-kernel+bounces-824954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066A3B8A8BA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B081F5A73E0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D15B321267;
	Fri, 19 Sep 2025 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="qnDQSCOQ"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78542261B95
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758298909; cv=none; b=p+MNqupvM28XDG++v8YrFoI859AXXHZaJSy/BDhhW5wJQeBnCxsKOmaLGaRX00FyllsC5Jay0qkntXMR/GnTWXeV39tTia88VSQe0NVp8zC2CX7NAqJZTXD/1iHs2dD8KMr7TufRvAbb4VtMszGPeplD+QriF9NSIhUpyYIUEnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758298909; c=relaxed/simple;
	bh=YFwepSrjHchMb4PcPDQTN+DbhNZkUpcKyIr+8weUClo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kjp7dpM5XjCJfcqy7f/NAd/o+MuSioAcyVYoqsIbrmbmG3xskGyfvg2RfdNqb1lOm9e/TrDhjByUKFYesQ0OFIzPhkro/p1DbHq7kmE9JNElPfaHqgoxL96GQwpT4F+tPLWh8yOOAqA2IZ09Etfrcm13v2OAUue2JY7PWJjN2WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=qnDQSCOQ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-78de32583fbso11811946d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1758298905; x=1758903705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KU0e54WZ9xSy3fCSUGF390H8SijTBET/vQ6EcFimkXE=;
        b=qnDQSCOQ7DT7ODQeayrLSZISRM9DO03r0T0UXnBZFOb9wqIjD7kOBiFiL6YFCOLXj9
         fipfmcdGQ3/0svLFC/Ahq2qF640iiwsvsgHtTDj5U4UqqT91bjWQVl3XoC2yWWYyggGH
         Ttb/PyBuzvvM8ndZtKoPaS3qmZ3Yv5FM3uM+dkgMhHGNOdhNo7q44R7vwACWtIj9sIJD
         2NAHFVyWdRucmht78EqN6fLGZbljzLl+6GfmvbG2F+eL1h9CuxofPwpOZ/1hVVP9MD1S
         p5/HZBYX3OeC7n2RZfnR5UELBioStOybDwfPYHV2CQwu3B3+ZwvwhIjtrBX+rQNVCZI+
         KDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758298905; x=1758903705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KU0e54WZ9xSy3fCSUGF390H8SijTBET/vQ6EcFimkXE=;
        b=SfHOQ33Qfk28dRCtFHMOPnqpBMAVtaerh9QtlvS553twHsGTCoANUMAl89w2HFrWlf
         E4xovoqEVXWpJUArZfmbmk6AdK5sEnRvb6/y5cxnzDgPkxHQ1VdA/QGwk8yN4FnD4NaT
         bP4kMfcQnfHM7DH1E61NHJeGkMPXngZLS2ScosKjRIFTkrc8i0LoLtZktICoSeh2HIZd
         iQ0v8CV5jpH28Q4v09FDEGUdMIvUf5Oa67NMYunsYBE+mmVUj4Fhws/Hj2NH5ex1feQL
         fAVh+VNvDw+XjgpYD4AlF7gotA8EbDB4QBeDZV0bKnQm6zAJGhbtFstGcCm+dRY/56Dg
         vqOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAv/1uTZXsneyyZ8YBtBdDQl3xkvpciE9xha14hKcTw3AWQmjKoyh9NyH1KNbVEwPw/7mARnOpxb7918M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4SpMm6kqbpxSltMn9LoOXNjRnr8xnmTgbdptBb16SKweWJWtW
	YVrQ+g54z79ghkHIfqsFuBxFu+lAcGzy15+QbYxNLSJwBc46NBT3zz/asa72+2bc3Vc=
X-Gm-Gg: ASbGncsSERJVe8mJPKi0VmTP2AWNfBPRA/aCciEifaZoLA8AFi/swbjQC6yV7Nuu8lN
	B+3v4kGw47FO2Cas/G/3tWDn+2FOidJiippisYvRfrApSNUI8bGGKqnaI3/QcqJIWyYM7Q8n1o7
	u4ApqNdKe+9GYEJZKuLYvp/bYiOwaQR9qh++ELiUndJsq7jZRHuBlENXO0hEHaPESR2C4D4IHMo
	jdTL4Xp6djYIFpz+DFKklqsADg51PqWYLNyyXI3GTTn5dQmez52OeUHkG4RJvumUugZFwLhXdV8
	HaDijnmPPTkXC03+Z+ShGnQjzmgUP2kUoqMrb/cJUVLGEr1SEgTttDru3iZ4yoa5ANLDPr+DhKG
	GzwCgPEMlH2xEeU/cPDaR+w==
X-Google-Smtp-Source: AGHT+IF3YqXL+DiZ1cpJVimdnZ2j3EsIyc7usMA8XFckTWUwfy3Lewpe/MvFwizF8tQB4kpD355gAQ==
X-Received: by 2002:a05:6214:268b:b0:78f:1a9e:2590 with SMTP id 6a1803df08f44-7991c124a4amr47454426d6.34.1758298904870;
        Fri, 19 Sep 2025 09:21:44 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-796d68804e4sm22102636d6.67.2025.09.19.09.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 09:21:43 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: [PATCH] mm: page_alloc: avoid kswapd thrashing due to NUMA restrictions
Date: Fri, 19 Sep 2025 12:21:34 -0400
Message-ID: <20250919162134.1098208-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On NUMA systems without bindings, allocations check all nodes for free
space, then wake up the kswapds on all nodes and retry. This ensures
all available space is evenly used before reclaim begins. However,
when one process or certain allocations have node restrictions, they
can cause kswapds on only a subset of nodes to be woken up.

Since kswapd hysteresis targets watermarks that are *higher* than
needed for allocation, even *unrestricted* allocations can now get
suckered onto such nodes that are already pressured. This ends up
concentrating all allocations on them, even when there are idle nodes
available for the unrestricted requests.

This was observed with two numa nodes, where node0 is normal and node1
is ZONE_MOVABLE to facilitate hotplugging: a kernel allocation wakes
kswapd on node0 only (since node1 is not eligible); once kswapd0 is
active, the watermarks hover between low and high, and then even the
movable allocations end up on node0, only to be kicked out again;
meanwhile node1 is empty and idle.

Similar behavior is possible when a process with NUMA bindings is
causing selective kswapd wakeups.

To fix this, on NUMA systems augment the (misleading) watermark test
with a check for whether kswapd is already active during the first
iteration through the zonelist. If this fails to place the request,
kswapd must be running everywhere already, and the watermark test is
good enough to decide placement.

With this patch, unrestricted requests successfully make use of node1,
even while kswapd is reclaiming node0 for restricted allocations.

[gourry@gourry.net: don't retry if no kswapds were active]
Signed-off-by: Gregory Price <gourry@gourry.net>
Tested-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cf38d499e045..ffdaf5e30b58 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3735,6 +3735,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	struct pglist_data *last_pgdat = NULL;
 	bool last_pgdat_dirty_ok = false;
 	bool no_fallback;
+	bool skip_kswapd_nodes = nr_online_nodes > 1;
+	bool skipped_kswapd_nodes = false;
 
 retry:
 	/*
@@ -3797,6 +3799,19 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			}
 		}
 
+		/*
+		 * If kswapd is already active on a node, keep looking
+		 * for other nodes that might be idle. This can happen
+		 * if another process has NUMA bindings and is causing
+		 * kswapd wakeups on only some nodes. Avoid accidental
+		 * "node_reclaim_mode"-like behavior in this case.
+		 */
+		if (skip_kswapd_nodes &&
+		    !waitqueue_active(&zone->zone_pgdat->kswapd_wait)) {
+			skipped_kswapd_nodes = true;
+			continue;
+		}
+
 		cond_accept_memory(zone, order, alloc_flags);
 
 		/*
@@ -3888,6 +3903,15 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		}
 	}
 
+	/*
+	 * If we skipped over nodes with active kswapds and found no
+	 * idle nodes, retry and place anywhere the watermarks permit.
+	 */
+	if (skip_kswapd_nodes && skipped_kswapd_nodes) {
+		skip_kswapd_nodes = false;
+		goto retry;
+	}
+
 	/*
 	 * It's possible on a UMA machine to get through all zones that are
 	 * fragmented. If avoiding fragmentation, reset and try again.
-- 
2.51.0


