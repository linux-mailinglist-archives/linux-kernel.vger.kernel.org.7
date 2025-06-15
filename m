Return-Path: <linux-kernel+bounces-687151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82D7ADA0E8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jun 2025 05:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CBA21705DB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jun 2025 03:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4EA2609DD;
	Sun, 15 Jun 2025 03:58:20 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FDFEEB2;
	Sun, 15 Jun 2025 03:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749959900; cv=none; b=g6rsdO2YwLW+8wARD2VVq7/9URDE4oNBZVMdl5pDtOz8uods/8Q9YEkMpLjX2USZMR0delJVPMBZUt1Jx65c10hJSH8RI76O+XgZVn2xZPOqfjkR0khzPXm0s50BWagpukUme/lATUvWiNYqj2SRfhMyLST/lfIRn3RIPzVZCR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749959900; c=relaxed/simple;
	bh=TObX3o0ygQfFGCamJ/I+ZQ44Fcj+AlluI304+qKBoyY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UQmvaQEt4+z11OWzWT0vK0CBClRl0p4wzcCbZYE9iq++2+t3bFc+c4Evcti7oC4rGPGQOIPDSCnKKzBY1WtuyrgrHFkxYHV2KjH0YxuOTKEskkm6x4q+w4Z+hseKBpKjb/tbTjK3mLpAJGcztsKxYSjCvoDxTbFQJdOCl+xBq+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 15 Jun
 2025 11:58:03 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sun, 15 Jun 2025 11:58:03 +0800
From: Cool Lee <cool_lee@aspeedtech.com>
To: <andrew@codeconstruct.com.au>, <adrian.hunter@intel.com>,
	<ulf.hansson@linaro.org>, <joel@jms.id.au>, <p.zabel@pengutronix.de>,
	<linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
	<linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/8] Aspeed SDHCI driver workaround and auto tune
Date: Sun, 15 Jun 2025 11:57:55 +0800
Message-ID: <20250615035803.3752235-1-cool_lee@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The purpose of this patch series is to workaround that the
Aspeed SDHCI software reset can't be cleared issue, and to add runtime
tuning and sdr50 support. The runtime tuning is to improve the
compatibility of the sdhci driver with different MMC cards.

Cool Lee (8):
  mmc: sdhci-of-aspeed: Fix sdhci software reset can't be cleared issue.
  mmc: sdhci-of-aspeed: Add runtime tuning
  mmc: sdhci-of-aspeed: Patch HOST_CONTROL2 register missing after top
    reset
  mmc: sdhci-of-aspeed: Get max clockk by using default api
  mmc: sdhci-of-aspeed: Fix null pointer
  mmc: sdhci-of-aspeed: Add output timing phase tuning
  mmc: sdhci-of-aspeed: Remove timing phase
  mmc: sdhci-of-aspeed: Add sdr50 support

 drivers/mmc/host/sdhci-of-aspeed.c | 370 ++++++++++++++---------------
 1 file changed, 183 insertions(+), 187 deletions(-)

--
2.34.1

