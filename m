Return-Path: <linux-kernel+bounces-638381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C725EAAE547
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 17:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C403BE677
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FC928B4FA;
	Wed,  7 May 2025 15:47:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FD028B7CC
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632830; cv=none; b=svTM2f/Fc+NcklvVq6/Bk/Ms77T1GsBztTC+Z2IYXzKCoK2py5Zw0HMlHmRvBbten82cRxcEOH8XoRCqS4EOwy8HwRoL6NDOtH/05dx7FzrLdsPWoatyFSbI1JJ8/LMJaDr74Ad6StUFL3RasXibk2Ze01W4mZS6/IXhRrEDfUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632830; c=relaxed/simple;
	bh=369bwvtiVylIIOkV/f/3osAZWZV4pzU5X5ry2ZDYtJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kGle4VX/vXxSp5fxXEaettjjQAhwFuQVb2uggb/ftI05JOMDeg8iIYYHhUmkd7WACZajTTvok6o3d7MS58cL1ArZ0HmFHkgHuIe62KUdAypWHQV+BDldFG0OpKWKFeNgw04BNuO9ceEKruxSR+VOPBcFsZJ2WkZl1sPanAPIprQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E24DB202C;
	Wed,  7 May 2025 08:46:57 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5C9653F58B;
	Wed,  7 May 2025 08:47:04 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	pcc@google.com,
	will@kernel.org,
	broonie@kernel.org,
	anshuman.khandual@arm.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	frederic@kernel.org,
	james.morse@arm.com,
	hardevsinh.palaniya@siliconsignals.io,
	huangxiaojia2@huawei.com,
	mark.rutland@arm.com,
	samuel.holland@sifive.com,
	palmer@rivosinc.com,
	charlie@rivosinc.com,
	thiago.bauermann@linaro.org,
	bgray@linux.ibm.com,
	tglx@linutronix.de,
	puranjay@kernel.org,
	david@redhat.com,
	yang@os.amperecomputing.com,
	mbenes@suse.cz,
	joel.granados@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v4 2/7] prtcl: introduce PR_MTE_STORE_ONLY
Date: Wed,  7 May 2025 16:46:49 +0100
Message-Id: <20250507154654.1937588-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507154654.1937588-1-yeoreum.yun@arm.com>
References: <20250507154654.1937588-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PR_MTE_STORE_ONLY is used to restrict the MTE tag check for store
opeartion only.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 include/uapi/linux/prctl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 15c18ef4eb11..83ac566251d8 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -244,6 +244,8 @@ struct prctl_mm_map {
 # define PR_MTE_TAG_MASK		(0xffffUL << PR_MTE_TAG_SHIFT)
 /* Unused; kept only for source compatibility */
 # define PR_MTE_TCF_SHIFT		1
+/* MTE tag check store only */
+# define PR_MTE_STORE_ONLY		(1UL << 19)
 /* RISC-V pointer masking tag length */
 # define PR_PMLEN_SHIFT			24
 # define PR_PMLEN_MASK			(0x7fUL << PR_PMLEN_SHIFT)
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


