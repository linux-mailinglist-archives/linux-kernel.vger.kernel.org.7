Return-Path: <linux-kernel+bounces-787058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3867B370DF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C9B367195
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355D42E718B;
	Tue, 26 Aug 2025 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MuECljJ9"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C9A2E285B;
	Tue, 26 Aug 2025 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227838; cv=none; b=H2pwXsxW5ArKOyq4E5QZSj3z3VKPbYKxEIpouSF42W/6+0ShP9I1kbrsDISIwvH+QFxu4FN+8ag2pP1BtxGvPh+rbpCr+yc2QADDV4t1pn0NzIcWE+wiEw0UYXSW8aLc24LF27oubj0aYF1lbxlL/PGBl83OCZCVZpwISih/TXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227838; c=relaxed/simple;
	bh=/WFpPBskMWBkdGVSacMhxhni4z2VHYUPoxSJMhvCRps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RApVZNHukpF78U9VqbAjawTp0jJWbJ/jGz+cdaBs6CRgbIhd2EL0Wz/Z5TAIjdQWqFAjiEVhMSJ1UlM+PEZvjmpM78tjtE9hruKu1vJn009VNklcZ1OBon4gqsUH2vxax9ZYkJy0lyPtbSlC5OkyZfi2uMupvmjnYQeTx9zgdyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MuECljJ9; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=k9
	vi2+U0ISlZpQf9ZsfxllqYwUzu1si7Y3nLS7lJb8g=; b=MuECljJ9l463ApcpWq
	oh1Ut2twyhVL3ktcTc5N4XUFpxCeea8KJ5bYwn0cbtSGniMlUizohCBB1xICvls2
	JbngcfFBE0Vui8vk81vmaGRWOqfSnvErvqqBGIcthb72k17ExCeO6UbqidcKGAnF
	S9VDFT1zpL9r2eI1tckc3RDQU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAH5Svt6K1o9DIiEg--.25085S5;
	Wed, 27 Aug 2025 01:03:43 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 3/8] PCI: Add macro for link status check delay
Date: Wed, 27 Aug 2025 01:03:10 +0800
Message-Id: <20250826170315.721551-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250826170315.721551-1-18255117159@163.com>
References: <20250826170315.721551-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH5Svt6K1o9DIiEg--.25085S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF1UKw1xur1fCF13trW8WFg_yoWDJrX_u3
	sFvF4xWrW0kF9xK3y29r1fZrya93Z3WF4xuF97tFyfAFy7GryY9Fyjvr1DJa13WayrAF12
	v3srtF1rCrn2kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUxR67UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQxi1o2it56YcgAAAsV

Add PCIE_LINK_STATUS_CHECK_MS macro for link status check delay.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 81105dfc2f62..f5f5474d9aba 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -77,6 +77,8 @@ struct pci_pme_device {
  */
 #define PCIE_RESET_READY_POLL_MS 60000 /* msec */
 
+#define PCIE_LINK_STATUS_CHECK_MS 1
+
 static void pci_dev_d3_sleep(struct pci_dev *dev)
 {
 	unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);
@@ -4683,7 +4685,7 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
 		if ((lnksta & lnksta_mask) == lnksta_match)
 			return 0;
-		msleep(1);
+		msleep(PCIE_LINK_STATUS_CHECK_MS);
 	} while (time_before(jiffies, end_jiffies));
 
 	return -ETIMEDOUT;
-- 
2.25.1


