Return-Path: <linux-kernel+bounces-833868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4F1BA3416
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8DF8624B41
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FED629DB6A;
	Fri, 26 Sep 2025 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b="q+LphQTY"
Received: from mx08-007fc201.pphosted.com (mx08-007fc201.pphosted.com [91.207.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FAE29BD9C;
	Fri, 26 Sep 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880415; cv=none; b=ao0EI96YWmrmA2s8ttFim8MYAFGVW7tAIHLoH4HS2fJkSU4U8/YGBzuSA5VDvNZtEox3rMcS2/DtoIJeXL6Y8ltmeU1KtiqkTs7CZ3Dal69hRLJwa6U+sVzsaqMz9dXZ8EI4kKSlCc6WiiXII9z4WhOBNj67bNxSohtxHdcOjoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880415; c=relaxed/simple;
	bh=en6d0hHij2irk5zdjFbgBYlwcpYdNB6CNO0zPbcRDTo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XO2UtVHrJ2tU2qxJelzxOX4qZWxPmQaf2IPvHQO64pVXUkM/mbFa9l4jr7WLbxw+gepO/G/tr2KqJo25Ztofkb3CSh/7Qw6HHcARBdLQDTxPSB+jvJRqbJfx4nUMFgiOAZJ8C3ktLkAUZeYG+iVE2gDfkBbYNvYKpj2q3CMJrqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de; spf=pass smtp.mailfrom=cab.de; dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b=q+LphQTY; arc=none smtp.client-ip=91.207.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cab.de
Received: from pps.filterd (m0456229.ppops.net [127.0.0.1])
	by mx08-007fc201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58Q9rRG61799306;
	Fri, 26 Sep 2025 11:53:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cab.de; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp-2025; bh=6f5Dn/r0RoMlQHj4h9qsA9M1
	+iFwmJ27lr1yK8Qj0xQ=; b=q+LphQTYERwfpUpZJbovDZLrtPmjOqctnFSiEAN7
	SXrWB8XM/TTQJno2D+hyuSaBOIprKf6fqWMEm7S91aBtLGslx/5UZ05F/AcvWzfv
	spbGtWufd9TQRfdaG0bu97JpTI6O+keF9qMfQFCQYg7oQYO4bpeA6eu8A7UWRSCT
	n+R6mHatJX9ktYLEryyeWbGQ2t9j3Oe+RTCnVxJEFmBFsrOQFZmkPAe1XRC2gvpZ
	oWyUho9DMv6m8CMIULjK3JmHrw9SyJj7xc+gvT5WpnooI5O9kRLjxTTPVc05ZJFl
	2oLUc+BNE8XbtZs+WrkOrJ6T1nFBIBk7skDaMaLgbZ7ckw==
Received: from adranos.cab.de (adranos.cab.de [46.232.229.107])
	by mx08-007fc201.pphosted.com (PPS) with ESMTPS id 49dbt4g7ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 11:53:27 +0200 (MEST)
Received: from KAN23-025.cab.de (10.10.3.180) by Adranos.cab.de (10.10.1.54)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Fri, 26 Sep
 2025 11:53:43 +0200
From: Markus Heidelberg <m.heidelberg@cab.de>
To: Jonathan Corbet <corbet@lwn.net>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Markus
 Heidelberg <m.heidelberg@cab.de>
Subject: [PATCH] Documentation: fix spelling, typos, grammar, duplicated words
Date: Fri, 26 Sep 2025 11:53:12 +0200
Message-ID: <20250926095312.206231-1-m.heidelberg@cab.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Adranos.cab.de (10.10.1.54) To Adranos.cab.de (10.10.1.54)
X-Proofpoint-GUID: 9L-v39hh5XHxr7_WQEpejG_nIjRSrav7
X-Authority-Analysis: v=2.4 cv=XdWEDY55 c=1 sm=1 tr=0 ts=68d66297 cx=c_pps
 a=LmW7qmVeM6tFdl5svFU9Cg==:117 a=LmW7qmVeM6tFdl5svFU9Cg==:17
 a=kldc_9v1VKEA:10 a=yJojWOMRYYMA:10 a=AASUXlr5cEY_NRS87wIA:9
X-Proofpoint-ORIG-GUID: 9L-v39hh5XHxr7_WQEpejG_nIjRSrav7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDA5MCBTYWx0ZWRfX5Xy9XAxMP+Ir
 ZCx7nBIuZeybl3Fora3vRG0yvbH8kf4BtNli6ySkApkcOXflnQcyHuxh9VNCADLAlxLftDGENDV
 QF75TrX9RTCtNqm/C+MaHRRMCN1XR4BSKhNZs6tJ5VNT54Yr4viaCyo/P2kan9cBHGSrmp6/tnK
 iy8R+1rqUZvSFrt/RjNbgBH8bQfrCcsT/rp8dgWt88WPHBtniHDgxogWWmX1g4Yj5LelinEsNqI
 PxXsHjBXuEpprpTh6upnrRP8wlm/GHs26BtCxJvHc/ZAsh30HlcO8r25EFUGz9GPGoiwyap/BbK
 D90xtOAMvdlxmoqOqfoU9xwj9mPLUOcxaD8ISBuPn8BG7KMHQE9Tetj02Esp945xJZdNP3z1LhZ
 MIbfjSY3pn9LhBPwfe3oLPX4B6S/1A==

Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>
---
 Documentation/bpf/prog_flow_dissector.rst  | 4 ++--
 Documentation/fb/fbcon.rst                 | 2 +-
 Documentation/filesystems/path-lookup.rst  | 2 +-
 Documentation/hwmon/lm75.rst               | 2 +-
 Documentation/kernel-hacking/hacking.rst   | 2 +-
 Documentation/networking/phy.rst           | 8 ++++----
 Documentation/process/management-style.rst | 2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/bpf/prog_flow_dissector.rst b/Documentation/bpf/prog_flow_dissector.rst
index f24270b8b034..8de1446b278b 100644
--- a/Documentation/bpf/prog_flow_dissector.rst
+++ b/Documentation/bpf/prog_flow_dissector.rst
@@ -68,7 +68,7 @@ Pre-VLAN parsing::
 
 .. code:: c
 
-  skb->data + flow_keys->nhoff point the to first byte of TCI
+  skb->data + flow_keys->nhoff point to the first byte of TCI
   flow_keys->thoff = nhoff
   flow_keys->n_proto = TPID
 
@@ -87,7 +87,7 @@ Post-VLAN parsing::
 
 .. code:: c
 
-  skb->data + flow_keys->nhoff point the to first byte of L3_HEADER
+  skb->data + flow_keys->nhoff point to the first byte of L3_HEADER
   flow_keys->thoff = nhoff
   flow_keys->n_proto = ETHER_TYPE
 
diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
index a98a5cb0b0d8..b278a8fe7e2b 100644
--- a/Documentation/fb/fbcon.rst
+++ b/Documentation/fb/fbcon.rst
@@ -109,7 +109,7 @@ C. Boot options
 	available, fb0, adding fbcon=map:1 tells fbcon not to take over the
 	console.
 
-	Later on, when you want to map the console the to the framebuffer
+	Later on, when you want to map the console to the framebuffer
 	device, you can use the con2fbmap utility.
 
 3. fbcon=vc:<n1>-<n2>
diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 9ced1135608e..4e374f9073f6 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -1077,7 +1077,7 @@ whether in RCU-walk or REF-walk, the symlink stack needs to contain,
 along with the path remnants:
 
 - the ``struct path`` to provide a reference to the previous path
-- the ``const char *`` to provide a reference to the to previous name
+- the ``const char *`` to provide a reference to the previous name
 - the ``seq`` to allow the path to be safely switched from RCU-walk to REF-walk
 - the ``struct delayed_call`` for later invocation.
 
diff --git a/Documentation/hwmon/lm75.rst b/Documentation/hwmon/lm75.rst
index c6a54bbca3c5..f05799c53474 100644
--- a/Documentation/hwmon/lm75.rst
+++ b/Documentation/hwmon/lm75.rst
@@ -154,7 +154,7 @@ The LM75 implements one temperature sensor. Limits can be set through the
 Overtemperature Shutdown register and Hysteresis register. Each value can be
 set and read to half-degree accuracy.
 An alarm is issued (usually to a connected LM78) when the temperature
-gets higher then the Overtemperature Shutdown value; it stays on until
+gets higher than the Overtemperature Shutdown value; it stays on until
 the temperature falls below the Hysteresis value.
 All temperatures are in degrees Celsius, and are guaranteed within a
 range of -55 to +125 degrees.
diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/kernel-hacking/hacking.rst
index 0042776a9e17..b3d352d2ffcc 100644
--- a/Documentation/kernel-hacking/hacking.rst
+++ b/Documentation/kernel-hacking/hacking.rst
@@ -259,7 +259,7 @@ overruns. Make sure that will be enough.
 .. note::
 
     You will know when you are a real kernel hacker when you start
-    typoing printf as printk in your user programs :)
+    typing printf as printk in your user programs :)
 
 .. note::
 
diff --git a/Documentation/networking/phy.rst b/Documentation/networking/phy.rst
index 7f159043ad5a..8d457979a1f1 100644
--- a/Documentation/networking/phy.rst
+++ b/Documentation/networking/phy.rst
@@ -5,7 +5,7 @@ PHY Abstraction Layer
 Purpose
 =======
 
-Most network devices consist of set of registers which provide an interface
+Most network devices consist of a set of registers which provide an interface
 to a MAC layer, which communicates with the physical connection through a
 PHY.  The PHY concerns itself with negotiating link parameters with the link
 partner on the other side of the network connection (typically, an ethernet
@@ -262,7 +262,7 @@ Some of the interface modes are described below:
     encoding.  The underlying data rate is 1Gbps, with the slower speeds of
     100Mbps and 10Mbps being achieved through replication of each data symbol.
     The 802.3 control word is re-purposed to send the negotiated speed and
-    duplex information from to the MAC, and for the MAC to acknowledge
+    duplex information to the MAC, and for the MAC to acknowledge
     receipt.  This does not include "up-clocked" variants such as 2.5Gbps
     speeds.
 
@@ -285,7 +285,7 @@ Some of the interface modes are described below:
 
     Note: 10GBASE-R is just one protocol that can be used with XFI and SFI.
     XFI and SFI permit multiple protocols over a single SERDES lane, and
-    also defines the electrical characteristics of the signals with a host
+    also define the electrical characteristics of the signals with a host
     compliance board plugged into the host XFP/SFP connector. Therefore,
     XFI and SFI are not PHY interface types in their own right.
 
@@ -545,7 +545,7 @@ When phy_register_fixup() or \*_for_uid()/\*_for_id() is called at module load
 time, the module needs to unregister the fixup and free allocated memory when
 it's unloaded.
 
-Call one of following function before unloading module::
+Call one of the following functions before unloading the module::
 
  int phy_unregister_fixup(const char *phy_id, u32 phy_uid, u32 phy_uid_mask);
  int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask);
diff --git a/Documentation/process/management-style.rst b/Documentation/process/management-style.rst
index dfbc69bf49d4..0b9e074277d0 100644
--- a/Documentation/process/management-style.rst
+++ b/Documentation/process/management-style.rst
@@ -42,7 +42,7 @@ actually true.
 The name of the game is to **avoid** having to make a decision.  In
 particular, if somebody tells you "choose (a) or (b), we really need you
 to decide on this", you're in trouble as a manager.  The people you
-manage had better know the details better than you, so if they come to
+manage know the details better than you, so if they come to
 you for a technical decision, you're screwed.  You're clearly not
 competent to make that decision for them.
 

base-commit: e30917da6074205bb1071a52e325c9d6ffe68ad5
prerequisite-patch-id: 81e067eae729d71e41b653c4f550dd3449003592
prerequisite-patch-id: 21078cbf43929b4a0d56ab4bb4acea907af70d7a
-- 
2.43.0


