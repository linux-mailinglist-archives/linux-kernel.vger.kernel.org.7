Return-Path: <linux-kernel+bounces-693065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643D4ADFA96
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 03:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4509617B265
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 01:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2480D1D9A5F;
	Thu, 19 Jun 2025 01:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="EN3P+erg"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6217A189905
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 01:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750295285; cv=none; b=pE2JRCaph8Pzpc+pn0lIJ/deKmK059k4T+8YBM7orgkeGH3//Kh3DuHD+0zXZo6gkWn0fx/PFYVKGn2hcZzVTKiBOMbLOnwZVN4nWGahhN3PGBqqiUm1RV/We6hF1CtGfHIDwWfe7Ioix82y9E89Ol8K5jpApG+KywYiWpZFius=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750295285; c=relaxed/simple;
	bh=MS18sacHJm5wYe0QMq5lKc+9jJ/K81eew7q6JBynOZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuSn4ZGDo9FbeKqvdShmky7Re/VXsy5RBOM7Susp+u1n8dPReFibxlb+0waM49M6UNMiWdAg+PCI8uBXlyIwUESfOMZ1M0oZn/iWpdqsgYwn9y+dd6Lv56oEXBvpXQcObsgozn0EnGi6SbM6wxM/IsWNz2kGdB63gAq9ITtLxEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=EN3P+erg; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 664462C0BB5;
	Thu, 19 Jun 2025 13:07:58 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1750295278;
	bh=6JmV8eEF9av+Sa6e/9Qv4UqSWGZRPCdM5w+0Gsi52gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EN3P+ergFsI37bvkitnLnCGP9tFjJWIFKulpyzrfz37csqluptZ4Z6rEZHy5m7BdG
	 5iJ6lX1NxMS/ZpShPKsJ5/lWm71sG+MPPj6pS0Hmyo5iN5/jyCtFF9ZUaUGU1T1gm7
	 pPORypf55S+glvjtADyZREdQx7UNPbbg7mC9a6Ya7Scst6AF3L46fUp/vZqkFH7Ixz
	 qQy+0QmgLW1yU1ohhdy/KC+ytXCFMlG9LKQX56XAQEYDiDeol/nKCCaEWCUANnPX5n
	 b6wKlk9xZOv5EUhMWSrTJDP7iA9IGzxOtZjtl8duedC2jcvujCT33W2l/a2V2YeW+/
	 mDEgJPx95j/hw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B685362ee0003>; Thu, 19 Jun 2025 13:07:58 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 088C513EE9C;
	Thu, 19 Jun 2025 13:07:58 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 08F6B280993; Thu, 19 Jun 2025 13:07:58 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: tsbogend@alpha.franken.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	sander@svanheule.net,
	markus.stockhausen@gmx.de
Cc: linux-mips@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 3/4] mips: dts: realtek: Add watchdog
Date: Thu, 19 Jun 2025 13:07:53 +1200
Message-ID: <20250619010754.3760612-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619010754.3760612-1-chris.packham@alliedtelesis.co.nz>
References: <20250619010754.3760612-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F7/0dbhN c=1 sm=1 tr=0 ts=685362ee a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=6IFa9wvqVegA:10 a=jdP34snFAAAA:8 a=Wqc9ATr8DmnQzDzGyroA:9 a=3ZKOabzyN94A:10 a=od6X62Lo79dmAcA2EqDc:22 a=jlphF6vWLdwq7oh3TaWq:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The RTL9300 has an integrated watchdog. Add this to the devicetree.

This is taken from openwrt[1] the only difference is removing the
unnecessary second cell from the interrupts.

[1] - https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dblob;f=3Dtarge=
t/linux/realtek/dts/rtl930x.dtsi

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/mips/boot/dts/realtek/rtl930x.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/mips/boot/dts/realtek/rtl930x.dtsi b/arch/mips/boot/dts=
/realtek/rtl930x.dtsi
index 74b30704f188..77a854034aba 100644
--- a/arch/mips/boot/dts/realtek/rtl930x.dtsi
+++ b/arch/mips/boot/dts/realtek/rtl930x.dtsi
@@ -142,6 +142,20 @@ timer0: timer@3200 {
 			clocks =3D <&lx_clk>;
 		};
=20
+		watchdog0: watchdog@3260 {
+			compatible =3D "realtek,rtl9300-wdt";
+			reg =3D <0x3260 0xc>;
+
+			realtek,reset-mode =3D "soc";
+
+			clocks =3D <&lx_clk>;
+			timeout-sec =3D <30>;
+
+			interrupt-parent =3D <&intc>;
+			interrupt-names =3D "phase1", "phase2";
+			interrupts =3D <5>, <6>;
+		};
+
 		snand: spi@1a400 {
 			compatible =3D "realtek,rtl9301-snand";
 			reg =3D <0x1a400 0x44>;
--=20
2.49.0


