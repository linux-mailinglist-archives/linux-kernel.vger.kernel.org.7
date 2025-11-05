Return-Path: <linux-kernel+bounces-886009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E16D7C347FC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753E8189FA99
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAB82D0602;
	Wed,  5 Nov 2025 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Ik68+Irp"
Received: from mx-relay177-hz1.antispameurope.com (mx-relay177-hz1.antispameurope.com [94.100.133.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2011991CB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.133.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331767; cv=pass; b=D0UcigQUFMZjqdHx8bF2QyxeZPWcJ269JhiaCFUArwV5ZxJsoDv94+RpjFvs3gjPi4flTi3G9bKJG4VCj8F+6qdHo1hsonWu4lazvF8jSf8BDjluBidcKlAMIbEyi9N5UhmoFMm7Qye6GT1tG42hq79EJDynrvciOETvHKPoGlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331767; c=relaxed/simple;
	bh=97ZxDtQ0n1JfB9JvPKPCcMdcLdBgllBUufOXYGcroo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Swfyz24FgnJLnSz32Vj2YTKPHO15IHKPSJIsapU3mnkKpfYjxjKLOCsO5Khlc+I75IVilK8MC3jm0rXBXsGymX4saEWEf6YNUCHVIqOzODrBOn7B8dCyg3XYBG7FKMrAGiQbgyoU2cXYzh/W8tHOQArUR4KcBJhocLzCdLYn9y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Ik68+Irp; arc=pass smtp.client-ip=94.100.133.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate177-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=M69bDo94SwBC5FFrocC4elBa/SG32/tKazGnJ/ycIZk=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1762331683;
 b=YlutfFfVnh1BE4qmGgmXPTZsqoBCZB1oe9rnRjRTODITxGX5PI5ZcdfvFWWK7Ik6b3g8abuQ
 b9C5Yuwj52sMl0SCmm+pxu71szEisSkPTaW9sEMwG8XTUDr+/aAlcph1lK6f3pOIR+Boc5/hdHT
 d9w3k9Fs4tpLSVmeHwG4qZOiMCYrIuPi/TCr+Tw6Z5wSEv4l52846L8B+4BdLNGvScqSdBuJDdc
 6b/KYqHuNFMAcCd6z8hW9O72LLZa1d2DawueJqPD9uaX7Hza8xFylfHaeU/JRP5VsLBWvkYJmTc
 u5vzACYzlsF/ZrlVCjhEtRzQufJWBz+w/uFmW5jQuSrSA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1762331683;
 b=S3Q4UjEZxeuJP0+DhEMcOd5Ei/5CKGiaiwb8pWZMw3i4Ogy4CDUUtSKIcsr5BPLFTC3Z1jlh
 h0ISRbbzEiU17K/vZ6ffeApD04n+21cjjp/1p98+roDseCse3SHCIgOeIryo681LSrCGgjZ3Op+
 UZgNXWsbZMcAlrcjAMmlG1pm0d645dMIbeVN/cftGyW8m5+trt6VOhWk6a3MzuUn1DKKxjquP6X
 qcfeFd7XTFyvMA60E74IsvBGhJ7+27CoYyEZL7IKrCCSdQhc/DhB6e/IPIGn5kMAhHzZ2M9iosX
 fRpv0KraZe7WOtxshLVE3Zoh2/ZUlbJT43p8qClm0WzMg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay177-hz1.antispameurope.com;
 Wed, 05 Nov 2025 09:34:43 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 7D195A4118E;
	Wed,  5 Nov 2025 09:34:28 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Tony Lindgren <tony@atomide.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Kevin Hilman <khilman@baylibre.com>
Cc: linux@ew.tq-group.com,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ARM: dts: omap: am335x-tqma335x/mba335x: Fix MicIn routing
Date: Wed,  5 Nov 2025 09:34:20 +0100
Message-ID: <20251105083422.1010825-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay177-hz1.antispameurope.com with 4d1dsd0w8hz3kgK6
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:ee6cc2dae69e292d8830ae36f3bfe5c5
X-cloud-security:scantime:2.208
DKIM-Signature: a=rsa-sha256;
 bh=M69bDo94SwBC5FFrocC4elBa/SG32/tKazGnJ/ycIZk=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1762331683; v=1;
 b=Ik68+Irp/eCu41NUbr51DttEDvvVBj6AM/TNu7ge0S1HjObkOJxdQWkGmEtEaywTpBT9Vqv3
 EPtJo7I9FyQLTPCNQX1bAKPK1NQDM1xBtQ0hGhfvtonNcgUNd8VDVeiW22e2Q3dumtz5X6lONTj
 J0iYSGm89LeW9c/Ufgjw0QT5AgnNi9LOZgTcCZ/g4zswwHU8hq5kBRjbVVM/KuaxxSFV9kziT5T
 b7QQdrP0mmfVJNM4CL5UGMkXN+e7KI5gSfINmPycUbeKM55h0QlekmPsNJScl5401/X8J7yODg1
 vyA+ux+IA0qepq7vKH2ZRBZrQ7cKOsXz6jqkV8h617jYg==

'Mic Jack' is connected to IN3_L and 'Mic Bias' is connected to 'Mic Jack'
Adjust routing accordingly.

Fixes: 5267fcd180b1 ("ARM: dts: omap: Add support for TQMa335x/MBa335x")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/ti/omap/am335x-mba335x.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-mba335x.dts b/arch/arm/boot/dts/ti/omap/am335x-mba335x.dts
index e51a8a17e74c9..84dd35aeb1143 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-mba335x.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-mba335x.dts
@@ -81,7 +81,8 @@ sound {
 			"Headphone Jack",	"HPR",
 			"Line Out",		"LOL",
 			"Line Out",		"LOR",
-			"Mic Jack",		"IN3_L",
+			"IN3_L",		"Mic Jack",
+			"Mic Jack",		"Mic Bias",
 			"Line In",		"IN1_L",
 			"Line In",		"IN1_R";
 		simple-audio-card,format = "i2s";
-- 
2.43.0


