Return-Path: <linux-kernel+bounces-815020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D9BB55E45
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 06:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B60BA062AC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 04:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440E51F0E55;
	Sat, 13 Sep 2025 04:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ecc7ux5w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33B92DC796
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 04:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757737495; cv=none; b=eJPeCi3CyEQuPiRQkt3RMvMvp4xZFA891WtEMlZztUhd6DKhHHK6MFP88VN5HwUuEpBDOUoiBX8TUBGarSYbM79otbbOkkJGnQZBCpuj9EMQg6G2qDciDRucmiyz4I7zvY9xROy4VWOZ8q+aZZs8cCUpbXv8wUlKUz2kvYPBRCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757737495; c=relaxed/simple;
	bh=Le4RnuqC/YCuMt5uPRuKPaIAosuU0L5uQtZVuQ72+Xs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hMp0WjEr6+QjVlUJ4Dx747MMRCYNMe09kMcuaY5wMvR5/tytGjkIEuKUZWSsdVchbBc1gtghG/LTcTsKhmxWjcciXJLymcIgF1YsbX7SzCI9XGXQK4RJ5yAHWgE08hiPeZ4woQcMSDDbcHAUUAx9NddUMAb6KN9HpINi5cW4hpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ecc7ux5w; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757737494; x=1789273494;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Le4RnuqC/YCuMt5uPRuKPaIAosuU0L5uQtZVuQ72+Xs=;
  b=Ecc7ux5wgSvGrEwP0KoW+CD9BSNy7TxBD1d6RNXWgCIJ6xmTxeIxM7mH
   UhN/05SNAqB+aC//XjMTXXHkAZCwcRef3+1N//jtKm8hOEgQsiaREfRrx
   hH7t0P9sXsoQyfJa32p1jhErlVNc0HRmLVfpLlLsfw9iQrhmvl7yirajS
   3iX5f0l5JN1vHXIupjBf3C3cKbKa55/m8JR80puAucv0ClUKXxw60dGkL
   RGzQ1RsnPlGtcFWm9FNtmONQZAh0tDyS2/jO8NuXOV45PyTvMJkZZXZrh
   wRcG5EZHdCK2PdWieOk31NnSWK5EOILEPZtx66j/hZLibT8cicBHX/all
   A==;
X-CSE-ConnectionGUID: fBdAGecOTaiVremTE7gdnA==
X-CSE-MsgGUID: 9YUvBUQ+QbKwWmGlx4+kyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60140603"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60140603"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 21:24:54 -0700
X-CSE-ConnectionGUID: 3pr5UAyfQjet5irIfBntNw==
X-CSE-MsgGUID: vAw5f6QDRKyYuErf/Akttg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; 
   d="scan'208";a="197869451"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa002.fm.intel.com with ESMTP; 12 Sep 2025 21:24:51 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] sched/deadline: Add bounds check in cpudl_maximum()
Date: Sat, 13 Sep 2025 09:53:15 +0530
Message-Id: <20250913042315.1292065-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a bounds check to cpudl_maximum() to prevent accessing cp->elements[0]
when the heap is empty. Return -1 when cp->size is 0 to indicate that no
valid CPU is available in the deadline heap.

Without this check, accessing cp->elements[0] when the heap is empty could
lead to undefined behavior.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 kernel/sched/cpudeadline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 0f7127b3a05c..dd736e3879c8 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -103,6 +103,8 @@ static void cpudl_heapify(struct cpudl *cp, int idx)
 
 static inline int cpudl_maximum(struct cpudl *cp)
 {
+	if (cp->size == 0)
+		return -1;
 	return cp->elements[0].cpu;
 }
 
-- 
2.34.1


