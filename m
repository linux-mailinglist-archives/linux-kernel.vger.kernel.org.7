Return-Path: <linux-kernel+bounces-871900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 777BCC0EB46
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2031889F10
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC5E3093CD;
	Mon, 27 Oct 2025 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk4MyiPY"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C1F3090CE
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576981; cv=none; b=ZsNReAHzCH30zyFVHIGRmJPrJ6RG2cSWNxSbMrppXdC1v/GplwcmWyLJpNySzues+9VSXOZpYeP8Nrp3Ihm/VvvRCpEFivtQwzXP5xicbkDyCr4sWK/N29NEQi2lUFGFGQWAXIY/QQp7ND1LRfn6zrJPIXjplPiwYaC4BU+wtno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576981; c=relaxed/simple;
	bh=udVyNr40B8fK2PACtFKkWz3iKvyMvgVcKAD+ZkyK2CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5gTpTVuzLZsCVOVvGbE8A/FfIQWX8zaHZrX7F7iJ6uYT9YiZLDCw25lZLH5CsIsiXP8h0B25dQZH3/bAD4WmYQbNFOs7K3Dfcy3XNWt9Ud0pYtnYbSHA+hHU6nf85uRZi2l/RanrGqkWisr4/nZycdOJqW3QEeEXiNSY0d89Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kk4MyiPY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a2738daea2so4007179b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761576979; x=1762181779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyBK5HLss/zF/tM/K4qW2J+Z3asnvx9H1hG28ozg6Qk=;
        b=kk4MyiPYBN9pIwb8uastv/cK8Cf2jYE3QD8rZQLEcoVViMNFU3Eb+0rh6MU06fHBK/
         9Fvk190nbLj/X6yv2+2kleyu0lwhx9Xp+QtW3ZZ0WSyX2Td/N4tMtWTTvwJfTCtjTLCS
         q2dY/C1VfLyY+U/05F8wZVzKokG+pmtyLpDtscZCXeSvCZvAJN1BtKs59MWpMHoDnVO0
         fAN3SUTV8hh9MAy2htkcgOWXHrmo0+rnmjjRFc0f3+dTtt4CsDf6jYA0nKabQ8V6VtWF
         XCJnLCAxdmM5JfMsBw7esyOd5UQp03+Lthdgr4T7o/OuuwtyIQ8VqVN+GFE6rgageWvh
         AAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761576979; x=1762181779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyBK5HLss/zF/tM/K4qW2J+Z3asnvx9H1hG28ozg6Qk=;
        b=CTl7IBhvbf1mytOtP8iwrWfocMmlZqnIxPjfAog1fXmtJKUz1xRJDLh4X+CxVc5wY6
         yMp/pFECzHktwJwUzqGYeEZWSti617NRs1RCIeuPpdv63jjiSXI9k43eN0OYH+fwWYBK
         Jqldq00WavZ1X9Ebgca0Dp0XoVCHxwVvRJP7wepHeYbpGTZ8DvUnHlsc3bASw714G0r3
         DyJmqoJ90lvvbtYX9cgIaYCMcRiUyNHZOCiHZo1kpDHBSZVruflcfS9BFV3nHq0fv6EQ
         L8lTylZ3rv3T92pzoKZlLYvkTN1bq3xwCrj3WGmRfYkhz35WqNwudAdtqHghyjxU10pI
         bqLw==
X-Forwarded-Encrypted: i=1; AJvYcCXAuil3xlabLkS/mtuWDkOBSJrWflcCA9haiCxrvIpaZ20oBIndCkxR/sPYC/OeBhh0E5K1jbqG7BqlTaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6c2mi1jbUyr3zdSwDJ9W0kk2ixKoF9qXSfs3nY31U+H/no5l
	3B2wXnLvAW9PM7b3Vh9XAG9eQw6wQtYcvAlYllgYDDhbloADTrz4Zunh
X-Gm-Gg: ASbGncvcF1hA/0073vde6LvBTG48Q/szcpgwHi+d4nnD/lv7QsZcVN8v+o0nRemjR2F
	DF2txj/LdlDssSvR5dNKA3j4W13xxiHxw2vaPVKbpna/666om771EnOBYNykKC2v13rpdxDbMHz
	gWS3X5NaD3cNgrf0xhEpH5gT8jEU5jyc5KHsGXw6LSCWLM9k6h1ArT9X7Y+EB7qqT33omghXm8Z
	WdpvDA9debsQYg5y3yj+Uo+vhhz70ccwLQfWEhxnpeAUZDVAr3rUxVSpDTE11MnmK8ug5zF6VON
	DeIQEhEp6t5/ftBSYpINiM7QOhRGJhcqD6jQ8zwuN1fumBW7g7EeDwMYd3t+NrLzjaUZ8MVhAPh
	qjRyQ0jgcyuTWTny/eBC3Eh3tDxcogmMOZXHG7vgj8y9bXyMJkw6HUMzBOWxeXMkNufVBM2GzrQ
	==
X-Google-Smtp-Source: AGHT+IF+HmWWIbu4RONj+wms//aaht+5AP20I8+4ooWFn7x7evY1F6ZZlpjlb36aBgMXfZJZOoYYlQ==
X-Received: by 2002:a05:6a00:928a:b0:781:9a6:116a with SMTP id d2e1a72fcca58-7a441bdb5ecmr276136b3a.9.1761576979105;
        Mon, 27 Oct 2025 07:56:19 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012b19sm8373372b3a.12.2025.10.27.07.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:56:18 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Hans Zhang <18255117159@163.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 1/2] PCI: dw-rockchip: Add remove callback for resource cleanup
Date: Mon, 27 Oct 2025 20:25:29 +0530
Message-ID: <20251027145602.199154-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027145602.199154-1-linux.amoon@gmail.com>
References: <20251027145602.199154-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a .remove() callback to the Rockchip DesignWare PCIe
controller driver to ensure proper resource deinitialization during
device removal. This includes disabling clocks and deinitializing the
PCIe PHY.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 87dd2dd188b4..b878ae8e2b3e 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -717,6 +717,16 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void rockchip_pcie_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
+
+	/* Perform other cleanups as necessary */
+	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
+	rockchip_pcie_phy_deinit(rockchip);
+}
+
 static const struct rockchip_pcie_of_data rockchip_pcie_rc_of_data_rk3568 = {
 	.mode = DW_PCIE_RC_TYPE,
 };
@@ -754,5 +764,6 @@ static struct platform_driver rockchip_pcie_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = rockchip_pcie_probe,
+	.remove = rockchip_pcie_remove,
 };
 builtin_platform_driver(rockchip_pcie_driver);
-- 
2.50.1


