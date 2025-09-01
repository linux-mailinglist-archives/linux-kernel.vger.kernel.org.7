Return-Path: <linux-kernel+bounces-794533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F5CB3E2F6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC306202977
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F2F337690;
	Mon,  1 Sep 2025 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gmgsrrmi"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEF73218DC;
	Mon,  1 Sep 2025 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729731; cv=none; b=WVcypXapNYKohaDsBFeIL6yo1psAiyHGcOWhBDl3pz/WGvzlPFnbFs3ROy9aKgu7hNSbHfwkOWmFtJvq6IrXhbbFMwBzGjz4FYAQaOSCoIfnkFuLqiTiUm0yJUwNqeHJYl/7oHABVp7pQaKycqXAzuZawMZ9aqT5ZgeOPrt1KAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729731; c=relaxed/simple;
	bh=uejZlFZAQvm5LVOPmSaXpDAhQ1NaqJbprex1xkoqfSI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gZHhac82u9q18SP0eEetiYxtqYJS4LjgAqvLWF/OE3bdtn+imOIDDtCmLQIFVk5vyeQKSFI8pmw/4eT3MoXjRtMJvspPE5A5CPvUn6AiAL2457qaTvEagR2m4myTodED9nAYg3UyZnVHl5dfmMBUMsqQaXtimZKnEAjXQA5b8cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gmgsrrmi; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 581CShP42770740;
	Mon, 1 Sep 2025 07:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756729723;
	bh=DyKTAE05zd7hVVcF/gkWKFhYS53prSAmivAbUQbAj3Y=;
	h=From:To:CC:Subject:Date;
	b=gmgsrrmib18epn0MWP9GOGEk+Xso4j/+4SpJlIwnytRUOBN5ni9+SP2BqYVCeJ4M9
	 jINnqILztwqgtyNloJirDTqMqNByKtyvcRn4/e7Z+E+lk/Eozh0qy8Df6aLtQtUXkG
	 9Aw3fGu7ERf7WrUuBzTvldSV3Wg4TWEYwYLAzEEs=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 581CSh9a2721477
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 1 Sep 2025 07:28:43 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 1
 Sep 2025 07:28:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 1 Sep 2025 07:28:42 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 581CSc7q2504775;
	Mon, 1 Sep 2025 07:28:39 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>,
        <d-gole@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>
Subject: [PATCH v2 0/3] Remove unused bits from dts and add support for remaining pinctrl macros 
Date: Mon, 1 Sep 2025 17:58:32 +0530
Message-ID: <20250901122835.3022850-1-a-kaur@ti.com>
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

This patch series cleans up the dts files to remove the pin control DeepSleep 
configuration that does not take effect in hardware.
This series also adds the remaining macros in the pin control file 
supported by SoC so that any configuration can be used as per requirement 
in dts files.

Akashdeep Kaur (3):
  arm64: dts: ti: k3-am62p5-sk: Remove the unused config from
    USB1_DRVVBUS
  arm64: dts: ti: k3-am62x-sk-common: Remove the unused config from
    USB1_DRVVBUS
  arm64: dts: ti: k3-pinctrl: Add the remaining macros

 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |  2 +-
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  2 +-
 arch/arm64/boot/dts/ti/k3-pinctrl.h           | 55 ++++++++++++++++++-
 3 files changed, 54 insertions(+), 5 deletions(-)

-- 
2.34.1


