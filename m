Return-Path: <linux-kernel+bounces-867514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3371FC02D19
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6FA73515E2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B24734C134;
	Thu, 23 Oct 2025 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="JtPkudUd"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B14734B434
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242371; cv=none; b=JZim0CZ0wzviTSWqzBvZxhdZHPeMZ+r0zumx5+c3D7VsADXtO0RikyZHLSiAXIZ14v3pd6Ce8XgUjHjZVy5yo61+DAkfkE1iQd3BumO4BQuw2jy+qSrmFAd1ruJPoIKxOp/F+kiN7iWc/POuQP84yjGijrphptJI6kwq30S4V8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242371; c=relaxed/simple;
	bh=49BNiaivaAVSLxOrAbQ3jcqUXbd5xtLUlvJhC8tkIpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUJFPraLJ+xySjTVMn0ZmUZStzMryKMTq3XifTgdaqPhHoGwBdoV/RBBIxMpcv4TyoqT04v2L691jgEyXxm4GRU/x2wbIOMxAul3o5Y+kAGr0kmQQIU3M820YKFmALhS9IxxslSEZwETlMULWsGJrV2zbocGBJIRarrwbhp6g/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=JtPkudUd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29292eca5dbso15518505ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761242369; x=1761847169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSMHyHNn/1vbJ7NUSylLHrrY4cYCxvOBtERxkVz+doQ=;
        b=JtPkudUdS1MxyqXFvjYkjymugAGweAQJKfYjlAeMnXYF0rnJHtyRBCamEkaBfUaECK
         SkReFy7tQbOHSNsDzw20dAbXwlchIt7pjrZ5Ku8h/npSmsFbbA8YaZptWYsNpRURqhQ8
         sPZYzr+H28CAgpZYr8jsnfO8J1hlTnLzC7M9D3Lz8SfPWCCA+UuD8qF7CeO7Apxy53X+
         yMHm1hy4IegkvdNj8N4zDXq9uT4zjKnH9DmKS+BAPH33Ng3jbAz/EOmRonozeE69X80d
         DatUfZiYUMDuhg8USkrvSO9o/UvtJI7ZLn3LIOX4Iq8jr/D4QHUpViyMG+rjMc3f38Z4
         iB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242369; x=1761847169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSMHyHNn/1vbJ7NUSylLHrrY4cYCxvOBtERxkVz+doQ=;
        b=thHsllW4GX3Tizf1ymTA+6XH71Rk7SjLhKuSm620qp9QA/wRDZvuGg5vVax7nKXDP+
         bHOW5wtTFyD8TV5z7/zefl53SalgTLvVKBrxpS0iubeKs2SEdhPqIDAhgyIHn5jddHOR
         cD9JYdsCOk8Q/k6GFrP5xwCtfVJ9ipj3Mmg2qUZuz9MofQgN4bPYxsCos6ocwtFKN9lE
         CXx1AR2pG1g/sgsfcFC8csqp6WfVRY1ap55BU1bE7oS9D2KsYlsnNF8C0trL0A0FHqGM
         1uDokm2/arvX6VsgQpx7EgzcmY33eZKkZIknxjnBp0tKB2AoQXpAc1mPhvKTywL8Saer
         oaOw==
X-Forwarded-Encrypted: i=1; AJvYcCX/f0WdGk/bU+j6/w0lAzeuWj+Q916Fm8YEOQyL73Eo+cAFoQwoMQgu5ougHBzylHXGbGyQPiSwmAywuiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjY0HyQ19hUwa5UBTLD3/GohiAg4yAQpkXfNAA7C1JvCd+fN9t
	qWJe99MOfAMc1T6sD0HQA794gqumewJ6ypM7JhaiwH10M/J3f4ypBvDomZMsDQeF07s=
X-Gm-Gg: ASbGncsvYyJpsQDjWVoVP+qKuSOLhA/S+sohH3tniKoDZhzvGY172eRe0LfkxYgVbkX
	9FOE1Sa6cS5vt12VxNociAyrGSGoyzdYdbbp13UmbxexBGRmLWvgyL7G8uGmc4VGyRWGEsSIP8F
	XkfxU1D4q6o23sa5P2+cKgwsup4vDl2La04WfdQBMV6I7ePs3nXKPgpLeHJhxAokVz59p2lUmP/
	jTBe2HcuzO+7YSd16LZWQnrmK0Sqm6o5LuaZXnw6osT6aLwM095S64I6ATJLHfNBxBsOjWj5CTM
	2RmyS8pmQBePgF62XYrDu30Ui52HXhsWWxMCp9srTZ/umZ00Lcq7cYkzaZA4bDCNRNZ8FTGQowG
	J6iU6YMN6jtqGxz5+l9adpdSoU/l/Mxi62RSvBgA1dOSHs3qQw1IVOv/09Zf3IHEGJvW23VHWMy
	fAOftVomTQZD6xK4gNBgQffD34vfmhLqfv7Q==
X-Google-Smtp-Source: AGHT+IG5ODtZ8NpgnPdL8N4UrnSSIWOWkDsOvPyVBDaaByRktns1SQuJqvUf+UP737qEBLe07B5fFg==
X-Received: by 2002:a17:903:440c:b0:264:8a8d:92dd with SMTP id d9443c01a7336-290c9cb8b95mr329120295ad.20.1761242367696;
        Thu, 23 Oct 2025 10:59:27 -0700 (PDT)
Received: from zoltan.localdomain ([208.115.86.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d1265sm6447431a91.3.2025.10.23.10.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:59:27 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] dt-bindings: spi: fsl-qspi: add optional resets
Date: Thu, 23 Oct 2025 12:59:14 -0500
Message-ID: <20251023175922.528868-3-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023175922.528868-1-elder@riscstar.com>
References: <20251023175922.528868-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow two resets to be defined to support the SpacemiT K1 SoC QSPI IP.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - The "reset" property now only applies to spacemit,k1-qspi compatible

 .../devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
index 5e6aff1bc2ed3..edd3158a6f2e8 100644
--- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
@@ -55,6 +55,21 @@ properties:
       - const: qspi_en
       - const: qspi
 
+  resets:
+    items:
+      - description: SoC QSPI reset
+      - description: SoC QSPI bus reset
+
+if:
+  properties:
+    compatible:
+      not:
+        contains:
+          const: spacemit,k1-qspi
+then:
+  properties:
+    resets: false
+
 required:
   - compatible
   - reg
-- 
2.43.0


