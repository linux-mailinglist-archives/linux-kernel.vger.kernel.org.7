Return-Path: <linux-kernel+bounces-861284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FE0BF2478
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 356964F5E69
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE57283151;
	Mon, 20 Oct 2025 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="diCbvMxy"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E5C283FCF
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976099; cv=none; b=sgU5gNOS4drByzYkHeLEtb2mFiUc7FeLdDuKoqM3g6AtCvwB5nDKaP3Q39B/49dzCTMkAd4nR+Y5CBipSMBe7D/DAGLw6cZP5ha3LfMiVn3EtpZ6FVV2elGB+3nGa3bJiseahifq9VdHovA1uypMQvV1Ch19PLwlolzj3SI7L2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976099; c=relaxed/simple;
	bh=lY512ww2GgxRIYZ3nYvRoncqZSBQoFPXtRikl+duERA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=hPfkIJq//AU4n3udEX/60VKsUqc2fAVgk6kAM0LvkR7HiwDScnfznzD+WHiB82mbN27U4sdc9TFpca+tgf5csy3YNjDVWlJjrAWlKRTJrvNkJIL34VJRo/Izjhe+AkocPiD6PzLTFSOFe02q3OdFUoIThw/UnfKvG/EnDlZasTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=diCbvMxy; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251020160135euoutp01a1ee36e7ad15d8e8a7aa21ff6f4f25b2~wPm29nWoA2236722367euoutp01T
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:01:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251020160135euoutp01a1ee36e7ad15d8e8a7aa21ff6f4f25b2~wPm29nWoA2236722367euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760976095;
	bh=Vz2ne046ZdvV+eht6cashAps0Hu4TwK9pfYylzXhh4I=;
	h=From:To:Cc:Subject:Date:References:From;
	b=diCbvMxyv6VHxaci38HRs6zoXY8d96RdjS2RPZsMICSvRkrneyUnNJQK/LZ/Uaw6L
	 xKhKEh8hsY4h4LpLmmaQp2FgwMXXjvAaQ23ZKKXp/q88v7+QlSN/0+UZVzpoTvouWD
	 rh/u5PEM7yXEQ2eTmgVRTObDe6WtX1W6+z/UzZLo=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251020160135eucas1p29eb8517e240f188f102e77713f85e29d~wPm2qtRxi1568615686eucas1p2V;
	Mon, 20 Oct 2025 16:01:35 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251020160134eusmtip28bdd46101f68866229b0150d21bad517~wPm2Mo_TP1636616366eusmtip2o;
	Mon, 20 Oct 2025 16:01:34 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa
	<tfiga@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Guennadi
	Liakhovetski <g.liakhovetski@gmx.de>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Hans Verkuil <hverkuil@kernel.org>,
	stable@vger.kernel.org, Shuangpeng Bai <SJB7183@psu.edu>
Subject: [PATCH v2] media: videobuf2: forbid remove_bufs when legacy fileio
 is active
Date: Mon, 20 Oct 2025 18:01:21 +0200
Message-Id: <20251020160121.1985354-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251020160135eucas1p29eb8517e240f188f102e77713f85e29d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251020160135eucas1p29eb8517e240f188f102e77713f85e29d
X-EPHeader: CA
X-CMS-RootMailID: 20251020160135eucas1p29eb8517e240f188f102e77713f85e29d
References: <CGME20251020160135eucas1p29eb8517e240f188f102e77713f85e29d@eucas1p2.samsung.com>

vb2_ioctl_remove_bufs() call manipulates queue internal buffer list,
potentially overwriting some pointers used by the legacy fileio access
mode. Add a vb2_verify_memory_type() check symmetrical to
vb2_ioctl_create_bufs() to forbid that ioctl when fileio is active to
protect internal queue state between subsequent read/write calls.

CC: stable@vger.kernel.org
Fixes: a3293a85381e ("media: v4l2: Add REMOVE_BUFS ioctl")
Reported-by: Shuangpeng Bai<SJB7183@psu.edu>
Suggested-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v2:
- dropped a change to vb2_ioctl_create_bufs(), as it is already handled
  by the vb2_verify_memory_type() call
- replaced queue->type check in vb2_ioctl_remove_bufs() by a call to
  vb2_verify_memory_type() which covers all cases

v1: https://lore.kernel.org/all/20251016111154.993949-1-m.szyprowski@samsung.com/
---
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index d911021c1bb0..0de7490292fe 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -1000,9 +1000,11 @@ int vb2_ioctl_remove_bufs(struct file *file, void *priv,
 			  struct v4l2_remove_buffers *d)
 {
 	struct video_device *vdev = video_devdata(file);
+	int res;
 
-	if (vdev->queue->type != d->type)
-		return -EINVAL;
+	res = vb2_verify_memory_type(vdev->queue, vdev->queue->memory, d->type);
+	if (res)
+		return res;
 
 	if (d->count == 0)
 		return 0;
-- 
2.34.1


