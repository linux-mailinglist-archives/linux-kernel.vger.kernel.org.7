Return-Path: <linux-kernel+bounces-845091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA856BC37D5
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 08:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF0818961F9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 06:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891E02DEA90;
	Wed,  8 Oct 2025 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="lHcYksxm"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB9226B755;
	Wed,  8 Oct 2025 06:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759905686; cv=none; b=rC5dFmw7wpSm+stMPlMnuFpoqfBy4pvesFTlki+Wxj/SF+bxh6xncMWsfjKVahxg1SHsvZf3xb7jkxqYknrU+U4lk7IXakVrcXhcO/4TpJxir5+YzcGJU5MSuutgBDCJoND8XC50v7FzzqDmrBmm1CaXuspa8gUBPFi7TOptV+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759905686; c=relaxed/simple;
	bh=qHDKrUnbwFpUyOo63VuaRywrzY2PN0YSw3mDZDwP4CY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CP90S6HqKgqnjKcTWK0Pj6oZlV6mUulKmpCbFwYwesskbuYWt4/x4+itndui+uMXB5gm9MeJBjO5KFWp17Da3r9E3JtAUzaDdlOLHNn4R5ZLvylL5fRCk7WRI19uAzLFB8A8L7VQtdyajHN/UNl6nOd3yQUcMqk/eEI8s5i2XYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=lHcYksxm; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759905678; x=1760510478; i=w_armin@gmx.de;
	bh=mrEujpjPCH689XnBaF1XxKzPSzECV1lO2phgBtByuVY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lHcYksxmnoIT8LFb84q6Ca+pIbp/O1vYXbptDUtnB5P11YSx+lhQzy5lwHbQPYvK
	 1iENAx7G6sc60NXOIkPHLsGvAT812593Ob9tNoc3iTq8RNkIdG2ZgFiqruRq+g+4Q
	 CN7fu3zGcIegJAO9fSNrE+p0Adsqzfy4ESM36ZW9LO5FJlchOnWhM21BFuaI5Jrzf
	 OPGhZ6L4TWg4T/7dZtE3BeXPl3b/D/2R2OBNw+R6DulPbco8XOFuqCv79fzVI5v8N
	 OUGz8au+PuBbk+N1mj1AOw8biFHDByw2PXp6s8myE6bZgUghFQO+8Gk77ukx2IbM3
	 O0xKumu+542biHbolA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.dip.tu-dresden.de ([141.76.8.136]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mq2jC-1uSQHs0fGk-00cpuZ; Wed, 08 Oct 2025 08:41:18 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: matan@svgalib.org,
	peter@chubb.wattle.id.au
Cc: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: lg-laptop: Add support for the HDAP opregion field
Date: Wed,  8 Oct 2025 08:41:12 +0200
Message-Id: <20251008064112.5981-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:unL7xqzIXpj3cOaoaGNHcM42ELOCpHjtRtl7Y23y6FHUCTkSUcb
 5O/+gZEA5v4L0sjKdE8YR4Lo0cnRl9gaAV/d3vlgENk2mgKAp3Td/4hHTetY+2Yt5PTQ28m
 x+h/ng2bSFW+U5hO2YUUkZfQaXK6ZzDP+Vy9yK4786bkLhyNF1zX7zmHderqKzDp8ezDhPH
 hPU3DoG6FC6wsi07IPUdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4z+XMDI9IGI=;VmZlcDuPp0q5RYg7swwZQivA8aP
 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
 wwJnkzOMErGV3RYTpAW7lh1OIDMfIXsggV2rQP

Various LG notebooks have a special field called "HDAP" inside
the ACPI operation region handled by the lg-laptop driver:

	Field (XIN1, AnyAcc, Lock, Preserve)
	{
		DMSG,   8,
		HDAP,   8,
		Offset (0x10),
		P80B,   8,
		P81B,   8,
		P82B,   8,
		P83B,   8,
		P84B,   8,
		P85B,   8,
		P86B,   8,
		P87B,   8,
		Offset (0x3E8),
		PMSG,   1600
	}

This field is set to 1/0 when the HD audio device is enabled/disabled
using the _PS0/_PS3 ACPI control methods. Add support for this field
to avoid printing warning messages when AML bytecode writes data
into it.

Reported-by: Peter Chubb <peter@chubb.wattle.id.au>
Tested-by: Peter Chubb <peter@chubb.wattle.id.au>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/lg-laptop.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-la=
ptop.c
index 4b57102c7f62..9996bb43e9a0 100644
=2D-- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -18,6 +18,7 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/string_choices.h>
 #include <linux/types.h>
=20
 #include <acpi/battery.h>
@@ -41,6 +42,7 @@ MODULE_PARM_DESC(fw_debug, "Enable printing of firmware =
debug messages");
 #define LG_ADDRESS_SPACE_ID			0x8F
=20
 #define LG_ADDRESS_SPACE_DEBUG_FLAG_ADR		0x00
+#define LG_ADDRESS_SPACE_HD_AUDIO_POWER_ADDR	0x01
 #define LG_ADDRESS_SPACE_FAN_MODE_ADR		0x03
=20
 #define LG_ADDRESS_SPACE_DTTM_FLAG_ADR		0x20
@@ -674,6 +676,15 @@ static acpi_status lg_laptop_address_space_write(stru=
ct device *dev, acpi_physic
 	byte =3D value & 0xFF;
=20
 	switch (address) {
+	case LG_ADDRESS_SPACE_HD_AUDIO_POWER_ADDR:
+		/*
+		 * The HD audio power field is not affected by the DTTM flag,
+		 * so we have to manually check fw_debug.
+		 */
+		if (fw_debug)
+			dev_dbg(dev, "HD audio power %s\n", str_enabled_disabled(byte));
+
+		return AE_OK;
 	case LG_ADDRESS_SPACE_FAN_MODE_ADR:
 		/*
 		 * The fan mode field is not affected by the DTTM flag, so we
=2D-=20
2.39.5


