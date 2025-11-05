Return-Path: <linux-kernel+bounces-885854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAD5C340CD
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 07:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFF7189DB12
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 06:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700582BF005;
	Wed,  5 Nov 2025 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iq6FnMH/"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539982BEC34
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762324115; cv=none; b=IH3SlbnzWTbzAshCwdtn8OBt7zUU4Pg3xdXB9051ZZx3J6dO8HJeGw1VwOPcQZKFejGip8DpaluHZ2AkdwDES+I5s543y9s09lNy8K53zA8r6DS6MqluVhmNpsxp2ziIs3Ucu0XFro9pIBeOZJM4RmMKFGhAXdTbi/rc70uNqvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762324115; c=relaxed/simple;
	bh=3FiroJxrQIhTUXDgWPdJEs83lUs7Rhdwifkg2x3t8g4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YoFak1c5SJ+OgqVvQx1LugrVoD53uKs3fNjv5FBIB0XWG2CXXNGaKKtnxEqLkKdx+B6gVyFn3svN9AK8wCqj9YSpXDH5MavQvtcnBaTBPAu5n6p9s0HYb9AVS4fwMS4y6z8W39KsE3YODa7DoKoQ2vyygqVOWT61c8CdQOGA7gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iq6FnMH/; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34101107cc8so3063052a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 22:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762324114; x=1762928914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5H6EdMxDpSqpmsIQ4cEg0ZlQTdzaOtsaMR+Q6cSWnBg=;
        b=iq6FnMH/OuAtEb9vxBIoCjdmrv76QSlxzb6NNHVDIFOe7RVdJ8+F8sz9Nw/7m1RlHY
         4HLzCEyzDxpQllfhklhDllyX0m25HSyayobFMYKeposp1aEqZ4gErrpQBvM7/625a6tO
         ClBwQCXqQbFXKGjYFe1IQmyN3UXM/Np5GlFps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762324114; x=1762928914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5H6EdMxDpSqpmsIQ4cEg0ZlQTdzaOtsaMR+Q6cSWnBg=;
        b=gt5PbbIPMR4ff3C7qoCCLzekeSRmaFu3S9/FDbPhUTDgQBMwWTwufyLKw/N6iGFKwY
         p33bFlJpr73VGvPvZ4m8cgIM4+T0dOkMSbaONRdNrvgw3jXX9KajgqrInz3lMZ+7K/hd
         qnk7IGygYGjSuF20Vq0FImgw/TBV25uZJArkRY1k23g+tdGU3wTKF3vdkox3YnpqIF+T
         fbfzot+VCurHauDr5VLDDsaOPFGJnrlN5oQSuBl2qRMbygf/N4V5uJhF+Ail1oD6ISOa
         jP3bTpx6qTxzu2pgXcOI+87UwM2TwBIw6fuoddv+tcJuo4dslTVfEXfM7FELU83IXBvi
         +Y1w==
X-Forwarded-Encrypted: i=1; AJvYcCWXLHsFgZSkFUHpEpAb9pdIBvY+OrawbfPVXcyvQ26Pp7cBeNMnQmQHmFBfwcRpq/LPNDpOgaV7N4l9YNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZkV3c3XkQ+dN9KHLF4ZGjNPTiRh+VMdbeKvekxEGQMtT6tePb
	Ni8aLh2Lf/W3Ih/64aAcFGEjMZ1g5VVMUiKw3gmSF5TP4WUuS5pTy//mjq5HOZz9Lg==
X-Gm-Gg: ASbGncvmYBjBsuEn5YF4/MEnvMK8gu07tAxXbOBjExf0bKgGkDwe4NBTCF+XfcHALs1
	ppuJfEt133x/TS1204LxcUSipMiZO6rNpJ6eWURcCpi3raKXkFHcGCqrCsQaEi6MPbTQRV48LdP
	Jgj527vV2cTp1ZKerxHGdYFIf7GhUfKQSwVgpJJNa/cCnM3mnJtH5kBtdclw+yaR8rt5YZZJBRW
	A6BIMHqEtW3oovoYb2pSs0OAvwp+rKt4MxFq0tZjFNQQWyDuEcs6REXzfvN8ySOKPTDBeuI2DA5
	njjA3I94p6B6eXw0/fK5+oHbt8ofZeP2biactdbGnFnsPIhEuxaQnXfX1lOImiC2N7LFs60ZeH2
	g22voDKa3dAInBybl+UKZHDkIrMpk1gxkx3oahmj2HLSPJ9nkWWlrK5RPCSW07F/ESqrYbVCF1e
	jZFCmRxEwDKvy7I72G1MgUPYBdCZ8u/6rSZpBTU/qQmlgKFlbeV4aGX5698vm6Zpu0RUv1
X-Google-Smtp-Source: AGHT+IHcxT8eopl534bKfusC4Hown9kjuaRa6MI3B1tgGIQ3dMjZZ/a/cIEyK3gcb84dHOtYByhoug==
X-Received: by 2002:a17:902:f542:b0:295:2d2c:1ba6 with SMTP id d9443c01a7336-2962ae10211mr34787125ad.36.1762324113674;
        Tue, 04 Nov 2025 22:28:33 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:c3d3:7b72:a22e:7adf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296019bb9d3sm48438615ad.50.2025.11.04.22.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 22:28:33 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: mediatek-gen3: Ignore link up timeout
Date: Wed,  5 Nov 2025 14:28:14 +0800
Message-ID: <20251105062815.966716-1-wenst@chromium.org>
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As mentioned in commit 886a9c134755 ("PCI: dwc: Move link handling into
common code") come up later" in the code, it is possible for link up to
occur later:

  Let's standardize this to succeed as there are usecases where devices
  (and the link) appear later even without hotplug. For example, a
  reconfigured FPGA device.

Another case for this is the new PCIe power control stuff. The power
control mechanism only gets triggered in the PCI core after the driver
calls into pci_host_probe(). The power control framework then triggers
a bus rescan. In most driver implementations, this sequence happens
after link training. If the driver errors out when link training times
out, it will never get to the point where the device gets turned on.

Ignore the link up timeout, and lower the error message down to a
warning.

This makes PCIe devices that have not-always-on power rails work.
However there may be some reversal of PCIe power sequencing, since now
the PERST# and clocks are enabled in the driver, while the power is
applied afterwards.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
The change works to get my PCIe WiFi device working, but I wonder if
the driver should expose more fine grained controls for the link clock
and PERST# (when it is owned by the controller and not just a GPIO) to
the power control framework. This applies not just to this driver.

The PCI standard says that PERST# should hold the device in reset until
the power rails are valid or stable, i.e. at their designated voltages.
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 75ddb8bee168..5bdb312c9f9b 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -504,10 +504,15 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 		ltssm_index = PCIE_LTSSM_STATE(val);
 		ltssm_state = ltssm_index >= ARRAY_SIZE(ltssm_str) ?
 			      "Unknown state" : ltssm_str[ltssm_index];
-		dev_err(pcie->dev,
-			"PCIe link down, current LTSSM state: %s (%#x)\n",
-			ltssm_state, val);
-		return err;
+		dev_warn(pcie->dev,
+			 "PCIe link down, current LTSSM state: %s (%#x)\n",
+			 ltssm_state, val);
+
+		/*
+		 * Ignore the timeout, as the link may come up later,
+		 * such as when the PCI power control enables power to the
+		 * device, at which point it triggers a rescan.
+		 */
 	}
 
 	mtk_pcie_enable_msi(pcie);
-- 
2.51.2.1026.g39e6a42477-goog


