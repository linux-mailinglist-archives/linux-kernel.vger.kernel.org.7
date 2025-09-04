Return-Path: <linux-kernel+bounces-800970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB3CB43E54
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3499B3B9E35
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662522EBDCA;
	Thu,  4 Sep 2025 14:14:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E01220408A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995248; cv=none; b=kzCTuU4sz2pLWtZ5cyER3JTNLWNehK2yQUqpkhrVf8fYM8hIYcSiGyXXqd9LJCLFBK9GCOwc0kVZeNHu65x+GfVgIeEnAkfI2F6I2YWQjtH0NSNpDsifBgzKJSFIz/v4nXJc86Q3zdl6nk/IbdpTQE6ab/YykI+zGV43XtVonqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995248; c=relaxed/simple;
	bh=g1Fb62DfXIZHZG4UIGOigbgf49jhagB+MS0+w+reNYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=K2dkcfE5wA8PSdrrn23T7MnalYbHzUc8zs7otMRGjXotgGwmeXZXPmpSXe6WMkjf3ZK3BgO0OVvcqFJDVzmDzrlO+cJzEB8nzBU233qEoZBC04QPsHB4ZmNlKcNXl7iY8J6FJdYQauovxtRG6Od7xVHUkuJdp0dMEMU/ZV9eGrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 654551596;
	Thu,  4 Sep 2025 07:13:56 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E33D3F63F;
	Thu,  4 Sep 2025 07:14:03 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 04 Sep 2025 15:13:52 +0100
Subject: [PATCH v2] coresight: trbe: Return NULL pointer for allocation
 failures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-cs_etm_auxsetup_fix_error_handling-v2-1-a502d0bafb95@arm.com>
X-B4-Tracking: v=1; b=H4sIAJ+euWgC/5WNQQqDMBBFryKzbkoMDdaueg+RkCajDlQjEw0W8
 e5NvUGX7/N5b4eITBjhUezAmChSmDKoSwFusFOPgnxmUFJpWcubcNHgMhq7bhGXdTYdbQaZA5t
 892+aeuFeFcoKfW19B1k0M+bXGWnazAPFJfDnbKbyt/6lT6UoBTqn0Xfqrqx+Wh6vLozQHsfxB
 T5ZpvLSAAAA
X-Change-ID: 20250904-cs_etm_auxsetup_fix_error_handling-cb7e07ed9adf
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Tamas Zsoldos <tamas.zsoldos@arm.com>, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756995243; l=2077;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=g1Fb62DfXIZHZG4UIGOigbgf49jhagB+MS0+w+reNYs=;
 b=JTCG2rHM8KtlbUkkR4xcwj0A9r4Rl+TvqXelMpCDRjaREDVAI7DSqz+13qxsXNE7eUoVsSt1D
 rvOHYrBkxSjArip8+dGvDw1sowHALm2LC8rKm+uXXFOWy76w6ROdW7J
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

When the TRBE driver fails to allocate a buffer, it currently returns
the error code "-ENOMEM". However, the caller etm_setup_aux() only
checks for a NULL pointer, so it misses the error. As a result, the
driver continues and eventually causes a kernel panic.

Fix this by returning a NULL pointer from arm_trbe_alloc_buffer() on
allocation failures. This allows that the callers can properly handle
the failure.

Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
Reported-by: Tamas Zsoldos <tamas.zsoldos@arm.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v2:
- Fix TRBE driver instead of changing coresight-etm-perf.c.
- Link to v1: https://lore.kernel.org/r/20250904-cs_etm_auxsetup_fix_error_handling-v1-1-ecc5edf282a5@arm.com
---
 drivers/hwtracing/coresight/coresight-trbe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 10f3fb401edf6a00b24b38cdaa7c2865e7a191ac..8f9bbef71f236b327d35a288689df9b0dd8ff3f4 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -748,12 +748,12 @@ static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
 
 	buf = kzalloc_node(sizeof(*buf), GFP_KERNEL, trbe_alloc_node(event));
 	if (!buf)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	pglist = kcalloc(nr_pages, sizeof(*pglist), GFP_KERNEL);
 	if (!pglist) {
 		kfree(buf);
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 	}
 
 	for (i = 0; i < nr_pages; i++)
@@ -763,7 +763,7 @@ static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
 	if (!buf->trbe_base) {
 		kfree(pglist);
 		kfree(buf);
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 	}
 	buf->trbe_limit = buf->trbe_base + nr_pages * PAGE_SIZE;
 	buf->trbe_write = buf->trbe_base;

---
base-commit: fa71e9cb4cfa59abb196229667ec84929bdc18fe
change-id: 20250904-cs_etm_auxsetup_fix_error_handling-cb7e07ed9adf

Best regards,
-- 
Leo Yan <leo.yan@arm.com>


