Return-Path: <linux-kernel+bounces-899302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A00BC5755B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D83093434E9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD2F34D3A9;
	Thu, 13 Nov 2025 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="tw4s6Fkp"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745D9338F54
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035561; cv=none; b=LWdIzBrEvLWBoAChkEXMhyXWls8IbpHLqbCMoHbdF35fTxc/qbCiAWONVGbNkGE+aw/VpkPpN6+jbA6B6QAMytKdQKtxVhTaom3nTtCfENTumqyXpKWUyl9u3BUmEwYZ5cMPzSbRj5ZfWEzUda280eyZPyiMRW+y1F+WZ9V0S3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035561; c=relaxed/simple;
	bh=FQCyISZnPOKJei2bgAKraXYH+mV70ZDTbaSgZq6DQ2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NVOobE47Qa9W7/8HQRHAgz+E9ULsc2p/S0VhnzW6SpqDNl6T0SNq3+yD32x7QA5g1IRLDPVl6u2ZQR6QQkup18TSwYHqzmw3w7T7oCjlnxIg33a/Ft1/NutqH/g0Epk2PtgGV05TFAMupt0BbCPcpFIlj73jiQXKR+FI3BXNerA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=tw4s6Fkp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297f35be2ffso10251185ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1763035557; x=1763640357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GfHQGwR2IJ0YhvOVkLG4P4YqTO9ZoG8OUJ/4HMhDBS4=;
        b=tw4s6FkpCKcJOXXEMyAmR698AilOfHhB6SacnBOHt+2JYn76GZZxcts2IlqKBtU6rU
         6W8h+8J9KRDlaN4O3WLq5Bw/RDvtS4jEb2T+6S6Hunn5bqT9WLDUzAvUEJ8GvWYOPiqp
         8OYNuraP887WFGFQmUDjycYtG7qmz7BTBkQZ69dspJQ4jPxzfz9CAz9iTAyRUNHx5xww
         gTjoAY6ugASbQZ/dn4UbAtFn+vHhnYP60N3tNEZc3xMj+0zotcU1U47stdRbDa4d1d2j
         PwyBvvcwB2OB75E9YFECkWdmLZNU03b5klPCI4fubIbipx3A8i+G4shg97ve5FznVnze
         SNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763035557; x=1763640357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfHQGwR2IJ0YhvOVkLG4P4YqTO9ZoG8OUJ/4HMhDBS4=;
        b=b6Gn8nVUDDI6GxAxOq7WE4r8NgWcPucrY0nfmEmB6l55B6ZsZdE724EYxONmbeX50L
         HdWJ41GBz3+PYAKq7m6Wv3uEiuFCdk5RdXUMq0m3xTk8dYg5Q06a7k22pmpB3o4zXhxF
         gwxk7seHwfYbRpINPCjMM5bCDlpy2z3Ie49+TctMggNdHmt2ncsXySV4/u60x70SDPW6
         LPvnLZqP5O6O5o+dYn0qlbVdds2kKlAQgDWP1r8uwfhtnFUYVQ28esUx2h1WOxVsjOdW
         uLrRt4H2n6yPuRAZIrNPXUBN8QkaguDqu/QM82m794UODs/BFuVyCNJj5aLoz2uDw7Sw
         p+0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtYHYv4PMGVSS6Hta39QMTXAcy5wTpgC+n9uFfbQCRREFRAiVc4Z0tX8Hdg5fBV4syBFm7Q+y30HniN7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGFAotNNBFkUNZQQgD1j88NqZ9k+7tIFiEwpkS7x5wwWCW0Zbu
	sMQlu/YqGagjWLzz82kwYu0DtGs0q+eLtwUJTkpMgru4qd6xVXirfXkonpPJl5hcUjc=
X-Gm-Gg: ASbGncstbnfK+DUkJUEKPFLCzPyLFG1dv2Q2feSsloWb0HOpOVXoIdjzVvILi3DM6BJ
	IU4yrlsNVmURIt9Nx0xNWxAhrCZLa39nv2GVPQghJvWlSH2TituAfetzQUsuD+t5vC0F5qWZA10
	Tmty+mxdeqGmF2ZMaeH432znMRHLOEUp26kc9be2ffu3h+X85+Ko2aIyf3HbL4hvEXti37Byqj7
	penJZQYFgVl3NA3jZREGh0lr45YlJAfI3cVcI9jQJYz8Q5Gp6EXUITxs/LJrmCX1B5XPTma3TK+
	/g6uEnoVMcf/x9iU9bshDxWhguxWE1EUU4S44qNnl6KPlzYKWIM92z6B+4J8YDX0l9lzW6yfhno
	FGTdd7XpDTA3aFENmLKKI8dU9FRA583lZR6J9adFjeG56bnYSVxtdAWnWQQ8zBp9AsmTk7XxgHf
	grKR8cyBlTLmvEXiNOQYysdXxH
X-Google-Smtp-Source: AGHT+IFgo9WsRupy+/jqOwQBJv80tuF4CK2JKSkC+PdQn2V45/Xn8leUXKdiJbwaz/ZGzv5fvvuF/A==
X-Received: by 2002:a17:902:ce0d:b0:295:7b8c:6611 with SMTP id d9443c01a7336-2984ed48d7emr84032885ad.15.1763035556593;
        Thu, 13 Nov 2025 04:05:56 -0800 (PST)
Received: from localhost.localdomain ([103.158.43.25])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2985c2bed7bsm24122405ad.74.2025.11.13.04.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 04:05:55 -0800 (PST)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: cezary.rojewski@intel.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: intel: avs: Fix potential memory leak in avs_pci_probe()
Date: Thu, 13 Nov 2025 17:34:41 +0530
Message-ID: <20251113120447.86911-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The link resources allocated in snd_hdac_ext_bus_get_ml_capabilities()
are not freed on subsequent error paths in avs_pci_probe().

Fixes: 1affc44ea5dd ("ASoC: Intel: avs: PCI driver implementation")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---

v1->v2:
- Shorten commit message 
- Handle the case when some of the links are allocated, as pointed out
  by Cezary Rojewski

Link to V1:
https://lore.kernel.org/all/20251113104121.79484-1-nihaal@cse.iitm.ac.in/T/#u

 sound/soc/intel/avs/core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
index 6e0e65584c7f..f0d77f3f3a28 100644
--- a/sound/soc/intel/avs/core.c
+++ b/sound/soc/intel/avs/core.c
@@ -473,8 +473,13 @@ static int avs_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	}
 
 	snd_hdac_bus_parse_capabilities(bus);
-	if (bus->mlcap)
-		snd_hdac_ext_bus_get_ml_capabilities(bus);
+	if (bus->mlcap) {
+		ret = snd_hdac_ext_bus_get_ml_capabilities(bus);
+		if (ret) {
+			dev_err(dev, "failed to get multilink capabilities: %d\n", ret);
+			goto err_ml_capabilities;
+		}
+	}
 
 	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
 		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
@@ -483,7 +488,7 @@ static int avs_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	ret = avs_hdac_bus_init_streams(bus);
 	if (ret < 0) {
 		dev_err(dev, "failed to init streams: %d\n", ret);
-		goto err_init_streams;
+		goto err_ml_capabilities;
 	}
 
 	ret = avs_hdac_acquire_irq(adev);
@@ -515,7 +520,8 @@ static int avs_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 err_acquire_irq:
 	snd_hdac_bus_free_stream_pages(bus);
 	snd_hdac_ext_stream_free_all(bus);
-err_init_streams:
+err_ml_capabilities:
+	snd_hdac_ext_link_free_all(bus);
 	iounmap(adev->dsp_ba);
 err_remap_bar4:
 	iounmap(bus->remap_addr);
-- 
2.43.0


