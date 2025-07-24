Return-Path: <linux-kernel+bounces-744603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 663FDB10F19
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD0E188590B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D812EACF2;
	Thu, 24 Jul 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMqKTTSN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F234E2EA493
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372125; cv=none; b=up0oOPkohLGOfrXVdwcrw1p735fWFZ9RYiaQSaoxwQiK6nEG2auAVuS++OLdKmAE8NEsfXbmdtZiX4Kmg+rx2Mz+PEYr/MgXIXR9qMz+Fk3iwsT028FvRaAOT93wGX/Maz1MoV2MMicjsj0CcAuSJr5S7Hhcwg9fkw8KI9yqehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372125; c=relaxed/simple;
	bh=e/8NAyoj8ZEz00eT4Nb5mCe50iuncMcLu4YwCuEbzFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qo+XIATcjkJlBMXLvxY3UJxlU5pEC3LLcC2VxXsPmy/CUMWRO9VhUIDjPngIvgA8js3yF1I7g1nJz4CfFSB8il4LTd7RLtF6ki9dfQ+uLJNwAc8szGCsIqcsDVoU9fCbTrZlB7shzsZKrpHrhEeijahKfaN0bO30OSL38RuQlzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMqKTTSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8421C4CEED;
	Thu, 24 Jul 2025 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753372124;
	bh=e/8NAyoj8ZEz00eT4Nb5mCe50iuncMcLu4YwCuEbzFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rMqKTTSNvkEVQ+EBczP9tBTslJzBuQCdmLWg1QqnEUWrO2eqtmQEVgpC0RBbV5vUO
	 kNVY89ik7MaMAV8GQVlmurF5O8AHB1QN6OJa4dyO6kij44/uL9fVxHvkOzghtVqm/P
	 vDfISwPr+dr8Npg64zhX9d+9DgzWP8FtPBYv3irbBgPGd83vAOaNzRuBR2ig0M0/Vl
	 cSuY+23MMrty3auP6zAbp7flJgx2mFFZUJkvT7m/+RsIN1HqgREnRZ28/IQsLppOqn
	 nIzmnIQ9aqPXy7kHUrePQiOoguEeV2BQEKzZJ42VJ2FKaumLE+UG8Zlubsw2czyNd2
	 Z5l3FfUSxY+gw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ueyBU-000000004Aw-1Mbh;
	Thu, 24 Jul 2025 17:48:40 +0200
From: Johan Hovold <johan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Justin Chen <justin.chen@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 01/11] phy: broadcom: brcm-sata: drop unused module alias
Date: Thu, 24 Jul 2025 17:48:13 +0200
Message-ID: <20250724154823.15998-2-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250724154823.15998-1-johan@kernel.org>
References: <20250724154823.15998-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver has never supported anything but OF probe so drop the unused
platform module alias.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/phy/broadcom/phy-brcm-sata.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-brcm-sata.c b/drivers/phy/broadcom/phy-brcm-sata.c
index d52dd065e862..fb69e21a0292 100644
--- a/drivers/phy/broadcom/phy-brcm-sata.c
+++ b/drivers/phy/broadcom/phy-brcm-sata.c
@@ -850,4 +850,3 @@ MODULE_DESCRIPTION("Broadcom SATA PHY driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Marc Carino");
 MODULE_AUTHOR("Brian Norris");
-MODULE_ALIAS("platform:phy-brcm-sata");
-- 
2.49.1


