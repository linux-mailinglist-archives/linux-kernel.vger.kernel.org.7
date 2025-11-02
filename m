Return-Path: <linux-kernel+bounces-881891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8278DC2928C
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 17:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F5B188D018
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 16:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D342BD031;
	Sun,  2 Nov 2025 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="rKxQbaA2"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A90265296
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762101618; cv=none; b=HHfhIM9cj0GzD6DEYZCvmzSNNaJtkCCmVj+zU8RimTim6bEUH81tC/JtH1OqTSlK2kbxZ2DChIiaIyc119EszVmPL+qCsv6t/QcnobnxEfnSDEi/eMMJWzCnvHbDXWwZBO6jdsdRT7SKe8lW9BzhXSZdvn7DNXjrdhHEm60K58E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762101618; c=relaxed/simple;
	bh=Kb3JH/oYXyIfvAreOyBtDfihenmrwJ9JBUgwvu5PIJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4xvhwffOBrVM3OwkNCYfzkqTlsgQ0PDSl8UvbSdJJMA+Nm8azGiMAewQTywdm8kzt0jTert/eH6323NX25i8PEKpD7WJ9RKSn1LrKVrlKAg2+tCsybawXc4a6AvXfih3NEQBEWUls5vead/tVxKeXtqzhRXhVFoSFKY6TwkWvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=rKxQbaA2; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=9v+VlZNs7pkUJ4buDzchWz+j2/PHnTQbOEo1xLRf2WU=; b=rKxQbaA2kTv7NS+CvtiIYVXtsR
	v1p60AWJ0MVvyDwG03vEWSkcXyAihr/IFJE7M1ew8d6iyHKeZH0tUS0AUG2+1s3smJBdIkC3vtzj7
	vOGpHnWEkYBkDyGQ3zsEDFG7jTzS1A2WMUCnrTGjX2rdyK4FGU1fTG668f1pggzhj5IZqHPCax85J
	fIaifuUTLKdaMsB7q+dLf8UIK1SDiMXOG+NOwpLm8i5qWGRgnv/b8h4cBVuARdfZCh/c/c3RgQVgE
	am/L7t6NUzS2vOB5kc9zbta06d1ADu2oSb6F1GmXAXpC8dnMiB40isjhhRHeKd5IAIvHB3ZU1aCUS
	Qr4sAYSw==;
Received: from i53875ba9.versanet.de ([83.135.91.169] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vFb7f-0003Q7-Ea; Sun, 02 Nov 2025 17:40:07 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org,
	srini@kernel.org
Cc: heiko@sntech.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] qnap-mcu: add nvmem subdevice to read the eeprom
Date: Sun,  2 Nov 2025 17:39:53 +0100
Message-ID: <20251102163955.294427-1-heiko@sntech.de>
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

changes in v3:
- rebase on top of 6.18-rc3
- the compile error the kernel-test-robot reported in v2 should've
  fixed itself with the patch applied before 6.18-rc1 .

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


