Return-Path: <linux-kernel+bounces-881796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DEEC28F02
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 13:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598EA3A9C9F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 12:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A054526CE25;
	Sun,  2 Nov 2025 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESaAA0rg"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8848E212B3D
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762085691; cv=none; b=LjvJGmO40qqFfuIuM4GtlBwuQAB7dJy0hPsRXiudrTX83Usrgnvn/nQx3saCccSlNCJO8P7AiLybRyPDrEzfv/W6T8FRBwbuNGbSjwVPY+k9P1Ul7MIiKAErtLO/wSyaGVUgy8Xx0VlirZD6+t/OUf2rtMBN8vDq/zPJNcNWdzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762085691; c=relaxed/simple;
	bh=ol78MnOzYqCpj4xHNIm6pzXtOiTHuOLRRI/WA36G40k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQDZn0vd1wYH/cSFitmPDY0HJoE+ax2uySIFg+5mK2xAtOBX0rV2t7Ff3NHH8e2rKRniqh+OTGVLFGv8YM+doOaVgWzzrFNRZRo+GQeQlEvRJqVRQSjYlyfxg4PGIDV9xHuzRzCWeumdmgpZkUXDU+8ckg2D5PMO+41iGAP4c04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESaAA0rg; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57bd04f2e84so4413411e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 04:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762085687; x=1762690487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HiQTcCjrBICpDprDtneCouSMSht13r31Nvj19QRNpDY=;
        b=ESaAA0rg2txD7YNOQtfZNOC1z79clHb6OcZQFsDj25T9+SC0Kb4Rtdap1QEg1OOkCj
         bljHYnCs4c3Z1RFmOW3ForuYbADs+n9MfnUhc24cOUNTA3q1o7xwaiobSawX+/AamruR
         OaCA2ItRbDLq4MfvLFMdCvBu2Z9DPLAxFWJphunv97+7bxjxaoSomKaNssaM84wE/qpj
         rSy9P+ytvFIos5jrYEB0bDc2V+NwXSFb1W0VwA4wcOZQYPhtPOmtjknS1sbPsxNHPGog
         xTaWRX8W84bYqJXfV+u3MUvvcASb8enCzwyD+Quey+fX1PJqTZZ6+eE37n/wfHFRVmXr
         BWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762085687; x=1762690487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HiQTcCjrBICpDprDtneCouSMSht13r31Nvj19QRNpDY=;
        b=REBlqULoz5IhrJ+lYvCvLQiXUiu0O/mSTox9ijUxXl6IDQ2JKH1HbA70yUIrZSbjcB
         uRXajeTFCmoDQBubE4Xk1NeMmZQWgzh+kBt4QTYfz15aSxe1RzxdYwVS1ihTQChbDa3k
         SkfZRf2xeS1LoCVfE7Yh0Qn9FTV0UAlmJo1sEJPlKylNt11NEQYs4IYAcoes1sWXhInL
         kiAz2GIPnWdDcFUshDYKjN9YqZpG721JY7sq4MU5vlurjkSBF70jLGYR6jfXGp/gVIVd
         n+wDOIMg9Zor0uErpAZTxG9EsyYVMtQzoGCBH5tbKigZ3wBxYoso2+r5UGbuIG2mSJMT
         aT+Q==
X-Gm-Message-State: AOJu0Yxh0LnH/ymvn3KZ3OysqcJfOQfxM3IhbwLOBa+pqa/6e/IIS2uM
	lsxb/Dkt+ongN6BGGG0h/QLSoliuILwLAOKvp2NMvXtGgB2GA1MLFZHBphReRPLL
X-Gm-Gg: ASbGncusYTiFSVewXjSTJVrLfTx0vaDKhBP7ajO15FbMTyBjbytLkbC77KY1ZwVJ8s2
	8S/lcSXirXVdbz6Dr78oZFIaWow68wY90dKszQT6qmX5fwjydAHUmQ7LPKfGGQF/HaEjTw22Ku+
	RX99wYSgVDTsvJ1ZzmtTbxVwfXh7vrx8f5+JS7AL4RHtk9raHr8sP0Wunj9tcR6FdECf/AE2pYQ
	Pf8X0HXe4DOCL10UOUawdyTNknXsaQhxkP9hdCKUWNM9NvpMHoV3S266xsziVtqlaS4ByyBr2AR
	V2gC6G2+cVTsg+btIpaEK3xBQntabEfAfn0RoEtt60NR5KfDZg4WmhSP0wzz8h8YVy0DL94c/KZ
	aZcjxNfxPVpCXkbzsvSB98WZnQN7k5VrTjgSg4LqE0UnpT/gMW6pa2DCQguNYhRMs6AiqYrnFC1
	Ke4sk=
X-Google-Smtp-Source: AGHT+IGMRGm4/WR/4L3aIyPW8LTQyvRM6kEmpyechdTB0XJmITzbv8KecSzkU0+tptyfsFCmAXHoPA==
X-Received: by 2002:a05:6512:3b0a:b0:594:2cfe:36a7 with SMTP id 2adb3069b0e04-5942cfe3b1emr98655e87.4.1762085687115;
        Sun, 02 Nov 2025 04:14:47 -0800 (PST)
Received: from archlinux ([109.234.28.204])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5942d2e60a4sm36937e87.80.2025.11.02.04.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 04:14:45 -0800 (PST)
From: zntsproj <vacacax16@gmail.com>
X-Google-Original-From: zntsproj <vseokaktusah7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: wim@linux-watchdog.org,
	linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	zntsproj <vseokaktusah7@gmail.com>
Subject: [PATCH] watchdog: fix typo 'paramter' -> 'parameter'
Date: Sun,  2 Nov 2025 15:14:31 +0300
Message-ID: <20251102121431.5546-1-vseokaktusah7@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: zntsproj <vseokaktusah7@gmail.com>
---
 drivers/watchdog/diag288_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
index 887d5a6c1..b6b487910 100644
--- a/drivers/watchdog/diag288_wdt.c
+++ b/drivers/watchdog/diag288_wdt.c
@@ -9,7 +9,7 @@
  * not recommended because it's only supported on z/VM but not whith LPAR.
  *
  * On LPAR, the watchdog will always trigger a system restart. the module
- * paramter cmd is meaningless here.
+ * parameter cmd is meaningless here.
  *
  *
  * Copyright IBM Corp. 2004, 2013
-- 
2.51.2


