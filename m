Return-Path: <linux-kernel+bounces-877983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9377C1F7FF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1653319C7E0B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCA4351FB8;
	Thu, 30 Oct 2025 10:22:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097A9350D75
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819774; cv=none; b=b9Bt7twTstjXTBG5e/hegFWp4TNnhoIq68ieUabsrCyAelfBR4S82IErzcnESDMiu4s57DjBOb2f39iYSF8dKhDTjZiAnum+3IRmI0tbzmmNDMdgK6Oq7Tdg6XFZT5gji2RcGYHDyXhlzx5GtYseyke1fW3j23cmS82PWx+JEbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819774; c=relaxed/simple;
	bh=uylQ8N0Tj3MThIcXCRxuc9igscliSHHERr3Sag3b2eI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibg2s6a/2ZrTPMvJJit71H7SVNX6BnnPSCMd26L+or5ipp1HiHSj7K15S2rz6N6oW5S8iG3vRzcT0PN4Wf5K8K3696VAGO1xTFxDccBdkXyGvXolN7FdET1ylWddJJ0q+sZPPFWAHDTMgv+M8NZhqvtTzYk5kTU1a6j6om4VVEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFC0E2ECB;
	Thu, 30 Oct 2025 03:22:44 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 711D23F66E;
	Thu, 30 Oct 2025 03:22:50 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	perlarsen@google.com,
	ayrton@google.com,
	ben.horgan@arm.com,
	sudeep.holla@arm.com,
	stuart.yoder@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v2 1/2] KVM: arm64: fix FF-A call failure when ff-a driver is built-in
Date: Thu, 30 Oct 2025 10:22:44 +0000
Message-Id: <20251030102245.2313898-2-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030102245.2313898-1-yeoreum.yun@arm.com>
References: <20251030102245.2313898-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Until has_version_negotiated is set to true,
all FF-A function calls fail except FFA_VERSION.
The has_version_negotiated flag is set to true when
the first FFA_VERSION call is made after init_hyp_mode().

This works fine when the FF-A driver is built as a module,
since ffa_init() is invoked after kvm_arm_init(), allowing do_ffa_version()
to set has_version_negotiated to true.

However, when the FF-A driver is built-in (CONFIG_ARM_FFA_TRANSPORT=y),
all FF-A calls fail. This happens because ffa_init() runs before
kvm_arm_init() — the init level of ffa_init() is rootfs_initcall.
As a result, the hypervisor cannot set has_version_negotiated,
since the FFA_VERSION call made in ffa_init() does not trap to the hypervisor
(HCR_EL2.TSC is cleared before kvm_arm_init()).

Consequently, this causes failures when using EFI variable services
with secure partitions that rely on FFA_SEND_DIRECT_MSG.

To fix this, call hyp_ffa_post_init() and set has_version_negotiated
during hyp_ffa_init() when the FF-A driver is built-in (CONFIG_ARM_FFA_TRANSPORT=y).

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 4e16f9b96f63..0ae87ff61758 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -984,5 +984,17 @@ int hyp_ffa_init(void *pages)
 	};
 
 	version_lock = __HYP_SPIN_LOCK_UNLOCKED;
+
+	if (IS_BUILTIN(CONFIG_ARM_FFA_TRANSPORT)) {
+		hyp_spin_lock(&version_lock);
+		if (hyp_ffa_post_init()) {
+			hyp_spin_unlock(&version_lock);
+			return -EOPNOTSUPP;
+		}
+
+		smp_store_release(&has_version_negotiated, true);
+		hyp_spin_unlock(&version_lock);
+	}
+
 	return 0;
 }
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


