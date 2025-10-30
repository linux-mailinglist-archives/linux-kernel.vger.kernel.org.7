Return-Path: <linux-kernel+bounces-878371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDC0C206FA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82671A679F3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D3726A1B5;
	Thu, 30 Oct 2025 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="fP7SwIlg"
Received: from mx-relay100-hz2.antispameurope.com (mx-relay100-hz2.antispameurope.com [94.100.136.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BDC224B0E
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.136.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832506; cv=pass; b=PtCbfPJ1j1qP1YpGH6q7FAg4RLpx1KF2dT52qL1iYSjuTxuKSa4qxbqrgnDf4xuWNi7p4DyXDRS6TvncXOOTLNxrh2q6ApAZ3Wx+GZSJ120R5NuJBwzaLFENcKuYk122H93WUAIwwRJv7CeSlyNq97hZrxCemyGy4j8nRfkS+zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832506; c=relaxed/simple;
	bh=EaVfQg/+QVSPAOgls27VI6muuvBs3u/FUZyH+/o1etI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuTJmFmZ8jIP2FJT6kHoiAmCJ+7su4TLg/T16287XfQUX9QTGn2iyLU4QZwuHRQg2PW7y1ZQ4jMpY7SG7R1qYJfuzEoSJK/NYzz5qUKPzYanYN9jzz9qzMb3XWjHcnz2U8MFvIP7ENI9j+QQhqI2/mRiIrqFdntu7mi2Y/dtS7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=fP7SwIlg; arc=pass smtp.client-ip=94.100.136.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate100-hz2.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=KEZFS4oLzG/srptDoN54vEJHXHS1Iew+xlKYXMZp3q0=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761832428;
 b=JnzJT5NKtrBPy2DXcKaWOyYgokxRjxoc/AvZT/AVxSUWnE1HWAwh8wqdKPrxlg8U+LCys3J+
 UAg2/a+bzVn7J5n1aygG3Co1B429l5H/Yv/CgFTnrIYMyGINr6Gg9tZ2qyyAu7aNjmt+6np4+i5
 S9nzqJvSU92wUp0NWcNjOdTcHuqAxtN/hljDPjmfyi8DRwzLZxOn2teVJr6Aj5RN6VsyAmHvrrv
 0I7y4s8sMqn/jiJ4WOGueAU8mgWAbxfag0i+P4fXuOtFsN2wiuHgj5ItYLYoGDmqYCKPB1SlTDx
 Mu/GGGlGVSz7m2hQF3Bj/t0EVwZLSQp8a1Ld/kUuf8P+Q==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761832428;
 b=L8Aa8/UYZktQtElLBQXGI2bIwT70Pj+LEiO8fzxoATkockVLgojh4EYyFBe2UmahyA818aU5
 NaOoBqdxDP/zHvd2a3I6Z6wrZsCWvqnxBa3K346Xu5VcE9lgFk6sGn5zTRtfu4JAaAucHmtXO6y
 p0g0KrMbKzKvHeh8I44JuLIAxMmHgRBPcf1erCgVvmZ0w/VoOYycoCBwKNeEgPcMOoQPMcd+uLO
 Roy4J39twznKDM/rBGBsUWpXOkqPNl2sqAJfXsp6V1zk2XLN/I2DTlZ7/dFg8HRheaG2P0M6HCu
 QkldsMHiL/IInwCwRCiJKPPQJcYp6Kc8QPFwcvu6qlZBQ==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay100-hz2.antispameurope.com;
 Thu, 30 Oct 2025 14:53:48 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 5CA0B5A0E73;
	Thu, 30 Oct 2025 14:53:20 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 19/19] arm64: dts: imx95-tqma9596sa-mb-smarc-2: add aliases for SPI
Date: Thu, 30 Oct 2025 14:53:01 +0100
Message-ID: <20251030135306.1421154-9-alexander.stein@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay100-hz2.antispameurope.com with 4cy5DW3sFkz3PJ21
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:a7bf318555c57f949278cf3d40d2a7cb
X-cloud-security:scantime:2.336
DKIM-Signature: a=rsa-sha256;
 bh=KEZFS4oLzG/srptDoN54vEJHXHS1Iew+xlKYXMZp3q0=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761832428; v=1;
 b=fP7SwIlgCJ19DR8tDssYEjigOk4tk4F3onB74JCEDxDfKl3A1QoveRIp1VSKv4QIRr57qqLc
 tlduISzq7exEAHGrSvbSP8S5W8tCUQHoiIRzIEbN8qBD1Yl6qXnCCxm0XEum2Ifu+UoJtPkFaUK
 PjNS8f/nevvT5dvM43M5QJM+xpRGduvuZE0OGUXdENEKmwJMncshmSG+l6GxTODglBh3Aku2Evf
 3UWKl2ll2hbGc5l+zb9ik2oSksmnEEBIMPX3CNnOFnjUWUQoskulvdpQid6D/pX1MKeTlT3br5c
 45pbkk40lSebLHvh5jLYaVa4P9YK9iixtvqfi9svrzRyA==

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

Add missing alias for SPI controllers.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
index d3a9360b8c548..97726eded0f86 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
@@ -39,6 +39,8 @@ aliases {
 		serial5 = &lpuart6;
 		serial6 = &lpuart7;
 		serial7 = &lpuart8;
+		spi0 = &flexspi1;
+		spi1 = &lpspi3;
 	};
 
 	chosen {
-- 
2.43.0


