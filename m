Return-Path: <linux-kernel+bounces-876218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7713DC1AF05
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59731A27B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8522C0296;
	Wed, 29 Oct 2025 13:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="O/2LALGz"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A689630E0FB;
	Wed, 29 Oct 2025 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744688; cv=none; b=Q5du04z0mX9VZ/KXqFCPJzPtRG4TfK+ugywDKoS1rrbI7TqQ4h8hiZFBMCTJWl5/mG5ilpg3uY4XkGntw2BDtMYTbd4DvqIRhQlOsZb3OaYaz+b8Vg3s92VJZq8lHJFIYImC6g2xMTdR+MOcWFIziqkYlQzD6VVvXamDF14C1Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744688; c=relaxed/simple;
	bh=SYraV+filwisiwS9WZRMVmfNWmZFChTE2AThFnhY42s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nSdFbje0Zi3LE14B+cP7HGvbgJML/Rp1cZbFnYRCdRQGELjT1Xe9W1PS7fBGWLFmt+J56A0ve2i+xd9WELKkW9B9ItJMmF0bi+3iGrG37sskYHvYuAZxEHurNkmq6odGWhdIqMw+VasGZvS8D+WnCelTQoz3YmFBCpxTy0L7bw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=O/2LALGz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761744684;
	bh=SYraV+filwisiwS9WZRMVmfNWmZFChTE2AThFnhY42s=;
	h=From:Date:Subject:To:Cc:From;
	b=O/2LALGzfg7bxSRYGrCSZcCKSfhDdWiHlzQcoMNRFwqXz2fTTP8Z+4fI9mErQAqat
	 wSHWQ4Rp8/9xwh6X9jODcZjSRa1S8H/W5f1rHkT13i4IjKx390DkuhEYHLyBCuDsxH
	 w8bb8tdFob3TxcgLK7UIYZbyHMSxjmijTBNZDc7Y2R1WpGfnL2klhu/GLUm1nLBPx6
	 cntcbzD8wCH9oqsF3WfuUCy7jzJ4/76FarnSJFe1owfgHiiZPrQ7BMqByKHsK096/7
	 O/9BO72dGF4GTpx8vkOonl9L0Nx1Gb2CWdb8yCiym7GGUjtsvzDMpPUFZkBKDDvF29
	 GNJG8MetriMwQ==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4ADEB17E1396;
	Wed, 29 Oct 2025 14:31:24 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Oct 2025 14:31:16 +0100
Subject: [PATCH] dt-bindings: spmi: spmi-mtk-pmif: Add compatible for
 MT8189 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-mt8189-dt-bindings-spmi-v1-1-fbea12a4ed5e@collabora.com>
X-B4-Tracking: v=1; b=H4sIACMXAmkC/zWNQQrDIBBFryKz7oAKgslVShZGp+ksNKljSyDk7
 pWGLt+H/94BQpVJYFQHVPqw8Fo6mJuC+AxlIeTUGay2zmg7YG7e+AFTw5lL4rIIypYZY3TO+qS
 TiQH6e6v04P1nvk8XV3q9e6BdI8xBCOOaM7dRFdob/iMwnecX0TQr8JoAAAA=
X-Change-ID: 20251029-mt8189-dt-bindings-spmi-cc5528d0d1ca
To: Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761744684; l=1085;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=SYraV+filwisiwS9WZRMVmfNWmZFChTE2AThFnhY42s=;
 b=8WnqoSnrc9pTeBpRP9VFPa2YNPpVTj3ItU6mF7Ddtv+37XFri9zChwAGjmvq8J9vg4J7MVY8D
 rF8S6+WTYw1CH47b43P5Pq6t57bGbRXP/elzLDnv3V7FX4RCQEETblD
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add compatible string for the SPMI block on MT8189 SoC, which is
compatible with the one used on MT8195.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml b/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
index 7f0be0ac644aa31d6c2a6be5981347473579ff70..dc61d88008a9c4dba217a8246d82bb4db88f33fd 100644
--- a/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
+++ b/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
@@ -26,6 +26,7 @@ properties:
           - enum:
               - mediatek,mt8186-spmi
               - mediatek,mt8188-spmi
+              - mediatek,mt8189-spmi
           - const: mediatek,mt8195-spmi
 
   reg:

---
base-commit: c9a389ffad27e7847c69f4d2b67ba56b77190209
change-id: 20251029-mt8189-dt-bindings-spmi-cc5528d0d1ca

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


