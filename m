Return-Path: <linux-kernel+bounces-722955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B8EAFE11B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4059D7B4B38
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5B1272E6B;
	Wed,  9 Jul 2025 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="TwbN+OZ4"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C933426E71C;
	Wed,  9 Jul 2025 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045400; cv=none; b=XC5IPzosyVP3pm+IwE8Y7Y9GGNOoUrqP8eOwQLD9+ubwPLyQ4FGwLquxgdRP5MV46Wn+Wpus+3okEoUv/aC4FX3Zz83uRTj3zE70prs5FsdALbGzvvDWXs/GYBEBqyan3XavBTdAEIdUIII0jAuF+FO11PSdQ6hrGtYsZcS/OXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045400; c=relaxed/simple;
	bh=6MHWs5eYMY0n1uokle7WvfECczWDc68PSbncPzElsg0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=YTBQfsVYjhRij1mh1sozLwEMx9Hhvd3v1Rq+P1gpyl7+JVSJIJ3fwhR1uzXVdnbb/i462q1MbW0oPjYJdGTlmBv+tSbw3nYmKbflzky7lXZ05OtDgwTSQ4Zp8gYHKFaKsIMRuCoEOiagk/AH3Rtu460/GQprTyxGTsLGd4M2DbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=TwbN+OZ4; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 608B3A0AD0;
	Wed,  9 Jul 2025 09:16:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=1xUKNCTRZOcUfegKTMuwnSkh5jIPQ1aseWbdQMJNrwg=; b=
	TwbN+OZ4U/BdPZczAAkHzPpjwTAER/9yZw+vJpAJawdjnQLbJDtS2EdzyDmuL28k
	b8nnfFvhxZbu6LLHohFyf9wZdxL5soao2I85GWDy8evJ/gL20i8+LNU2yZQ9WkoR
	XxJYw+S2/qj+7F74hx3FxCRABpvWwHv4A6qQ5KSNUJ4nVU5IUOiNA3WS8Lkq9mI8
	pSr1Y6sPVNgcI0DgYU37BF5pE0CMjt8LQrDcabBIXoFdR93rAMG/JgKaVTUCWTS6
	TBOOk7A6xONDPYmeSlxODU43ubbH1OkZn2r9ce6ve9l63AqCY3o8uveQkqnh8h50
	vhESAqFrJoZq0puaMVhtMINdxr4RKuczM1SSsURrd709TKi2HD9XNGJYoskkhzBe
	Xz+iQ3mQFXfju9l1zKLatUupboWzbYlfKLofTBUsvekTRY2PC1kmgjAQuMGXKU6c
	yUw0UpWYEtI3d322vqNBR/EXGtGek+GwdwLehdoOcosjig7TShR2q6w1ZllU1OSN
	Y+kuF8uxIYmjSkoQmlA7HIrvGGGsNIQG4IjVdyIAnuTHZsOV7S8WPlGB+mvI5aex
	7ssEB/vCtNXAYIafXioBnZnrxiq8+X4wY+gv6qjKPAAMw9FvL8YqBAgP9iDGWfHv
	yOE4KXyJqjLVIM7MoMNnIap3EUh+ZR8TSYruqOso64I=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Subject: [PATCH v2 0/2] Replace verbatim license text with a
 `SPDX-License-Identifier`.
Date: Wed, 9 Jul 2025 09:16:06 +0200
Message-ID: <20250709-tsx9x0-dts-lic-v2-0-b9b7d056728b@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADYXbmgC/3WNywqDMBBFf0Vm3SkxJVi76n+IizzGJmCjZFKxi
 P/e6L7LA+eeuwFTCsTwqDZItAQOUywgLxVYr+OLMLjCIIVUohESM6/tKtBlxjFYtI7c3Vktb0M
 DZTQnGsJ6Bru+sNFMaJKO1h+Zt+ZM6RB94Dyl73m81If+92OpsUZhlFWGWqka95zTNOp49R/o9
 33/Adwls03FAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, Lucile Quirion
	<lucile.quirion@savoirfairelinux.com>, Sebastien Bourdelin
	<sebastien.bourdelin@savoirfairelinux.com>, <contact@savoirfairelinux.com>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
X-Mailer: b4 0.13.0
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1752045368;VERSION=7994;MC=1726887820;ID=156410;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E657160

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
Changes in v2:
- Fix msg
- Add patch to imx51-ts4800.dts
- Link to v1: https://lore.kernel.org/r/20250702-tsx9x0-dts-lic-v1-1-0b5c5be9257d@prolan.hu

---
Bence Csókás (2):
      ARM: dts: imx6-tsx9x0: Replace license text comment with SPDX identifier
      ARM: dts: imx51-ts4800: Replace license text comment with SPDX identifier

 arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts    |  3 +--
 arch/arm/boot/dts/nxp/imx/imx6dl-ts4900.dts   | 38 +--------------------------
 arch/arm/boot/dts/nxp/imx/imx6dl-ts7970.dts   | 38 +--------------------------
 arch/arm/boot/dts/nxp/imx/imx6q-ts4900.dts    | 38 +--------------------------
 arch/arm/boot/dts/nxp/imx/imx6q-ts7970.dts    | 38 +--------------------------
 arch/arm/boot/dts/nxp/imx/imx6qdl-ts4900.dtsi | 38 +--------------------------
 arch/arm/boot/dts/nxp/imx/imx6qdl-ts7970.dtsi | 38 +--------------------------
 7 files changed, 7 insertions(+), 224 deletions(-)
---
base-commit: c435a4f487e8c6a3b23dafbda87d971d4fd14e0b
change-id: 20250702-tsx9x0-dts-lic-cded8dca23f7

Best regards,
-- 
Bence Csókás <csokas.bence@prolan.hu>



