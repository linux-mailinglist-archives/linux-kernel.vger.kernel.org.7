Return-Path: <linux-kernel+bounces-616317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48373A98AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 15:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACFE3445479
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 13:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219ED17A58F;
	Wed, 23 Apr 2025 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axpj7R5q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CB41A2387
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745414534; cv=none; b=cBNLMJwNVy1VU3oejKp5yEDfee1j2+/DjkTah8VKGGUi2ec4GtVNcAWmobIqU8oODjjKDC5fMfChkhOuDklPUYTnjAprt1Qbljj10Q4ACaSCM/Kyo5Rj0t3H0bjvTBnkGtzKvnQbAac7QOzm4nXcNBezDyFL/05Y2PGBDZ0T5jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745414534; c=relaxed/simple;
	bh=YmvfucME6p9mQbq10tqk6j4ONnoLmEFU9LLeZ/eqRUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HaznCsFh68MCbc6pr5l5SU0Yj8TVfGfuTbmxMttiTd3/+TPyY8Rm9qqBo5f8WI2ETOiLQrCUMHXP1uz1Wnc2r2S7JJJUtUvHJmRGomv8FLifdP1fl5sjE8NB49z21CA058bTKBc8mwNX5X29poTG/+GCjdzMuYprk5yqF1JnrL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axpj7R5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A02C4CEEC;
	Wed, 23 Apr 2025 13:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745414534;
	bh=YmvfucME6p9mQbq10tqk6j4ONnoLmEFU9LLeZ/eqRUU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=axpj7R5q57Mj82o3h/MOqTF2aEcTMNDebumr54f6EJh6MmVFEog2tkq75/SiowMhA
	 trvi45zHR4C5D9cm8bilF8462kmu82ln4qvPMiEWwuOEDQ8zb+J4fWprBqzN7Cf9nS
	 cFyAmNS0no5ht/gR0h6BqTeq+l7sYSF22lknP6rT2Imd/lcjH8NW2PwlG7lWf3G0jk
	 yiIJpsN9VRyJxZ75ZR9KeLP+e+q3caqttjdEx2eZYGWKS54Az7IJ8Vs/V/FbWZ4Kta
	 01UvBGKkMaFTe6tWcloR4cqDVxDcGrtS1jqa7KDYx9gzQkj7X9we70RxzoPP3HlWc7
	 BiNfsCJ0ihZMg==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 23 Apr 2025 15:21:51 +0200
Subject: [PATCH v5 08/14] nvmet-fcloop: prevent double port deletion
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-nvmet-fcloop-v5-8-3d7f968728a5@kernel.org>
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
In-Reply-To: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

The delete callback can be called either via the unregister function or
from the transport directly. Thus it is necessary ensure resources are
not freed multiple times.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 9adaee3c7129f7e270842c5d09f78de2e108479a..014cc66f92cb1db0a81a79d2109eae3fff5fd38a 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -215,6 +215,9 @@ struct fcloop_lport_priv {
 	struct fcloop_lport *lport;
 };
 
+/* The port is already being removed, avoid double free */
+#define PORT_DELETED	0
+
 struct fcloop_rport {
 	struct nvme_fc_remote_port	*remoteport;
 	struct nvmet_fc_target_port	*targetport;
@@ -223,6 +226,7 @@ struct fcloop_rport {
 	spinlock_t			lock;
 	struct list_head		ls_list;
 	struct work_struct		ls_work;
+	unsigned long			flags;
 };
 
 struct fcloop_tport {
@@ -233,6 +237,7 @@ struct fcloop_tport {
 	spinlock_t			lock;
 	struct list_head		ls_list;
 	struct work_struct		ls_work;
+	unsigned long			flags;
 };
 
 struct fcloop_nport {
@@ -1067,14 +1072,20 @@ static void
 fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 {
 	struct fcloop_rport *rport = remoteport->private;
+	bool delete_port = true;
 	unsigned long flags;
 
 	flush_work(&rport->ls_work);
 
 	spin_lock_irqsave(&fcloop_lock, flags);
+	if (test_and_set_bit(PORT_DELETED, &rport->flags))
+		delete_port = false;
 	rport->nport->rport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
+	if (!delete_port)
+		return;
+
 	fcloop_nport_put(rport->nport);
 }
 
@@ -1082,14 +1093,20 @@ static void
 fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 {
 	struct fcloop_tport *tport = targetport->private;
+	bool delete_port = true;
 	unsigned long flags;
 
 	flush_work(&tport->ls_work);
 
 	spin_lock_irqsave(&fcloop_lock, flags);
+	if (test_and_set_bit(PORT_DELETED, &tport->flags))
+		delete_port = false;
 	tport->nport->tport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
+	if (!delete_port)
+		return;
+
 	fcloop_nport_put(tport->nport);
 }
 
@@ -1433,6 +1450,7 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
 	rport->nport = nport;
 	rport->lport = nport->lport;
 	nport->rport = rport;
+	rport->flags = 0;
 	spin_lock_init(&rport->lock);
 	INIT_WORK(&rport->ls_work, fcloop_rport_lsrqst_work);
 	INIT_LIST_HEAD(&rport->ls_list);
@@ -1530,6 +1548,7 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
 	tport->nport = nport;
 	tport->lport = nport->lport;
 	nport->tport = tport;
+	tport->flags = 0;
 	spin_lock_init(&tport->lock);
 	INIT_WORK(&tport->ls_work, fcloop_tport_lsrqst_work);
 	INIT_LIST_HEAD(&tport->ls_list);

-- 
2.49.0


