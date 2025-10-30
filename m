Return-Path: <linux-kernel+bounces-878241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5D8C2019D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239D83B8884
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439C3355056;
	Thu, 30 Oct 2025 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="EThJ1/nj"
Received: from mx-relay172-hz1.antispameurope.com (mx-relay172-hz1.antispameurope.com [94.100.132.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A865B34402D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.132.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828668; cv=pass; b=mRvzch4KylSvfwHqU+kmHrfLm6CB0oLIjB5i1BCD55t9K3qNBFfqR+KYaP+LoKSOhXU333XAvWpEbX2h5hiUuZ8ClmGnsyGX59AcrPUa9xBUMk8QX/g+/+4+3dJGik4D2R1ylLDJEPi8nBq+lUUvEjtpfajpS9x9o8lP2/yS/+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828668; c=relaxed/simple;
	bh=SBO7GNLcfMbKloOhhNir70H2TF40KEEU8NLb1BkwWh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlQW9EpPBE+E3YwnCEZZJNgXVmOj3Uw0M5K5UDL2iEb9BjXkL9ErwBCXCTVuX0fSEAiisWDkQX8pHlwMYkce/2vJDGdPUEAmKVpfB0MknaQVYNbat81s+JRFgHJyQQ3njA2Kn3r03o2P0CueboroNcC3oNkah094E/L+JCTdb3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=EThJ1/nj; arc=pass smtp.client-ip=94.100.132.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate172-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=yQrnZtKYkTmoOqZMGCIOD6/kHXaWhNyn+TUU1owbG/U=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761828610;
 b=PGy5YfA052EnINpW+nfdFoJfXxK/xiAUsT1v8pHTpw2LsoVS8gpmeXOj7B5rTg2Y6HrCIMDl
 hf4ycLXOCZIrlYw1aHBAlA1gWprs59IPw5zmzWE9QNwLs4kC3dTrA2G45oEMfd4bIBLS9MSz3UN
 YPfJdkCRx2s9/jl51pxTYIhYgh7sz1RrlURSxeqmtuiZpJX1bIycz4eDtKLhwC8h8ERtfvCNez2
 wYsY3DtAUR7u/9o0bExk53OzT6joFNJ2wekNQDLMaSH6QmR0kTtones9JLxnQ6yuZFqaHZ7wh6l
 PFUSN0OdlToYWSZ1dhqpaTD+3MuGRyKYP+DUaUxmskTKw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761828610;
 b=L/gIO+XiiprKoFwlLy2S7txxY60/8r4tyLzII15sAsLyUcir6AwWCc97t99PbLPwi3FluYo+
 0ytWT2UxhGkGiWYQIVzHGOYYxg4ElYXvK7NAHq1+f8wtoiBb3BV+reHp2vVP5g29XEV3mMSv15W
 VNHdE/KWnlhP8jL205EuQZopBHDD5MFhEqdx9SYqkEB1agWH1lxIpMjKZVqYQf02IHzaCU3t1TP
 hWeWEfLV21Nmj+WywXzss5ldWee+lo1/kh8BE/WULbO+5T0+IlBXCCcSKLfok0xHJ6JivKRnQfZ
 +Cxm4iSbWx5+gVAJndEtMj7r9hUqWW1X7RwC9emfu7wjw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay172-hz1.antispameurope.com;
 Thu, 30 Oct 2025 13:50:10 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 9E58A220D24;
	Thu, 30 Oct 2025 13:49:52 +0100 (CET)
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
Subject: [PATCH 02/19] arm64: dts: imx95-tqma9596sa: reduce maximum FlexSPI frequency to 66MHz
Date: Thu, 30 Oct 2025 13:49:09 +0100
Message-ID: <20251030124936.1408152-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030124936.1408152-1-alexander.stein@ew.tq-group.com>
References: <20251030124936.1408152-1-alexander.stein@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay172-hz1.antispameurope.com with 4cy3q51zVyz1Z1pc
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:22167396eefe238fc1584f087a1c054f
X-cloud-security:scantime:2.247
DKIM-Signature: a=rsa-sha256;
 bh=yQrnZtKYkTmoOqZMGCIOD6/kHXaWhNyn+TUU1owbG/U=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761828610; v=1;
 b=EThJ1/njS/OT2JibbwytTeWt+PdR8KzPumUP8gMhSbX53esbXsiqQXr2fGjoL18aAmJ/L4S7
 5SnS3rTfg+nJAySyYRPIwD+y/tWcEiqs6ANzo1+SurrjYZXcf5mmRwvFikQyAOewMge1cyz6c22
 4/GOQNK43JVPjpipvCoQhZ/mG9elKLdKpQB8/mhSxHk3SPyYFWGLxcYG+wQ/UFCqIwDuS6l8fKT
 xNBUR8vme89fe9QMWl/XhFthQ7qMHIv6VboWuyvaBZGv6IQPsX9ZqCd3gtLr3URy7pZBnezfJDa
 fmayu2AC0ArkL9gA+BMP3Wa88tMj/XftaX6y5yp4E+C2w==

66 MHz is the maximum FlexPI clock frequency in normal/overdrive mode
when RXCLKSRC = 0 (Default)

Fixes: d2c4d71b6cde ("arm64: dt: imx95: Add TQMa95xxSA")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
index c3bb61ea67961..16c40d11d3b5d 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
@@ -115,7 +115,7 @@ &flexspi1 {
 	flash0: flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <80000000>;
+		spi-max-frequency = <66000000>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		vcc-supply = <&reg_1v8>;
-- 
2.43.0


