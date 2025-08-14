Return-Path: <linux-kernel+bounces-769039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3380DB2698A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B41E1CE740F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3447DA6D;
	Thu, 14 Aug 2025 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4JrZJz7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A9F19D071
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181097; cv=none; b=ibMFX8GRls368sCf/ZR7YcXytelUYAYZaQmUTbiZQi+7jZuxum+5GpvgMfbNFNicA9X0WTsYDKfjnxWXvjVZp7YWlztThFBNX1GpksvT3I8ka00DClumQsXQmjS45K+87+e8gE4z6Qqdfc79E5h7NHROC/3LIrKNLHn1OgyNbU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181097; c=relaxed/simple;
	bh=fzicJF7q4dLRrPHjJsfFWmWacz7FUNgbf3Z1XpBzzQE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=R1fGNnkauHpIPRjRYa3J2G1fBSj9PCZ4/Pr/hS20HpyDA17vAmsBrvYH/hQM6/E6T1vwvyyB3MOF26O7KWP8j6ZogLSgM4R2o7KFo6Ren331EYSMtjCOw9hgy23qGC70uZuOVZEvZfv6Lu7asUQv3vm67f6QRTR0LoHg4MSfLkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4JrZJz7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755181094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bNKOtXjUgCmr7vZC9Pfp3UyUNOWyPhcYtzWE4DBiIqI=;
	b=a4JrZJz7kvvsXcVJiF/fmJG+7DX1EWWK+1kRq4JXIY4RkzHJcFW37a//GB6U/HeW/g9XXi
	7ZReM41T/f9RQqos3VjL3CbZ+SPHafYuAxFh9nF8r7XHolmhJTQgGK1TgBqHzIknjbLlus
	3RZlZRMCeCKmePT4DwcjxefhMe7cWIo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-ftt7xQQsN2aAGreQBuMtOA-1; Thu,
 14 Aug 2025 10:18:08 -0400
X-MC-Unique: ftt7xQQsN2aAGreQBuMtOA-1
X-Mimecast-MFC-AGG-ID: ftt7xQQsN2aAGreQBuMtOA_1755181086
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15590180034F;
	Thu, 14 Aug 2025 14:18:06 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.86])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 98D7D19327C0;
	Thu, 14 Aug 2025 14:18:01 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com,
	eric.auger@redhat.com,
	robin.murphy@arm.com,
	rafael@kernel.org,
	bhelgaas@google.com,
	jgg@ziepe.ca,
	lpieralisi@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lenb@kernel.org,
	jean-philippe@linaro.org,
	jsnitsel@redhat.com
Subject: [RFC] iommu: Fix virtio-iommu probing
Date: Thu, 14 Aug 2025 16:17:58 +0200
Message-ID: <20250814141758.2140641-1-eric.auger@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
probe path") broke virtio-iommu probing and no iommu group are
produced anymore.

When probe_iommu_group() gets called viommu_probe_device() fails
because viommu_get_by_fwnode(fwspec->iommu_fwnode) returns NULL.
So it seems we need to restore the original iommu_probe_device
call site in acpi_iommu_configure_id() to get a chance to probe
the device again.

Maybe this defeats the whole purpose of the original commit but
at least it fixes the virtio-iommu probing.

Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Cc: stable@vger.kernel.org # v6.15+
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

I also tested smmu probing and this seems to work fine.
---
 drivers/acpi/scan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb1fe9f3b1a3..9f4efa8f75a6 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1632,6 +1632,13 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 		err = viot_iommu_configure(dev);
 	mutex_unlock(&iommu_probe_device_lock);
 
+	/*
+	 * If we have reason to believe the IOMMU driver missed the initial
+	 * iommu_probe_device() call for dev, replay it to get things in order.
+	 */
+	if (!err && dev->bus)
+		err = iommu_probe_device(dev);
+
 	return err;
 }
 
-- 
2.49.0


