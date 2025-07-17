Return-Path: <linux-kernel+bounces-735567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F352B09111
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5FF1C42817
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2C92FCE2E;
	Thu, 17 Jul 2025 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hSA/bLe8"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490E32FC013;
	Thu, 17 Jul 2025 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767734; cv=none; b=YsWSAztOlTlXDzdst9im+WMVuuNrPuxPbBIuugwJkHKqj8pUE68tU8CT4gKv+4iWVD8YSyYoPw/UpWEp+UzVit9Vc7lVN8/2Ciuq3uYl/cDl0gdp0N5IBjdCdOtjcH1Cn38Jmmp3zxtPMlFoednAguhgIWjUL1IDm7IrUSxPmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767734; c=relaxed/simple;
	bh=RrHksrFkCg/NKrEpe92y6Svmo1I7KY/ch6FiLjn+DN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mvgxH7Mgdk3wb8D35k+uuNtqH1bB9j32Rby1AilSmYOFSTEW6jYHP1K9lGXeKOyIod6TDYGOPiiLPvfaavjRAV7IAl9ubI8yMdezYM+dtkVo5lMTu1vBdh31ROlZ62l7g4dYRL0gtOjoBnkdkkG4u4Qrz3IC5SP66+8Gw/v+pno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hSA/bLe8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752767730;
	bh=RrHksrFkCg/NKrEpe92y6Svmo1I7KY/ch6FiLjn+DN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hSA/bLe8DZxuEQU8M/DcpYvijG71b7Ey3e8SN1AAOp3/cikHkWksfYSjgQtu6GDiV
	 knmCPCwMT9g9MgY2wK+/ohZU4xnzd8ldhI8G4SE2jLgfcrI79bJn2xXWga+mwOSZDx
	 qx1Xs/R6vztQbAZ1OcjCcF9nPwMxw2fRgBx6CdZ6IUIaPWiv26tZvK5CyqjdrDZAQ3
	 C2tu+vQIu9N3fhpBUI1X+/sHzagwi6gpbRWKt0C9kM2I7jgJ9x9IT8qcPY6ZtY7C42
	 ttPiZ6S8pCSHHCMV9ewMDkF53pbtlRYzG2E7cEH9V0s2eGztJ+qyg8GPt/sj333qZl
	 TCOJgnBYAOXrA==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 455A617E14DC;
	Thu, 17 Jul 2025 17:55:30 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 17 Jul 2025 18:54:56 +0300
Subject: [PATCH 7/9] usb: vhci-hcd: Use the paranthesized form of sizeof
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-vhci-hcd-suspend-fix-v1-7-2b000cd05952@collabora.com>
References: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
In-Reply-To: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Fix the sizeof usage issue reported by checkpatch.pl:

  WARNING: sizeof *desc should be sizeof(*desc)

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index a2a8418c77e58ae9e06d673d0012b972c92ee33b..841902482fb15d1d86525f23492e4966f35630a0 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -286,7 +286,7 @@ static struct {
 static inline void
 ss_hub_descriptor(struct usb_hub_descriptor *desc)
 {
-	memset(desc, 0, sizeof *desc);
+	memset(desc, 0, sizeof(*desc));
 	desc->bDescriptorType = USB_DT_SS_HUB;
 	desc->bDescLength = 12;
 	desc->wHubCharacteristics = cpu_to_le16(HUB_CHAR_INDV_PORT_LPSM |

-- 
2.50.0


