Return-Path: <linux-kernel+bounces-857848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E170CBE810D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DE14261DA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D21311978;
	Fri, 17 Oct 2025 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WTP7GzL8"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149929BDB1
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696924; cv=none; b=Aan4yTpYBPjYR4Sx3hqf6jO4vgXX6I3KY09T5/B6ygn05+QEVI9jOXi8gJBb+gOgQgYwQ+iBvBhPxE3GN53JnRVtphd5/rAASk+4mWxsQTGe5q5O28WedvGjlZ6w6CKRAD5Ll6RvwB3FQ35cGFJ5gMNNi5Y/eqo4Nnbt/bL2UMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696924; c=relaxed/simple;
	bh=hDc2oFcdiWLdH/xSdtTVssubFRDytf79xyKFDmLkbsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGmqPssKyeDOaX33NVdroGeNUf8a5Y/iknhmNQAzABfc2aGO8+HQ3rzfUQKpyebxZWBT7QTV12P1M0poWyYDoyyU6DjZkbeKPHVskA7QHGSfPRmbV5VLY/lmV7ZmffCNhSBH8pF9Z4RcDBN1OLHLf/alUnPRlMBTuTsHB1cB8wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WTP7GzL8; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760696920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tm4ooCobJ7IPas/H5HYQmks0EaS+ndM5xWuuBgOopDI=;
	b=WTP7GzL8Jy2nRkV6hocOqUbWXZbhCRKkOqHe+t6d1OQbf5VbtuwnkhqLudQErrb9qS8KL5
	zh3c8jlGz7QWguxAbuGDSiipAi+VxUm7WNAVLXsagx2nnawqeVpVQsApfOLEYzSvAexKNR
	b5EcZTOb8D5EZlcGWdoAnif1ghCoDug=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2/2] stm class: Replace kzalloc + copy_from_user with memdup_user_nul
Date: Fri, 17 Oct 2025 12:27:44 +0200
Message-ID: <20251017102743.75394-4-thorsten.blum@linux.dev>
In-Reply-To: <20251017102743.75394-2-thorsten.blum@linux.dev>
References: <20251017102743.75394-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kzalloc() followed by copy_from_user() with memdup_user_nul() to
simplify and improve stm_char_policy_set_ioctl(). Remove the obsolete
comment.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/hwtracing/stm/core.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 5834f796e86b..335bcf749214 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -733,18 +733,9 @@ static int stm_char_policy_set_ioctl(struct stm_file *stmf, void __user *arg)
 	if (size < sizeof(*id) || size >= PATH_MAX + sizeof(*id))
 		return -EINVAL;
 
-	/*
-	 * size + 1 to make sure the .id string at the bottom is terminated,
-	 * which is also why memdup_user() is not useful here
-	 */
-	id = kzalloc(size + 1, GFP_KERNEL);
-	if (!id)
-		return -ENOMEM;
-
-	if (copy_from_user(id, arg, size)) {
-		ret = -EFAULT;
-		goto err_free;
-	}
+	id = memdup_user_nul(arg, size);
+	if (IS_ERR(id))
+		return PTR_ERR(id);
 
 	if (id->__reserved_0 || id->__reserved_1)
 		goto err_free;
-- 
2.51.0


