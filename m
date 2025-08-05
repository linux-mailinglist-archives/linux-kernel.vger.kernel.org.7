Return-Path: <linux-kernel+bounces-756725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA680B1B85A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D89418A6E23
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742972957B6;
	Tue,  5 Aug 2025 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLIz/Vr/"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AA2292B55;
	Tue,  5 Aug 2025 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410862; cv=none; b=btNBxBMfDN99xLGt83waWs9DNaSP+pCdZVGrX3tlqt3zyhc7kWCz9NV/AYbLTpLw2X9hEnarqrDNiBfBqTvJ3WG6VWW0xO4ADdi7rc0IpsgEMms5OHD6p5bZarBaRVBuvhjT1sDSpPdBGhedUuXwKiBYhGhCIavZDpJbrC4tJbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410862; c=relaxed/simple;
	bh=UK5iJbYNS2bkATUR/j8SSeeGik5UMeQlVxFcKrIdg3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfSBSm4KmlK0F7jTOpwPpWv3fwiE22XITuZgyJG/VIWjQAwc0xlerTZRORYOr+ceyCiwRm1bdxqfLEtVWJAn1t68IrBMJIEM6NPBghsRFBSzb7hJoopV8nPdsH/0/IkxskQCzSUq0oxlap7A9yBP9ZJzcu0Xat2/blcZcCJkdX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLIz/Vr/; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70a57a8ffc3so56154987b3.0;
        Tue, 05 Aug 2025 09:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754410860; x=1755015660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTHZI7K9+4GxRlV7Vt7J0J39jlZPj/iqR6Wo5lhHevk=;
        b=dLIz/Vr/Dz3+TIcWyD2ix7l2uc+VXRfzftkv/BNsiN0jQaRD094IpQMavxXd6+m+nA
         fBOoDSBXwJm+9Jewa09Yznvi6nMQj4Pm33Rp4F+dlY6+9ZHhZQ2MVK0aMiRxbtkGjTQ8
         +nWctVnC/QCwiYlX/PKFcWtfokASyiaLh0gqohT67oDSWjn6+cfHGnP6J623fxNL+HCV
         rjHVsWqb3CMI3HbkA7xwaM6KG3pvaUQ307WLUUOjWZYlX1SJzIMXaPoLTKJiM10t9IZM
         keoCLTzjwaLqR2kIqQM/G2uXD17l7wjbie1SVjPMnoze+WiisHWIjU51U5iWfyZQyYk6
         w6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410860; x=1755015660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTHZI7K9+4GxRlV7Vt7J0J39jlZPj/iqR6Wo5lhHevk=;
        b=uq1BlSM3a+9Vp2aZHXa+SWTnekYyeiUU5tA/aK/lB5GYFOfRjDF9+78l+cO3jUehZY
         ePGxaqGta0YPlo1fXBUxuYx+Y+voPDj8sFsh/hcpMgHyrGgbuiu9QDM4rXDdhbgYeiZg
         RHkgmzk67KuodF1hsykfjytQiCwfLN2dSjgROBDGCxfzV3bDjjN7QAoSzWrs56kug23O
         S1K3ZnhQdIl98w3CKkTxhEj8bdtZuT0TwaF5d0tEocFt0OynuxUhsCXlncp6FrnTeeHj
         1jjQBvVhhHloR3c8mS9mxpz4f2NKHe5aTYPOWx/96uSash9HNKdOYBnAugNGaq8U7Lny
         8WAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC6BKeJj7oFAGvMDgZijszQA9F7qMhCjHNBEQomSnylkC+HFe0Pd2mXDZW3ton0HINkuotB5UszHprNdmX@vger.kernel.org, AJvYcCW+fCQSfQKdBKoRuCkPjigFvwRGoWMIgSZoi6fjS04USTLDZ/5XhRECbW6Eqrt/0jfzqaIwvdBcGZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5kBtaJpcI+WHum/sqTzSWGsRFRH1oT8yHV8WwGxOb74SwMTZe
	RxR2gOHcQj/5jr6DYAIrgcaZ4h35jEj//nznAEb1JuwkoOMPHQqvvocI
X-Gm-Gg: ASbGncsX+l/4Zu/ML1oX7LCxIWf5RPb8FIRZCaaKdjjL26oTeZbKaIGTdKeN3dK3d8C
	VcIDaYT76TsR+JOKBT8TUxDn2BwYAfeX89FvGmFCP6iLSPD9yMwTjDixZA2plAY6UkZ40Xre+x0
	VYRFLennYOrm6jqx2JWCPQiJCpDw4l4zwMLVHhOraEf5fsW81O7A8IuDP6Jk9oydDhHhb8K53mt
	7f71BSXHcCgoYkdIlu/I5NPeQSgH+3rut9cFHt3NPl86NmUOesu+hppjkeK9iPN2e3IsI6RPca2
	80HoP97VMS2ucEx09WdaWCXLZ3ZAGtTseZLIjc6KMaXoPy7gi9ZRACUgSIVIuS8vp9zoRy1ClYj
	LnpITOwHceY4Y5OUPPkXHQO/aVs4RdVXmOWBwDJVg6C4=
X-Google-Smtp-Source: AGHT+IEvW39T/sWp90HWrVkoCtc3N9MROV6TVWwJCqhkh0uDVhaEZjbOJNyDmjL1eVTf6OAsvjkH2A==
X-Received: by 2002:a05:690c:6085:b0:712:d54e:2209 with SMTP id 00721157ae682-71b7f5f743fmr175406147b3.14.1754410859891;
        Tue, 05 Aug 2025 09:20:59 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:2c65:e45a:e7d5:5f0e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5cdfc5sm33098757b3.77.2025.08.05.09.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:20:59 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	corbet@lwn.net,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: [PATCH 3/5] mm/damon/sysfs: Implement a command to wait until schemes are applied
Date: Tue,  5 Aug 2025 11:20:20 -0500
Message-ID: <20250805162022.4920-4-bijan311@gmail.com>
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

Any DAMON command that uses damos_walk() internally, such as
update_schemes_tried_bytes and update_schemes_tried_regions, waits until
each scheme in the DAMON context have finished. This can be useful, for
example, if a user wants to know when new scheme parameters they've
committed have been applied. Another use case could be if a user wants
to record the system state every time a scheme is applied for debug
purposes.

This patch adds a new command, wait_for_schemes_apply, which calls
damos_walk() without a walk function so that all it does is wait until
all schemes have been applied. The same functionality can be achieved
by using update_schemes_tried_bytes, for example, but having a separate
command for this avoid unnecessary work. It also makes user intent
clearer when used in scripts.

Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 mm/damon/core.c  |  3 ++-
 mm/damon/sysfs.c | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 07b4fc5a9790..56a13d16e4d1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1731,7 +1731,8 @@ static void damos_walk_call_walk(struct damon_ctx *ctx, struct damon_target *t,
 	if (!control)
 		return;
 
-	control->walk_fn(control->data, ctx, t, r, s, sz_filter_passed);
+	if (control->walk_fn)
+		control->walk_fn(control->data, ctx, t, r, s, sz_filter_passed);
 }
 
 /*
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index c2b036abb25b..ded3f60e4e22 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1223,6 +1223,11 @@ enum damon_sysfs_cmd {
 	 * intevals.
 	 */
 	DAMON_SYSFS_CMD_UPDATE_TUNED_INTERVALS,
+	/*
+	 * @DAMON_SYSFS_CMD_WAIT_FOR_SCHEMES_APPLY: Wait for all schemes to be
+	 * applied.
+	 */
+	DAMON_SYSFS_CMD_WAIT_FOR_SCHEMES_APPLY,
 	/*
 	 * @NR_DAMON_SYSFS_CMDS: Total number of DAMON sysfs commands.
 	 */
@@ -1242,6 +1247,7 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"clear_schemes_tried_regions",
 	"update_schemes_effective_quotas",
 	"update_tuned_intervals",
+	"wait_for_schemes_apply",
 };
 
 static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1643,6 +1649,25 @@ static int damon_sysfs_update_schemes_tried_regions(
 	return damos_walk(ctx, &control);
 }
 
+static int damon_sysfs_wait_for_schemes_apply(
+		struct damon_sysfs_kdamond *sysfs_kdamond)
+{
+	/*
+	 * damos_walk returns after the next time all of the schemes have been
+	 * applied. We don't need to do any actual work, so walk_fn is NULL.
+	 */
+	struct damos_walk_control control = {
+		.walk_fn = NULL,
+		.data = NULL,
+	};
+	struct damon_ctx *ctx = sysfs_kdamond->damon_ctx;
+
+	if (!ctx)
+		return -EINVAL;
+
+	return damos_walk(ctx, &control);
+}
+
 /*
  * damon_sysfs_handle_cmd() - Handle a command for a specific kdamond.
  * @cmd:	The command to handle.
@@ -1688,6 +1713,8 @@ static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 	case DAMON_SYSFS_CMD_UPDATE_TUNED_INTERVALS:
 		return damon_sysfs_damon_call(
 				damon_sysfs_upd_tuned_intervals, kdamond);
+	case DAMON_SYSFS_CMD_WAIT_FOR_SCHEMES_APPLY:
+		return damon_sysfs_wait_for_schemes_apply(kdamond);
 	default:
 		return -EINVAL;
 	}
-- 
2.43.5


