Return-Path: <linux-kernel+bounces-746950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3BFB12D94
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5C117DDB0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 02:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAADF155326;
	Sun, 27 Jul 2025 02:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRB4AipB"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D9D747F
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753583419; cv=none; b=fW7OKhdYR3eH7u5H9/53Hqxuf67vvlKYiUfOW7szt4W7ZlI3ElpLZuxJo9vVUNT0sC4fFyycTp8REWNqERCe2gCzXy6lfT6OnScjXCP6aA7yOFmg6b1bbPTzkNUmC1pq0x99I7ewJHZyfpGLff7Put8jkna+CgFheeK/akM/PaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753583419; c=relaxed/simple;
	bh=BbtLETgMS5qyUODBrsadCnpoXePLzxf1knvhykUQD8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3xGjFQEk5uC8kWx1sA0iO2yzYpO06kjTj6a+LejrLHco207ASzOHPKrS2jAWHQNV/stGCnrSHVw6/L9GvkW7vHUArTpzD77wTHxjEGDCKIQhJi6EqBse0O5PyBvmxqZtd+t1WKgYXgLJ4OXyDVPd8+zmXmvTVta7iqGZ3n/120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRB4AipB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23c8f179e1bso38787365ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 19:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753583416; x=1754188216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i7Z/CeL/3tzEd7gHOKjeEpVKVjkDPKtAcg1iayXirF4=;
        b=cRB4AipBVDMn/ay3XukMlNOzYkcKaJd+9dkOuoBbuOR3a0bRuEwXPkJf9+bmTj3i6W
         fspG73V5bL+NdIRO5poWrEipU7k2COAiPncjw6stWFG7tKmOQaMG/jOjupJjC6OvqY5l
         lXjBxHiFbalhQcbYO6RKh1wsiGQEfxYfaIkDwabZSLJNni7MddhAjSqQDVyQ8DAGxm8T
         t/7qP5e5errGnjOb4FagERoZcYgFHjz2k1c0HRL/JUs6ji4ESFsQl16MBZmXgWGS74tz
         AvHVkjfdVpUhSyeYjCIEBSdREMLo9isa6zuPjTcP1DuEe8o1yR5cjpIpYiyuPQAcYpND
         M23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753583416; x=1754188216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i7Z/CeL/3tzEd7gHOKjeEpVKVjkDPKtAcg1iayXirF4=;
        b=RyXRcegch4ctBbVmUpV8Ferm9vuhtoTpS3tQf5t44OEKdGHFr3NK9MFGoo2ZiXg/fT
         A3yto8C3FtVpD2E7+tKF+966FcgO15z+CDgMkNQutEPwTdg/svBgM0ROC4LdbyH1MFcP
         +5dReXFNp2Fk/l/g4gM8zvYysrq+AAYUTc1FvB0Cudt/Ku9Kw1yF2i/t33d2npTFDLK5
         DsmptDEvwdHmA5Zq59L0Nnb/6+/Tik1fQgtqdp/DryVnjyhokczoaA/O4r3RpdpeXqwm
         +orDiT2iWjJk7l+oY78F8gvSDCbEyJNbYbGDTCGB0RA1Lr4SXBUW1C9hywiTv76iRGh5
         kLoA==
X-Gm-Message-State: AOJu0YzbTqmrkK2zIF35pFI1ekF2NQLDMv3lpFzMuDOieNPOhDskpmZE
	BRvpDnmNwTp4xSTH+SgkstJGqVWZ+Co5DAv7NXuHim74ElhEVpYi7uiasJz05ncZ
X-Gm-Gg: ASbGncvKhMXu29L5ed3P7Hb8B0+5EoEdx6EWRia9Y3YRhLWqJBZhESCghZvkqRtWK48
	jfYJoRhkXPxNgdqxaPDA7tVPAeJsvXHig699S/qV5q/jaSX2JQbKAiPrRcDXTIAsRkp05fbMo8x
	TEURIByKxo3G8MZ/kSKIejhXUfZxNepci1dCP+vQE17xQ++S7Xt+mrZuXryhfMCGkuESp7ZHe1V
	mrl22RGUabfaD+ROh2DfMu4/RqQ6t+ypwJuUZatDH7L6hJNNzEwLELTeoh+s2AmSCTQMVzu6apI
	+XQTGO5fxb0SA+Qg1Z6ibGHLRTZiU7swo3s/eVcv17uFuHkFKKG7Pja3l4qkbzHTrWz8sQwkQXx
	BNA5nwaz27IIx3V7zap+aTBcZ2zhyMy04/2EJPsJ0ngh55Xd8u40DhPC5
X-Google-Smtp-Source: AGHT+IEeu1Qvz7XLkOmlYAhzz4xrraIH1DXGFBSvM0gmwyKzM6G5ACLyQQC+T3A4i2jUh9Ub7cRBDQ==
X-Received: by 2002:a17:902:f693:b0:234:c549:da10 with SMTP id d9443c01a7336-23fb31e312emr99690405ad.47.1753583415882;
        Sat, 26 Jul 2025 19:30:15 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30bcfbsm25836275ad.16.2025.07.26.19.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 19:30:15 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/cpufreq/qcom-cpufreq-nvmem.c: Fix typo 'defered' -> 'deferred'
Date: Sat, 26 Jul 2025 22:30:19 -0400
Message-ID: <20250727023019.82233-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 54f811710..5a711de3e 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -605,7 +605,7 @@ MODULE_DEVICE_TABLE(of, qcom_cpufreq_match_list);
 /*
  * Since the driver depends on smem and nvmem drivers, which may
  * return EPROBE_DEFER, all the real activity is done in the probe,
- * which may be defered as well. The init here is only registering
+ * which may be deferred as well. The init here is only registering
  * the driver and the platform device.
  */
 static int __init qcom_cpufreq_init(void)
-- 
2.50.1


