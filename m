Return-Path: <linux-kernel+bounces-783863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDAFB33397
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED111888BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 01:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC51022D792;
	Mon, 25 Aug 2025 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiW0FJ/u"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E975E1E51EF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756085673; cv=none; b=VWfO1kOrz/m3Y9j1adu1tIslppOkXoDp/qgHCku4bl4SGoKk8DU5MITV+gY7tPQkNIsJUsqk6tYMR+CdsvdKosZKji/d2MYY3lGb+ggFQ1jjtgWntocoQG1b0Nx2sqi5PdG8qlOSWGAMgtFmD82dETC+/A8hhAGEquotdY0/3tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756085673; c=relaxed/simple;
	bh=5cyQM9XuxzzKyY5Sq7j2xuFUo0qYLyW35cQvHrK7s4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NsCouzex6VSfX6w+LEk1M04paJhanGy09T9+a/qN4ZVCcXmP/izXTHxQEbgrSX5ObLeaqQMOVGMU6vsOWCLUHM9dUV9/j8L42nm59BOfr9F1PpSdUp4Yg3mEXO3ZJfu3gmWyEZHFQrq9qpEppIrqJG7bAEj2MApKqZ53jE3Nse8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiW0FJ/u; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso3413499a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 18:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756085671; x=1756690471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7WGdMD7pS4V9asD7LoLkSW2uvY5b3XN5ChMyE9HGl8=;
        b=ZiW0FJ/uQtrnpD83RYR2aFR0TgYLgr/FCWZ4VyjaBjDuu/ZW060NECcun+ZJW7IzoW
         XJ2cANM1t2X6TTKzAc3e3o7rA31NQty2akCvr/ZDtKg76C5g0KuSGbYvzB68fXtD8mTm
         ndK/OEXvxkKADGZuouicSAnKyTHpHiWayy6aAMCyJs+m84WikpvKCyE69GL5EZrzktsJ
         P5NMadrBR9pkmnj6yfYqez9bpbMj/NQEZCtnGJAxbz0sCW/d7e+uUxH/jxHTOXC4zoBv
         IUv9fo3T16ChzjCYH9jnEQGN2ip5E1O1EAKtO6oxOsaW0sOz2Bz+mVXcI9ofSjDmP9f+
         /eyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756085671; x=1756690471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7WGdMD7pS4V9asD7LoLkSW2uvY5b3XN5ChMyE9HGl8=;
        b=Mzd9tYbs/zgYfpu6YkaGz5Pm/ziyq55eK7zLvLdYC9P36BBvZzyP+0oS/UQNaAMaPm
         DwrEfJ02ric3xa6Y6xF+B6D7cCfgsUt3xoOBdfcotYIsw1SuYnFEnYA1r0uG1tXPgDyI
         lAJeU/o9xk69W8rjoXN2MSedGo+3DNqn5MC6MzF9PbwubuM+b/mxg5ADJ87RQGxLTlVQ
         2UGJS23HQICqV5HmVVwyZRqADpPUzmFuhsWkI+uWrQVEM/O2sItHTkPtfKG6mrDREYcl
         JXOTrg1ws89OubLNdf4pun1bHqH2HHxWoCY+W5oCYDhwL78354yxy2wMG9vqQvL2CQVf
         zKDA==
X-Forwarded-Encrypted: i=1; AJvYcCW8CJ0z/kob+PK+WOGNNZ9If0aOS0mTNZUUN9s+SSxZMMMsLt4ubO2CaxeyXvI4DNJ7EKpHZGV0F6dVMtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxP94NrWXZ5lnnZhx3ZbIEO3pSPLysliX/ivx77nw7dY7rSQzF
	4vNBnyMKve2TCfg9yIhCRT25JovMjA2IC249LHpZCQUrYO+qsgpJyckX
X-Gm-Gg: ASbGncu9bTolipyOgPH32aUx6fcl/5PaSaDl9fl1PQvVKZUITLHV4lj3EWa/s7Tv9SH
	PkusqiEFMkl6h+B22LTipWvcRvDjahudWvzj+FMiHOoiauD81LEI6tgxDfN8EuzSQfDWCulYTMF
	9bgxa2jZFDW3XIzZL10fj+7rsOYN7QKWXH6YdLfgdcZz3yRyQdcViKyOGEXxkgEFg6tgFsA8VhJ
	+7sCfqsdqpwKCV6eWmcqzhHZtfyTreS9w0V7hUYWzGhu7D9f/AXRH1p9Ay++0o7d4cL5txV/S/a
	9ffyALjs8SXHF8nQGb+b+np3g7At+DhIAv7ge82G9J1F9AAzr6MD2zV9hBeFuyskJSfA2id9hap
	izDYUymhSMTkn28pjp53a+IrnpN3gJ4+MgaXVd2T7YVsosNRbeWYsqQMkFJTd3Ksp9548k2SC4A
	==
X-Google-Smtp-Source: AGHT+IFHr2kZ+775zp3IFYdEzoyHV6hkPMxZ/zxmEszseN9VFqHSaX4x/YJAyQmWz2RlTyng40GOOQ==
X-Received: by 2002:a17:903:1b6d:b0:246:b1fd:298c with SMTP id d9443c01a7336-246b1fd2fc8mr42463345ad.1.1756085671109;
        Sun, 24 Aug 2025 18:34:31 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668880a99sm52425995ad.121.2025.08.24.18.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 18:34:30 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: vbabka@suse.cz,
	akpm@linux-foundation.org
Cc: cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	harry.yoo@oracle.com,
	glittao@gmail.com,
	jserv@ccns.ncku.edu.tw,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 2/2] mm/slub: Replace sort_r() with sort() for debugfs stack trace sorting
Date: Mon, 25 Aug 2025 09:34:19 +0800
Message-Id: <20250825013419.240278-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825013419.240278-1-visitorckw@gmail.com>
References: <20250825013419.240278-1-visitorckw@gmail.com>
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
index c91b3744adbc..67b68f132f84 100644
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
@@ -7782,8 +7782,8 @@ static int slab_debug_trace_open(struct inode *inode, struct file *filep)
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


