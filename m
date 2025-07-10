Return-Path: <linux-kernel+bounces-725914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B812B00573
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2D81C443A8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFE82741D4;
	Thu, 10 Jul 2025 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xgVLx7/E"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDBA23ABA6;
	Thu, 10 Jul 2025 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158354; cv=none; b=RgNgYhv5D7y1Hk8dfOzlmfc3rPty3i9r/lP/I2r0ExpHeagBpFwpRdVl4BkJ7aWjrgMZNYlgUm4jjqx8X8v4xoYfYKTZCBkw61zDNpg/9cnkJCX7iiUyGK/o1n9SHnFLwGvb/L6wVOHHDCYHcxel/550yzGOaCzSPwSxKh+HLiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158354; c=relaxed/simple;
	bh=UCUKULXFCqD7Htou+pcidQL298jdGLI2+TJQvNLKUXk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=lJonlmoak30ComizjPkKgWy6qcVnHVSpSEa4W01OGm3IGd0+pkuRg52ZAay5dYseLVRYhjBU51WFfsXEqKs+sWldl8/hJ7uR3gvGs5fD6AtfsH/EyNC6O74Ybu2JdZE+7wWVbrSK4E/oVDtX9rVU/IevZn+veM0PNQi7Zyu8QuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xgVLx7/E; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56AEd5ce1532758;
	Thu, 10 Jul 2025 09:39:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752158345;
	bh=oSJCoY6FjmJJjlUf6QZ/7RHreKY48dRarT/BjAI0j2Y=;
	h=From:Subject:Date:To:CC;
	b=xgVLx7/E7IiqH4siAjyn8GUnxr7yeKI/AAWY/voph7hzmFaFCD2fy6VUlZ8vSSmPF
	 Y1AI3Sbxc/o+K971vTFTURSeo0jEl58UCvhbcSmGZUupQKJW2GmeWI8TbWI28jtvwZ
	 ddgBMsIgZXFpj0QnmeKpv3E8nOF2Aed1LGcIiyVI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56AEd5sS256406
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 10 Jul 2025 09:39:05 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 10
 Jul 2025 09:39:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 10 Jul 2025 09:39:04 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56AEd4Ij1518683;
	Thu, 10 Jul 2025 09:39:04 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 0/2] arm64: dts: ti: k3-am65: add boot phases to
 critical nodes
Date: Thu, 10 Jul 2025 09:38:58 -0500
Message-ID: <20250710-65-boot-phases-v2-0-d431deb88783@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAILQb2gC/3XMyw6CMBCF4Vchs3ZMW8KlrnwPw2KgU5mFlLSk0
 RDe3cre5X+S8+2QOAonuFU7RM6SJCwlzKWCaablySiuNBhlGtUpi22DYwgbrjMlTkjka6LWjV1
 voJzWyF7eJ/gYSs+SthA/p5/1b/1LZY0KWfveOtuRrfV9k+sUXjAcx/EFOaUt1akAAAA=
X-Change-ID: 20250709-65-boot-phases-aaf3aa6db782
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357; i=bb@ti.com;
 h=from:subject:message-id; bh=UCUKULXFCqD7Htou+pcidQL298jdGLI2+TJQvNLKUXk=;
 b=owNCWmg5MUFZJlNZbp/wCAAAZH///vfr6vP/63z1V/5/U/mbSh/mVX73/n/75Q7bj/re5l6wA
 RmxoxRpo00PUAAHqaAAAAAA0A9IAG1AGI0AD1AAAyDIaB6jMoek9Rmp6mh6aiANNGgZNMjTQZNA
 MhowIDRpkNBk0DQNBkGmENBkyNGhowjEBkYmmCaaNDJkDFD0npDIaA9QyGj1AANB6mEA0DRoANB
 ppoNBoyNPUGgANAAAaND1NAaPTUYagQV++6acSNM4ScM4UxgYTQnBQyawUQ1vCHAErQDreN9f3M
 lfTg5KqS++Nn7gnYDXTJokptaqIXSQqwzztsK1GUd9K9/mWQQ0oxb2Wr2ZK3OLVWYWq3AGkxz2L
 TAlIzGFenDVr0wcmy46jaOsP3urdHH59/TGO9yXjQvO/E6tVvc05X+6fLRQupcKp+iR85vLziBJ
 J8Y7MNfyrwEYYViOpYGjw6uJQJbxcIsFAG9xQiilpPDoPrZddEoSBt7fO58xjbmpv5eQiYGd6FU
 WR8q0Sq4GT7u5fNwfG16lHc8nG/CNOVklnrNRnN6zgWkEjkqRsSGI19sd09BDC2pgV205gGKj7B
 sjrYO9w+QGFy6tqEU+ObQqpjsX9dAjXZc3n/A5mfzHFgTcOHVtQcz0i6CIudP2RuocjmHYPgWet
 ZHpmmEy/f8XckU4UJBun/AI
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello everyone!

To save precious on chip RAM space during bootup 'bootph-*' flags was 
added to the dt-schema to describe which nodes need to be present during 
each phase of the bootup process and which can be pruned to recover RAM 
space that would otherwise be wasted.

This small series adds the bootph-all flags to all the boot critical 
nodes for all boards that utilize the AM65x as well as to the AM65's 
reference board.

Happy Hacking
~Bryan

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v2:
- removed tag from &mcu_udmap{} node
- Link to v1: https://lore.kernel.org/r/20250709-65-boot-phases-v1-0-e1f89d97a931@ti.com

---
Bryan Brattlof (2):
      arm64: dts: ti: k3-am65: add boot phase tags
      arm64: dts: ti: k3-am654-base-board: add boot phase tags

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi       |  1 +
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi        |  1 +
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi     |  5 +++++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 17 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso |  1 +
 arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso |  1 +
 6 files changed, 26 insertions(+)
---
base-commit: 3b08f8a34a2061d89a2411d04a675b3860d4f9cc
change-id: 20250709-65-boot-phases-aaf3aa6db782

Best regards,
-- 
Bryan Brattlof <bb@ti.com>


