Return-Path: <linux-kernel+bounces-732614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91501B06985
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77D60567C45
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5422D46AD;
	Tue, 15 Jul 2025 22:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b="Es1/l0im";
	dkim=permerror (0-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b="frj+uzZ1"
Received: from mail.adomerle.pw (mail.adomerle.pw [185.125.100.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7362D2387;
	Tue, 15 Jul 2025 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.100.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620296; cv=none; b=EF7elzKMNDO5n8LgRAGVieFQj6DGmuUIkiTAU0VcUd5kALXZTkB271ZxPtBOZdKmJHYU2lqKBKG58Wk4+rLxqjgqeESL3sDxajQUYLArbOfVFI6VRZcv5aS7ez7u6bForZipS7BZjDKgYRMSLL0CbUs/yeFw/zAXf5ZaSouRoec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620296; c=relaxed/simple;
	bh=02JHNErhpfJhyX8RCSwRYRITgS/5CHQ4G2ULdWQFZ7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WULEoxtFNoyeShxIZ+fipUd5vDAAM6UrQTdAwS7xf8WBo+gI4ZeD2VC1hBNaOAbawV80/fiMPx4uxu++rDALWRWJRzE2QgosO1Tl4McPdo6BwVY0QgwA3onzCE/cVy0HoRdPZ0XpPN5idt+e0Gk7NOsV+fFz072AVKalyhjZKfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adomerle.pw; spf=pass smtp.mailfrom=adomerle.pw; dkim=pass (2048-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b=Es1/l0im; dkim=permerror (0-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b=frj+uzZ1; arc=none smtp.client-ip=185.125.100.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adomerle.pw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adomerle.pw
DKIM-Signature: v=1; a=rsa-sha256; s=202506r; d=adomerle.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1752620274; bh=Z1c9KM3s7uvmjaAduy8hBIL
	aS8R/eb6us35Q5ePZprY=; b=Es1/l0imZ+MADVUXPGvIWU38SBGD735Xt8cKpRCgqkdnpD6KVW
	2+YdMD3s/pzQCU9MDxYTA8BoO+nMvtXVBidA2ztNnI34z9CPpYKjI7E5N0Vhq+wDxt8Zp0c5ODu
	0Hjk9/DNfxjr5Ofk2WIa2f/tI8NXZd+kJnQXi0QYmL9nDqSCtnDMnRKwtaZ4FVzAMxkOqp4NEBg
	lC/DHIEsX02+h5ThOyFFdulwkyzIoxn96wi9iyyDTzHSYWoCibAiz2DVORetF/VW7WNtc2+JGqR
	HlLMQgVDYirDXCmATSju6HJMDQcstW+lTE1kCNVdcDTj7Otsr1Q5pQhIHJIQg34E8Tg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202506e; d=adomerle.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1752620274; bh=Z1c9KM3s7uvmjaAduy8hBIL
	aS8R/eb6us35Q5ePZprY=; b=frj+uzZ1ZcH6Bon1HJxu/Nm7jjjmsLWcnm/KtdvX74j5Vp3qoV
	cxlp7/aZm9lBc+7qhZs9fwdMmPIOHhs1dGDg==;
From: Arseniy Velikanov <me@adomerle.pw>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Flora Fu <flora.fu@mediatek.com>,
	Alexandre Mergnat <amergnat@baylibre.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Arseniy Velikanov <me@adomerle.pw>
Subject: [PATCH v1 1/2] dt-bindings: soc: mediatek: pwrap: Add compatible for MT6789
Date: Wed, 16 Jul 2025 02:57:45 +0400
Message-ID: <20250715225746.1321-1-me@adomerle.pw>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible for the PMIC Wrapper found on the MT6789 SoC.

Signed-off-by: Arseniy Velikanov <me@adomerle.pw>
---
 .../devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
index 4737e5f45d54..b757cda1d32b 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
@@ -33,6 +33,7 @@ properties:
               - mediatek,mt2701-pwrap
               - mediatek,mt6765-pwrap
               - mediatek,mt6779-pwrap
+              - mediatek,mt6789-pwrap
               - mediatek,mt6795-pwrap
               - mediatek,mt6797-pwrap
               - mediatek,mt6873-pwrap
-- 
2.50.0


