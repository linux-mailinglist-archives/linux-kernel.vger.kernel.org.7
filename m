Return-Path: <linux-kernel+bounces-745306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6146CB11832
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F9F5659CB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FE5284684;
	Fri, 25 Jul 2025 06:01:34 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id D9AF127F19F;
	Fri, 25 Jul 2025 06:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753423293; cv=none; b=K9Ry/MgJCNVwM3cFAtK75Ki0BwTiO8cHV3piH3dQC8ceSFyxmm6Lr+MnZKC8M/Tj1vLKgqAB0Z+Ri4SpB6TZL2YuQl8cugA9zJmmmHosqr7neukXBwKYyffFsXeK50MuAF3y5cm5hjpk14EWhtF9lBU9UNfNHtSVhJQV2jhl6Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753423293; c=relaxed/simple;
	bh=sIZ0MbeFvICbFqZ06S1DiZL/3SGp4hFYp2eCTHKFdyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=GrJG371zl13nCL86wBy+fIMOuGq3QJESAauLkt6HvWGebCj8FL/Dob9SsweyT/eZaBZ6I8sbiheRytuXtNf3D0Ypg6n5djzZHS7WhgIxpjhTe350voPD01qU1FXPK2yNUoUZ/qwTl4T9ltNNOQjNzdbyidgReipwsG9M26H0f2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id AAC596018CCD3;
	Fri, 25 Jul 2025 14:01:24 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: Su Hui <suhui@nfschina.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2] usb: xhci: print xhci->xhc_state when queue_command failed
Date: Fri, 25 Jul 2025 14:01:18 +0800
Message-Id: <20250725060117.1773770-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250725031308.1355371-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When encounters some errors like these:
xhci_hcd 0000:4a:00.2: xHCI dying or halted, can't queue_command
xhci_hcd 0000:4a:00.2: FIXME: allocate a command ring segment
usb usb5-port6: couldn't allocate usb_device

It's hard to know whether xhc_state is dying or halted. So it's better
to print xhc_state's value which can help locate the resaon of the bug.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
v2:
 - Print xhci->xhc_state with hex style.

 drivers/usb/host/xhci-ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 94c9c9271658..131e7530ec4a 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -4372,7 +4372,8 @@ static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
 
 	if ((xhci->xhc_state & XHCI_STATE_DYING) ||
 		(xhci->xhc_state & XHCI_STATE_HALTED)) {
-		xhci_dbg(xhci, "xHCI dying or halted, can't queue_command\n");
+		xhci_dbg(xhci, "xHCI dying or halted, can't queue_command. state: 0x%x\n",
+			 xhci->xhc_state);
 		return -ESHUTDOWN;
 	}
 
-- 
2.30.2


