Return-Path: <linux-kernel+bounces-869437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AEFC07E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E76A504AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD55227E05F;
	Fri, 24 Oct 2025 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c5qzPTWL"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA63B15E8B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333451; cv=none; b=RRs9OVjJDsOcwEHBVl+7C9fFSOGtYO0a5ma/YW/COsb/SgBLurIc6j3cT0GFjSMZf9fUPKYB8i/yICDsylilkTpAhuqHcZ90qAvbnwWxpPYUawI0YS3TQmAnXSNT1n8G0kKoazbjfjfomazjJ1eYhha/b2WQnc9oSgbaTgQpOrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333451; c=relaxed/simple;
	bh=9azi96wBOJ6vXSjdzcfToJLMXg52vQx/W6W0iwJWqYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GCaw8tpJ1vWVF7siKo8z2nHzBuhM5aOR3Fse8puA2lbrXLEA3uW9JriXtaqGjX5aoEGVr/SCiaWmZfxcedaVZQE5wri1B/oSRxVoqb+SQ+Q5+lk1Wh8s6O2pQ7sx8feJ9dxIeSyfGBL/MVsz2nT9G1NIk4Q3kLE1w7Kxwz/N2P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c5qzPTWL; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761333446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ANhWe0qYmdKcTZKvGQIIz2zwd1hYT8FYOTKZM81v5zg=;
	b=c5qzPTWLkI5BS8Q9Bxza059jRaigNP0KvcgfSEQz7jCHxGdxyrLpK/C7Z9ApfId+cminFW
	KruiW/u5a4HLo/OfAiaBZ2rN07GHVyznZGXtqnTtvejQ9b0ljIzToxbxRmJkoAL04amwNR
	vkU+iLtPQpZKydeJQBOkXv78wFbq7eY=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Hyun Kwon <hyun.kwon@xilinx.com>,
	Simona Vetter <simona@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 0/3] drm: zynqmp_dp: Retrain link after HPD if necessary
Date: Fri, 24 Oct 2025 15:17:04 -0400
Message-Id: <20251024191707.2310589-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

I noticed that after reconnecting a mini-displayport cable, the sink
would not display an image. But if I forced the link to re-train, the
image would come back.

Some digging revealed that the DP spec requires retraining after a HPD
event if the sink syas the link has gone down. So implement that since
it fixes my problem and it's required by spec.


Sean Anderson (3):
  drm: zynqmp_dp: Update connector state before AUX transfers
  drm: zynqmp_dp: Use smp_load/store for status
  drm: zynqmp_dp: Retrain link after HPD if necessary

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 43 +++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 17 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


