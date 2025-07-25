Return-Path: <linux-kernel+bounces-745405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5C9B1196F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37461C267C0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144882BD59C;
	Fri, 25 Jul 2025 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Zh3rnGFx"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C661A9B58
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753430185; cv=none; b=HCAMAWgrZK+gZ+6aOxQjrmi6dtolmMWEz9zl51GAzF9Dd7Y/scACoYcZZ91Wi8iDz1TRkVUF2mENAJLH98iZYlO7y48Sxk8sIwxA0Pl5cmjC1dWnH4gRmpztqBu9QEwK6ehauE4lC2LqsmS/ZcV4QISN07/zGR26wzOn2c/CazM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753430185; c=relaxed/simple;
	bh=bHlJU8s3O85pMhN0e5lOrEmnGUFRZHa4Uyvqp1Hv3CY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pt9CDXw3l0p0mRFQa6WEG6MTzVVc0QnlbdkrisOMjCxAwaDRpWYRGLGDkYpeOQo4TV1mOrU72gK1n3UPgKINSm5reuIYWCWy0xjy/YZBsk9cQFy0Cu00p8seC/7RXonlSsH8Lr+HRMG7HN3M2DYDDUeIxLeRMhqmsPAkRgrZmn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Zh3rnGFx; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753430179; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=H+2iYihZj9Du+wmLcM2uaptjOmTGKx7rpf2tqr3MPFQ=;
	b=Zh3rnGFxYVFnwT8tbyBHYwRG/mmC8bdsG9owtj67dlrY4CJhZguk2bBI75aqm7PPJeAaXuHfy+oT/+H4G/j7ySIM2Uk/J7Whzvq000/WH16MzdbC5bOZjOT3VjWHhkyX1k+3VC8MxkEVviVq1zCK/leew7+5tnxSD/gB042Skl8=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WjwmeOr_1753430171 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 15:56:19 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] mailbox: remove unneeded semicolon
Date: Fri, 25 Jul 2025 15:56:10 +0800
Message-ID: <20250725075610.1973456-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

./drivers/mailbox/bcm74110-mailbox.c:483:2-3: Unneeded semicolon.
./drivers/mailbox/bcm74110-mailbox.c:563:2-3: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=22936
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/mailbox/bcm74110-mailbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/bcm74110-mailbox.c b/drivers/mailbox/bcm74110-mailbox.c
index 0680be8dc18f..623ece0b2c1e 100644
--- a/drivers/mailbox/bcm74110-mailbox.c
+++ b/drivers/mailbox/bcm74110-mailbox.c
@@ -480,7 +480,7 @@ static int bcm74110_mbox_send_data(struct mbox_chan *chan, void *data)
 		break;
 	default:
 		return -EINVAL;
-	};
+	}
 
 	return bcm74110_mbox_tx_msg(chan_priv->mbox, msg);
 }
@@ -560,7 +560,7 @@ static struct mbox_chan *bcm74110_mbox_of_xlate(struct mbox_controller *cntrl,
 	default:
 		dev_err(dev, "Invalid channel type: %d\n", type);
 		return ERR_PTR(-EINVAL);
-	};
+	}
 
 	return &cntrl->chans[type];
 }
-- 
2.43.5


