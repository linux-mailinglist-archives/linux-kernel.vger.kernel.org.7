Return-Path: <linux-kernel+bounces-636901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C337FAAD189
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 01:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1753BDF37
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 23:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9F921D594;
	Tue,  6 May 2025 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NP0Q/voc"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3602B21CA18
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 23:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746574153; cv=none; b=NFylHPiFW78DHnyALcwyhAfs9eijvptsofzNP1n+iX0BcVzdWULr0QjuhihVVoBHYtCvLejotguIngVvh9xCvzMCSKd1P+AZYkNSxvLboNUbopZu+yAc+0oJ4H7MWleeoAI/23x/O5m4mEelH0M83jdIYoj9hK3mThw8ocGLRZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746574153; c=relaxed/simple;
	bh=CkAJNZGsqN+wKRqe2YfEbZgDdJl4391xwfv4kVcDbYo=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=dZ8Wv2SPvwf/NJfguX13g7D8qVf7hnfCzFblrTIlq1bpSvNZ/PGeIV7njrs6O7ENYyuXCSNb2rkk5aGS1GXK4a3fFSF7psMMLwXaW8+GDX96UbbiArKOz1NgiDFTbTfw6Batct0rNIJjnQgNZRxBW64BT4fjVDeR6bhfr8mgDc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NP0Q/voc; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22e3abea7e8so13019005ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 16:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746574150; x=1747178950; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PTmyf01T3gAbd8nVlWRowa1nLpLLaQXyEZs3lGMVO5A=;
        b=NP0Q/vocZKPrgXaDV1PptHwRy6m5/VOhfko1gZ9F3PfAucZdKUSuCsV3eNPISXktU0
         kg8RUFoFA9JWyv0hmLwtPnCmpkH1XgY1aEy9cxgrRFqy0By0Oc7+aQNLK54+w1HrxBeQ
         XR5xqRbiJVpiS1zYiaCC9b61r2cn016YW+YVk96JQgy7iK3X2XusuIsLkCDE/3vr92uD
         oaFgDwrT/tIjKBaR9YQLOKXdLjY0mpY83Jek32/8u7PsIBo0fzoly4Xo8won+IR+iWuJ
         ThMoZLEY0tS4BCFvlqxg0nLf7eVltH/iBSe4qX4+pjUxLd4/FMQNL7E07mG/OePT4BXV
         +tTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746574150; x=1747178950;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PTmyf01T3gAbd8nVlWRowa1nLpLLaQXyEZs3lGMVO5A=;
        b=XBQj5mb2CLUyjCGPY74Kj6Un0EheQKtlHxQVXwVi4cljTbLgBkiRyUC5GWrt6WvAc4
         NP56B4sPDxWHpGZWecKVIyDJYYWRZ+cMbmLpnkmONBX8DJ5kNpioflx7vGfTjMbhv8si
         dCMmhpKUlsacj98Mkkb7YtUiGffdZqHurLlJ6mDKPgOgRiHEgvFpw8/+19W96+akUrFK
         vHodH9VAgt1TlFcCsSDrwIHk4AtVFYMb5wAfnLdwO2mU9etnb6zBFjLXrfHlExIY1ykO
         fZ1oZeROvQaoAbxIV4Ydq998bzhqMaltQdsCI8gzOmTmJN/lFjEVTum9mU7bp6oyM4EH
         izFA==
X-Forwarded-Encrypted: i=1; AJvYcCUQLm3AfVsyH3a9iXH/yfcobDC84KDqfFO+hpshc2RYLA4+TGPvHUYLhUb7zKIXnVVe0Rb8+1X+6M4NPUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKrH+9vG0oJOHObuwBZQBK85KfHFpSkUw5Riih1eZWE/UDjHro
	Y9JTWV1wz45lDES8eRmE9872gKidTLOOBrd5nykj8a40e4GZwrn9IIMNj6VvwVhZZe5oisckwuT
	7NWomBJEwecB+dw==
X-Google-Smtp-Source: AGHT+IFQY5HUx0oa7l2vrt+vRSs5i6+wkH7b7/riSmc0WOaH6CUV5IpCXY0O4Zv4ruVzyyOy+ltJtS2lqzxtZsM=
X-Received: from plbkn8.prod.google.com ([2002:a17:903:788:b0:22e:42e5:9666])
 (user=rdbabiera job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ecd1:b0:224:191d:8a87 with SMTP id d9443c01a7336-22e5ea8a2f6mr14693045ad.26.1746574150482;
 Tue, 06 May 2025 16:29:10 -0700 (PDT)
Date: Tue,  6 May 2025 23:28:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8802; i=rdbabiera@google.com;
 h=from:subject; bh=CkAJNZGsqN+wKRqe2YfEbZgDdJl4391xwfv4kVcDbYo=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDBlSs02/qkj/aH77aKoq/yXHUyLeZQwpYWGCa6U3TJhsf
 LF/7wOOjlIWBjEOBlkxRRZd/zyDG1dSt8zhrDGGmcPKBDKEgYtTACaiMY/hr8zim/VfJ4aybbyf
 08jh6xtS3PPZ+tqVlVpylbwFWfIJKxkZWrYx1tXrey86dfSw9voVT4w/H2B1r3Twm9XStdxtl34 qKwA=
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250506232853.1968304-2-rdbabiera@google.com>
Subject: [PATCH v2] usb: typec: tcpm: move tcpm_queue_vdm_unlocked to
 asynchronous work
From: RD Babiera <rdbabiera@google.com>
Cc: heikki.krogerus@linux.intel.com, badhri@google.com, 
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, RD Babiera <rdbabiera@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A state check was previously added to tcpm_queue_vdm_unlocked to
prevent a deadlock where the DisplayPort Alt Mode driver would be
executing work and attempting to grab the tcpm_lock while the TCPM
was holding the lock and attempting to unregister the altmode, blocking
on the altmode driver's cancel_work_sync call.

Because the state check isn't protected, there is a small window
where the Alt Mode driver could determine that the TCPM is
in a ready state and attempt to grab the lock while the
TCPM grabs the lock and changes the TCPM state to one that
causes the deadlock. The callstack is provided below:

[110121.667392][    C7] Call trace:
[110121.667396][    C7]  __switch_to+0x174/0x338
[110121.667406][    C7]  __schedule+0x608/0x9f0
[110121.667414][    C7]  schedule+0x7c/0xe8
[110121.667423][    C7]  kernfs_drain+0xb0/0x114
[110121.667431][    C7]  __kernfs_remove+0x16c/0x20c
[110121.667436][    C7]  kernfs_remove_by_name_ns+0x74/0xe8
[110121.667442][    C7]  sysfs_remove_group+0x84/0xe8
[110121.667450][    C7]  sysfs_remove_groups+0x34/0x58
[110121.667458][    C7]  device_remove_groups+0x10/0x20
[110121.667464][    C7]  device_release_driver_internal+0x164/0x2e4
[110121.667475][    C7]  device_release_driver+0x18/0x28
[110121.667484][    C7]  bus_remove_device+0xec/0x118
[110121.667491][    C7]  device_del+0x1e8/0x4ac
[110121.667498][    C7]  device_unregister+0x18/0x38
[110121.667504][    C7]  typec_unregister_altmode+0x30/0x44
[110121.667515][    C7]  tcpm_reset_port+0xac/0x370
[110121.667523][    C7]  tcpm_snk_detach+0x84/0xb8
[110121.667529][    C7]  run_state_machine+0x4c0/0x1b68
[110121.667536][    C7]  tcpm_state_machine_work+0x94/0xe4
[110121.667544][    C7]  kthread_worker_fn+0x10c/0x244
[110121.667552][    C7]  kthread+0x104/0x1d4
[110121.667557][    C7]  ret_from_fork+0x10/0x20

[110121.667689][    C7] Workqueue: events dp_altmode_work
[110121.667697][    C7] Call trace:
[110121.667701][    C7]  __switch_to+0x174/0x338
[110121.667710][    C7]  __schedule+0x608/0x9f0
[110121.667717][    C7]  schedule+0x7c/0xe8
[110121.667725][    C7]  schedule_preempt_disabled+0x24/0x40
[110121.667733][    C7]  __mutex_lock+0x408/0xdac
[110121.667741][    C7]  __mutex_lock_slowpath+0x14/0x24
[110121.667748][    C7]  mutex_lock+0x40/0xec
[110121.667757][    C7]  tcpm_altmode_enter+0x78/0xb4
[110121.667764][    C7]  typec_altmode_enter+0xdc/0x10c
[110121.667769][    C7]  dp_altmode_work+0x68/0x164
[110121.667775][    C7]  process_one_work+0x1e4/0x43c
[110121.667783][    C7]  worker_thread+0x25c/0x430
[110121.667789][    C7]  kthread+0x104/0x1d4
[110121.667794][    C7]  ret_from_fork+0x10/0x20

Change tcpm_queue_vdm_unlocked to queue for tcpm_queue_vdm_work,
which can perform the state check while holding the TCPM lock
while the Alt Mode lock is no longer held. This requires a new
struct to hold the vdm data, altmode_vdm_event.

Fixes: cdc9946ea637 ("usb: typec: tcpm: enforce ready state when queueing alt mode vdm")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes from v1:
* modified commit message to include call stack
---
 drivers/usb/typec/tcpm/tcpm.c | 91 +++++++++++++++++++++++++++--------
 1 file changed, 71 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 784fa23102f9..9b8d98328ddb 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -597,6 +597,15 @@ struct pd_rx_event {
 	enum tcpm_transmit_type rx_sop_type;
 };
 
+struct altmode_vdm_event {
+	struct kthread_work work;
+	struct tcpm_port *port;
+	u32 header;
+	u32 *data;
+	int cnt;
+	enum tcpm_transmit_type tx_sop_type;
+};
+
 static const char * const pd_rev[] = {
 	[PD_REV10]		= "rev1",
 	[PD_REV20]		= "rev2",
@@ -1610,18 +1619,68 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
 	mod_vdm_delayed_work(port, 0);
 }
 
-static void tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
-				    const u32 *data, int cnt, enum tcpm_transmit_type tx_sop_type)
+static void tcpm_queue_vdm_work(struct kthread_work *work)
 {
-	if (port->state != SRC_READY && port->state != SNK_READY &&
-	    port->state != SRC_VDM_IDENTITY_REQUEST)
-		return;
+	struct altmode_vdm_event *event = container_of(work,
+						       struct altmode_vdm_event,
+						       work);
+	struct tcpm_port *port = event->port;
 
 	mutex_lock(&port->lock);
-	tcpm_queue_vdm(port, header, data, cnt, tx_sop_type);
+	if (port->state != SRC_READY && port->state != SNK_READY &&
+	    port->state != SRC_VDM_IDENTITY_REQUEST) {
+		tcpm_log_force(port, "dropping altmode_vdm_event");
+		goto port_unlock;
+	}
+
+	tcpm_queue_vdm(port, event->header, event->data, event->cnt, event->tx_sop_type);
+
+port_unlock:
+	kfree(event->data);
+	kfree(event);
 	mutex_unlock(&port->lock);
 }
 
+static int tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
+				   const u32 *data, int cnt, enum tcpm_transmit_type tx_sop_type)
+{
+	struct altmode_vdm_event *event;
+	u32 *data_cpy;
+	int ret = -ENOMEM;
+
+	event = kzalloc(sizeof(*event), GFP_KERNEL);
+	if (!event)
+		goto err_event;
+
+	data_cpy = kcalloc(cnt, sizeof(u32), GFP_KERNEL);
+	if (!data_cpy)
+		goto err_data;
+
+	kthread_init_work(&event->work, tcpm_queue_vdm_work);
+	event->port = port;
+	event->header = header;
+	memcpy(data_cpy, data, sizeof(u32) * cnt);
+	event->data = data_cpy;
+	event->cnt = cnt;
+	event->tx_sop_type = tx_sop_type;
+
+	ret = kthread_queue_work(port->wq, &event->work);
+	if (!ret) {
+		ret = -EBUSY;
+		goto err_queue;
+	}
+
+	return 0;
+
+err_queue:
+	kfree(data_cpy);
+err_data:
+	kfree(event);
+err_event:
+	tcpm_log_force(port, "failed to queue altmode vdm, err:%d", ret);
+	return ret;
+}
+
 static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
 {
 	u32 vdo = p[VDO_INDEX_IDH];
@@ -2832,8 +2891,7 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
 	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
-	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP);
-	return 0;
+	return tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP);
 }
 
 static int tcpm_altmode_exit(struct typec_altmode *altmode)
@@ -2849,8 +2907,7 @@ static int tcpm_altmode_exit(struct typec_altmode *altmode)
 	header = VDO(altmode->svid, 1, svdm_version, CMD_EXIT_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
-	tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP);
-	return 0;
+	return tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP);
 }
 
 static int tcpm_altmode_vdm(struct typec_altmode *altmode,
@@ -2858,9 +2915,7 @@ static int tcpm_altmode_vdm(struct typec_altmode *altmode,
 {
 	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
 
-	tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP);
-
-	return 0;
+	return tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP);
 }
 
 static const struct typec_altmode_ops tcpm_altmode_ops = {
@@ -2884,8 +2939,7 @@ static int tcpm_cable_altmode_enter(struct typec_altmode *altmode, enum typec_pl
 	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
-	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP_PRIME);
-	return 0;
+	return tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP_PRIME);
 }
 
 static int tcpm_cable_altmode_exit(struct typec_altmode *altmode, enum typec_plug_index sop)
@@ -2901,8 +2955,7 @@ static int tcpm_cable_altmode_exit(struct typec_altmode *altmode, enum typec_plu
 	header = VDO(altmode->svid, 1, svdm_version, CMD_EXIT_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
-	tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP_PRIME);
-	return 0;
+	return tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP_PRIME);
 }
 
 static int tcpm_cable_altmode_vdm(struct typec_altmode *altmode, enum typec_plug_index sop,
@@ -2910,9 +2963,7 @@ static int tcpm_cable_altmode_vdm(struct typec_altmode *altmode, enum typec_plug
 {
 	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
 
-	tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP_PRIME);
-
-	return 0;
+	return tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP_PRIME);
 }
 
 static const struct typec_cable_ops tcpm_cable_ops = {

base-commit: 588d032e9e566997db3213dee145dbe3bda297b6
-- 
2.49.0.967.g6a0df3ecc3-goog


