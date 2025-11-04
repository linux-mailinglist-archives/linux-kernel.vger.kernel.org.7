Return-Path: <linux-kernel+bounces-883880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6324AC2EA66
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 01:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F8FF4F7A72
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 00:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6E021FF5F;
	Tue,  4 Nov 2025 00:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CTi2qOrE"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102471DDA1E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 00:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762216551; cv=none; b=sC5pd8vgsP3gYAfBpzXJjYRmogDn7GYRIf1p25rGnnI9HSh08iFxsH88OUVHTajHLECoYPZLap0N+gHMxwU4/E0VVQs/2+SDBmKbyRA9XKTU/GGt94dFsZH2CjyDbMhC8r03rZ2cIpEUasg7pIRA75/6OmXQOeYsbYkB3hbyHEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762216551; c=relaxed/simple;
	bh=KAYtgiZUPPe8NgBwTLsXuDceoGVjrVYIcn380wldP9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Izw7Minx6tUaJ+UeUHRs7Dagb22477VXlFXZC50W3Z88ykVUSCKlva327cHiXrKM6yqPvioKYFCE1K0LGxGpV3LA2tQjcUyLNAs3Rxk6fC42zU3cVSea0u/NzxjhF3PHO6bEJPG/KuWO7v2tcqx0myHiFZHTfxsB3EBXJGry9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CTi2qOrE; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-9434f5350bcso471126239f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 16:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762216548; x=1762821348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uz2s7/ofcFQ58Iof/0T9cnbQM/oQ0V7gekj1ChH2tmU=;
        b=CTi2qOrEqs1xuiC++F9oNiJMV6t6qK3DCyRvTXChJs8xjpx84TmERiukn9DDwU0ySz
         EXtzEJxvYXsMpz7eAf4uohq017posRO8xruaXaxm4y+/UJQD3YI7VEv7n938HLOhwBFA
         /0UK1ci94B2GE3RTd7uUq0QSGe4D8remQloHWFd+blCxaPNeWI1qB1v1HrRGL2wAVzm/
         Zy+p9EwvoDATPUPMx5itVpgap3DLhs4eRJ8IgTyzoOKQGlgZoIiNHKH3+iDjb262wAs3
         aXq7bVIsLgU31PBYw6DAf1gkfzCJoX3y1Lbd6kJRq0RZegc6O0VTd2+PItGMAsut6GUz
         1fuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762216548; x=1762821348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uz2s7/ofcFQ58Iof/0T9cnbQM/oQ0V7gekj1ChH2tmU=;
        b=JljfsT685pxrJXOLXftkNO67tUICHpm3VlRtPEwH6SliS/w5PfebBDhjuhnlGTeFvz
         HPjvx1JuVd8vBu7QD9GFVWUfFmF7UeP8oEL1hkkuK3R2nGRwq3npBzPUcsnXrVA828/A
         t915Q7ATsg0b+oCsEmKyS2gpFM3uAd3DtakHNfQ7tks2FllIsbOpGZ3lilybzgOBuRuK
         jfKUtQNysZMeekpJ3vYhl1wXuD7ZacipUnUPkId/0C1Ee6eUiiTgqe94t+wk4WukdJdV
         IcDeakmslVp+A+PRrqyzjbtXDG8Jk1+6SAFBMZhZMd5AeWQwZ4J4LHMqnlqYFZi0GvIu
         6FyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl8U/GhdD8S58TiyWf0TVFVn4Jf9SC2+bakxROHbN+C/KT0cWZDtxvX+AMtGTRJy4IgFksHm8jGdPx7V8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhkhu+3tuHu8aQKiy0oaRgyCJRVQ7KUsvr7NTz40PMFQqSSJ47
	YQAfyV1PodEpq3cGIPHbjVEp9lw88KImDDR4cIlYxSqTexB348NxrSRCjDvkfiODtTlX5pHZCOT
	Cv2cp+C/rvw==
X-Google-Smtp-Source: AGHT+IE3X+JlUJOrqF/mQ51/z0lnEJZo1YGLEu85f7ePFvLk1PPKgO61x2/eG90E812CeeUeOXM5OOkY+5NT
X-Received: from iobee3.prod.google.com ([2002:a05:6602:4883:b0:945:a89b:a5a])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a5e:db0b:0:b0:945:a04c:d94e
 with SMTP id ca18e2360f4ac-94859449e5emr191010739f.5.1762216548345; Mon, 03
 Nov 2025 16:35:48 -0800 (PST)
Date: Tue,  4 Nov 2025 00:35:34 +0000
In-Reply-To: <20251104003536.3601931-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251104003536.3601931-1-rananta@google.com>
X-Mailer: git-send-email 2.51.2.997.g839fc31de9-goog
Message-ID: <20251104003536.3601931-3-rananta@google.com>
Subject: [PATCH 2/4] vfio: selftests: Export vfio_pci_device functions
From: Raghavendra Rao Ananta <rananta@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, 
	Alex Williamson <alex.williamson@redhat.com>
Cc: Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"

Refactor and make the functions called under device initialization
public. A later patch adds a test that calls these functions to validate
the UAPI of SR-IOV devices. Opportunistically, to test the success
and failure cases of the UAPI, split the functions dealing with
VFIO_GROUP_GET_DEVICE_FD and VFIO_DEVICE_BIND_IOMMUFD into a core
function and another one that asserts the ioctl. The former will be
used for testing the SR-IOV UAPI, hence only export these.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    | 13 ++++
 .../selftests/vfio/lib/vfio_pci_device.c      | 75 +++++++++++++------
 2 files changed, 67 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index b01068d98fdab..2baf12a888e67 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -294,4 +294,17 @@ void vfio_pci_driver_memcpy_start(struct vfio_pci_device *device,
 int vfio_pci_driver_memcpy_wait(struct vfio_pci_device *device);
 void vfio_pci_driver_send_msi(struct vfio_pci_device *device);
 
+const char *iommu_mode_container_path(const char *iommu_mode);
+const struct vfio_iommu_mode *lookup_iommu_mode(const char *iommu_mode);
+
+void vfio_container_open(struct vfio_pci_device *device);
+void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf);
+void vfio_container_set_iommu(struct vfio_pci_device *device);
+void __vfio_container_get_device_fd(struct vfio_pci_device *device,
+				    const char *bdf, const char *vf_token);
+
+void vfio_pci_iommufd_cdev_open(struct vfio_pci_device *device, const char *bdf);
+void vfio_pci_iommufd_iommudev_open(struct vfio_pci_device *device);
+int __vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token);
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H */
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 3f7be8d371d06..7a1547e365870 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -311,7 +311,7 @@ static unsigned int vfio_pci_get_group_from_dev(const char *bdf)
 	return group;
 }
 
-static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf)
+void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf)
 {
 	struct vfio_group_status group_status = {
 		.argsz = sizeof(group_status),
@@ -331,9 +331,8 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
 	ioctl_assert(device->group_fd, VFIO_GROUP_SET_CONTAINER, &device->container_fd);
 }
 
-static void vfio_pci_container_get_device_fd(struct vfio_pci_device *device,
-					      const char *bdf,
-					      const char *vf_token)
+void __vfio_container_get_device_fd(struct vfio_pci_device *device,
+				     const char *bdf, const char *vf_token)
 {
 	char *arg = (char *) bdf;
 
@@ -356,32 +355,46 @@ static void vfio_pci_container_get_device_fd(struct vfio_pci_device *device,
 
 	if (vf_token)
 		free((void *) arg);
+}
 
+static void vfio_container_get_device_fd(struct vfio_pci_device *device,
+					  const char *bdf,
+					  const char *vf_token)
+{
+	__vfio_container_get_device_fd(device, bdf, vf_token);
 	VFIO_ASSERT_GE(device->fd, 0);
 }
 
-static void vfio_pci_container_setup(struct vfio_pci_device *device,
-				      const char *bdf, const char *vf_token)
+void vfio_container_set_iommu(struct vfio_pci_device *device)
 {
 	unsigned long iommu_type = device->iommu_mode->iommu_type;
+	int ret;
+
+	ret = ioctl(device->container_fd, VFIO_CHECK_EXTENSION, iommu_type);
+	VFIO_ASSERT_GT(ret, 0, "VFIO IOMMU type %lu not supported\n", iommu_type);
+
+	ioctl_assert(device->container_fd, VFIO_SET_IOMMU, (void *)iommu_type);
+}
+
+void vfio_container_open(struct vfio_pci_device *device)
+{
 	const char *path = device->iommu_mode->container_path;
 	int version;
-	int ret;
 
 	device->container_fd = open(path, O_RDWR);
 	VFIO_ASSERT_GE(device->container_fd, 0, "open(%s) failed\n", path);
 
 	version = ioctl(device->container_fd, VFIO_GET_API_VERSION);
 	VFIO_ASSERT_EQ(version, VFIO_API_VERSION, "Unsupported version: %d\n", version);
+}
 
+static void vfio_pci_container_setup(struct vfio_pci_device *device,
+				      const char *bdf, const char *vf_token)
+{
+	vfio_container_open(device);
 	vfio_pci_group_setup(device, bdf);
-
-	ret = ioctl(device->container_fd, VFIO_CHECK_EXTENSION, iommu_type);
-	VFIO_ASSERT_GT(ret, 0, "VFIO IOMMU type %lu not supported\n", iommu_type);
-
-	ioctl_assert(device->container_fd, VFIO_SET_IOMMU, (void *)iommu_type);
-
-	vfio_pci_container_get_device_fd(device, bdf, vf_token);
+	vfio_container_set_iommu(device);
+	vfio_container_get_device_fd(device, bdf, vf_token);
 }
 
 static void vfio_pci_device_setup(struct vfio_pci_device *device)
@@ -471,7 +484,7 @@ static const struct vfio_iommu_mode iommu_modes[] = {
 
 const char *default_iommu_mode = "iommufd";
 
-static const struct vfio_iommu_mode *lookup_iommu_mode(const char *iommu_mode)
+const struct vfio_iommu_mode *lookup_iommu_mode(const char *iommu_mode)
 {
 	int i;
 
@@ -488,7 +501,12 @@ static const struct vfio_iommu_mode *lookup_iommu_mode(const char *iommu_mode)
 	VFIO_FAIL("Unrecognized IOMMU mode: %s\n", iommu_mode);
 }
 
-static void vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token)
+const char *iommu_mode_container_path(const char *iommu_mode)
+{
+	return lookup_iommu_mode(iommu_mode)->container_path;
+}
+
+int __vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token)
 {
 	struct vfio_device_bind_iommufd args = {
 		.argsz = sizeof(args),
@@ -502,7 +520,14 @@ static void vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_
 		args.token_uuid_ptr = (u64) token_uuid;
 	}
 
-	ioctl_assert(device_fd, VFIO_DEVICE_BIND_IOMMUFD, &args);
+	return ioctl(device_fd, VFIO_DEVICE_BIND_IOMMUFD, &args);
+}
+
+static void vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token)
+{
+	int ret = __vfio_device_bind_iommufd(device_fd, iommufd, vf_token);
+
+	VFIO_ASSERT_EQ(ret, 0, "Failed VFIO_DEVICE_BIND_IOMMUFD ioctl\n");
 }
 
 static u32 iommufd_ioas_alloc(int iommufd)
@@ -525,23 +550,31 @@ static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
 	ioctl_assert(device_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &args);
 }
 
-static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
-				    const char *bdf, const char *vf_token)
+void vfio_pci_iommufd_cdev_open(struct vfio_pci_device *device, const char *bdf)
 {
 	const char *cdev_path = vfio_pci_get_cdev_path(bdf);
 
 	device->fd = open(cdev_path, O_RDWR);
 	VFIO_ASSERT_GE(device->fd, 0);
 	free((void *)cdev_path);
+}
 
+void vfio_pci_iommufd_iommudev_open(struct vfio_pci_device *device)
+{
 	/*
 	 * Require device->iommufd to be >0 so that a simple non-0 check can be
 	 * used to check if iommufd is enabled. In practice open() will never
 	 * return 0 unless stdin is closed.
 	 */
-	device->iommufd = open("/dev/iommu", O_RDWR);
-	VFIO_ASSERT_GT(device->iommufd, 0);
+	 device->iommufd = open("/dev/iommu", O_RDWR);
+	 VFIO_ASSERT_GT(device->iommufd, 0);
+}
 
+static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
+				    const char *bdf, const char *vf_token)
+{
+	vfio_pci_iommufd_cdev_open(device, bdf);
+	vfio_pci_iommufd_iommudev_open(device);
 	vfio_device_bind_iommufd(device->fd, device->iommufd, vf_token);
 	device->ioas_id = iommufd_ioas_alloc(device->iommufd);
 	vfio_device_attach_iommufd_pt(device->fd, device->ioas_id);
-- 
2.51.2.997.g839fc31de9-goog


