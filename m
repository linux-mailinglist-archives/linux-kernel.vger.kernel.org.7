Return-Path: <linux-kernel+bounces-646324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE38BAB5B02
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 19:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43D14A18B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 17:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19BE2C10A1;
	Tue, 13 May 2025 17:17:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC182BFC63
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747156655; cv=none; b=X3hBX5QHxt8AQ6fCK1/cGBSX3mDD3sM2He9L9WNO1bv2Z9AVDz3F5wDRu9ezYC2ml1HWmdQvEtNj14zyXgeZugF6/NQGYK2I333UKjtQjBjrBfrAcMtWXTOyqkzxK36t+b4LqIUdYApTBlXFrgVHXVS2ihfDVQktI/87Jpsnq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747156655; c=relaxed/simple;
	bh=IusM1wNvVBiofs5oMHccA1cFrE6K4vqHXuJu7y9oYg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S1bXqLDVR+cobAnM1wXiJF+kg+1g+QEGFSWKcPfFISk4udWhZPVxPPl1HI3dEQfhTlQWSdlHxcVDj7WdI8/dDpmk2cH5E6BpJm1s4U1wZrl3I6jSmmTSn7u7wAmXngo2IyxZUIwVV7GcVy8wpNrxYGflLGNU05mFItWrvPxBYGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 290CF2BC3;
	Tue, 13 May 2025 10:17:22 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB27C3F63F;
	Tue, 13 May 2025 10:17:29 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
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
	Shanker Donthineni <sdonthineni@nvidia.com>,
	fenghuay@nvidia.com,
	Babu Moger <babu.moger@amd.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH v11 18/30] x86/resctrl: Fix types in resctrl_arch_mon_ctx_{alloc,free}() stubs
Date: Tue, 13 May 2025 17:15:35 +0000
Message-Id: <20250513171547.15194-19-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250513171547.15194-1-james.morse@arm.com>
References: <20250513171547.15194-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

resctrl_arch_mon_ctx_alloc() and resctrl_arch_mon_ctx_free() take an enum
resctrl_event_id that is already defined in resctrl_types.h to be
accessible to asm/resctrl.h.

The x86 stubs take an int. Fix that.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since v10:
 * Removed a stray semicolon in the commit message.

Changes since v9:
 * Removed two stray semicolons.
 * Reworded the commit message.

Changes since v8:
 * This patch is new.
---
 arch/x86/include/asm/resctrl.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 7a39728b0743..a2e20fe90a2c 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -194,14 +194,16 @@ static inline u32 resctrl_arch_rmid_idx_encode(u32 ignored, u32 rmid)
 
 /* x86 can always read an rmid, nothing needs allocating */
 struct rdt_resource;
-static inline void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r, int evtid)
+static inline void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r,
+					       enum resctrl_event_id evtid)
 {
 	might_sleep();
 	return NULL;
-};
+}
 
-static inline void resctrl_arch_mon_ctx_free(struct rdt_resource *r, int evtid,
-					     void *ctx) { };
+static inline void resctrl_arch_mon_ctx_free(struct rdt_resource *r,
+					     enum resctrl_event_id evtid,
+					     void *ctx) { }
 
 u64 resctrl_arch_get_prefetch_disable_bits(void);
 int resctrl_arch_pseudo_lock_fn(void *_plr);
-- 
2.39.5


