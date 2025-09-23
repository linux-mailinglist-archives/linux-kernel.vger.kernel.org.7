Return-Path: <linux-kernel+bounces-828481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AE5B94AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79721902E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD947314A73;
	Tue, 23 Sep 2025 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8xQGEDM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C697B30FF32
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611060; cv=none; b=CjBIcH9EbCNZTr0/YUtsLN/I3FIlENyzSRU6M+1Vn8VD4xDXEDA7vUVYKALUTO3IBaAO2/y2pGKJNmB0gZiw2GpWL2fQW7siZTvoHhgFGNWxvJ7HBnp4Beuq4ULS3nw3gRSTpnrNeQvJSclgCE21uhIoczVZ08qvBESBFWK4PqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611060; c=relaxed/simple;
	bh=2G5Pz2T/eeOEleqQw05bBp5Z2PqxOo2preIQJKu0QM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMHiIbKrS0ZqVV17JYM+Cv1G2d03ATubLBu8K8iUWtSMYi05lQItay5FficXPbZZcA1ojAteurrxRsqPI6pm27Nyp33BSjIhxYuOX2UzY7VsiuRQW837VeqThfcPYP8WqzHozaX2YSarHKPuO7CWJiJx03UU1VS6Py7TmFAIpsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8xQGEDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DDEC2BCB2;
	Tue, 23 Sep 2025 07:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758611060;
	bh=2G5Pz2T/eeOEleqQw05bBp5Z2PqxOo2preIQJKu0QM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J8xQGEDMFJ/qtpBbAULbHfp4+VkGq0FiAxONZGT9Fdx3AWajjf+2uoLy9g43Da/F6
	 5ceRKUb19M+P3hEdD6IVbjJwYyVImAsUn1RsFGa0Q/a7fxvfqjLUua66ZFqk8wmoKy
	 RQE9YMt2tpuDxq8W8UtUi5mJ1120i0/zWWMfd5hNq+epAPW6dxFFQYHbz1vwuJVZPB
	 i1nz9gFlO5uCxFP1BV+alnZozu9pbk/+2SIP4zgV/48vTNCFs2MHKs+26rRPVJFHXK
	 u0HGznBj3j8gr7kKPZ6ZT8alOZ33BLVjY5ClWsNhj9nXHIPvXnr+dy7y0ecVE2qbPM
	 FvpTxv6nCKA+g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v0x4U-00000006bL6-26TP;
	Tue, 23 Sep 2025 09:04:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ani Sinha <anisinha@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 12/17] arm/virt: Wire up a GED error device for ACPI / GHES
Date: Tue, 23 Sep 2025 09:04:06 +0200
Message-ID: <3237a76b1469d669436399495825348bf34122cd.1758610789.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758610789.git.mchehab+huawei@kernel.org>
References: <cover.1758610789.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Adds support to ARM virtualization to allow handling
generic error ACPI Event via GED & error source device.

It is aligned with Linux Kernel patch:
https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.huang@intel.com/

Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/arm/virt-acpi-build.c |  1 +
 hw/arm/virt.c            | 12 +++++++++++-
 include/hw/arm/virt.h    |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index ff3b7a794b84..2b63008df01d 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1066,6 +1066,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     }
 
     acpi_dsdt_add_power_button(scope);
+    aml_append(scope, aml_error_device());
 #ifdef CONFIG_TPM
     acpi_dsdt_add_tpm(scope, vms);
 #endif
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 02209fadcfac..6960f6113fef 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -693,7 +693,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
     MachineState *ms = MACHINE(vms);
     SysBusDevice *sbdev;
     int irq = vms->irqmap[VIRT_ACPI_GED];
-    uint32_t event = ACPI_GED_PWR_DOWN_EVT;
+    uint32_t event = ACPI_GED_PWR_DOWN_EVT | ACPI_GED_ERROR_EVT;
     bool acpi_pcihp;
 
     if (ms->ram_slots) {
@@ -1050,6 +1050,13 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
     }
 }
 
+static void virt_generic_error_req(Notifier *n, void *opaque)
+{
+    VirtMachineState *s = container_of(n, VirtMachineState, generic_error_notifier);
+
+    acpi_send_event(s->acpi_dev, ACPI_GENERIC_ERROR);
+}
+
 static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
                              uint32_t phandle)
 {
@@ -2500,6 +2507,9 @@ static void machvirt_init(MachineState *machine)
 
     if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
         vms->acpi_dev = create_acpi_ged(vms);
+        vms->generic_error_notifier.notify = virt_generic_error_req;
+        notifier_list_add(&acpi_generic_error_notifiers,
+                          &vms->generic_error_notifier);
     } else {
         create_gpio_devices(vms, VIRT_GPIO, sysmem);
     }
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index ea2cff05b02f..e14ea0f9d42a 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -174,6 +174,7 @@ struct VirtMachineState {
     DeviceState *gic;
     DeviceState *acpi_dev;
     Notifier powerdown_notifier;
+    Notifier generic_error_notifier;
     PCIBus *bus;
     char *oem_id;
     char *oem_table_id;
-- 
2.51.0


