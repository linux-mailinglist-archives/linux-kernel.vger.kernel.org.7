Return-Path: <linux-kernel+bounces-883780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB2AC2E667
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4E63AA097
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765C92FF644;
	Mon,  3 Nov 2025 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="BvO0hEUA"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44B023184F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 23:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762212598; cv=none; b=GT1eC87mmcvvkiSj4953MMe+llbJAKrbzIiwiA/pTIK/uLrNQfBXoxFcMpaJFmskFStuXVeEFMXKINbAWCU02O83kx7j3SSLtj0mQ/xtNWR9deP58GJySsGRzEZW06dm9p2FVabcElkpUCWwVAoeRDz445tHsUNuFKsfcbYXf2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762212598; c=relaxed/simple;
	bh=M6GknbJpE506sINKjQjH772EGL0xHUNJqJDMuG3v7JI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PmHVP4pSqpSttR5Z0mkWTXqcWuWrKScEZ8BXyIY4/eNcKL9h9QTcORpnWBI4vhPSo6uS52yiZUuiDsdDARhE5Jir+h2ZJolmvF9crZB+flvGqYHt6CJSK3buTz61UZLOSJEVux+FsUXcZ5+HrUfFGDF5Qgii/Kq5n0CZWdj1pqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=BvO0hEUA; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=/GEMrOwZVsiXdMif1L0bfvd7qwfmMoi0a0kPiLrWVPA=; b=BvO0hEUAUKHNaCspW5SOVCu0/G
	PwrTaHoHOMGWWOlg++lw6Am1wTewS49UfOolGriQxEukA6xtj+RFRqa02sfmnv3YIduazuP/t65uz
	Z+ko0GbyKUGX0cWbLa5y5F2oFqpJPHkP85COWY40Ky494KGItFycxoy3ZzABkEGoDbDSzq1ePwHEe
	jF6P2kLcUXgfhunylDroww4w89CQ3geDtjVlVDcNAy4CQ7QUugfLnTIdiS3wH3GaFiFjnzf0p8Smw
	LI4F7tfwfV09b4E9Czw3UdNC2iOHlbojYbjg477imgC49CPTEiaJX39hUh8Z1SfHgGA5zM6wOFSrT
	0mrgQENQ==;
Received: from i53875a3a.versanet.de ([83.135.90.58] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vG3zh-0007mj-5a; Tue, 04 Nov 2025 00:29:49 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org,
	srini@kernel.org
Cc: heiko@sntech.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] qnap-mcu: add nvmem subdevice to read the eeprom
Date: Tue,  4 Nov 2025 00:29:40 +0100
Message-ID: <20251103232942.410386-1-heiko@sntech.de>
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

changes in v4:
- add missing linux/slab.h include for kzalloc and kfree prototypes

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
 drivers/nvmem/qnap-mcu-eeprom.c | 111 ++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+)
 create mode 100644 drivers/nvmem/qnap-mcu-eeprom.c

-- 
2.47.2


