Return-Path: <linux-kernel+bounces-630463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 303ABAA7A8C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 22:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E894C72C3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 20:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4CF1F30DD;
	Fri,  2 May 2025 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="CDSfpHGf"
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD0219049A
	for <linux-kernel@vger.kernel.org>; Fri,  2 May 2025 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216270; cv=none; b=VbjmHoa1bMPAE1/Osy1BDNIvGDSJV5qtG4z9X6Y+FfQtSAqY4rRocX8SUG9Vmfs9N9YrWvyMpy3HywFjel33eOMV839lXPimYaSbHosSU1DR7ZwGcmo4DuHzZ4pE/w+OXZOtA822FhGKct86caT9HQW5rfvBUd2Vbk/p7+vIYBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216270; c=relaxed/simple;
	bh=Ytm/GvlCXo1rzdBBm9nHFFC0YSOj7VcNOCaaHJVVRPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hz1OPWEossQPtXjULb5UlRGx4rag2cjvPNSl7H5glCkJQeWSpmlgGeBoZv6WDzkr2h3wk+9UyttkIOtasBoODgTqZEIO5j5LuMySpuCEOMEB8cwroWB06lGjgpgTz358KGWNDzyyHkn8AVbcdtB3W5rV3eelooYknvyDPham8j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=CDSfpHGf; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 49005 invoked from network); 2 May 2025 22:04:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1746216265; bh=4uXnc6THj5050EedKYJrhkloNDi/wDIkoo7Dg956Prg=;
          h=From:To:Cc:Subject;
          b=CDSfpHGfaGKtlC/4IzyxCtgJ0uTMLbyNgLpPMEEf6pdEf0Tn2XmaGl8IL+wqfVqQD
           je4XRQ7g4HufICG1uhzuszg0fWIFkTGWBJaLYs8sTD4u5OCPE+3+72F4ZX4UePaYV6
           6WT/THtxfY7SjSL4DtXn7BGsHr23Cilcp6M8jvs3TLDO7V+C38Id8NOLjDMmE7ln35
           EcMW0bF4DF4ckbVX21AvyOxq9wZCvu3dWa4j7PotFJhNK2EjSFJ3ouTCcrLWRA2Bbu
           mLLZZzK+FvVy2pl97TDjh7cjNn/NhHtyAfZ6bnZ3NegS5vvXo9i+TSPOajf6MGjfDL
           4+IsVHnOENK7w==
Received: from 83.5.150.21.ipv4.supernova.orange.pl (HELO laptop-olek.home) (olek2@wp.pl@[83.5.150.21])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <johannes.berg@intel.com>; 2 May 2025 22:04:25 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: johannes.berg@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH iw] util: rename hz to Hz vol 2
Date: Fri,  2 May 2025 22:04:24 +0200
Message-Id: <20250502200424.3492403-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 44d60f18ebb128d826032c567aa0246a
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [wfO0]                               

In most places, the Hz unit is used. This commit changes
hz to Hz in other places.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 util.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/util.c b/util.c
index c6d5974..1ebb19e 100644
--- a/util.c
+++ b/util.c
@@ -1630,7 +1630,7 @@ static void __print_eht_capa(int band,
 	    !(he_phy_cap[0] & ((BIT(1) | BIT(2) | BIT(3) | BIT(4)) << 8))) {
 		static const char * const mcs[] = { "0-7", "8-9", "10-11", "12-13" };
 
-		printf("%s\t\tEHT-MCS Map (20 Mhz Non-AP STA) (0x", pre);
+		printf("%s\t\tEHT-MCS Map (20 MHz Non-AP STA) (0x", pre);
 		for (i = 0; i < mcs_len; i++)
 			printf("%02x", ((__u8 *)mcs_set)[i]);
 		printf("):\n");
@@ -1644,8 +1644,8 @@ static void __print_eht_capa(int band,
 	} else {
 		static const char * const mcs[] = { "0-9", "10-11", "12-13"};
 
-		/* Bit 1 corresponds to 2.4Ghz 40Mhz support
-		 * Bit 2 corresponds to 5/6Ghz 40 and 80Mhz support
+		/* Bit 1 corresponds to 2.4GHz 40MHz support
+		 * Bit 2 corresponds to 5/6GHz 40 and 80MHz support
 		 * If no Channel Width bits are set, but we are an AP, we use
 		 * this MCS logic also.
 		 */
-- 
2.39.5


