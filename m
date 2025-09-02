Return-Path: <linux-kernel+bounces-796324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CED0AB3FEE1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CC31884BFB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29E52FC009;
	Tue,  2 Sep 2025 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="afy43oVa"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FEB2FABF0;
	Tue,  2 Sep 2025 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814221; cv=none; b=IWZIvs9o2nlXPAvm/vCyoln+FrmLxEjqFH/YRhHNzjS+EgYJ3rWfR+aHS7c36Ij5gzGCYJ9Y2A+2lSz/uXKF22H0t4m/zZHwegY+65Uv6DNrKRAors6RS4AkMFPOrE10nwhZSbor19LmJBIfEvY5NCoOI+o0vqmWctpFLzw52Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814221; c=relaxed/simple;
	bh=QnjGonsDqZPGnZZkeE224zwZkLc85sQkNvz+zjv8Pp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HefrP5r6yXMaLeuddgxMOv7hga+VIfacKCz2x1IdpJHRkv5LP7TEs8XmC8YkhvX157sW4/AFTH9UovkPR+Ts6i/XSZdFBP28bbcv2SnWQ3RzN03NrPQtNnFC5jctEnDW8xKAMiKugESlj5saXrMJaMLJmcgBfUvFb68+8Q3VwKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=afy43oVa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756814217;
	bh=QnjGonsDqZPGnZZkeE224zwZkLc85sQkNvz+zjv8Pp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=afy43oVarvQjEMo5QKKKvMwP6MmtDSFAfU9hRWlSE9UlAls0gEvEjWAuJh7FU3G5U
	 71Hu4o8JnOzo1Z+ohzkU168N2oqChq1AD4ub+cgidBwoa3a110qzs6X1poafdpYiMr
	 KFwh0S6bKl8U35EIqv+/LbpBwdKx8vNlcjXKead8FIc3PX0mJIgRIBV0UBNifgcaLh
	 gGqb2NxfaxGv3SfDDW8aMn3FzEsPXHfsNdTAU4btjC/cv0XM6fdnPC0H+OwsNTnxlj
	 OfV6a2ybNTd10AboJIkcpbuQjaED6NIVzRrKLfQBcBnQTLvac2BMzOjOFpSlO8zz6X
	 CWFuSIRtHtOQg==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 83E7617E10B7;
	Tue,  2 Sep 2025 13:56:57 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 14:56:24 +0300
Subject: [PATCH 02/17] usb: vhci-hcd: Consistently use the braces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-vhci-hcd-cleanup-v1-2-1d46247cb234@collabora.com>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
In-Reply-To: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Fix the inconsistent usage of braces as reported by checkpatch:

  CHECK: braces {} should be used on all arms of this statement
  CHECK: Unbalanced braces around else statement

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 764ade343bd4fb9d680f518ead997f6165214214..437c5dd8fa077310f4f15c3dd03cd805650b8999 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -346,8 +346,9 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		invalid_rhport = true;
 		if (wIndex > VHCI_HC_PORTS)
 			pr_err("invalid port number %d\n", wIndex);
-	} else
+	} else {
 		rhport = wIndex - 1;
+	}
 
 	vhci_hcd = hcd_to_vhci_hcd(hcd);
 	vhci = vhci_hcd->vhci;
@@ -598,11 +599,12 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 				     USB_SS_PORT_STAT_POWER) != 0) {
 					vhci_hcd->port_status[rhport] |= (1 << wValue);
 				}
-			} else
+			} else {
 				if ((vhci_hcd->port_status[rhport] &
 				     USB_PORT_STAT_POWER) != 0) {
 					vhci_hcd->port_status[rhport] |= (1 << wValue);
 				}
+			}
 		}
 		break;
 	case GetPortErrorCount:

-- 
2.51.0


