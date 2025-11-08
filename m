Return-Path: <linux-kernel+bounces-891389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6496C4292A
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 09:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C2513482D2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 08:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021682EAD1C;
	Sat,  8 Nov 2025 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oqvp9T0H"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6F72E9ECA
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589184; cv=none; b=uEuehD1LnVnUVDipDbVWuZtwEBSclsaBnuLBLMh7QYzLKQ4+5Klhzgd1tAFhH/Uy9Hq6rWQsfTb5RpyJjiHBOaCwtD/fDWfD0rpYNaluNagYFHyjEZxMcQb2DMx79KGSmqd3bXbwqVvtplMyprxNRQYBLb1CDhhx60mc/ljAFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589184; c=relaxed/simple;
	bh=pb+afI/6/X6X9fMm8RSxMg3KNjvn7Kd3MLf/HKmZNFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thkJzP70wzElzGB9O1LS/a0KdTrlXh8+70C3lYr6BwhAe403K3PjXp8l+xPx970COYt0+Ugw0mcujXxjXVewbam1rxa3U58h//arMvmc6OuzqAh3rOL5wRdJwErFvtTtry+swumXxWuia0dJV98JG1KtGQW5FRiNzYPqaxWWHAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oqvp9T0H; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7afd7789ccdso1458378b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 00:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589181; x=1763193981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uu/tPbxU9/ARLStujrsMBWUmhOTcbpkoe1nFm3w3B10=;
        b=Oqvp9T0HSi4Lx5lq1wOnUdKfO/ouZUnBjhsC/c2dHImhqu3wl8NXtFClbwszW76oOS
         vtGq1o/pQ0uQaVtVFl4ncrt7ePIqFuCw+ACmplOxEJ74seCta/udpTaZcpjg0VZWP8Lh
         lfyOkFEVQtuNitSA1Lkfhb7p/ExEM5MR3Cyi6aOtlgwdFUFMHF2Q0ObZWPxq6yoIHwH+
         Hp4RVhHT7gPd0W3hkEOQTMfzNHO1k+lrZloKv0+pVi1rAN3lVWdusfudDXERc/PEZUVt
         96Se8y0LqCxBhehIChd7NGUYim6QcuOQTmSsz4i7qMFBPlGIriGQDNbTILMjvd27B6mg
         fQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589181; x=1763193981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uu/tPbxU9/ARLStujrsMBWUmhOTcbpkoe1nFm3w3B10=;
        b=i4lgMZnlAL+/f3H0ebyLEhuxrZQxu6sllKrPFwbZtVJyW5WmLRJZHJRsHuNfmfReCT
         RW+kFsZTtDbMGTXNUXy3GWtc3v14baI6imofaBNkZADVnZGRCpPkbvAk/Fr80zEcXsOx
         QOkCWeT14TyXmeySHlfXSihijhGoOHY/irvpF9s6H9uYWm2sLMgiYkf4Fm2TNuzTGvkq
         rIS7zV2EUcTWu8oQevXePKRZDaoPKYOuxoWr8aK4ACiqvaBD87a2dwYv8oVRLoIWCMIA
         DgwdEsBEjJ4fSedK3k3RhaFAizGLbQ/TuPfPzatGS0oHHCNEgXMqTeMGSE1IXYvNmz0Z
         A9rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDN+ilYOIPdxFwGSgdsNvRnfW+af7VM8MF54tXBWgdrd0uau0Ta4LDGndcq7Xjp7izZ3/w3L4wrPXp92s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx3XAhjlyjO8ckTi/k6fabZJ0LG1/4On/gAysuquPJX/Z4eBdi
	l5Oh7TssAAmIsFiudw5tTfUOGc2lYZfNSQaSTlyUC1w99wYLCXnJK6ca
X-Gm-Gg: ASbGncuQ0/L29AZr0iPFX26JBBDNRnC2QV84s/0JOD3zKjhlNcgdhp8Ku0xUS0XOL9v
	mR8m2/tp2Wn69kfzchHO10uIP7Sij8RDRSqt36VcXXvM3D+5LS8nkJGAg8DUBvl3jBRiBibBpdj
	2wzm3Ww9y9s64rnVmvF7yHeNLXzA7XLRdikMX4Bz5AxD+i2op4geYHG+ev0OP7n4ToM5UBJKhyN
	frOhCNE3vumDW1AEEE+fp9VeeKjA5muq+jSIKCm/3tiydCAztJ1NqNeJoC9uJyRxba+I7wNdbp2
	/X7EfJEJR2VGTZ74XKHKi7wKhlpcLTxRB/dPRut3lRTdaOj65nUfy4+yAFek3BVj5Myd5d7u2qy
	t7e8pr6EHD6ypXR3cqBDduY4aGzowoVFvTBTnm53weGMRlNhlnQObl9bfgBKLtGM6R/ChFBXWb1
	OyY3VEwBrH+mxA/Qn5vbTud+qVQKdnjs3+wkLmeWnW2gCWjHIEualg9X69
X-Google-Smtp-Source: AGHT+IF7mUz86StpMhyTBEmSmjCP/Jl1AFr+f+bpRD/SCMI1b/IQXHVDAjmvzlL0XUw1PqOX/qeczw==
X-Received: by 2002:a05:6a00:2ea2:b0:7aa:2cc6:8c38 with SMTP id d2e1a72fcca58-7b225acbff2mr3066155b3a.2.1762589181042;
        Sat, 08 Nov 2025 00:06:21 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccc59eb6sm5189098b3a.67.2025.11.08.00.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:20 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 3163611388DB; Sat,  8 Nov 2025 17:06:19 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 11/13] um: nommu: disable SMP on nommu UML
Date: Sat,  8 Nov 2025 17:05:46 +0900
Message-ID: <a9d5519fe7696def8c00a1bba7b3c6c832d5dfba.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_SMP doesn't work with nommu UML since fs register handling of
host does conflict with thread local storage (more specifically,
the variable signals_enabled).

Thus this commit disables the CONFIG option and the TLS variables.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/os-Linux/internal.h | 8 ++++++++
 arch/x86/um/Kconfig         | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/internal.h b/arch/um/os-Linux/internal.h
index bac9fcc8c14c..25cb5cc931c1 100644
--- a/arch/um/os-Linux/internal.h
+++ b/arch/um/os-Linux/internal.h
@@ -6,6 +6,14 @@
 #include <stub-data.h>
 #include <signal.h>
 
+/* NOMMU doesn't work with thread-local storage used in CONFIG_SMP,
+ * due to the dependency on host_fs variable switch upon user/kernel
+ * context so, disable TLS until NOMMU supports SMP.
+ */
+#ifndef CONFIG_MMU
+#define __thread
+#endif
+
 /*
  * elf_aux.c
  */
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index bdd7c8e39b01..f12e2e4e0a12 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -12,7 +12,7 @@ config UML_X86
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select DCACHE_WORD_ACCESS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
-	select UML_SUBARCH_SUPPORTS_SMP if X86_CX8
+	select UML_SUBARCH_SUPPORTS_SMP if X86_CX8 && MMU
 
 config 64BIT
 	bool "64-bit kernel" if "$(SUBARCH)" = "x86"
-- 
2.43.0


