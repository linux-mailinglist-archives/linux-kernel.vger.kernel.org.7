Return-Path: <linux-kernel+bounces-765448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D8EB235DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926E8586CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2B22FF14C;
	Tue, 12 Aug 2025 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="XS2iR68w"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1D62FAC06;
	Tue, 12 Aug 2025 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024907; cv=none; b=FzjjuGJ0Ui2nO7yYF3nXHuzq34n0q7J9A0LSNlILgsvjjh54w9Xer4fvLTnBkeZE73gAnIQhHTBFZ5hpv09UkHDuSms3a+mEAPRnXe7DJ2WzQms26uM5C6n0JUsH2crc4xuykOgtwgmTPbl1WbOw6O49H9TcPkf1YCWC10wFTBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024907; c=relaxed/simple;
	bh=DQQenL9DOL7wPHstzqxApM+0t4yV+a9ZJFj5f2xv+yY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=i00h+2rjdFgrn4V50FtGAfQ85NXHNADqiy06DqBzja1XRkZbROPkeWXUczVjGWn7hpvoFNk7JVBtopb+n326PM71GC17M/uuxO9OBUG54mMBtZY/L4msGAYT9d7aKZUicMuveXtUw/4Uqlblh3kdEIDmhCMgNHELV2am+7C3lUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=XS2iR68w; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E6C60A0A91;
	Tue, 12 Aug 2025 20:55:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=wiTgx5FswFd9UU0aL3t0f1YHFTB6TqQdKLInT1tRewQ=; b=
	XS2iR68wZPkJIKeuFZCHlUoAwlNFb4zVBr1oD2ktQ5QTBmtY7lwavvnNoHR1w8ch
	MDZV84lD44r6Z9TRITKBUl2GSWeSa949u38AkZ7KarW5dC8HQv9YHLYDjUhAsPFL
	qAmZAAsv/CD58rOwQI+WOH+HaJAX8pbn30KwwNLrKYUBey2ir6GRGNMt8pu3XPJa
	VVeKk1XU7pkPdv0AYjxS0Y5mOtHeZt0/+cC1hfkvvAXUizkQ4MPsYezPCGs6kCKk
	He4/03UcLv03pECuYvl3TNSoVyDvVMfC4WTZvP7hmwsN/xf+oqb8yfJFduBTRAJf
	LQTGugD1jzZfqIm/eZMIPTSVIuuF2pBhinGzzlyCOwrzI+6OmI1hI+QvyMkPi7gw
	EiftcHtpeZYxeWgrdrMI2MYOguc+Lo9EFdtueCwbLEuG/Xw9iSy2RYnh8FUUo2Oi
	E09NuZfgegaMxibyI22tPyCx4yNRjGkmQJUMWV70sFrSPvw3U08dt2Ep4fBeEyG5
	aKEyz7iz7wQkznGwiRSTFUc5/ZyJVp3yYA7uY1+CQFn8kSJ/Imdg9Pzz9GlEb0Ci
	H1S2sADyhII8VPggSkixjvyKBxRb0ust9+L5iCkAzj/8oMTYv8AUbh5oixofTlt+
	yH/W9KVNFuthA6fWYR5Oj6UCsvGepADT4HIR8XUoGj0=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Subject: [PATCH v3 0/2] Replace verbatim license text with a
 `SPDX-License-Identifier`.
Date: Tue, 12 Aug 2025 20:54:42 +0200
Message-ID: <20250812-clab-dts-lic-v3-0-bf7aa5462766@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPONm2gC/3WNwQ6CMBAFf4X07Jq2KAVP/ofxsG23tgkW0iLRE
 P5d4ERMPE7y5s3EMqVAmV2KiSUaQw5dXKA8FMx4jA+CYBdmksszV7wE06IGO2Rog4GmVE44Vxl
 CzRalT+TCe7u73RfWmAl0wmj8evLEPFBahz7koUufLTuKdf6nMAoQoKraOK1qQxavfepajEf/Y
 mthlHu5+ZElcEASJ+LOcu3KvTzP8xenHIN//gAAAA==
X-Change-ID: 20250703-clab-dts-lic-937f1ff6ceab
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Igor Grinberg
	<grinberg@compulab.co.il>, Ilya Ledvich <ilya@compulab.co.il>, "Valentin
 Raevsky" <valentin@compulab.co.il>, Christopher Spinrath
	<christopher.spinrath@rwth-aachen.de>
X-Mailer: b4 0.14.2
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1755024903;VERSION=7995;MC=1796943816;ID=1014991;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515E617465

Fix up Device Tree files by replacing the license text in comment blocks
by a `SPDX-License-Identifier`.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
Changes in v3:
- Fix one missing SPDX line
- Link to v2: https://lore.kernel.org/r/20250709-clab-dts-lic-v2-0-ae14e0fd0bf3@prolan.hu

Changes in v2:
- Also patch imx6q-utilite-pro.dts (in separate commit)
- Link to v1: https://lore.kernel.org/r/20250703-clab-dts-lic-v1-1-768cfb78ceda@prolan.hu

---
Bence Csókás (2):
      ARM: dts: imx6-compulab: Replace license text comment with SPDX identifier
      ARM: dts: imx6-utilite: Replace license text comment with SPDX identifier

 arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts      | 38 +-----------------------
 arch/arm/boot/dts/nxp/imx/imx6q-utilite-pro.dts | 39 +------------------------
 arch/arm/boot/dts/nxp/imx/imx7d-cl-som-imx7.dts |  6 +---
 arch/arm/boot/dts/nxp/imx/imx7d-sbc-imx7.dts    |  6 +---
 4 files changed, 4 insertions(+), 85 deletions(-)
---
base-commit: 66701750d5565c574af42bef0b789ce0203e3071
change-id: 20250703-clab-dts-lic-937f1ff6ceab

Best regards,
-- 
Bence Csókás <csokas.bence@prolan.hu>



