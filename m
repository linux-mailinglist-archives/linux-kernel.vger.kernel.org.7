Return-Path: <linux-kernel+bounces-879123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18B4C22543
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2431AA2574
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73718329E7E;
	Thu, 30 Oct 2025 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lYoe02Gx"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E70D34D3AA
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761856628; cv=none; b=HJUP1lw+fL/Kjw3jDDbiqVu8890mS+AprTDznVyKnmQsjj91pva3c0odIfeBUl7ugUsh56G2vjVdHdMc4Z4MmMH4A1HDL3OSMJjFnI9fwQnlpmeLU/+BMPzzwwBYMW8vHUNfb0g3KFZxPb+FjgzVdPaaYMdSq23Mg1Pvxu/SdNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761856628; c=relaxed/simple;
	bh=WlVHMNsUypU1FXTI7RJeWUXKT9Vfcs+P0uVyWt1bTR0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PZ6HKjz4D3o56AxJcL3KwV2lADnLv8WIgzmtDQOC6w46cAbE1TKnM++gsbvZ+EBoRWVs51vcZT5dY3lKVD5nkbvh/U5Wn3D0EmPmbJqhR3PTtyKWioKTO9Y6yLwX5aHP5lY1iTh9FpzW/28NVrAIq+IUwQ8e8O8gunCLWJau0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lYoe02Gx; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761856622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X2UTRuI3d+ah0NP1XnZBknA6KIGKxvLTX6zevUgVI7o=;
	b=lYoe02GxRGNGJ19ONWrtYqOOLcS7beZe5agFjJVoqFaKa8kZHHGpUuoiOFpbfeCs4gaBiy
	9Q3mYgFZo4OjjIZQnLeyvMN8cGB9ZaWukPIfqF6H2LWYVr0cviIDsMx8hFv2/wOw/89aE7
	qwGu2aMbySGTZxCIiLnWnDzyNbsSXAE=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Simona Vetter <simona@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2 0/3] drm: zynqmp_dp: Retrain link after HPD if necessary
Date: Thu, 30 Oct 2025 16:36:39 -0400
Message-Id: <20251030203642.3076656-1-sean.anderson@linux.dev>
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

Changes in v2:
- needs_retain -> needs_retrain
- Actually retrain the loop (accidentally removed while rebasing)

Sean Anderson (3):
  drm: zynqmp_dp: Update connector state before AUX transfers
  drm: zynqmp_dp: Use smp_load/store for status
  drm: zynqmp_dp: Retrain link after HPD if necessary

 drivers/gpu/drm/xlnx/zynqmp_dp.c | 44 ++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 17 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


