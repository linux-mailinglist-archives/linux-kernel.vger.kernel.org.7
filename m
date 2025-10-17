Return-Path: <linux-kernel+bounces-858214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0311FBE94D0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9D6E34CC42
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2120323EA9E;
	Fri, 17 Oct 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xaXCSQhp"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408A42F12C4
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712310; cv=none; b=HvEskZT4ytMUCmdkroozSrS1ZKbAFWRJY5UE9mMzvUHd5ywwOz6eqvQeqSktviRJ5vZajQdTwkm9z5PnhZlA8+sadAm9hae9WaRm02hFnFEJejTAOO7U6fck29/cKx8cRxMjrYffVnT95otk0P94fDef8c+FFc2MMQ6ABFKr/D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712310; c=relaxed/simple;
	bh=7yS+3WVVMV1k3kFMBGjytJ4hvvP/oGoU7QYoLBsZUKM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ve1R6i1d5txp0fRAEwdcBqgmL763e9La8BqRB6r5alBhjsiGZ9Rr3MoXFS2rqKccaGB6+Ql9zL+cAa/DHDedXnUO2spdboNutkC1DE4NQx1TU9l/YKDpOHdWO+gsrCG7SoHfKHPkhIr9QJnRLcal/ojYmlRIYz4aYYkVz/MrpXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xaXCSQhp; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 30031C041EB;
	Fri, 17 Oct 2025 14:44:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 73D92606DB;
	Fri, 17 Oct 2025 14:45:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5AA1F102F2360;
	Fri, 17 Oct 2025 16:44:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760712303; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=OE1RwCUFQpjSHhtqjiyxSFVV1olT1TnL086Q3IopYSw=;
	b=xaXCSQhpeI9tbP+EEL74P8TSHV4xOEN4wshZZ7c9jOz8xPfgMw5Li1VifOB2vnhGxuwDaf
	kUhek0Xm7eN4YM+E4SwvfKzGCFqYc/QfDxXEYDFykTtj1c7VZSQ75boxjMI+qmcZEe2VHA
	Rms9ZLbKqKPpz9S3o/D9MzqTdWY78iZEfYc7TqfTbycc8oewsah5+EuErommgy8gMl15Q1
	Ojx93L15N61cemY0UgXoAu0lJw4pLpdV2Z8e2uC5uuZ8376GwLI+SGKsVniPiqYPB6ldSw
	EJWkMDxlqEaYBkuLgz7XGg8ZFI4Gse0Hq5PQ0UrgkpbwYvc3Ij2DB7tkTuCbAA==
From: "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
Subject: [PATCH RFC 0/2] firmware: ti_sci: Introduce BOARDCFG_MANAGED mode
 for Jacinto family
Date: Fri, 17 Oct 2025 16:44:49 +0200
Message-Id: <20251017-ti-sci-jacinto-s2r-restore-irq-v1-0-34d4339d247a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGFW8mgC/zXOzYrCQAwH8FcpORuZVK2lJ2HBB/AqHqbTuBtpO
 2syFkF8d8evW/5JyC83MFZhg6a4gfIkJnHMgWYFhD8//jJKlzOUrlyRI4dJ0ILgyQcZU0QrFZU
 tRc2besZlWbNz9bEjFyAf+Vc+yvUF7GG3/YHDu6l8vmQsfSYDm/kX1hQfavmlJKJY7H3Kr+FES
 FitwzrwqqO2WmzaGFMv4zzE4Qm23hhzPUhqiqmaU40aCA73+wPX6L8n7AAAAA==
X-Change-ID: 20251010-ti-sci-jacinto-s2r-restore-irq-428e008fd10c
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 richard.genoud@bootlin.com, Udit Kumar <u-kumar1@ti.com>, 
 Prasanth Mantena <p-mantena@ti.com>, Abhash Kumar <a-kumar2@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

This series introduces the BOARDCFG_MANAGED mode, which is used by the
Jacinto family. In this mode, low power configuration is handled
statically for the Device Manager (DM) via boardcfg.
On Jacinto SoCs, the DM-Firmware does not support suspend-resume; instead,
it is restarted from scratch during resume. As a result, the firmware is
unable to restore IRQs, and this responsibility is delegated to the ti_sci
driver.

Signed-off-by: Thomas Richard (TI.com) <thomas.richard@bootlin.com>
---
Thomas Richard (TI.com) (2):
      firmware: ti_sci: add BOARDCFG_MANAGED mode support
      firmware: ti_sci: handle IRQ restore in BOARDCFG_MANAGED mode during resume

 drivers/firmware/ti_sci.c | 153 ++++++++++++++++++++++++++++++++++++++++++----
 drivers/firmware/ti_sci.h |  14 +++--
 2 files changed, 150 insertions(+), 17 deletions(-)
---
base-commit: cb6649f6217c0331b885cf787f1d175963e2a1d2
change-id: 20251010-ti-sci-jacinto-s2r-restore-irq-428e008fd10c
prerequisite-message-id: 20251014-ti-sci-io-isolation-v1-1-67c7ce5d1b63@bootlin.com
prerequisite-patch-id: 7bbf6ca9fb85214b5360548506ccca7fae2e5a16

Best regards,
-- 
Thomas Richard (TI.com) <thomas.richard@bootlin.com>


