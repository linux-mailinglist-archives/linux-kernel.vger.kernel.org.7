Return-Path: <linux-kernel+bounces-893029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87A2C46636
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4433B8BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EB330BB96;
	Mon, 10 Nov 2025 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="A7/UqIG9"
Received: from mx-relay49-hz3.antispameurope.com (mx-relay49-hz3.antispameurope.com [94.100.134.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9341430AABC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775467; cv=pass; b=s94MfB64LE2VkaFiXsevpjUoIxmrWdS5j6hVOQt4pQxKIk+8IrTwPOR62C63qGGPa6nIrQRLl/kkTxxXJwyenYP8kwUOZ3zjlsQsIRXH2IKboZB5vKqLsn+PJL4pNfIP4S61R52kyBJHbKAAiyzYfXe040nSu1tr6Ovhi5ag19M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775467; c=relaxed/simple;
	bh=HXlBxqOb74Fg5Giay0IgvqZHwM52eaS13jG1nIa4SVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdSc5QSZyys4CvOgML23kmApFdxAhOAMDlYeABsECuIjgZDRzh54QCEEHEci5h14o5+U4N57Hw9sbmy1awUjf92kjBS59ZCdpXSG6CvqRLy9t/bvy+wmHlvF0CQa5kHtsffwg/0hAW0emUNUINR7+CdiV3SV4094YzNtaoeev+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=A7/UqIG9; arc=pass smtp.client-ip=94.100.134.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate49-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=EI3VncdrDlFCBHgHP23iIzteEuQaU2FWB5CYdMi6Jhs=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1762775423;
 b=V6ud9Z0B2Hg6xyLjrvV2EQyrYgjBmVJSnxPJOH7T3J2AAzyXZxDO16SXwVGdT/Nb/DBbfCYk
 JY67H7/iOIUVzhCAgsrgVLLUOez8qH1VcxIdXuNb+fnV8Fi5hKkT0Vsxm/7t2EOK2MA/oeeRcZz
 MAVBRdrDVKH2yONjIc2YIGs7cmoacBlXcC18CTtxI3bHgh+TWMT8Gl87MM8OGiTqvFbIE0NH/CO
 KXScBFgQNIXTKdX7ELHDhJANaOLv6htOOtirNSGthf+kwGOICSFBRL93rTK/YyX4ryMrLUs8RYB
 vhq0pKhNLgOr91S1ojLL/yOs9LI3E1coAwa1gq6Q47wKQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1762775423;
 b=oiUPzF/MJfxoA+nrTMnvY7xws8DDgzEN58kdm8hb8WPH6m014Uvj91S1gaWMnG5XfHdrbP4c
 WrDS01DzcHrHLlI/7iv2h6+XnF1saNhVpInOZ/VIXtSUM81/X4gh5t8H6u9AgNHAN4JVKbKMBUN
 XKuWE55EorjbbwJGhTM55YfCa8JEx/2c8mc9ykZ8LaPedbFOOJWhTlU5/PLJhEGdUlHLmdQIo/e
 vO+XT9RAORo/OD9VFigfjgJVQdtdAlbI23wrMS9Iz6udIAl4UuDJuPj/ia4+FKSdXwepulGaHh3
 vr4i4DLi1RAIPvzb3eJsPSStig7WeFXZOk4gr0gUwGkpQ==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay49-hz3.antispameurope.com;
 Mon, 10 Nov 2025 12:50:23 +0100
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 57E2FA40F9D;
	Mon, 10 Nov 2025 12:50:06 +0100 (CET)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: ti: Add compatible for AM625-based TQMa62xx SOM family and carrier board
Date: Mon, 10 Nov 2025 12:49:45 +0100
Message-ID: <18471e4c907e8681248776e3674e22075e25a50a.1762775119.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1762775119.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1762775119.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay49-hz3.antispameurope.com with 4d4nz31Pkkz3yYR4
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:4ec77760357b01082a9b811132bbae09
X-cloud-security:scantime:1.896
DKIM-Signature: a=rsa-sha256;
 bh=EI3VncdrDlFCBHgHP23iIzteEuQaU2FWB5CYdMi6Jhs=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1762775423; v=1;
 b=A7/UqIG9uKCMOAc+2RMdyhEBxqwfHJGpW50OfDZIHLTB0lLIOT5Qrml6/dbazwl0RxJ0G96J
 K1J+Rf3TGF33bKCC2U8nXKa5G+7vMEJUS9CjDk4kKEcf0LRHEl9bfrNFHDOQeVMKsKdhjRF/TKf
 bbWzAEfJgncNoLspIWySjB75LBD4svB4ytlnflo9HMU/nDwNXRW/BPF4nQJ+0pZKa1FPFFU+Ppx
 LC5nrkfZrAXhAl6l4JIjhcAfI/GOwClAI/taHt0UdmHYk2bfM/exBMskzEbYo2sWFrWfhFZqNlG
 siLIIOl2BncXE0kyUGrcDRrpUuGsICe6ZEzsGyC7vZ8Jg==

The TQMa62xx is a SoM family with a pluggable connector. The MBa62xx is
the matching reference/starterkit carrier board.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 2e15029dbc677..cfa158dfdc9cb 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -89,6 +89,13 @@ properties:
           - const: toradex,verdin-am62          # Verdin AM62 Module
           - const: ti,am625
 
+      - description: K3 AM625 SoC on TQ-Systems TQMa62xx SoM
+        items:
+          - enum:
+              - tq,am625-tqma6254-mba62xx # MBa62xx base board
+          - const: tq,am625-tqma6254
+          - const: ti,am625
+
       - description: K3 AM62P5 SoC Toradex Verdin Modules and Carrier Boards
         items:
           - enum:
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


