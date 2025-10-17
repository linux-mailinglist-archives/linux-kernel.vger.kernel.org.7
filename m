Return-Path: <linux-kernel+bounces-857242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F5DBE64DB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C64F19C885B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1858D3112D8;
	Fri, 17 Oct 2025 04:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBOoQ82Q"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57599310764
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760675052; cv=none; b=BnMxDiZPsLw/dG2+wci7ze3eWHh3YuGq6WcUHvyDgCl03eyRx+rBM0K1rBpy2fwSk79RgRsv3uA0Z83C/1gwNpfodvF2rRWvfzVyBj1VMtnqBy0/UfvTfcJvlf0KOk5YEqB8gm4o6mG+U46Gp/0BrFAoR9e7Ti9Bx3xF24WJO8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760675052; c=relaxed/simple;
	bh=5mK2M0hVJGfdiN3VSfq9BCNgQdVTn70R+CbJkNedk+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hb0BB5g6WNT5ZQuZQMy61EUAX0yBzHMJIglOuUlRtcI8aPgZuD/blD4xQZfsTfUEAif0JkuY9vQpG2jfrKd6xM1IuR9KAD/aj1VUMMWSo/U0qFmwQzGKXsUY9FUoOfMICXAQ53ZQLjA3JPIMWuEPvbXk5e8ZGvsad8Qu4mcZDZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBOoQ82Q; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b67ae7e76abso1119507a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760675049; x=1761279849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29Lq2xnZtj+6Sy2WBmqrd6RHyzvurjh80XYGtTuJrGI=;
        b=WBOoQ82Q4+Y7rN+a2ZN8npcIO/l+yLJQ6aVHATOYgZu5YaeOwiL6j/PCDF7dImrvk/
         Tg5mzfp4pKJHgdCC1qGeds/l87hbTpDZomv+lxCB91j50UiWagLFmrXtPhLokPiBAHG0
         deTiBVSOVrJEeL+eFGMV9w6rEgAOvnDR1u+XB+54Dq7XJ5e21RybUfVgQHqZRINX6X18
         56FxyIjftAjfsQulyPGrnCTdtWP1u5rCwo3dlidDUWwVDCN0FNpaDDzcN9ze5pXKuvEa
         s2bE07HQo+uC6rljxA/y+loGfAP9Z5/d4yd/lXTnK4RJ5FMyD6zayucReRLQwyWSq2xP
         X5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760675049; x=1761279849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29Lq2xnZtj+6Sy2WBmqrd6RHyzvurjh80XYGtTuJrGI=;
        b=ckNHKf59yMXhz6Yl0AiD9IGaElaQnW4ujRKwKjFTHe7eI+s50t28hsTuLKZIgHzLxr
         ghZD8oByltT5HmmPKAGkzmNSCzc/o2QTeG4MBw3UpC4BvnnrLgPHmouXhJQmdqaInxjM
         4Agek7q1OhHFo4OFjvy5QY2tO5TPFa8IUNwhs4ZkBBmnRq+hg56Q92JqCEG/L9hZINf9
         zXldlJHQRocQCoFOQPDkEUTfkBLzxcnpMB9TOS2et6SrNYaanU/A1PusV6zS3Q3EDhRD
         4tbriYsvumAFfnX0+CbjlKVq9KZhA1tvl0a3M6P6VWijERKXkdTQjHkrYTL/RJZGTr+x
         7CPA==
X-Forwarded-Encrypted: i=1; AJvYcCWcLCmte+FynDr33KOnWszZT9DsC7PWyNndzJQTV2QZidwxJcG/qVS6g4qyIYjL/Thq3L8AiqH3hMnIYPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPT1mQ6VgG5C9aZxwS27zNRtxbJhqr9VCqNMNNvIRCAwdNg1CC
	1ZsDfNIHJwyRouADEnx1F27nFwBt2SRx/TQ4TU+YlJxL8sZsfStRmlxr
X-Gm-Gg: ASbGncvqjDc6AZtDATKYsTdnjlxf6NsPD2z+bBCeXbugfHWVAKC3Fa+lV42JtAmVxSA
	yBfxk9QzcHRGYVsKugBM54dzk+CTM12R3K5AXjaoIs5pjWkMpWpGY5kgZ6W6vrE21hwV6e8gqyq
	WZiMtFYU4IR1soaQAfA/QHf3UMGiDrFLvrmv+q2iIAHWCkg1mw2DpMEXEQ3X7dxWdENr3K/GE2i
	8X3JZsHygT6ZJDptJcCrmLBFK7dfn/7R4LwF9p/Qego30dyJ3jE+qFtmzTnTUzI1tXatHQXeeEY
	hjfvpvJmg/OXd7gsWumDEOVNX0ZBgWdJ76OlzbS2vJNQqUabjuMjyDVSHkPqFXN0I6Ul1+95iwn
	l1pad2x/G4WAGhiVqaECEXR7s7qeusmmja9sCfCGBiFJEwKJseItvXRWrHmDoro5EbSxtKD/gQO
	ipX6MkfejZZcfgqhVYi8DtrNxIpWTLicWz4L6N/YSa+ZoKy24lNCuL22KhhT2vGLx67UvwX7btq
	x08OkStgg7UqSVJ2jaM
X-Google-Smtp-Source: AGHT+IE3Loe/21tReTiMC1KE1PN6nnxQShPQ2aeX3VGqy1tfwwjN0OSJDK1WmyW+Y1kgS8QPEPO/LQ==
X-Received: by 2002:a17:903:1250:b0:290:dd1f:3d60 with SMTP id d9443c01a7336-290dd1f3fc8mr6269945ad.51.1760675048710;
        Thu, 16 Oct 2025 21:24:08 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33be54cad3esm245557a91.12.2025.10.16.21.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:24:08 -0700 (PDT)
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
Subject: [PATCH v4 6/7] nvme-tcp: Allow userspace to trigger a KeyUpdate with debugfs
Date: Fri, 17 Oct 2025 14:23:11 +1000
Message-ID: <20251017042312.1271322-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017042312.1271322-1-alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
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
v4:
 - No change
v3:
 - New patch

 drivers/nvme/host/tcp.c | 72 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 791e0cc91ad8..f5c7b646d002 100644
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
@@ -1429,6 +1430,75 @@ static void update_tls_keys(struct nvme_tcp_queue *queue)
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


