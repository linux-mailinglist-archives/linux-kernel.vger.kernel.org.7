Return-Path: <linux-kernel+bounces-726866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B95B0122F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90115463E0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B535119644B;
	Fri, 11 Jul 2025 04:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNc2WbMa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670A717741
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208353; cv=none; b=SC7MIrmuhWS450hOg7O3kFdYtDyc4S7bfsvN2pIN35j/tu3vmHg37nTwP/4LYdfA2V8csf0iBYC8qmMEUFcLMiO4VvG6jVdothHFYit1cShG5e0Z1ja+NX1pCZsxdBdB69WFLR+zPOSjhV+puzgHWIRYJ7/85EYEDIKkr4XRxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208353; c=relaxed/simple;
	bh=eUIWk726v+M/KGMh85jwLqDMcIQEgBCGm+2tVRYQnXk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ae3FJUkPZ7RVCo+tgav5IdjI9C9ZroRKFDO/DYmGb3Btm7ioE7ry+RV8zKG1GfOnBFWtWrmoGFkqRhtufRdhI89Q+yJWq6WFSomicsjDhPjtkXsuo5G8qWoLX0xFRrWQVb+OpIEssDL33DyVEz9EzEvTIiauoMBf63Vg/k2xNEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNc2WbMa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752208350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kGKnKSqmFoncY/VFaVr1B/bk0NjVO6YxCz0oeOIIZx8=;
	b=ZNc2WbMa3TEbcJglitKjl7AziIHYoOwNJXk3hRaDw8LBGF+e9XMgGoZ7nr2e8CfA2BdEdU
	R9e2s9IUZjkWuyfl99+uNOPcKq7ThEvrCvZFv7v05eRPm13EzK6GQgXFLhs0q6l4gqwZWD
	+unpUEfMI/9snSXZYGSXq4iXqZGpm/M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-FZv3N2m2OGGFD-R7qLVXFQ-1; Fri,
 11 Jul 2025 00:32:27 -0400
X-MC-Unique: FZv3N2m2OGGFD-R7qLVXFQ-1
X-Mimecast-MFC-AGG-ID: FZv3N2m2OGGFD-R7qLVXFQ_1752208345
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 358F0180028A;
	Fri, 11 Jul 2025 04:32:24 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.240])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36B09180045B;
	Fri, 11 Jul 2025 04:32:20 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Subject: [PATCH 00/14] drm/panel: Use refcounted allocation in place of
 devm_kzalloc() - Part5
Date: Thu, 10 Jul 2025 23:31:11 -0500
Message-Id: <20250710-b4-driver-convert-last-part-july-v1-0-de73ba81b2f5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI+TcGgC/x2NSwqDQBAFryK9TsOMHyS5SshiPq12kFF6RjGId
 0/jql5tXp2QSZgyvKoThHbOvCQV+6ggTC6NhBzVoTZ1Z3pr0LcYhXcSDEtSFJxdLrg6Xd9t/mH
 TRv+0wcehd6A3q9DAx514f67rD3XOxZNyAAAA
X-Change-ID: 20250710-b4-driver-convert-last-part-july-34db91cbdf7a
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Jerry Han <hanxu5@huaqin.corp-partner.google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752208280; l=3615;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=eUIWk726v+M/KGMh85jwLqDMcIQEgBCGm+2tVRYQnXk=;
 b=38hQRfOGGclA6FW/2g7fnz6dS/hrEhjEqLJ5nfziKuWZ+hF78CDy8AHl2TB1AX9xo1yYtpkxS
 E8b6jlrsVTRDW1sLUxzIZTEJ2I/ba8+5trZNni9jAIFtag14iF24/kY
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Use the new API devm_drm_panel_alloc() for panel allocations.
A major chunk of driver conversion was sent in a 3 part series
which is already merged. The coccinelle patch that was used to
identify unsafe panel allocations didnt flag about 20 drivers.

Not using any semantic patch for the remaining drivers.
This series does the conversion by not passing explicit type
to the helper and maintaining type safety suggested by Geert.

Link to part 1, 2 and 3 of driver conversion:
https://patchwork.freedesktop.org/series/147082/
https://patchwork.freedesktop.org/series/147157/
https://patchwork.freedesktop.org/series/147246/

Link to part 4 that incorporates type safety:
https://patchwork.freedesktop.org/series/151355/

Geert's suggestion
https://lore.kernel.org/dri-devel/CAN9Xe3TXZa1nrCLkHadiBkOO=q1ue8Jwc3V13pXcbAc9AFS2-Q@mail.gmail.com/

This is the final set of drivers.

A total of 86 drivers covered in part 1, 2 and 3 are converted
by passing explicit type and is not type safe. Changes to those
will be addressed in the upcoming series.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
Anusha Srivatsa (14):
      drm/panel/lq101r1sx01:  Use refcounted allocation in place of devm_kzalloc()
      drm/panel/raspberrypi: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/vvx10f034n00: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/osd101t2587-53ts: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/novatek-nt36672a: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/lg-sw43408: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/kd097d04: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/khadas-ts050: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/jdi-lt070me05000: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/lpm102a188a: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/ilitek-ili9882t: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/himax-hx83102: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/boe-tv101wum-nl6: Use refcounted allocation in place of devm_kzalloc()
      drm/panel/boe-himax8279d: Use refcounted allocation in place of devm_kzalloc()

 drivers/gpu/drm/panel/panel-boe-himax8279d.c          | 11 +++++------
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c        | 10 +++++-----
 drivers/gpu/drm/panel/panel-himax-hx83102.c           | 10 +++++-----
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c         | 10 +++++-----
 drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c         | 12 ++++++------
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c        | 11 +++++------
 drivers/gpu/drm/panel/panel-khadas-ts050.c            | 13 ++++++-------
 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c    | 12 ++++++------
 drivers/gpu/drm/panel/panel-lg-sw43408.c              | 10 +++++-----
 drivers/gpu/drm/panel/panel-novatek-nt36672a.c        | 10 +++++-----
 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c    | 12 ++++++------
 drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c  | 12 ++++++------
 drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 12 ++++++------
 drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c       | 11 +++++------
 14 files changed, 76 insertions(+), 80 deletions(-)
---
base-commit: bead8800222768dab1a421206350d530b0c45254
change-id: 20250710-b4-driver-convert-last-part-july-34db91cbdf7a

Best regards,
-- 
Anusha Srivatsa <asrivats@redhat.com>


