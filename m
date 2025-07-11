Return-Path: <linux-kernel+bounces-728125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6288DB023DF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E54B46AE5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1E62F2C6E;
	Fri, 11 Jul 2025 18:37:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1802E2F49F4
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259045; cv=none; b=MRD9bfHM9WGyc9hXaqXCcRkts8G2JM1tp2Ny/wSwUKA9mEHb3ailpMeAvHpr9Wvep/DgqD/zFOO3YJYX/XYpuU8wdhyD4cRPeVhwpic0banw3oUzazBXdbZ74cws0YjWuKnG9rLWZyl5gB3+fhdX1OxniUsVkvFllxZFTYxUzZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259045; c=relaxed/simple;
	bh=zZn6nw6MIKagEatIZlxSgmu3FXGINHqldSz6WGUn8JQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JA42f5fROJftdUE24fIOeN3KT+jc9jAPrw5nyMNYJcqEsEP3UntdEvjpfkRI/M3rBgQ2gHbakPqFxirwml4Y/HN28QMNrsAtQDxKVA3rwc00MDoD3RsmEGT7RpbZWMOTMhbBN/Tzjc4jisdtRDNl/4N1hHEyCGWHZm1Ej+HA1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9BE516F8;
	Fri, 11 Jul 2025 11:37:12 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 693E43F694;
	Fri, 11 Jul 2025 11:37:20 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Ben Horgan <ben.horgan@arm.com>,
	Rohit Mathew <rohit.mathew@arm.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Zeng Heng <zengheng4@huawei.com>,
	Lecopzer Chen <lecopzerc@nvidia.com>,
	Carl Worth <carl@os.amperecomputing.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	James Morse <james.morse@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: [RFC PATCH 06/36] ACPI / PPTT: Stop acpi_count_levels() expecting callers to clear levels
Date: Fri, 11 Jul 2025 18:36:18 +0000
Message-Id: <20250711183648.30766-7-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250711183648.30766-1-james.morse@arm.com>
References: <20250711183648.30766-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_count_levels() passes the number of levels back via a pointer argument.
It also passes this to acpi_find_cache_level() as the starting_level, and
preserves this value as it walks up the cpu_node tree counting the levels.

The only caller acpi_get_cache_info() happens to have already initialised
levels to zero, which acpi_count_levels() depends on to get the correct
result.

Explicitly zero the levels variable, so the count always starts at zero.
This saves any additional callers having to work out they need to do this.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/pptt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 13619b1b821b..13ca2eee3b98 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -183,7 +183,7 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
  * @cpu_node: processor node we wish to count caches for
  * @levels: Number of levels if success.
  * @split_levels:	Number of split cache levels (data/instruction) if
- *			success. Can by NULL.
+ *			success. Can be NULL.
  *
  * Given a processor node containing a processing unit, walk into it and count
  * how many levels exist solely for it, and then walk up each level until we hit
@@ -196,6 +196,8 @@ static void acpi_count_levels(struct acpi_table_header *table_hdr,
 			      struct acpi_pptt_processor *cpu_node,
 			      unsigned int *levels, unsigned int *split_levels)
 {
+	*levels = 0;
+
 	do {
 		acpi_find_cache_level(table_hdr, cpu_node, levels, split_levels, 0, 0);
 		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
-- 
2.39.5


