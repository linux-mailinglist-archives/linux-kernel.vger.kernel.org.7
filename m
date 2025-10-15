Return-Path: <linux-kernel+bounces-854171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92028BDDC3E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA5E35005AA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FDD31A57E;
	Wed, 15 Oct 2025 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTuyCEAR"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2876C31A059
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520359; cv=none; b=ZM3UFqR7iU4DnNxSWToSGTPu5Q6lr1/d5l4LHEK1IMJ+Cme6c26eKnOduRTewmeb412Gb75BE6WuoRa7DNzJVg29/0tYvcbx6B7lQ92vd5jC1kgvfW5LARl594p2RVgf8sr/7gjUsxJDgbQf8D8bcNQodUchoDbVgDNMX8FfANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520359; c=relaxed/simple;
	bh=5RP+NYGBCAcP9sVodp5C4Ye+lxrfMuSA70t/0cFcM6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KOIie1cwsN1z56nFfuzghZCGG5TjHuG6jG+EZYrbdjLejzMiKIHZWlUH3GoQBkQe5gY6HZjsn7GJ6AEeqEV0riSgxR32XnREJJktFJ8abTVr7VRHdQA6OK18ZTOCRJ/Iltk6ygavZTvs8sefKuLTdtctsqN++eXvTQ0gBaQj9vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTuyCEAR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-780fc3b181aso3810423b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760520357; x=1761125157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y27mfP/51Mbfw358eu1yuPjNWUXysGxqMLnfgU6NaWA=;
        b=DTuyCEARO4iQJQ9fb2IWfSW5dkdngCRKm4XqHkB4PQTxsYQtbIfkER/oJJEHWF1QNq
         h+N08UwTzYDKH5Z1ff4VRpqIS9KUbJK67EKewtoHRklIho7DoRM6hzzJTe4DXg3n3AgB
         Pk9KOhWtJ03yY+ibQFlEWzNvahgMuzA6jMx4KDDmT8U/e1BaSw8A/+pChNq+aOqIwzzM
         Xbor6SV+qrT1hZKJEIsUEJWeCesvmNovglOc9oYEFrRPWL+4lPXfafRV+bBMiqBqoCHd
         xCQkLoIzSb49dI+zNphxQMwzxHdq+9LmU2N/+WulJgTOUKjCZmVD9AJ7BVUrFmTo8/3Z
         GRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760520357; x=1761125157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y27mfP/51Mbfw358eu1yuPjNWUXysGxqMLnfgU6NaWA=;
        b=jjWgMx/dNKfZSXs6DIg3rTXZ5MLOXUI+Q2Opr7VIuRtsdh4ouSkEBTtXv8mWtr62A+
         yVSHvLJ0FVdgCXXBgBw4Qt7S/6paE+nBvnUhQBq3Dh8xAiOYLuRDDxf4ed4wOUt1LC46
         GoT2TI4LZPmyI/95Uq5U4yYGU8+cZYkhK0D0zjlVPkqPLEf8JaAPe7eh6LPOx6h9Z6sc
         1EQmANNcoTb/pBG0KGHpqzo6r7FKixmr7vGL/1qBz+a2SIpGaPAbpmcL/E+YPK5rQzRy
         kAKM0KiNU0Y1385AS9nylKLROA/4yIxQBbj8bvsElNDC9VR21VeTR2xC1Lq3gLqCKoE8
         hcyQ==
X-Gm-Message-State: AOJu0Yz0GU4b5MgyoFUMUjsxvaAuNwDS5ItOQe9YxQpdD8qezFo6HAbn
	zQyrkCY3/N/7wys8RJGVcUcMoSnFqCYgBEFqIH2Dso/vtk4kdcftTWT5
X-Gm-Gg: ASbGncuMaoPDV5Wk/Mu4oUUGWrx6jV/ww/sH1c3scFvxLrWF5ob+6vWma4350fX3KBH
	LlZyPuXlSmbdrKSU3BVLLpsuCL/RhFjD/lt5t5AAlNog3t2vCkvehr3UiJrdNuufHaIC8YaGWbl
	p2H2JAqhvwN6FB1Cn8JTtr6vTOeFTzsTmvTuwwsnGaAQqgsVGTcIzxwKiFv/n01ePFD48Re/7g2
	diRu7DdSJb/gsLe763721JrrtSyfBruUdlJiRBc+cV5Tlp9D5E/FveR86pvU8IE5k3brBf2790Q
	bAg+1kaNRvQFHOHATCSdf52AWnkHKCkPZkSNxpyK0DAhwsa/IpnORV0+PbYMPKE2bCyPhOjCxyT
	IXPvJ2eIq9DHrCDrLqr1MO1VW+YfhwUv2Bfv8BSvrv66NlZDM1FAqpxQ=
X-Google-Smtp-Source: AGHT+IFOSPYmWJ3lrYXq1lbkUMvnb1m+5qpQqFhS676gcwftEHa0HVMKsOIxqxjQgumwhzpSXoOROw==
X-Received: by 2002:a05:6a20:3c8e:b0:2ea:f131:e25e with SMTP id adf61e73a8af0-32da83e54b6mr34186934637.47.1760520357151;
        Wed, 15 Oct 2025 02:25:57 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bb19d3csm17895109b3a.31.2025.10.15.02.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 02:25:56 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3B8E44209E9D; Wed, 15 Oct 2025 16:25:54 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sharath Chandra Vurukala <quic_sharathv@quicinc.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net] net: rmnet: Fix checksum offload header v5 and aggregation packet formatting
Date: Wed, 15 Oct 2025 16:25:41 +0700
Message-ID: <20251015092540.32282-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2271; i=bagasdotme@gmail.com; h=from:subject; bh=5RP+NYGBCAcP9sVodp5C4Ye+lxrfMuSA70t/0cFcM6k=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnv08+7/YzS1Iov5ExLFkp6veDeYokp//6YBnbNj9pox mcWJHiuo5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABN528vI8GD1puM3Hu8yXbLh Qlu7XL77e/658eXJKdnWVx47xt7TfMnI0C4a5atecnLN+9Dcv3YLd//+UHeC663FLHlV/px8ra/ reAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Packet format for checksum offload header v5 and aggregation, and header
type table for the former, are shown in normal paragraphs instead.

Use appropriate markup.

Fixes: 710b797cf61b ("docs: networking: Add documentation for MAPv5")
Fixes: ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial implementation")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../device_drivers/cellular/qualcomm/rmnet.rst       | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
index 289c146a829153..6877a326058206 100644
--- a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
+++ b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
@@ -137,16 +137,20 @@ d. Checksum offload header v5
 
 Checksum offload header fields are in big endian format.
 
+Packet format::
+
   Bit            0 - 6          7               8-15              16-31
   Function     Header Type    Next Header     Checksum Valid    Reserved
 
 Header Type is to indicate the type of header, this usually is set to CHECKSUM
 
 Header types
-= ==========================================
+
+= ===============
 0 Reserved
 1 Reserved
 2 checksum header
+= ===============
 
 Checksum Valid is to indicate whether the header checksum is valid. Value of 1
 implies that checksum is calculated on this packet and is valid, value of 0
@@ -183,9 +187,11 @@ rmnet in a single linear skb. rmnet will process the individual
 packets and either ACK the MAP command or deliver the IP packet to the
 network stack as needed
 
-MAP header|IP Packet|Optional padding|MAP header|IP Packet|Optional padding....
+Packet format::
 
-MAP header|IP Packet|Optional padding|MAP header|Command Packet|Optional pad...
+  MAP header|IP Packet|Optional padding|MAP header|IP Packet|Optional padding....
+
+  MAP header|IP Packet|Optional padding|MAP header|Command Packet|Optional pad...
 
 3. Userspace configuration
 ==========================

base-commit: 7f0fddd817ba6daebea1445ae9fab4b6d2294fa8
-- 
An old man doll... just what I always wanted! - Clara


