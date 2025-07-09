Return-Path: <linux-kernel+bounces-722996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34C3AFE187
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31680168423
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1F9270EAB;
	Wed,  9 Jul 2025 07:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="nLbkwTcb"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BC5270575;
	Wed,  9 Jul 2025 07:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046943; cv=none; b=AkWn+xCWFGQtFnS2N2WsZE6oiKAMS3+yD3zZz7ae1JX50TF+zcSDUDRVkeFb+5J1Xel7mL0erd+alGAaznMe207ay5b7aK9w81vH+4EYj3M4zfUw6Ydj3D9GfxO4zQzs1bQbyMqsOKUhvFGcYr1+N/RDjFyQRR4PXGv85bdM17c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046943; c=relaxed/simple;
	bh=ecv5+5/m1+Gnq1JTLl6m3RRrGXpo7D7ecbChgYLSojo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=NK2Bzx3L+f8fQXeE3W+Qq+o5CmBWoY7FShKonfIA/Md2n8c6KTGwXLaKFoEJMzJDp6nkrxrEEZ+2wN3yc0kLYOsRpAVWRWMVZNyQGwvj1NCn32qsr1Q4MKrs3Yz2yzEyr0Sy7QbUgJFGgdI8HZK3L8ooG/TFqoSahXK8LzAiyso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=nLbkwTcb; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 9D036A0AD0;
	Wed,  9 Jul 2025 09:42:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=ciZo3Rb0oHyr7k3Catpk4nU+ODKWlZkt8ewyJGvtWtc=; b=
	nLbkwTcbD1dBeWZQSCAsQLrXaW/WfQ22k085LHblLIv9OlgH9S4zCKaTVGpM98pm
	HVjE+bW9gi1SYFUn8hl0gfV+WDHXnIGQW/Tk2cN8IZmc9MtNATST0hjxxSG4NKc6
	3nQfMTJSGQWieF14yiyBGtXAUH5KsCgK59YA+pf6fHaZRCkxAAVsmcwjUGtKzmOq
	7Jorqna+whWh0rOpQErvwakX3p0CSLcBLdHdIstxDYZDpZu6m93REEEkfPHWtvDQ
	7T8OnoNBBNR0Tx7pZ1uZc/LcsZ//tT6vvTtmHgBU5ix1wNhyg2XeBcv4KdKsE0Ki
	sjOLFyLLoUuQBGXDb2Giv1RZgNLa8FswqVyRVWg9Rs0nR7UDRZ2UUjfZrG+seYjs
	yCdSlcxeF6L6qNTxHWq6Ve8+Tx7ndLCZJKjTIR/E698Qxx+/zIHON0DXS08diruh
	uVKH6LATakEYoogBtsCk9+kIRWFnOY5IbB0spaQAXKJoJrHfmEy5sZKMJAOBh9HC
	0gn0GBmxTpcLRtV6zlsmKC6e9YaTJkRdepjolBVnGtK3Xdd2zq1mE3HjUDy1tlxs
	WncmWVbOxGsL0RplFRbV0TpfKnYD3ZcnzvkGMQjh2u6YH98mkWzuG9hYD2dTjCIt
	KA6i1IdwMPr/gcrGVrbT0G9FLmMWWJ3/58F70sm1/6c=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Subject: [PATCH v3 0/2] Replace verbatim license text with a
 `SPDX-License-Identifier`.
Date: Wed, 9 Jul 2025 09:42:00 +0200
Message-ID: <20250709-sr-som-dts-lic-v3-0-51fcbd61aef1@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEgdbmgC/3WNwQ6CMBAFf4X07JpShIIn/8N4aMtimwAlXSQaw
 r/bciIxHid582ZlhMEhsWu2soCLI+fHCMUpY8aq8Yng2shMcFFyyQVQAPIDtDNB7wzovOqMrHh
 ptGBRmgJ27r0f3h+RtSIEHdRobLoZFM0Y0tA6mn347OElT/O/jSWHHATWZX3BytSFvE3B92o82
 xdLjUUc9eJHF1HnRVOaRktZtc1R37btCzFkmR4EAQAA
To: Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
X-Mailer: b4 0.13.0
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1752046939;VERSION=7994;MC=3508746739;ID=98588;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515E657160

Fix up Device Tree files by replacing the license text in comment blocks
by a `SPDX-License-Identifier`.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
Changes in v3:
- Also patch imx6q-h100.dts
- Link to v2: https://lore.kernel.org/r/20250703-sr-som-dts-lic-v2-1-0395c9b776d9@prolan.hu

Changes in v2:
- Fix message tags
- Also patch solidsense files
- Link to v1: https://lore.kernel.org/r/20250702-sr-som-dts-lic-v1-1-2e8584e6c837@prolan.hu

---
Bence Csókás (2):
      ARM: dts: imx6-sr-som: Replace license text comment with SPDX identifier
      ARM: dts: imx6q-h100: Replace license text comment with SPDX identifier

 arch/arm/boot/dts/nxp/imx/imx6q-h100.dts           | 38 +---------------------
 arch/arm/boot/dts/nxp/imx/imx6q-solidsense.dts     | 38 +---------------------
 arch/arm/boot/dts/nxp/imx/imx6qdl-solidsense.dtsi  | 38 +---------------------
 arch/arm/boot/dts/nxp/imx/imx6qdl-sr-som-brcm.dtsi | 38 +---------------------
 arch/arm/boot/dts/nxp/imx/imx6qdl-sr-som-emmc.dtsi | 38 +---------------------
 arch/arm/boot/dts/nxp/imx/imx6qdl-sr-som-ti.dtsi   | 38 +---------------------
 arch/arm/boot/dts/nxp/imx/imx6qdl-sr-som.dtsi      | 38 +---------------------
 7 files changed, 7 insertions(+), 259 deletions(-)
---
base-commit: 66701750d5565c574af42bef0b789ce0203e3071
change-id: 20250702-sr-som-dts-lic-b16fc7605cb2

Best regards,
-- 
Bence Csókás <csokas.bence@prolan.hu>



