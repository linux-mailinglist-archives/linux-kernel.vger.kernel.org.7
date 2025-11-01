Return-Path: <linux-kernel+bounces-881151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A322C2791E
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 08:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7F23A4BA5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 07:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43964299AB5;
	Sat,  1 Nov 2025 07:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVwGQNp8"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2583299943
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761982912; cv=none; b=iKhRBoQVel92l6hwhK0hn4etddAAx0AclW7iw5kM/iYsCudGSMwVtFLCDwr8VFVSSwU9d67lz29BRm+W9r9cfJ2a2R/kyuJgKFanaT26qr2/cvM5bnodQ5sla27HHDy277vgzP5W4Fkv30UCLzPPofa4G5btWBUmcr+wETWY6bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761982912; c=relaxed/simple;
	bh=oAjAkDjUtAQk6n81S60YXrOlbuP7F5bm3hxxpXuUVUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TwFN7Oa05X4xwJSpI5i8Fcg/mkPu92iYqFRiZmEqyDy6+mamsBnUJWW6OO6y/7U8WaacYvcAC1YB1jhBhlPMmFfv51wH+cqm8izu55QiIGaE77mRUb+wU1a2Ogl61MvFuL9IjNGsSdRqYqqMlPq8LW1M83hNBjUvbXwsA+NKQEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVwGQNp8; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso2040380a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 00:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761982910; x=1762587710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oLshY2j1NyL4UvQi5KisxTMa4rbmEZHWDo+dRWBxLQA=;
        b=gVwGQNp8Jb8y6eqEvGuuVoO7KiztDfI5HZkZ+NlnTZlsVpfrRhUYWfTkjUgbaszy7F
         IBOpCISvNi6afr/udqrDsAO8FYgZRVTtj3VgiPQjZj7GB5pdjiunc5uUwltmFf9Pd6vx
         4wfCr0CJfBSYKq48tfmNSwOWU3VUEScp8Aehmcuu1TFAijcwX55hjI+qP3ZwTMsBBOvj
         oyf5B/ZGjE7Gm+IFJqpjmtFmL4yEwwVAsqG/hn3CWbqJqscLGA89l9IbDwyONmxzP4ia
         BFGtXnVclV0Sszv7nVvLvHIZXzHnu85qrmdQ8A8YoPrCQQk7NQ2t7igv4j1ktmKQZyIF
         h7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761982910; x=1762587710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLshY2j1NyL4UvQi5KisxTMa4rbmEZHWDo+dRWBxLQA=;
        b=ccu7eMAZPgF4Duz+GF0VK4PbBaDwTNznwHd5gX0gOe5xicwlNGx5mZ6FpFPktxesh2
         ILgmT1rkoaTWn/9cXsG9Y5/GORlNfE4XWef0Uop3JNPvu+klV67tmE6sGzAj05ofJfpQ
         LB0Iu6f32eceQE3Ix6luHm+BrYCgU2PBZrPetyjd5E7TPv9+Gd1Of1sdbs/YfIEvFiz+
         DkHLnnIO7GEDm2G34+UkouDqQ1gVBgKwsWPjOUApbAQrG7LMAc+akNBzCZ8KppOYgRGK
         lLzn3Lyy7HaBJ8YXYegP8HbCu0YtpfBnGawFBBd8OJEk0vbhl2Z2oe2en5FbSLncsdve
         v/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc2uLHrDQfsty8B2w8jqyubPnCrxR9LwDzZhwCER37d08LzY8Zcw0rfs+687SmDfnJzCaf/mtIYfTyA5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWiI6j+v4ljBM3KrIzsYSIou2Z5LEXn/Zae/Jq+MkNA5m28TZ3
	KFuxXoJQ/g7Y0T+dwOQ/CrJcGyL91SZOyPGRITXv/CIs1dbBDCnH+sBv
X-Gm-Gg: ASbGnctqjP5yTwpD//5oLcCUBNgncPQTom0XkOg5N128bDAv5UcQfmFpSSNm/twKwwD
	K+svdvRSPvLRqUZoVhNmSo2oKrmiL+WrEwSy6wbK/WrkaAJ/DOV8g5GLi3fdicTJjMEVGmRt1ok
	SFnSbrD+GOuZAQ9aj+czNrwoNbe3/nQ2WhypljYW/QMWFbfi0d141jioGm+LXliYE5PUNs+XB/Y
	qfsDo2h9PQwIMFgWQlUcyMffWg+GhU6TjCuhikMJGhZN9H+CDoGZcAKA6/xS/XARBWhG+BoD4/P
	KNy4t3CeOSGFBiy+8PXQz3FCZ/BkGgTvAsp/slpK7yJrYCyDK6VDwu0Rz5H90dSzwSaIWZsJ3K/
	53iUeZ+s2f0s0y4XA6QAU8VM4N8W//tqQC0GDNN2NhH+svGkYfcSeSWqwdC9Kv9ci/m4Bv2WfsM
	pmaGEFqxtWeEmswEA=
X-Google-Smtp-Source: AGHT+IHnnhPQKfRcidYUStUKxCGSss3Zb5ESxuCsXwzEr4uHGFO1U7MahgvxQHE4zEs8CPhTVBVoBw==
X-Received: by 2002:a17:903:189:b0:27e:ef96:c153 with SMTP id d9443c01a7336-2951a3eac5amr77029145ad.19.1761982909925;
        Sat, 01 Nov 2025 00:41:49 -0700 (PDT)
Received: from fedora ([38.183.9.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295426a789asm27969305ad.111.2025.11.01.00.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 00:41:49 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: martin.petersen@oracle.com
Cc: inux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	i.shihao.999@gmail.com
Subject: [PATCH] target: substitute kmap() with kmap_local_page()
Date: Sat,  1 Nov 2025 13:11:37 +0530
Message-ID: <20251101074137.98988-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a single use of kmap() which could be replaced with
kmap_local_page() for better CPU contention and cache locality.
kmap_local_page() ensures non-sleeping operation and provides
better multi-core CPU scalability compared to kmap().
Convert kmap() to kmap_local_page() following modern kernel
coding practices.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/target/target_core_rd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_rd.c b/drivers/target/target_core_rd.c
index 6f67cc09c2b5..d6768ea27f94 100644
--- a/drivers/target/target_core_rd.c
+++ b/drivers/target/target_core_rd.c
@@ -159,9 +159,9 @@ static int rd_allocate_sgl_table(struct rd_dev *rd_dev, struct rd_dev_sg_table *
 			sg_assign_page(&sg[j], pg);
 			sg[j].length = PAGE_SIZE;

-			p = kmap(pg);
+			p = kmap_local_page(pg);
 			memset(p, init_payload, PAGE_SIZE);
-			kunmap(pg);
+			kunmap_local(p);
 		}

 		page_offset += sg_per_table;
--
2.51.0


