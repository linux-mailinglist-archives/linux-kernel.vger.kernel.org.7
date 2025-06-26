Return-Path: <linux-kernel+bounces-703999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2CEAE97FE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 10:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5F6166140
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 08:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73D1285049;
	Thu, 26 Jun 2025 08:17:45 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2221525BF1F
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925865; cv=none; b=FnhvP1QN47GvED1KG2AK4DAdYbCA+fFtYD8t1EOCqZxsJFrUVuRQhy/RdKdWA8IKheR4GjBHoxUtcub1RfPVq7XtUm5iAsXmzggiD6yhjGsqMo53gTgbnjJ8y0k6GYwrNwqYQNhV1J2n6wGzle17HX35Sq4JeMLqsvvB82lq75c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925865; c=relaxed/simple;
	bh=UB+TyR5m+U/crFbwM1WFMO4bbKXq3amGh5rWtRpdOoM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c87tzWd3SyM3SVBR/I82I5bhtG78h3iUQc2qvwsmGG/svy737mHk5xEWBUHGus/QHyRjOVk+RZ4iKMTMqVQRgIt6iNypojgRw9IAesIwTbREDRvvphL5218KgGOOUqklIJow5ZZ0NPiC3L36dXFw3Jz/uqh+FX68fO9RbQblPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: uTUvvCebQ+qE+brYpPDDtg==
X-CSE-MsgGUID: h2slAUOXS1i6yeDvzEYokg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Jun 2025 17:17:36 +0900
Received: from REE-DUD04480.adwin.renesas.com (unknown [10.226.78.19])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 413F44017F3F;
	Thu, 26 Jun 2025 17:17:34 +0900 (JST)
From: Michael Dege <michael.dege@renesas.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Michael Dege <michael.dege@renesas.com>,
	Uwe Kleine-Koenig <u.kleine-koenig@baylibre.com>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2 RESEND] phy: renesas: r8a779f0-ether-serdes: driver enhancement
Date: Thu, 26 Jun 2025 10:17:23 +0200
Message-Id: <20250626081723.1924070-1-michael.dege@renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch set adds the following to the r8a779f0-ether-serdes driver:

 * USXGMII mode support for 2.5GBit/s ethernet Phys
 * A new configuration step suggested by the latest R-Car S4-8 users
   manual V. 1.20.

Changes in v3:
- Fixed wrong macro (reported by kernel test bot).
- Link to v2: https://lore.kernel.org/r/20250527-renesas-serdes-update-v2-0-ef17c71cd94c@renesas.com

Changes from v1:
 - Modify this driver for the R-Car S4-8 only
 - So, this patch set drops the followings:
 -- any dt doc modification
 -- X5H support.
 -- 5GBASER support
 -- Registers' macros

Thanks,

Michael

Michael Dege (2):
  phy: renesas: r8a779f0-ether-serdes: add USXGMII mode
  phy: renesas: r8a779f0-ether-serdes: add new step added to latest
    datasheet

 drivers/phy/renesas/r8a779f0-ether-serdes.c | 97 ++++++++++++++++++---
 1 file changed, 85 insertions(+), 12 deletions(-)

-- 
2.25.1


