Return-Path: <linux-kernel+bounces-796742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85857B4068F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F7F1B24F9A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8863064AF;
	Tue,  2 Sep 2025 14:21:52 +0000 (UTC)
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224481DF963
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822911; cv=none; b=pvoNZ++Ip9VwMrh/ABh/bBtu4gRJIIY4WodbDzTMfPaARPh950u68LFE5NnVQFOeQzHcE/QiMHAhd4W0zpc0PP7dJaiC9gXvQredek09tR58UxbJK4Y9lW/0zB/q2BaCVkpHEhV+Vb05u8ENJxkJ73/LStPiMpZQ7PV3w1HWXso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822911; c=relaxed/simple;
	bh=64iibJK+KRVjIgmjFJIhThEwuVDvu+rWRefokrk8L3c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dOib9lv4coY9WDIpNVBKdDzKKFShVcHihcHVyZnvRC4yRLK0XeSR3HTasS//vStOp93/LR/LZc1nze+WVfO1g2XzIa6GjIX0ppET1Ye6HTegcvH+yRWmcdVWM9sOXUdIwmLOMcWZwlu18Cv+MmQaDmfcwkP4II+aCOTkce1ZIKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=carnegierobotics.com; spf=pass smtp.mailfrom=douglass.dev; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=carnegierobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=douglass.dev
Feedback-ID: 3578:1022:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1344370180;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 02 Sep 2025 14:21:42 +0000 (UTC)
From: Woodrow Douglass <wdouglass@carnegierobotics.com>
To: linux-kernel@vger.kernel.org
Cc: Woodrow Douglass <wdouglass@carnegierobotics.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] regulator: pf530x: NXP PF530x regulator driver
Date: Tue,  2 Sep 2025 10:21:32 -0400
Message-Id: <cover.1756822704.git.wdouglass@carnegierobotics.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I wrote this driver to read settings and state from the nxp pf530x
regulator. Please consider it for inclusion, any criticism is welcome.

Thank you,
Woodrow Douglass

Woodrow Douglass (2):
  regulator: pf530x: Add a driver for the NXP PF5300 Regulator
  regulator: pf530x: dt-bindings: nxp,pf530x-regulator

 .../regulator/nxp,pf530x-regulator.yaml       |  74 ++++
 MAINTAINERS                                   |   6 +
 drivers/regulator/Kconfig                     |  12 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/pf530x-regulator.c          | 328 ++++++++++++++++++
 5 files changed, 421 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/nxp,pf530x-regulator.yaml
 create mode 100644 drivers/regulator/pf530x-regulator.c

-- 
2.39.5


