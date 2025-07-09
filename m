Return-Path: <linux-kernel+bounces-722986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4B0AFE168
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B7A189C3AA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287B0270ECD;
	Wed,  9 Jul 2025 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="bHeETC5Y"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7D26E703;
	Wed,  9 Jul 2025 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046568; cv=none; b=Bt7aGzPdU20ORyQEsJ+Cp19kHs+23CBv8rOgbwDe4Ie2IGDzlJIgHxUdwsWXUMokNUM48Rg2Z0VwnL9BCclOjnZ+jrwg6Uw+an60NwY6AtlJd4SqQ9+zyzJT4F5whaWLB91ycZrwhquVCfWrlJ6xz5ls3IOUAhgqSvHeoCdp3wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046568; c=relaxed/simple;
	bh=MHO+wqttm9IwRn51ncx0EvQ4Awa8cG2+AkQoeAgBcks=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=V665AczqT2qd1sXxncvDVadgxQrsuA+vYI89g5XtzsC7beIDykSSPb9Bvd8FLS7riC/GWLOH9cvYxvtH84/KKK1fTtQ28ml0niSjXXBAaKr1vCmNDTBGV4L4B4haWCwiVjF0GwKVgNxhLpIhb1uq2tNlGW4gQ9tckCheL3VWIYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=bHeETC5Y; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 598A1A00D7;
	Wed,  9 Jul 2025 09:36:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=I10eUqTaVNFpuSOwlVJzBv/KnrXqakY/X6KD3vhHpq0=; b=
	bHeETC5YbdMCs8lgL5/nWyKVHYlPBBp1YhVUX+VHI8w9xMAA1o3MuWbt9HVH2LqY
	+9rP9eBedCfljrwbJ00lzeXSx/dSWzI1J4GgxXxjckyR6DDn6Jd8w067Pd/89IOq
	g5DMhn193sDZlHF5JfVX7sfpM/GiVqs9xrrc4vE+EOIkWeTmFa3gyJqEEta0P1iU
	F2PMfbJ0UcA/mr2TP9ICQ8c6ZLwMx6PwnmS0uYJXDWZqrBOJ+u6Zf7poXwTnSHA0
	VYUTA4NsLqctf2ODsLQbC6t8mjC4/eA2ZiGPgh5I2lU/CgKVNtC05xGpHL2GrAz7
	6xdbEVfZ+jx7lPnF2jm2gLgAgppkkY56HshvHDwWPBaclqdEQO7LPcWZpJLHqgCZ
	iK5XCa0u/fmewt4RvZ/H0kMoGQ40NbVu2owIGuiTZmAd0Ag81+/F1th0P2/lsqgk
	EebmPV1+A/q9FbzzjebtbuR+F0eFaryHZIblj/su1F6dTtznZse8stpDRk9iw8gV
	Fw7qEOL7eEOpo9LWzjvMxhIYLnvW767lsQrMzBF7RUY3BOIWxpAbwe7tiNUkZ5mw
	GsIeoAiBo4CEV95r9izJHaaZjX/8MQPUF7wJSJCb93lowjfD67GiqM56v0PLFBWh
	ZtkJoZHgjOad8ROdsKpbxDGhenRHI7ZrZaHczsApl2I=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Subject: [PATCH v2 0/2] Replace verbatim license text with a
 `SPDX-License-Identifier`.
Date: Wed, 9 Jul 2025 09:35:41 +0200
Message-ID: <20250709-clab-dts-lic-v2-0-ae14e0fd0bf3@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM0bbmgC/3WNQQ6CMBBFr0Jm7RgKkaIr72FYTMvUToKFtEg0h
 Ltb2Lt8yfvvr5A4Cie4FStEXiTJGDJUpwKsp/BklD4zVGV1KXVZox3IYD8nHMTitdZOOddYJgN
 5MkV28jlyjy6zocRoIgXr98iL0sxxF72keYzf43ZRu/7nYVGoUDetdUa3lnu6T3EcKJz9G7pt2
 340QDfrwQAAAA==
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
X-Mailer: b4 0.13.0
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1752046564;VERSION=7994;MC=486602207;ID=156666;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E657160

Fix up Device Tree files by replacing the license text in comment blocks
by a `SPDX-License-Identifier`.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
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
 arch/arm/boot/dts/nxp/imx/imx7d-sbc-imx7.dts    |  5 ----
 4 files changed, 3 insertions(+), 85 deletions(-)
---
base-commit: 66701750d5565c574af42bef0b789ce0203e3071
change-id: 20250703-clab-dts-lic-937f1ff6ceab

Best regards,
-- 
Bence Csókás <csokas.bence@prolan.hu>



