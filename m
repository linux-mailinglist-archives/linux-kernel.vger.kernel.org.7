Return-Path: <linux-kernel+bounces-758047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDEFB1CA39
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBE218C4853
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603B829B204;
	Wed,  6 Aug 2025 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgViXboK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499AC27FB1B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754499811; cv=none; b=UoTiqBnTArjRWB6L9Ho/+U6xHjjYEY05S9SkwbEiyqkNNgBGbsiCtjefLhMVWGi70nitrYxnWMfTNLARrnWYwxQ6u5a6BjFr2ZXRbxkKJNc42zI96l/FMsHrHTCsrNAUyfa+wyEGXMeBIOJp5C8t821Qjickw9GKwHvCB2QANtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754499811; c=relaxed/simple;
	bh=vdcd5YalhwXfabTe89vnmf/6PjoRuQzUY38aCn303vI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PKBXouLvw6hACovtONgLdMhdR/qcN33cfJQrSPkuXlYK1wXRmDyZlWHNf9SWYIL7o/Krxr2++Kt1Zj/hvuZK03VQlf6W9hdC6alY83t4Ni6sv5syjXs0BO4c/b0Fd/xsO9i8BIFlH3+FJoBy/l7JWE0Utm9Ay8uFr/nAghLw0oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VgViXboK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754499809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b10VcHJdtGe6RLfFmaHbkOGwrL+Hpk9E2OZqBdENHnM=;
	b=VgViXboKdiqE1+AcJTgF5Fafejsz6u1sATQGs2TY6QkumIjH1BehhgAnkpi8nAYToGHxGQ
	D2F+NkKp5TxFido+9U/eARtKlHmdwPjwg/foWpfemxPJpJ4cuES3YJP+cIMOj+WAx2eX+J
	f3UOV3wHO5rc/j2zCjuDGy5zLLB+UD8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-662dq8N0Mp2KuUy0rZN1HA-1; Wed,
 06 Aug 2025 13:03:25 -0400
X-MC-Unique: 662dq8N0Mp2KuUy0rZN1HA-1
X-Mimecast-MFC-AGG-ID: 662dq8N0Mp2KuUy0rZN1HA_1754499804
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C18D5180035F;
	Wed,  6 Aug 2025 17:03:24 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.66.8])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F54C1800282;
	Wed,  6 Aug 2025 17:03:23 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com,
	kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	eric.auger@redhat.com,
	clg@redhat.com
Subject: [PATCH 0/2] vfio: Deprecate fsl-mc, platform, and amba
Date: Wed,  6 Aug 2025 11:03:10 -0600
Message-ID: <20250806170314.3768750-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The vfio-fsl-mc driver has been orphaned since April 2024 after the
maintainer became unresponsive.  More than a year later, the driver
has only received community maintenance.  Let's take the next step
towards removal by marking it obsolete/deprecated.

The vfio-platform and vfio-amba drivers have an active maintainer,
but even the maintainer has no ability to test these drivers anymore.
The hardware itself has become obsolete and despite Eric's efforts to
add support for new devices and presenting on the complexities of
trying to manage and support shared resources at KVM Forum 2024, the
state of the driver and ability to test it upstream has not advanced.
The experiment has been useful, but seems to be reaching a conclusion.
QEMU intends to remove vfio-platform support in the 10.2 release.
Mark these drivers as obsolete/deprecated in the kernel as well.

Thanks,
Alex

Alex Williamson (2):
  vfio/fsl-mc: Mark for removal
  vfio/platform: Mark for removal

 MAINTAINERS                           |  4 ++--
 drivers/vfio/fsl-mc/Kconfig           |  5 ++++-
 drivers/vfio/fsl-mc/vfio_fsl_mc.c     |  2 ++
 drivers/vfio/platform/Kconfig         | 10 ++++++++--
 drivers/vfio/platform/reset/Kconfig   |  6 +++---
 drivers/vfio/platform/vfio_amba.c     |  2 ++
 drivers/vfio/platform/vfio_platform.c |  2 ++
 7 files changed, 23 insertions(+), 8 deletions(-)

-- 
2.50.1


