Return-Path: <linux-kernel+bounces-840995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86378BB5EBD
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 06:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D9B19C624F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 04:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C24D2264BD;
	Fri,  3 Oct 2025 04:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwFlzdvc"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A023223337
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 04:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759465979; cv=none; b=g+bYxnebynmFYPih2pIC6Sg9wNeAY6pEqwulMsCIE4YYpMq0dFzWSfsC2y+bhKi/qPyp+V5kpSCp3vSMM8e7XOKad5R7ZlS1SDo8bTSDG6KI7m1wdX7wFO1DFEVOLOnS2RiVzGyOf4yLJ3dtNDtR9c5JB0PHsaqYfUS5yYJzrwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759465979; c=relaxed/simple;
	bh=/TjxyRjXn5vKm7N0CPYK5CIrgVeXHkM5aYlhADtKSeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KULq3KSmFs1TKBVB+k5kham24rBvpKx3yFu9ap98QBkpiWQKnTB95KfyPYjgfZO5UPIeSWEOapL3h1YwrcfWUGXk33a2A4DUJbMve2GBjDdi5EgWZXVXFeRuEx5mtd6QFuVfPz/3F454LbAeVCMcBtETF4fgvV3RVi5sOt+AKGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwFlzdvc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7811a5ec5b6so2327086b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 21:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759465976; x=1760070776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RfUYBKsuo8ddTyCuM4jvFb8g3qBzZAb/Bm18mx0r0I=;
        b=iwFlzdvcAOpvQrdxPOpFKG648z1hp5V1ACgABbOyW2IUog7DRq4dCgqjWk8Rd7MPQ9
         guNGGsjFLMBvbesBt7W1u43qYBioArFnL+RsS0EU0J9Ve842B3IdrMHAach1GN/Em4SA
         jzia6ClqJxoLd9c660/U2XWsTFwnR7cNz0OWfHebJ9OH8A/zkZ+4KrkHs28ErCjRvZTM
         Zz5cJT1NeXBM8GschXdLOEEcRowZcyL5ahGvDJRVZdLtA8Jw02f7cnm1vXk+0Gy+BKpI
         TRWOb5n3CyawhHeo8unr9fe9gteJOkI2f/GC8pWxs4ecwSRDaQqCNYRwGZU33AfqOxWA
         gJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465976; x=1760070776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RfUYBKsuo8ddTyCuM4jvFb8g3qBzZAb/Bm18mx0r0I=;
        b=tjKjOXSaNBqXWpsXZIelXbUnZDi72iwZTYZl+r4lyZfg2qV3w7/02Lq/tEYPkcvXQM
         ey+ynN0jbSFZ0qT+RYH0fMKfwEXrgOT3+/ODac0xxqkJL4CnZafvad2DOuSsjkmY1Co3
         9l5wLpeAGpjO0Uu35coHt2kwNugjYC2AxP4vbFh2ylzbTK3w4e/OOg03Sf6L7FG9rMv2
         YdLV7JUhz5oAVnlR02xPXQ//IMgvL/KyaokuJlFg9dP9eCSigyxbtK7RXBI8ElgIPllc
         rxUmh2fvWuThQEdyAimOPyReLZnIDxhQWg9lGh1YlfyVBi3opEOKGwsI3rf2f4RVU9iN
         BUyw==
X-Forwarded-Encrypted: i=1; AJvYcCWvqO0oWu7TJor8PtZf8wyUnkeYH3LgpH0VLWl+oVf61YNKWTnk1wgFsWROH6fuVQrh5YeykLMgYKW5oVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5eCr7XGB2F78dT3rRiGj23SWcjMJ+rrPK4ZmMneiFS05B7nN7
	zd0b56MUDcseEyk6RU0QZwrw+gXQcLBHhpMDQBGn84TlOSTzBhnyYMA2
X-Gm-Gg: ASbGncsKRTOfI0UWDcMQ8mtZHbbOF5RHhwxS7zWpslZKqf4XIdOz7cZY1iHfvSffUfX
	ruxXtmZaOxo7z5WoaXRLveULiwQMRLYZvU2pOGM2pIcHHAp5IXh3VDFbAR+ynHleO3xcof6iqU2
	8uNft9gHgkKOAWpJG7G9AxxCQrAAt31gobtTlLl6CGtQG512ql6Dr5GWqdRdvOkK4COWr9ni+pN
	FcMhh/At99GXGrUll3Vt6f6DkyHZA+j0bO3taxqxsKW96skpkf0Um/ZBQYpNDHa70cGBBJl3hTv
	aadfLfZS6LP4mFsXGqq45LhWysBNHOkuy48fTAHEh1MoXL9/TgpcuswvXDH9AI2Bi8DeBVSKQsz
	5Q0b6WMSLSdP1xKqNOgq2Y8iEjgMbuvd56+LBaFfMQIR/FBkTmh53+v7WhbRRgMDJJ7bNpsfwAV
	bvvysoSDSrYfDi9V7C8f62Ex2P6TRm0yjvlPO15yTK3rDSdMLfjyPLGowC+4D5uME=
X-Google-Smtp-Source: AGHT+IGGX+e0auRKkNgRCpHofPZBmDCRUu/ZNBz9qUrUPtdZIEwSRDXKxeRRWzhaVI2evV9MhLLdHA==
X-Received: by 2002:a05:6a20:729c:b0:2da:f4be:c8c2 with SMTP id adf61e73a8af0-32b61dde689mr2200196637.31.1759465975599;
        Thu, 02 Oct 2025 21:32:55 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm6528233a91.23.2025.10.02.21.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:32:55 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 8/8] nvme-tcp: Allow userspace to trigger a KeyUpdate with debugfs
Date: Fri,  3 Oct 2025 14:31:39 +1000
Message-ID: <20251003043140.1341958-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003043140.1341958-1-alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Allow userspace to trigger a KeyUpdate via debugfs. This patch exposes a
key_update file that can be written to with the queue number to trigger
a KeyUpdate on that queue.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v3:
 - New patch

 drivers/nvme/host/tcp.c | 72 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4f27319f0078..8c6d18727e90 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -11,6 +11,7 @@
 #include <linux/crc32.h>
 #include <linux/nvme-tcp.h>
 #include <linux/nvme-keyring.h>
+#include <linux/debugfs.h>
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/tls.h>
@@ -1432,6 +1433,75 @@ static void update_tls_keys(struct nvme_tcp_queue *queue)
 	}
 }
 
+#ifdef CONFIG_NVME_TCP_TLS
+#define NVME_DEBUGFS_RW_ATTR(field) \
+	static int field##_open(struct inode *inode, struct file *file) \
+	{ return single_open(file, field##_show, inode->i_private); } \
+	\
+	static const struct file_operations field##_fops = { \
+		.open = field##_open, \
+		.read = seq_read, \
+		.write = field##_write, \
+		.release = single_release, \
+	}
+
+static int nvme_ctrl_key_update_show(struct seq_file *m, void *p)
+{
+	seq_printf(m, "0\n");
+
+	return 0;
+}
+
+static ssize_t nvme_ctrl_key_update_write(struct file *file, const char __user *buf,
+					  size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct nvme_ctrl *nctrl = m->private;
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	char kbuf[16] = {0};
+	int queue_nr, rc;
+	struct nvme_tcp_queue *queue;
+
+	if (count > sizeof(kbuf) - 1)
+		return -EINVAL;
+	if (copy_from_user(kbuf, buf, count))
+		return -EFAULT;
+	kbuf[count] = 0;
+
+	rc = kstrtouint(kbuf, 10, &queue_nr);
+	if (rc)
+		return rc;
+
+	if (queue_nr >= nctrl->queue_count)
+		return -EINVAL;
+
+	queue = &ctrl->queues[queue_nr];
+
+	update_tls_keys(queue);
+
+	return count;
+}
+NVME_DEBUGFS_RW_ATTR(nvme_ctrl_key_update);
+#endif
+
+static void nvme_tcp_debugfs_init(struct nvme_ctrl *ctrl,
+			    const char *dev_name)
+{
+	struct dentry *parent;
+
+	/* create debugfs directory and attribute */
+	parent = debugfs_create_dir(dev_name, NULL);
+	if (IS_ERR(parent)) {
+		pr_warn("%s: failed to create debugfs directory\n", dev_name);
+		return;
+	}
+
+#ifdef CONFIG_NVME_TCP_TLS
+	debugfs_create_file("key_update", S_IWUSR, parent, ctrl,
+			    &nvme_ctrl_key_update_fops);
+#endif
+}
+
 static void nvme_tcp_io_work(struct work_struct *w)
 {
 	struct nvme_tcp_queue *queue =
@@ -3065,6 +3135,8 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	list_add_tail(&ctrl->list, &nvme_tcp_ctrl_list);
 	mutex_unlock(&nvme_tcp_ctrl_mutex);
 
+	nvme_tcp_debugfs_init(&ctrl->ctrl, dev_name(dev));
+
 	return &ctrl->ctrl;
 
 out_uninit_ctrl:
-- 
2.51.0


