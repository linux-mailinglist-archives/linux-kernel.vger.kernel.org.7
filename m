Return-Path: <linux-kernel+bounces-722348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B05C2AFD878
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDA41AA7FAA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F2323D2BB;
	Tue,  8 Jul 2025 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzeawnEp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5740123AB9D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006989; cv=none; b=cE16cOZFej6GgY0zmI6IUGPltB6jNaleoP129zVhPtTH8wl8v8GDr//eXbYIvtQ+YbiWCpPcYHB+q4ZXcJMVFV1POcYP68CVsHGGZEAft3T0rcA3glpICCMnOBhtJO2SuyetjD0QV68wUxHOgN33hF2l0w6iiQ3b013j1MTRFSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006989; c=relaxed/simple;
	bh=ye8liTiYgzGO7x6UHhS9H869YttY6nt3eS7umiedAes=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BTay67Q/g+OcF2iSwkWcmEdUtuAecOdjh590+XH34HowxOh7mobUaB90L0tEI9/K7cKU5ZLnQdW7XRQ/l5EnuJfKaWv86BB/Pj4m14JiUwyW9QqbgDxXb4QFJnG++e7RRGx70/PvGmSCjcggt1n+q2WQ1+IiYk/fL2yviS7C2Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dzeawnEp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752006986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aPQIW6AVsdIyzf3QyXYN0rJl2U1an9vOm+sVCLf9NSQ=;
	b=dzeawnEpKNN4BIVt+Dh+TrOy7Cqm26LbnNhrrM2P6uP6xme2xUC5t6FHbHrBPSKpYQ/3fy
	RzEri99WBqzL2bcPar/YcMFFxK4kIi9Xb88qzkid1j7cL699tdwYXrmURyNcu0Y2IjiIzh
	O6QYZPRCFPk1Fyhjl1OszpCEC/HiHdM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-vINcWXa4PWiIpOodOZ-jxQ-1; Tue,
 08 Jul 2025 16:36:23 -0400
X-MC-Unique: vINcWXa4PWiIpOodOZ-jxQ-1
X-Mimecast-MFC-AGG-ID: vINcWXa4PWiIpOodOZ-jxQ_1752006981
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DCA318089B6;
	Tue,  8 Jul 2025 20:36:21 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.132])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73C7F1956087;
	Tue,  8 Jul 2025 20:36:18 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Subject: [PATCH 0/6] drm/panel: Use refcounted allocation in place of
 devm_kzalloc() - Part4
Date: Tue, 08 Jul 2025 15:35:12 -0500
Message-Id: <20250708-b4-simple-panel-api-convert-july-v1-0-630902123ea1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAACBbWgC/x3NQQqDMBBG4avIrDsQQ4viVUoXk/S3HUljSFQs4
 t0buvw27x1UkBWFhuagjE2LzrGivTTk3xJfYH1WkzX2ZjrTsbty0U8K4CQRgSUp+zluyAtPa/i
 yiG9Hh94621PNpIxR9//i/jjPH6HggOZyAAAA
X-Change-ID: 20250707-b4-simple-panel-api-convert-july-aac1fbe82b28
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752006919; l=2160;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=ye8liTiYgzGO7x6UHhS9H869YttY6nt3eS7umiedAes=;
 b=b55ELB70ugm4QSAoHETsJvHJkWj5KrpJH8E0FevWl6ly5MQDGCOI7+yskVNvVK2XK3mJF/OhU
 N/zOg2aRKL9C+6EIogxaZ+uZFItuUUSE47LL3G+kzKndB5OoY8Sk+5K
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Use the new API devm_drm_panel_alloc() for panel allocations.
A major chunk of driver conversion was sent in a 3 part series
which is already merged. The coccinelle patch that was used to
identify unsafe panel allocations didnt flag about 20 drivers.

Not using any semantic patch for the remaining drivers.
Apart from addressing a part of missing drivers, this series also
does the conversion by not passing explicit type to the helper and
maintaining type safety suggested by Geert.

Link to part 1, 2 and 3 of driver conversion:
https://patchwork.freedesktop.org/series/147082/
https://patchwork.freedesktop.org/series/147157/
https://patchwork.freedesktop.org/series/147246/

Geert's suggestion
https://lore.kernel.org/dri-devel/CAN9Xe3TXZa1nrCLkHadiBkOO=q1ue8Jwc3V13pXcbAc9AFS2-Q@mail.gmail.com/

14 more to go which will be sent once this series gets feedback.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
Anusha Srivatsa (6):
      drm/panel/visionox-g2647fb105: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/truly-nt35597: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/tdo-tl070wsh30: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/kd070fhfid015: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/ls043t1le01: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/samsung-s6e63m0: Use refcounted allocation in place of devm_kzalloc()

 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c       | 14 +++++++-------
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c     | 12 ++++++------
 drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c | 12 ++++++------
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c        | 13 ++++++-------
 drivers/gpu/drm/panel/panel-truly-nt35597.c         | 10 +++++-----
 drivers/gpu/drm/panel/panel-visionox-g2647fb105.c   | 10 +++++-----
 6 files changed, 35 insertions(+), 36 deletions(-)
---
base-commit: 482c7e296edc0f594e8869a789a40be53c49bd6a
change-id: 20250707-b4-simple-panel-api-convert-july-aac1fbe82b28

Best regards,
-- 
Anusha Srivatsa <asrivats@redhat.com>


