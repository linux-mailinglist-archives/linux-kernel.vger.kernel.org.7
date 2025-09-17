Return-Path: <linux-kernel+bounces-820780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D3BB7F37C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E99D542FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18F0289E30;
	Wed, 17 Sep 2025 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N5K5iDzC"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619A32C3253
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114940; cv=none; b=roKdpTdERzpyqZmOtsxvHaA8EFukpH6NXMGBhWEhHckGIp2BPa/ui7lm6MVenzFoslflnsc5M2zD1nFx84QZX0EmHfFKKnIePUKcCQ5HwkBkDI3Ho7vAPN0tv52rEpjDNn61hw5AnnurNbBZuu1KAt6oPtWv4d+tV706Xbc1D+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114940; c=relaxed/simple;
	bh=Y5zSiew1HlsRxHI4TA0darBpHSgrE6KRq2+LTbfKjE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C5b/XXpxKu3aHMYhV6Wujv+VK1jWkmqCk2a8TxupwFMJZnICKaCiLZPWLEKKXsd57lrKgJWylYypUxgqwL4jeLGbko0CVOP963/wKwDo5jq2Zz67arZFMJI9tXFJx2bIrBZjavRTZ5q7k2z8jeYKhRjVuHFY/7sAJeaX37kORM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N5K5iDzC; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758114935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cquWK7kH4bLDDc69Dwd2sFVO799JniTrXyb2ALE4vnQ=;
	b=N5K5iDzCgsYmAAYZCZTxBJXUwSMV4wGTjMESjZDu5OHGtHpwWbtN59NCaMTjUUIU3cC4ZQ
	MyQgV169gltyPAeUuhy0JpV7+HoCQue+ZS3ItL7VVekvjEsaRWJT/aC7gwUK7KwI6iw1Po
	pvGX8pRN+iwPA+Q+XhrASZcMhUYWalY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jann Horn <jannh@google.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] comedi: Replace kcalloc + copy_from_user with memdup_array_user
Date: Wed, 17 Sep 2025 15:13:47 +0200
Message-ID: <20250917131349.117642-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kcalloc() followed by copy_from_user() with memdup_array_user()
to improve and simplify comedi_unlocked_ioctl().

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/comedi/comedi_fops.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 7e2f2b1a1c36..dea698e509b1 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -2284,15 +2284,10 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
 		rc = check_insnlist_len(dev, insnlist.n_insns);
 		if (rc)
 			break;
-		insns = kcalloc(insnlist.n_insns, sizeof(*insns), GFP_KERNEL);
-		if (!insns) {
-			rc = -ENOMEM;
-			break;
-		}
-		if (copy_from_user(insns, insnlist.insns,
-				   sizeof(*insns) * insnlist.n_insns)) {
-			rc = -EFAULT;
-			kfree(insns);
+		insns = memdup_array_user(insnlist.insns, insnlist.n_insns,
+					  sizeof(*insns));
+		if (IS_ERR(insns)) {
+			rc = PTR_ERR(insns);
 			break;
 		}
 		rc = do_insnlist_ioctl(dev, insns, insnlist.n_insns, file);
-- 
2.51.0


