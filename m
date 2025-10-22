Return-Path: <linux-kernel+bounces-865205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D184BFC7AA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E77E44F84BF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BE434EEF4;
	Wed, 22 Oct 2025 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT3YQ9Gc"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB2E34CFB1
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142904; cv=none; b=IjER+qbHwCuoqUJdnhhtW7FT0080P2KF3DAakNkhQ5cng2pvPB+gHi37u32dM0/uDQz6zI9hhqD9NnDRMx7OQ6wSperYqKra/e/RN1y0oLbNtXCreY/7UN8dFpsu0mcZ7Kfo4yyir2PgBMPNbucYsekxwG5+nwVPSP3cuID4MjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142904; c=relaxed/simple;
	bh=EkGBXhItwLWxgQ/aIBX1I+SuRG7//x8trI9XTwjIFpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJp0oKtwj7cSLIaK5oGYwYt8FnTetrhxSnw49VQ6XdCIgceNi377SHebEeljWD60BZKW/BST8gq+BxQBHrfYaauhzfXXDIFJAAbM1SMusR5XO+9CxH4dYu2o9ogMnvPzw/BGGtelITKadmgIfCGOlwHWcKR6YDMy2VlSAFT/O9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lT3YQ9Gc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47117f92e32so46784235e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761142897; x=1761747697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PboKxjSSvW6h8IWsKUFqt3oWZleCNVGyc+XkVJL1pxE=;
        b=lT3YQ9GcruPN+lVPATeN+AeMLQ9HuT9T3lRtwrQTTtpiAeeEyeDgV11dPEy+lRdIcs
         dB5tdNavAiXbZusN/vPISKlN5VA9I518xHEukkRh0vgyCi8IFuQXi8K+SOlMcFTjBWrh
         TuOUkuige4UxvD7CENUTFhOSd5Pdm/zkgm/PdoVZBp2m9B/6C3I/j/VaUEFuJaP00gpF
         +NN4xmNSBd/c+vnntwWQd7d5ad6s9gz48KKsI0t9b6Ij790/47VBssEdqoXIblxrG36H
         BI/+SsVzrIEsSVg8j61Aqgjd+6oXP6WLSWwW/aRZayFaQ9CTWhjXQtSaa7S5J2EXAXvd
         L7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761142897; x=1761747697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PboKxjSSvW6h8IWsKUFqt3oWZleCNVGyc+XkVJL1pxE=;
        b=HPBu1IFXzRVE94J7zIDe1vbiRfGVB0nTmEOOTx5qwa/9bSFJWdzm1ZbNBtpYCvXxSs
         lP2OsSZDcGtSqIBkZrfAbZCII8ejPpn4Ab1a1RFGuFn8eVZ7rO7RZnJeZD3Se1xSBMQQ
         kjgguTmhTjvPPxzaiemtawTjat2e4tLw/smpUgwusj2qSPnXwwMMbDkeorL2+u7vPW+n
         nlGDowl1ncxDS+ouBbV4UBmAi8kUdrqtlmdERXjbFwbjKMgjIqVXFSNK7S9WbQu2ZANS
         fwny8lo9FpyC1RcTgoe8TGghdb2s1+3AjYcnyowNASRXsl73EPke5cyx0mVxWP/jAac4
         KD4A==
X-Forwarded-Encrypted: i=1; AJvYcCVrbKnGSVaQP2/cJquEDOwsdIOestNsjeWJeTk/nbIGuRpW94Z6XWZ8YuyHepUZEv2IWODAAa3h1MHo9+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBxOV/6zx47yq47d2g/fhpRKpIUNrHzHjvx2d63Q9Bq5ovw32w
	HnLNDEdihwGTAO8PHBUSW+5/cy1TsMQ/O/Ig5lF7G+CnNKryAwRoxInm
X-Gm-Gg: ASbGncvMzrHsRar8N/Qod9oZjmQ4ipMW2kJAY6DyAi2y0zJp1Vbb2dq80g2BUml3NPF
	Azv050E+5RWCn892Wf+Wd5AM4IXan3k6hPprF1PnEuCV6IHEUw51Wb1kPH5oMCPNP9iOv/Xh6j2
	8P8o7Wi7Aoj5CRiuQTNOgyVi1ZGZNPl9WY0xlhzrMNnnKAEmhGiIRANTGUgCjcOyXzGkZv3DbmD
	TIX1oS+4GAdrOvGc0YRXJAfRrD2dUmMs4N4yyFqTOCea455AaoJqUfOof12i0VBVpoPUc7VAAPv
	iTnVVCiIALL/RGpfrWJllK3YZzHCltQ3YZIROqVlqlfxIW6dx1ahXApZVJKglIcH7x+xTutKXtU
	udhbVEwPlJILLHTKa7qhSI9eRcP3uO/m0yp03gYC4qDXcL2bjFPdabYsQtjAVzuBLes4jOz0Msh
	4Xzg==
X-Google-Smtp-Source: AGHT+IEQ89eeh/r2+ipRz7waSS8oqSfLxP7wC0ZsoklWA5VZX65aruo6BpxwArM9GCWrpFvdCs8Ryw==
X-Received: by 2002:a05:6000:2308:b0:428:55c3:cea8 with SMTP id ffacd0b85a97d-42855c3d365mr1542726f8f.50.1761142897063;
        Wed, 22 Oct 2025 07:21:37 -0700 (PDT)
Received: from xeon.. ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3d4csm24803518f8f.19.2025.10.22.07.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:21:36 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
	Dmitry Osipenko <digetx@gmail.com>,
	Charan Pedumuru <charan.pedumuru@gmail.com>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Aaron Kling <webgeek1234@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v5 08/23] staging: media: tegra-video: csi: move CSI helpers to header
Date: Wed, 22 Oct 2025 17:20:36 +0300
Message-ID: <20251022142051.70400-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022142051.70400-1-clamor95@gmail.com>
References: <20251022142051.70400-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move CSI helpers into the header for easier access from SoC-specific video
driver parts.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/staging/media/tegra-video/csi.c | 11 -----------
 drivers/staging/media/tegra-video/csi.h | 10 ++++++++++
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/media/tegra-video/csi.c b/drivers/staging/media/tegra-video/csi.c
index 604185c00a1a..74c92db1032f 100644
--- a/drivers/staging/media/tegra-video/csi.c
+++ b/drivers/staging/media/tegra-video/csi.c
@@ -20,17 +20,6 @@
 
 #define MHZ			1000000
 
-static inline struct tegra_csi *
-host1x_client_to_csi(struct host1x_client *client)
-{
-	return container_of(client, struct tegra_csi, client);
-}
-
-static inline struct tegra_csi_channel *to_csi_chan(struct v4l2_subdev *subdev)
-{
-	return container_of(subdev, struct tegra_csi_channel, subdev);
-}
-
 /*
  * CSI is a separate subdevice which has 6 source pads to generate
  * test pattern. CSI subdevice pad ops are used only for TPG and
diff --git a/drivers/staging/media/tegra-video/csi.h b/drivers/staging/media/tegra-video/csi.h
index 3e6e5ee1bb1e..3ed2dbc73ce9 100644
--- a/drivers/staging/media/tegra-video/csi.h
+++ b/drivers/staging/media/tegra-video/csi.h
@@ -151,6 +151,16 @@ struct tegra_csi {
 	struct list_head csi_chans;
 };
 
+static inline struct tegra_csi *host1x_client_to_csi(struct host1x_client *client)
+{
+	return container_of(client, struct tegra_csi, client);
+}
+
+static inline struct tegra_csi_channel *to_csi_chan(struct v4l2_subdev *subdev)
+{
+	return container_of(subdev, struct tegra_csi_channel, subdev);
+}
+
 void tegra_csi_error_recover(struct v4l2_subdev *subdev);
 void tegra_csi_calc_settle_time(struct tegra_csi_channel *csi_chan,
 				u8 csi_port_num,
-- 
2.48.1


