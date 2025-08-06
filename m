Return-Path: <linux-kernel+bounces-758465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BA1B1CF82
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3616318C5E18
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387D5277CAB;
	Wed,  6 Aug 2025 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVCpH+2u"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AC419DF6A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 23:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754523797; cv=none; b=F6UqnByeJ18RAE93mDBfINr3CUq2ne72T1AH4p6AHUvhohd+aeWFEWbd+1Z9Ouhqr4i4lQdcBjBpmEKkY2EkKTRyyiEuC9pcafrSA1GeVwRxmyNHW8qQ2KFsHkHVt8tkiJib5BGAVlY/tLbKWTGQbVoy8aUbL8xar1OqVwpuWGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754523797; c=relaxed/simple;
	bh=/W92kUb+TXnluRqaL68VPO0zwa9YeUOvdI55X1iPeMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wf2IW2lml2cTjwN52KjxyaYn26uESMdQ6cEmKplEyC99ZmlSFRRnbdU5eC8mspKmmkVfDF4N+PdXm2qmLOMNrRhXgETUJ0JlM00h5QmGsuKtQqkQ2I7pCUEypnZ6GS3GaNQ/JX1hkpweccO8Id72OMIRFbV30PBsLfuRGC9aqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVCpH+2u; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8e014c1d19so357573276.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 16:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754523793; x=1755128593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cfT15tOepazFTL2Lg8MMF8cCYjiRwORhTnogRj+tN3g=;
        b=EVCpH+2udjH+aWH/vCJexIZNfyF6/s4AYU/+l8GouOSYOSdS0SxteE8F/tDiMiNqdh
         CAuLwnArmxLMOKXWg+b8grxbJzWKvs8UpHgcELlol6Uy+vwQVK2xJmm2eumg/R9F82Md
         rZx70PYYIQd1gJAT2htVxh9qMyQp/TdxSyghhD5AwW9JjFApTSOjI9gVmp2+0ypZOfOY
         tW3bhDqbgAZYbT+CVkzRSINonNgy0zw4epwWXEzdC670EsC5aFC53zUngef3IwSRMKDh
         LRYbBOw0IR5ktNqQk9EG5BfQQojam38xY5IEfLPq2Z8gdrNDJI1nrn+H5QKVdelSfYaa
         yUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754523793; x=1755128593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfT15tOepazFTL2Lg8MMF8cCYjiRwORhTnogRj+tN3g=;
        b=Ai5ui21nGhimpTI4o2BoUqtlJMvgySr6ouawAxUr61W8Ik33OP31opIG7BJE1S0T4Z
         +D7Ws5LP2oOQJKbvCxvzw+F85aid8BZk6FeFo3u77dZ0jPpisOpouNUaFR89EWnxvvvZ
         B5saymM7lUPvd+tuh6vht+vW8dKdx4MBYgHWXNoQilYGCARLaGN7hMkaaVMYeGHMBQ5Z
         6MxjVDU5gPQSh1hfHmk1DNayz+HfSlhfXegKF4RCZey+hTEg2gBLMHuwnZeJ19lMhIk7
         RoEN/234ZqOIZDkV8FpgEUXRiV7k2mVWAzuiQ8sPnGPMVeFnD6bobYfVaRmL5lys4kL4
         rF4A==
X-Forwarded-Encrypted: i=1; AJvYcCUqwiD94/7V0g/qwfVUiyPVnBsl9MH2E92CbJbvVN/62KalXqdk48DtIJHA3IGtzuq8lhcvvE19aXzkp90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHoepJRjgVsT+JKec3zvIT6Yk+wUZjX8Y7JTMSFU+BdLqX1AZ5
	Ezxn8Epw2U4f0BZn6gPlsMkWf8c/E6sg1WaBVcjRasVANnUL80djHq4DST2Mnw==
X-Gm-Gg: ASbGnctF8abvar3VyIscHpfPx2k/vQCyQZzKlgAd82znTM8vCkiFKGYijmSoOhzy8i3
	H0jTJx/sknqu12+1JRwO5b2BDHbCBe/fhKQqV8rOF0bEB0BDD7U2qsmOsOP6g24uNDV9N8qjIhw
	dF5uOlJu2s3kz9N5A2vtSVPAuvhmkgPyHbWzLJPXDoxCqR5XdlTGDuikHvVIxSWejkfWodHAI8N
	wsPZ5UbkTyc3wfFLdU8OKmnzqHV8TFHPHsnwzh1QONZbbAqganNXLTA+NPGGulAONbqI1gj2n82
	awgKzrtEENk+stnSMeNxiLmYzBh2HdOUjfD32z5cTpaXg/iyNRqhjss6J5aw+Ctxhq3aA0FzdHE
	F9gcNAfFIl2Z5pbYwQgt7lswvyo2dGPg/Mt/rX2Yp8Af5tWt2AlRb
X-Google-Smtp-Source: AGHT+IErqUmAYFMk9ex7yBFNFktwhE0CW7kYKo02zKyww8eNDXZVT5/FhMr+He7/ul7nzCXLh9hJVw==
X-Received: by 2002:a05:6902:4389:b0:e90:235f:6c1 with SMTP id 3f1490d57ef6-e902ac7df0amr4638106276.25.1754523792936;
        Wed, 06 Aug 2025 16:43:12 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:9e66:4583:8a9c:a62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e900da4155csm2593946276.39.2025.08.06.16.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 16:43:12 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: sj@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijantabatab@micron.com>,
	Bijan Tabatabai <bijan311@gmail.com>
Subject: [PATCH v2] mm/damon/core: skip needless update of damon_attrs in damon_commit_ctx()
Date: Wed,  6 Aug 2025 18:42:54 -0500
Message-ID: <20250806234254.10572-1-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

Currently, damon_commit_ctx() always calls damon_set_attrs() even if the
attributes have not been changed. This can be problematic when the DAMON
state is committed relatively frequently because damon_set_attrs() resets
ctx->next_{aggregation,ops_update}_sis, causing aggregation and ops
update operations to be needlessly delayed.

This patch avoids this by only calling damon_set_attrs() in
damon_commit_ctx when the attributes have been changed.

Cc: Bijan Tabatabai <bijan311@gmail.com>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
Changes from v1[1]:
  - Compare entirety of struct damon_attrs
  - Apply logic in damon_commit_ctx() instead of damon_set_attrs()

[1] https://lore.kernel.org/all/20250806164316.5728-1-bijan311@gmail.com/
---
 mm/damon/core.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6a2fe1f2c952..80aaeb876bf2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -570,6 +570,24 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
 	kfree(ctx);
 }
 
+static bool damon_attrs_equals(const struct damon_attrs *attrs1,
+		const struct damon_attrs *attrs2)
+{
+	const struct damon_intervals_goal *ig1 = &attrs1->intervals_goal;
+	const struct damon_intervals_goal *ig2 = &attrs2->intervals_goal;
+
+	return attrs1->sample_interval == attrs2->sample_interval &&
+		attrs1->aggr_interval == attrs2->aggr_interval &&
+		attrs1->ops_update_interval == attrs2->ops_update_interval &&
+		attrs1->min_nr_regions == attrs2->min_nr_regions &&
+		attrs1->max_nr_regions == attrs2->max_nr_regions &&
+		ig1->access_bp == ig2->access_bp &&
+		ig1->aggrs == ig2->aggrs &&
+		ig1->min_sample_us == ig2->min_sample_us &&
+		ig1->max_sample_us == ig2->max_sample_us;
+
+}
+
 static unsigned int damon_age_for_new_attrs(unsigned int age,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
 {
@@ -1198,9 +1216,11 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	 * 2. ops update should be done after pid handling is done (target
 	 *    committing require putting pids).
 	 */
-	err = damon_set_attrs(dst, &src->attrs);
-	if (err)
-		return err;
+	if (!damon_attrs_equals(&dst->attrs, &src->attrs)) {
+		err = damon_set_attrs(dst, &src->attrs);
+		if (err)
+			return err;
+	}
 	dst->ops = src->ops;
 
 	return 0;
-- 
2.43.0


