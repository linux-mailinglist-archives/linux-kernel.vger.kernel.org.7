Return-Path: <linux-kernel+bounces-793364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59542B3D26A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 12:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E553444259B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 10:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D2A25784C;
	Sun, 31 Aug 2025 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="sO0KwqQU"
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C710A155C82
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756637963; cv=none; b=sy1DxZHTI1sa6VQW+q7IrgEuZDvmQy5oH0Yte6hZk+5QLn9yww9xvYSGiWciezAOgxh3kcuJNrry4QVzif6JIN2emSupLMBJQ53Jiur2vl5WD8q55Ibr2q7VeWLdd5pDN3PHZVUoZnbOdINliEEb9GprOU3vQfa1JQNsIxvrcwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756637963; c=relaxed/simple;
	bh=BJEY9XNmUMmuoG2EnF2C4kDWrZVe9xasqzXacCqNAoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B6bkic9z2pKky8fjtIpMA6mA051UmkKzoDlY/4J1xyuaxrCC+K30LcE38K6BzN+0fRzRUsH5pN83gbdp9muQfLizGehiTbBkWC/ntxBVIJurWV6Y9Rf+jglJu7KZVD7zltUHKGrrpuA32PmYM44Gg/Dw6hpcOjwnXmsvemuQddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=sO0KwqQU; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 28424 invoked from network); 31 Aug 2025 12:59:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1756637952; bh=Att+j6IckEZGDZODDSPv+3ucwoae9zCiz41MbWlyFFo=;
          h=From:To:Cc:Subject;
          b=sO0KwqQUyAsrRQFWy+G9V7FRcABbCGMzea/9AlM9+nZT3WngZWo+vOWnZXa9Uz1sC
           nA0FkWYcw0JBW5GbIOHNzVJhh3ORblYVmYuMvZEMAsJcDCMv0YLHwvZAFVXDK5AiPN
           wA3NXxJnHLelgxnXMiyzxE3LvOo8ozvdUrWGnNAg8OMUQ2pRnaKOMd4P1/SbE3x02v
           8R5SHox2ihwL+qCBzvDd2g5ZXHCQF1McVcndV2YA1CK6ArmW3PlhUpxYd1hvSKs2Kl
           liP1rfaDv/SbfZdQh/gMqU9HxZOpq9sVDAMaSouynlmPXTA5YYn/plLquBKHM162Ve
           jTfBm2T7OUsUg==
Received: from 83.24.147.22.ipv4.supernova.orange.pl (HELO laptop-olek.home) (olek2@wp.pl@[83.24.147.22])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux@armlinux.org.uk>; 31 Aug 2025 12:59:12 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH] net: sfp: add quirk for FLYPRO copper SFP+ module
Date: Sun, 31 Aug 2025 12:59:07 +0200
Message-ID: <20250831105910.3174-1-olek2@wp.pl>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: b7efb9f78005ec06a94286c9b1e30df2
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [0cME]                               

Add quirk for a copper SFP that identifies itself as "FLYPRO"
"SFP-10GT-CS-30M". It uses RollBall protocol to talk to the PHY.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/phy/sfp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 5347c95d1e77..4cd1d6c51dc2 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -492,6 +492,9 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK("ALCATELLUCENT", "3FE46541AA", sfp_quirk_2500basex,
 		  sfp_fixup_nokia),
 
+	// FLYPRO SFP-10GT-CS-30M uses Rollball protocol to talk to the PHY.
+	SFP_QUIRK_F("FLYPRO", "SFP-10GT-CS-30M", sfp_fixup_rollball),
+
 	// Fiberstore SFP-10G-T doesn't identify as copper, uses the Rollball
 	// protocol to talk to the PHY and needs 4 sec wait before probing the
 	// PHY.
-- 
2.47.2


