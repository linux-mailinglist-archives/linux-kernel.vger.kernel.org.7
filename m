Return-Path: <linux-kernel+bounces-874070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0E2C156F3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CEFB2355344
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50314341AC8;
	Tue, 28 Oct 2025 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zsr5vbNp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD43341657
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665197; cv=none; b=geGz1uAe/zd0K81XGbcbIjoSGUwYbsCYoipF0hb5AkdmebNpbzC2G5aAnh0jaGBz8k+g5NBFjV4hVfsqsZwXoQ+5OWd5eXmozOm8Cv8Jm8RdZ1qrsnSKK/XpRXqtH9fe4aFuqpASE3gI0nn+wNJlXtO6ThE69s8lqxPilP+6Uec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665197; c=relaxed/simple;
	bh=uk4BXDqQZAgKrVvpodOAU8C2ZzT9WsLHCrNjmUbOuuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XLg3x+UsbPWrkbo1nnOz4KWyLUV26IAk1Viyq3Jrs0fWqHTNS5iV4LmvMtYpc/czMs2SoOzGb9FbsAlv3pHRm75Llw2+eSDxHeXtnEcwEhronqz6dcEkwgVXoW3HtpU3T5Am0ePvLmkJcPNZ80icvp4ahq9SM9gbX+WtuLOz+Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zsr5vbNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3768DC4CEFD;
	Tue, 28 Oct 2025 15:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761665197;
	bh=uk4BXDqQZAgKrVvpodOAU8C2ZzT9WsLHCrNjmUbOuuk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zsr5vbNpeCASQVoVA89FzshZNjVQeNybVav7TArfjjGz0NBsdOXD5gZRLvoMafmGW
	 8Fi15S8xgwf8U7jtMi1ALItXHPTidOFf+yXF47MRpLMnhYAIoYRggjxE+klAz9PSxq
	 KVjtyuMkH+HQQa9F5GjpQzyFbC8uaBJduiP3V6IAD3Q40nKl6M2dOYGNl++qwZtveY
	 4ITErAtU3DR3ygX79kq3S1vII4WPmT9BH6Pv42W2j/v1BzjN04K/XZJaf9jWXe9zJT
	 xt04l2UDbf8wJ926UWP119j1yyWi3B3E4W9/RbxneJ76wxeYiYOYDbb7KLl88FK337
	 aVuH0YF2WePzg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 28 Oct 2025 16:26:22 +0100
Subject: [PATCH 3/5] nvmet-fcloop: check all request and response have been
 processed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-nvmet-fcloop-fixes-v1-3-765427148613@kernel.org>
References: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
In-Reply-To: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3

When the remoteport or the targetport are removed check that there are
no inflight requests or responses.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 5dffcc5becae..4e429a1ea2bd 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1111,8 +1111,10 @@ fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 	rport->nport->rport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
-	if (put_port)
+	if (put_port) {
+		WARN_ON(!list_empty(&rport->ls_list));
 		fcloop_nport_put(rport->nport);
+	}
 }
 
 static void
@@ -1130,8 +1132,10 @@ fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 	tport->nport->tport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
-	if (put_port)
+	if (put_port) {
+		WARN_ON(!list_empty(&tport->ls_list));
 		fcloop_nport_put(tport->nport);
+	}
 }
 
 #define	FCLOOP_HW_QUEUES		4

-- 
2.51.0


