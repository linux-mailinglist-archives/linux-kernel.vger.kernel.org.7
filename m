Return-Path: <linux-kernel+bounces-598386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708BDA84593
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 16:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD788A2687
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 13:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9769528A3FA;
	Thu, 10 Apr 2025 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M66yZ762"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FF82857E0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744293589; cv=none; b=EoDzxw9MOYFWHtpgZW0FzQJx+UnrOh4YJn7lhmx6G8rs0DvkUrXXddyHX0AaK63NII1P2F45VQhzl0KlzfYD9JsGMond89vgpCqjZYT9RR/xGsjNVWqRbExxFcyVRh6snWB6ArUKH4e+9FKQt8G/WneMqAEDszlrUhSxJP9vKhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744293589; c=relaxed/simple;
	bh=dozxbqDyh0RTYArEIZ4nuZWXNjfO1WGiz7kCJLp4w7g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=en2haT1+0qq31vqHSId8QRHAec9QwbuD8z7JJUPoLmDHYeM1+r2XEQwQpNERnnkQwPTAVz85r+ccIZRonsNQGl0wPdahdIo+TpaYjHbDl07SgKOWMNzea9waxKl07NDDpBCECADjDztcoJlSNZ9etpf77NGKs70RoLQPBzSN68A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M66yZ762; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744293587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=6lXGy6iAiZmOgyrTQM3k7GoQsEWd4e16jb/q6ytdasg=;
	b=M66yZ762P3UPKEpAVtpHSNOzprxkoPmZL6dN7ogF9ajmgHpBhwnyLfVbXkvl/d1/FcM/Ij
	qO1xFJinjnAcpWUJaUC1MhI2segZtBSp2hcgtS0lkXINJTGNjFW1ydoFFgV3ljGOZKxZoE
	OAQNhn6Tzmi6id8AURaYg1fSuIB+3Wo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-2i51UBx4NjiTq2LJm2JYxw-1; Thu, 10 Apr 2025 09:59:44 -0400
X-MC-Unique: 2i51UBx4NjiTq2LJm2JYxw-1
X-Mimecast-MFC-AGG-ID: 2i51UBx4NjiTq2LJm2JYxw_1744293583
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-399744f742bso266188f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 06:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744293583; x=1744898383;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lXGy6iAiZmOgyrTQM3k7GoQsEWd4e16jb/q6ytdasg=;
        b=V796xuW3icJijtt2w4v1lMGSiOnerf0NQXQqQ5B75+FgHXgK/MZ3PJZzn110L7Giz9
         r7y/KxRXXlwu52nkq0vkMyvJj0V9cH2fwQubSDYovOtIo8IDBGSZTeNFl2+DbXNId10g
         n2WdNY8WhHGocWcxw3olsqgXZ4wWeth2iasJD89/5qyndWnsquS+KJ/6k1iQj4tIlDIM
         dgxE1gXvNsYsynDJxT6j2rOMPsmAHw4n1QEhEUo0HYxgqWTQWxFYOr5dpK52y+gH9tD3
         9FLZpKmSis6jq/ScFyWFGlbBDooSFeE2VlpriH/VjVMmb5yfBp5+KpdCY0SVwz6K0gjC
         j81g==
X-Gm-Message-State: AOJu0YyfUBNWZ5IYHRgPpMRyxC/Mkf/bfCbZghUkZVD4mVM225mqiZ9P
	XA4/02o5rxLYOXYkBlv1f7rxlQVj47WP5GsGT+wr+Je25wXt1COuKmXiE/p+X8YNHJ+pHsM45sJ
	l9AC+jYmsDEFUuOsCPMeiZauWyhddbqe7Z4/9yMB9iwPDrRcPIY5PssmHBQGyCGSHnWEvgUZjEG
	JIwWcJTBJ1ecyNC5vqaRoUeZb4opeiE1poFqo68Fo=
X-Gm-Gg: ASbGncthlKlz4iZq7tJfyivQBMWCItevHJtSi/JyZSgXnSFbrnWtvPZEUaUEGDW3mM4
	Kr7gwB61WZzGkJQTQ72YI2J7qFRRpPzHZ4w66Lh+GWgYcbYjlgfVZ9W452xK7ZHZFGU53WtVcY2
	CMhg5MNc3E8vVErkpxUzrsonbf3JCACclDMHusm2cz0BH1tknAzJTqLP6nvFoLuqr7dOytM81XK
	rkB5orG52wtai2Ma1Ie1b3w8EVdOH9EKuEU37sgNL3pKnXqOKlsXBcfUgjKAG2IzvlzC3wIXn5l
	FcOx0A==
X-Received: by 2002:a5d:64e7:0:b0:39c:30f9:339c with SMTP id ffacd0b85a97d-39d8f4733f5mr2497566f8f.28.1744293582797;
        Thu, 10 Apr 2025 06:59:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw+tyHh/388+fwunCYjGaGsvlhLWWOG8wscIdgu1ZoCVa9T/4VMl/VofRwJqpwdsBVtJzo3g==
X-Received: by 2002:a5d:64e7:0:b0:39c:30f9:339c with SMTP id ffacd0b85a97d-39d8f4733f5mr2497525f8f.28.1744293582179;
        Thu, 10 Apr 2025 06:59:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233a2a13sm52019325e9.10.2025.04.10.06.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 06:59:40 -0700 (PDT)
Date: Thu, 10 Apr 2025 09:59:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Eric Auger <eric.auger@redhat.com>, Eric Auger <eauger@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: [PATCH v2] virtgpu: don't reset on shutdown
Message-ID: <8490dbeb6f79ed039e6c11d121002618972538a3.1744293540.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

It looks like GPUs are used after shutdown is invoked.
Thus, breaking virtio gpu in the shutdown callback is not a good idea -
guest hangs attempting to finish console drawing, with this warnings:

[   20.504464] WARNING: CPU: 0 PID: 568 at drivers/gpu/drm/virtio/virtgpu_vq.c:358 virtio_gpu_queue_ctrl_sgs+0x236/0x290 [virtio_gpu]
[   20.505685] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink vfat fat intel_rapl_msr intel_rapl_common intel_uncore_frequency_common nfit libnvdimm kvm_intel kvm rapl iTCO_wdt iTCO_vendor_support virtio_gpu virtio_dma_buf pcspkr drm_shmem_helper i2c_i801 drm_kms_helper lpc_ich i2c_smbus virtio_balloon joydev drm fuse xfs libcrc32c ahci libahci crct10dif_pclmul crc32_pclmul crc32c_intel libata virtio_net ghash_clmulni_intel net_failover virtio_blk failover serio_raw dm_mirror dm_region_hash dm_log dm_mod
[   20.511847] CPU: 0 PID: 568 Comm: kworker/0:3 Kdump: loaded Tainted: G        W         -------  ---  5.14.0-578.6675_1757216455.el9.x86_64 #1
[   20.513157] Hardware name: Red Hat KVM/RHEL, BIOS edk2-20241117-3.el9 11/17/2024
[   20.513918] Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
[   20.514626] RIP: 0010:virtio_gpu_queue_ctrl_sgs+0x236/0x290 [virtio_gpu]
[   20.515332] Code: 00 00 48 85 c0 74 0c 48 8b 78 08 48 89 ee e8 51 50 00 00 65 ff 0d 42 e3 74 3f 0f 85 69 ff ff ff 0f 1f 44 00 00 e9 5f ff ff ff <0f> 0b e9 3f ff ff ff 48 83 3c 24 00 74 0e 49 8b 7f 40 48 85 ff 74
[   20.517272] RSP: 0018:ff34f0a8c0787ad8 EFLAGS: 00010282
[   20.517820] RAX: 00000000fffffffb RBX: 0000000000000000 RCX: 0000000000000820
[   20.518565] RDX: 0000000000000000 RSI: ff34f0a8c0787be0 RDI: ff218bef03a26300
[   20.519308] RBP: ff218bef03a26300 R08: 0000000000000001 R09: ff218bef07224360
[   20.520059] R10: 0000000000008dc0 R11: 0000000000000002 R12: ff218bef02630028
[   20.520806] R13: ff218bef0263fb48 R14: ff218bef00cb8000 R15: ff218bef07224360
[   20.521555] FS:  0000000000000000(0000) GS:ff218bef7ba00000(0000) knlGS:0000000000000000
[   20.522397] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.522996] CR2: 000055ac4f7871c0 CR3: 000000010b9f2002 CR4: 0000000000771ef0
[   20.523740] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   20.524477] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   20.525223] PKRU: 55555554
[   20.525515] Call Trace:
[   20.525777]  <TASK>
[   20.526003]  ? show_trace_log_lvl+0x1c4/0x2df
[   20.526464]  ? show_trace_log_lvl+0x1c4/0x2df
[   20.526925]  ? virtio_gpu_queue_fenced_ctrl_buffer+0x82/0x2c0 [virtio_gpu]
[   20.527643]  ? virtio_gpu_queue_ctrl_sgs+0x236/0x290 [virtio_gpu]
[   20.528282]  ? __warn+0x7e/0xd0
[   20.528621]  ? virtio_gpu_queue_ctrl_sgs+0x236/0x290 [virtio_gpu]
[   20.529256]  ? report_bug+0x100/0x140
[   20.529643]  ? handle_bug+0x3c/0x70
[   20.530010]  ? exc_invalid_op+0x14/0x70
[   20.530421]  ? asm_exc_invalid_op+0x16/0x20
[   20.530862]  ? virtio_gpu_queue_ctrl_sgs+0x236/0x290 [virtio_gpu]
[   20.531506]  ? virtio_gpu_queue_ctrl_sgs+0x174/0x290 [virtio_gpu]
[   20.532148]  virtio_gpu_queue_fenced_ctrl_buffer+0x82/0x2c0 [virtio_gpu]
[   20.532843]  virtio_gpu_primary_plane_update+0x3e2/0x460 [virtio_gpu]
[   20.533520]  drm_atomic_helper_commit_planes+0x108/0x320 [drm_kms_helper]
[   20.534233]  drm_atomic_helper_commit_tail+0x45/0x80 [drm_kms_helper]
[   20.534914]  commit_tail+0xd2/0x130 [drm_kms_helper]
[   20.535446]  drm_atomic_helper_commit+0x11b/0x140 [drm_kms_helper]
[   20.536097]  drm_atomic_commit+0xa4/0xe0 [drm]
[   20.536588]  ? __pfx___drm_printfn_info+0x10/0x10 [drm]
[   20.537162]  drm_atomic_helper_dirtyfb+0x192/0x270 [drm_kms_helper]
[   20.537823]  drm_fbdev_shmem_helper_fb_dirty+0x43/0xa0 [drm_shmem_helper]
[   20.538536]  drm_fb_helper_damage_work+0x87/0x160 [drm_kms_helper]
[   20.539188]  process_one_work+0x194/0x380
[   20.539612]  worker_thread+0x2fe/0x410
[   20.540007]  ? __pfx_worker_thread+0x10/0x10
[   20.540456]  kthread+0xdd/0x100
[   20.540791]  ? __pfx_kthread+0x10/0x10
[   20.541190]  ret_from_fork+0x29/0x50
[   20.541566]  </TASK>
[   20.541802] ---[ end trace 0000000000000000 ]---

It looks like the shutdown is called in the middle of console drawing, so
we should either wait for it to finish, or let drm handle the shutdown.

This patch implements this second option:

Add an option for drivers to bypass the common break+reset handling.
As DRM is careful to flush/synchronize outstanding buffers, it looks like
GPU can just have a NOP there.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Fixes: 8bd2fa086a04 ("virtio: break and reset virtio devices on device_shutdown()")
Cc: Eric Auger <eauger@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

changes from v1 RFC:
tested by Eric
fixed up commit log and comments as suggested by Jocelyn

 drivers/gpu/drm/virtio/virtgpu_drv.c | 9 +++++++++
 drivers/virtio/virtio.c              | 6 ++++++
 include/linux/virtio.h               | 3 +++
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 2d88e390feb4..e32e680c7197 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -128,6 +128,14 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
 	drm_dev_put(dev);
 }
 
+static void virtio_gpu_shutdown(struct virtio_device *vdev)
+{
+	/*
+	 * drm does its own synchronization on shutdown.
+	 * Do nothing here, opt out of device reset.
+	 */
+}
+
 static void virtio_gpu_config_changed(struct virtio_device *vdev)
 {
 	struct drm_device *dev = vdev->priv;
@@ -162,6 +170,7 @@ static struct virtio_driver virtio_gpu_driver = {
 	.id_table = id_table,
 	.probe = virtio_gpu_probe,
 	.remove = virtio_gpu_remove,
+	.shutdown = virtio_gpu_shutdown,
 	.config_changed = virtio_gpu_config_changed
 };
 
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 150753c3b578..95d5d7993e5b 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -407,6 +407,12 @@ static void virtio_dev_shutdown(struct device *_d)
 	if (!drv)
 		return;
 
+	/* If the driver has its own shutdown method, use that. */
+	if (drv->shutdown) {
+		drv->shutdown(dev);
+		return;
+	}
+
 	/*
 	 * Some devices get wedged if you kick them after they are
 	 * reset. Mark all vqs as broken to make sure we don't.
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 4d16c13d0df5..64cb4b04be7a 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -220,6 +220,8 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
  *    occurs.
  * @reset_done: optional function to call after transport specific reset
  *    operation has finished.
+ * @shutdown: synchronize with the device on shutdown. If provided, replaces
+ *    the virtio core implementation.
  */
 struct virtio_driver {
 	struct device_driver driver;
@@ -237,6 +239,7 @@ struct virtio_driver {
 	int (*restore)(struct virtio_device *dev);
 	int (*reset_prepare)(struct virtio_device *dev);
 	int (*reset_done)(struct virtio_device *dev);
+	void (*shutdown)(struct virtio_device *dev);
 };
 
 #define drv_to_virtio(__drv)	container_of_const(__drv, struct virtio_driver, driver)
-- 
MST


