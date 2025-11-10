Return-Path: <linux-kernel+bounces-893030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8839C46630
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1388C4E9C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8703230C36F;
	Mon, 10 Nov 2025 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="H27i6ARB"
Received: from mx-relay48-hz3.antispameurope.com (mx-relay48-hz3.antispameurope.com [94.100.134.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A7309EFF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.237
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775467; cv=pass; b=UM9g6XKzvh4x2iMhOY27DFMpbT79X9XXtrrkaPdLOX3Gte4N9c/iQMk5gusPHjhVYAGgzfdnTiBm9T94MjVQQ6yDmGDq5V6Jdd5E9/D81flt7nT/2MVptfFdcgWvfga0mg6MKlLAg8O3i4JpoyLf23d9dcLQDeMnt43eU0u9eMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775467; c=relaxed/simple;
	bh=8ANnxTZGB0qdq9OA0+LforOl8pHytTMeo+uUVALYyx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P1bYsQbTl/KgChFFzKWUEZ04zeah09YZOaLKDypFcanNbfI9Y0vw1UuGAlR/dqTTyKRy4d3wOuQtDYohPLth8uS2bouVO9QmFcd6vsiEYhhSPyfHhou3tB3pIaU2v+wojgk84vtF7ya+zpAF//eVfwF3l787fnMbXLxag2AH54k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=H27i6ARB; arc=pass smtp.client-ip=94.100.134.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate48-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=6+JY7AOKey3FDjj6FvnrDJHIL5n0tWzWiuTW9DK4ln0=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1762775422;
 b=npImvd+OGGbR5vJ6swHagiqHtwKJQpr3sNcCp4wq7veMER39xbR9/fwola+jQ6LvZWdLWNb6
 C6kVZw+Zv6N1NBQg5tipo90v4J7RFj/6bX1BQPBnz0gIkTFI6AMgb0UEbnFID1Xq4uwlvjgoT9i
 USqf1doJ+x9nDBuBtohApODQY2CBFXMs8nB95ACt4/FXY9o1HmUMUqh1RuA4QJ5GvLW1AD0CAzZ
 LBg8LA8w5NV3s/i2pyuxA7etzyz0WyYHimw8IqTiBFA9EO375vR+83GMVppk3IFpSjBnDAajKPF
 J2zmXgq6lOrJycn0j9ltgQ4ssZ5NFqqOGz1Fo5nqMHZoQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1762775422;
 b=jk9DwqmQqexVR6Mn+sWDGlJceS8N2bLSq0C6MAfZohrka3VoMLFCKwQ6MCwBsMzLn6w40dJt
 /deELrNuxLJchaYl3Uj1zeqECl24T/k2TqJNzoRr7f7vYwA21QFFKjXNv5q2XnnsGtgUUnOpBvk
 sEp3tnxspt4tKp6cGEOOTmLBpHNBi0/wxpoMqaG5gGHjUiBnIEY7xobN6IzPyjI/a0EMOWbPwnU
 zU9/+fpeRgkhwmQYzhS9Avpnet9NZ27bF3zDcDboiAPbFnYzaYsHm2bEkrR82wLOQbnCR2YTYmJ
 ux/Hww/sM0v43shm4PFG3gUYaeWwqg7YsrHoFJyP7kc7Q==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay48-hz3.antispameurope.com;
 Mon, 10 Nov 2025 12:50:22 +0100
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 8EFB1A41305;
	Mon, 10 Nov 2025 12:50:05 +0100 (CET)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v4 0/2] TQ-Systems TQMa62xx SoM and MBa62xx board
Date: Mon, 10 Nov 2025 12:49:44 +0100
Message-ID: <cover.1762775119.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay48-hz3.antispameurope.com with 4d4nz22xmnz1kNh54
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:1af9115dd2db95f7ea9e58f71e1f2d89
X-cloud-security:scantime:1.819
DKIM-Signature: a=rsa-sha256;
 bh=6+JY7AOKey3FDjj6FvnrDJHIL5n0tWzWiuTW9DK4ln0=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1762775422; v=1;
 b=H27i6ARB3PqsecSRefko1S+LVbNyFNKVgdTMYg6FzJ+Ek7UpDqzaG24jSuk2LmpmqqPu6002
 XihgSM3YqhaSnqzvmtsG6QEbkBX6Q9hKGjBSbRaVm+HGEemFdpulvhSk8luAO4Y+0rMxkOkHJPy
 5eMQziyKZGActjzx+zDHthalMehLTTqhNijl0WCYUKt8p/TfA72Py0jaPL3k4Wj89zLcnfuekYl
 jIj+JRDRcctXdW9i4wTBfg62mhkg8E/ZMrofqe9IU9TQKGAs8DRu4MZnTprCneVtA6p/05OxtUV
 7fllpdvveuJLXSEJT4c164OqpE8jXUAMVOLRHayctbLqA==

This adds Device Trees for our AM62x-based SoM TQMa62xx and its
reference carrier board MBa62xx.

Not yet included are overlays to enable LVDS display output and MIPI-CSI
camera input.

Changes in v4:
- Rebase onto latest ti-k3-dts-next
- Reorder boot phase tags after other standard DT properties
- Add missing supply regulators in SPI-NOR flash and USB hub
- Set status = "okay" in &cpsw3g, as it is disabled in k3-am62-main.dtsi
  now
- Add disabled 1400MHz OPP entry (will be enabled by bootloader if
  supported by PMIC configuration)
- Update copyright years in new files

Changes in v3:
- Rebased onto ti-k3-dt-for-v6.18
- 3 of the 5 patches in v2 have been applied already and are dropped
- Include k3-am62-ti-ipc-firmware.dtsi, drop now redundant configuration
- Change node name for MCU reserved memory to 'memory'
- Use rgmii-id PHY mode
- Drop now redundant ti,rx-internal-delay
- Update simple-audio-card,name to match other TQ SOMs with compatible
  configuration
- Reference dss_pins in dss node (actual display support will be added
  in a follow-up patch series)
- Consistently use GPIO_ACTIVE_HIGH define
- Drop unneeded usb0 quirk flags
- Add boot phase tags

Changes in v2:
- Collected acks and reviews
- Rebased onto v6.13-rc1

Matthias Schiffer (2):
  dt-bindings: arm: ti: Add compatible for AM625-based TQMa62xx SOM
    family and carrier board
  arm64: dts: ti: Add TQ-Systems TQMa62xx SoM and MBa62xx carrier board
    Device Trees

 .../devicetree/bindings/arm/ti/k3.yaml        |   7 +
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 .../boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts | 930 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi | 331 +++++++
 4 files changed, 1269 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

