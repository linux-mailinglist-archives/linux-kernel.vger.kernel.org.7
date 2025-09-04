Return-Path: <linux-kernel+bounces-800563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D59B43948
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B99176F0C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E729C2F90E2;
	Thu,  4 Sep 2025 10:53:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C272713B5AE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756983206; cv=none; b=KO1RVcfLaQcqF87h6f2AiU525/0BYqJ8mdFp8Lw6594ThKW6VB1XHaDkEl72OI9P5KeIGW9G1609iei4pQeHt4Kfh9EUIjwqhH0bA9r1i262d4n20Ldg5wcpwIVzgDUVZT2o3uJ5jloCH4/ZnPNGJbhtOZ/ZeJp3dUIBuIux+gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756983206; c=relaxed/simple;
	bh=gUN/ZW4KvGQOdeqR8aU1Idybq150PRVccSLO4ebU/d4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mdKr9sC69Yp2lwIcvjpQtYzCly2aI27cMdCTd10yCUVtM06YospTfcq3aZJ7yAqecXkAePq7DExuxB+E56CH81ApmxvvhKQOBIuejytJJLFXwM5rgJ/S/+IEB4zSKyBEb/KRL1R/GuIIZ7z/urdEoXQqpPXVWJxL4LRzHeEbe+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C99F22E98;
	Thu,  4 Sep 2025 03:53:15 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A20DB3F6A8;
	Thu,  4 Sep 2025 03:53:22 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 04 Sep 2025 11:53:04 +0100
Subject: [PATCH] coresight: perf: Fix pointer check with IS_ERR_OR_NULL()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-cs_etm_auxsetup_fix_error_handling-v1-1-ecc5edf282a5@arm.com>
X-B4-Tracking: v=1; b=H4sIAI9vuWgC/x2N4QqCQBAGX0X2dweXFGKvErFcd5+2UKfsagjiu
 7f0c2CY2cmgAqNbs5PiKyZTdTifGsqvVEcEKc7UxvYa+3gJ2RjLh9O6GZZ15kE2huqk7Hp5Sx1
 DfnaIHUqfykAemhVu/Sf3x3H8ALQBfQR0AAAA
X-Change-ID: 20250904-cs_etm_auxsetup_fix_error_handling-cb7e07ed9adf
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Tamas Zsoldos <tamas.zsoldos@arm.com>, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756983202; l=1661;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=gUN/ZW4KvGQOdeqR8aU1Idybq150PRVccSLO4ebU/d4=;
 b=QWI/ZPBR2t1UE7dFZrvbApqTI04e5+fJVZrjlXO2btD5VhnPcXlBHbYw4I1p7FXEd3kkKQAAW
 4V0fjusEoKsAj2fME8m4GLjO6vCqwiQvFrc7aQ5jQFrGOOyNi1Snu2N
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The returned pointer from .alloc_buffer() callback can be an error, if
only checking NULL pointer the driver cannot capture errors. The driver
will proceed even after failure and cause kernel panic.

Change to use IS_ERR_OR_NULL() check for capture error cases.

Fixes: 0bcbf2e30ff2 ("coresight: etm-perf: new PMU driver for ETM tracers")
Reported-by: Tamas Zsoldos <tamas.zsoldos@arm.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f677c08233ba1a28b277674662c6e6db904873dd..440d967f5d0962df187a81b0dd69a7d82a8b62ba 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -198,7 +198,7 @@ static void free_sink_buffer(struct etm_event_data *event_data)
 	cpumask_t *mask = &event_data->mask;
 	struct coresight_device *sink;
 
-	if (!event_data->snk_config)
+	if (IS_ERR_OR_NULL(event_data->snk_config))
 		return;
 
 	if (WARN_ON(cpumask_empty(mask)))
@@ -450,7 +450,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	event_data->snk_config =
 			sink_ops(sink)->alloc_buffer(sink, event, pages,
 						     nr_pages, overwrite);
-	if (!event_data->snk_config)
+	if (IS_ERR_OR_NULL(event_data->snk_config))
 		goto err;
 
 out:

---
base-commit: fa71e9cb4cfa59abb196229667ec84929bdc18fe
change-id: 20250904-cs_etm_auxsetup_fix_error_handling-cb7e07ed9adf

Best regards,
-- 
Leo Yan <leo.yan@arm.com>


