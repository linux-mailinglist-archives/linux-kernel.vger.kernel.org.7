Return-Path: <linux-kernel+bounces-881718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0F8C28CD3
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 10:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E62084E401A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 09:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F813274B2A;
	Sun,  2 Nov 2025 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax8l2UFJ"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089A271A94
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762077006; cv=none; b=DO2giuOZPOggtv193PrODKl+mVzoitDcQ33Z2Z7q2nDatH/MkGFVmq2x1V/1MnYR1kN6YQ8aI7a1hVqDAEFNXAPw6+9Lsa3mjjt1TLQDl2/kcLz7tCUGrCMApwaMP8DEdKZFsM9Ho0CCPfR70sQpn8yJWA7SvvMWx5zJNtTNmF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762077006; c=relaxed/simple;
	bh=gv2QVhcMmEMjQ2DKMNqWKgsW+lI0oArue4IoB/hcybY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSM3qxddCCfniM7GTNFaq5W8ZtwaXWXxCIOQ7qRs+tuRhhfSGz7zcq3U0UevojA0fvYubUm7KeiI7lBc9o4cItV2F7G8vGjFXrlHg8JmwtiUdgJxTJ2DWbLh6hvdfYU12wesniYI+BptvfdNfcJcqHPFLLxhhAmnsXFDQkaKioY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ax8l2UFJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so230009b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 01:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762077004; x=1762681804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfBGkCpdCJbbx8ptfVRSSTZ4TOwzXcv5IKpsCTLcAdg=;
        b=ax8l2UFJvrgYhg7U7SAAPIRWqyLebUTDcWlCKDwRe21hlxZoL4QQz1hlnu6b6skgnN
         PXqgLl7j+XWkq3Rp5H7hO05phzXB1+gyeVXbBA6yJQSghKNp2hpaMIR8MaWVxGUwD4mP
         s6XnQunVlX02knSTIo++liojFqdcHBK1PJWVGAN1izu1FEdTvDYtkcYnRSVPgJeTmG9Z
         CAjW5wyf6TiJOfxPxDUstBYDeCIvJ3zqbx9IOye8iFyGAMf4ZVgotjacdX/5NSY0sMfK
         SkUhmE6lhg67Gip8egyHa8U/lElk4JXk5/fjcEM1piu8wFABrnb3Ok9eusCvm2g0pwTp
         rD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762077004; x=1762681804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfBGkCpdCJbbx8ptfVRSSTZ4TOwzXcv5IKpsCTLcAdg=;
        b=HjZGva+0OkQaYf+a+vtsdEyup5/rul+HGy0XU1ZA3pFmFqCAzlivvCy3VecV1VUjQD
         9RpmIvsr6PG3QEE3MuMPrnylh2n8uah8sgOcKjtvOMVnxWMBywyEOLOLVVd8SefQkqDM
         uuWd6usDiKuqNTVgRhJQfdRbLAM2hVKzVzQAfcP5eghu3HUBnKl+IKOK1OpoHc2lgY6J
         pGBzlkX6/MHYyuCAEB0u/qdDMYcXwCZAYOYbgBMuuT/8XFuB4X8mAyF8HGl8dB5WeVN5
         /FwQviX/X4/fWJHSeOzB8u/QDmuSu04UBhawg0nBmrpld51TjQLb9Fcz7hJ10Foc2NSs
         0zVA==
X-Forwarded-Encrypted: i=1; AJvYcCU/DgmIXL7NVArFX70mAXNZzY1YIjdssHk8IAPm0ATKzv8/f8NUD9pTgrR8iOzG2tlpoOBd7BcH/mTWvJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpicXeCfVgsYsaEZLg7vOvinPRv1IHA35pTaogLcDpOdOpDGXJ
	SPWy0pIU7jej5FczdVRnw7vL84WufZAmo8m2uIS3aG9FllUAKqFWU3Q4OZNRqQ==
X-Gm-Gg: ASbGncvOH4ZggBfpZBdODwdMJx62u0HzJEDLyf93QhQvvzx13UrDVpmjc2HkCsf+RtM
	j5T8c9PiP34Kj09AA2sjPEwz6IzzqgacmB1qm51iInvNbHOZHzXBNQ/LNDKAhZAj3C5VbznxlnC
	Ypo2U8PN/WUETRsWFR5GLObqCWMF3+rJrQVD60riS//QzsD1aRpsPmYzFiQ94Rao5qu4NBaMbvh
	5V+4mqo7A/WVIghg1ODZJcp9jg23vaVa3sgWw00E97xhmYXifwSv1feuhWiHjQRpPEKPfIk3IW+
	7oiq0Ubzs5m/7PwVL6B+hV8Mb7b1wR5BnI2yB/cxvBjuRrVJ2xmXCGbLlX4lAmEs1Yepj+H6A8v
	MItnRZTnNhsSK1K3VQw6+QCWUySkDL6Gqz7PH7O2lvsjgyntlbLEHZboIXO1cplx05+jALnSP60
	SHscRqfPVn8Vru9Q17ypkA2ghnwQiotnPLNEkHu9UPBTIAEiVs7x2Vgl2b
X-Google-Smtp-Source: AGHT+IEDhV7V1q+X2A4WeUCbo0ZHZo62KKRfx9fdau0q/StwiLJYD/4G+s6ryRCgEgHJrpTQR06FxQ==
X-Received: by 2002:a05:6a00:2d1d:b0:7aa:8397:7754 with SMTP id d2e1a72fcca58-7aa83978122mr1186234b3a.2.1762077004150;
        Sun, 02 Nov 2025 01:50:04 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7aa76782f1esm1243225b3a.67.2025.11.02.01.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:50:00 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id E59851123813; Sun,  2 Nov 2025 18:49:57 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 11/13] um: nommu: disable SMP on nommu UML
Date: Sun,  2 Nov 2025 18:49:36 +0900
Message-ID: <54839396f81bc2755728a53912bd8fcb19b889a1.1762075876.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762075876.git.thehajime@gmail.com>
References: <cover.1762075876.git.thehajime@gmail.com>
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
index c52fb5cb8d21..2bc18ecad783 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -13,7 +13,7 @@ config UML_X86
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select DCACHE_WORD_ACCESS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
-	select UML_SUBARCH_SUPPORTS_SMP if X86_CX8
+	select UML_SUBARCH_SUPPORTS_SMP if X86_CX8 && MMU
 
 config 64BIT
 	bool "64-bit kernel" if "$(SUBARCH)" = "x86"
-- 
2.43.0


