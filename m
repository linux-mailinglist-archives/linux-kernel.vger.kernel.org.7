Return-Path: <linux-kernel+bounces-878363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1035EC2065E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EA754ECE8E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AEF226D0C;
	Thu, 30 Oct 2025 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="h2KWcmnV"
Received: from mx-relay73-hz1.antispameurope.com (mx-relay73-hz1.antispameurope.com [94.100.132.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FE2194A65
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.132.237
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832436; cv=pass; b=f7RFShhXMaQGTTGixsJfgPlz1YisAe9jZ+ZOxNf9S705vrRj+Hy1xIHcA61Uvr7pGJyrvS9np0k8esW5zVwb76/27ml8zJRqHts6x5y/eC6COQ8aQxJLVcm2VS9Sox3cZSP3mXU2MkHHCNR+M+wJ6pRaAv6oz/DjbESLPxpg/nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832436; c=relaxed/simple;
	bh=tJrQacF40a7gkfl20Qlli9OSH8A6qFFlTzAw0DY/ick=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cgn8iGPZZndiqX0uiQSjLDUvqUpR67arjCBv/PUuF9/4oLLF+cpU9bnPOO9Il4iTILFdWA4l2T8UXAoVO7OgXi8KUnl6xUBRd3HInFSCIb7qraZNACkA/03CrFQTu1BZ93rZZuNuk5tWrW4tS1BlnTV9GIIYeTEYNiRujvph6M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=h2KWcmnV; arc=pass smtp.client-ip=94.100.132.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate73-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=WrjQJJxL5a0An32raO9r8CtscWfKA5mlsUuQyxrLoQk=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761832425;
 b=Cm6r74ggMh44YOkq5/tIZwHQTkQvXzrK2NLgQ5MIeq+U6pIKX/E65HA8V91rxXIxQ2iJ9+rf
 7uADujmASHaFVvqjmmHn+A7dmpRN+b3u3Vr2IxyYYjfccnTWVdyS1uS8AWxL1l6mpQsm6X8rnOl
 HCUdbKAPA6hcOOb00oknFZcr7/O7olfEANDYEKq0rijOR4eHg/hkGgsAAyx+NkcuOwyECEYfOrT
 JyTWyVmsZJvJwkFcevinlL/qNWuApim3HDyZTsuXIBOYkuhh/sGBOThU1VS06cNZCQHpgJxE+tX
 xgJbZSCrk5QKTDE5RXqibpX0gFzG5Lfk7fPrxGDHj12mw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761832425;
 b=HC+/Qf225KxzH17RHqBz58R/0y9fLh0Yw9Y6NfVpebZGWJZdb/cjzSBPPVwnBv2cREGLfWyh
 nBq3yFGbQkuQJBEteCB20rtjLnrfX/StpQytURy7dnMXCyPAtpQXkoFoBHlXPN77p9gQVHC+zEc
 7sYPctmo6EFiRSIvv3jC3GhPxx3YEU9Vj9w26J9bMvXM4Z7FFcKCQUrJzPgvV282sPznU3hZ9iQ
 55k7JtkJBHO8H42+Nz49RwySM6WSF8YdDiLThqMWowTbB8b0wDF9toAiFWqKfFyQtbTeryJt8Jt
 W44Lu4CjS/lUVg+eMeugph2a5IvbvV9Jk3KsGduzzTgJg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay73-hz1.antispameurope.com;
 Thu, 30 Oct 2025 14:53:45 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id CE8195A0AF8;
	Thu, 30 Oct 2025 14:53:17 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/19] arm64: dts: imx95-tqma9596sa-mb-smarc-2: mark LPUART1 as reserved
Date: Thu, 30 Oct 2025 14:52:59 +0100
Message-ID: <20251030135306.1421154-7-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030135306.1421154-1-alexander.stein@ew.tq-group.com>
References: <20251030124936.1408152-1-alexander.stein@ew.tq-group.com>
 <20251030135306.1421154-1-alexander.stein@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay73-hz1.antispameurope.com with 4cy5DV2Rr7z14YKb
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:adb5c744a6af74ddd2c8a6726a431f2a
X-cloud-security:scantime:1.676
DKIM-Signature: a=rsa-sha256;
 bh=WrjQJJxL5a0An32raO9r8CtscWfKA5mlsUuQyxrLoQk=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761832425; v=1;
 b=h2KWcmnVRcLodii6EIU/wcaDPOK6blTyQBUSoh/R7RsOE4M+wdAXkD2kkJ11eLi1TpayaVQJ
 8BN3vV5Eu76phd0XjFGI2/djahe2JOdrVkSPApmaNT8ukVN08yVc4yjBM2OiuFF1gxkOqQsu2gL
 p5l346iMu/bXzhTWsycdts0ntjZXtFAdRPCvi5m8lbEiAXrXKw527T5siiKlz/a5EgPg5/q4R3D
 V62o/KSeNvsTEp//qghKt3g+A6D9NJgeRVbYflUv1DGYx1iVd+r0LeCQgMI2/d1m0Zt5JDVcvnX
 3pfWwiDWe+jeXtp82YmcL3LJmSFPJaHiyznLGrOlA1mXQ==

LPUART1 is not disabled, but used by system manager (SM) and should not
be used by Linux.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
index d1c3d55b14469..15d117d785445 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
@@ -212,7 +212,7 @@ &lpspi3 {
 
 /* SER0 */
 &lpuart1 {
-	status = "disabled";
+	status = "reserved";
 };
 
 /* SER3 */
-- 
2.43.0


