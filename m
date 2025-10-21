Return-Path: <linux-kernel+bounces-863520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EA0BF809D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062AC18A5EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEA834F260;
	Tue, 21 Oct 2025 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XECirQQ9"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33B4221FDA
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071104; cv=none; b=SzA2NGBQvi5kA6Un5jZ6NnQoiXVsIKHmqj02YZpJwMY+RttXNFLbbfCTgX85qrvIqfYrNzPHke7tJVE87XkD8yvwKSdD5ZoY6OmA2owqJOskEjhUDZYfI2SEar01svprUwd7NPunLO+QbvRSN5/xrbV1YfByA7IM2jEH+94zYYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071104; c=relaxed/simple;
	bh=uGGtj65PbTrlbw+uhHSVW++NmhcnRg1oiufGnyI2qRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LW46mptzCMk/Ba3KpImL0YOpLmmk7TgCV2eIoqbfzoqdUZya56BpGE3SPcYZtfQuTI8TwL39NFaZZE12DC303pby4VPHWRWxOdMKubBfvWqD3R3CwygAfMiNf8DNbt5P91yYXXSnKLF7lPowYxqOeEFkBfd8+FIiISSVTUvRGO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XECirQQ9; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-93e7ff97d9fso438788239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761071102; x=1761675902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/hRaAHyijOpufUPv49cvX1ntk/2yuvuUY4aCKFAmWd0=;
        b=XECirQQ9heFZSgIbAb5HKk+eGkgpyrS6R7icQrRPvXjL58B/mUFT44sAfleJoxPBQt
         Z5IykCrkSQqUSar5YdJrTQ28GuoTS+o65wo5Ah2nNe+5DkTimbumcyyf+0kK4bdgDXJq
         l51edLFl/JENV3FPvclCgcvxvxzOpokiw0vzYKX/YHwwTxUSKFTyZj7A6Itg6R7Wa4L2
         X0z1FHNm6MXPo9+ScnJt/VP9VxP+WwMeWt/UWrTknJ4VMJR1OoHZruOiZWkDTnZ3EUNw
         WFlCEBlAHKsbtRWBcxezKjGa9LHYNjOVGixmsT0KoHJZkpnZAdXYlAko0iRyxmBj5gpn
         Ag8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071102; x=1761675902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hRaAHyijOpufUPv49cvX1ntk/2yuvuUY4aCKFAmWd0=;
        b=T2gbeoLHMJW8pfsbg4L8mYuGExRsB0H4eJQ2J9BGIzvxWca0LM18XDpqjngiY2s3uO
         SAb7DkISpaNvNkTVJevEAFe5OtcQI2eK+3OTQlg/kyp0Du0btRuJOm6iO1lwuEFcfG+L
         H0zOVEpk7hSC2RlK9jAtfkFY/ZOzXTk97dGksv9l6FCaAk4SC8jS+lAIwc4i7PKa1f49
         F4paplAQT7+k+6YYDWqzUJ41M6xEGE2jTI0myJSFUUcfMWy9PwBAXJtjUOt+eTkFVTXQ
         qG27PH9me9iwXYnxYLb3FeBV1gVABgCAi+GP9TSuoVEzU4ighKJWvw/7+IHy1mcqJwsr
         uXaw==
X-Forwarded-Encrypted: i=1; AJvYcCUtrG7v9OVtT7JNrtyz/S6/VFkL4ziJyPC58g/C+wB+RFM4CRdn9mBDSdYKCGEZUSxwGAcG/FjtnXlIdJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPnxg6TqA0f3+zoMueST+D0egDizYGmETKMymvANpaxQ6tbjzR
	mG3Lj7AbFzmwrJXYpz65Zmt/Jo0i7pL3HUuH294FDsnkdf4OMuliNix2
X-Gm-Gg: ASbGncuXnetv5y1QFKB5xCFDfx5l8GDB8wGIDTZ1M4Ke/Frr5eqRMxDCIQ0eQHOUJ54
	8MRQH3Fk7ZaGwXLtmJ2Ks5Mg2VzQKtoEbvSh0J5Sv8vhvwytfZeDfaChtC8DzW7arM5s0QOmDD8
	zcO1Uyk8UmRa2dtIp7T+Qx7Nd0qA2DzOo5O9ZixPXMDCb+q+dBTMMel2QXQHpvzANl43a2SHMlY
	cGf3HE1MTnpFHmGhrYfdhZgBkAMm9SqIk1m5nsadsOv3fJo7REmKNLI8ekuWUUZpqUmKkWvQfXt
	VmsP++zdm3bk4zFEjlMfr4A9eDjstKgpEgNsHCKndFiwfOCpezjY1Ho3UQ7zUbA58TGGDcNDdti
	7FGsjXTjhOZ67yiYFQFpekNzq8gMUcFsJKTzodbuFkgqxQSjo/ZbvfoMca7vRhHWBgLRFAn0Key
	OqZjO5/R0/YMzV/c65KN2B5A==
X-Google-Smtp-Source: AGHT+IEjqZ6+79HpV6r/CD1o/Z4Q+UBJIDYVMWQbNCZ5pOHYsJukoWPbU6x5ZEpq+HAyIA6z7ev07w==
X-Received: by 2002:a05:6e02:1a66:b0:425:951f:52fa with SMTP id e9e14a558f8ab-430c5275304mr291734935ab.14.1761071101704;
        Tue, 21 Oct 2025 11:25:01 -0700 (PDT)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07c9ef0sm45644795ab.35.2025.10.21.11.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:25:00 -0700 (PDT)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: Jonathan Lemon <jonathan.lemon@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] ptp: ocp: Fix typo using index 1 instead of i in SMA initialization loop
Date: Tue, 21 Oct 2025 18:24:56 +0000
Message-Id: <20251021182456.9729-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ptp_ocp_sma_fb_init(), the code mistakenly used bp->sma[1]
instead of bp->sma[i] inside a for-loop, which caused only SMA[1]
to have its DIRECTION_CAN_CHANGE capability cleared. This led to
inconsistent capability flags across SMA pins.

Fixes: 09eeb3aecc6c ("ptp_ocp: implement DPLL ops")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 drivers/ptp/ptp_ocp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 794ec6e71990..a5c363252986 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2548,7 +2548,7 @@ ptp_ocp_sma_fb_init(struct ptp_ocp *bp)
 		for (i = 0; i < OCP_SMA_NUM; i++) {
 			bp->sma[i].fixed_fcn = true;
 			bp->sma[i].fixed_dir = true;
-			bp->sma[1].dpll_prop.capabilities &=
+			bp->sma[i].dpll_prop.capabilities &=
 				~DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE;
 		}
 		return;
-- 
2.25.1


