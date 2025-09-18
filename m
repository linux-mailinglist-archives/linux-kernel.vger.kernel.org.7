Return-Path: <linux-kernel+bounces-792027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E64B3BFA2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4E67C10FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDDF335BB0;
	Fri, 29 Aug 2025 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+UpTaAG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5003375A3
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481855; cv=none; b=R4s5v/NzXEWHaP2r/nZLW3DCR+CHNFJk8hC2Zoo0KdA1lKHD+AKNwEnXfVcdpDZ872myBA6OC9wpyc8VctIkl05r+EWqCe8IxycnKycPHi4KXhiyGdyvk48s1F0ZBiIDvDbI0C2lu4laR+fAtQV+eGPjA1ppdGoRxCY7lThZTRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481855; c=relaxed/simple;
	bh=vw+qLjiyh+G0bkQwHR3d6Hwy+8ZKwQcQXIo7MovUDik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qwwK6f4pmNAX+bA52xdpap4m7usmeAmbJ6M8jnaveZ/GVwXsy55bWY3zjDgDI25N5lMpJKGnObnPCEGKzHKx0LQ1KjOHC+96CJRML++/BlVS7FvOkrn5n7kd7zn0vPeIFrmPf3h6jAUbot3lWFWIsfC8iiWXb7JdbRAVv7tz/ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+UpTaAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3B8C4CEFC;
	Fri, 29 Aug 2025 15:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756481854;
	bh=vw+qLjiyh+G0bkQwHR3d6Hwy+8ZKwQcQXIo7MovUDik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F+UpTaAGtIvtTZDVCVBcZ2Z2+U5j1HXxRHhgm8uqq7c7LQgbGhdbKIzJGuSCAClfQ
	 ToEIL30cXyjSFad0JeHN1coDVYAAHuRuKZKuOuNIxj8aQN90Yyn0ANGojJ2DZz9gP8
	 vvQ2UmHI/sOMUnJhfLMrNBVKTvjIUakEENhIYrDBGDxXBv75MxkImOq0UdOHDYsn0z
	 PDbPfnpoEQPWk6334vWBWKRlFwJmTiEN9zOtdikEtkpyle9Q4SY+ddL+iq4zOJKNmz
	 IKKLvuC5tJq2QxKPGHYZChApIYWW8G67kOXc4VkB2idobpwAOy+unQjEzlQT3Cg66S
	 QbDc7ELGmOHmQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 29 Aug 2025 17:37:25 +0200
Subject: [PATCH v3 1/4] nvme-fabrics: introduce ref-counting for
 nvmf_ctrl_options
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-nvme-fc-sync-v3-1-d69c87e63aee@kernel.org>
References: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
In-Reply-To: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

nvmf_create_ctrl allocates the options object and frees it when the
create_ctrl function fails. TCP and RDMA are doing the initial connect
synchronous, while the FC transport offloads the connect attempt to a
workqueue. Thus, nvme_fc_init_ctrl has to take owner ship in the error
case to avoid double free.

But there are several places in the nvme core code which want to access
the options pointer in the cleanup path and this is racing with the FC
reconnect or delete state machine. E.g

  nvme_ctrl_free
    nvme_auth_free
      ctrl_max_dhchaps
        ctrl->opts->dhchaps

  nvme_do_delete_ctrl
    nvmf_ctrl_subsysnqn
      ctrl->opts->subsysnqn

There are also a few workaround in the existing code to avoid
de-referencing a NULL pointer:

  nvme_class_uevent
    if (opts) {
       add_uevent_var(env, "NVME_TRADDR");
       add_uevent_var(env, "NVME_TRSVID");
       add_uevent_var(env, "NVME_HOST_TRADDR");
       add_uevent_var(env, "NVME_HOST_IFACE");
    }

Furthermore, user space is able to trigger a crash because
nvmf_ctrl_options are exposed to sysfs and expects ctrl->opts to be
valid always:

  nvme_sysfs_show_hostnqn
    ctrl->opts->host->nqn

  nvme_sysfs_show_hostid
    ctrl->opts->host->id

By introducing ref-counting for the options, it decouples the options
lifetime from the controller objects, which avoids all the races
mentioned above.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fabrics.c | 22 +++++++++++++++++++---
 drivers/nvme/host/fabrics.h |  6 +++++-
 drivers/nvme/host/fc.c      | 14 +++++++++-----
 drivers/nvme/host/rdma.c    | 18 +++++++++++++-----
 drivers/nvme/host/tcp.c     | 21 ++++++++++++++-------
 drivers/nvme/target/loop.c  | 19 +++++++++++++------
 6 files changed, 73 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 2e58a7ce109052ecdda433f13162911459a81fb3..cb9311c399856de54a2e4d41d41d295dd1aef31e 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1279,8 +1279,11 @@ static int nvmf_check_allowed_opts(struct nvmf_ctrl_options *opts,
 	return 0;
 }
 
-void nvmf_free_options(struct nvmf_ctrl_options *opts)
+static void nvmf_free_options(struct kref *ref)
 {
+	struct nvmf_ctrl_options *opts =
+		container_of(ref, struct nvmf_ctrl_options, ref);
+
 	nvmf_host_put(opts->host);
 	key_put(opts->keyring);
 	key_put(opts->tls_key);
@@ -1294,7 +1297,18 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 	kfree(opts->dhchap_ctrl_secret);
 	kfree(opts);
 }
-EXPORT_SYMBOL_GPL(nvmf_free_options);
+
+int nvmf_ctrl_options_get(struct nvmf_ctrl_options *opts)
+{
+	return kref_get_unless_zero(&opts->ref);
+}
+EXPORT_SYMBOL_GPL(nvmf_ctrl_options_get);
+
+void nvmf_ctrl_options_put(struct nvmf_ctrl_options *opts)
+{
+	kref_put(&opts->ref, nvmf_free_options);
+}
+EXPORT_SYMBOL_GPL(nvmf_ctrl_options_put);
 
 #define NVMF_REQUIRED_OPTS	(NVMF_OPT_TRANSPORT | NVMF_OPT_NQN)
 #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
@@ -1316,6 +1330,8 @@ nvmf_create_ctrl(struct device *dev, const char *buf)
 	if (!opts)
 		return ERR_PTR(-ENOMEM);
 
+	kref_init(&opts->ref);
+
 	ret = nvmf_parse_options(opts, buf);
 	if (ret)
 		goto out_free_opts;
@@ -1371,7 +1387,7 @@ nvmf_create_ctrl(struct device *dev, const char *buf)
 out_unlock:
 	up_read(&nvmf_transports_rwsem);
 out_free_opts:
-	nvmf_free_options(opts);
+	nvmf_ctrl_options_put(opts);
 	return ERR_PTR(ret);
 }
 
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 1b58ee7d0dcee420a1cf7d1a4b8e7e558b69ecae..bcc1d5f97ee5a03852830bf3ba0a15f82c7c2c03 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -72,6 +72,7 @@ enum {
 /**
  * struct nvmf_ctrl_options - Used to hold the options specified
  *			      with the parsing opts enum.
+ * @ref:	for reference count of the data structure
  * @mask:	Used by the fabrics library to parse through sysfs options
  *		on adding a NVMe controller.
  * @max_reconnects: maximum number of allowed reconnect attempts before removing
@@ -112,6 +113,7 @@ enum {
  * @fast_io_fail_tmo: Fast I/O fail timeout in seconds
  */
 struct nvmf_ctrl_options {
+	struct kref		ref;
 	unsigned		mask;
 	int			max_reconnects;
 	char			*transport;
@@ -142,6 +144,9 @@ struct nvmf_ctrl_options {
 	int			fast_io_fail_tmo;
 };
 
+int nvmf_ctrl_options_get(struct nvmf_ctrl_options *opts);
+void nvmf_ctrl_options_put(struct nvmf_ctrl_options *opts);
+
 /*
  * struct nvmf_transport_ops - used to register a specific
  *			       fabric implementation of NVMe fabrics.
@@ -225,7 +230,6 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl);
 int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid);
 int nvmf_register_transport(struct nvmf_transport_ops *ops);
 void nvmf_unregister_transport(struct nvmf_transport_ops *ops);
-void nvmf_free_options(struct nvmf_ctrl_options *opts);
 int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl, int status);
 bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3e12d4683ac72f9ef9c6dff64d22d5d97e6f3d60..db5dbbf6aee21db45e91ea6f0c122681b9bdaf6f 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2372,8 +2372,7 @@ nvme_fc_ctrl_free(struct kref *ref)
 	nvme_fc_rport_put(ctrl->rport);
 
 	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
-	if (ctrl->ctrl.opts)
-		nvmf_free_options(ctrl->ctrl.opts);
+	nvmf_ctrl_options_put(ctrl->ctrl.opts);
 	kfree(ctrl);
 }
 
@@ -3437,10 +3436,15 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 		goto out_fail;
 	}
 
+	if (!nvmf_ctrl_options_get(opts)) {
+		ret = -ENOLCK;
+		goto out_free_ctrl;
+	}
+
 	idx = ida_alloc(&nvme_fc_ctrl_cnt, GFP_KERNEL);
 	if (idx < 0) {
 		ret = -ENOSPC;
-		goto out_free_ctrl;
+		goto out_free_opts;
 	}
 
 	/*
@@ -3512,6 +3516,8 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 out_free_ida:
 	put_device(ctrl->dev);
 	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
+out_free_opts:
+	nvmf_ctrl_options_put(opts);
 out_free_ctrl:
 	kfree(ctrl);
 out_fail:
@@ -3573,8 +3579,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	cancel_work_sync(&ctrl->ctrl.reset_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 
-	ctrl->ctrl.opts = NULL;
-
 	/* initiate nvme ctrl ref counting teardown */
 	nvme_uninit_ctrl(&ctrl->ctrl);
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 190a4cfa8a5ee2e6b97a5a1b304c1338dcd748fa..f0692f1132aaef2f8f8c30e9d7824e4bf1f91117 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -976,8 +976,8 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 	list_del(&ctrl->list);
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
-	nvmf_free_options(nctrl->opts);
 free_ctrl:
+	nvmf_ctrl_options_put(nctrl->opts);
 	kfree(ctrl->queues);
 	kfree(ctrl);
 }
@@ -2242,6 +2242,12 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
+
+	if (!nvmf_ctrl_options_get(opts)) {
+		ret = -ENODEV;
+		goto out_free_ctrl;
+	}
+
 	ctrl->ctrl.opts = opts;
 	INIT_LIST_HEAD(&ctrl->list);
 
@@ -2250,7 +2256,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 			kstrdup(__stringify(NVME_RDMA_IP_PORT), GFP_KERNEL);
 		if (!opts->trsvcid) {
 			ret = -ENOMEM;
-			goto out_free_ctrl;
+			goto out_free_opts;
 		}
 		opts->mask |= NVMF_OPT_TRSVCID;
 	}
@@ -2269,13 +2275,13 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 		if (ret) {
 			pr_err("malformed src address passed: %s\n",
 			       opts->host_traddr);
-			goto out_free_ctrl;
+			goto out_free_opts;
 		}
 	}
 
 	if (!opts->duplicate_connect && nvme_rdma_existing_controller(opts)) {
 		ret = -EALREADY;
-		goto out_free_ctrl;
+		goto out_free_opts;
 	}
 
 	INIT_DELAYED_WORK(&ctrl->reconnect_work,
@@ -2292,7 +2298,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 	ctrl->queues = kcalloc(ctrl->ctrl.queue_count, sizeof(*ctrl->queues),
 				GFP_KERNEL);
 	if (!ctrl->queues)
-		goto out_free_ctrl;
+		goto out_free_opts;
 
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
 				0 /* no quirks, we're perfect! */);
@@ -2303,6 +2309,8 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 
 out_kfree_queues:
 	kfree(ctrl->queues);
+out_free_opts:
+	nvmf_ctrl_options_put(opts);
 out_free_ctrl:
 	kfree(ctrl);
 	return ERR_PTR(ret);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c0fe8cfb7229e16af41286f5edb01586ad617291..df445b4da39ef134c605ca7ef1ccbeda99a23862 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2554,8 +2554,8 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 	list_del(&ctrl->list);
 	mutex_unlock(&nvme_tcp_ctrl_mutex);
 
-	nvmf_free_options(nctrl->opts);
 free_ctrl:
+	nvmf_ctrl_options_put(nctrl->opts);
 	kfree(ctrl->queues);
 	kfree(ctrl);
 }
@@ -2888,6 +2888,11 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
 
+	if (!nvmf_ctrl_options_get(opts)) {
+		ret = -ENODEV;
+		goto out_free_ctrl;
+	}
+
 	INIT_LIST_HEAD(&ctrl->list);
 	ctrl->ctrl.opts = opts;
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
@@ -2905,7 +2910,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 			kstrdup(__stringify(NVME_TCP_DISC_PORT), GFP_KERNEL);
 		if (!opts->trsvcid) {
 			ret = -ENOMEM;
-			goto out_free_ctrl;
+			goto out_free_opts;
 		}
 		opts->mask |= NVMF_OPT_TRSVCID;
 	}
@@ -2915,7 +2920,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	if (ret) {
 		pr_err("malformed address passed: %s:%s\n",
 			opts->traddr, opts->trsvcid);
-		goto out_free_ctrl;
+		goto out_free_opts;
 	}
 
 	if (opts->mask & NVMF_OPT_HOST_TRADDR) {
@@ -2924,7 +2929,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		if (ret) {
 			pr_err("malformed src address passed: %s\n",
 			       opts->host_traddr);
-			goto out_free_ctrl;
+			goto out_free_opts;
 		}
 	}
 
@@ -2933,20 +2938,20 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 			pr_err("invalid interface passed: %s\n",
 			       opts->host_iface);
 			ret = -ENODEV;
-			goto out_free_ctrl;
+			goto out_free_opts;
 		}
 	}
 
 	if (!opts->duplicate_connect && nvme_tcp_existing_controller(opts)) {
 		ret = -EALREADY;
-		goto out_free_ctrl;
+		goto out_free_opts;
 	}
 
 	ctrl->queues = kcalloc(ctrl->ctrl.queue_count, sizeof(*ctrl->queues),
 				GFP_KERNEL);
 	if (!ctrl->queues) {
 		ret = -ENOMEM;
-		goto out_free_ctrl;
+		goto out_free_opts;
 	}
 
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_tcp_ctrl_ops, 0);
@@ -2956,6 +2961,8 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	return ctrl;
 out_kfree_queues:
 	kfree(ctrl->queues);
+out_free_opts:
+	nvmf_ctrl_options_put(opts);
 out_free_ctrl:
 	kfree(ctrl);
 	return ERR_PTR(ret);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index f85a8441bcc6ecdcfb17e9cf1e883d2817cce9fc..22039535ff9d3c8b2b42ecaa843b947446a8ba99 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -291,8 +291,8 @@ static void nvme_loop_free_ctrl(struct nvme_ctrl *nctrl)
 	if (nctrl->tagset)
 		nvme_remove_io_tag_set(nctrl);
 	kfree(ctrl->queues);
-	nvmf_free_options(nctrl->opts);
 free_ctrl:
+	nvmf_ctrl_options_put(nctrl->opts);
 	kfree(ctrl);
 }
 
@@ -567,6 +567,12 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
+
+	if (!nvmf_ctrl_options_get(opts)) {
+		ret = -ENOLCK;
+		goto out_free_ctrl;
+	}
+
 	ctrl->ctrl.opts = opts;
 	INIT_LIST_HEAD(&ctrl->list);
 
@@ -574,10 +580,8 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_loop_ctrl_ops,
 				0 /* no quirks, we're perfect! */);
-	if (ret) {
-		kfree(ctrl);
-		goto out;
-	}
+	if (ret)
+		goto out_free_opts;
 
 	ret = nvme_add_ctrl(&ctrl->ctrl);
 	if (ret)
@@ -641,7 +645,10 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	nvme_uninit_ctrl(&ctrl->ctrl);
 out_put_ctrl:
 	nvme_put_ctrl(&ctrl->ctrl);
-out:
+out_free_opts:
+	nvmf_ctrl_options_put(opts);
+out_free_ctrl:
+	kfree(ctrl);
 	if (ret > 0)
 		ret = -EIO;
 	return ERR_PTR(ret);

-- 
2.51.0


