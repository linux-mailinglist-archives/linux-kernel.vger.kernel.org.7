Return-Path: <linux-kernel+bounces-883882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3920C2EA30
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 01:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1531D188F006
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 00:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB3A2222C8;
	Tue,  4 Nov 2025 00:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xjHusNKA"
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360FE207A0B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 00:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762216553; cv=none; b=VpeIgQ6bBYji8rJH81GODbpUnNOa2XlHD5oY293ydv4kujgcq1XdTlZFgyr5FfBSSAuuzYpiQIIOLXPGaYsaNJ+YK6sp+P7TWu3pBpWHfdjT6gdnWZLOjJ+E49DCGZqfWxPDlCLG0k5ig/bSlGqL/kMyHinxpOSjdvHBSDNIpGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762216553; c=relaxed/simple;
	bh=uGK2yal742+L5uk1T2yEsKAxi7zImwe71HR1cOhVFBc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WQmkRaD59xRfAABrqNeoi0GXk7LwshwRqMzFWcRjgJhb2kVIPaJzhzW1ds9GqDOBAU28SUtVd/rtKU3wmUSxediEQISqjsQt99vez52lHHk4gH7y5eKGzRwca/zUG/h1w8BHAiT/SHTOClN3Jr6Iq7+9lzgKmKhnKxA3FsRoepc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xjHusNKA; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-4330f62ef60so30014515ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 16:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762216549; x=1762821349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GF5TG07a1gbc3wTybx+JCwQT1BRdxgUx9VY9r9yva38=;
        b=xjHusNKAIfVIhZD/DssHhJSQVqiDOTWam9KmB9mcqNmASN7ur28mxDFAayeeeWa8Vi
         Sx/LQt89sDi7X2GN5ik7cfwGMC94K81jxPuVQXgqPMEnqWRPEzPOW42Orgc4VryLbXnD
         bJFND3bzZiBbcGdBMypi2gJtGyfaJcWTgGdO9FUC8hDjvVl7XzgvC13Z02+tTw2yoCtz
         Qj7ezDVL0nSKArtTDh3qXWP2kuoLCPvUeHpMaJiXzhaOLw4IDFMvBv4W9CTYcZlzjgPo
         kR+Q7acHsVwRoEZbJuVLBLzqPs8+Vp6qiAH5LBe+5TioLllR0XSK+6lgbK9zu+an5wg1
         incw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762216549; x=1762821349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GF5TG07a1gbc3wTybx+JCwQT1BRdxgUx9VY9r9yva38=;
        b=IkfG2MbuS6Ztfj494r6oHHzt9w9r/tqe6IkC7koUoWfy26o6itagsYzCztyTeREWTU
         xiARq+hkgzCTjhhVhsFajx5oUreMwrsrk9NgBPL1MwYFOKhvrAFRiGcuTJRImgVH5zkl
         q5wr8Cr1zDPuQ5CR14CQ/iT3++UE/SBPsdGTCXqWvIPpv4I/zHnNbeAIZL4G64nKDbmo
         5abqblZ2q/iRsKzxfZkw6mJIsFePUBYAro8GLY7aj0FMlnyECDa/hqymYEELXLLKZrB6
         UEYcYiP465nVyIwHTPKY/AA/WoFMZOLwJlS2NsEYceaVjT1YbLHZRTrrhKyzceZiX2MP
         ifGw==
X-Forwarded-Encrypted: i=1; AJvYcCUHJxM/sFWGuFliKgmJR1EI632evpE6n9+XcwZsQq1oG4RAjhRHFm0RGZMEYiRn2dHGfzbNfU/A3Ub0IP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7W1Y53a50K8PxgtzjiMie8aI3fwHq7UOPvp5Kmz/gddmLwreJ
	GnRTSJaINkHyV3qMDrLfFG7AeHLDRQVkMY9ND7zXh+G5nfaBGkz4umrNNF3ePaOTr10eRd4RQFa
	M1vWcPwXS6w==
X-Google-Smtp-Source: AGHT+IF8Q031DG4uDTX0YteuJO/98OOb+2PRRF1bW+brFBXJOSsraipfCPKDFyV4JvE0wkGPqNgytRHV3VGn
X-Received: from ill17.prod.google.com ([2002:a92:c651:0:b0:433:1d1f:6919])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6e02:1543:b0:433:2fa2:a55d
 with SMTP id e9e14a558f8ab-4332fa2a76emr79592985ab.12.1762216549069; Mon, 03
 Nov 2025 16:35:49 -0800 (PST)
Date: Tue,  4 Nov 2025 00:35:35 +0000
In-Reply-To: <20251104003536.3601931-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251104003536.3601931-1-rananta@google.com>
X-Mailer: git-send-email 2.51.2.997.g839fc31de9-goog
Message-ID: <20251104003536.3601931-4-rananta@google.com>
Subject: [PATCH 3/4] vfio: selftests: Add helper to set/override a vf_token
From: Raghavendra Rao Ananta <rananta@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, 
	Alex Williamson <alex.williamson@redhat.com>
Cc: Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"

Not only at init, but a vf_token can also be set via the
VFIO_DEVICE_FEATURE ioctl, by setting the
VFIO_DEVICE_FEATURE_PCI_VF_TOKEN flag. Add an API to utilize this
functionality from the test code.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 .../selftests/vfio/lib/include/vfio_util.h    |  2 ++
 .../selftests/vfio/lib/vfio_pci_device.c      | 34 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index 2baf12a888e67..f0a12646456a9 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -307,4 +307,6 @@ void vfio_pci_iommufd_cdev_open(struct vfio_pci_device *device, const char *bdf)
 void vfio_pci_iommufd_iommudev_open(struct vfio_pci_device *device);
 int __vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token);
 
+void vfio_device_set_vf_token(int fd, const char *vf_token);
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H */
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 7a1547e365870..c0fa4e27a96ef 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -144,6 +144,40 @@ static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
 	ioctl_assert(device->fd, VFIO_DEVICE_GET_IRQ_INFO, irq_info);
 }
 
+static int vfio_device_feature_ioctl(int fd, u32 flags, void *data,
+				     size_t data_size)
+{
+	u8 buffer[sizeof(struct vfio_device_feature) + data_size] = {};
+	struct vfio_device_feature *feature = (void *)buffer;
+
+	memcpy(feature->data, data, data_size);
+
+	feature->argsz = sizeof(buffer);
+	feature->flags = flags;
+
+	return ioctl(fd, VFIO_DEVICE_FEATURE, feature);
+}
+
+static void vfio_device_feature_set(int fd, u16 feature, void *data, size_t data_size)
+{
+	u32 flags = VFIO_DEVICE_FEATURE_SET | feature;
+	int ret;
+
+	ret = vfio_device_feature_ioctl(fd, flags, data, data_size);
+	VFIO_ASSERT_EQ(ret, 0, "Failed to set feature %u\n", feature);
+}
+
+void vfio_device_set_vf_token(int fd, const char *vf_token)
+{
+	uuid_t token_uuid = {0};
+
+	VFIO_ASSERT_NOT_NULL(vf_token, "vf_token is NULL");
+	VFIO_ASSERT_EQ(uuid_parse(vf_token, token_uuid), 0);
+
+	vfio_device_feature_set(fd, VFIO_DEVICE_FEATURE_PCI_VF_TOKEN,
+				token_uuid, sizeof(uuid_t));
+}
+
 static void vfio_iommu_dma_map(struct vfio_pci_device *device,
 			       struct vfio_dma_region *region)
 {
-- 
2.51.2.997.g839fc31de9-goog


