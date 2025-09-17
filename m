Return-Path: <linux-kernel+bounces-821495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80370B81682
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CBC48299E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A7D3009ED;
	Wed, 17 Sep 2025 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPvfc+qh"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0832F069F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758135552; cv=none; b=AebG1YvthC61+eZtXmgv1cwVHA640TNLmD0wd51VOLWYTH9KFr8aorXeoOY5t+zsrbbnveKEh1oJen7uvtqYSQtHdV45ufNvhfCbTPFyyVoRCN5YqJ9Lkt3eG4rYfxiaYJXPNQXwM2qsouCdLnDug3+PezrmjQ3C9ZQ6KLTk25E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758135552; c=relaxed/simple;
	bh=fOvuVk9wRvaDx5kq/QMyukgQeJWsLkcPrp3KdsFzJXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p6mkiLsXN4X/cmUJIK9btx0XlUMuKIsBneDpvfk5va5+rvgwRytFyET4wOQEuqiw+j4dq1nZknEys8HhR1iQNjlk5uICl/OCqGS3yOJwDGMe/1Gs2GsKGXgIlENMV9Rugn9sXEn9Nwyzj3lEgDbdWPWADrL8hfTz+ZTW78G13qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPvfc+qh; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f76454f69so194346e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758135549; x=1758740349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PBW7HlnBnHXsZV43FxLiqGMyPVmVlz0PSTx6u3WdsDs=;
        b=YPvfc+qhN7az8BgzJCC/C0I4Kttjr81mvOrg9pPQ9IbrYYV47+fWw7t+BowsvPOgPk
         8Tpewr6MqErbu9YuQPuNwuG9JISZHoT4/8mC82BeuY6iab1BiOot+A3jurzoxi90X5RW
         4PiRSVSv2aY8y/q2MvF9TQaidaAu7F4zStY122Y+k1nbDmT1KhqUasfxiIqTmQEOPwH6
         oKEJawM/H/KxZvQjK+Xb1jMWdPDdlcAuxpEKP2HsTB2Yer4DlIxOSanV0ZDfmgUCMDWR
         rr3WVIwYht7bqjlzAKHg/BS2W2YU9dmnzMVlBPj+7woXuIPEUG+fMb0ymLHilPa+w0g7
         Ttlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758135549; x=1758740349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBW7HlnBnHXsZV43FxLiqGMyPVmVlz0PSTx6u3WdsDs=;
        b=pWKQFZMXk9Y4NeJ1oN4zJbbpstfMsgAupRyDzmU8gPp41qTqpr6whou9UwWbhEE0nS
         UQjdP6UTcNFdHKrWOeUvcORhGPev8nbw9GJAKCE6FV5Y8d3jc57O3Bk9EglAxrUIJOo1
         IQ3KhnvwdipLRtKFyHwVWhoDV3PtTUnmKixSfXysHWPS9V+l1K77vR2Tq01oBjNA5qbo
         tcYrY+DxeWu6OkVTdPAvTGs751WFQEJqt1Sxd66b0V9d17XsVoB5qqzxkJaQWOBC8y9g
         Bm70R9HFKUIAjpCqUn+LVFZL7szLfSKD6+BoRxVBGTbDozwGpLV0MmlBCe9Qe0/qC0Te
         oJIA==
X-Forwarded-Encrypted: i=1; AJvYcCV17kyEWtQpDpaaISPvUngEzK4r0x/I7W/i/YYGuZ4F/g2UlEO3/o35SNf8gkmY1CuZAhdS5x++wWU/Ddg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD3yS+PcGhNPeHMDjemwFvbG8+YUOvnX8KIPxIP/gb7g0FuRVY
	ptJjV1lFQfbdRJIVbryBnUffEmG1fjm6nnCfTRTSFMfB2PzOJ4GRY+Qd
X-Gm-Gg: ASbGncs/nxuZOGCMsmPTH7JNBGef0aOJrm7oDR9+1dKHMXT0d0YapluaPkgp7PArJDw
	VELGC3sjbZfAsx6DskYE8SKs88KYCJoCB6bkS7dIaR3OYVvtIKiMlsyPzgl/udzOln8BkM6K9t7
	vKmT/PJj4bbNVYL/MJ7eGUkRdGYLRJLSZvt9Dta9cy4TopTQSQUFrTLBvL1i0TGzHIi+k0nxCYE
	E6DKspAMASqHbxu9c4jUaHQOG0s7ntDxMP1Il/RqWIXitv6HUeTAOpjW2oZRh3YFv4mGRvOo1K9
	QzYhLZFXk2Mt32ogrM4EjBiUGVcB3AXK9bfymRKqiJ/ryzM9xjyNPZiErbLyPSRZFKGb2Hbnxq1
	G8FRBU8oDp3NCAgTPcRDoH83bzeUOwuaG468=
X-Google-Smtp-Source: AGHT+IGa8vKcBgMPTv3VCQG18vLMJP9gPf1BC7QGZ2WiTb9J1yWYwEmirgaUnxIIH6tWYsC0zdnrrw==
X-Received: by 2002:a05:6512:3b8e:b0:570:a8d4:a7c3 with SMTP id 2adb3069b0e04-577970368femr1384222e87.14.1758135548886;
        Wed, 17 Sep 2025 11:59:08 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a5f4472asm80895e87.5.2025.09.17.11.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 11:59:08 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH] mm/vmalloc: Move resched point into alloc_vmap_area()
Date: Wed, 17 Sep 2025 20:59:06 +0200
Message-ID: <20250917185906.1595454-1-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently vm_area_alloc_pages() contains two cond_resched() points.
However, the page allocator already has its own in slow path so an
extra resched is not optimal because it delays the loops.

The place where a CPU time can be stolen is a VA-space search in the
alloc_vmap_area(), especially if the space is really fragmented using
synthetic stress tests, after a fast path falls back to a slow one.

Move a single cond_resched() there, after dropping free_vmap_area_lock
in a slow path. This keeps fairness where it matters while removing
redundant yields from the page-allocation path.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5edd536ba9d2..58204728123d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2057,6 +2057,13 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 		addr = __alloc_vmap_area(&free_vmap_area_root, &free_vmap_area_list,
 			size, align, vstart, vend);
 		spin_unlock(&free_vmap_area_lock);
+
+		/*
+		 * This is not a fast path. Check if yielding is
+		 * needed. This is the only one reschedule point
+		 * in vmalloc() path.
+		 */
+		cond_resched();
 	}
 
 	trace_alloc_vmap_area(addr, size, align, vstart, vend, IS_ERR_VALUE(addr));
@@ -3622,7 +3629,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 							pages + nr_allocated);
 
 			nr_allocated += nr;
-			cond_resched();
 
 			/*
 			 * If zero or pages were obtained partly,
@@ -3664,7 +3670,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		for (i = 0; i < (1U << order); i++)
 			pages[nr_allocated + i] = page + i;
 
-		cond_resched();
 		nr_allocated += 1U << order;
 	}
 
-- 
2.47.3


