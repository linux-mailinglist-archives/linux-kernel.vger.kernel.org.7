Return-Path: <linux-kernel+bounces-823427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F7FB86658
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714AB3B8B20
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9142D239F;
	Thu, 18 Sep 2025 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="la4DFChz"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F00A2D2384
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758219256; cv=none; b=V2I+ARe4aDcp4UH7+a9jseiagXP5lizP1F4BHx1yh9xJePg/GXr6SkXssCXk+1WvbUAxxG8yAD8LpgggvchdVgDNBWIsotuLJsZfvQyOGmrT/5F1d80gvZHvqw1/2VNsQ2xiiay8Fss9R1WgSIW+YFGdGueyhsT+Me9+v5djVX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758219256; c=relaxed/simple;
	bh=plehf26lV3FfzdRjGH16xpfo76cdDmGfOmktnbJHBhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S2jaxdxarEVvO7hQzG0wCfgJpLVuvpXJNToFeOjYywyvbI63bPvYFgQ2TbuOr04USfjwm90HikrKWe2+y3hMIXZC/z+HMnBdaeEsTW6kXuFQaFtSedwIUEdO+FrbDEdvdqVwuDWHM7eJBUBSR+fhixhd24kdNPmTFFAmlyUDZm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=la4DFChz; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso1225527b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758219255; x=1758824055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wakvOmINFFDIzFIPuPMgLSywd6bmR/VxBmcCPjKbWe0=;
        b=la4DFChzO+optJuAfunQTc5uN3OmZH9WCQHrFI3v7UhKk4v0cBjiwWpFXSFf0FFz3S
         ebTYQYg9QPbrtp0v4wRyJeERtyjwSosBYJ86mFQvwkWYqiKic8NhmbVYzXLD/BrRoTGE
         LX7rKEgJ4g73FLYthFJasdFZe7z4ruitYAU25Y8edlIN/DugPjctwF0DB7tI8CPTX+eg
         iZ9jWVFVSKY+n57yv0wc1jJ15w/h0MDIgJfvRFxKcMmRO4Cn7GSjSrsiriua251KJyl9
         TYcdG+hNQbRFJE1mTjxsj8jrvv2Mj2u1PfCeozEbONOxOv0D31uxEmCtBuhGEoFTipc2
         4bnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758219255; x=1758824055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wakvOmINFFDIzFIPuPMgLSywd6bmR/VxBmcCPjKbWe0=;
        b=R832QhIFxUp4A6fvm0uUJy2Ml1KomkL3sEg1P6wCKlyq2ZNqiO97GvIvNRdLut0zOn
         nVgZ4rCzf3+j1Nil8E9AVAr2hSdZyQYmAcW8LYNQC/cPWJ8+Sv9otIqP2VIh2o94rRBi
         6rhtT4Mq9DCrLo++hYqiLMEevmTDQBc3RooSS56VKAGLB6Z7Py6694lkd7aKRAGq5PXX
         FdcuOReQ1vn6cVHYvYSUWIpd3yZv3675kj5QyDHdKq0HTZawOM3gOTJVvtMtFdoCZOfj
         VNuyDktPTcpizx0tK5AoVDPF8uLIfMuAx+cHc6l+I9qEtQSStp6yE1QA3TvEJbaweTIE
         HGfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBZVfyvYqwaeAWssrJZO2cja6tDW1uaksyPQD8c/gmqIk0e6h/oxBkDvrpZtPKf6d8UwJbMp6uaAqSyMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9HpJJPCuvMijh7KFezoLOJJFk8KjdW5P+uK12id3CVuuUiu77
	n1cIeWFQCSm6g/daqUZnnIGKGfeeHjciHTFu3NtTqEgywjfZAe08nFAS
X-Gm-Gg: ASbGnctcqccpEZ+VhKsJsAJ8kRE1e3jCdH+NeVaFLJ84LqoxOv4PK7mm/NLgIMGLxVV
	VrMv/NkeQ33TrslwbGXTHe3ba4ic8FTGq2OFySC5XuPdWifDMgxme819Nl4yrVTFNzkAlz00H3n
	lhG695kndAUnPKFF6sJd15Q24fdEBTb7G2jDDgFUF+ZYRQobGpt/hIEU+uebl7z/3M2kefc1UGz
	x8fR7Q7tqvNPxwOy3kwYLXxe+HkBqEKkwiIb8d+9mgr7DigfQC/Fjm5af3/o9v73/TTPalnfyJD
	ApSeJtmgRFeHeUi6caFPeMc6M2hhUGAGuvYYGVxSy3dzEdZJ9AMCPDhrEitQ6Zpn6shmKmFoa2l
	X9TkCLbep5ibQgxQgn8NL02d3b34Su/gLjZu6QCrRvw==
X-Google-Smtp-Source: AGHT+IEPsHiDu6beO/Hsry9V80GWYk2DYorDZkppoEyn/lpQz4QbXXFYMRyUp805AG1h5+9l+6cpWg==
X-Received: by 2002:a05:6a21:6d89:b0:263:4717:564 with SMTP id adf61e73a8af0-2925b41e299mr857221637.6.1758219254627;
        Thu, 18 Sep 2025 11:14:14 -0700 (PDT)
Received: from muxbit.. ([2401:4900:1cb8:2c41:4cd2:6b0b:66a7:bdd9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cff22af5asm2927767b3a.100.2025.09.18.11.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 11:14:14 -0700 (PDT)
From: Manish Kumar <manish1588@gmail.com>
To: akpm@linux-foundation.org
Cc: vbabka@suse.cz,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Manish Kumar <manish1588@gmail.com>
Subject: [PATCH] mm/show_mem: update printk/pr_info messages and replace legacy printk(KERN_CONT ...) with pr_cont()
Date: Thu, 18 Sep 2025 23:44:03 +0530
Message-ID: <20250918181403.93812-1-manish1588@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Manish Kumar <manish1588@gmail.com>
---
 mm/show_mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index 0cf8bf5d832d..798949d10ce1 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -26,7 +26,7 @@ unsigned long totalcma_pages __read_mostly;
 static inline void show_node(struct zone *zone)
 {
 	if (IS_ENABLED(CONFIG_NUMA))
-		printk("Node %d ", zone_to_nid(zone));
+		pr_info("Node %d ", zone_to_nid(zone));
 }
 
 long si_mem_available(void)
@@ -156,7 +156,7 @@ static void show_migration_types(unsigned char type)
 	}
 
 	*p = '\0';
-	printk(KERN_CONT "(%s) ", tmp);
+	pr_cont("(%s) ", tmp);
 }
 
 static bool node_has_managed_zones(pg_data_t *pgdat, int max_zone_idx)
-- 
2.43.0


