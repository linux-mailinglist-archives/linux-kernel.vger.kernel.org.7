Return-Path: <linux-kernel+bounces-737984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A723DB0B2DF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 02:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5584F17EFE4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E143E41760;
	Sun, 20 Jul 2025 00:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnqOvKxU"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951481F92E
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752969732; cv=none; b=W961qj/YYnTZpnBnqz4adRpKGdPMg+eDFBABciHzwlJhUTk9ktTO/lzj3Zw88tTjeuU/38Autb2jiHl9GhV9KPCULzZF/UpPjhFWhnHg9qPT6LMzaJcDyFf0kgVjpNGPihlbVcQbDx9ISIwZMoieYpbRH8+78OcUaaDkjRpvlJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752969732; c=relaxed/simple;
	bh=kWH481rQxHSgO2aYYrKtU7VjD5qYBOXbDaNzIknywTY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdhxzHFV07yrYm1WpQqq9VxPq/Kg0K2eXbONCerDg7SlbaTkdpnJPyANC9UMeJh3e4U+yQKAFiK65juf0m+X0ASZAL3Vj+Y1A1AVWyidR2CbP3YWe1LXbcdzlQY+btFuuWcHsuX/RSYyMEwKpcwTAyR2dZgxAZP9gw0zS2Md2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnqOvKxU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23526264386so29388675ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 17:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752969730; x=1753574530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wRoDb+voU8lgHdTpaHOsovTOL2n5XlnH2FXsWKtkNow=;
        b=UnqOvKxU2Qom57Iqm6TtyEdW7/7fCCflecqydNkcNlAH3a6CVWr630Ol34oheDl549
         WpOATyXCF6FsLgfkKloofrxnGNjEIBdmOlABzEkfxVvIgxmRiD0Js+PsTsG4OuPKUyM/
         UTXnehp/lcmjY+hTKO/sPvaKmN63EBF2oqO14ZbVZOEbRl2zr5dAxYATJfH9Y22J79aS
         wYZfnaIqLxH0v8PiUmQ19l7y+WICtmluPWUg4qmpRSkVd4vcOeINB60w5PoRx2BSYfbG
         zBeF/LilbnJddkkBsh4xOBYOKj2Hb10cBC30UZRE4/IDQ8m3ya+06j++suD5Oa4idkht
         QElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752969730; x=1753574530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRoDb+voU8lgHdTpaHOsovTOL2n5XlnH2FXsWKtkNow=;
        b=DeWMA0Qo9KfwtRZZGmMPJG+R02EaO6ntfPSvvNgY6FnFimVUwmrv2FbRv5f+bT2432
         5f5fZsyRMc50T7wSSJO7upJKdxtr7xl9Ykbro8mxpkEqapVnYcXPKzneMsnYkgbRAZ0H
         bwLCniNCnRR2016RtfWIYkPo0emzMcMKtMgNZkecY5DqDEZlm769PX9w8hym4+LOZbg4
         C7QY37bsgwzcqODXfIqlYhDe7aXZHT464S+skPImAJQPkR8onDf3jtG1qjUi9fZKcxrm
         ld/Ztaciejaob0R8xWfiLQkMezhoM28nh51xVmo4Ejui9YY+wZWAm+F1ltcKvjvtNs6F
         Tijw==
X-Forwarded-Encrypted: i=1; AJvYcCVdnzNZ+X0f3MO8a7La6HmDLyCjVwrHa58Od4vjhufF3i0wfJj/KdbXW0+2g5asNvgF4qcx7FWDS8SVfsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz2m4RbNrqaOTVDcau+TIPWvVP7oADQRXo9rqxO7XRz7HGQ+mA
	EpXndUFseyL2HZr4fI5AhnyX4FfYwRTOCA/pqUTFatszgFM8y0TCR09u
X-Gm-Gg: ASbGncs+vJr7D6MpVsXxgwt//sp0mGkOw0+5aqH5W3sbBQoYmIx860AEHQYO82P557I
	jD4+n2ATFvrrZOBtz11bEOPZ5e3q7Nc9LqJaOSsovtU8LR8RpfgmlI7qd40uIMVnX4flDjOzLUC
	0QqbSKUPKlWMXHk6sHLm/Ny48jNBGDKl/Qvl5KVcXOf8yJDW+ZnwnleJTN4d9px889z3O7dT1kT
	raveOXFGBqpcayiS7W1shTGmCpQiZH6Q/Q3jIQ2uj7rlBLtRskRH7F7VCTQKcd1dsOPb3qml+ck
	1ImIic1m5C/IvNadRR6nDlfpXv0CSxNhvUr3rNZ1UXquydCWv5lhAuk/YsnuDn5P3dNdbjLfTOT
	5WfdjB8pxhdS84HWvT9O0rEe1fiWJNscFDUwRC5hUhgJK29V3swHeerrxyNmKBq4=
X-Google-Smtp-Source: AGHT+IHqeh5H+cwZXLynkz1KvJ7nhaok/k4EEbnFVlyCAAZG/xRcLSYxwJPT96memS9fpzyST0sY9g==
X-Received: by 2002:a17:902:e84f:b0:234:9094:3fb1 with SMTP id d9443c01a7336-23e25763da2mr244183835ad.35.1752969729849;
        Sat, 19 Jul 2025 17:02:09 -0700 (PDT)
Received: from localhost (111-252-5-201.dynamic-ip.hinet.net. [111.252.5.201])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23e3b6cfdb1sm34053625ad.139.2025.07.19.17.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 17:02:09 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 4/9] drm/panthor: capture CSG state for devcoredump
Date: Sat, 19 Jul 2025 17:01:41 -0700
Message-ID: <20250720000146.1405060-5-olvaffe@gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250720000146.1405060-1-olvaffe@gmail.com>
References: <20250720000146.1405060-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Capture interesting panthor_fw_csg_iface fields for devcoredump.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_coredump.c | 58 ++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_coredump.h | 23 +++++++++
 drivers/gpu/drm/panthor/panthor_sched.c    | 13 +++++
 3 files changed, 94 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_coredump.c b/drivers/gpu/drm/panthor/panthor_coredump.c
index 44d711e2f310..e08bd33b3554 100644
--- a/drivers/gpu/drm/panthor/panthor_coredump.c
+++ b/drivers/gpu/drm/panthor/panthor_coredump.c
@@ -24,6 +24,7 @@ enum panthor_coredump_mask {
 	PANTHOR_COREDUMP_GROUP = BIT(0),
 	PANTHOR_COREDUMP_GPU = BIT(1),
 	PANTHOR_COREDUMP_GLB = BIT(2),
+	PANTHOR_COREDUMP_CSG = BIT(3),
 };
 
 /**
@@ -53,6 +54,7 @@ struct panthor_coredump {
 	struct panthor_coredump_group_state group;
 	struct panthor_coredump_gpu_state gpu;
 	struct panthor_coredump_glb_state glb;
+	struct panthor_coredump_csg_state csg;
 
 	/* @data: Serialized coredump data. */
 	void *data;
@@ -85,6 +87,28 @@ static const char *reason_str(enum panthor_coredump_reason reason)
 	}
 }
 
+static void print_csg(struct drm_printer *p,
+		      const struct panthor_coredump_csg_state *csg, u32 csg_id)
+{
+	drm_printf(p, "csg%d:\n", csg_id);
+	drm_printf(p, "  GROUP_FEATURES: 0x%x\n", csg->features);
+	drm_printf(p, "  GROUP_STREAM_NUM: 0x%x\n", csg->stream_num);
+
+	drm_printf(p, "  CSG_REQ: 0x%x\n", csg->req);
+	drm_printf(p, "  CSG_ALLOW_COMPUTE: 0x%llx\n", csg->allow_compute);
+	drm_printf(p, "  CSG_ALLOW_FRAGMENT: 0x%llx\n", csg->allow_fragment);
+	drm_printf(p, "  CSG_ALLOW_OTHER: 0x%x\n", csg->allow_other);
+	drm_printf(p, "  CSG_EP_REQ: 0x%x\n", csg->ep_req);
+	drm_printf(p, "  CSG_CONFIG: 0x%x\n", csg->config);
+
+	drm_printf(p, "  CSG_ACK: 0x%x\n", csg->ack);
+	drm_printf(p, "  CSG_STATUS_EP_CURRENT: 0x%x\n",
+		   csg->status_ep_current);
+	drm_printf(p, "  CSG_STATUS_EP_REQ: 0x%x\n", csg->status_ep_req);
+	drm_printf(p, "  CSG_STATUS_STATE: 0x%x\n", csg->status_state);
+	drm_printf(p, "  CSG_RESOURCE_DEP: 0x%x\n", csg->resource_dep);
+}
+
 static void print_glb(struct drm_printer *p,
 		      const struct panthor_coredump_glb_state *glb)
 {
@@ -193,6 +217,10 @@ static void print_cd(struct drm_printer *p, const struct panthor_coredump *cd)
 
 	if (cd->mask & PANTHOR_COREDUMP_GLB)
 		print_glb(p, &cd->glb);
+
+	if (cd->mask & PANTHOR_COREDUMP_CSG) {
+		print_csg(p, &cd->csg, cd->group.csg_id);
+	}
 }
 
 static void process_cd(struct panthor_device *ptdev,
@@ -219,6 +247,29 @@ static void process_cd(struct panthor_device *ptdev,
 	print_cd(&p, cd);
 }
 
+static void capture_csg(struct panthor_device *ptdev,
+			struct panthor_coredump_csg_state *csg, u32 csg_id)
+{
+	const struct panthor_fw_csg_iface *csg_iface =
+		panthor_fw_get_csg_iface(ptdev, csg_id);
+
+	csg->features = csg_iface->control->features;
+	csg->stream_num = csg_iface->control->stream_num;
+
+	csg->req = csg_iface->input->req;
+	csg->allow_compute = csg_iface->input->allow_compute;
+	csg->allow_fragment = csg_iface->input->allow_fragment;
+	csg->allow_other = csg_iface->input->allow_other;
+	csg->ep_req = csg_iface->input->endpoint_req;
+	csg->config = csg_iface->input->config;
+
+	csg->ack = csg_iface->output->ack;
+	csg->status_ep_current = csg_iface->output->status_endpoint_current;
+	csg->status_ep_req = csg_iface->output->status_endpoint_req;
+	csg->status_state = csg_iface->output->status_state;
+	csg->resource_dep = csg_iface->output->resource_dep;
+}
+
 static void capture_glb(struct panthor_device *ptdev,
 			struct panthor_coredump_glb_state *glb)
 {
@@ -264,6 +315,13 @@ static void capture_cd(struct panthor_device *ptdev,
 
 	capture_glb(ptdev, &cd->glb);
 	cd->mask |= PANTHOR_COREDUMP_GLB;
+
+	/* remaining states require an active group */
+	if (!group || cd->group.csg_id < 0)
+		return;
+
+	capture_csg(ptdev, &cd->csg, cd->group.csg_id);
+	cd->mask |= PANTHOR_COREDUMP_CSG;
 }
 
 static void panthor_coredump_free(void *data)
diff --git a/drivers/gpu/drm/panthor/panthor_coredump.h b/drivers/gpu/drm/panthor/panthor_coredump.h
index e578298e9b57..d965ebc545d3 100644
--- a/drivers/gpu/drm/panthor/panthor_coredump.h
+++ b/drivers/gpu/drm/panthor/panthor_coredump.h
@@ -69,6 +69,29 @@ struct panthor_coredump_glb_state {
 	u32 ack;
 };
 
+/**
+ * struct panthor_coredump_csg_state - Coredump CSG state
+ *
+ * Interesting panthor_fw_csg_iface fields.
+ */
+struct panthor_coredump_csg_state {
+	u32 features;
+	u32 stream_num;
+
+	u32 req;
+	u64 allow_compute;
+	u64 allow_fragment;
+	u32 allow_other;
+	u32 ep_req;
+	u32 config;
+
+	u32 ack;
+	u32 status_ep_current;
+	u32 status_ep_req;
+	u32 status_state;
+	u32 resource_dep;
+};
+
 #ifdef CONFIG_DEV_COREDUMP
 
 struct panthor_coredump *
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index a9fd71fa984b..504fc097ebfe 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3681,6 +3681,19 @@ static void panthor_sched_coredump_locked(struct panthor_device *ptdev,
 
 	pm_active = pm_runtime_get_if_active(ptdev->base.dev);
 
+	/* force a CSG_STATUS_UPDATE */
+	if (pm_active && group && group->csg_id >= 0) {
+		struct panthor_fw_csg_iface *csg_iface;
+		u32 acked;
+
+		csg_iface = panthor_fw_get_csg_iface(ptdev, group->csg_id);
+
+		panthor_fw_toggle_reqs(csg_iface, req, ack, CSG_STATUS_UPDATE);
+		panthor_fw_ring_csg_doorbells(ptdev, BIT(group->csg_id));
+		panthor_fw_csg_wait_acks(ptdev, group->csg_id,
+					 CSG_STATUS_UPDATE, &acked, 100);
+	}
+
 	panthor_coredump_capture(cd, group);
 
 	if (pm_active == 1)
-- 
2.50.0.727.gbf7dc18ff4-goog


