Return-Path: <linux-kernel+bounces-794463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B07B3E21F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB653AEB86
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56FE25524D;
	Mon,  1 Sep 2025 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="g0ZqsjAQ"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE31E16F265;
	Mon,  1 Sep 2025 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756728018; cv=none; b=fZQCJ1omlozst5TQ/qztZrivcSgea6G53OpZuiw/E0aInkFHqi0Atmjapuky7plyRmHAGdimLxsato6ef6P+QQ3vWFM5QEEPkZEshoGNl0IHCbxkQr4qzKeNuU3566cax0/ZqOCQq+VzP9jTKxUYbbP8rUdKT/cHDk5NInaDV0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756728018; c=relaxed/simple;
	bh=ncDkAmTwT0Rkkhhm8MfP1Yyb9PyuX7v/Xxr+SiRs5Zs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=p7+RC9OzIdJDdn079x1RKKfRAKIFrhJfYk62zqMJjpZX2JtvwtVKLzwUpErWdcr1pRU11MVEPLQeI93EFAJR10jGD49b33Vd1T3KM+Z6fc2CNnhDyx0nt7lH54n9ONOjHILTcmTzs2GKRHhDAvih1saHvutF5RlfS76XVBPd6Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=g0ZqsjAQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1218)
	id 6D6B52119398; Mon,  1 Sep 2025 05:00:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6D6B52119398
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756728015;
	bh=DqjAdCMHVkkdWzLTGnh/chMDtmy2mjtPszEjqUE3nck=;
	h=From:To:Cc:Subject:Date:From;
	b=g0ZqsjAQ52x/XWjrNdB22RvqpUEDOMxkYMUiAmF5tkUuKpSaRZJuxs61CCdAcMnB6
	 cqXYYCKBWnoBbKaCgyrLB0ehnHSklgpUaM9fSk2BP5fdVJEmUrtvUZmzryvltpByQH
	 oPgXSVLq70HjCcRUzrODBCS0M7nA+Ee5Ec8Q0F9U=
From: Abhishek Tiwari <abhitiwari@linux.microsoft.com>
To: abhitiwari@microsoft.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ssengar@microsoft.com
Cc: Abhishek Tiwari <abhitiwari@linux.microsoft.com>
Subject: [PATCH v2] Drivers: hv: util: Cosmetic changes for hv_utils_transport.c
Date: Mon,  1 Sep 2025 05:00:00 -0700
Message-Id: <1756728000-8324-1-git-send-email-abhitiwari@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix issues reported by checkpatch.pl script for hv_utils_transport.c file 
- Update pr_warn() calls to use __func__ for consistent logging context. 
- else should follow close brace '}'

No functional changes intended.

Signed-off-by: Abhishek Tiwari <abhitiwari@linux.microsoft.com>
Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
---
Changes in v2:
- Replace "x86/hyperv:" with "Drivers: hv: util:" in patch title.
---
 drivers/hv/hv_utils_transport.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/hv_utils_transport.c b/drivers/hv/hv_utils_transport.c
index 832885198643..b3de35ff6334 100644
--- a/drivers/hv/hv_utils_transport.c
+++ b/drivers/hv/hv_utils_transport.c
@@ -129,8 +129,7 @@ static int hvt_op_open(struct inode *inode, struct file *file)
 		 * device gets released.
 		 */
 		hvt->mode = HVUTIL_TRANSPORT_CHARDEV;
-	}
-	else if (hvt->mode == HVUTIL_TRANSPORT_NETLINK) {
+	} else if (hvt->mode == HVUTIL_TRANSPORT_NETLINK) {
 		/*
 		 * We're switching from netlink communication to using char
 		 * device. Issue the reset first.
@@ -195,7 +194,7 @@ static void hvt_cn_callback(struct cn_msg *msg, struct netlink_skb_parms *nsp)
 	}
 	spin_unlock(&hvt_list_lock);
 	if (!hvt_found) {
-		pr_warn("hvt_cn_callback: spurious message received!\n");
+		pr_warn("%s: spurious message received!\n", __func__);
 		return;
 	}
 
@@ -210,7 +209,7 @@ static void hvt_cn_callback(struct cn_msg *msg, struct netlink_skb_parms *nsp)
 	if (hvt->mode == HVUTIL_TRANSPORT_NETLINK)
 		hvt_found->on_msg(msg->data, msg->len);
 	else
-		pr_warn("hvt_cn_callback: unexpected netlink message!\n");
+		pr_warn("%s: unexpected netlink message!\n", __func__);
 	mutex_unlock(&hvt->lock);
 }
 
@@ -260,8 +259,9 @@ int hvutil_transport_send(struct hvutil_transport *hvt, void *msg, int len,
 		hvt->outmsg_len = len;
 		hvt->on_read = on_read_cb;
 		wake_up_interruptible(&hvt->outmsg_q);
-	} else
+	} else {
 		ret = -ENOMEM;
+	}
 out_unlock:
 	mutex_unlock(&hvt->lock);
 	return ret;
-- 
2.43.0


