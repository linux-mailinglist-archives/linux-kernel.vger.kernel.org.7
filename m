Return-Path: <linux-kernel+bounces-828988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CFFB95FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 387227A2C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C34324B36;
	Tue, 23 Sep 2025 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="lYSLrzaa"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96F3322C67
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633520; cv=none; b=YJq46soQ41oPLYa+rCgZ0G4uNZnhEZgFAtZuCpuKWkPq61uLofv3gfL9JeaKRRixyrbZgUlDZqUhieZ30GaEUg0BJJOBDOiLYfptWliw3IR0JPS5lL8IQDoLxSPvmH5IovNCrvMGatk01U3WZrrShicOLi0oy9NneIWJbC+q0DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633520; c=relaxed/simple;
	bh=EuZtMgEsgL+hRV5xdbJTdLeZhQp9dfm9ihSBPLRyzaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zv62Dm3BYIM2WO6RaUy0hiX38iFYP/ODsxxDYgdTrRzHqQZsXHysx4kc3AsiSWLAREfxuGLvAg79/gU+M8eBJeZ2eKTGeVZheBNGqVA5XyH3BI81/e6mpxdWR8KQo5gM2AP177gbsGqQY4zoiEUyd7DK/BC/wNDWigH0pzRuhg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=lYSLrzaa; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=kJbEN+nAWxl0+R+kkxsp1uN0HYAq2bqxCyL27b0ZfbE=; b=lYSLrzaakazaYd75xXCT97ShIK
	2Iaf9FNR4a05oyh9nLg6pCmVlV4Jszl0AwkSp77vvYlueS4Rr3uwSaMBBBebscbEa5/Q0+eKXm6MR
	HD4HiOkW//o9t1VVGmSORS2EhlGs8uhFW4amrCxo1b8Ou96VF4oWAocxpMc9KIictZPlqI3hQLZia
	IblbZDqBlgPNpxqj1I7OySQkR1kdMGmA1IvXU6uelNRp9TLB0HY2AJvJDxdT72LFlznCJkRJD8902
	vamMZ7cDCwyxgvK/GgDBtLeOjfdnH+9MfLsjKIK9lKe6820viIoVBC1jfoNgR1AXcKnFURUgVh/yB
	RKWV8q8g==;
Received: from i53875a1e.versanet.de ([83.135.90.30] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v12uc-0003yq-KA; Tue, 23 Sep 2025 15:18:30 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org,
	srini@kernel.org
Cc: linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH v2 0/2] qnap-mcu: add nvmem subdevice to read the eeprom
Date: Tue, 23 Sep 2025 15:18:13 +0200
Message-ID: <20250923131815.1898332-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The qnap-mcu is firmware running on a Weltrend WT61P803 MCU and there is
an eeprom connected to it, that can be read via the serial interface.

The eeprom is somewhat important, as it contains for example the
assigned mac address for the rk3568's gmac interface on TSx33 devices.

So add a nvmem driver for it and hook it into the mfd.


This needs to be applied on top of
commit a141f0ff2548 ("mfd: qnap-mcu: Include linux/types.h in qnap-mcu.h
shared header") to not cause build failures.


changes in v2:
- drop binding patch, already applied
- split up nvmem driver and qnap-mcu-mfd subdevice addition (Lee)
- add Srinivas' Ack for the nvmem driver

Heiko Stuebner (2):
  nvmem: Add driver for the eeprom in qnap-mcu controllers
  mfd: qnap-mcu: Hook up the eeprom sub-device

 drivers/mfd/qnap-mcu.c          |   1 +
 drivers/nvmem/Kconfig           |   9 +++
 drivers/nvmem/Makefile          |   2 +
 drivers/nvmem/qnap-mcu-eeprom.c | 110 ++++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+)
 create mode 100644 drivers/nvmem/qnap-mcu-eeprom.c

-- 
2.47.2


