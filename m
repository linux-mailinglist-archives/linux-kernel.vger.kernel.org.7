Return-Path: <linux-kernel+bounces-758048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15B9B1CA3A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D82917ACEB0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC44F29B8D8;
	Wed,  6 Aug 2025 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ca5KU71G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAEB296148
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754499812; cv=none; b=imaeE53s0hhtHS0csk6IHRYFLe0SDsSrBG9wrnCeWEUGC7YRB8vU7Oe0Fwn7Lh7YMbTBbc8PK0hMvt7TL2DcIPuG1/eP50fFR7g4s1H91+dkwtU3aFiCfM8hlecT6979kBw98InQbuVtAHu19eQvlubftjPPDk94lcBb3JPz3n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754499812; c=relaxed/simple;
	bh=R9E2CXDi0Ci1uMDw2pUbtnv9Gjct9iSM/Rkm4hV2jXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiUkie0WJifd8EFMBOVGUExGTDgpktzWXd8BXEqUqImXPi+Y0T2G10hS/xuddHdiJid9tvco05HBXeeAo2Oa9r1farx/V1abIgVCvdZkDhvvJgBS3I+VfrsQ9VlXVztI4x9xvZf/hhvtadteyxiz3IiUQsZH+jXQXCYyhaUY2e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ca5KU71G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754499809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOB1iUxGdN/YU3HdC/MxEaPJYHZj91g8Oi9O0xUCn9c=;
	b=Ca5KU71GJ+1tYgiJ+X/8HP33v0R8Lpeav66ZNP56z3/glci6CRZ/FrLng+UYS93JRvX0TS
	m5Jfa4N+OAOTYrw8+9ZRKOzDskjn2wLWY5pZuyRvoGyAbFuZjU3tzG8BHTxGzPPfc2QoKH
	EbmeRKTYa103zwbbucVoZ5IRoyxaIo8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-Ep4MHr24Nci2mqbrnOwGsA-1; Wed,
 06 Aug 2025 13:03:27 -0400
X-MC-Unique: Ep4MHr24Nci2mqbrnOwGsA-1
X-Mimecast-MFC-AGG-ID: Ep4MHr24Nci2mqbrnOwGsA_1754499806
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 546091800446;
	Wed,  6 Aug 2025 17:03:26 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.66.8])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22DBE180035C;
	Wed,  6 Aug 2025 17:03:24 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com,
	kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	eric.auger@redhat.com,
	clg@redhat.com
Subject: [PATCH 1/2] vfio/fsl-mc: Mark for removal
Date: Wed,  6 Aug 2025 11:03:11 -0600
Message-ID: <20250806170314.3768750-2-alex.williamson@redhat.com>
In-Reply-To: <20250806170314.3768750-1-alex.williamson@redhat.com>
References: <20250806170314.3768750-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The driver has been orphaned for more than a year, mark it for removal.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 MAINTAINERS                       | 2 +-
 drivers/vfio/fsl-mc/Kconfig       | 5 ++++-
 drivers/vfio/fsl-mc/vfio_fsl_mc.c | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0b444e5fd5a..25a520467dec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26033,7 +26033,7 @@ F:	include/uapi/linux/vfio.h
 
 VFIO FSL-MC DRIVER
 L:	kvm@vger.kernel.org
-S:	Orphan
+S:	Obsolete
 F:	drivers/vfio/fsl-mc/
 
 VFIO HISILICON PCI DRIVER
diff --git a/drivers/vfio/fsl-mc/Kconfig b/drivers/vfio/fsl-mc/Kconfig
index 7d1d690348f0..43c145d17971 100644
--- a/drivers/vfio/fsl-mc/Kconfig
+++ b/drivers/vfio/fsl-mc/Kconfig
@@ -2,9 +2,12 @@ menu "VFIO support for FSL_MC bus devices"
 	depends on FSL_MC_BUS
 
 config VFIO_FSL_MC
-	tristate "VFIO support for QorIQ DPAA2 fsl-mc bus devices"
+	tristate "VFIO support for QorIQ DPAA2 fsl-mc bus devices (DEPRECATED)"
 	select EVENTFD
 	help
+	  The vfio-fsl-mc driver is deprecated and will be removed in a
+	  future kernel release.
+
 	  Driver to enable support for the VFIO QorIQ DPAA2 fsl-mc
 	  (Management Complex) devices. This is required to passthrough
 	  fsl-mc bus devices using the VFIO framework.
diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
index f65d91c01f2e..76ccbab0e3d6 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
@@ -537,6 +537,8 @@ static int vfio_fsl_mc_probe(struct fsl_mc_device *mc_dev)
 	struct device *dev = &mc_dev->dev;
 	int ret;
 
+	dev_err_once(dev, "DEPRECATION: vfio-fsl-mc is deprecated and will be removed in a future kernel release\n");
+
 	vdev = vfio_alloc_device(vfio_fsl_mc_device, vdev, dev,
 				 &vfio_fsl_mc_ops);
 	if (IS_ERR(vdev))
-- 
2.50.1


