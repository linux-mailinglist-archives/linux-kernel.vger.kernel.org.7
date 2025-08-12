Return-Path: <linux-kernel+bounces-765005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB6BB229FA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7CF564DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E870F2D4B6F;
	Tue, 12 Aug 2025 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="RVfkO8I1"
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F060285C81
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007586; cv=none; b=Ncxy6xczczrM8HIy3HEKXoBTijWVI3kLa8wDyb9W2SwgWUK7VewEa/lL9VVkCJjuC01gPh511LXEMhJwiEBAvK7Ks2dFEkS4UBaeVndAIA8P6h+mxoGI6ppD/exRQgDJznz2PBcuP62fWpguboctBA8TAbLikQ6C5uXdlBqNre0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007586; c=relaxed/simple;
	bh=gv54/UhyYxU7/160wHwxgnOOXa7EI1hmdhGIJ/nTmF0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ubN0qB14wMo82GGPByw+WtTRVVRn4ptdPSBY8CX1mJHU+3frloOUq15JWpgEFbR4srOVyr98U8ZcifnH8PNdjKxX48qiRzG99iY+3Twal0+MXJIe1J2+wRDsqRuIypnqGIJGXg3LhgSzsO0RIw1GrgRyytY7VaLFtK51EVjU+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=RVfkO8I1; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 37806 invoked from network); 12 Aug 2025 16:06:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1755007574; bh=8+NRamZyzJl3Hb9e7l0RqXmfgcgtdi2vp3O5N1sGpwA=;
          h=From:To:Subject;
          b=RVfkO8I1Gk+FwtCm24Qr2ZmnyETldEqUO1xnA/qRLYb9YKx42MpIqFC/Vpk/dNMwl
           fvbbrSmf0EhHC+BCWPBXy3PZZ892cLwhNzBRv7+V5gR6v231OVCgr760PYRCfSsUPD
           bdRxJRYEnA6Y0tXohUzet1XgO5hVuJ/T/AEIoG2qQz4sjsxWZcMGbPOS8ehSo2utE/
           32bO+YzhG2FoKrkChMTgadCd+/XhsLBsI6JaDiAkTq+cnC0wXxRVQkyqGokiDVsu74
           s1EVHbJb/MPsRSMnKPRlKdnc69o4pU455uGfsSD9KUqCRoMKrvywG9B7/0PYzfzPCK
           2JGTj+gEMNCfg==
Received: from 83.24.134.210.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.134.210])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <robh@kernel.org>; 12 Aug 2025 16:06:14 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	tsbogend@alpha.franken.de,
	olek2@wp.pl,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mips: lantiq: danube: add model to EASY50712 dts
Date: Tue, 12 Aug 2025 16:06:04 +0200
Message-ID: <20250812140612.990460-1-olek2@wp.pl>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: e0be6f8dff75f897bc9bff45db674e9a
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [YbPU]                               

This fixes the following warning:
arch/mips/boot/dts/lantiq/danube_easy50712.dtb: / (lantiq,xway): 'model' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml#

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 arch/mips/boot/dts/lantiq/danube_easy50712.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/boot/dts/lantiq/danube_easy50712.dts b/arch/mips/boot/dts/lantiq/danube_easy50712.dts
index 1ce20b7d05cb..0c60584092cd 100644
--- a/arch/mips/boot/dts/lantiq/danube_easy50712.dts
+++ b/arch/mips/boot/dts/lantiq/danube_easy50712.dts
@@ -4,6 +4,8 @@
 /include/ "danube.dtsi"
 
 / {
+	model = "Intel EASY50712";
+
 	chosen {
 		bootargs = "console=ttyLTQ0,115200 init=/etc/preinit";
 	};
-- 
2.47.2


