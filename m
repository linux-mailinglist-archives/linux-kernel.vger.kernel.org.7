Return-Path: <linux-kernel+bounces-646337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB17AB5B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 19:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1C31B42BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 17:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8778E2C2FB1;
	Tue, 13 May 2025 17:18:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A5D2C2FA5
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747156701; cv=none; b=WJDXixTp+b15xmCqGnYUP1UIBbCuNck1jLi+gFIGF+P9dRz1tBpX/wMfDi+cq6ztzSRUxTJzM7PbUQ4B1HznfXk3nw5S7F9VOlchylVUUYioR7uhpuAqHpzHv+a4X0f9iepOAa+RG86BSg0rxGyBceliELoN1g/BW4NMMv2irfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747156701; c=relaxed/simple;
	bh=D+1dbxe88pe0IuA5+/nZTjIpSbyWaqVn84aTPN9m87M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jt18m7jTwKK9zSJGcQ+XTVcsTqXr0AR94lrQN7NEXtP/uTcXR3wOc3Z5GzKjGA4E95yC6n8d78UYn80RBliOL74cUa1heY1iRX1pBdgfRPed4ar1aHdk9jnZGxZVBA1/2SwQRdxq2FYF0PpljiOO7aIrIb77GqVI/AmDzIioVes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A8832C23;
	Tue, 13 May 2025 10:18:08 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 048B13F63F;
	Tue, 13 May 2025 10:18:15 -0700 (PDT)
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
	Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v11 30/30] MAINTAINERS: Add reviewers for fs/resctrl
Date: Tue, 13 May 2025 17:15:47 +0000
Message-Id: <20250513171547.15194-31-james.morse@arm.com>
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

resctrl has existed for quite a while as a filesystem interface private to
arch/x86. To allow other architectures to support the same user interface
for similar hardware features, it has been moved to /fs/.

Add those with a vested interest in the common code as reviewers.

Signed-off-by: James Morse <james.morse@arm.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Acked-by: Dave Martin <Dave.Martin@arm.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e54b9019e942..9584c0d493a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20363,6 +20363,8 @@ F:	tools/testing/selftests/net/rds/
 RDT - RESOURCE ALLOCATION
 M:	Tony Luck <tony.luck@intel.com>
 M:	Reinette Chatre <reinette.chatre@intel.com>
+R:	Dave Martin <Dave.Martin@arm.com>
+R:	James Morse <james.morse@arm.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/filesystems/resctrl.rst
-- 
2.39.5


