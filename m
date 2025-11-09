Return-Path: <linux-kernel+bounces-892187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0820EC44936
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 23:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF3C84E6290
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 22:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273F12594B9;
	Sun,  9 Nov 2025 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b="p3KOSZIi"
Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA40E244660;
	Sun,  9 Nov 2025 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762727423; cv=pass; b=pSVe5UdWL6qTXiO8Ww5ZP68zYKJjxwBIKtSZd4+ewyu831NLzCaQ4OmOPLIZHqZ5BOnXC/hw2stUjf0W4/J1HaaWMnTH/XGqeeBrRZ0gdjmVf9qnlng7tUdTb3+EKT3Eh3we1wn8xRRphyGu/k7IIHvBaWPxzF2bGwFVxHNUFMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762727423; c=relaxed/simple;
	bh=DW51q5SLRoGHh/XsGlEjbQHvn+fjOKORZVbEJ9F8wNI=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Date; b=qEzBt/WCNc807yiA5itJqWrAcRHV90+843d6eXiS+GPH0XxZhV1d2aGAAigIsVSYiaDNcn31mOSnQ2sGh/YLrE5UQogoihvQ6YhHlbAZpZ+gGiWQaeNvf/ihrdPbj/e0BdIJKOhWdUhn+dNWwJfyG4XotemkKiXoWcLi67CN4aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com; spf=pass smtp.mailfrom=rootcommit.com; dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b=p3KOSZIi; arc=pass smtp.client-ip=23.83.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0856C180C07;
	Sun, 09 Nov 2025 22:30:14 +0000 (UTC)
Received: from fr-int-smtpout22.hostinger.io (100-121-54-118.trex-nlb.outbound.svc.cluster.local [100.121.54.118])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 91DCB180B51;
	Sun, 09 Nov 2025 22:30:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1762727413; a=rsa-sha256;
	cv=none;
	b=v0/fdEO0jwsney5EwKr8+VUwYnhfMf9u2Edl8Q67i681nMTIaI5cc0TTSvJRzXYadnFRl6
	DSmmL/nRkL47wiKNoFd7vnS6clOrwWqLgKSxRYhb7jnjvNhNRrh+5Wp0Cl3QFN/YQGyIcO
	pxEGZGU3FZKMbS0VD1k3NWt7LBy2PM0UB3J+jBmrX+InDUqMKP4zb41FzkLmP6Qbk1x1Bb
	mIsSa82knRzwSFk318FL4Ak+K+ZiRWoAwMyLlS4L1LbT5ZkwdgbPyQXxfUAr71XdrwH+bk
	oyBhgRvQZ1O04IUdAQHD/AxrKP1zRQ9pygJ3uWxoZvG385eC8b7+nDVj1IvdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1762727413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lMMDZRDGGpEBuRYV24hp6KfsDILOWOPCJ715ewD0GOI=;
	b=aDhE2iV3Mvzo0DqpT914aBMkSE65qOOw9O0JN8k7BzDMAFjEn+ot9ahfhqdvgPgU58iNy+
	tqnDzZp3sheXGsbpG9+Ps4BqjWRpJLdVgnDEFjHhjKX/2YoxKg7Z17X3EvfbJpopzJruGO
	IWyKYQ3ZPffKPz9KM/RZeyFmIEuFeCrf9QcLLQIqcM15eOGWjusPtBBtCidz8zxNOcrTRn
	I6xLq1j0Y+t1enH7w0P7heLaDcFuNs5FaepHWNOCVWf1rbdU8pmb91ZnTpAssrZQE6WSAV
	9RusVOKnvX/jU0SWbv+fk4+FrfPaCLKqybYNrXcFkSideSAJIHYBB+8hWdREOQ==
ARC-Authentication-Results: i=1;
	rspamd-768b565cdb-8jqbh;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId:
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Print-Coil: 6b41a3097df5bd0d_1762727413938_3700687853
X-MC-Loop-Signature: 1762727413938:2777145993
X-MC-Ingress-Time: 1762727413938
Received: from fr-int-smtpout22.hostinger.io (fr-int-smtpout22.hostinger.io
 [148.222.54.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.121.54.118 (trex/7.1.3);
	Sun, 09 Nov 2025 22:30:13 +0000
Received: from localhost.localdomain (unknown [IPv6:2001:861:4450:d360:6854:e5c6:92e9:8517])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4d4SD13R28zyVB;
	Sun,  9 Nov 2025 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1762727409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMMDZRDGGpEBuRYV24hp6KfsDILOWOPCJ715ewD0GOI=;
	b=p3KOSZIiyvC6q2bDLUNZ6Z4mm+WuOaEA+2AqZT93a4cli8wFETt5PwZL5QK0YQVv2bAs4Q
	FO3zdRz6OZ4lG8WFBuhs5d4v6TXwVtvTdn2dOCIcP+JWefGp49p8ljcVkT4xbKhNuGgpVE
	CQ8jJHmLF9S7IaK40+lKi8C/VdYoaX6MoAmS3wXeB0/LB6ikb6EiWfP73Tlk9vocbg2aWG
	0mixNwwWJIDPdX+xphBJMzVEvN2aMQ8NunMKOfrIKHgTWfT4EBZQS5aTRdRVzLE/qrnHin
	KSSYKUtdM0EPsi1XTfY1z/Fm+LpvJXnL58PasUmhBrS5sMQtweSvUDXS3WUgQw==
From: michael.opdenacker@rootcommit.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] riscv: dts: spacemit: add Gigabit Ethernet and PDMA to OrangePi R2S
Message-ID: <20251109222858.3085488-4-michael.opdenacker@rootcommit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251109222858.3085488-1-michael.opdenacker@rootcommit.com>
References: <20251109222858.3085488-1-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Date: Sun,  9 Nov 2025 22:30:09 +0000 (UTC)
X-CM-Envelope: MS4xfArM56kEnyOUB4CkV1Zq92++CESYar+YPFTqQjUETC8mhwT0g5lSKIXEsshMGeqE7tGhVqC6cMoQwS3eeDjq1AjGyRX67NexJ/6kD+YaQaZtoN0Xkx26 XVdn9WvMHQ1tlEziuimLAnQSQ73uu3wR030fUMh/IAOS8F+Rd0H8bcYsVTGyzNnrNWgjlbUEXwMRMMvgECYItYxRfhnpPVwzf8ABsxKCEsQEocNomrw8KMU3 7T1hIE2Y8VBp8aAgS0iRiX19PrSEz5puU75kefDGkGYGr56XchriwhBt8s5K824GYLvDrg/BzRArI28heuGPPxtBLBGfMkfsIcHobfJ96iGUtCPr9JiloGLU 0UmabrJQGj1sFNm0f/7vv2xLmCNAQOzpSRDTmMB4soLu6zOZdWxImhLdnCcSjRI5nrWC+wX8GMxevCaQOcECsjk/QDLeBCMdW0sV2pl3PqTu9ie5QwaH6KF7 ePYehagWI0+nlJcKXhE3IMxbVYeoWzqPxtNggrCVY61WPySGrReXB8u65OBlWqHNTNRPQca0O7GmEpa2q/xie86z8jsXR9AWmqsolhAeIgkYQyZbf4vEek6S x3/idIl+OQKCl+5HlANUDRdSL/o4oWWDLHDAttfjHuNJYD0qa0IhODqVZT+SlYA34244Mp/qweuE1uYlXVeO+qdJ2X4GHM+HueAZne3tb+fO3A==
X-CM-Analysis: v=2.4 cv=DJTd4DNb c=1 sm=1 tr=0 ts=691115f1 a=9hvhlO9olek7/vweJUpOAg==:617 a=xqWC_Br6kY4A:10 a=d70CFdQeAAAA:8 a=1SozR2x5KYA1SUCAoLIA:9 a=NcxpMcIZDGm-g932nG_k:22
X-AuthUser: michael.opdenacker@rootcommit.com

From: Michael Opdenacker <michael.opdenacker@rootcommit.com>

The OrangePi R2S board includes two RGMII ethernet ports
supporting Gigabit Ethernet operation.

They have an external Motorcomm YT8531C PHY attached,
the PHY uses GPIO for reset pin control. Their description
was reused from the DTS from the OrangePi RV2 board.

Enable PDMA for the SpacemiT K1-based SoC.

Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>

---

tests on eth0
-------------

root@orangepi-rv2-mainline:~# iperf3 -c 172.24.0.1
Connecting to host 172.24.0.1, port 5201
[ 5] local 172.24.0.2 port 51354 connected to 172.24.0.1 port 5201
[ ID] Interval Transfer Bitrate Retr Cwnd
[ 5] 0.00-1.00 sec 113 MBytes 947 Mbits/sec 0 395 KBytes
[ 5] 1.00-2.00 sec 113 MBytes 945 Mbits/sec 0 395 KBytes
[ 5] 2.00-3.00 sec 112 MBytes 936 Mbits/sec 0 395 KBytes
[ 5] 3.00-4.00 sec 112 MBytes 942 Mbits/sec 0 395 KBytes
[ 5] 4.00-5.00 sec 112 MBytes 941 Mbits/sec 0 395 KBytes
[ 5] 5.00-6.00 sec 112 MBytes 940 Mbits/sec 0 409 KBytes
[ 5] 6.00-7.00 sec 113 MBytes 948 Mbits/sec 0 409 KBytes
[ 5] 7.00-8.00 sec 112 MBytes 940 Mbits/sec 0 409 KBytes
[ 5] 8.00-9.00 sec 112 MBytes 941 Mbits/sec 0 414 KBytes
[ 5] 9.00-10.03 sec 113 MBytes 919 Mbits/sec 0 414 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval Transfer Bitrate Retr
[ 5] 0.00-10.03 sec 1.10 GBytes 940 Mbits/sec 0 sender
[ 5] 0.00-10.04 sec 1.10 GBytes 939 Mbits/sec receiver

iperf Done.
root@orangepi-rv2-mainline:~# iperf3 -s
-----------------------------------------------------------
Server listening on 5201 (test #1)
-----------------------------------------------------------
Accepted connection from 172.24.0.1, port 38326
[ 5] local 172.24.0.2 port 5201 connected to 172.24.0.1 port 38332
[ ID] Interval Transfer Bitrate
[ 5] 0.00-1.00 sec 112 MBytes 935 Mbits/sec
[ 5] 1.00-2.00 sec 112 MBytes 942 Mbits/sec
[ 5] 2.00-3.00 sec 112 MBytes 941 Mbits/sec
[ 5] 3.00-4.00 sec 112 MBytes 941 Mbits/sec
[ 5] 4.00-5.00 sec 112 MBytes 942 Mbits/sec
[ 5] 5.00-6.00 sec 112 MBytes 942 Mbits/sec
[ 5] 6.00-7.00 sec 112 MBytes 942 Mbits/sec
[ 5] 7.00-8.00 sec 112 MBytes 942 Mbits/sec
[ 5] 8.00-9.00 sec 112 MBytes 941 Mbits/sec
[ 5] 9.00-10.00 sec 112 MBytes 943 Mbits/sec
[ 5] 10.00-10.01 sec 384 KBytes 725 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval Transfer Bitrate
[ 5] 0.00-10.01 sec 1.10 GBytes 941 Mbits/sec receiver

Tests on eth1
------------------

root@orangepi-rv2-mainline:~# iperf3 -c 172.24.0.1
Connecting to host 172.24.0.1, port 5201
[ 5] local 172.24.0.2 port 60564 connected to 172.24.0.1 port 5201
[ ID] Interval Transfer Bitrate Retr Cwnd
[ 5] 0.00-1.00 sec 113 MBytes 947 Mbits/sec 0 423 KBytes
[ 5] 1.00-2.00 sec 113 MBytes 945 Mbits/sec 0 423 KBytes
[ 5] 2.00-3.00 sec 112 MBytes 943 Mbits/sec 0 423 KBytes
[ 5] 3.00-4.00 sec 112 MBytes 938 Mbits/sec 0 423 KBytes
[ 5] 4.00-5.00 sec 112 MBytes 944 Mbits/sec 0 423 KBytes
[ 5] 5.00-6.00 sec 112 MBytes 936 Mbits/sec 0 423 KBytes
[ 5] 6.00-7.00 sec 112 MBytes 943 Mbits/sec 0 423 KBytes
[ 5] 7.00-8.00 sec 112 MBytes 940 Mbits/sec 0 423 KBytes
[ 5] 8.00-9.00 sec 113 MBytes 951 Mbits/sec 0 639 KBytes
[ 5] 9.00-10.01 sec 112 MBytes 934 Mbits/sec 0 639 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval Transfer Bitrate Retr
[ 5] 0.00-10.01 sec 1.10 GBytes 943 Mbits/sec 0 sender
[ 5] 0.00-10.02 sec 1.10 GBytes 940 Mbits/sec receiver

iperf Done.
root@orangepi-rv2-mainline:~# iperf3 -s 172.24.0.1
-----------------------------------------------------------
Server listening on 5201 (test #1)
-----------------------------------------------------------
Accepted connection from 172.24.0.1, port 49628
[ 5] local 172.24.0.2 port 5201 connected to 172.24.0.1 port 49640
[ ID] Interval Transfer Bitrate
[ 5] 0.00-1.00 sec 112 MBytes 934 Mbits/sec
[ 5] 1.00-2.00 sec 112 MBytes 942 Mbits/sec
[ 5] 2.00-3.00 sec 112 MBytes 942 Mbits/sec
[ 5] 3.00-4.00 sec 112 MBytes 942 Mbits/sec
[ 5] 4.00-5.00 sec 112 MBytes 941 Mbits/sec
[ 5] 5.00-6.00 sec 112 MBytes 942 Mbits/sec
[ 5] 6.00-7.00 sec 112 MBytes 942 Mbits/sec
[ 5] 7.00-8.00 sec 112 MBytes 942 Mbits/sec
[ 5] 8.00-9.00 sec 112 MBytes 942 Mbits/sec
[ 5] 9.00-10.00 sec 112 MBytes 941 Mbits/sec
[ 5] 10.00-10.01 sec 640 KBytes 1.14 Gbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval Transfer Bitrate
[ 5] 0.00-10.01 sec 1.10 GBytes 941 Mbits/sec receiver
---
 .../boot/dts/spacemit/k1-orangepi-r2s.dts     | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts
index 902cb6702fbf..a4007a7a1656 100644
--- a/arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-r2s.dts
@@ -14,6 +14,8 @@ / {
 
 	aliases {
 		serial0 = &uart0;
+		ethernet0 = &eth0;
+		ethernet1 = &eth1;
 	};
 
 	chosen {
@@ -21,6 +23,56 @@ chosen {
 	};
 };
 
+&eth0 {
+	phy-handle = <&rgmii0>;
+	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac0_cfg>;
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <0>;
+	status = "okay";
+
+	mdio-bus {
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+
+		reset-gpios = <&gpio K1_GPIO(110) GPIO_ACTIVE_LOW>;
+		reset-delay-us = <10000>;
+		reset-post-delay-us = <100000>;
+
+		rgmii0: phy@1 {
+			reg = <0x1>;
+		};
+	};
+};
+
+&eth1 {
+	phy-handle = <&rgmii1>;
+	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac1_cfg>;
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <250>;
+	status = "okay";
+
+	mdio-bus {
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+
+		reset-gpios = <&gpio K1_GPIO(115) GPIO_ACTIVE_LOW>;
+		reset-delay-us = <10000>;
+		reset-post-delay-us = <100000>;
+
+		rgmii1: phy@1 {
+			reg = <0x1>;
+		};
+	};
+};
+
+&pdma {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_2_cfg>;

