Return-Path: <linux-kernel+bounces-618592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EBDA9B085
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 16:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E4E1B844A3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 14:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79C028D83D;
	Thu, 24 Apr 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VQsAJJKu"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2F428A414
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504050; cv=none; b=M0N+IzJ1ZWZ22ICZmmRupvVSinxosfINAmelkRwCmxwf50JT0pG40c8Ie82V47Fkf2m+uW8l6e7eYf+YjFmdlFyrgLHbpPv5P061BnCKyEpVB70Ot5d+Mjla5Pp+wD3Kbh95u1XKLXwYofLBYtQHbln4tp5tj2P4AS7oUZDniXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504050; c=relaxed/simple;
	bh=r3nd9vghu4s4uBkV+N+7fBpy1dkBUZqwpUsMh9tj/Uw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fMxo2pE52rA9FZFRAcQYg9STwwn6j3gBGmFoVQUqECLZuCXxihl1kj4QvpKGZPbiLyUgCvGrsafYyoihGpH3/B2KVNifUPWvdOOKDTVZoDdxxnk7bW/hU9iqnij7Bzd/TOoi1iHQxq1Ldq35G3/q/Hwts/NAigTk6/57U59FE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VQsAJJKu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfe574976so7692675e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 07:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745504045; x=1746108845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrxJtuJG442F2RUwTFuDHGt6qjNm8WZW6h3yhfXqCrI=;
        b=VQsAJJKu0h2qk9A9xzNKMZK6r7K8M27J7ZmUtQbNAP1wZYFB/nBWgwA/ggE5n+Qd0I
         TAXhGrBlm1ThQgmwgmbNAZv+Yo9Ay/NQMbTr8OY4Nptw/Bewli5OGnagneHTc/Wjotm9
         AJn7JH7o4LC3fD6XeYIMbpPwyxx8UCMxwPcHCgpQXXD+BNlzCmkt/71/U4tNSiUyG4xk
         Rll0CsbyHj5CQEjj6X4hZHyoFYjVUJzJBfOjvNIasG3FXHLXEcGxcewR++AvyQPTVTDP
         qHEIzbgBpFkjq7gi12n50ADGWVrJWD9RwThMWmj+qfGF3o2bPCldXWF5lBMrjjtVuQYm
         QUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745504045; x=1746108845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrxJtuJG442F2RUwTFuDHGt6qjNm8WZW6h3yhfXqCrI=;
        b=Dubh1QPOaSup9NiK1A8EIkc7nYqwegwOkfpnn7kZm7r95GAyno9l/Enx4ogOcsY/iv
         CYmFnc1MxkuSbKD3LJdtafzn62/V2nZ74BI2GN/1cpOfkgZMs5x79VIxmmIGUAGQrn8A
         r/mo7unoAG4Rs57nGmFGfszgoDJV6kfU3Q7Ys4g+OJb2nhPwCnMimNylLgEpmGL/GSTn
         zPC23G2YD2WXhNZPyYJ2JYvkNbpjH2wYUrfsgwJGey6u8a7YzEQDwpiCcbkMBU/uE4y+
         7+CZnMoOLjExEoQl4GYz7fZkBpYwVp/zJcgSh7yctPJQLdru9cnTEoJgUF8DrTfUouOF
         Wg2g==
X-Gm-Message-State: AOJu0YxuTXWoNwQY1UUxCqKQ1sy5sWXFC/7rm/aI3hiA4J0qNMXJi15j
	rcf7ISnLvXvUY5RP/s8ZZQbdsr8Pb7BCUBsDz2C/fMsrkSVUkj1HVQ/G5oIbqZuTdBbK8/t+ob7
	k
X-Gm-Gg: ASbGncszm2JUyNiRmmLpygm+ExJj8LdeecvGl5RiS3ZDAaawfqCgwUt1Vf9lyQIXGq+
	iJPW1EscUmPHLzIWzY4JkLtrdQ7jDVGEzS6MfSTew7zXq/hMfcXsIW3e0aSXdE2YIoHKYx9HJUM
	84ppR9K4PgLc6wvMqsbygBFv5rqdj72l6EzDReCBBAxIh1mtkLE4AE1PdG+2QQJgpFMsuVLlH7+
	j5sjJebSjccc7JPjqqsQJxz0WOoAnkLOSRvE6KsnhEIYtCtdmc6RH8vp92qYYp/0LrxqadVA/mc
	28IHHHkXpyYxtBbOw3po0tfrbK/00o4FVu3OnoJkBXCxiLM+qW3vWQ5hKyMNbRKY3CSRZmSP+nJ
	coZ6w+GMyY4eutH2E
X-Google-Smtp-Source: AGHT+IF2yQw22hjehK9elALveIYUJReJwgCD95mE9PZgbazIybojHN298a9GDoCEMK47GVkaXYd77A==
X-Received: by 2002:a05:600c:4e48:b0:439:8c80:6af4 with SMTP id 5b1f17b1804b1-4409bd23f55mr24505185e9.19.1745504045045;
        Thu, 24 Apr 2025 07:14:05 -0700 (PDT)
Received: from seksu.systems-nuts.com (stevens.inf.ed.ac.uk. [129.215.164.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d4a8150sm2199951f8f.7.2025.04.24.07.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 07:14:04 -0700 (PDT)
From: Karim Manaouil <karim.manaouil@linaro.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Cc: Karim Manaouil <karim.manaouil@linaro.org>,
	Alexander Graf <graf@amazon.com>,
	Alex Elder <elder@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
	Quentin Perret <qperret@google.com>,
	Rob Herring <robh@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
	Will Deacon <will@kernel.org>,
	Haripranesh S <haripran@qti.qualcomm.com>,
	Carl van Schaik <cvanscha@qti.qualcomm.com>,
	Murali Nalajala <mnalajal@quicinc.com>,
	Sreenivasulu Chalamcharla <sreeniva@qti.qualcomm.com>,
	Trilok Soni <tsoni@quicinc.com>,
	Stefan Schmidt <stefan.schmidt@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>
Subject: [RFC PATCH 15/34] gunyah: Add VM lifecycle RPC
Date: Thu, 24 Apr 2025 15:13:22 +0100
Message-Id: <20250424141341.841734-16-karim.manaouil@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250424141341.841734-1-karim.manaouil@linaro.org>
References: <20250424141341.841734-1-karim.manaouil@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elliot Berman <quic_eberman@quicinc.com>

Add Gunyah Resource Manager RPC interfaces to launch an unauthenticated
virtual machine.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
Reviewed-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Signed-off-by: Karim Manaouil <karim.manaouil@linaro.org>
---
 drivers/virt/gunyah/Makefile      |   2 +-
 drivers/virt/gunyah/rsc_mgr_rpc.c | 252 ++++++++++++++++++++++++++++++
 include/linux/gunyah_rsc_mgr.h    |  79 +++++++++-
 3 files changed, 331 insertions(+), 2 deletions(-)
 create mode 100644 drivers/virt/gunyah/rsc_mgr_rpc.c

diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index c2308389f551..b1bdf3e84155 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-gunyah_rsc_mgr-y += rsc_mgr.o
+gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o
 
 obj-$(CONFIG_GUNYAH) += gunyah.o gunyah_rsc_mgr.o
diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
new file mode 100644
index 000000000000..626ad2565548
--- /dev/null
+++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/error-injection.h>
+
+#include <linux/gunyah_rsc_mgr.h>
+
+/* Message IDs: VM Management */
+/* clang-format off */
+#define GUNYAH_RM_RPC_VM_ALLOC_VMID		0x56000001
+#define GUNYAH_RM_RPC_VM_DEALLOC_VMID		0x56000002
+#define GUNYAH_RM_RPC_VM_START			0x56000004
+#define GUNYAH_RM_RPC_VM_STOP			0x56000005
+#define GUNYAH_RM_RPC_VM_RESET			0x56000006
+#define GUNYAH_RM_RPC_VM_CONFIG_IMAGE		0x56000009
+#define GUNYAH_RM_RPC_VM_INIT			0x5600000B
+#define GUNYAH_RM_RPC_VM_GET_HYP_RESOURCES	0x56000020
+#define GUNYAH_RM_RPC_VM_GET_VMID		0x56000024
+#define GUNYAH_RM_RPC_VM_SET_BOOT_CONTEXT	0x56000031
+#define GUNYAH_RM_RPC_VM_SET_DEMAND_PAGING	0x56000033
+#define GUNYAH_RM_RPC_VM_SET_ADDRESS_LAYOUT	0x56000034
+/* clang-format on */
+
+struct gunyah_rm_vm_common_vmid_req {
+	__le16 vmid;
+	__le16 _padding;
+} __packed;
+
+/* Call: VM_ALLOC */
+struct gunyah_rm_vm_alloc_vmid_resp {
+	__le16 vmid;
+	__le16 _padding;
+} __packed;
+
+/* Call: VM_STOP */
+#define GUNYAH_RM_VM_STOP_FLAG_FORCE_STOP BIT(0)
+
+#define GUNYAH_RM_VM_STOP_REASON_FORCE_STOP 3
+
+struct gunyah_rm_vm_stop_req {
+	__le16 vmid;
+	u8 flags;
+	u8 _padding;
+	__le32 stop_reason;
+} __packed;
+
+/* Call: VM_CONFIG_IMAGE */
+struct gunyah_rm_vm_config_image_req {
+	__le16 vmid;
+	__le16 auth_mech;
+	__le32 mem_handle;
+	__le64 image_offset;
+	__le64 image_size;
+	__le64 dtb_offset;
+	__le64 dtb_size;
+} __packed;
+
+/*
+ * Several RM calls take only a VMID as a parameter and give only standard
+ * response back. Deduplicate boilerplate code by using this common call.
+ */
+static int gunyah_rm_common_vmid_call(struct gunyah_rm *rm, u32 message_id,
+				      u16 vmid)
+{
+	struct gunyah_rm_vm_common_vmid_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+	};
+
+	return gunyah_rm_call(rm, message_id, &req_payload, sizeof(req_payload),
+			      NULL, NULL);
+}
+
+/**
+ * gunyah_rm_alloc_vmid() - Allocate a new VM in Gunyah. Returns the VM identifier.
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: Use 0 to dynamically allocate a VM. A reserved VMID can be supplied
+ *        to request allocation of a platform-defined VM.
+ *
+ * Return: the allocated VMID or negative value on error
+ */
+int gunyah_rm_alloc_vmid(struct gunyah_rm *rm, u16 vmid)
+{
+	struct gunyah_rm_vm_common_vmid_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+	};
+	struct gunyah_rm_vm_alloc_vmid_resp *resp_payload;
+	size_t resp_size;
+	void *resp;
+	int ret;
+
+	ret = gunyah_rm_call(rm, GUNYAH_RM_RPC_VM_ALLOC_VMID, &req_payload,
+			     sizeof(req_payload), &resp, &resp_size);
+	if (ret)
+		return ret;
+
+	if (!vmid) {
+		resp_payload = resp;
+		ret = le16_to_cpu(resp_payload->vmid);
+		kfree(resp);
+	}
+
+	return ret;
+}
+ALLOW_ERROR_INJECTION(gunyah_rm_alloc_vmid, ERRNO);
+
+/**
+ * gunyah_rm_dealloc_vmid() - Dispose of a VMID
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VM identifier allocated with gunyah_rm_alloc_vmid
+ */
+int gunyah_rm_dealloc_vmid(struct gunyah_rm *rm, u16 vmid)
+{
+	return gunyah_rm_common_vmid_call(rm, GUNYAH_RM_RPC_VM_DEALLOC_VMID,
+					  vmid);
+}
+ALLOW_ERROR_INJECTION(gunyah_rm_dealloc_vmid, ERRNO);
+
+/**
+ * gunyah_rm_vm_reset() - Reset a VM's resources
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VM identifier allocated with gunyah_rm_alloc_vmid
+ *
+ * As part of tearing down the VM, request RM to clean up all the VM resources
+ * associated with the VM. Only after this, Linux can clean up all the
+ * references it maintains to resources.
+ */
+int gunyah_rm_vm_reset(struct gunyah_rm *rm, u16 vmid)
+{
+	return gunyah_rm_common_vmid_call(rm, GUNYAH_RM_RPC_VM_RESET, vmid);
+}
+ALLOW_ERROR_INJECTION(gunyah_rm_vm_reset, ERRNO);
+
+/**
+ * gunyah_rm_vm_start() - Move a VM into "ready to run" state
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VM identifier allocated with gunyah_rm_alloc_vmid
+ *
+ * On VMs which use proxy scheduling, vcpu_run is needed to actually run the VM.
+ * On VMs which use Gunyah's scheduling, the vCPUs start executing in accordance with Gunyah
+ * scheduling policies.
+ */
+int gunyah_rm_vm_start(struct gunyah_rm *rm, u16 vmid)
+{
+	return gunyah_rm_common_vmid_call(rm, GUNYAH_RM_RPC_VM_START, vmid);
+}
+ALLOW_ERROR_INJECTION(gunyah_rm_vm_start, ERRNO);
+
+/**
+ * gunyah_rm_vm_stop() - Send a request to Resource Manager VM to forcibly stop a VM.
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VM identifier allocated with gunyah_rm_alloc_vmid
+ */
+int gunyah_rm_vm_stop(struct gunyah_rm *rm, u16 vmid)
+{
+	struct gunyah_rm_vm_stop_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+		.flags = GUNYAH_RM_VM_STOP_FLAG_FORCE_STOP,
+		.stop_reason = cpu_to_le32(GUNYAH_RM_VM_STOP_REASON_FORCE_STOP),
+	};
+
+	return gunyah_rm_call(rm, GUNYAH_RM_RPC_VM_STOP, &req_payload,
+			      sizeof(req_payload), NULL, NULL);
+}
+ALLOW_ERROR_INJECTION(gunyah_rm_vm_stop, ERRNO);
+
+/**
+ * gunyah_rm_vm_configure() - Prepare a VM to start and provide the common
+ *			  configuration needed by RM to configure a VM
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VM identifier allocated with gunyah_rm_alloc_vmid
+ * @auth_mechanism: Authentication mechanism used by resource manager to verify
+ *                  the virtual machine
+ * @mem_handle: Handle to a previously shared memparcel that contains all parts
+ *              of the VM image subject to authentication.
+ * @image_offset: Start address of VM image, relative to the start of memparcel
+ * @image_size: Size of the VM image
+ * @dtb_offset: Start address of the devicetree binary with VM configuration,
+ *              relative to start of memparcel.
+ * @dtb_size: Maximum size of devicetree binary.
+ */
+int gunyah_rm_vm_configure(struct gunyah_rm *rm, u16 vmid,
+			   enum gunyah_rm_vm_auth_mechanism auth_mechanism,
+			   u32 mem_handle, u64 image_offset, u64 image_size,
+			   u64 dtb_offset, u64 dtb_size)
+{
+	struct gunyah_rm_vm_config_image_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+		.auth_mech = cpu_to_le16(auth_mechanism),
+		.mem_handle = cpu_to_le32(mem_handle),
+		.image_offset = cpu_to_le64(image_offset),
+		.image_size = cpu_to_le64(image_size),
+		.dtb_offset = cpu_to_le64(dtb_offset),
+		.dtb_size = cpu_to_le64(dtb_size),
+	};
+
+	return gunyah_rm_call(rm, GUNYAH_RM_RPC_VM_CONFIG_IMAGE, &req_payload,
+			      sizeof(req_payload), NULL, NULL);
+}
+ALLOW_ERROR_INJECTION(gunyah_rm_vm_configure, ERRNO);
+
+/**
+ * gunyah_rm_vm_init() - Move the VM to initialized state.
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VM identifier
+ *
+ * RM will allocate needed resources for the VM.
+ */
+int gunyah_rm_vm_init(struct gunyah_rm *rm, u16 vmid)
+{
+	return gunyah_rm_common_vmid_call(rm, GUNYAH_RM_RPC_VM_INIT, vmid);
+}
+ALLOW_ERROR_INJECTION(gunyah_rm_vm_init, ERRNO);
+
+/**
+ * gunyah_rm_get_hyp_resources() - Retrieve hypervisor resources (capabilities) associated with a VM
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VMID of the other VM to get the resources of
+ * @resources: Set by gunyah_rm_get_hyp_resources and contains the returned hypervisor resources.
+ *             Caller must free the resources pointer if successful.
+ */
+int gunyah_rm_get_hyp_resources(struct gunyah_rm *rm, u16 vmid,
+				struct gunyah_rm_hyp_resources **resources)
+{
+	struct gunyah_rm_vm_common_vmid_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+	};
+	struct gunyah_rm_hyp_resources *resp;
+	size_t resp_size;
+	int ret;
+
+	ret = gunyah_rm_call(rm, GUNYAH_RM_RPC_VM_GET_HYP_RESOURCES,
+			     &req_payload, sizeof(req_payload), (void **)&resp,
+			     &resp_size);
+	if (ret)
+		return ret;
+
+	if (!resp_size)
+		return -EBADMSG;
+
+	if (resp_size < struct_size(resp, entries, 0) ||
+	    resp_size !=
+		    struct_size(resp, entries, le32_to_cpu(resp->n_entries))) {
+		kfree(resp);
+		return -EBADMSG;
+	}
+
+	*resources = resp;
+	return 0;
+}
+ALLOW_ERROR_INJECTION(gunyah_rm_get_hyp_resources, ERRNO);
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index 87e919cc1e28..294e847c27ed 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -19,9 +19,86 @@ int gunyah_rm_notifier_register(struct gunyah_rm *rm,
 int gunyah_rm_notifier_unregister(struct gunyah_rm *rm,
 				  struct notifier_block *nb);
 
+struct gunyah_rm_vm_exited_payload {
+	__le16 vmid;
+	__le16 exit_type;
+	__le32 exit_reason_size;
+	u8 exit_reason[];
+} __packed;
+
+enum gunyah_rm_notification_id {
+	/* clang-format off */
+	GUNYAH_RM_NOTIFICATION_VM_EXITED		 = 0x56100001,
+	GUNYAH_RM_NOTIFICATION_VM_STATUS		 = 0x56100008,
+	/* clang-format on */
+};
+
+enum gunyah_rm_vm_status {
+	/* clang-format off */
+	GUNYAH_RM_VM_STATUS_NO_STATE		= 0,
+	GUNYAH_RM_VM_STATUS_INIT		= 1,
+	GUNYAH_RM_VM_STATUS_READY		= 2,
+	GUNYAH_RM_VM_STATUS_RUNNING		= 3,
+	GUNYAH_RM_VM_STATUS_PAUSED		= 4,
+	GUNYAH_RM_VM_STATUS_LOAD		= 5,
+	GUNYAH_RM_VM_STATUS_AUTH		= 6,
+	GUNYAH_RM_VM_STATUS_INIT_FAILED		= 8,
+	GUNYAH_RM_VM_STATUS_EXITED		= 9,
+	GUNYAH_RM_VM_STATUS_RESETTING		= 10,
+	GUNYAH_RM_VM_STATUS_RESET		= 11,
+	/* clang-format on */
+};
+
+struct gunyah_rm_vm_status_payload {
+	__le16 vmid;
+	u16 reserved;
+	u8 vm_status;
+	u8 os_status;
+	__le16 app_status;
+} __packed;
+
+int gunyah_rm_alloc_vmid(struct gunyah_rm *rm, u16 vmid);
+int gunyah_rm_dealloc_vmid(struct gunyah_rm *rm, u16 vmid);
+int gunyah_rm_vm_reset(struct gunyah_rm *rm, u16 vmid);
+int gunyah_rm_vm_start(struct gunyah_rm *rm, u16 vmid);
+int gunyah_rm_vm_stop(struct gunyah_rm *rm, u16 vmid);
+
+enum gunyah_rm_vm_auth_mechanism {
+	/* clang-format off */
+	GUNYAH_RM_VM_AUTH_NONE			= 0,
+	GUNYAH_RM_VM_AUTH_QCOM_PIL_ELF		= 1,
+	GUNYAH_RM_VM_AUTH_QCOM_ANDROID_PVM	= 2,
+	/* clang-format on */
+};
+
+int gunyah_rm_vm_configure(struct gunyah_rm *rm, u16 vmid,
+			   enum gunyah_rm_vm_auth_mechanism auth_mechanism,
+			   u32 mem_handle, u64 image_offset, u64 image_size,
+			   u64 dtb_offset, u64 dtb_size);
+int gunyah_rm_vm_init(struct gunyah_rm *rm, u16 vmid);
+
+struct gunyah_rm_hyp_resource {
+	u8 type;
+	u8 reserved;
+	__le16 partner_vmid;
+	__le32 resource_handle;
+	__le32 resource_label;
+	__le64 cap_id;
+	__le32 virq_handle;
+	__le32 virq;
+	__le64 base;
+	__le64 size;
+} __packed;
+
+struct gunyah_rm_hyp_resources {
+	__le32 n_entries;
+	struct gunyah_rm_hyp_resource entries[];
+} __packed;
+
+int gunyah_rm_get_hyp_resources(struct gunyah_rm *rm, u16 vmid,
+				struct gunyah_rm_hyp_resources **resources);
 
 int gunyah_rm_call(struct gunyah_rm *rsc_mgr, u32 message_id,
 		   const void *req_buf, size_t req_buf_size, void **resp_buf,
 		   size_t *resp_buf_size);
-
 #endif
-- 
2.39.5


