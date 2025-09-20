Return-Path: <linux-kernel+bounces-825781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C078B8CCD5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A48C1BC1535
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 16:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DC3306498;
	Sat, 20 Sep 2025 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+AJHisY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD22FFF89;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385494; cv=none; b=j5y1t84h4DsEAdyX98rqgAj8XTxU8q4yAyGtIYUblRpeHjR5yJSpPboAdXlZrhEA4mQAgLlNH7LF/bqU+vQAgTKdjg3zw/KajYk8PA44QwJoKLr+Y08L+BQoHTce4L8mg36g64B60g+ju9ISL4haREqEQrDZghs+Udx1k3hZqA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385494; c=relaxed/simple;
	bh=toiotQoCuOHY3r8fjBEqFvdcaLzdfuNUoadqTtlC8VA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HXNdAo0NN7tsB67xmErLD8T7f+ZasSDCfvwWFOv0eZh6+w/456DXgI2V4yYGI/bF+YhqsLMdx1VpoENr+ohtHz4qtMjfiMKraQpqho6LXqHjc+KmVs6CByx3uETu1ZwESpnRzmw2/HHELxe0CCmpTIUniqTh9YWYrtGPO2DXueY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+AJHisY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FEDAC19421;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758385493;
	bh=toiotQoCuOHY3r8fjBEqFvdcaLzdfuNUoadqTtlC8VA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=f+AJHisYqErkJVCDWtIJ4urc/elhs9aKb6QExunwVTxnJVjUW21aX7uilFGGiKz2D
	 Ed76aB+KHrOgMBIdBQUw1jyiFP46x8GjHW5npw+F4bv8UMVih8R+uYxcaMEOyEnWvD
	 BjXOdbSRSOAy84R6Z1KACFYMAOzHJREDbtu89l9JfNg/2H5IZdQLwXxM1aAmdmdlpz
	 B+5PnpT7HPyIgUAEXDyYyCsWO9OcnZVELEBs8B8pYhfjNEPdl5q0J/CQ95UiJ/dAmo
	 xoi6czTzjruSWN+GGMqXCaqMuPgxeLpDwMA9ICaoQL4R9dMpL+sbciBR/rGTWYQjQC
	 DnZZMsWUPGAUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88419CAC5AD;
	Sat, 20 Sep 2025 16:24:53 +0000 (UTC)
From: Cristian Cozzolino via B4 Relay <devnull+cristian_ci.protonmail.com@kernel.org>
Date: Sat, 20 Sep 2025 20:23:34 +0200
Subject: [PATCH 09/10] dt-bindings: arm: mediatek: Add MT6582 yarisxl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-mt6582-v1-9-b887720f577d@protonmail.com>
References: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
In-Reply-To: <20250920-mt6582-v1-0-b887720f577d@protonmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 Cristian Cozzolino <cristian_ci@protonmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758392693; l=847;
 i=cristian_ci@protonmail.com; s=20250620; h=from:subject:message-id;
 bh=8QNDDRlIA0pWOB1+uvCR+bTE1fSSumhUEQ1GcGuja2s=;
 b=ecd6hSS6PNAV3+HGWu4LFm6ykdQjzGl4ilAIbSH3jsNcyh3dQc/hX/W9+goC+OpIwSEe4pPnm
 1wQFm/810XYBviG/VAjn3Fo3MgoMSoj7QP1agb12YM4DYkdCN2SAd7z
X-Developer-Key: i=cristian_ci@protonmail.com; a=ed25519;
 pk=xH5IvIPUNHV1Q8R0/pq2CfuVFR/wTiAyuyi6IwedjZY=
X-Endpoint-Received: by B4 Relay for cristian_ci@protonmail.com/20250620
 with auth_id=438
X-Original-From: Cristian Cozzolino <cristian_ci@protonmail.com>
Reply-To: cristian_ci@protonmail.com

From: Cristian Cozzolino <cristian_ci@protonmail.com>

Add an entry for Alcatel Pop C7 (OT-7041D) smartphone board, named
yarisxl, based on MT6582 SoC.

Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index f04277873694880d14d78acd39b6c9725394c2f2..5dce019cc998fb7498d7ce60afedb46011fff345 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -38,6 +38,7 @@ properties:
           - const: mediatek,mt6580
       - items:
           - enum:
+              - alcatel,yarisxl
               - prestigio,pmt5008-3g
           - const: mediatek,mt6582
       - items:

-- 
2.49.0



