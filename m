Return-Path: <linux-kernel+bounces-830322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26861B9965B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3BCB3AC34A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B562DEA86;
	Wed, 24 Sep 2025 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PMaf4nmj"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8022B2DBF7C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709013; cv=none; b=IUofRjJzaj+3nKXsa8T8fU4TS1LU30+e6cTltefxH1wnBFlMr8oUMT7miefG1oB69PkTvKe3LBgJCnBfJNwrdHUECj7Y4MxoYA2uyJfyrHCpqmrq+NO8Lex+8WO8YwJ4E1csva39/KwyzaCsDc7uUs7H01I7FtfGKrIhYbH2VXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709013; c=relaxed/simple;
	bh=S9krJNAXbYfiBjHOowFzU/MHlCd/viA3rjI5GntmR2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTxxBjoCfGUxMKPIt22728wY2skPL+as1MElA8DArfuUzF8V64LzLWqoE5W/xpmmwlt2f3q/zUt/plj/cFC+RiR8OOwr4shhyn7lZX2DMn5bFheW4Xs3S+UfrqFE9G+VmqfOH2Mda3HBMXT+yqeQ/cBCBTPdnIFqPAWJHt33mU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=PMaf4nmj; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3164978f11so227271666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758709006; x=1759313806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rr4AHNLZpak0/qwDXluW3tBh9480ZbWvsfmpnJ8cepg=;
        b=PMaf4nmjtw7ODmDHrVU4cW9aHpwbBxRm+TIGSbQio0dAX8jPqG/k/AK5bja+3aSPsG
         pgsu8of+2dHLuLk55T0SRKpmLLDICByWcq1OAm7jCy0Amer9BxaK2/QT3+QZ3g4w7//g
         VfGEiM4ttsnzRhgIdw6H/S4jXQvdgTgxciDrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758709006; x=1759313806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rr4AHNLZpak0/qwDXluW3tBh9480ZbWvsfmpnJ8cepg=;
        b=Xh141468YoQgAP5DVmlpQb7RKTsSG6qOHvZGgr2KrNYSI5zn/n97bjL4DWMEXGpYwh
         s58hF6LIyWyTHTlX9vJHAl2cTRrgoLaQgzVwyixzTv7q/GvwG8j502b0KPRGrwzNWyu5
         amBoGJzvvfF91EE5xL/BMoehmSyucfh5VfAsRK9SzSfEZG5OUUtbiSCoxjYSzpjulkxz
         Y7TrmLQutASAG2pIrNaRZObYl2lW6CXjtZLuANBC2Bv//OcqPfRXdPy3GVjzKBlnuEed
         QAegLvJarrpe0OQQnwxIJJgSDZCH5uaip0rOI/EYTZ4g5w4+auWGv3o7p4dTA5OMSQea
         W8Sw==
X-Gm-Message-State: AOJu0YysbZbhxhPZ7f88oVTFSoQnWXHr/jXUU1DWAoJSGFkIeQ5YK+tv
	+iLHMoNJpk1Alsforb1cBW2rqLpVuBr+Xt/rmcSbx6tnx7R2mirDiTJ/02xgEC2duyFoenv0P8y
	swC6R
X-Gm-Gg: ASbGncukYsrjkyrI4OusiIkL39k9lXJ8zQj0qqeWtkjQFi827pVm/J2WmLcCYzb4svU
	LKo5dDBXXTgfsUAf7dRBV2C6trc8H5mwaiPIiSIrH1ExgG6wVa8Eu/tWf7SXCEPANg4cb0Xr8G5
	pGXME7MMgnrBEw41Akrwj3gSdkjL74rYQEUwIV/60wvtS8McKLUk2eVbJcg/f9oVRxndDv28uGC
	djoGtlK3qxCQndFyfmwhAehfGcRJPaNHV8oCnYZFAiZZcUbYIr1swiiD+0P4FQwtHcOb4vFZ+0d
	z/Q0aPPlHJsZZzgAeOuqg472ph4Ep8Wq2X4RXWCfIayEKkidedTcm72V8iZMA65PRiDNu3dDoH+
	hAiB4ChIHVp0MBcMCVvME7zp6O5VX3nogcxy21t1L4Xwq7Z1K844c9bST/tu4YmYm9iU3/ZayRu
	ZcNhi5MUDjVpB+y+dBVJlUlKQ8WduSHi/EvLuakjOVd7/gafEwXei+uHEk9R8=
X-Google-Smtp-Source: AGHT+IE7L5itM2VG+Ck3uzCsPeP/CVsjTWyWIegSsTc3ax7OvaG0j081Z2YX1lAhE+xoVbkexzcJ/g==
X-Received: by 2002:a17:907:3f9d:b0:b2a:7f08:23d5 with SMTP id a640c23a62f3a-b302c2f813amr554123866b.63.1758709005631;
        Wed, 24 Sep 2025 03:16:45 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b28d206bd13sm949712766b.31.2025.09.24.03.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 03:16:45 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Eric Biggers <ebiggers@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] ARM: mxs_defconfig: enable sound drivers for imx28-amarula-rmm
Date: Wed, 24 Sep 2025 12:16:27 +0200
Message-ID: <20250924101640.2942635-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924101640.2942635-1-dario.binacchi@amarulasolutions.com>
References: <20250924101640.2942635-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable TLV320AIC3X I2C codec and simple-card support used on Amarula
rmm board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 arch/arm/configs/mxs_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 3b08c63b6de4..603fb003b223 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -100,6 +100,8 @@ CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_MXS_SOC=y
 CONFIG_SND_SOC_MXS_SGTL5000=y
+CONFIG_SND_SOC_TLV320AIC3X_I2C=y
+CONFIG_SND_SIMPLE_CARD=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_STORAGE=y
-- 
2.43.0

base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
branch: microgea-rmm-audio

