Return-Path: <linux-kernel+bounces-835883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0741FBA842F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DF877A78E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AD42BF3F4;
	Mon, 29 Sep 2025 07:37:27 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930DD2110E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759131446; cv=none; b=QHPCP/xrC5aMi75M+JcDmURHwgUu+w1wukc5rkG3Rw1vrW6auFtajuhxTL6PhsQ1VxFG4YmX5KmsV9rg9c3jOCaGVI+OSYbVY5/6t0Rjb5zwy+izuixiTpelu1HWknsXpWsHLMVcFLAn6iCW7goTf6tH3340eoQDuhukGBAQLAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759131446; c=relaxed/simple;
	bh=tEf2v0yWBV41CAxuZkm/e8KRs0l6+pyp0tk3XAe6S/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h/btkRggGxtuK/eUKlJ9+/eLF/Wb06DM4lAjI6roWDzONDhiF0cUOfNMgZ4Selm78p+jTj9/gGdzNwn+RRYUzdGqqgukjlZBPxtIDchiRcjTr7WYY3qtYXC6kXTZ5gUJiGzv57EfkNckMIpeISZRR2fA26nvK68rOX9lgOPI1JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1b6dd27c9d0711f08b9f7d2eb6caa7cf-20250929
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:d9d0e40c-edd5-46ee-95a6-f5c51855eb38,IP:15,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-50
X-CID-INFO: VERSION:1.1.45,REQID:d9d0e40c-edd5-46ee-95a6-f5c51855eb38,IP:15,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-50
X-CID-META: VersionHash:6493067,CLOUDID:cecb04c47009135223c07d0fb1735ae3,BulkI
	D:250929153710RZQSC2KQ,BulkQuantity:0,Recheck:0,SF:10|24|38|44|66|78|102|8
	50,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSI
X-UUID: 1b6dd27c9d0711f08b9f7d2eb6caa7cf-20250929
X-User: pengcan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1407328618; Mon, 29 Sep 2025 15:37:09 +0800
From: Can Peng <pengcan@kylinos.cn>
To: masahiroy@kernel.org,
	tglx@linutronix.de,
	kees@kernel.org,
	aliceryhl@google.com,
	ojeda@kernel.org,
	xur@google.com,
	jpoimboe@kernel.org,
	rppt@kernel.org,
	david.kaplan@amd.com
Cc: pengcan@kylinos.cn,
	ruanjinjie@huawei.com,
	namcao@linutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpu: Make CONFIG_CPU_MITIGATIONS user-configurable on non-x86 architectures
Date: Mon, 29 Sep 2025 15:36:42 +0800
Message-Id: <20250929073642.965938-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On non-x86 architectures, CONFIG_CPU_MITIGATIONS is currently controlled
indirectly via ARCH_CONFIGURES_CPU_MITIGATIONS, leaving no way for users
to disable mitigations at build time. This forces mitigations to be
enabled even in trusted or performance-critical environments where they
are unnecessary.

Introduce a user-visible Kconfig option for CONFIG_CPU_MITIGATIONS,
defaulting to 'y' for safety, but allowing it to be set to 'n' when
desired. This provides consistent configurability across all
architectures while preserving the default secure behavior.

Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 arch/Kconfig | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index d1b4ffd6e085..b0ef0cc412eb 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -14,7 +14,18 @@ config ARCH_CONFIGURES_CPU_MITIGATIONS
 
 if !ARCH_CONFIGURES_CPU_MITIGATIONS
 config CPU_MITIGATIONS
-	def_bool y
+	bool "Mitigations for CPU vulnerabilities"
+	default y
+	help
+	  Say Y here to enable options which enable mitigations for hardware
+	  vulnerabilities (usually related to speculative execution).
+	  Mitigations can be disabled or restricted to SMT systems at runtime
+	  via the "mitigations" kernel parameter.
+
+	  If you say N, all mitigations will be disabled.  This CANNOT be
+	  overridden at runtime.
+
+	  Say 'Y', unless you really know what you are doing.
 endif
 
 #
-- 
2.25.1


