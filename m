Return-Path: <linux-kernel+bounces-818445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B81DB591D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9FAB1BC551E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187DB284688;
	Tue, 16 Sep 2025 09:12:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990528BAB9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013934; cv=none; b=fJg/IYfP3aTTQuvVjH517O2DmzrNTAwFak4TwDow6nDAYnMLdmp//+Q202dyDV154JzAIaAYlNKStyX4PizaaixuTVbSDn/Av00e6bZ7sTgr04MF+eBnNh6vyDB/VZNpfKB6sRKVRSA7G5pmPIQ2emqEA8CYSXpCMqKp5S4m7dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013934; c=relaxed/simple;
	bh=GHuK+PLJQJr02xZ81YhwlytM9kKnQHjixQj34PgCAYs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HSLkyFcUnJe2lIFXKL2hI+SCdi7v2X1afWtVL4tQxzevog7vWMNENm7DDibT3Yx4EMWSKlPgPvl77wHxJ9MmZ1TSGye2pC0NdUg6r0IsvPtLLSkXph42LUDtqvQx1tIdVVP6SSc7swv5WKd6QA9TywstzM3cXc7dYtMDJLGGBSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uyRjI-0002aw-A8; Tue, 16 Sep 2025 11:12:04 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uyRjH-001Z3b-0E;
	Tue, 16 Sep 2025 11:12:03 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uyRjG-00BVwu-30;
	Tue, 16 Sep 2025 11:12:02 +0200
Date: Tue, 16 Sep 2025 11:12:02 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC] net: selftests: Adding TX checksum offload validation
Message-ID: <aMkp4vGilSPbAyun@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello everyone,

While working with the smsc95xx driver, I identified a need for better
validation of the driver and hardware TX checksum offloading capabilities. I
believe a generic test suite for this would benefit other drivers as well.

The generic selftest framework in net/core/selftests.c seems like the ideal
location. It already contains a test for the RX checksum path, so adding
validation for the TX path feels like a natural extension.

Here is the list of test cases I propose to add:
- TX csum offload, IPv4, TCP, Standard MTU Packet
- TX csum offload, IPv4, UDP, Standard MTU Packet
- TX csum offload, IPv4, ICMP, Standard Payload
- TX csum offload, IPv4, TCP, Minimal Size Packet (1-byte payload)
- TX csum offload, IPv4, UDP, Minimal Size Packet (1-byte payload)
- TX csum offload, IPv4, UDP, Zero-Checksum Payload (Verify checksum becomes
                              0xFFFF)
- TX csum offload, IPv4, TCP, With Single VLAN Tag
- TX csum offload, IPv4, TCP, With Double VLAN Tag (Q-in-Q)
- TX csum offload, IPv6, TCP, Standard MTU Packet
- TX csum offload, IPv6, UDP, Standard MTU Packet

The implementation for these tests would involve preparing an skb with the
corresponding L3/L4 headers, flagging it with CHECKSUM_PARTIAL, and sending it
through the PHY loopback. The test would pass if the received frame has a
valid checksum.

As a related question on driver implementation:
The documentation suggests that the older flags NETIF_F_IP_CSUM and
NETIF_F_IPV6_CSUM are being superseded by the more generic NETIF_F_HW_CSUM.
When the network stack sends a packet with skb->ip_summed = CHECKSUM_PARTIAL,
the driver is responsible for ensuring the final checksum is correct, either by
offloading the calculation to the device or by falling back to a software
function like skb_checksum_help().

Is this understanding correct, and is relying on CHECKSUM_PARTIAL as the
primary mechanism for requesting TX offload the recommended practice for modern
network drivers?

Thanks,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

