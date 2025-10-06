Return-Path: <linux-kernel+bounces-842895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20090BBDEA2
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 13:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700DF3AC2C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 11:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA6F26A0AD;
	Mon,  6 Oct 2025 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="opQIIg0N"
Received: from mx-relay76-hz1.antispameurope.com (mx-relay76-hz1.antispameurope.com [94.100.133.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B7D34BA3A
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.133.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759751406; cv=pass; b=XTVneQqRI+lIdChZ39zfE/Wmm66CVtveiJaGqqtn3bRIJzlHpgaCkOrCVBQG3Z4kSUjKtmVNd5HxfmCnQp3xFWVjjbgVOWoDFLbOBSI2V+CzAJvNvtYCJOPNaVqkOQ6vvOZOK9Ww6Fa4BRSqJNqP9eY2XC2QdwbAm4Qb0tyv01w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759751406; c=relaxed/simple;
	bh=lQusUQvXdBnjoaLEEe4P5A98H/WHgUn83QJF2IuKnxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CxS5uwEuWN2MMjONfFAOs5npOxzmazWftgkx8d36KUZxCbl/0CzkRUPIjyxzJGCpbbT7G60rO1NxVCFB7Gr9okxfWJcF3DrKAJiV/F1+P1x9NlrmI0bAqoM8ac797howVoXJhcM08nz7WS1XRZRIGjuiJdHwaFZcgFgiJwumrms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=opQIIg0N; arc=pass smtp.client-ip=94.100.133.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate76-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=Nwv2x3AV2URX4eDt226Z25gIAY13bxvGxt/6sHiSWCk=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1759751360;
 b=L5HcGPeYkrtdOUf5aqR+92eJ3qZP4Zg3W7BdJPg/DGvsB6OX2M06n+rBUWKUZqMvjCVhUJ3a
 +bdMsdcqk3Nhrg5GAIaRigolVpCAKPNJslZ672ZVtvRMFKb937nTOXl2jwQ/D8d4v9lH5vSuD3O
 YI1PiWCIuQ7tlnQoD3NKjyJPNOaTpHW9FP5p4g3I4f5hXh5oCwVcACMr4KvBcIHzs/w0XFwq0UY
 dDc6SUrXguHgduaIAI5JYivR1aUMR7Qa9bGDLmSxzmlfJJGjM9++xBhrVPYRGjankM0CHp0iRb/
 BEwS6dPAT5hLAzRLnFjUb+x/Y3BLnMqCQM4ulDiBKXHOQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1759751360;
 b=QQJGs859nLM0JXoiogG38Hsl6cQ3cnc+ovx+sb/tPPaX9rmiC+P8aOmxWa+Vj71IlYcBkmM5
 XRHbWz+gHY1PZ0vMK2cQRSjY05YD9PHqdIiZ4WWcxil73aW0qo7gXqgOPBv/SDUECxOFDbMJZ1p
 kZgvDM9jvpLufcFbFq6OUnjmvv4gJU7gOkaao3RHrEtoYut2tgSFpnA8XgC9/5H7uWXIJvhLSgR
 PZtcAvjHQZNHfKqyCv45WUad8UUS4LMmgMb6cRMw1BLc0MMMh+emzKqGc9l7E9ThXBmWObPoVms
 mZgGQfWbsZL0KXTGK0eDOBYaGhDiwGMJgQvvbe6pSGo/w==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay76-hz1.antispameurope.com;
 Mon, 06 Oct 2025 13:49:20 +0200
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 67843220CBE;
	Mon,  6 Oct 2025 13:49:02 +0200 (CEST)
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
Subject: [PATCH v3 0/2] TQ-Systems TQMa62xx SoM and MBa62xx board
Date: Mon,  6 Oct 2025 13:47:46 +0200
Message-ID: <cover.1759749553.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay76-hz1.antispameurope.com with 4cgHbz2JRWz4LZB9
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:48afd15d2880b31a25c63c7ab36f7410
X-cloud-security:scantime:2.103
DKIM-Signature: a=rsa-sha256;
 bh=Nwv2x3AV2URX4eDt226Z25gIAY13bxvGxt/6sHiSWCk=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1759751360; v=1;
 b=opQIIg0N/ivILzz3T3EsyYMkWCXzCOFrntX0Qcf2jRQIpIaCP955f9upCWEFTEcdWH7Gl99P
 1JCB/Dh822LliHMXYcTFarGHhNXHWtqfzdFnIPRvcFjHg89n2sMCrpQD0wRehg1nxlaSV1KnwU2
 PuO7i0R+RU8wZOaJeAlfCkynOnRA0K1VTgTPIGf6IqwmZs5BNi0FxK8/F3DBlhpHaGjxIzp8HEm
 88fV64Jdf8r0GVou/UA14jTy7FFjmk5IlfCB3trGZnKceD+lUtCzPs8wLO34qNCPRYN9TWtijfz
 409lCfEDQJCJ7M1EzefxLGOEBD+/8LFWMQbhvTbSZK3/w==

This adds Device Trees for out AM62x-based SoM TQMa62xx and its
reference carrier board MBa62xx.

Not yet included are overlays to enable LVDS display output and MIPI-CSI
camera input.

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
 .../boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts | 928 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi | 319 ++++++
 4 files changed, 1255 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


