Return-Path: <linux-kernel+bounces-828485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F43B94AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47F73A62E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62D6314A74;
	Tue, 23 Sep 2025 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmYsFq69"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80253101B5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611060; cv=none; b=gaTzl8wqwb9xQ5eOYpbK+wxA8iVVbpBsLTLKDSD1g/o9BJppRYmlRbfusLnATyMV/B9/jnOxnm5+p1qP8rkqaeljQz5w6GRfYCwN2ftylnc8qDkR+yYNZvI0C7ykl89108Td9grw/xvlkMZxghb8wOZ/CmC0QXerESoYRz/AUqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611060; c=relaxed/simple;
	bh=cEEEEJHzEJ8o3Lb3soWpv/d/TI1qGjWD1WNIHqkcvX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1rg1G4mE+2Fl6OohMwB/5hvdoqiNKkFpzqf6wLbhkTVVDS6/SuUphXfWfLLb4g3wFxjz327SxGhH+8iRZf8DHFjFwdqF+EgmUnoVoY1UwYJ8huOOh09Rj/Z+5W7A6H3G0jt5emMBxRlis0m44MFCM6rBhiNyHwjY0hx3nxKIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmYsFq69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9B4C4AF0C;
	Tue, 23 Sep 2025 07:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758611060;
	bh=cEEEEJHzEJ8o3Lb3soWpv/d/TI1qGjWD1WNIHqkcvX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WmYsFq69EmvOZOQx5vgfFH+NWs52sqjHWMULIPuZ3JTmPh0gRTCxGOJjo/pK1Gxvc
	 HEAnrFRbw5qGgAHyDJkKXHOBSmdUY5EBewdlFkRDn2Baw38MJFhny2CGsFRumip6be
	 vuMTNSUBGqE4YAwrd2IlZmsOYwibFVxPZWu136Xma4VUQhFrXBNpxcN9zFQEbWVZWn
	 7d+FzUhdMCq03CkAhKvJKy5dNheuJjpD3ahkt+yp/gxwsCwgrD0F6gHAlZ2npnhDWG
	 2lK4UBpmES982Cby8ZcZLlnweOvHOV5jPJRxK04uOInbZgJbDa4tEkGWGbhARCaToT
	 n5Apbxm/KbPOw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v0x4U-00000006bLM-2Zkq;
	Tue, 23 Sep 2025 09:04:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 16/17] docs: hest: add new "etc/acpi_table_hest_addr" and update workflow
Date: Tue, 23 Sep 2025 09:04:10 +0200
Message-ID: <e3e8bd92ce40d997c67ac1d4d973c0041b8f59fc.1758610789.git.mchehab+huawei@kernel.org>
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

While the HEST layout didn't change, there are some internal
changes related to how offsets are calculated and how memory error
events are triggered.

Update specs to reflect such changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 docs/specs/acpi_hest_ghes.rst | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
index c3e9f8d9a702..aaf7b1ad11a5 100644
--- a/docs/specs/acpi_hest_ghes.rst
+++ b/docs/specs/acpi_hest_ghes.rst
@@ -89,12 +89,21 @@ Design Details
     addresses in the "error_block_address" fields with a pointer to the
     respective "Error Status Data Block" in the "etc/hardware_errors" blob.
 
-(8) QEMU defines a third and write-only fw_cfg blob which is called
-    "etc/hardware_errors_addr". Through that blob, the firmware can send back
-    the guest-side allocation addresses to QEMU. The "etc/hardware_errors_addr"
-    blob contains a 8-byte entry. QEMU generates a single WRITE_POINTER command
-    for the firmware. The firmware will write back the start address of
-    "etc/hardware_errors" blob to the fw_cfg file "etc/hardware_errors_addr".
+(8) QEMU defines a third and write-only fw_cfg blob to store the location
+    where the error block offsets, read ack registers and CPER records are
+    stored.
+
+    Up to QEMU 9.2, the location was at "etc/hardware_errors_addr", and
+    contains a GPA for the beginning of "etc/hardware_errors".
+
+    Newer versions place the location at "etc/acpi_table_hest_addr",
+    pointing to the GPA of the HEST table.
+
+    Using above mentioned 'fw_cfg' files, the firmware can send back the
+    guest-side allocation addresses to QEMU. They contain a 8-byte entry.
+    QEMU generates a single WRITE_POINTER command for the firmware. The
+    firmware will write back the start address of either "etc/hardware_errors"
+    or HEST table at the corresponding fw_cfg file.
 
 (9) When QEMU gets a SIGBUS from the kernel, QEMU writes CPER into corresponding
     "Error Status Data Block", guest memory, and then injects platform specific
@@ -105,8 +114,5 @@ Design Details
      kernel, on receiving notification, guest APEI driver could read the CPER error
      and take appropriate action.
 
-(11) kvm_arch_on_sigbus_vcpu() uses source_id as index in "etc/hardware_errors" to
-     find out "Error Status Data Block" entry corresponding to error source. So supported
-     source_id values should be assigned here and not be changed afterwards to make sure
-     that guest will write error into expected "Error Status Data Block" even if guest was
-     migrated to a newer QEMU.
+(11) kvm_arch_on_sigbus_vcpu() reports RAS errors via a SEA notifications,
+     when a SIGBUS event is triggered.
-- 
2.51.0


