Return-Path: <linux-kernel+bounces-617792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8B5A9A5FA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 10:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38181B84CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 08:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7922147EA;
	Thu, 24 Apr 2025 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rrluGAZF"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D6E20E70A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745483669; cv=none; b=EmAvjHCujw1zrYMmk3B7deXIBh/uxfpF8YNqibEyeChkhZRGe/L5IqBEKaAgNr/bMK6wULJMbuhMGzihosR1T76rYxSpkQPwuNQ3qyepfIIdzuiZ9WHt00VnIuN9DQQjMs6B1VPgoPJwvFNLb5JroSUEJwxzESqWzzPPDqSbP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745483669; c=relaxed/simple;
	bh=vNv6q0bb1dhXpfiDx4lYdoPPd0v2qIBg86Rmq+6QIeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cHeA6Lro7xl0yk+ruqXKjVmH4/0PNV/+iAIUxU8vSBOvF2VeMaTGktMTbgHM45WonpbR2l6oAgICuqkO+58hPITzviNuAt8FEw22A0N/ADvgOgpjLLPFicuNqG1W0rnXFwyzcMgxUWuhRriziRo720IfFz6BHT6w1HqDDBqcBJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rrluGAZF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39efc1365e4so320845f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 01:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745483665; x=1746088465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rDEe0RbbOdS/AATPa77SHHta5wsKCuUdsdnept9/i0=;
        b=rrluGAZFLTrvbsEtplM69wEgWcFW9D9ZCcUhL8kfOKIZ6/SVtLBBRKCUr+URxptpR9
         1GYMOh+x2Cxa+99VM7NJqeMlf96SXNMPkIGffi2tc9KqEUA3aNYDMEW+e156PJ5WIY8d
         sHKWvKnFyPjaTO5OjLJRNf+AF2bv57xDBE6h1a/GSF6X75YiAFJnlHqJpy2xiAJV8j8E
         TvLkLuXV8rjWAbRL4O3avq+Zf7oJlvOYduhP/8R8uR1Be1g/IGqR84vyffuImIlYb9Ww
         Jd/Vv8cJSPQ2SSJpWYxDwnz1ZpWH2SVLLBkZOiI45nrAICFq0k0lv6Kwh56TRQ2DKE3s
         3OmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745483665; x=1746088465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rDEe0RbbOdS/AATPa77SHHta5wsKCuUdsdnept9/i0=;
        b=ffvcaRLnKUnvYPFFGJPHkDljFx3r/JJFGBw+xA0Ogo7o2jgyRVvKOq5A+7KECAkeOw
         EX46svW0JUWGff8h3O1VA6Rd8KlZSfzqJ6pVe7e2CiA0pyAeZ9BPDLpnN+xti2ZZAYbU
         IL4kyh49R4QK/bqUi7GIz0b21TA3P2UeB6MJnFB9KnxaHQTfTHIJYzrNvmXne5qsVZS4
         paVS2xywb4eHmKZRCrLnK7FUJEqDIFCHPWPuzcK/ebPm9E0GKJEdZwtqWqEUC9y9DUAo
         H/exCqQr0DMPGswETbX9bkBtQIZ5OFmM3bFD39vvbZPHcNU4rawGpwD8z/EOYFv5Ag6P
         1fPg==
X-Forwarded-Encrypted: i=1; AJvYcCWMbTMbuncDP1wXwLwYWx+UW1pB69hVp7fcGJdqYnxkjVrm1WpGaQ+MhTqRKuH/sV6c2BqHImsQceQIRFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYRkRcf4+poe3EZy5kI7Fl0UTPVfyh+eBuwEWZCp5EHuYwwUPe
	FpLZjyclmvTfZbt1mHURyfpygM7hGFIgPcBqy+/Kc3/QAJBlcnbz1qqBTPTMQyE=
X-Gm-Gg: ASbGncuutq5Vid5JOJAPvZE68dFng/I9vKQqe5z+yw3dk/emtFvhYtrillSpe3rK4cB
	FktRnEr+gX993l/zKPpk2bbKuOM7a/S9skq5/uFgj1T3PuxUYl+B38NJJS9vymfZC6qoGCmgxVK
	bEn3x72D1uyd+EOlpcT8noBMQBVXYMILzqYSC46X1ptzJEuXufwnmCJZkhEABt5Q/oMcaibwsR8
	L+B+b3Nvcoy95uL2D41YmwyV0Z6qEttMGZw9kaUPtZnvjsXdCbRPVM9dZ2dI1DeL5GWg725dGm+
	63BNQSpGQut+4t9qps7AEoEyKlY8g2qAfNIaO1/m23wuVFrE87G9+w==
X-Google-Smtp-Source: AGHT+IHB/1fPMi8W8gNYBZX9ahiEF0UFgajqPwu4G1ECbDegN3oYFc0PmydKXsVY2MSnx6gtJ+HsoQ==
X-Received: by 2002:a5d:47cb:0:b0:39c:2661:4ce0 with SMTP id ffacd0b85a97d-3a06cf5ac06mr1515723f8f.13.1745483665163;
        Thu, 24 Apr 2025 01:34:25 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:f74:6a9a:365b:4453])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a06d4c6c56sm1323881f8f.60.2025.04.24.01.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 01:34:24 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 24 Apr 2025 10:34:05 +0200
Subject: [PATCH v5 2/2] PCI: endpoint: pci-epf-vntb: simplify ctrl/spad
 space allocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-pci-ep-size-alignment-v5-2-2d4ec2af23f5@baylibre.com>
References: <20250424-pci-ep-size-alignment-v5-0-2d4ec2af23f5@baylibre.com>
In-Reply-To: <20250424-pci-ep-size-alignment-v5-0-2d4ec2af23f5@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2649; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=vNv6q0bb1dhXpfiDx4lYdoPPd0v2qIBg86Rmq+6QIeY=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoCfeNM/XnkovbNkugaUgh+qynHCUCtYyhIWFEg
 Mnjh1220EuJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaAn3jQAKCRDm/A8cN/La
 henkD/kBk6sa7qTps24wEDvGqFqWVTIMapEBlE7MOo2mVVheqN1DbKKPyXp+48xcqqo8mSJ6y6k
 HDSdfWCOuf0uq9OGCHGxshry3J0/RdzHPn70ZRsT9f1zAt3SooEvxkL5mA0h9NWJaQc4Mjmsx8v
 YkjxiCooDpDHAQodmmZoGJf86HQLybBrSskdskNA9w4+4C7FfPOeXl+QhtjTZhPQp0NR8jvPoDU
 ywoj23FUzDHXoarguypcLl731tXJMsbJKYViABXBcWXD6YH8lPE4aooJnOAzOvDL6ENz2hxmDTu
 fTeYO9LgGa+H2WGmZF+cBCwQlgu+Ezk/mbQap7S5qbJHtXplFrNRY38Tph5tRGYK+ruB8ie3bt9
 wFhs3SN9FSwFCe1OWxO6LJwlMu1jSfIFOo4QHqtfOjgnnccRcjQp4o7d6ji51GNYl2GyaKc5XwQ
 k/TUGW7BD2nMECwtXKLcobsEj+dLOzEjnx847/4IpfzHCBvunz67EzlZb7iSypHXN9kpdSp1BVN
 qtgc7vck/211s5WWWYbNvQskBEvB27/mx29Yp4OI67ZQ3qn7Gh99oZQq+IJPU9scrsnwrYepWUL
 Da5yGlyxLBV3u33uJjya3KgcvgRBCXS7Ksg2GJcpcbEqV7euamaxHnV8uiYlm2HlTKDUJP3IV2V
 uinIHWXjuwaRucg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

When allocating the shared ctrl/spad space, epf_ntb_config_spad_bar_alloc()
should not try to handle the size quirks for underlying BAR, whether it is
fixed size or alignment. This is already handled by pci_epf_alloc_space().

Also, when handling the alignment, this allocate more space than necessary.
For example, with a spad size of 1024B and a ctrl size of 308B, the space
necessary is 1332B. If the alignment is 1MB,
epf_ntb_config_spad_bar_alloc() tries to allocate 2MB where 1MB would have
been more than enough.

Drop the handling of the BAR size quirks and let
pci_epf_alloc_space() handle that. Just make sure the 32bits SPAD register
are aligned on 32bits.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 874cb097b093ae645bbc4bf3c9d28ca812d7689d..e4da3fdb000723e3adad01f0ddf230ecc0e572a7 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -408,11 +408,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  */
 static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 {
-	size_t align;
 	enum pci_barno barno;
 	struct epf_ntb_ctrl *ctrl;
 	u32 spad_size, ctrl_size;
-	u64 size;
 	struct pci_epf *epf = ntb->epf;
 	struct device *dev = &epf->dev;
 	u32 spad_count;
@@ -422,31 +420,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 								epf->func_no,
 								epf->vfunc_no);
 	barno = ntb->epf_ntb_bar[BAR_CONFIG];
-	size = epc_features->bar[barno].fixed_size;
-	align = epc_features->align;
-
-	if ((!IS_ALIGNED(size, align)))
-		return -EINVAL;
-
 	spad_count = ntb->spad_count;
 
-	ctrl_size = sizeof(struct epf_ntb_ctrl);
+	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
 	spad_size = 2 * spad_count * sizeof(u32);
 
-	if (!align) {
-		ctrl_size = roundup_pow_of_two(ctrl_size);
-		spad_size = roundup_pow_of_two(spad_size);
-	} else {
-		ctrl_size = ALIGN(ctrl_size, align);
-		spad_size = ALIGN(spad_size, align);
-	}
-
-	if (!size)
-		size = ctrl_size + spad_size;
-	else if (size < ctrl_size + spad_size)
-		return -EINVAL;
-
-	base = pci_epf_alloc_space(epf, size, barno, epc_features, 0);
+	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
+				   barno, epc_features, 0);
 	if (!base) {
 		dev_err(dev, "Config/Status/SPAD alloc region fail\n");
 		return -ENOMEM;

-- 
2.47.2


