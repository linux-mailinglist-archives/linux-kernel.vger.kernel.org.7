Return-Path: <linux-kernel+bounces-729721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77217B03AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4BB17747C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9320E242905;
	Mon, 14 Jul 2025 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eWu1a5MW"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AEE234973;
	Mon, 14 Jul 2025 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485268; cv=none; b=TPeEt2M+YMOgV+2Mz2M+BRQonU9VJrIi8m/f4jGK98DpR7y/cQCgGN/QAv2gIjm2wX5JOtTmqozEQcJo4e1hIM0umquYrvCTRF8smjWlA9bmu8Px+fRqI6myKWmHsWR6pSbUszIgBj7flRv/rnOKTsRk7axZWKebGmxFNo17FTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485268; c=relaxed/simple;
	bh=NkdzmEJA2rxV8ybPvo6F3lSYDZZ175rOCAFA+Gh9kxc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TC+yj2ZptK01aDVmIrtXv1KtO6oCtN3srmfSoCqcgukAuCumTcTV3YFQa4GpQQbhFWCNogmUpQ5JCDu6G6nNVDk4Ni260xs7l3RdXmHABUqIhg6tIPi0tyuxhYXkxzchnhiIZ+Wjph6tnJ6rNZSyNBDlYL+Mxhwuqo/FNQMSrtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eWu1a5MW; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56E9RUuJ2347226;
	Mon, 14 Jul 2025 04:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752485251;
	bh=qdPkp927EPjHpR8CdKSeHXDZaCUOcmMQXfmTrJemwIg=;
	h=From:To:CC:Subject:Date;
	b=eWu1a5MWRtt3TkJXNSUFqfYB+klz8bWTbeY5rO2y2J+XEdjG9xpPX+anug5ujash7
	 hIgNbve/TZpU4MpJFWSesXzs+cW1wblnSpEEh+Vtl/7eOYDAYk+SqnNvgp/3o7mrCz
	 qzrMTH0JuUw94L3yI+TcEMyaigQEK27hn0DZoVzc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56E9RU55197401
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 14 Jul 2025 04:27:30 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 14
 Jul 2025 04:27:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 14 Jul 2025 04:27:30 -0500
Received: from abhilash-HP.dhcp.ti.com (abhilash-hp.dhcp.ti.com [172.24.227.115])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56E9RPVg279945;
	Mon, 14 Jul 2025 04:27:26 -0500
From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <y-abhilashchandra@ti.com>
Subject: [PATCH 0/7] Add Interrupts property for CDNS CSI2RX
Date: Mon, 14 Jul 2025 14:57:01 +0530
Message-ID: <20250714092708.3944641-1-y-abhilashchandra@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The driver patch that adds support for error detection on the
Cadence CSI2RX by enabling its interrupt lines was recently
picked up [0].

Accordingly, this patch adds the required interrupts property
to the Cadence CSI2RX device tree nodes.

Test logs:
(To validate the complete functionality, CRC errors were
intentionally generated by modifying the sensor overlay)

AM68: https://gist.github.com/Yemike-Abhilash-Chandra/123fed82e798a76944ec23f8e46d1114
AM69: https://gist.github.com/Yemike-Abhilash-Chandra/1820e39888cb50e250a83e2d059365f6
J721E: https://gist.github.com/Yemike-Abhilash-Chandra/63f993a995fd6a12cb113454952c063f
J722S: https://gist.github.com/Yemike-Abhilash-Chandra/2144fc8ab2f7bcdb3ef868e85424467d 
J721S2: https://gist.github.com/Yemike-Abhilash-Chandra/f46587ec1ef72671ee31803dd93434b4
J784S4: https://gist.github.com/Yemike-Abhilash-Chandra/0c594683772f11c70bccb508757e9799

Driver and Binding patch series: https://lore.kernel.org/all/20250416121938.346435-1-y-abhilashchandra@ti.com/

[0]: https://lore.kernel.org/all/aG9tuMFOnvwXkcE-@valkosipuli.retiisi.eu/

Yemike Abhilash Chandra (7):
  arm64: dts: ti: k3-j721s2-main: Add interrupts property
  arm64: dts: ti: k3-j721e-main: Add interrupts property
  arm64: dts: ti: k3-j784s4-j742s2-main-common: Add interrupts property
  arm64: dts: ti: k3-am62p-j722s-common-main: Add interrupts property
  arm64: dts: ti: k3-j722s-main: Add interrupts property
  arm64: dts: ti: k3-am62-main: Add interrupts property
  arm64: dts: ti: k3-am62a-main: Add interrupts property

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                 | 3 +++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                | 3 +++
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi   | 3 +++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi                | 6 ++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi               | 6 ++++++
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi                | 9 +++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi | 9 +++++++++
 7 files changed, 39 insertions(+)

-- 
2.34.1


