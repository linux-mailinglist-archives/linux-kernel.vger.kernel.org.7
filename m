Return-Path: <linux-kernel+bounces-756724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B990B1B85F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B39182FCC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61C8292B4F;
	Tue,  5 Aug 2025 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGR2Cfui"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3594028BABE;
	Tue,  5 Aug 2025 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410858; cv=none; b=kUtMTw8vVh7Z1w+lqElKnHlnrBN3aM/rdaCrf1XHsaIY1A1Jaod7KC6Hx9widNllRaPcIS+1aV1vaQCGYU/c1nTT1vb5jVL+Oa86ag8mPjTfG0hrMusZzd2OhGgLPqLaoLLuj8WkFLFv7dFfZZ96G4qQRQ4ZVditrnQv0kqXRgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410858; c=relaxed/simple;
	bh=a2md+4vsTqK11YqhnkKXK2lQnHwV8IUnDfnplUt2rhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKQ/BAyiCFGjUhKAomeoI9zXJfve1Dd3JIPak6yT1hyrokR96KocvTsYm5ln8q85fjZO+9YZ6eHb3rW2CUT2Csn7iKof3dpRYxyUhjCMPn+hbUok41GBuwfdYHoWPcRdAKgrNsZBQUUTc6VCLOi+/R0fpkq8xUTu+sx4+SxX0Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGR2Cfui; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71b49a8adb2so52757267b3.1;
        Tue, 05 Aug 2025 09:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754410856; x=1755015656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bx5UQH2AP53zKZgFMv/Gb2uS3eFAcrg1hCo7F6RktNc=;
        b=hGR2CfuirZ7F3HMuP+BVeDO2/ytrNK1LrmDgpNY6iVeGbJUwmIuah73g/EZogqPljZ
         USCd1gEZ/tlQiqbVKH5+6GBxdU1Y0O7p15NZxij5mzsb+g765UYCM5chVdwnOwLOVwGj
         hYLoCzHQ8w4EBuVBVOa8+pJwIZ4PmZIOJZl2JvSqDZGhA2Xg85pSeJ1Y4IGTQe4XdjVR
         dgfr7e63CVlKHeonUx3VqtvEwWnN68twB/gWLlNQdmz4tx3FuTVdbl8B0VUzwyqQOFiK
         9qmd310V6j1wgbZ3BWozV38GpIHGBEvznjJV4kB/q3eG2NIlBdxKkIHt8uF32x+BFRwW
         yTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410856; x=1755015656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bx5UQH2AP53zKZgFMv/Gb2uS3eFAcrg1hCo7F6RktNc=;
        b=XeN+FNF+GOdk0Icsh2N66Exm0GCSxlbBG5xQg8eLMHK+ra6IAbVTEKfeMgwiC8ge9e
         AEiFVCDNV0jkvT1+wQ7sN30iEPGJx+fncYCoSsNNe419cJwhGPI6VJ+pvosJVeIftrMj
         rkb0ctNpM7wUImjtIq2EplTXe7oFL+w9Xmp8bW07qw/k/BDq1vn6n4NGLKj3cQiLiPZG
         UqFeP8JSwlZieB3a7d0AGU7y2JQAG2+2hjsRNYoaZeGP0kgVUFFhSTf6WBIlWaGjbrIE
         QnT4HaRP9HFK2+PTP1Eauu4WMQ1SZxDex0KatSGbFee8SIikdEsdprL9s4xPfRHhAgMb
         tR4g==
X-Forwarded-Encrypted: i=1; AJvYcCUFDjmGEmF6mBjJf2Aeb3GoxTjtvuPxUrpz2uqofj8NcsGnfXHXd3TuXV90znj6tAU70z3LG4awTY4=@vger.kernel.org, AJvYcCUz6f28nvBvjvEZbEby6Eu1WGfOFoSc54bBCb7v9dVK8y8Jp1+nKrJGVy3MVA3yxY9szGdpWyPR///knZxo@vger.kernel.org
X-Gm-Message-State: AOJu0YwxNjQqz+tITKR4WRv7fsqD43Ak3BOAczZ8viuv0HNOvTWgqx1f
	oIEdTQO5l94a1cAOqRL7TZRUKE1+aTsm9ZPlYAOiUspfyHsBtK8RTVhooIXXEg==
X-Gm-Gg: ASbGncvVk8hsMS7SiRb/zTuWH3nRr/Z1byktz5N/BNCw2RIDEOxOpyxlfP3+3SKkfGG
	AC1PW4atuv2EzokNudNnusgwMdoEg6vgHmtLJJfI8uEwquaPaCkyh3Sf2EiSAz6aMkmHEhFupon
	6oPgB0oJjK1DbuKGcTQH6tqOdnvsmEDRcNqo4WwGRkJcwV0XUyRqVBFQHYrwxLRa3zqFHK4qF30
	qSspHZT1vFGkYBVySZXO2Xx/N5Prmb4MSjXxW8KIAlxZp5Y4LocyYoiboK3BgihpNThQHZXWq1v
	DbCGwNPdQUnT60DnWALl7TH6Zuk+iXJP3QsGXpA4cZBggJGolnr+/BGh8TMMi9/W18piFQ0gsLz
	SB4BwX9O1lumaNDwD9YcBVpB3LSeLsGNk+BBfr/02i7I=
X-Google-Smtp-Source: AGHT+IFlo58+shaatwrcSK3z92CxM5zcfRVC7mFQfOpwfhIPPC64bmge/xE/VJyP1a2lBc5ROadoGg==
X-Received: by 2002:a05:690c:102:b0:719:4c68:a70f with SMTP id 00721157ae682-71b7f7f5e71mr172583967b3.20.1754410855971;
        Tue, 05 Aug 2025 09:20:55 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:2c65:e45a:e7d5:5f0e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5cdfc5sm33098757b3.77.2025.08.05.09.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:20:55 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	corbet@lwn.net,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: [PATCH 2/5] mm/damon/sysfs: Implement a command to only commit scheme dests
Date: Tue,  5 Aug 2025 11:20:19 -0500
Message-ID: <20250805162022.4920-3-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805162022.4920-1-bijan311@gmail.com>
References: <20250805162022.4920-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

To update DAMOS migration dests, users need to write "commit" to the
"state" file of kdamond, which will recommit all of the damon parameters.
This patch implements another state file input command,
"commit_scheme_dests," that only commits the DAMOS migration dests.

This provides two benefits:
1) It is slightly more efficient
2) When the "commit" command is sent to the state file,
   ctx->next_{aggregation/ops_update}_sis are reset. If a user sends the
   "commit" command frequently (relative to the aggregation and
   ops_update periods) to update the migration dests, the aggregation and
   ops_update events will be prevented from triggering. Having a
   separate command side steps this problem.

Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 mm/damon/sysfs-common.h  |  3 +++
 mm/damon/sysfs-schemes.c | 35 ++++++++++++++++++++++++++++++++---
 mm/damon/sysfs.c         | 27 +++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 2099adee11d0..3189b2bda079 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -59,3 +59,6 @@ int damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
 void damos_sysfs_update_effective_quotas(
 		struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx);
+
+int damos_sysfs_set_schemes_dests(struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index d355f6c42a98..d30c8b6575c2 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2445,10 +2445,9 @@ void damos_sysfs_update_effective_quotas(
 	}
 }
 
-static int damos_sysfs_add_migrate_dest(struct damos *scheme,
+static int damos_sysfs_add_migrate_dest(struct damos_migrate_dests *dests,
 		struct damos_sysfs_dests *sysfs_dests)
 {
-	struct damos_migrate_dests *dests = &scheme->migrate_dests;
 	int i;
 
 	dests->node_id_arr = kmalloc_array(sysfs_dests->nr,
@@ -2468,6 +2467,35 @@ static int damos_sysfs_add_migrate_dest(struct damos *scheme,
 	return 0;
 }
 
+int damos_sysfs_set_schemes_dests(struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx)
+{
+	struct damos *scheme;
+	int i = 0;
+
+	damon_for_each_scheme(scheme, ctx) {
+		struct damos_sysfs_dests *sysfs_dests;
+		struct damos_migrate_dests dests = {};
+		int err;
+
+		/* user could have removed the scheme sysfs dir */
+		if (i >= sysfs_schemes->nr)
+			break;
+
+		sysfs_dests = sysfs_schemes->schemes_arr[i]->dests;
+		err = damos_sysfs_add_migrate_dest(&dests, sysfs_dests);
+		if (err) {
+			damos_destroy_dests(&dests);
+			return err;
+		}
+
+		damos_destroy_dests(&scheme->migrate_dests);
+		scheme->migrate_dests = dests;
+	}
+
+	return 0;
+}
+
 static struct damos *damon_sysfs_mk_scheme(
 		struct damon_sysfs_scheme *sysfs_scheme)
 {
@@ -2530,7 +2558,8 @@ static struct damos *damon_sysfs_mk_scheme(
 		damon_destroy_scheme(scheme);
 		return NULL;
 	}
-	err = damos_sysfs_add_migrate_dest(scheme, sysfs_scheme->dests);
+	err = damos_sysfs_add_migrate_dest(&scheme->migrate_dests,
+		sysfs_scheme->dests);
 	if (err) {
 		damon_destroy_scheme(scheme);
 		return NULL;
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 1af6aff35d84..c2b036abb25b 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1188,6 +1188,11 @@ enum damon_sysfs_cmd {
 	 * to DAMON.
 	 */
 	DAMON_SYSFS_CMD_COMMIT_SCHEMES_QUOTA_GOALS,
+	/*
+	 * @DAMON_SYSFS_CMD_COMMIT_SCHEMES_DESTS: Commit the scheme dests to
+	 * DAMON.
+	 */
+	DAMON_SYSFS_CMD_COMMIT_SCHEMES_DESTS,
 	/*
 	 * @DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS: Update scheme stats sysfs
 	 * files.
@@ -1230,6 +1235,7 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"off",
 	"commit",
 	"commit_schemes_quota_goals",
+	"commit_schemes_dests",
 	"update_schemes_stats",
 	"update_schemes_tried_bytes",
 	"update_schemes_tried_regions",
@@ -1478,6 +1484,23 @@ static int damon_sysfs_commit_schemes_quota_goals(void *data)
 	return damos_sysfs_set_quota_scores(sysfs_ctx->schemes, ctx);
 }
 
+static int damon_sysfs_commit_schemes_dests(void *data)
+{
+	struct damon_sysfs_kdamond *sysfs_kdamond = data;
+	struct damon_ctx *ctx;
+	struct damon_sysfs_context *sysfs_ctx;
+
+	if (!damon_sysfs_kdamond_running(sysfs_kdamond))
+		return -EINVAL;
+	/* TODO: Support multiple contexts per kdamond */
+	if (sysfs_kdamond->contexts->nr != 1)
+		return -EINVAL;
+
+	ctx = sysfs_kdamond->damon_ctx;
+	sysfs_ctx = sysfs_kdamond->contexts->contexts_arr[0];
+	return damos_sysfs_set_schemes_dests(sysfs_ctx->schemes, ctx);
+}
+
 /*
  * damon_sysfs_upd_schemes_effective_quotas() - Update schemes effective quotas
  * sysfs files.
@@ -1644,6 +1667,10 @@ static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 		return damon_sysfs_damon_call(
 				damon_sysfs_commit_schemes_quota_goals,
 				kdamond);
+	case DAMON_SYSFS_CMD_COMMIT_SCHEMES_DESTS:
+		return damon_sysfs_damon_call(
+				damon_sysfs_commit_schemes_dests,
+				kdamond);
 	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS:
 		return damon_sysfs_damon_call(
 				damon_sysfs_upd_schemes_stats, kdamond);
-- 
2.43.5


