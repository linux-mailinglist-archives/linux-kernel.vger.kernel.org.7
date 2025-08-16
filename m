Return-Path: <linux-kernel+bounces-771837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70460B28C11
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274471CE4BED
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309AA23BD1A;
	Sat, 16 Aug 2025 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inaTDuCf"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2394023AE95;
	Sat, 16 Aug 2025 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755334076; cv=none; b=IJmzZ54GnlTbnRgrcInsQhvP/EooHNK01qBUGlo2/wpQCLgwkTtfvsQBUKJgbpzQZpDAS84/frKKR+JB2qs7xhpxAry2y8noTbkuHvG3VE+Iloud/eLDyXm3Qri32l/gIEzoAjtZxQLih7iP80TU5r9tx6LoI1rVpgDKDGodo4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755334076; c=relaxed/simple;
	bh=YhnsWfnst8CACf6PQAROgdhIAFBdYvfImQU33bmRVoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtvDT+xZoExTpzvS9XLr2f4xQHJV3rzwh1o8zXf+8QuHKKhNeCwUNZsZxy4a+HkchSMm4Xsx6k7AO2tgAfvvrZr+TYTmaAl54qbJlmvwZbceW/DnPV09gujL7VVWLY0lKCNZ5owSFppEkhcPLboOgaQuSVvn0Jl2WwWDdQu/db4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inaTDuCf; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so497138b3a.0;
        Sat, 16 Aug 2025 01:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755334074; x=1755938874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50Ntk2ae5CUZ3DU9PEgu24q2kwxt9HUqPcFOtly0Sk4=;
        b=inaTDuCfFL8k1Ty/IGnE4uo4UtAgFFTD33ERIkbfLsoBLHhf7ELdwysQ1PnnUWNmph
         8V1WWd0Rtx5JyCh+0dG0+vZiyp0ClovaR2GgIk8qMS+E0FTrqp0z3SWS7ymcjkYVmluq
         sjYpXcqTJehfRH8c5fc8FDle8CsGxGlPKAZ20YVBMaMRuCl7whinGsCvwQXb6hnAVpib
         Hnwf1wj8L71YiTcwdnYIKsfKnwai2Aj65w2A3ouVm6gNTBlD9++fx8k/Dc48SHZTxY8S
         bv/pimXcb2zCRdpY9Jf2jkznORbNFA+cHf36CQsF3yB52o2+Gw7cTZB1t5mygIcXXzfF
         MNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755334074; x=1755938874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50Ntk2ae5CUZ3DU9PEgu24q2kwxt9HUqPcFOtly0Sk4=;
        b=sDwOtjlnni2PCpdncJCuDLn+AFVQCuV7ohA+cdM36Ux11utPuN5xdOGs4KLlFyxfsW
         x/7wHbVfGJvKINkC+1bClxA9XtWcWMImUyuco4I/lmnZv9lyriL2lGgiEndF3Ndxl84U
         7ufViRZ6WuQ8naSsctc1xJ1PakCUfPDUOio3JlBAfnjjNn7Ve5eSAIXfnvKTfkKGXhYj
         vYFo/y++5ioMbcGhQlNy7sa9nz6OFjGycDq+MMLBdTdlQE2vToV0j27F6VhXc7pGxXOM
         BuhUCnR5rcI+q3bv82nalsGBRyM6IIsH4et5F88VMRw2DQnw9YQZE6iFBYqmm/72imYw
         U+gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuByNT5kUMPLJjqJiQZb5YRq+3KLEybn2oe7awj2Vt6Rva9y+I1OBo5yyPZNmjXz+GAW7SrIfRSfl6dEx7@vger.kernel.org, AJvYcCVspT5AOn9roOPPluSbmKs40xdch71Vbk07usTaOAzjHurX6tcLga3gwqZACrIEHKvZkAzJ6ETyudE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC69u16O3T/Yu3/SzsIgKFhNZzdYdu17I7fS+xNgooqIo3Xbqf
	yzqxEpEgA/X/4yntJ9llSrdOosCaZqLfFrycQDnYxSixCY2MBMuZQ1Cv
X-Gm-Gg: ASbGncsZm9/HP9RoIuTcqtTHJ2MErzFxtcL6drlqIBS22RX8dR3skqHUAsblxd59Z9I
	vj2GBqPtm16mYZsjihF19H3dKF/715zHxLsh7zR2fful7p3Jj6kuyCqiYxGxIaA4Jl72M8wO9yD
	zLATUep7+QWRahJ5k9G4mI5sAAqccmcnhQxj5T7xPyplMRqCXBTHTcRP4lS3LayXR2o/mpkKmle
	JYcjm3bHRATspFxOKrd3NvJKFkfmM1PMnYJBhtIKBqGUTUm4b92H1vSH/5NTF37E+RHUdZoXCoL
	nwIFEuFxX27te7LAqdWR2gRrrajY98woa2+p6rMZf9gIanwA++a79zUKqNFP4avKfFkL8Y4gMeD
	GfE5PGmFXh4A=
X-Google-Smtp-Source: AGHT+IHH2hwegF/f0OgFPR9gVfjZpUsDlbhxI4wzUfEICoM2jQpliSfPj1xZkFqOfFWIa8JxKO9MuQ==
X-Received: by 2002:a17:902:c98b:b0:23f:f96d:7579 with SMTP id d9443c01a7336-2447900cf44mr20352345ad.37.1755334074401;
        Sat, 16 Aug 2025 01:47:54 -0700 (PDT)
Received: from junAIR ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm31048215ad.157.2025.08.16.01.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 01:47:54 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 3/7] phy: sun4i-usb: a523: add support for the USB2 PHY
Date: Sat, 16 Aug 2025 16:46:56 +0800
Message-ID: <20250816084700.569524-4-iuncuim@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816084700.569524-1-iuncuim@gmail.com>
References: <20250816084700.569524-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

Previously, USB PHY was compatible with D1 and did not require
separatedata options. But now we need to add a third PHY, which makes it
incompatible. The third PHY is used together with USB3/PCIe combophy with
DWC3 controller. In the BSP code, the third PHY requires a separate glue
driver, but it seems that it is not needed.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 8873aed3a..bb79339f2 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -1025,6 +1025,15 @@ static const struct sun4i_usb_phy_cfg sun50i_h616_cfg = {
 	.siddq_in_base = true,
 };
 
+static const struct sun4i_usb_phy_cfg sun55i_a523_cfg = {
+	.num_phys = 3,
+	.phyctl_offset = REG_PHYCTL_A33,
+	.dedicated_clocks = true,
+	.hci_phy_ctl_clear = PHY_CTL_SIDDQ,
+	.phy0_dual_route = true,
+	.siddq_in_base = true,
+};
+
 static const struct of_device_id sun4i_usb_phy_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-usb-phy", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun5i-a13-usb-phy", .data = &sun5i_a13_cfg },
@@ -1041,6 +1050,7 @@ static const struct of_device_id sun4i_usb_phy_of_match[] = {
 	  .data = &sun50i_a64_cfg},
 	{ .compatible = "allwinner,sun50i-h6-usb-phy", .data = &sun50i_h6_cfg },
 	{ .compatible = "allwinner,sun50i-h616-usb-phy", .data = &sun50i_h616_cfg },
+	{ .compatible = "allwinner,sun55i-a523-usb-phy", .data = &sun55i_a523_cfg },
 	{ .compatible = "allwinner,suniv-f1c100s-usb-phy",
 	  .data = &suniv_f1c100s_cfg },
 	{ },
-- 
2.50.1


