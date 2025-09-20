Return-Path: <linux-kernel+bounces-825871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A023B8CFF7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 21:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8BFA7A96EB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C18265632;
	Sat, 20 Sep 2025 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bryanhinton.com header.i=@bryanhinton.com header.b="BmApqPn4"
Received: from outbound.mr.icloud.com (p-west2-cluster4-host10-snip4-10.eps.apple.com [57.103.69.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC5525A2D8
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.69.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758397942; cv=none; b=fWfWIBTo3z2rF/FFzfDFUEfHkUaLKLGkftM69UT/aW2K4y74j32ul+NkEvsK5nev1fE0mQ+Kg47uioayzneMaWu5XexuWCDZOUhzWYHU4NqfHR7aYyLvg/DJvbeTs/PCp5qlzzTjbPChdik8PJAZaRA9d15z1+R/muYjyHPN1y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758397942; c=relaxed/simple;
	bh=a3eS4LsaDgWxJX0nJZ5rLV0s3OKa8cAn/Cd//hvIp6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6C9s4RylE5k8FRCDYt+GTbAu+1go0wxv+ynNSGa2uk68351Yji3lWlZLDIaJS+Si9RhobTemYKitinwMuzyL/+7C+/FqI/u0XK5ejdZHrFr6BKfsWnNdqSdHN7oeOAAgNs5TOLDAG3Px5ZY+cNDwXDn4gNwKmn9bCAchxLmZFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bryanhinton.com; spf=pass smtp.mailfrom=bryanhinton.com; dkim=pass (2048-bit key) header.d=bryanhinton.com header.i=@bryanhinton.com header.b=BmApqPn4; arc=none smtp.client-ip=57.103.69.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bryanhinton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bryanhinton.com
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-11 (Postfix) with UTF8SMTPS id C36AF1806084;
	Sat, 20 Sep 2025 19:52:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanhinton.com; s=sig1; bh=k0SOWbLw84OBsxZriedsqK5hxUT6sNCYYaMQDUt04bA=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=BmApqPn4hfaWnHMKj6gYPoM85OiOogScwm6AguIcIwnwW+siyn3vxjZwzqFd37mZ6zDxFVsC3smPzr7ed+WvTDeqVDvI3ExzeI2XlkQKoo1ymJomVJIaSXDrWdMSMVzEN9WPc2HPnsXqBdpH0cNpiZqbvqyrPwCfdIMsCKnJddLz1+3j70Xwq7BWybuVQ4gOiCIb8YmKrpYntpm3BzZhk0v7FdcLM+OwKKnheV42YMLuwtjS3TxulFf3C5jNORoPIV8Ktcm3fUrGO1Y11NEzfqhBaY5tF/E8eRQuPOJNhb9ze0K+XP7yaxPUaGLzKtHU6Cy5uQlpz6Tl1mh3q2Ij6A==
mail-alias-created-date: 1643268037438
Received: from localhost (mr-asmtp-me-k8s.p00.prod.me.com [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-11 (Postfix) with UTF8SMTPSA id 40D1418001F0;
	Sat, 20 Sep 2025 19:52:18 +0000 (UTC)
From: Bryan Hinton <bryan@bryanhinton.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: angelogioacchino.delregno@collabora.com,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	matthias.bgg@gmail.com,
	robh@kernel.org,
	daniel@makrotopia.org,
	Bryan Hinton <bryan@bryanhinton.com>
Subject: [PATCH v2 1/2] arm64: dts: mediatek: mt7981b: add labels for UART0/1/2 nodes
Date: Sat, 20 Sep 2025 14:50:50 -0500
Message-ID: <20250920195102.2733949-2-bryan@bryanhinton.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920195102.2733949-1-bryan@bryanhinton.com>
References: <20250920195102.2733949-1-bryan@bryanhinton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mBhngQ9sjVFgcqTigtoistV_k-tujIkB
X-Proofpoint-ORIG-GUID: mBhngQ9sjVFgcqTigtoistV_k-tujIkB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDE5NCBTYWx0ZWRfXxFPJSD5OGktG
 UeLPBUNIy/S47Jzetf6J/BjxXzzzabI64GJPlhbXknJYYGl0J9fTCS0BFPBYYGtpGGTnOs6EXEr
 2ejUaLPloAWxnkVAs+0GjAmVg+LVc5aadIwKyFbr+xPaicpeXHMdyVuyMo8howBJs0g6FWndv7U
 vemQRI37sNJJS3kfG4pjmW9yu3EBlYGTZyFbLDbK3YnZ6hnffKb1JJEQuqm88o7yX5tqyDKCO+U
 /xiXVSh/LJkIh9HMZ5pONdulImxak/wo/C2jNXzDNscEJijaClG5bACFSWYjoLzXYkCvp9enI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_07,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=913 clxscore=1030 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509200194
X-JNJ: AAAAAAABU7elWgdKEGifIUerGrdz3AuEfJ8Sw9y2TUnmm3megRUveYhBf2WD2d1Lr06lEVapCSAcM6eEaaP8gfzAgb11lIDXu/aIyrr5WLmFQPDW/r0UocqP//VEbmxAveqC9de2SWEcUwxCZnrsl++7BiOiA0LwqEsyictdElbeJFZbGILSpDbFwmaV/sz8awy/dXUeG4V2LWvvXZO5IdphIJe4/nYTwV9AVXTVqEmiic51a7NE8HZENkwjppfE7Z5BF37EoATzGnhvxCAg9yAtrIhg+J4T/yzGDreA61wW3a23VGpHZUaZBCS8mB6MIwQJVxUGET4+Hu/3X0LfuCkowb6TVOrzlrxMdQJUPNUbCLHniHteYd5vqBlYOrUbxBKFTaSZQqL1R3CmVRvVUpmqbaZ/VMSyQbhDofKA1Ai6RxIFSPdvai6TG3JhezBylKInVX5GrgMQexUU42v1W+vU+9z2zurcpfzOOnTQ+ytY9UxqH0oj6t9rqbn68J3F5b2k0eAN9PVZPERUmmE+wUrN8WX7Z8gpPVb6iW8hS6/HuFRoLEMnnjfph3C8OVYNsD5Lh6Fi8IKsUMEZDvNzNwhJew7LrIPOvAYlIWi3fdZ+v7PBCICT2jy8RcJ+IFHu+A8nePdE80A4P9pZ94l1kvJ/amhePwQVCpB1Mb+ap/7JOq/1Ags1cSCqf/u5OYWhqUnL+FpOj6y5JcTVjO76xIQIOLnYe78DcZPbuLJEIaMuIqcaJQ==

Add stable labels (uart0, uart1, uart2) to the MT7981B SoC UART nodes so
board DTS files can reference them directly. This change is purely
cosmetic and introduces no functional differences.

Verification: Built dtbs and boot-tested mainline Image+DTB via U-Boot on
MT7981B hardware; decompiled DT shows the uart0 label present and the
serial0 alias (or absolute path) resolves to serial@11002000.

Signed-off-by: Bryan Hinton <bryan@bryanhinton.com>
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 5cbea9cd411f..4ee7fb83000d 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -94,7 +94,7 @@ pwm@10048000 {
 			#pwm-cells = <2>;
 		};
 
-		serial@11002000 {
+		uart0: serial@11002000 {
 			compatible = "mediatek,mt7981-uart", "mediatek,mt6577-uart";
 			reg = <0 0x11002000 0 0x100>;
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
@@ -105,7 +105,7 @@ serial@11002000 {
 			status = "disabled";
 		};
 
-		serial@11003000 {
+		uart1: serial@11003000 {
 			compatible = "mediatek,mt7981-uart", "mediatek,mt6577-uart";
 			reg = <0 0x11003000 0 0x100>;
 			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
@@ -116,7 +116,7 @@ serial@11003000 {
 			status = "disabled";
 		};
 
-		serial@11004000 {
+		uart2: serial@11004000 {
 			compatible = "mediatek,mt7981-uart", "mediatek,mt6577-uart";
 			reg = <0 0x11004000 0 0x100>;
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.51.0


