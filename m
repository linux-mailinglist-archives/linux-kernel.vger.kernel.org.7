Return-Path: <linux-kernel+bounces-751106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D27B16551
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04C25669EB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE5F2DFA31;
	Wed, 30 Jul 2025 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVXGYb6h"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620582DE6E3
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896004; cv=none; b=eFB5tL2m3Znf2nTtgL0iQCm8ehxu4c+32Ai7SJfVcMkYLihumEtXe0hD3176ie9/FxLzAidTYCsGKyexU0fRltvc0PKJFzS2JfSrtTsZFZVd/exUMZmjpNLLXnZSy+rRmxYH1g83gZfEcBcTpZCriDRzzQlGSN3eZ0MJM8RR9AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896004; c=relaxed/simple;
	bh=5MtdqOrWp9XL+/7P8KF0tm7XQYdo1i1gdInDgtxB8uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMgLAc1X5OFmtKk1v4zVvL5964aIwKTOQht0iqeXwUX37S4y1BY1axdACMKQxJE4+Ozhhm5V6uQ8a+1uyMnJxLMjWrrkMBp963I1nP6LS2QZBrWXGkm/il8XdJL2uI1TDTbb9Qs5ULvVmOJOG2D8qylLXngTeMXAtE8F8u6m7K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVXGYb6h; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso407055e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753896001; x=1754500801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQ2a6DHl3z5np980mAJ2X98cngKs2SsQ+pYCL8WCFTA=;
        b=KVXGYb6hHi5K+PK6Eg6D4nwFiJLaPll75wmAm3zXb/+b+cPH45e/Y8xBWRLrMMXE6D
         vGkEus0QB9wlG5Jge4kgGnQbYtY1aeSDq/A0OduUtSnCQjJYKppwZ27nGWdytvTFYi1v
         /MWGbQsoyMyz92wbieZMM85Z0nQUXC2NZ5gIM1+G04Oge4lgRXvGtTwcLOeP5hUv1rpr
         b4196ytvFfsSZI8inVJ3VuOwxeCvLcfuEOY0CtKOUo4itFZa2RlCHiLeEyIzxjwaujSv
         QZfzPl21ID52niwrueHb+TgK07IP8ho3x7aMFsegR05A6ijlAW5h5/hdoA5HmNEX58Br
         aDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753896001; x=1754500801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQ2a6DHl3z5np980mAJ2X98cngKs2SsQ+pYCL8WCFTA=;
        b=TNyQW9noRTzZ3NtaTGvLksLUQ8rl7uKIuuHIOptJI2wiaYYIW4W7iQ8bgBpkoRv5AR
         4gI+BFUVBin/KMUR83geVO2V+Z1lig27z5ozp/sHvFQAdyygQMmS16Y9hGUvwARuuZVX
         6SQCg4+vDORnc8oFVt7MMebX/KpKQHx8YeVDkPNLy1YHGUE2beFnB2VoAKjLDrJ3AhIP
         8snATH1p9VpGbAZPiRT8vhV73uIYF868Vz0VcCBJsLIOo+PYoucNLMa1XuXE6ggv5iq6
         d3I6A5bGVYUG7Zoc7P2XXE8b5Yhe8RdYE33kH21osArWM5+ksKFRj0hyOarSaLx7PfEI
         N8Tg==
X-Forwarded-Encrypted: i=1; AJvYcCV7akl/4Qk6jHtWMX1hDOU8su+8mrYBwi312bDDSCmUQ7Sz5WRxH9Tu7cuDOmTz7WOLxGgCyRUhPsA5SiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQSTrFlR6gkbYWDW5mcS3qvNRKAKEXJYbNAHm0EOO629YFBHF0
	I2IH/nG3Y32cSUHfqWQ0RnQTBub5tbOYCsIm1TeWqXHCjKITE05G3WfO
X-Gm-Gg: ASbGncs+qMkvVE4bwTOS2uUYvz5qtCO2GQdAdw0mU3iFt1TgkrmmUDuQ5cNOjj8UMeW
	CXMNzlE+S7t5sup7Ds1pwwvYS6TqtjqHTkY4Cx8gatI1sZ+wVcjM5Mpc9CJQ/3SbfYVDRWDfXVP
	sWyzDuT2NLi9yh5lfuxsdm4Aq/oswNhL38LYTFbe6Z8J2wTDORueJanvHfvK+6fjIclsqsc9Zp0
	gGcmEyRkhuhDTN5k9oqZVJPB9vtPi3HTwzMKfK2mhMcnGhkKaSSJDxY3Y91YfAgK3WH/LG8RI0F
	hn+lsr7CMnIA7XLqJW20iOu32S0oQLowWabTTWJJ7UrVYpm6wfLjGy2+MRjEXxIE/sw7CkoaCAN
	WzvwHxar3n/0tWVc=
X-Google-Smtp-Source: AGHT+IEHjDXRiZsxpAsVevWpg7SdTkCsFSlZa/tie3LLi8D0AnSzcwlEavp7Qck5/rRCdYnNe8zb1w==
X-Received: by 2002:a05:600c:8119:b0:456:1c44:441f with SMTP id 5b1f17b1804b1-45892be164dmr40383595e9.31.1753896000435;
        Wed, 30 Jul 2025 10:20:00 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:40::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953cfcadsm37360005e9.18.2025.07.30.10.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 10:20:00 -0700 (PDT)
From: Yueyang Pan <pyyjason@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm/damon: Move has filter to ops-common
Date: Wed, 30 Jul 2025 10:19:55 -0700
Message-ID: <06734aa15198e542f9defbc1d29fc0731671c3d8.1753895066.git.pyyjason@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1753895066.git.pyyjason@gmail.com>
References: <cover.1753895066.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moves damon_pa_scheme_has_filter to ops-common. renaming
to damon_scheme_has_filter.
Doing so allows us to reuse its logic in the vaddr version
of DAMOS_STAT

Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
---
 mm/damon/ops-common.c |  9 +++++++++
 mm/damon/ops-common.h |  2 ++
 mm/damon/paddr.c      | 11 +----------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 99321ff5cb92..3ebfa356ca46 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -412,3 +412,12 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
 
 	return nr_migrated;
 }
+
+bool damon_scheme_has_filter(struct damos *s)
+{
+	struct damos_filter *f;
+
+	damos_for_each_ops_filter(f, s)
+		return true;
+	return false;
+}
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 61ad54aaf256..8d5c5c7631ac 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -21,3 +21,5 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 
 bool damos_folio_filter_match(struct damos_filter *filter, struct folio *folio);
 unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
+
+bool damon_scheme_has_filter(struct damos *s);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 53a55c5114fb..daeceed981a0 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -262,22 +262,13 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 	return applied * PAGE_SIZE;
 }
 
-static bool damon_pa_scheme_has_filter(struct damos *s)
-{
-	struct damos_filter *f;
-
-	damos_for_each_ops_filter(f, s)
-		return true;
-	return false;
-}
-
 static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
 	unsigned long addr;
 	struct folio *folio;
 
-	if (!damon_pa_scheme_has_filter(s))
+	if (!damon_scheme_has_filter(s))
 		return 0;
 
 	addr = r->ar.start;
-- 
2.47.3


