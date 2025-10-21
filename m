Return-Path: <linux-kernel+bounces-862989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC54BF6BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A69A541850
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2F1336EC5;
	Tue, 21 Oct 2025 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="R7UUFjUQ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681672F0C79
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053015; cv=none; b=gBCzUHcVgG6+QiZsxJNMmoVDVS4sjCEsHN4w7jCFaBqGBG2k17vNIdhUvSMaeqrgmjIMNI9pc3WdSw+CCxQY6L7sD3TmwwK7M3F1x/+t+MDdvJ8yjPGhCBPI2DD7FG8pPOHm7X2q//pNGsKlUWYOeK5XCyZq5X6+LiqyLQuHLaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053015; c=relaxed/simple;
	bh=Y9ZTONpm589+RojL1lzdfFuJkRYHnz4HWW2urQfAi4Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MIgkdkdJ1klxL7kINxfFF3tX3cUAG+OmxtFBxYTJ8dKlI7/mPb9z1TnByPJyamnQyYFk4K4LsIKlRZOvi8FZC2m3y0J/dNvvWwUfayI1NdM2/h8g2OTbIUoED0k4tCTZLU7SusOzx7BWQhqjsGjx2hWKAe9bv8XRfd/NFv4vMeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=R7UUFjUQ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DAE426A6;
	Tue, 21 Oct 2025 15:21:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761052906;
	bh=Y9ZTONpm589+RojL1lzdfFuJkRYHnz4HWW2urQfAi4Q=;
	h=From:Subject:Date:To:Cc:From;
	b=R7UUFjUQlXPZ0QyWEZrIDzGV0sI2mekpKrCarcrkZW6l2wZ+eLwAlCry+4KCmQNw+
	 7ojaEBNNxZ+bqw95BMS1nbqdKmzfnWQQEMPlc7dYNzDKJq6v/dZwGLUxJo2OOb5nBE
	 gSiO3o9yxUW3irBXF4zldSDRPUQUEZ+WaEEfEy3Y=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 0/7] drm/bridge: tc358768: Long command support
Date: Tue, 21 Oct 2025 16:22:56 +0300
Message-Id: <20251021-tc358768-v1-0-d590dc6a1a0c@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADGJ92gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyND3ZJkY1MLczMLXUvj1CQjYzMLyyTzRCWg8oKi1LTMCrBR0bG1tQC
 vsKS/WgAAAA==
X-Change-ID: 20251021-tc358768-93eb23689b7a
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Dmitry Osipenko <digetx@gmail.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2092;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=Y9ZTONpm589+RojL1lzdfFuJkRYHnz4HWW2urQfAi4Q=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBo94lJfRq1+7S5Yp12KN+JPMIwAcqW0ah6q/eeh
 9Xe9O2vHdiJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaPeJSQAKCRD6PaqMvJYe
 9XcXD/45MM0PpEJDhfDQNr2SZEfVvu/KDnfjua5bjeMxE5dZMuwKE/vsXau1mkrt0d+TEoAyAfu
 96o2IZVO90Dt1xC+wpYkoTZ+m0WYcsew1JMpSse7kT4aF+fsSQ+Qn1zbHIrymfnXC1zgi89oSqU
 6VLUNTlIImM6jf+F5oMya7SMDJHR9SATx503IfMCW67Syf29+yVQ3dCi6fuIu1NrsoGTBmAN0UC
 fD5VQFpt4OXRUkQ3rN5i3od/Y4WCyCuEkhY5bE/cwRr4UQ2zbIj5E80Xj9FxVJadG8VCRPsx5N6
 MT3oD3VL9ZcMTIy+v/azeae53YavGN93sB1GKUmZU1nFMSeR+Dby28Xkp2rRZcU/40LcaSpQDxX
 RsayzaENXW9H+AWjYtbTifHgDrzRjN8L/cKz1alqBmgNntr/K8B//uXyN87dEzRN9hDq+fqf1uW
 uYWFK8B6La1uZNHldwSrmzZi5VFLRezsBc7CUnDbvgtSvVJc+QTwnbWoZei9CnEkSCFYsajfosl
 5EEF2SL34YX5WlfPbCcQ3bNbuQTBZdC+0eMKBw8q9A8N0y6ruegky1rbs0AYDcGtjOJ77cAfqQ2
 HLa/AAH5hCdYodPCEI4kXtyd3ida1q07JK0gxuBvKpJL60oFVJ6caNwgtdajJQ04o6hU5/XVCnV
 DMJNIkwcViO6k3w==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

This series makes some small improvements to the tc358768 driver, and
then adds support for long commands, commands that have more than 8
bytes of payload.

This has been tested on Toradex Verdin AM62 board, with a ST7703 based
DSI panel which requires initial configuration using commands that have
8+ bytes.

I tested the following combinations, by observing the panel visually and
the DSI lanes with an oscilloscope:

- HS command transfer, continuous clock
- HS command transfer, non-continuous clock
- LP command transfer, continuous clock
- LP command transfer, non-continuous clock

All except LP + continuous clock work fine. While observing the lanes
with normal oscilloscope is a very high level and vague view of what
exactly is going on the lanes, it still looks good to me: initial
commands are sent in LP, and then video data is being sent in HS, and
clock lane is continuous. However, the panel stays black, so something
is not quite right.

As it doesn't make sense to send commands in LP during initial
configuration, especially with longer commands, I will leave that
particular combination unresolved. I'd be interested to hear if it works
on some other panel.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Parth Pancholi (1):
      drm/bridge: tc358768: Set pre_enable_prev_first for reverse order

Tomi Valkeinen (6):
      drm/bridge: tc358768: Fix typo in TC358768_DSI_CONTROL_DIS_MODE
      drm/bridge: tc358768: Separate indirect register writes
      drm/bridge: tc358768: Support non-continuous clock
      drm/bridge: tc358768: Add LP mode command support
      drm/bridge: tc358768: Separate video format config
      drm/bridge: tc358768: Add support for long command tx via video buffer

 drivers/gpu/drm/bridge/tc358768.c | 202 +++++++++++++++++++++++++++++---------
 1 file changed, 157 insertions(+), 45 deletions(-)
---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20251021-tc358768-93eb23689b7a

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


