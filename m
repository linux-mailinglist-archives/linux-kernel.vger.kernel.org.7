Return-Path: <linux-kernel+bounces-722585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C05AFDC9E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE6837B1BF2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3F316DEB3;
	Wed,  9 Jul 2025 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgwSz9uf"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991CE137932;
	Wed,  9 Jul 2025 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022826; cv=none; b=rctf6ApeZlP3RQIonlohCdScvV6kvWfnjvLHezzlz5Tzr9vj+6nS/A+Bme3P329Z5hRodLv0fibtFlS+aLPldRNWSuRzlN0PTakCT8aTEBPnyLgsdLhC6f7Yd5VGUZblyzi29Jp2GdimxbrzHDmpZsFvgtN2z7VLbTsK0WWNbto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022826; c=relaxed/simple;
	bh=TF36DmJ4gRDLXGKB0dablkBerf4+G3+9gH3N4qFv2Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVBHvIRIVpOWyM4xuI50JQdHKAwtTv0Wg1h9B4WC4YsMlvVA9qQqtPxZS6/VxAnOzPYW52Cfl6tbt5C1fgEjU/a48dZ/NufcJJJKdAV69XEPGDyREpUI+ekAdqO4LGz8bjZ0QYCWzNeZ2JvEyjNxPET69QUN7OcvywDXrDVidb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgwSz9uf; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e85e06a7f63so4528334276.1;
        Tue, 08 Jul 2025 18:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022823; x=1752627623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TgSHi8o+LhWVBXZHtMiPoCLNZyL4Zo3x7ltlQyypVA=;
        b=fgwSz9ufaJo0s9rJbsYR9KA+7qJ4e5sOc5OjAcU9xyRmAoC4cV/g3v+yArNfW4+yws
         pWlNEOLzkA1VksTR3qac3UHP0Qqv4JRC6IqXe+k3uY7VrBrWBEG7JzQsDfIT+MOBj1lM
         1Mq/Q0u9hJIEBmpGHU65vbhbnJMClv3oh8yVhldAvbgucO7gsU1m6whYamajebUVsaAq
         4THfnCQNVMdcKCQI4ogwI6ZSDbHPaHahNnZaRfkfkkzznYoH6Rtw8c3ThFXEMHOnpBuE
         XGqxlGclgOPuuIaCwEdEVz+OZ3YtwoZc4vwRv+LGZtLHk812G4LhBONyy0eh7dSpB2iZ
         bgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022823; x=1752627623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TgSHi8o+LhWVBXZHtMiPoCLNZyL4Zo3x7ltlQyypVA=;
        b=ohvl6ZumDABVRj83loQ2BwckqzVyIbRXd8UBEg2nDN2tcGPMzauHUTTlQDWDJR2TY9
         lvWkBIrqUQbE3RR5heavhOYAncg1gQlhKnCvEx8TLDGvgYchiKjUHwJQZm5X/5Rg975I
         QNu8xVO2yG1wk2vVFozRyOez7x43ZL335QcwzqWEgu7+MNfCFuJmjSw04j2BWQt4wWLC
         JG2oDXkMCLflucNMlJrPi+3UG+f801f7recYtweH8OB+shWAd6soqIiSPZy0eQvHXkxK
         O9o96LGNgqFjMbOPebYbHaCcDm+dhwbbDl9hU3b7ZFFuJ7PL1VyRzzZOBtPIV3kWqhSF
         8hAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+mkZpk28m3Y75Acr4ogBqqSrAL43ekv3unzZdNZQWjgTYTcqAKT4pAXL8w8LMphEGAf7lb7H3TLs=@vger.kernel.org, AJvYcCXK1vmm3eaGyd0g+TdzAsKMk7dw0tqcZJU1RD0LGtZPWcZzjtamLXRYgr8jWbdecGFA/BxOtcbUR/pMi5bg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Ilk1bAAh6gK1rgtVunwnbhcBkDyyk/EiVOwAY8K9RIqf6s+f
	OeJLVK1B13VJrrmE5qp+cx9n1AZTSzrD4LSutD6FHM4yTErWoQr5kv5Q
X-Gm-Gg: ASbGncuejYqHvUGllnzdFQC6f3Uk64RbrXGI76jnxI52JQ7Ao5PdovBV+qKv4bC9VKp
	PSBj+FVrJKtUknmCEi9p3RqZMN+1s2mZ84UV+F7Msep0Zl4YcTdTyqpE/xZCaMopzeFbtBvmacJ
	uJP4pmOWxlB5zobhUEatUrtCztPwYInLUdibuwN7I28Q5yfN3RZS4KcUtbB6mYA13lYB3kvrINc
	tYVmajY+qXJeDMnGTMIW49MqP3ek8YUPscSOV7oi5gycvJgWPFM/SLcjYjX2p6Td4iBKRKGQyOR
	tEK0+07TRth3aVXAMg1kPT5tET7ztLYipGGmajuSWSW3tN200Rl0uebf3VlZiLCd0wVAu1PJK8A
	+odvrflg=
X-Google-Smtp-Source: AGHT+IHKEK977MUyeP+iX8FWA6em280Bb2xxq8On52e+HzVmSP39OMEedbCQWl+WgqWCiO+aaXyLvQ==
X-Received: by 2002:a05:6902:18d1:b0:e89:97db:e13a with SMTP id 3f1490d57ef6-e8b6e0bb33emr1141015276.2.1752022823136;
        Tue, 08 Jul 2025 18:00:23 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:00:22 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	vtavarespetr@micron.com,
	ajayjoshi@micron.com
Subject: [PATCH v4 02/13] mm/damon/core: add damos->migrate_dests field
Date: Tue,  8 Jul 2025 19:59:32 -0500
Message-ID: <20250709005952.17776-3-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709005952.17776-1-bijan311@gmail.com>
References: <20250709005952.17776-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

Add a new field to 'struct damos', namely migrate_dests, to allow DAMON
API callers specify multiple migration destination nodes and their
weights.  Also update 'struct damos' creation and destruction functions
accordingly to initialize the new field and free up the API
caller-allocated buffers on those, respectively.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 include/linux/damon.h | 13 ++++++++++---
 mm/damon/core.c       |  4 ++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 07cee590ff09..1f425d830bb9 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -470,6 +470,7 @@ struct damos_migrate_dests {
  * @apply_interval_us:	The time between applying the @action.
  * @quota:		Control the aggressiveness of this scheme.
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
+ * @migrate_dests:	Destination nodes if @action is "migrate_{hot,cold}".
  * @target_nid:		Destination node if @action is "migrate_{hot,cold}".
  * @filters:		Additional set of &struct damos_filter for &action.
  * @ops_filters:	ops layer handling &struct damos_filter objects list.
@@ -488,9 +489,12 @@ struct damos_migrate_dests {
  * monitoring context are inactive, DAMON stops monitoring either, and just
  * repeatedly checks the watermarks.
  *
+ * @migrate_dests specifies multiple migration target nodes with different
+ * weights for migrate_hot or migrate_cold actions.  @target_nid is ignored if
+ * this is set.
+ *
  * @target_nid is used to set the migration target node for migrate_hot or
- * migrate_cold actions, which means it's only meaningful when @action is either
- * "migrate_hot" or "migrate_cold".
+ * migrate_cold actions, and @migrate_dests is unset.
  *
  * Before applying the &action to a memory region, &struct damon_operations
  * implementation could check pages of the region and skip &action to respect
@@ -533,7 +537,10 @@ struct damos {
 	struct damos_quota quota;
 	struct damos_watermarks wmarks;
 	union {
-		int target_nid;
+		struct {
+			int target_nid;
+			struct damos_migrate_dests migrate_dests;
+		};
 	};
 	struct list_head filters;
 	struct list_head ops_filters;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index ab28ab5d08f6..62acfd5cf4ea 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -407,6 +407,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	scheme->wmarks = *wmarks;
 	scheme->wmarks.activated = true;
 
+	scheme->migrate_dests = (struct damos_migrate_dests){};
 	scheme->target_nid = target_nid;
 
 	return scheme;
@@ -449,6 +450,9 @@ void damon_destroy_scheme(struct damos *s)
 
 	damos_for_each_filter_safe(f, next, s)
 		damos_destroy_filter(f);
+
+	kfree(s->migrate_dests.node_id_arr);
+	kfree(s->migrate_dests.weight_arr);
 	damon_del_scheme(s);
 	damon_free_scheme(s);
 }
-- 
2.43.0


