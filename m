Return-Path: <linux-kernel+bounces-591628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CADA7E29C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 16:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FCD71881E57
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 14:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4549A1FAC26;
	Mon,  7 Apr 2025 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="USH96wTo"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B908D1F868F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036772; cv=none; b=mVK4DU5qOQC90QnZ0F0dKRrXs5I5sT1Ioa1hP4NnUN9JleUIRc3k61CMRBLaNkyTVVzDLAATNjyBpUT68Fqlpw12Ft62vFMj0FbxFHOoYstS4wh8ym1f0x5pAMkxoffIh46biG6CE+gaTK8QqkhAzca1sfRca7a6LaysbY8ICeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036772; c=relaxed/simple;
	bh=gpdenQ1KTwrhqtRAGsdUtxPDX/0ZTIXJDe/D+TKenF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nMs+p9QSSCtwI6U8T+FPZ5Q4v3X5zQVcG7VM/vUFQw75oMO8JC5ai9nEbRAdWJ+DTUAH2Q5+QNR+WP09yZf5MdkxAuQ8wNGY/OTP0Wv6MegBS+73YjAVA0By4+TYzvcZYMOpYRdcjyT/ccpeepjpeCWmMDb7I3Kye9mHerrsgU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=USH96wTo; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3913b539aabso2589165f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Apr 2025 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744036767; x=1744641567; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAkSoBab2mcjkSikNieA7Mms82PLhiuTw+xHOZIjvOM=;
        b=USH96wToS2QK+WUQ3EfwESMwcLSpjohUHVu21tPQ5903L0huSambSn7v+1hm0dIZl2
         0KabSrMQjz3Iq9Yl1Zrae0Czg2hzUB/FyrB0pap8ODLucPF/cax6t7Y5d5uhF25Nzycf
         eTey/FgWUW0knZOxoSc022qieeo/gJ+Os6njEir0NkRYPq4f5hopRN5e1oTjp6SrqrD8
         /XoY5gxzz/p12NycwA9x1CDC+1LEAIMZUHUVTTjd9Mf8Suir/VMRK1TQdgtch5J1BWR9
         7Bkv1LapLTx1qXS2XNL78fZOc1txGoCO9+eBh1LXBs0YaSU75t1ZWM5+es4SZX5RiHIQ
         9r6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744036767; x=1744641567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAkSoBab2mcjkSikNieA7Mms82PLhiuTw+xHOZIjvOM=;
        b=BPRFxb8GqF9YALziOcuvCHtFWikLXsH1zAzEBwh0BW3hBldxcG8ioYgKdlt49muF4i
         s3QKzMGLF9tCzVcsZU8p6iqUyOvCXSquTduMfPOQ74DzmfwPBk+zrMY0/Onp3kPsIg5i
         bacO0jpFXJpWxBR51rXQ+NqLV7yMbaxxSGcf6kxj+zGk71vNKpCDmC/bku5SYQgDUnmd
         B0tT0joySgrFD9h2Gb8WTVJVaYNUfak8UbM6QY8jDHHtHjDBbicmpKZoaSUEo3Tnf9z7
         Mkod3PuDfpVq1VviyB9zPBBYlZFA0Hf8A5if3AIo9NHhS1LsSEQBxQAl3ctCa4PCX1zA
         jjug==
X-Forwarded-Encrypted: i=1; AJvYcCX2dphHEqvexffuL96c6+pTb4DzGU8vJrBYx/R3MJooPT9QkVguwnNiUHxR/E9oAvveiYNL5haIrSLvUmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTZPnqaF41lFftKjDLwNHEZEnuvvJPcJmkJZ23eC+00fUrLUQ8
	eCxuqCEJTCt74Sj3wRE7kxUCkwxn2Uk90XniJZHrZB7vpYaI7aucXh5G2cga/pg=
X-Gm-Gg: ASbGncsM98ffuVOGpcO61JiJpIulwzfRyqVIdnWNzhYyZtRiT1aJKor7IaTW9zVSg9K
	5LEAtIJZqhAicb4FtnjG8qT1TLCOjC6Sw2ewsOfoTtwg3hVFKx6WflRsmDr2w8yam03PSOTV4JE
	GbBKmNIzTyIhWdd8tfGZDEwoRhv0O3bCxXkTb/IicekmJ4H+MaZxBLhicuAnkDpyUNG/9rI2G+t
	jDVfxehco0edzUMhEXLjJg5Mi3+zIVOGkm/EBs/AsdE2pdp1P+4NRxyaKpcLVQ9nwuZEl7Gqjlr
	zzmfkqhdxddTt4pWUxodKVj2yTndPbK8kujSxNhJ2D9ShsaMDK0jz/G+A1U=
X-Google-Smtp-Source: AGHT+IHYNuBw7pt0b3N9Uj+WvpJtruSG0l3vb5tTFAlq3DYP7AsQp5Q6OxMd7vtr6bLEUuW77X9vqQ==
X-Received: by 2002:a05:6000:2509:b0:390:d6ab:6c49 with SMTP id ffacd0b85a97d-39cb35b1a8cmr12446064f8f.35.1744036766921;
        Mon, 07 Apr 2025 07:39:26 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:1122:cb29:d776:d906])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec16602bbsm135003705e9.9.2025.04.07.07.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 07:39:26 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 07 Apr 2025 16:39:07 +0200
Subject: [PATCH v3 1/3] PCI: endpoint: add epc_feature argument for
 pci_epf_free_space()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pci-ep-size-alignment-v3-1-865878e68cc8@baylibre.com>
References: <20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com>
In-Reply-To: <20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, 
 linux-nvme@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6049; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=gpdenQ1KTwrhqtRAGsdUtxPDX/0ZTIXJDe/D+TKenF4=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBn8+OauAXNd7kCvh8ELhw9UoQ+j9kAT8RJ+NjMp
 oe5ssp0vg+JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ/PjmgAKCRDm/A8cN/La
 hX83D/sHZNFS59gQ+4tjHanyRU0075HG7FzCjsrOpcn4tmq1hn+jgn6dhWO8oxjMBDCbTextQIf
 XRhqEc8ne7LwhSCmO6VJffo+woIG1kNyvVmHcnUoacePg95tTePNuTrs9K2dLUe9JTvZwwJiKuc
 zvQCcBgslxS3wyCeZrO57mYiNHr5R/6kNvQ2G7t/to2FiXiQTduj+CVkiKvG+7JX/W7FA8C9MtU
 mj61PY4DqWpdNGt5ssMYq3mkwbLpEdWoOdgz/h9iLLqHyUeLv3So091p137zgvTx7BbPm2ePh0P
 QRfjqrhJFfkGb9453ayLp+zPjxUKwAkA653DtSQJTz6pp7FTYJnHYVWqjk/lM6cEci3zKZfgU2j
 p5BMXYjoL0kO5A6/nhlMm11Qatd1scLJloJBeYmShCQSaglvY9XXMSqtsI1Xe35rklbdDlL+a2M
 7yJSGuy/qDj1MhcMcX2lM0ac4KdD40GfPY5AcwzRhZCo2eNxIRAmn/s9g0DvK05fdaBxRtjHNxC
 ouUQ9p2HWbLG+c52gHmU5kfTqYipAZMdnsN1+i9UJVyADq9UGL4MRiL4KdwEn96dANHkP/ObHKU
 I4Wj+6VnOjKQQM2sun9xo8gAfcAW3nFfH9w7cCMkhAdraLlVc5tl87BfSr5Vm5UFBY6H4qpdAAF
 c3hpgbSWFd/jwTA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Add epc_feature argument for pci_epf_free_space(), same as
pci_epf_alloc_space(). Doing so will allow to better handle
the iATU alignment requirements.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/nvme/target/pci-epf.c                 |  3 ++-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  3 ++-
 drivers/pci/endpoint/functions/pci-epf-test.c |  2 ++
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 16 +++++++++++++---
 drivers/pci/endpoint/pci-epf-core.c           |  2 ++
 include/linux/pci-epf.h                       |  1 +
 6 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 51c27b32248d0137fd3a557728eaab72fc7fca0c..2bbc41f8400837bcb83463b436598b16070e11f5 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -2174,7 +2174,8 @@ static void nvmet_pci_epf_free_bar(struct nvmet_pci_epf *nvme_epf)
 	if (!nvme_epf->reg_bar)
 		return;
 
-	pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
+	pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0,
+			   nvme_epf->epc_features, PRIMARY_INTERFACE);
 	nvme_epf->reg_bar = NULL;
 }
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index e01a98e74d211174db3075c20457a3183f37e0a5..44775c41c10b90a56b1167f3f3869a60c686cf9e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -957,7 +957,8 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
 		ntb_epc = ntb->epc[type];
 		barno = ntb_epc->epf_ntb_bar[BAR_CONFIG];
 		if (ntb_epc->reg)
-			pci_epf_free_space(epf, ntb_epc->reg, barno, type);
+			pci_epf_free_space(epf, ntb_epc->reg, barno,
+					   ntb_epc->epc_features, type);
 	}
 }
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 50eb4106369f41afa00ed3ae58c84922e0a49e51..8d5df47967226e1f02444e8d45f7aad1394afd04 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -740,6 +740,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 				      &epf->bar[bar]);
 		if (ret) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar,
+					   epf_test->epc_features,
 					   PRIMARY_INTERFACE);
 			epf_test->reg[bar] = NULL;
 			dev_err(dev, "Failed to set BAR%d\n", bar);
@@ -941,6 +942,7 @@ static void pci_epf_test_free_space(struct pci_epf *epf)
 			continue;
 
 		pci_epf_free_space(epf, epf_test->reg[bar], bar,
+				   epf_test->epc_features,
 				   PRIMARY_INTERFACE);
 		epf_test->reg[bar] = NULL;
 	}
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 874cb097b093ae645bbc4bf3c9d28ca812d7689d..8f59a5b9b7adec2c05eebae71c6a246bc5a8e88c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -389,10 +389,15 @@ static int epf_ntb_config_sspad_bar_set(struct epf_ntb *ntb)
  */
 static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
 {
+	const struct pci_epc_features *epc_features;
 	enum pci_barno barno;
 
+	epc_features = pci_epc_get_features(ntb->epf->epc,
+					    ntb->epf->func_no,
+					    ntb->epf->vfunc_no);
+
 	barno = ntb->epf_ntb_bar[BAR_CONFIG];
-	pci_epf_free_space(ntb->epf, ntb->reg, barno, 0);
+	pci_epf_free_space(ntb->epf, ntb->reg, barno, epc_features, 0);
 }
 
 /**
@@ -557,7 +562,7 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	return ret;
 
 err_alloc_peer_mem:
-	pci_epf_free_space(ntb->epf, mw_addr, barno, 0);
+	pci_epf_free_space(ntb->epf, mw_addr, barno, epc_features, 0);
 	return -1;
 }
 
@@ -570,10 +575,15 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws);
  */
 static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 {
+	const struct pci_epc_features *epc_features;
 	enum pci_barno barno;
 
+	epc_features = pci_epc_get_features(ntb->epf->epc,
+					    ntb->epf->func_no,
+					    ntb->epf->vfunc_no);
+
 	barno = ntb->epf_ntb_bar[BAR_DB];
-	pci_epf_free_space(ntb->epf, ntb->epf_db, barno, 0);
+	pci_epf_free_space(ntb->epf, ntb->epf_db, barno, epc_features, 0);
 	pci_epc_clear_bar(ntb->epf->epc,
 			  ntb->epf->func_no,
 			  ntb->epf->vfunc_no,
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 394395c7f8decfa2010469655a4bd58a002993fd..b7deb0ee1760b23a24f49abf3baf53ea2f273476 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -213,11 +213,13 @@ EXPORT_SYMBOL_GPL(pci_epf_remove_vepf);
  * @epf: the EPF device from whom to free the memory
  * @addr: the virtual address of the PCI EPF register space
  * @bar: the BAR number corresponding to the register space
+ * @epc_features: the features provided by the EPC specific to this EPF
  * @type: Identifies if the allocated space is for primary EPC or secondary EPC
  *
  * Invoke to free the allocated PCI EPF register space.
  */
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
+			const struct pci_epc_features *epc_features,
 			enum pci_epc_interface_type type)
 {
 	struct device *dev;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 879d19cebd4fc6d8df9d724e3a52fa7fbd61e535..d2d1c60fd5e0487b25aad51fee1b30554f630557 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -222,6 +222,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  const struct pci_epc_features *epc_features,
 			  enum pci_epc_interface_type type);
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
+			const struct pci_epc_features *epc_features,
 			enum pci_epc_interface_type type);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);

-- 
2.47.2


