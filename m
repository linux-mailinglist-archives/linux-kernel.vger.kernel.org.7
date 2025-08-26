Return-Path: <linux-kernel+bounces-786059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E5FB35486
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565721B665B0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2302F5336;
	Tue, 26 Aug 2025 06:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu1NaqxQ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8712F1FD8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189413; cv=none; b=T2EhUDiLCmEQz9fmYpXbVLFwMeYpFhBAXT8jVr/PIIiloox+foaFNeUb2sTEDWN81sJ4ZS2wVBIsrLxRMYq2t9OEYeYnC4UYJ26xNs3N1v0PioNL+IYVnYid2RlpdYmn3pN1gVe0Y7Z2191JNkuS9VTK33rhqekEq1ywTtlsuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189413; c=relaxed/simple;
	bh=hkVzxDmYkyZScwgI5/uxbAQwhSr1A3G6WdChM31peIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qLnLK+Bdt1DUW7IRJg6lF8oDijFcjN6ZVvFQTs50LFKHPzUD1PybdQrBgGCGnh6uUsBMjbfAdP6E9abUv/Av4BfRox+RJ0wd5MZanEbUuD8p54y+iRDZnkwFsejn+IGtTZl2EuxbUaCQwZJ2evMRCcopsi6hi1EfXzw4XapUVBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hu1NaqxQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77057266cb8so1631423b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 23:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756189411; x=1756794211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIkwDyhxeRC9KaW10KQxZAmgX/lJ0Jk/lOkmMojQenc=;
        b=hu1NaqxQjN4kTnBJxjH4EY70uRFDCiQ4/MNG6wrUY97xJjeSH379X/1ZYFmPI0+vuc
         bCvHbV6HgHt065HkO1C+sfSBcHYe2F/pjpgYgWCaNzS4x4T0lDRI/YLSdaSYlnw8jXos
         Y3Y5/lmhQ4/50a/pQ5f6DryOK5E9VNT05QQmU0GNzPWAmlwmcayU3Ltx5aQr2mqnGqp6
         BrvyEV1fQE2NXj3a2KopvszK7M4jD+cGLgGka6S4jmKhQvxQToYcXKt0T2WCzjPcze6k
         yr9bwpYvbV0cO0o8LgcIarb1KNr00qUNEtJwn2mNgrcw0gbIXonCAIuM2CqZv01D0KOG
         5B2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189411; x=1756794211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIkwDyhxeRC9KaW10KQxZAmgX/lJ0Jk/lOkmMojQenc=;
        b=ldmrkx1ufRgSPgmAc26bvyEZm/wkB3AKMZ4XWqs5crUtPHRbdfwMx2GZpzgPCygWpH
         4P0OmYPOskZNg00ymxvgsaiHhjviY7lG17bVBKSHKDHIuYAP6vKRy1pPLYnU5piJWtYK
         H2TRIil92BGkwvz9DJxzd8rLdDOVjT1lpOTTbWZ5AauENnXjOQoaonXpH7IX/2F+AGca
         lo5tq5Z2FcLeg5VPVzTJcizxvGw6fKpzjmF9KSTjvYomfAZSO56yzT2brIkhyYRY6lk1
         W26QRncUHq5j8xPeQJtd9HiUG+v8Rw4NH4g3eh1joKOsi7p2Pwcs+VA4YxUuw3NOfeIM
         8BJw==
X-Forwarded-Encrypted: i=1; AJvYcCU2jZ3AV4jrqyFeMZQsmjt/w/bmJQkFCLD3YSOhAy7l7Ryr5Bb38GJndtxH71mFf05BQ85UtwgZrtMx8m4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk6zSpJwuXqylU33GuQwr1bhomCw7ZYWdDwXRj2Z8xtbcnLqD8
	V6Cq+XuAX9ExtRMbGIV1izPgqbVKwwUdgJIu8ZCiszps/FxcRKNvv17n
X-Gm-Gg: ASbGncvGymeTBXSb5nTZ9VP4+hwlnZyZVViVi7SY/aZ5f7C5P4hqigyKJacibuH5zy0
	cqQvKZlkCjsSxju03rIldaPaf8Uao3OQXLMkt8fh36cSll+Txn4uH48dpJum4/jr9unfuWXL8kK
	/ojYqicGdccG4YTq15mxA0Ofc+Ejh64cPg1pepECRrK2tRdCP58+tEOWPGqQ8pVqQ86nHsegKBx
	Ws2Va47hSHVU//p4otk2bSmpeLtN+cQwq+BieWZK5v+rOUDAwNjaVFamvmFYxq5ueJXPGnw+dR9
	q+pvLP++QFsq+GJNtBAr+kkVMU/k/F3XptWjoCVCiYGJkibH9X3nmaMWZPKngLJGSQCUYGGGFXz
	GA8vlJeP56eAVwDJoGTXGf95ScDZx0OP184vc10NX9ODRMQDiL8SD4feVIMr/jr4=
X-Google-Smtp-Source: AGHT+IEVmakc1sTT/jj4NROLgnG5GSB/qkE6B1uuzuSzoJh9ZET6//lRRxrnhGh2veVhZQOgT7nbwg==
X-Received: by 2002:a05:6a00:2d0c:b0:771:f393:ceb3 with SMTP id d2e1a72fcca58-771f3a31abcmr3337714b3a.16.1756189410887;
        Mon, 25 Aug 2025 23:23:30 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771fbbc3bb0sm492535b3a.66.2025.08.25.23.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:23:30 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: vbabka@suse.cz,
	akpm@linux-foundation.org
Cc: cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	harry.yoo@oracle.com,
	glittao@gmail.com,
	jserv@ccns.ncku.edu.tw,
	chuang@cs.nycu.edu.tw,
	cfmc.cs13@nycu.edu.tw,
	jhcheng.cs13@nycu.edu.tw,
	c.yuanhaur@wustl.edu,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 2/2] mm/slub: Replace sort_r() with sort() for debugfs stack trace sorting
Date: Tue, 26 Aug 2025 14:23:15 +0800
Message-Id: <20250826062315.644520-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826062315.644520-1-visitorckw@gmail.com>
References: <20250826062315.644520-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comparison function used to sort stack trace locations in debugfs
never relied on the third argument. Therefore, sort_r() is unnecessary.
Switch to sort() with a two-argument comparison function to keep the
code simple and aligned with the intended usage.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 mm/slub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 081816ff89ab..39a238384892 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -7711,7 +7711,7 @@ static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
 	return NULL;
 }
 
-static int cmp_loc_by_count(const void *a, const void *b, const void *data)
+static int cmp_loc_by_count(const void *a, const void *b)
 {
 	struct location *loc1 = (struct location *)a;
 	struct location *loc2 = (struct location *)b;
@@ -7778,8 +7778,8 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
 	}
 
 	/* Sort locations by count */
-	sort_r(t->loc, t->count, sizeof(struct location),
-		cmp_loc_by_count, NULL, NULL);
+	sort(t->loc, t->count, sizeof(struct location),
+	     cmp_loc_by_count, NULL);
 
 	bitmap_free(obj_map);
 	return 0;
-- 
2.34.1


