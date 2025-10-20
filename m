Return-Path: <linux-kernel+bounces-861360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47874BF286B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88E854E3F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F57330313;
	Mon, 20 Oct 2025 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="vPAvdVW2"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805A419F115
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979121; cv=none; b=ibGDTwOi5mSHYWZL2dNNicmLIn3JL8pmasH3SN9pJ5zPtnOV3D9gfqnw2/BehZad/6sxe6SIYh/Gnj6LI5T+LrJ0yAPzbcRlUpzLNqDKHCvbR8noI1m2nFSdEyMKE83vZmArHM34R/nqz6ZgKxZoSYcpRm/q8HfexEFrnc6OKdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979121; c=relaxed/simple;
	bh=J4RnlkPmRis+4sZTPl73tqOpMLz4XTH3ddn132lst7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5I/eSzsehVQzShj6jCxr1duj8Ox4nrZfHuZfyOJ96RmkaqZVtupmviokr3lZ9sATnMkUdbOMK0vg3aaBBWSIXatV5xR2y8aEu2R3W+F6QoWeCBcdi0CH6r29+adLvhejOvz+u1Al1h1gbOnDcINT1be19y8WUn3fm4t+7pgPgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=vPAvdVW2; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-940276d224dso211373239f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760979118; x=1761583918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuOxACCK+Imy4d0s9ApaTGaS6oXJ+8tFgrJY9fioEn0=;
        b=vPAvdVW2Aq9JKBgQQn5U/VBywZ4m8Acex6+JX/fjRcJJaOpU3lpjfyDQ7bBaE5C78P
         szpBB8M2ctfZjuo8n23fUVOs26/6WuHLoV8o02kPEX46Jn+VH7BAKf9PP1+8QT5sgSZs
         F1ASYRs7Rujbm6EUdaHFdftWev3KJkxMIGmJiInsHrWcyEVYEx1wuVTb4SxfVslsHKtB
         KrIKyQYH1RoERiQO3V/T8idechikUX9H6txIYF1b2oRuH30JFbmZ3PfspE/2pC1sKOBz
         zhauEgJttg2W/SY+erDONQXd5iUk8t5FLff+D41I+Le2tUwBN0+glcbU+U+uHeX5PrRC
         szcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979118; x=1761583918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuOxACCK+Imy4d0s9ApaTGaS6oXJ+8tFgrJY9fioEn0=;
        b=dxGI5BtClCDpg2bHwY01rCvw+FC3JxANYOKOk2vixiCU8LNhmv2LDA1lWeX5jhXyLX
         /l9ifMMZHCQN9RPP4lmFZgtvh12of7oSVsJiYLsJohXB2xE+83yvv8S9Uf0B0yLyV8DM
         GMPTHAUPHCKFocFaOr9kBsL6E5lLOCjc/uDZigC4yh8a0KsA6CFQSQDMvWjISGhv52hc
         3AxYvpbbywYtEufBW6Oi/aPT56l4Y0qGbcDyRSTEd4rjNCU64ZMNCN8N8y9sF/hH1qMJ
         pgdlKLGt1xYAkTOkmS3ziMSx8j7xIw7z6GuzvZ6qwqlg6uzY5aYtW/N2w39RE5xZm9YI
         BNyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUxqsJaFSVgvgc/ypECtEE9rhoUG6n5uFwPpIfXYELTVT0zTOB7n8sFqfbP8UI6oYzGxf9dHk7X/KsCxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0d2zb5ZXrwaaBonxGQfJ+u9L0PD5U8LVwXwAf8+t0c3qbgWD8
	eO1M0PedQ/UNeLoluMB8EoPEWA3z+w9vdc5pezo27cvnTGoG5gZP4J3c30HgtC19c7M=
X-Gm-Gg: ASbGncupTeSjR11v15q6Mzj3tkNXrJNffm8gncAfy6ZMNP+SSN+RzC0LQjVHd/7qQPZ
	yQYqDpSt53M6jx2Q3gHxGm/RNyP4mMvKVSwQQfhiP9cfT73f8a+pnNNI48ObC4+8MBf0uHMTnpB
	JPKMpyHibLDpTLXXJYKiGJuhmWGdWQYaONtTlo7HmRvWH2iSefSvPVHuzSpjFEfoDVnBVll0fCC
	nD+hhWjxRGiijsQmkvK2nIcQ2+nQUNAXPYvQm6MmeHLdQGWjKPuukPQJovXEeh62OCsOsjsJyOh
	ilpYMyXzXQMgIHd8iheNoS6G/gsltPyawwt6qm/5QjJCqC4PnKgFMlvFUrAARzeSGDa5DlwFxBg
	VP8kU2SbF8vztbHzNm6Sprl+3OxJsoFUm1d9FzkuvsSLL843++r7P06w4mR7+Qoe5SpvxwKYEkp
	HwI0ctwtPxYBDkf/OQEVyucn6HTg4Hx7+VLNeZe/SzzNI=
X-Google-Smtp-Source: AGHT+IEC4oh/Jnvhjv0NLxKRomMypLMZRmo/rR+Ffv9+T12KDSfiODwIv7xt26rVmqA6jr2VlWiOZw==
X-Received: by 2002:a05:6e02:152d:b0:42f:9dd5:3ebb with SMTP id e9e14a558f8ab-430c529a04bmr188317305ab.24.1760979118533;
        Mon, 20 Oct 2025 09:51:58 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9799428sm3116783173.63.2025.10.20.09.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:51:58 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] dt-bindings: spi: fsl-qspi: add optional resets
Date: Mon, 20 Oct 2025 11:51:44 -0500
Message-ID: <20251020165152.666221-2-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251020165152.666221-1-elder@riscstar.com>
References: <20251020165152.666221-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow two resets to be optionally included for the Freescale QSPI driver.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
index f2dd20370dbb3..0315a13fe319a 100644
--- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
@@ -54,6 +54,11 @@ properties:
       - const: qspi_en
       - const: qspi
 
+  resets:
+    items:
+      - description: SoC QSPI reset
+      - description: SoC QSPI bus reset
+
 required:
   - compatible
   - reg
-- 
2.48.1


