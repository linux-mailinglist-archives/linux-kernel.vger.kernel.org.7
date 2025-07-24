Return-Path: <linux-kernel+bounces-743934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B364CB105AC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBDE1899B84
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C5D259C9F;
	Thu, 24 Jul 2025 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3mIb466"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EB6258CDC;
	Thu, 24 Jul 2025 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348878; cv=none; b=AbSmge22KWkzZzKn+TImxImxnMZarZm/cP5oNhM2xB1TEIKZQ4pJngtBP4E78+EzYMNkweuKBJMN4kmhswsGDyJVD2145e+ylVH5YiFGYYV04RlXzWd+WwwL/0Gmvd64g5M6UtUZ1zHEWHSmGRv4vr6PizyjCiboIraOrWiSsjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348878; c=relaxed/simple;
	bh=4S2sO9+gyKQlX7P6mYB1jRoLNXHl2nNd3KH07AQEZfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MrIN2n3BD+FtpkbkhLxJF/ZM/0j1aJYEskh1QEG0CzMRcIeutdDK1g/UENpua5VdazcLd6q78Zz2nnzyxqEA24zMNAztz5dW68D6B/6lEfB3kHTw89Th5GRQL33mprZUCPELcHDVpowM0+ptSqIjQ1jPM85e+mdXYHPmXqDQgKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3mIb466; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3A2C4CEED;
	Thu, 24 Jul 2025 09:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753348877;
	bh=4S2sO9+gyKQlX7P6mYB1jRoLNXHl2nNd3KH07AQEZfk=;
	h=From:To:Cc:Subject:Date:From;
	b=D3mIb466hgUoyjn3CtLAcMX/Y7iCJAQ3YT4+AyDhaES8J2rKTLLgFweBE0cl1q5N/
	 Oe1k1H1lUdyP9wLm171+KCYAYJRqlzxccTF57P3to16wNb28uGQTZLILnJeufXMqk8
	 +V9K31VdmLRH+P8JhQ5O36VmkV3bd85SCo1W1w3+CY/t14i6F/TuKFKx+ORiQuFWEC
	 9tIC0INu8dxAXJ7xBQNN0wn7tj2LRgGXLmSXzuN27UzmpafOAdoUFK0pCfnDRs91mF
	 i3A4qVxZA4jQEBPK9Urff7j+ka84BPKq/xLEvCQhVb8LDL2AE3XjAALzuHEfNQkiHn
	 4PBXVBVLvwjbA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ues8W-000000005Y9-0z7K;
	Thu, 24 Jul 2025 11:21:12 +0200
From: Johan Hovold <johan@kernel.org>
To: Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] usb: musb: omap2430: enable compile testing
Date: Thu, 24 Jul 2025 11:21:04 +0200
Message-ID: <20250724092104.21317-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nothing seems to prevent the driver from being compile tested on
non-OMAP platforms so enable it to provide wider build coverage.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/musb/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 9e45d12b81d3..f56929267eaa 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -84,7 +84,8 @@ config USB_MUSB_TUSB6010
 
 config USB_MUSB_OMAP2PLUS
 	tristate "OMAP2430 and onwards"
-	depends on ARCH_OMAP2PLUS && USB
+	depends on ARCH_OMAP2PLUS || COMPILE_TEST
+	depends on USB
 	depends on OMAP_CONTROL_PHY || !OMAP_CONTROL_PHY
 	select GENERIC_PHY
 
-- 
2.49.1


