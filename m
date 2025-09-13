Return-Path: <linux-kernel+bounces-815070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C89B55F01
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 08:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC87D1C88312
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 06:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8DE2E7F12;
	Sat, 13 Sep 2025 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lTVQc5XA"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82ED2E7BA0;
	Sat, 13 Sep 2025 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757745773; cv=none; b=pc3oi7z31WXzZdN2KiWkut0J1x1rnT3GGQFWbR/i6BrKKSMwnmkPhWaMCs7VuRcJO2gfwDdZXPksba5mzCrsq+XWm73vvC1iiwvM38UlslZzCwW85ssGDiqiB76jhU1DwJXCJs1XDTY2hWvke4aRfY0WbjvHZMTdH1SEnhv6rJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757745773; c=relaxed/simple;
	bh=99vNy5PDPTWA4oW6Oa12RA2++f17bRBwUE5j36/8OSY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c9SBRp/79OjvGB9CwbuO8xyGT9K6iNdpjmfDdEGzY3loqO2b3mSLG5QXKdlOpGSTZcTt/uvL0NS6Hl4J2xBc26fJFQ7dwFaRafyouoCgmSqeG3z5Ns0hbncmogdIyx4OHk6k4ILqRPcXDyyEmau9s1qy6933p7EEGVV2AuBsNrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lTVQc5XA; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58D6gDnc664120;
	Sat, 13 Sep 2025 01:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757745733;
	bh=3OZQiGNMXfE/ACLETEfEQUWdCU873vCZ6upELcnL4J0=;
	h=From:To:CC:Subject:Date;
	b=lTVQc5XAWzgdG3o6NtWPFM1v9sK6VgozTzX2U2qLMgwJYTqtswUw39nO0TGKrXsPd
	 VzN8/4V5TQSZC/IQ50D6vRtggPX2CRbR4KXWS5z5J4yFdIAb+Ncjw/tazdsrlBj3EL
	 BHPXlLTyEpRJBSguH8Kz+eY//H8QwMB7wkAQh1uQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58D6gDXY1841141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 13 Sep 2025 01:42:13 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 13
 Sep 2025 01:42:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 13 Sep 2025 01:42:12 -0500
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58D6g5uw543875;
	Sat, 13 Sep 2025 01:42:06 -0500
From: Swamil Jain <s-jain1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jyri.sarha@iki.fi>,
        <tomi.valkeinen@ideasonboard.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <simona@ffwll.ch>, <aradhya.bhatia@linux.dev>
CC: <h-shenoy@ti.com>, <devarsht@ti.com>, <praneeth@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <s-jain1@ti.com>
Subject: [PATCH 0/2] Enable OLDI support on AM62X
Date: Sat, 13 Sep 2025 12:12:03 +0530
Message-ID: <20250913064205.4152249-1-s-jain1@ti.com>
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

The AM62x SoC features 2 OLDI TXes each, which makes it possible to
connect them in dual-link or cloned single-link OLDI display modes. This
series enables OLDI support on AM62X[1].

[1]: https://www.ti.com/product/AM625

Aradhya Bhatia (2):
  arm64: dts: ti: k3-am62: Add support for AM625 OLDI IO Control
  arm64: dts: ti: k3-am625: Add OLDI support

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 52 ++++++++++++++++++++++++
 1 file changed, 52 insertions(+)


