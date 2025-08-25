Return-Path: <linux-kernel+bounces-785617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE0DB34E92
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC17188A3D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0A22C0276;
	Mon, 25 Aug 2025 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2kkiMiW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A139B2BEC42;
	Mon, 25 Aug 2025 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756159149; cv=none; b=QJDW55rRWw/b+WUITRmEy14OBY56KTobWgsxOvYQKgSF2gzTIpCyWucETlpiMzKIQmMIO2Lmiq0S95emB+v5/qSr4yAjqCn1eMBxpFzeEmbsrOTDK1ZPLsWYJYIYaJ79Mj3oF0O1VL0fv65Y7sA/3ynsH1qFC/sDtVncrImw3cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756159149; c=relaxed/simple;
	bh=sgYvCew38YwKs1GKSigLyRNGrOZsc87VhyevOGB0a60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyKL+EYwPpZ/Dj/lbY+rAiyEqcmgHfYrGnMT9NOFWNsTDbCLSDAwqONEx8xo8lKbwFNMw0z9zpfkmYE2NvnRY4wxqAV/XYA68gfFoRdt5YJBqTmUF16Nxzn7y2aQcufsm53NnqD4DtSDFww+AMB979/8c5+AFgHBY0xVEfGRAms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2kkiMiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B886C116C6;
	Mon, 25 Aug 2025 21:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756159148;
	bh=sgYvCew38YwKs1GKSigLyRNGrOZsc87VhyevOGB0a60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C2kkiMiWXWac1P6Y0R1VHYYV+4MFCzPATKTaJoEoq/ZYXSZZ1P+NAXokZiXBx/eRT
	 Uu+qyHWXpS/Jmua7DM1a/raWwu2n9MqBEirPRL+/snGt/fAWMCGMyXxGJM8vwcKk3m
	 PhyNSUvluQaVzu6a4N48uybXAWxVYdmv+sCbJKytHjvwcDaf+oqc88JknNUjv2VH8l
	 WJKg9DuNhuHXbVUmxuO8ATpiUuIYPD5RK7ZTMoWlSalUOOEDvsRVpuyeVVZyJqpS+g
	 gDdJdFeMqDggYZ9eXTMHwoDB3jzEcQgu7N5QKPVfTWhiy/xAs+XqpHhDzsqrV9QUxf
	 C2FE2fi40AhXg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 03/11] tools headers: Sync linux/cfi_types.h with the kernel source
Date: Mon, 25 Aug 2025 14:58:55 -0700
Message-ID: <20250825215904.2594216-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
In-Reply-To: <20250825215904.2594216-1-namhyung@kernel.org>
References: <20250825215904.2594216-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in this cset:

  5ccaeedb489b41ce cfi: add C CFI type macro

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/linux/cfi_types.h include/linux/cfi_types.h

Please see tools/include/uapi/README for further details.

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/linux/cfi_types.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/include/linux/cfi_types.h b/tools/include/linux/cfi_types.h
index 6b87136757655c05..685f7181780f9233 100644
--- a/tools/include/linux/cfi_types.h
+++ b/tools/include/linux/cfi_types.h
@@ -41,5 +41,28 @@
 	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
 #endif
 
+#else /* __ASSEMBLY__ */
+
+#ifdef CONFIG_CFI_CLANG
+#define DEFINE_CFI_TYPE(name, func)						\
+	/*									\
+	 * Force a reference to the function so the compiler generates		\
+	 * __kcfi_typeid_<func>.						\
+	 */									\
+	__ADDRESSABLE(func);							\
+	/* u32 name __ro_after_init = __kcfi_typeid_<func> */			\
+	extern u32 name;							\
+	asm (									\
+	"	.pushsection	.data..ro_after_init,\"aw\",\%progbits	\n"	\
+	"	.type	" #name ",\%object				\n"	\
+	"	.globl	" #name "					\n"	\
+	"	.p2align	2, 0x0					\n"	\
+	#name ":							\n"	\
+	"	.4byte	__kcfi_typeid_" #func "				\n"	\
+	"	.size	" #name ", 4					\n"	\
+	"	.popsection						\n"	\
+	);
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif /* _LINUX_CFI_TYPES_H */
-- 
2.51.0.261.g7ce5a0a67e-goog


