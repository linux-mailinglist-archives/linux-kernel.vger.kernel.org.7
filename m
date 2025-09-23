Return-Path: <linux-kernel+bounces-829460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93991B97201
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C9419C8421
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433862DEA9E;
	Tue, 23 Sep 2025 17:50:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B2C2DEA95
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649817; cv=none; b=VLbA2mE3yoH38BWOcudhexvMRpHsducsL3UJ9qUkCBY8pww1gXa0Ny9xUTBF1F7fjcgDxOBt7k8SSyoa2QxMwytCxr58oslZvFyvyInZow5nrJYWE9h7LSAts8QoAWkH3UpOaJ1ehUNIc7kfRJAft+MdNw30gB0JigTPS1v8AHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649817; c=relaxed/simple;
	bh=odqMRWq0AVxn5mGgrhTcGJSh/oeRfsrm+r1/SiGdrSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuyRT2A9nZ3tQNm7OPFSRu41m5jy9cqqDGSJvxcSvRb5MQGaYq44/rfG3YD6b0AKEuX0pUPKPQMIHgFcRmG8pC+zty6W/RCV0jrVXz5pp4/ROByoqzpSW8Zi7utHg8/DbeG4yLG+EPtj6qFKuO5OoAGTWkHFh3gSHTx5I+Xd99U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E640497;
	Tue, 23 Sep 2025 10:50:07 -0700 (PDT)
Received: from e137867.cambridge.arm.com (e137867.arm.com [10.1.30.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC8333F5A1;
	Tue, 23 Sep 2025 10:50:11 -0700 (PDT)
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ard Biesheuvel <ardb@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	kasan-dev@googlegroups.com,
	Mark Rutland <mark.rutland@arm.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>
Subject: [RFC PATCH 15/16] arm64/insn: always inline aarch64_insn_gen_load_acq_store_rel()
Date: Tue, 23 Sep 2025 18:49:02 +0100
Message-ID: <20250923174903.76283-16-ada.coupriediaz@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923174903.76283-1-ada.coupriediaz@arm.com>
References: <20250923174903.76283-1-ada.coupriediaz@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As it is always called with an explicit instruction type, we can
check for its validity at compile time and remove the runtime error print.

This makes `aarch64_insn_gen_load_acq_store_rel()` safe for inlining
and usage from patching callbacks, as both
`aarch64_insn_encode_ldst_size()` and `aarch64_insn_encode_register()`
have been made safe in previous commits.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/include/asm/insn.h | 36 +++++++++++++++++++++++++++++++----
 arch/arm64/lib/insn.c         | 29 ----------------------------
 2 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 46d4d452e2e2..b7abc9b3e74c 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -882,10 +882,38 @@ u32 aarch64_insn_gen_load_store_pair(enum aarch64_insn_register reg1,
 				     int offset,
 				     enum aarch64_insn_variant variant,
 				     enum aarch64_insn_ldst_type type);
-u32 aarch64_insn_gen_load_acq_store_rel(enum aarch64_insn_register reg,
-					enum aarch64_insn_register base,
-					enum aarch64_insn_size_type size,
-					enum aarch64_insn_ldst_type type);
+
+static __always_inline u32 aarch64_insn_gen_load_acq_store_rel(
+					 enum aarch64_insn_register reg,
+					 enum aarch64_insn_register base,
+					 enum aarch64_insn_size_type size,
+					 enum aarch64_insn_ldst_type type)
+{
+	compiletime_assert(type == AARCH64_INSN_LDST_LOAD_ACQ ||
+					type == AARCH64_INSN_LDST_STORE_REL,
+		"unknown load-acquire/store-release encoding");
+	u32 insn;
+
+	switch (type) {
+	case AARCH64_INSN_LDST_LOAD_ACQ:
+		insn = aarch64_insn_get_load_acq_value();
+		break;
+	case AARCH64_INSN_LDST_STORE_REL:
+		insn = aarch64_insn_get_store_rel_value();
+		break;
+	default:
+		return AARCH64_BREAK_FAULT;
+	}
+
+	insn = aarch64_insn_encode_ldst_size(size, insn);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn,
+					    reg);
+
+	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn,
+					    base);
+}
+
 u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
 				   enum aarch64_insn_register base,
 				   enum aarch64_insn_register state,
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 63564d236235..6ee298f96d47 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -328,35 +328,6 @@ u32 aarch64_insn_gen_load_store_pair(enum aarch64_insn_register reg1,
 					     offset >> shift);
 }
 
-u32 aarch64_insn_gen_load_acq_store_rel(enum aarch64_insn_register reg,
-					enum aarch64_insn_register base,
-					enum aarch64_insn_size_type size,
-					enum aarch64_insn_ldst_type type)
-{
-	u32 insn;
-
-	switch (type) {
-	case AARCH64_INSN_LDST_LOAD_ACQ:
-		insn = aarch64_insn_get_load_acq_value();
-		break;
-	case AARCH64_INSN_LDST_STORE_REL:
-		insn = aarch64_insn_get_store_rel_value();
-		break;
-	default:
-		pr_err("%s: unknown load-acquire/store-release encoding %d\n",
-		       __func__, type);
-		return AARCH64_BREAK_FAULT;
-	}
-
-	insn = aarch64_insn_encode_ldst_size(size, insn);
-
-	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn,
-					    reg);
-
-	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn,
-					    base);
-}
-
 u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
 				   enum aarch64_insn_register base,
 				   enum aarch64_insn_register state,
-- 
2.43.0


