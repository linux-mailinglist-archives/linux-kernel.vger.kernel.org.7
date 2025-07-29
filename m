Return-Path: <linux-kernel+bounces-749127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF387B14A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29EF816AA21
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0AD285C86;
	Tue, 29 Jul 2025 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WPanjw30"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E7828507B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778952; cv=none; b=orRBMT4aid9enT/Az5/0xorYPqLO1c9P93IgwErQAqucCBtemwUK+umvCc5TJcr5sCujex5+KyV6f2yMIbqf+1jDSn4eO2AfaJTb2JylyskfroXfqILFvZ50qGn6C6OBuh8eQ8dSmqXBKt2bw6RFaa8YLyROue+1kwYElCLAsXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778952; c=relaxed/simple;
	bh=Vf1eFM5yZ6nnjibfmczURk97fD3seBESLOHYvhUn8OE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GY8QWZmp09/C+WWjC+uALrMJVyyZOQ1Uy4PrVs2A9/jiHQQxHiQIBJYj4OmoH7nrrrgL6p8iEKl5ybJlNuiLjQrI7GNf5QLghP3zGOmZ2OW4gPRAaLlmw2xR0hD9vIS38rISOzujByXUjdb6wuRG01g7U8d+mkBWm43bgLNQFpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WPanjw30; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7nwHU016225;
	Tue, 29 Jul 2025 01:48:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=dC1l2Kr1gTPn6e3ySSguiqQ
	Quq32M7Wg4iyZ9FRv1UQ=; b=WPanjw30ewJfBXicincBxiNIzOjnxVicL8vOyUX
	3F4WCR6Kp4A8yumqbcKgxzV/I8mSUJ+O3lRA3s7Y+tnD0uILEZ/4zxGRxzCTIle2
	gy/wPuMSW228U3yZFB47JCtGGmVT5/mTWWwwXRdMD0ztFwBJCXlhvoXa0Wi7stS6
	KEvGHb9VOpb/oooueiu+gJx7sNEl3WUoTH9KaKuC/qAmxDeMyNLAa0UaXKsKIRfe
	ewEgh/Iq4dyoxH48QxnqhDv5pVA747TVlzQGlLbl5MfR9GOQnimyyuUDy1dXnEkL
	SEIvtreUCZhcoh/avd07mYSE52euoIXwfLPYn6GDjc1x9LQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 486t86g3qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 01:48:35 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 29 Jul 2025 01:48:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 29 Jul 2025 01:48:36 -0700
Received: from c1illp-saixps-016.eng.marvell.com (c1illp-saixps-016.eng.marvell.com [10.205.40.247])
	by maili.marvell.com (Postfix) with ESMTP id BB4243F7053;
	Tue, 29 Jul 2025 01:48:32 -0700 (PDT)
From: <enachman@marvell.com>
To: <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH] irqchip/mvebu-gicp: clear pending irqs on init
Date: Tue, 29 Jul 2025 11:48:26 +0300
Message-ID: <20250729084826.3222785-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: mhCc1890rHyS8Qi2IpBOiKkGQ_cba2WD
X-Proofpoint-ORIG-GUID: mhCc1890rHyS8Qi2IpBOiKkGQ_cba2WD
X-Authority-Analysis: v=2.4 cv=YLSfyQGx c=1 sm=1 tr=0 ts=68888ae3 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=dGVNLvYjXAbngGU7jv8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA2NyBTYWx0ZWRfX/n+03sKb1Elf b21G7HXARViRjUyGceyM6bL7J5mNAgU/t0HwKwslftIJh1e5kxN3PeQxBml43KoO7HMwNC4gvL9 vml2O7w4VnoVrv8XhdLqJyV/REf2MDPe3kFmjPPGkaCwilK2NsdEDSL3SHzEtr6vXpwKtyACiN1
 SZBqDDDORi+PxLls3wah1haHwX/03WvBBO4XgPf+Jv4y0AZX1l5incitakuuvLsWtqS3Zdo+jK3 6M1EI3V19GW9UhC1AJecUtVxNUrDvyiIHqriRTeUKpOWlUzm+cymjuS8Q/TvJ9Ufm73V2RSn2/q T5UdPd/nD0DrC9VHdJcsFzf6jJibwjct9Fv98h8EIErtZWKyCiY1nn3YrfDNwKQUIRmo4M4EXj9
 iRQi6avQMSAIMQ4Gx6T7425/8S9xNkYvF3YQMGLMpMoHy1z5gfS8mFhtmPumr2z7QIv56iod
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01

From: Elad Nachman <enachman@marvell.com>

For kexec case, left interrupt might generate spurious
interrupts in various A7/A8/CN913x interrupt system
from the I/O SB to the NB. Clear all pending interrupts
when the driver is initialized to prevent these spurious
interrupts.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/irqchip/irq-mvebu-gicp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
index d3232d6d8dce..0fa21a45d4e1 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -31,6 +31,7 @@ struct mvebu_gicp_spi_range {
 
 struct mvebu_gicp {
 	struct mvebu_gicp_spi_range *spi_ranges;
+	void __iomem *base;
 	unsigned int spi_ranges_cnt;
 	unsigned int spi_cnt;
 	unsigned long *spi_bitmap;
@@ -236,6 +237,14 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	gicp->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(gicp->base))
+		dev_err(&pdev->dev, "gicp - Cannot ioremap !\n");
+	else {
+		for (i = 0; i < 64; i++)
+			writel(i, gicp->base + GICP_CLRSPI_NSR_OFFSET);
+	}
+
 	return msi_create_parent_irq_domain(&info, &gicp_msi_parent_ops) ? 0 : -ENOMEM;
 }
 
-- 
2.25.1


