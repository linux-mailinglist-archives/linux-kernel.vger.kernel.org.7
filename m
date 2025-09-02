Return-Path: <linux-kernel+bounces-796331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3427FB3FF08
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598953BD3FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FB4305E09;
	Tue,  2 Sep 2025 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EX4AsSg4"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED882FF14C;
	Tue,  2 Sep 2025 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814227; cv=none; b=AywhVdMFvxs7bPgUhLfrF2jcYN1eRWG9GsKAPMIjFQy/OsgAnDNPN0oryj1SBKkccxFhjzUiT/oTZ1qifNSCH8rangb3PGW+LOROGD3u+d0fyraADHZpgFk/LZca9RChc7I4yf1oNmo5kg00iH8gcK+jmg8uQTlM3/qbCcmqQEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814227; c=relaxed/simple;
	bh=yA3LP5QVmcRjbpMbX945mpkBfWjMxWHDASdt5Mk5ZmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l4Z/7nQP80ed+iQlCNnFaLNa449H3sIAhUqFL17C+tQuH43CJseSSdggcQ2CAkRA6VNdWcIoUF5pJ15lDV9ijcaeJydB1HjmLP68Gm/8sudB/OXtKuQ086E779aXaNFgQM4nzSlx5GDr/hTzV+XLLsID6+jEl4PF4K7hhM4pkz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EX4AsSg4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756814223;
	bh=yA3LP5QVmcRjbpMbX945mpkBfWjMxWHDASdt5Mk5ZmQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EX4AsSg4ekc/PPJKfjR+l3Gwd3L+Cgy7X6wP2qCxliI7wYnr5pOHWzHd++z74qUNF
	 6mKTfy2t42HDEYvTU+oRj/DEuznvAdg+H3MVluuLl7dBx8N49HRBhu5aoLaeYJv5Hi
	 jeiHPYQVMiDAKMR0FNx2UxMHQuhvyERJ5Pkf3e6ZYj/uQPd7rbUc3opA4/hMq1/pTR
	 zAi+RYI9x1Pw9pMCzlawfeBlexXbeU7xoXaSYSkyGES2jsF+GcFGMANjXGEiB5I5DP
	 QCCksOTNKUwbe8xHLffxXTkFAsW4siZH1D0ejOwQWm/2EmKQdqQW16E9nVzcg16Mxx
	 ADa3fWtqOy3zA==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 6913217E0B84;
	Tue,  2 Sep 2025 13:57:03 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 14:56:31 +0300
Subject: [PATCH 09/17] usb: vhci-hcd: Simplify NULL comparison
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-vhci-hcd-cleanup-v1-9-1d46247cb234@collabora.com>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
In-Reply-To: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Use the shorter variants as suggested by checkpatch.pl:

  CHECK: Comparison to NULL could be written "!c"
  CHECK: Comparison to NULL could be written "!vhcis"

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/usb/usbip/vhci_hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index d3933979689f8cd141b3554e902c1e7b9fc6c694..e989be33ada00d5073f5753b72bb71d349c67b83 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1131,7 +1131,7 @@ static int hcd_name_to_id(const char *name)
 	int ret;
 
 	c = strchr(name, '.');
-	if (c == NULL)
+	if (!c)
 		return 0;
 
 	ret = kstrtol(c + 1, 10, &val);
@@ -1521,7 +1521,7 @@ static int __init vhci_hcd_init(void)
 		vhci_num_controllers = 1;
 
 	vhcis = kcalloc(vhci_num_controllers, sizeof(struct vhci), GFP_KERNEL);
-	if (vhcis == NULL)
+	if (!vhcis)
 		return -ENOMEM;
 
 	ret = platform_driver_register(&vhci_driver);

-- 
2.51.0


