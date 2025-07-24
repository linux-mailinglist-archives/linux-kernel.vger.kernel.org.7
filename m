Return-Path: <linux-kernel+bounces-744605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5467B10F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7D21892EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7962EAD0E;
	Thu, 24 Jul 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLlxFYS9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3422EA49D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372125; cv=none; b=TxixrYomLPoD/a6ddPyH2lUue3M9OK5LTGESx7vTSAikc9k7d0+HZWjmGh794g/qO+7xXMLiP+Tz+hYV9VqnWrEwXExYFUVFHwlPUoDhzQPfMGKfE3loWCyfGMjRb9uh3ob+oEEBjfXZpf1tH3py8DpIKFtPURhq+/c0sufL0gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372125; c=relaxed/simple;
	bh=MqIH2WftlenJEkZ7aVZ4T+tqBDomTp3GL6m592tTZXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyS7egPaYMQjFKSRjWm/Lxk2xjcBf9Nqt6OnOAqD8WwqZwWbg57su/anI4CMnQYLfwboWgYZjzLHiDQIGsmUXMRa/gVRnvJpfpsHWXUQ9ijQWrpyP/uo+DiXIRzt1gTM5dk4HvP0r2NudN+boZ/9X4HnQECKwfcyqbgTnFt03qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLlxFYS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C64C4CEF8;
	Thu, 24 Jul 2025 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753372124;
	bh=MqIH2WftlenJEkZ7aVZ4T+tqBDomTp3GL6m592tTZXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JLlxFYS9KffpIHCeFtPrikomy2NVw2jM52pMA7wEbxF51HxO/c0KrShpZ6xJG/+0t
	 z89Jw5vZxJTb16DGB5YsvxYv5LD2niZkDMbzAUTjPTL5jQiyvdDJp5UBbk+prIqQiu
	 CuZkEXsgyWNqSlKEwQJ6a4lhhAGFwBt0poZ6+FUlVdqqkf3lUDriYuw5+cKq8k8lp+
	 +DtnGjSmxI1EhDuXU+DYa6UcGn8P7liYspCi1gBZGciVZba2+obJtadHQyy9x11iEW
	 O1sP9leOKXBMqkSMrk20hlWWDw5+En7+KnsOsJ932R/Ejt4+VMAdOvLTUlddITGE5Y
	 NENG1BQqHqJpA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ueyBU-000000004B3-2JWp;
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
Subject: [PATCH 04/11] phy: hisilicon: hi6220-usb: drop unused module alias
Date: Thu, 24 Jul 2025 17:48:16 +0200
Message-ID: <20250724154823.15998-5-johan@kernel.org>
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
 drivers/phy/hisilicon/phy-hi6220-usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/hisilicon/phy-hi6220-usb.c b/drivers/phy/hisilicon/phy-hi6220-usb.c
index 97bd363dfe87..22d8d8a8dabe 100644
--- a/drivers/phy/hisilicon/phy-hi6220-usb.c
+++ b/drivers/phy/hisilicon/phy-hi6220-usb.c
@@ -161,5 +161,4 @@ static struct platform_driver hi6220_phy_driver = {
 module_platform_driver(hi6220_phy_driver);
 
 MODULE_DESCRIPTION("HISILICON HI6220 USB PHY driver");
-MODULE_ALIAS("platform:hi6220-usb-phy");
 MODULE_LICENSE("GPL");
-- 
2.49.1


