Return-Path: <linux-kernel+bounces-835553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2971BA76BD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B54189765E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF33527781E;
	Sun, 28 Sep 2025 19:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lwB8M8US"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7353A275AF4
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 19:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086486; cv=none; b=DDmxqsD39HRATqNNVPK8rysPDtlL/oj2TT7Bd9x6p3ijRnwp9PllUXr9BAO93qgl/sHygHkc0VeLOw7lNKw+JkN5lIyAEaPPEkTuPvmzrHfp9iBidhAqThBZAzSZL/WirODKDRttvKC11FgySivwx7gEBqIGZYu21Yrm83uzBWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086486; c=relaxed/simple;
	bh=bp7Q5MfQ7BUhrxdif0RdrYgnTPagGMPXrfDPEix32cA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VI8IZKT4J+FMcvpNRpnla53f8tgb5CBiVXdpClJjWi62Ps2p7HTAi/jTuzjrVybFinILpvSiBuQZSUbdpQBe4uM8mH34+ftxLW7WIEhGDKI0yW6cEGJX9rXd7pGrxuFdzqGHXWjjNeUxZsoaOuvez6b4JdMbF+wwFhuLq92Gb+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lwB8M8US; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77b73bddbdcso3232511b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086484; x=1759691284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJxUEkhR4xzbVVm1hzIqWlYBXGWxXyVuvzNZ0+K6GBc=;
        b=lwB8M8USC4MsZpOV6rXGPf99LmzaBDPL4k7rhBcrCTsUGgWW9xNQ2BpB6Rc2npS5vr
         lV+wLEiSQszkb/isLVMPea1ycNz7TDSPteRGdDTpQUPIBr5K06xRBlaegmneLqSD/DHr
         KoqlNCljMeykVKk1heJ3jWjy34kGyRw6AQmLffCCNQmLioiwRFFSXojTA0DL4mU/OCL8
         HbawFx/MhOO3GH+1lAb2m+yDY5apdruMCGukAVHwb8+bkHg5bwPbtPQJpU0tD8qOAO6d
         ii80AmOaejskNnyRIb4dAiWOOCnSeILmQJB+hlFYVfUo82Ke5T2wrUTl3GGMtT/kn+U/
         qdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086484; x=1759691284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJxUEkhR4xzbVVm1hzIqWlYBXGWxXyVuvzNZ0+K6GBc=;
        b=sXIYgnObW4KY9nrj2s1nrhUOwT5jMu9Vd8nHI0HVmxxN0nmaEJz3cnD8uuH0D9jr+0
         l9rQDEtG5ylNK2wq2uoqqEUjfA8U1RiLOYEwxrnIBSf8lqgt2s71me5u6+lK5/6K59gU
         tMNhNl6uHrL4x+RXzk+gLENzs9TDMJkm6RzBq1xO8jY7Pdc5f+mkbVYZ7Woqyys6IqeV
         MQFxpDuIkcwVr56yBrmtU3gERUnlkoIjyUBnAtErNdOGQvDp0jlJmw7ytZ7c+t4Wa+1e
         U+m4mWhWxi50q5U7MlwdXLrf3+yf8rvLbVYhK52A2XiHSyGPSmusgi/aRldAz2OE3Jpr
         083g==
X-Forwarded-Encrypted: i=1; AJvYcCWy92ulQeK/BC8aRdW7FFDKn77d0MPLfuxF/JqG3+ETlySSHjnA057zFgz9c0ipxKpWkEZnAgskvMwlP9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrtl0NR2mhs4+BuOvR0r7h3qq1XJ0TzXtOCwaWuGGnHtb53oZX
	RF8WOWEPc7rxEvj0YUQO/iw4BqSRrqwC7s0ZGUaX/lM+LHT1E2qS9j4HEufv6hvyYXlYgkxHdXl
	WXcM71sDe4bxLVQ==
X-Google-Smtp-Source: AGHT+IFMTxLoSANT4uRqLmmBpB6B54qHvJVSAjDeqXG+t6yE8ph3la8TEAGcK8rMwkormXLy9e2ya2SG2UiFcQ==
X-Received: from pfog16.prod.google.com ([2002:aa7:8750:0:b0:77f:1f29:5399])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2395:b0:772:397b:b270 with SMTP id d2e1a72fcca58-78100fcf632mr12637028b3a.10.1759086483707;
 Sun, 28 Sep 2025 12:08:03 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:23 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-16-skhawaja@google.com>
Subject: [RFC PATCH 15/15] iommufd/selftest: Add test to verify iommufd preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, zhuyifei@google.com, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Test iommufd preservation by setting up an iommufd and preserve it
across live update. Test takes VFIO cdev path of a device bound to
vfio-pci driver and binds it to an iommufd being preserved.

Note that the helper functions setup_cdev, open_iommufd, and
setup_iommufd will be replaced with VFIO selftest library. Similarly the
helper function defined to open and interface with Live Update
Orchestrator device will be replaced with a common helper library.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 tools/testing/selftests/iommu/Makefile        |   1 +
 .../selftests/iommu/iommufd_liveupdate.c      | 196 ++++++++++++++++++
 2 files changed, 197 insertions(+)
 create mode 100644 tools/testing/selftests/iommu/iommufd_liveupdate.c

diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
index 84abeb2f0949..42c962c5e612 100644
--- a/tools/testing/selftests/iommu/Makefile
+++ b/tools/testing/selftests/iommu/Makefile
@@ -6,5 +6,6 @@ LDLIBS += -lcap
 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += iommufd
 TEST_GEN_PROGS += iommufd_fail_nth
+TEST_GEN_PROGS += iommufd_liveupdate
 
 include ../lib.mk
diff --git a/tools/testing/selftests/iommu/iommufd_liveupdate.c b/tools/testing/selftests/iommu/iommufd_liveupdate.c
new file mode 100644
index 000000000000..1003d0cf2cae
--- /dev/null
+++ b/tools/testing/selftests/iommu/iommufd_liveupdate.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <stdbool.h>
+#include <unistd.h>
+
+#define __EXPORTED_HEADERS__
+#include <linux/liveupdate.h>
+#include <linux/iommufd.h>
+#include <linux/types.h>
+#include <linux/vfio.h>
+
+#include "../kselftest.h"
+
+#define ksft_assert(condition) \
+	do { if (!(condition)) \
+	ksft_exit_fail_msg("Failed: %s at %s %d\n", \
+	#condition, __FILE__, __LINE__); } while (0)
+
+int setup_cdev(const char *vfio_cdev_path)
+{
+	int cdev_fd;
+
+	cdev_fd = open(vfio_cdev_path, O_RDWR);
+	if (cdev_fd < 0)
+		ksft_exit_skip("Failed to open VFIO cdev: %s\n", vfio_cdev_path);
+
+	return cdev_fd;
+}
+
+int open_iommufd(void)
+{
+	int iommufd;
+
+	iommufd = open("/dev/iommu", O_RDWR);
+	if (iommufd < 0)
+		ksft_exit_skip("Failed to open /dev/iommu. IOMMUFD support not enabled.\n");
+
+	return iommufd;
+}
+
+int setup_iommufd(int iommufd, int cdev_fd)
+{
+	int ret;
+
+	struct vfio_device_bind_iommufd bind = {
+		.argsz = sizeof(bind),
+		.flags = 0,
+	};
+	struct iommu_ioas_alloc alloc_data  = {
+		.size = sizeof(alloc_data),
+		.flags = 0,
+	};
+	struct vfio_device_attach_iommufd_pt attach_data = {
+		.argsz = sizeof(attach_data),
+		.flags = 0,
+	};
+
+	bind.iommufd = iommufd;
+	ret = ioctl(cdev_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
+	ksft_assert(!ret);
+
+	ret = ioctl(iommufd, IOMMU_IOAS_ALLOC, &alloc_data);
+	ksft_assert(!ret);
+
+	attach_data.pt_id = alloc_data.out_ioas_id;
+	ret = ioctl(cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
+	ksft_assert(!ret);
+
+	return ret;
+}
+
+int open_liveupdate_orchestrator(void)
+{
+	int luo;
+
+	luo = open("/dev/liveupdate", O_RDWR);
+	ksft_assert(luo > 0);
+
+	return luo;
+}
+
+__u32 liveupdate_get_state(int luo)
+{
+	struct liveupdate_ioctl_get_state state;
+	int ret;
+
+	state.size = sizeof(state);
+	ret = ioctl(luo, LIVEUPDATE_IOCTL_GET_STATE, &state);
+	ksft_assert(!ret);
+
+	return state.state;
+}
+
+bool liveupdate_state_normal(int luo)
+{
+	return liveupdate_get_state(luo) == LIVEUPDATE_STATE_NORMAL;
+}
+
+bool liveupdate_state_updated(int luo)
+{
+	return liveupdate_get_state(luo) == LIVEUPDATE_STATE_UPDATED;
+}
+
+int liveupdate_set_event(int luo, enum liveupdate_event ev)
+{
+	struct liveupdate_ioctl_set_event event;
+	int ret;
+
+	event.event = ev;
+	event.size = sizeof(event);
+
+	ret = ioctl(luo, LIVEUPDATE_IOCTL_SET_EVENT, &event);
+	ksft_assert(!ret);
+
+	return ret;
+}
+
+int liveupdate_preserve_iommufd(int luo, int iommufd, int token)
+{
+	struct liveupdate_ioctl_fd_preserve preserve;
+	int ret;
+
+	preserve.fd = iommufd;
+	preserve.token = token;
+	preserve.size = sizeof(preserve);
+
+	ret = ioctl(luo, LIVEUPDATE_IOCTL_FD_PRESERVE, &preserve);
+	ksft_assert(!ret);
+
+	return ret;
+}
+
+int liveupdate_restore_iommufd(int luo, int token)
+{
+	struct liveupdate_ioctl_fd_restore restore;
+	int ret;
+
+	restore.token = token;
+	restore.size = sizeof(restore);
+
+	ret = ioctl(luo, LIVEUPDATE_IOCTL_FD_RESTORE, &restore);
+	ksft_assert(!ret);
+	ksft_assert(restore.fd > 0);
+
+	return restore.fd;
+}
+
+int main(int argc, char *argv[])
+{
+	int iommufd, cdev_fd, luo, ret;
+	const int token = 0x123456;
+
+	if (argc < 2) {
+		printf("Usage: ./iommufd_liveupdate <vfio_cdev_path>\n");
+		return 1;
+	}
+
+	cdev_fd = setup_cdev(argv[1]);
+
+	luo = open_liveupdate_orchestrator();
+	ksft_assert(luo > 0);
+
+	if (liveupdate_state_normal(luo))
+		iommufd = open_iommufd();
+	else if (liveupdate_state_updated(luo))
+		iommufd = liveupdate_restore_iommufd(luo, token);
+	else
+		ksft_exit_fail_msg("Test can only run when LUO state is normal or updated");
+
+	ret = setup_iommufd(iommufd, cdev_fd);
+	ksft_assert(!ret);
+
+	if (liveupdate_state_normal(luo)) {
+		ret = liveupdate_preserve_iommufd(luo, iommufd, token);
+		ksft_assert(!ret);
+
+		ret = liveupdate_set_event(luo, LIVEUPDATE_PREPARE);
+		ksft_assert(!ret);
+
+		while (1)
+			sleep(5);
+	} else {
+		ret = liveupdate_set_event(luo, LIVEUPDATE_FINISH);
+		ksft_assert(!ret);
+	}
+
+	return 0;
+}
+
-- 
2.51.0.536.g15c5d4f767-goog


