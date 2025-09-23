Return-Path: <linux-kernel+bounces-828474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237C8B94ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89EA718897A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C03112AB;
	Tue, 23 Sep 2025 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElXQVf6x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE3C30FC02
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611060; cv=none; b=h/dWlR0aSLH3Vcor0w5bGjU+AZEaZADqXqrxRmPfuhQyIIh4Mn5l/JtfY+LMLoF99ooZxFzke5QRkwqF7PTkz5iHwkYN2yFxneJjMw4zqjv7R7jwFQ7Jh7YMMK/5AnVsJVMY/cwXXNWlAr1LN4O1VDLgV7YKfnoPHH8ztgrtu2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611060; c=relaxed/simple;
	bh=IcJJp5xPR5nte8FFlf6/ZvB0o7KifNbuksj0OAyRaaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRC7xVoBy57n0NJTDF65Fgh3SS/4PKShgh0a3BA+T6BB8OepacY1ySCowfnCuNBonjD+Af9PTlPzx8oNp98Yxr99a+egAtGNHAw+uf8jW5oejs+2jII/eE4bv3ulxdk+m4fCXDq5uzkxfLFBEInhAt8laa/HV5LhCcQFF0XPty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElXQVf6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40008C19422;
	Tue, 23 Sep 2025 07:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758611060;
	bh=IcJJp5xPR5nte8FFlf6/ZvB0o7KifNbuksj0OAyRaaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ElXQVf6xGZqTUWWdCndF8Y959eqSP8HOjrOo5VSMyX+Yf3l1TBfYV9QHb5lDaCAmF
	 MQrK4GFizcrdrxqk693b8E+AIKbMpv/knMWpvmC6IlvHDu+zwoQFpt3ruND6TyH73P
	 rsI95I3MhwhoGZr39BV0Gl9g8mDGM0JmDoM+8sCNyGNS7XFmcqp1+QxSEih1Ycsvz7
	 iRlCSHDNB6FrwjUS4ykWCmOb7lknIOyOFuY9fl7CvoShF1nE1kftrM0zKc7WvjABBj
	 +TWuAhKDZdNkJBQSJieVhrlxXWCujMNu3E0KLaZ1nS27tcyL8Axb2Gik8z/KDT+eOi
	 RE5OWUQfX1+QQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v0x4U-00000006bKq-1dEy;
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 08/17] acpi/generic_event_device: Update GHES migration to cover hest addr
Date: Tue, 23 Sep 2025 09:04:02 +0200
Message-ID: <ede7ddf4b10f34094a4327dc458d630ad319bd1c.1758610789.git.mchehab+huawei@kernel.org>
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

The GHES migration logic should now support HEST table location too.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/generic_event_device.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 95682b79a2df..55998303c22f 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -436,6 +436,34 @@ static const VMStateDescription vmstate_pcihp_state = {
     }
 };
 
+static const VMStateDescription vmstate_hest = {
+    .name = "acpi-hest",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(hest_addr_le, AcpiGhesState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static bool hest_needed(void *opaque)
+{
+    AcpiGedState *s = opaque;
+    return s->ghes_state.hest_addr_le;
+}
+
+static const VMStateDescription vmstate_hest_state = {
+    .name = "acpi-ged/hest",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = hest_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
+                       vmstate_hest, AcpiGhesState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_acpi_ged = {
     .name = "acpi-ged",
     .version_id = 1,
@@ -449,6 +477,7 @@ static const VMStateDescription vmstate_acpi_ged = {
         &vmstate_cpuhp_state,
         &vmstate_ghes_state,
         &vmstate_pcihp_state,
+        &vmstate_hest_state,
         NULL
     }
 };
-- 
2.51.0


