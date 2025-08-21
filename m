Return-Path: <linux-kernel+bounces-778998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646E6B2ED9E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17480A214A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7733B221540;
	Thu, 21 Aug 2025 05:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UqLH1ane"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEEF156F45
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755754784; cv=none; b=S11p0lPbHAFWBV7Fy1a1TMNfQSO5pOOcsikdGXgLU/n76p4ymvU17X+/MhhyoBGKhT8TlCN1/6DX0vFnHD41PyWnyhdjyqgMhnpdvf2uCJT7PsLrD9PK9jXWF0udCttabdxqLRBqAZsvYI4Jq6IEpn7/ZwT+JIcgAMydNClE8Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755754784; c=relaxed/simple;
	bh=ZVRwY9UyLmfELmyQd5FagKf90snoN1VTuvCXhRUjQIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=sWAOLjC1WOIj15pwkz1d7uRfcVkydj/oBCA+/wUNvmVPy7vGwi7ljjRCZFP5/QAlYKb+NOidFSgLBxBtsjZqdcc9rvPgB6V2pStD7FSoL7Wfw/yxrlZxHdv5t0WRvOAUtcWKqBA8YjVZ+lKZungaPhaVSJQ3Aa73e+RTxox9o1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UqLH1ane; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250821053940epoutp024e027f622d17e8267a66865fd9099a91~dsaudFWl41951819518epoutp02M
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:39:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250821053940epoutp024e027f622d17e8267a66865fd9099a91~dsaudFWl41951819518epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755754780;
	bh=iH1pwxK5h8zaKzLO7uEYoulOZ2jTl+7LVkze5OMti3Y=;
	h=From:To:Cc:Subject:Date:References:From;
	b=UqLH1anezpMgkpJFrzoFNEKYKnY5vpRY7ZHr3sZLRJWO0b3uIvCxQgnBVOSHJM5Io
	 pov+eunBZbJ9cSBfYslaiXiMyZClxceGLxszOgUXHLDRSwjICDIsiEciUzvH7kSJN8
	 Lp/3mg7dsttnWo2aGvRX1gvTX5odsDgscs6Rio9A=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250821053939epcas5p451a25e767d61cfc0fb9a429634edaef2~dsat5sUIU0911909119epcas5p44;
	Thu, 21 Aug 2025 05:39:39 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.95]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4c6sZy6y6Nz6B9m9; Thu, 21 Aug
	2025 05:39:38 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250821053938epcas5p290f78790250d8cb09df2f35e45624359~dsasrxHFk0873308733epcas5p2Z;
	Thu, 21 Aug 2025 05:39:38 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250821053936epsmtip26f716bb48a68fd77790a74e134ba5da4~dsarKv-TI2276922769epsmtip2X;
	Thu, 21 Aug 2025 05:39:36 +0000 (GMT)
From: Bharat Uppal <bharat.uppal@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	linux-samsung-soc@vger.kernel.org
Cc: pankaj.dubey@samsung.com, aswani.reddy@samsung.com, Bharat Uppal
	<bharat.uppal@samsung.com>, Nimesh Sati <nimesh.sati@samsung.com>
Subject: [PATCH] scsi: ufs: exynos: fsd: Gate ref_clk and put UFS device in
 reset on suspend
Date: Thu, 21 Aug 2025 11:09:23 +0530
Message-ID: <20250821053923.69411-1-bharat.uppal@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250821053938epcas5p290f78790250d8cb09df2f35e45624359
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250821053938epcas5p290f78790250d8cb09df2f35e45624359
References: <CGME20250821053938epcas5p290f78790250d8cb09df2f35e45624359@epcas5p2.samsung.com>

On FSD platform, gating the reference clock (ref_clk) and putting the
UFS device in reset by asserting the reset signal during UFS suspend,
improves the power savings and ensures the PHY is fully turned off.

These operations are added as FSD specific suspend hook to avoid
unintended side effects on other SoCs supported by this driver.

Signed-off-by: Nimesh Sati  <nimesh.sati@samsung.com>
Signed-off-by: Bharat Uppal <bharat.uppal@samsung.com>
---
 drivers/ufs/host/ufs-exynos.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 3e545af536e5..4d0f7d6b84fe 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1896,6 +1896,13 @@ static int fsd_ufs_pre_pwr_change(struct exynos_ufs *ufs,
 	return 0;
 }
 
+static int fsd_ufs_suspend(struct exynos_ufs *ufs)
+{
+	exynos_ufs_gate_clks(ufs);
+	hci_writel(ufs, 0, HCI_GPIO_OUT);
+	return 0;
+}
+
 static inline u32 get_mclk_period_unipro_18(struct exynos_ufs *ufs)
 {
 	return (16 * 1000 * 1000000UL / ufs->mclk_rate);
@@ -2162,6 +2169,7 @@ static const struct exynos_ufs_drv_data fsd_ufs_drvs = {
 	.pre_link               = fsd_ufs_pre_link,
 	.post_link              = fsd_ufs_post_link,
 	.pre_pwr_change         = fsd_ufs_pre_pwr_change,
+	.suspend                = fsd_ufs_suspend,
 };
 
 static const struct exynos_ufs_drv_data gs101_ufs_drvs = {
-- 
2.49.0


