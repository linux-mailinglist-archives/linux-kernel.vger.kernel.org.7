Return-Path: <linux-kernel+bounces-768185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B5FB25E04
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B1F3AF16D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DA52E2DE9;
	Thu, 14 Aug 2025 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="tU9jSxht"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAB82D3731;
	Thu, 14 Aug 2025 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157680; cv=none; b=SqUjqwf8nlMZPhKQHltiTQhWMiW4aHb8ojRSobUUVzrEphfIPZ4jBoqn3MWxNK+j36LRFgJNL5Yrl9sFjQy0YXC7XgCYxa0YrTIoQrQXUt6sFDqHo1nUi557ljmovDdrBBfSgPv0UYvSmHKghGHPsaGNTEMUtCExArfuBfGsT0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157680; c=relaxed/simple;
	bh=xAn+cnfyyM3U3BtSeRhVwWWBr+mg4WUF0H7T5rzB8/I=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=iVfl1OOrluo+M3Lu6FGpi2NjXWyKC/gbKNTBdh44IzTiKE4ravq9p3esS9VqIQR1s8mOuQCb2bu0KXIeusNjBkrLWWwcvFcGcYQafS9Zfd0uX7PvxvOo8QLtnw/BqGjMhUpMo8eX8aUWDpwHUHNew7d0DFzSszFbKtr5UabCKGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=tU9jSxht; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 0646CA01D2;
	Thu, 14 Aug 2025 09:47:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=/PgpZFPlATlaMC5VfqXMLfLIa0Lf3oB7k4UtRnC01pw=; b=
	tU9jSxhtFHdpfUAzU2X92LRvFj0LyycV9ceTrA+S/LkT1TunDlVk1W+qUtsTaxpV
	/HgocVSCLJ22ytp4Iij9TRIDNYLzRWVv+d+zTIy2SDcllWKq51V6Q/gYd/TKhino
	8Ob9MUN1N4NhhIrl6JvrDA5i5hJq41iuAx6p247kPJVtBvnQSyFF2+mu2HEuVZx9
	9uHWHJGbltG43F1oVNetX8tLPAwwjDR97sAZiKojKI0McvFfHZPYaok0gtLvMfPH
	0g/2/VeSHbimmZfTpbNxfvRQwQL0rJ4n+/htPuOGYJGkXnW/0gE7NfGYIQmKinZa
	OrHXblIifgC0KHfvOF3SymyIHpFiEYv0P2VBmdnAeAkJziSnVymnnSP5j3gpDEnP
	KiT5aRBO0iGlsdg6Ogjva04yV8Hn40XyN5IHylUJVynqkEZN77YY3LhYSc1jaKyG
	nix5ZzQ9fIgsFgT7bTZZ2vCaDm1N/rDMGBurQt4WNdNYWnvPz++fRXbPcJbhO32T
	LZ9XcAoJ4NlVbd7U3ioob2jnm7vsl7b0IO8cOTd2J2Fbbt/L2dzYkLjU/GxFhvl4
	Cx54N9sEsMqe7snT7BH0uSEnOndd6+QbJYltaW80Lu+OpiLrcOAscrCkCuivF4Cg
	ILBepz4raTqx+2nljqJ+YngIfWkSEIkkD/HilhZonSs=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Subject: [PATCH v2 0/8] Replace verbatim license text with a
 `SPDX-License-Identifier`.
Date: Thu, 14 Aug 2025 09:47:42 +0200
Message-ID: <20250814-imx-misc-dts-lic-v2-0-faff7db49a5f@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJ6UnWgC/2WNwQqDMBBEf0Vy7pYkpY321P8oHmKMzYJG2U3FI
 v57o9BTLwMPZuatgj2hZ3EvVkF+RsYxZtCnQrhg48sDtpmFlvoqjSwBhwUGZAdtYujRQall50z
 b3HKKPJvId7gcl886c2PZQ0M2urAfDZaTp70YkNNIn0M9q73+s1T/llmBBGOVVlUnL8ZWj4nG3
 sZzeIt627YvMwIOXskAAAA=
X-Change-ID: 20250708-imx-misc-dts-lic-820fc7db6fc7
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Fabien Lahoudere
	<fabienlahoudere.pro@gmail.com>, Andrej Rosano <andrej@inversepath.com>,
	"Troy Kisky" <troykiskyboundary@gmail.com>, Gary Bisson
	<gary.bisson@ezurio.com>, Joshua Clayton <stillcompiling@gmail.com>, Sergio
 Prado <sergio.prado@e-labworks.com>, Wig Cheng <onlywig@gmail.com>, Sean
 Cross <xobs@kosagi.com>, Otavio Salvador <otavio@ossystems.com.br>
X-Mailer: b4 0.14.2
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1755157668;VERSION=7995;MC=3327119661;ID=1088340;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515E617667

Fix up Device Tree files by replacing the license text in comment blocks
by a `SPDX-License-Identifier`.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
Changes in v2:
- Replace bounced mail addresses
- Link to v1: https://lore.kernel.org/r/20250709-imx-misc-dts-lic-v1-0-7a1219f037a9@prolan.hu

---
Bence Csókás (8):
      ARM: dts: imx53-ppd: Replace license text comment with SPDX identifier
      ARM: dts: imx53-usbarmory: Replace license text comment with SPDX identifier
      ARM: dts: imx6-sabrelite: Replace license text comment with SPDX identifier
      ARM: dts: imx6-evi: Replace license text comment with SPDX identifier
      ARM: dts: imx6-marsboard: Replace license text comment with SPDX identifier
      ARM: dts: imx6-pistachio: Replace license text comment with SPDX identifier
      ARM: dts: imx6-novena: Replace license text comment with SPDX identifier
      ARM: dts: imx6-warp: Replace license text comment with SPDX identifier

 arch/arm/boot/dts/nxp/imx/imx53-ppd.dts        | 38 +---------------------
 arch/arm/boot/dts/nxp/imx/imx53-usbarmory.dts  | 39 +---------------------
 arch/arm/boot/dts/nxp/imx/imx6dl-sabrelite.dts | 38 +---------------------
 arch/arm/boot/dts/nxp/imx/imx6q-evi.dts        | 40 +----------------------
 arch/arm/boot/dts/nxp/imx/imx6q-marsboard.dts  | 38 +---------------------
 arch/arm/boot/dts/nxp/imx/imx6q-novena.dts     | 45 +-------------------------
 arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts  | 39 +---------------------
 arch/arm/boot/dts/nxp/imx/imx6sl-warp.dts      | 44 +------------------------
 8 files changed, 8 insertions(+), 313 deletions(-)
---
base-commit: c435a4f487e8c6a3b23dafbda87d971d4fd14e0b
change-id: 20250708-imx-misc-dts-lic-820fc7db6fc7

Best regards,
-- 
Bence Csókás <csokas.bence@prolan.hu>



