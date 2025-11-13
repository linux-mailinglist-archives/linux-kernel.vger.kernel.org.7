Return-Path: <linux-kernel+bounces-899160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0188EC56FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02E93BEB6D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191ED3321A4;
	Thu, 13 Nov 2025 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="Jvt26m+a"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBA0331A50
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030502; cv=none; b=dyikee2MoDozB9/fiMTvoCjXaRmjR4z21v+An03xQjCws8PYF5tGDX1emPa6+X6XAX85wqzmkGkbRJpDwrIWNH/SRzZL+mdu87Amn8Y83DP/bkCMvjIyWtZQqXju19OxwIg6mWhsB+Dkk+27EcRlZFZdyOKBu0XJkoDeUBJIHWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030502; c=relaxed/simple;
	bh=aNIpEp0tWzp6Hm7TmTE9jYjQYZRYZ+L/GDzDkm2PqH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RByuwTj9Eh8K0VYwW5Sjsw3XIbPH+sbem4K57n4mJhc3gYug2IoT2wJjSP2DK0YLawxCxke1UVgZxq4FWzXieWhlUEZFtghufqeZZzq8r3v15A+flf8Vp6J9oh4BJsFcCFsRn/5Fa623V2AbKV2SrVt4cg4ENp6xyKuZjpEdeog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=Jvt26m+a; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso555110a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1763030498; x=1763635298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DJz+ux1agXrbz0s4q+1/StE2n0vhcodsi2hiIHN4wt0=;
        b=Jvt26m+ajkc4zu8OwRBlgSgN0CKhqTIYNB7h4BKiTs6cnpO1i1Ba4s/iAjkZC4/a9T
         A0AK0G+DEM+m4AJ/a53W+DqoZT/J7eWRbXR0mbCqaARgAv9VX9vsr8eHUusyAr12oB4K
         JsnzB6c2uGHWOFO2DTsTrUAkLGx6ZUH3pmKs/wBCnBWXxrPterS487Oy4GJPNtUYdWYz
         wmxczMK+84lzHYsnThrPMuRvwPibun/RMWdt2qhE0Z1EonGKOa4cPQrckH5A0LzEKdM6
         Erztm4918qbbSdkwp3ACyaqNBlSflJmourlCvVFHddhUFby4ydICi7pbnnZaNYZJttcn
         SxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030498; x=1763635298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJz+ux1agXrbz0s4q+1/StE2n0vhcodsi2hiIHN4wt0=;
        b=veKl8lFQtIZwa9E2TLxGJBKNTl2mjHCvik1ukuEdFFo2TS+IZO0RA2zArPw6q6s8uk
         RtUEdaXA/+cUgmY2wk7WLnJEYm19R5IWJr5x1AYAkqL5u+0yg/zKOtyD06wgCQfnMFWA
         oezNUNRcPWeFNmZwtYbQcgwU8ufL2Hn7In5tGbB8IyR6xXAlglBvPFqm3awjXdP1c55a
         O02bhnVETOGOd1tV6UHtnpLywQSgR6rcUcWE0ef9WKpyavuhCKnwH80r+nzTiSd2i8Tw
         yYwWUvB4R5mmvR2dbaPJlycGjm89i/adeCs+zoEkp7h/TyGe3GXyDrc6LTF4bL5hpIQ+
         YQ3g==
X-Forwarded-Encrypted: i=1; AJvYcCVHbOOyZYBLdQzy1DKF1Wm0mdOar+Brw1/RUmosDuPHKJjQpH2EJD2+qUV2otz2UJOXWsU9WnPFDP1jdbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcM9K5LwzsP0U6BOx4SwmogGZ40H4gsEmV/6OxIKz9+4LyWRCV
	V/AmscF7KfhoNUwS7LhWb58gb1RTMvaxtwObm0lQfRXaDgRv7fHH5nWxYinH7jzOyWY=
X-Gm-Gg: ASbGncttvGOIUgDwHtKBoUdQj297CziN20PC+G3drTlP4Tc1RtwKhdnx82j7iIo1jir
	HsLMJeCDWs7Zf3eypchX9m+lFjZ12wVVV9ui+ft9gUl26XshNkVy+1npDTeE1PgCDSk8OxyVUPr
	dGd3LgPd6j4enX0cbU6au8Y2cu374JNswNWp8NN9LQmuphbvoctL/c8TQ35JNEDXSudJZ94EXn+
	GKyPt+IXps/ngagPAcbjN42z+EfC8CGf4xL9VTR6DLqMDKwuy5cA7uNIkw4BaIQPSAggCeYxj+K
	qwhOSPsmSyZ8ySqMx92qPX7nMmkmNWaRTrdR94vSvooatT/OvOXWLlcSnhDCS+HD2yMzulHzpCe
	EBoM6Pff8LMWfUSyX24VecuEVKu6FRLKbesPXQg3JLuBp98dOsLpOjePgaBB+otyd3KV9cP6R+Y
	SDbQsgo6DyfkJ4fQ==
X-Google-Smtp-Source: AGHT+IHJPNOxOgpSD+v9EzuulPA1PCX4HxiLuMt9tyYIQH59E/uUGS1fwIwf/FuYrqXa6iso6ctPZg==
X-Received: by 2002:a17:90b:5625:b0:341:88ba:c6d3 with SMTP id 98e67ed59e1d1-343ddec5702mr7551477a91.23.1763030498074;
        Thu, 13 Nov 2025 02:41:38 -0800 (PST)
Received: from localhost.localdomain ([103.158.43.25])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-343e07d3bb3sm5568870a91.19.2025.11.13.02.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:41:37 -0800 (PST)
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
Subject: [PATCH] ASoC: intel: avs: Fix potential memory leak in avs_pci_probe()
Date: Thu, 13 Nov 2025 16:11:19 +0530
Message-ID: <20251113104121.79484-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In snd_hdac_ext_bus_get_ml_capabilities(), memory is allocated for
multiple hdac_ext_link structures, and appended to bus->hlink_list.
But the subsequent error paths in avs_pci_probe() don't free them.

Fix this by calling snd_hdac_ext_link_free_all() on the error path.
Also handle the return code of snd_hdac_ext_bus_get_ml_capabilities()
correctly, since it can return -ENOMEM.

Fixes: 1affc44ea5dd ("ASoC: Intel: avs: PCI driver implementation")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 sound/soc/intel/avs/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
index 6e0e65584c7f..ece78a1c0e42 100644
--- a/sound/soc/intel/avs/core.c
+++ b/sound/soc/intel/avs/core.c
@@ -473,8 +473,13 @@ static int avs_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	}
 
 	snd_hdac_bus_parse_capabilities(bus);
-	if (bus->mlcap)
-		snd_hdac_ext_bus_get_ml_capabilities(bus);
+	if (bus->mlcap) {
+		ret = snd_hdac_ext_bus_get_ml_capabilities(bus);
+		if (ret < 0) {
+			dev_err(dev, "failed to get multilink capabilities: %d\n", ret);
+			goto err_ml_capabilities;
+		}
+	}
 
 	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
 		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
@@ -516,6 +521,8 @@ static int avs_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	snd_hdac_bus_free_stream_pages(bus);
 	snd_hdac_ext_stream_free_all(bus);
 err_init_streams:
+	snd_hdac_ext_link_free_all(bus);
+err_ml_capabilities:
 	iounmap(adev->dsp_ba);
 err_remap_bar4:
 	iounmap(bus->remap_addr);
-- 
2.43.0


