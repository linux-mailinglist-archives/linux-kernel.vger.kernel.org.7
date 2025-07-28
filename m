Return-Path: <linux-kernel+bounces-748278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1011B13EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 392187AE7FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE508274B52;
	Mon, 28 Jul 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnUOaRJE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200E22737E3;
	Mon, 28 Jul 2025 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717179; cv=none; b=MKekKwK7MbSbpeNhCDlEmjkdttSvG+X037EJqPPc8Pl+SXBCnb//hZRbB7QLAuufogRUMjHfKcbbXhU8kUa1FH4pQTvDBWae/np8c/J3kRoWolsJcYkBEABmEA0JuF1AWMg0VV6Aii88LZsqiv0gth2kbwzsRprImtTYisYc9N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717179; c=relaxed/simple;
	bh=fJ8DxG6HN180rt/dWpJklk55wcUF3JkaqyPkKVekboM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O8oKMA411JAfENtqFoJ50zmxkdWXzaJfsTibkr3cBbTUUFcAUa1JQw8QIf0lMMVfOVpq1yB+x67CUFq1YC9b5CZ68g9BDmHQSG7vcOh2asCYBWvwAtVllfAMJoAmZgi/s4OPKGG4qcGR/2EUyYqyTxp26CXkcoSCCTA5fHquPbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnUOaRJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1DCAC4CEEF;
	Mon, 28 Jul 2025 15:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753717178;
	bh=fJ8DxG6HN180rt/dWpJklk55wcUF3JkaqyPkKVekboM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DnUOaRJECUrLLJ8i05tXMW18w+oA78dbQL9mE64Dib6L5cbgnsa38ebgnM0v15/Tn
	 VkcwMqHBvPnuk3RbXWHYIYWEbZAdaMqkCwEVgVCJpFdgKWvV/36RTay9Qa9gPcdZN1
	 PWgyhn3L57gjGqB+lNhbKdGyJYPR1FWuf50Wl4bbFx3dXqlWbr9YFrQiCzL0E2a+86
	 O7SU8cTHM+lKee4mplphkPbDSXe5nT8H3jQgvghE6sucEQu2yUmYuAZAOMZ+KEVymA
	 dT2a7sUvCV0GiL2VVJ0lEFFRuz3hg06leXWwzCjmEAmxGJtC0GFgm5UdUEKBT93rJG
	 i4cCUhpewVguw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913D2C83F26;
	Mon, 28 Jul 2025 15:39:38 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH 0/2] phy: add basic support for NXPs TJA1145 CAN
 transceiver
Date: Mon, 28 Jul 2025 17:39:28 +0200
Message-Id: <20250728-tja1145-support-v1-0-ebd8494d545c@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALCZh2gC/x3MTQqAIBBA4avErBPU/qCrRAtxppoWKmoRhHdPW
 n6L915IFJkSzM0LkW5O7F2Fahuwh3E7CcZq0FIPctKjyKdRqh9EukLwMQscrUXbo0bTQa1CpI2
 f/7ispXz1AfMuYQAAAA==
X-Change-ID: 20250726-tja1145-support-d6ccdc4d2da3
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753717177; l=857;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=fJ8DxG6HN180rt/dWpJklk55wcUF3JkaqyPkKVekboM=;
 b=lUufaxZwR/txAdEzEBxXstUfbsDo1v0MhaMCRNENmFqiHgP4C4kqWYcjIFxM6//LzhIrfYy1a
 dbSDpBq/+0jAhwiJo/rbku+lz+BlwLiZQ5bm+vEvXssgvAZOw+6tPL9
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

Add basic driver support for NXPs TJA1145 CAN transceiver which brings the
PHY up/down by switching to normal/standby mode using SPI commands.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Dimitri Fedrau (2):
      dt-bindings: phy: add support for NXPs TJA1145 CAN transceiver
      phy: add basic support for NXPs TJA1145 CAN transceiver

 .../devicetree/bindings/phy/nxp,tja1145-can.yaml   |  79 +++++++++
 drivers/phy/Kconfig                                |  10 ++
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-nxp-tja1145.c                      | 185 +++++++++++++++++++++
 4 files changed, 275 insertions(+)
---
base-commit: 4a3556b81b99f0c8c0358f7cc6801a62b4538fe2
change-id: 20250726-tja1145-support-d6ccdc4d2da3

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



