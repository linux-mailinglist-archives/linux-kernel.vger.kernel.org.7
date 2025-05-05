Return-Path: <linux-kernel+bounces-632701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A24AA9AEB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 19:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1181A8089B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 17:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A0026FDB2;
	Mon,  5 May 2025 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xkeNNnlw"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB32154425
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466932; cv=none; b=Osn65LepvS9S//fL5K+YcOhOf7xEgbl2gcRKm2pFo7loZavukb+yvdzLK+ek07U1fOI/gvLAVGkE8KFPa1yV11vMdbbTFh5CSv6ogd15xu2vJROoFtixD3ZUC3qnJXFU2N8jL727C/WTmhgecizz418c5SMQE8yHtfIfaKuVJMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466932; c=relaxed/simple;
	bh=B+qwCUY3eq14vw47Zfe4vuilfWwGDTVLmI1jZLIuLsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rfi6EkxSKC688lfRmu56p+dhu/anfQ7SA+BUELgUBbS4jetCA/4rYs5RNGwaXS9d75RL5FLGW/cOK+OXTC66F7cTz36jOHKHW+mS14mA4QAP8oZXI5omDBft+S11q7U7ewIghV77gsUR4WDYBP05IPcCPB7crAk9alvl4b6dnk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xkeNNnlw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c0e0bc733so4510745f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 May 2025 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746466928; x=1747071728; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vGqWxZm/m2TQpVxIBgE41j6Cssz2HeDjBc3cPlm+w3E=;
        b=xkeNNnlwYhx8iK7e8iYeFGuz/hb9P+wH7xuzfYxh3SGYnytm0iVcI1R1L1hAnvMUM0
         CbViZ40C3fNClADQocg7YlrM9VMduR+hYKafR0CxJtNfAJDQNFM/2xqRwmdQQCUtU8UJ
         YGt03rn744hRzH8WV3+oPfmEfyf9JC6lScQfndxiJWEnuzIwCL7UBF3Bsup9+gXU39zO
         dLpC5vQtfo34T5G6HmUcChZjmFR5UktW4cViBcPd9hT6xGK0iff4PZkt3OAaxxJqvozM
         4c0XfvzQIliFlXz0tcxZ/BRRenoQDVKNtTpXJz9yDogEPr+ZQyLnrWoX64kyAjzyWbib
         2vvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746466928; x=1747071728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGqWxZm/m2TQpVxIBgE41j6Cssz2HeDjBc3cPlm+w3E=;
        b=lbe+GG8Bu34NrVtmgvNF6iZlxcL7zN/Knj89fq+HiHYrzD1vz2NslGcv33Y39dONxm
         70Usger0qhHPn03OHOpfMpTN0/zbX4mPsIp8bMk/HqW01HcYxCyzfzTScqkcMrQQqHZc
         Rl3LvsswRW8Dep5UnIsWxw+t2BNRIz7y6X1ynxKLV+aEqact6RiKfAmfJJjuXCbTORXH
         AORJweG33uADnEfje5WNfZgBfxjHbI3JklH1qb4Xa/44f+CmkI7qoBWxXLNS10BH+l2d
         RC9e0kiJLCbSB8Q387m1sfFu1xrMn6hlIbwHeemNoMKUqJfFFk8WSJ3gimddpO004Cnt
         +F4g==
X-Forwarded-Encrypted: i=1; AJvYcCV22ajqwMRrsal+MWso07w6kCzDnE6YI/CDiLdzdq8j/ePaM2nzJy5UEa7cCCpBaoVtYA3byNA19Svw3TY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy73L2E28Wq6pTVS9eIW0KQk7VrvLLi89lft8hqK8kqwWa+WSxc
	k59CaQMO37yH7ENj5yAyKnshY04lcfwNBVc7srCBbmgdPwbLTyXipcjbj8oyyUc=
X-Gm-Gg: ASbGnctN4sSvZBoLo0QvqWQXRNf2baaf8ST1+CUby4INKTI1kD7rvATV21T2GVyKjwo
	+achgjfMWaNiFmbIEtuMeTPodwO70CmN0otTYGY2JigoTtLwyal8jyywytb5A13ymgz1X9IlLuL
	U4UIOdtwmeMcNsMzGNuftbivboOPmmqNFKEzKmJCBSPzCcxvc5+z7QlICbnMlG6CrLTIb9PZjDN
	w39j81kVu4mtUsd2W9xp1q6+fX0VVOrUOhOaCaA4oQybQURvAxGoI8nF6In1Lt9tDqb0aK18dmZ
	GtKDvvNgTVqYjQaHECiTmy24E67Hp/9hEP1IQF6wi58ytsLX340FdA==
X-Google-Smtp-Source: AGHT+IFO5ZOl3WbSVm06FVhgd/i3dra5ZvGLeZpLS1wCgTAqjLTG4sEOT/fzcnQ6TFzk2Xp7wmzK2w==
X-Received: by 2002:a05:6000:18ab:b0:391:3049:d58d with SMTP id ffacd0b85a97d-3a09fd11b24mr5996162f8f.0.1746466928504;
        Mon, 05 May 2025 10:42:08 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:dc81:e7a:3a49:7a3b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a099b0efbfsm11345829f8f.69.2025.05.05.10.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 10:42:08 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 05 May 2025 19:41:50 +0200
Subject: [PATCH 4/4] NTB: epf: Allow arbitrary BAR mapping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pci-vntb-bar-mapping-v1-4-0e0d12b2fa71@baylibre.com>
References: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
In-Reply-To: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7212; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=B+qwCUY3eq14vw47Zfe4vuilfWwGDTVLmI1jZLIuLsY=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoGPhr38FAeaNtY9Pmu/YdTa9ik8dKaILGYk8oq
 Xel3jbhWmqJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaBj4awAKCRDm/A8cN/La
 hfhHD/90J4gK6A31RqSKPgeIQXRjUH9eyvbVh4A/PuFXF1XX4TQCotey6uRmw4Aplx3+5V3fatO
 b1V4nFxskxpg3nb+ECjODvnssQIIMBXB73EHUCL5/Vg+xbQ89xP5UkvZ86eggE5Z3TN0YuXKUhU
 v/o/us4hQNtIkjw3e3i1tYGr6z8M1ULHyZCjSc9WHm27iNhvYR4vo3I7Q3bkYKc6Qp0ZtF7RpkG
 FvXdjg6UO0LQeJ9TMKxwt08eF80IGAhYyFPhdBnyvNwecATg4JWnZcj9DVme2CerMivw41FWbyW
 gheWZHhL6P6RGmZqK/iGLdOyAuqJbKkPolo/k5/iXCYbiIXxRjIgLCF/D+5ROloKx5FetEOCMVg
 nlb8wbe3AqdI92LC+ynKxF5bwUyQMmjfvPmsGKXDSXffJ/+KrEXrJPyM0cAAY2FSb9m1UU4QVgr
 Ccv5clQm2PHESZCDmeNb7PW7d/KxLwRFxzKVXfzmSN6iOL3zQL9Xl7d9r6QobmFrJsKmam/p5kc
 JOWGylE38kUJUJoK9IqWp3+YfwE3sVyDBHDTExMe2HvV+RVFlKri6T6ZQslkq5AzVYsNeA9Nzcc
 RAjG3iWfl1v2jc7iVy2TNyGfz3J1LdAp/IjrUMj1oeKb0LF3oAF2NsLvjCoZ8du/6u70MF7QDFv
 M1jf4inORmEjvOg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The NTB epf host driver assumes the BAR number associated with a memory
window is just incremented from the BAR number associated with MW1. This
seems to have been enough so far but this is not really how the endpoint
side work and the two could easily become mis-aligned.

ntb_epf_mw_to_bar() even assumes that the BAR number is the memory window
index + 2, which means the function only returns a proper result if BAR_2
is associated with MW1.

Instead, fully describe and allow arbitrary NTB BAR mapping.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 108 ++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 53 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 00f0e78f685bf7917b02dd8a52b5b35f68d5bb64..9539cdcd0f8fa4b5c5e66477672f8f97d5ec4e52 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -49,6 +49,7 @@
 #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
 
 enum pci_barno {
+	NO_BAR = -1,
 	BAR_0,
 	BAR_1,
 	BAR_2,
@@ -57,16 +58,26 @@ enum pci_barno {
 	BAR_5,
 };
 
+enum epf_ntb_bar {
+	BAR_CONFIG,
+	BAR_PEER_SPAD,
+	BAR_DB,
+	BAR_MW1,
+	BAR_MW2,
+	BAR_MW3,
+	BAR_MW4,
+	NTB_BAR_NUM,
+};
+
+#define NTB_EPF_MAX_MW_COUNT	(NTB_BAR_NUM - BAR_MW1)
+
 struct ntb_epf_dev {
 	struct ntb_dev ntb;
 	struct device *dev;
 	/* Mutex to protect providing commands to NTB EPF */
 	struct mutex cmd_lock;
 
-	enum pci_barno ctrl_reg_bar;
-	enum pci_barno peer_spad_reg_bar;
-	enum pci_barno db_reg_bar;
-	enum pci_barno mw_bar;
+	const enum pci_barno *barno;
 
 	unsigned int mw_count;
 	unsigned int spad_count;
@@ -85,17 +96,6 @@ struct ntb_epf_dev {
 
 #define ntb_ndev(__ntb) container_of(__ntb, struct ntb_epf_dev, ntb)
 
-struct ntb_epf_data {
-	/* BAR that contains both control region and self spad region */
-	enum pci_barno ctrl_reg_bar;
-	/* BAR that contains peer spad region */
-	enum pci_barno peer_spad_reg_bar;
-	/* BAR that contains Doorbell region and Memory window '1' */
-	enum pci_barno db_reg_bar;
-	/* BAR that contains memory windows*/
-	enum pci_barno mw_bar;
-};
-
 static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
 				u32 argument)
 {
@@ -144,7 +144,7 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
 		return -EINVAL;
 	}
 
-	return idx + 2;
+	return ndev->barno[BAR_MW1 + idx];
 }
 
 static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
@@ -413,7 +413,9 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 		return -EINVAL;
 	}
 
-	bar = idx + ndev->mw_bar;
+	bar = ntb_epf_mw_to_bar(ndev, idx);
+	if (bar < 0)
+		return bar;
 
 	mw_size = pci_resource_len(ntb->pdev, bar);
 
@@ -455,7 +457,9 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 	if (idx == 0)
 		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
 
-	bar = idx + ndev->mw_bar;
+	bar = ntb_epf_mw_to_bar(ndev, idx);
+	if (bar < 0)
+		return bar;
 
 	if (base)
 		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
@@ -557,8 +561,13 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 	}
 
 	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
-	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
 	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
+	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
+
+	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
+		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
+		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -596,14 +605,14 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
 		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
 	}
 
-	ndev->ctrl_reg = pci_iomap(pdev, ndev->ctrl_reg_bar, 0);
+	ndev->ctrl_reg = pci_iomap(pdev, ndev->barno[BAR_CONFIG], 0);
 	if (!ndev->ctrl_reg) {
 		ret = -EIO;
 		goto err_pci_regions;
 	}
 
-	if (ndev->peer_spad_reg_bar) {
-		ndev->peer_spad_reg = pci_iomap(pdev, ndev->peer_spad_reg_bar, 0);
+	if (ndev->barno[BAR_PEER_SPAD] != ndev->barno[BAR_CONFIG]) {
+		ndev->peer_spad_reg = pci_iomap(pdev, ndev->barno[BAR_PEER_SPAD], 0);
 		if (!ndev->peer_spad_reg) {
 			ret = -EIO;
 			goto err_pci_regions;
@@ -614,7 +623,7 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
 		ndev->peer_spad_reg = ndev->ctrl_reg + spad_off  + spad_sz;
 	}
 
-	ndev->db_reg = pci_iomap(pdev, ndev->db_reg_bar, 0);
+	ndev->db_reg = pci_iomap(pdev, ndev->barno[BAR_DB], 0);
 	if (!ndev->db_reg) {
 		ret = -EIO;
 		goto err_pci_regions;
@@ -656,15 +665,20 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
 	pci_free_irq_vectors(pdev);
 }
 
+static const enum pci_barno ntb_epf_default_barno[NTB_BAR_NUM] = {
+	[BAR_CONFIG]	= BAR_0,
+	[BAR_PEER_SPAD]	= BAR_1,
+	[BAR_DB]	= BAR_2,
+	[BAR_MW1]	= BAR_2,
+	[BAR_MW2]	= BAR_3,
+	[BAR_MW3]	= BAR_4,
+	[BAR_MW4]	= BAR_5
+};
+
 static int ntb_epf_pci_probe(struct pci_dev *pdev,
 			     const struct pci_device_id *id)
 {
-	enum pci_barno peer_spad_reg_bar = BAR_1;
-	enum pci_barno ctrl_reg_bar = BAR_0;
-	enum pci_barno db_reg_bar = BAR_2;
-	enum pci_barno mw_bar = BAR_2;
 	struct device *dev = &pdev->dev;
-	struct ntb_epf_data *data;
 	struct ntb_epf_dev *ndev;
 	int ret;
 
@@ -675,18 +689,10 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
 	if (!ndev)
 		return -ENOMEM;
 
-	data = (struct ntb_epf_data *)id->driver_data;
-	if (data) {
-		peer_spad_reg_bar = data->peer_spad_reg_bar;
-		ctrl_reg_bar = data->ctrl_reg_bar;
-		db_reg_bar = data->db_reg_bar;
-		mw_bar = data->mw_bar;
-	}
+	ndev->barno = (const enum pci_barno *)id->driver_data;
+	if (!ndev->barno)
+		ndev->barno = ntb_epf_default_barno;
 
-	ndev->peer_spad_reg_bar = peer_spad_reg_bar;
-	ndev->ctrl_reg_bar = ctrl_reg_bar;
-	ndev->db_reg_bar = db_reg_bar;
-	ndev->mw_bar = mw_bar;
 	ndev->dev = dev;
 
 	ntb_epf_init_struct(ndev, pdev);
@@ -730,30 +736,26 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
 	ntb_epf_deinit_pci(ndev);
 }
 
-static const struct ntb_epf_data j721e_data = {
-	.ctrl_reg_bar = BAR_0,
-	.peer_spad_reg_bar = BAR_1,
-	.db_reg_bar = BAR_2,
-	.mw_bar = BAR_2,
-};
-
-static const struct ntb_epf_data mx8_data = {
-	.ctrl_reg_bar = BAR_0,
-	.peer_spad_reg_bar = BAR_0,
-	.db_reg_bar = BAR_2,
-	.mw_bar = BAR_4,
+static const enum pci_barno mx8_barno[NTB_BAR_NUM] = {
+	[BAR_CONFIG]	= BAR_0,
+	[BAR_PEER_SPAD]	= BAR_0,
+	[BAR_DB]	= BAR_2,
+	[BAR_MW1]	= BAR_4,
+	[BAR_MW2]	= BAR_5,
+	[BAR_MW3]	= NO_BAR,
+	[BAR_MW4]	= NO_BAR,
 };
 
 static const struct pci_device_id ntb_epf_pci_tbl[] = {
 	{
 		PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
 		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
-		.driver_data = (kernel_ulong_t)&j721e_data,
+		.driver_data = (kernel_ulong_t)ntb_epf_default_barno,
 	},
 	{
 		PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x0809),
 		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
-		.driver_data = (kernel_ulong_t)&mx8_data,
+		.driver_data = (kernel_ulong_t)mx8_barno,
 	},
 	{ },
 };

-- 
2.47.2


