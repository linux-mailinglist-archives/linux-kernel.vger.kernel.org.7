Return-Path: <linux-kernel+bounces-732664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3A5B06A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D90A1A6391A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27098633F;
	Wed, 16 Jul 2025 00:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JTQb1Kvk"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BCDEAC7
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752624937; cv=none; b=LHV9F2HTHFScRxgZF/v9S6QuX0/OD1gW7rVU0AK04NomybcAzBn1ylVUUmmLpMHZxd9EVD9dkF8bxG5uROQtNTrpVTFZ/7+WX/+OhBSGstgpUcMh8allB2gedFfzPYw1Kb63LDPsEjdvImBcuLEG9oA0xY8PRspA0pr20EcHpoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752624937; c=relaxed/simple;
	bh=bF3eAJPKjlAX0gmHM4YTfXjMQhi+hJNSNb/htMc19BY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jUyujzDpFIco1CDwhkwQueH5pJ1R2vHFh38mGonBM5Qkc7NSG5nU9TnNeX+/i3i9KB1USRvZmUKkTDYKDaM6/dORXXHgVC8BXgPv4PKl3oeB/9mhOnxvcjovr1JRTN8eL1APfpgbmiuMG0zr/CWbIpFi8O1Nm4aW/67N4an9JwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JTQb1Kvk; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752624930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NqDbyW0SQUqhy7PhdCLuIIofPAFpacRqZlTUSJkPTyE=;
	b=JTQb1Kvksng+jYaz/qIjlUMNHkTE6wJS+drkqD5B6/k3CPzRQtwKqfyb2H6msM8nV7uBRA
	y3ErCC9r3W8gycNE18Dr41nrdkPFjuhXXNaF3KTdv8h/r1dfC2UUk57d3tiDkIf/1DwamN
	AA0B31lDb7enfR1pMvq7BcpdkEVjiuY=
From: Zqiang <qiang.zhang@linux.dev>
To: oneukum@suse.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	pabeni@redhat.com
Cc: qiang.zhang@linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: usb: Make init_satus() return -ENOMEM if alloc failed
Date: Wed, 16 Jul 2025 08:15:23 +0800
Message-ID: <20250716001524.168110-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This commit make init_status() return -ENOMEM, if invoke
kmalloc() return failed.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 drivers/net/usb/usbnet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 921c05bc73e3..26fce452581c 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -254,6 +254,8 @@ static int init_status (struct usbnet *dev, struct usb_interface *intf)
 				"status ep%din, %d bytes period %d\n",
 				usb_pipeendpoint(pipe), maxp, period);
 		}
+	} else {
+		return -ENOMEM;
 	}
 	return 0;
 }
-- 
2.48.1


