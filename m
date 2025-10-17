Return-Path: <linux-kernel+bounces-858402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ABEBEA965
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8328188B6CD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56FF2BE7DF;
	Fri, 17 Oct 2025 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fL2u+Keo"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A80284B2F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717747; cv=none; b=J/fNgDc34z0EibO1cOpKKw6WF7eAMiltaAu0wjqlCas0zoHfM4Qdtk9Y2+aSqbPxtSzlGjCfMqeapW0SpCLYr4WKonlilEiHZwxMMLrYU0r2K2Wd5WqekG6ECw0EolxJSml930lTgZxkl+tqSWA52ca/4iSM+y54JOaiN4p2juQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717747; c=relaxed/simple;
	bh=JPFqJYnkaCnjfz8yNbmZ/wzPu14Hx42HsWltnrWblTs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UU+BIxBC8yFT9R1ahYGbhJS3lZFXTCLRmL5DcQ9+nqQKIZ1vtq85joS+NoawOAfeczkOaNAYpi8i9DaaQ8daWMrjf8UljIf07giG6pbScswlmPgA6mAxYrj1KJqbl0s+IoN/7o2xSLpE4GuOY6ZmZj8l8hDQy1LB/opUicANC8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fL2u+Keo; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0AB24C041F9;
	Fri, 17 Oct 2025 16:15:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4AC34606DB;
	Fri, 17 Oct 2025 16:15:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26359102F2326;
	Fri, 17 Oct 2025 18:15:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760717742; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=1gZYj8CDwkwQkHj+g6IyGlj/9ZmAjcXOn2g8weSaT64=;
	b=fL2u+KeofXB5YaHR4yIc2hQBnF6ZbtSt9VFrCzpYo/5iQsPI/YpUC9AIe+me8YLQpt5OnF
	9Z8Ohg9X6AYuLxFo/eqpQCAnV+tpE5DTitrgHRpbgDo8eohVLUijgcJWIX0SCfEipkzBPK
	ymox/DdB0mozuKHw3bilOEebC2Mbs9zQH7tvA5ju+GPztgX2dTx9kmhOhmyhW8tbtZSk26
	TJdkEWRyj4WvF7c2ZfZXQApWukCdsjuRm40Lod9EwYlkV8SHudbBH0137gn0qSMjFTjAI1
	USLr3+2BicO0LU47aqwvSIHDn+150r0fofsyW+fyZ9nGjAoFUPQaPVC4/5DMRg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v2 0/3] drm/display: bridge_connector: get/put the stored
 bridges: fix NULL pointer regression
Date: Fri, 17 Oct 2025 18:15:03 +0200
Message-Id: <20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-0-667abf6d47c0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIdr8mgC/6WOTQ6CMBCFr2K6dgytQMCV9zDEwHSESaAlbSUaw
 t0dSTyBy++9vJ9VRQpMUV0Oqwq0cGTvBMzxoHBoXU/AVliZzBQ60yXYMEEX2IrTjqNH6CnNz/T
 T0DtHmHyAB79gsBPfkRDqNje1tV1ekVHSPQcSf9+9NcIDR8m89xuL/qr/Li4aNFTalnWVY3Eu9
 bXzPo3sTugn1Wzb9gH3oRhf/AAAAA==
X-Change-ID: 20251016-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-9a429ddb48e2
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
 Naresh Kamboju <naresh.kamboju@linaro.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

A patch of mine recently merged in drm-misc-next [1] has a NULL pointer
deref regression (reported here [2] and here [3]). Being in lack of a quick
fix, I sent a revert proposal [4].

The revert proposal has no answers currenty, and in the meanwhile I have a
patch that implements the original idea but without the same bug. So here's
a v2 series with:

 - the same revert patch
 - the original patch but rewritten without the same bug (and even simpler)

Also the re-written patch is now split in two for clarity because it was
doing two somewhat different things.

[1] https://lore.kernel.org/all/20250926-drm-bridge-alloc-getput-bridge-connector-v2-1-138b4bb70576@bootlin.com/
[2] https://lore.kernel.org/lkml/336fbfdd-c424-490e-b5d1-8ee84043dc80@samsung.com/
[3] https://lore.kernel.org/lkml/CA+G9fYuKHp3QgPKjgFY3TfkDdh5Vf=Ae5pCW+eU41Bu=D7th2g@mail.gmail.com/
[4] https://lore.kernel.org/lkml/20251016-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v1-1-81d6984c5361@bootlin.com/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v2:
- No changes to the revert patch
- Added the (corrected) patch introducing the same feature as the original
  buggy patch, and also split it in two fir clarity
- Link to v1: https://lore.kernel.org/r/20251016-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v1-1-81d6984c5361@bootlin.com

---
Luca Ceresoli (3):
      Revert "drm/display: bridge_connector: get/put the stored bridges"
      drm/display: bridge_connector: get/put the stored bridges
      drm/display: bridge_connector: get/put the panel_bridge

 drivers/gpu/drm/display/drm_bridge_connector.c | 92 +++++++++++---------------
 1 file changed, 39 insertions(+), 53 deletions(-)
---
base-commit: 84a0a3f014cda68ff10b8517d09e9f0c1cd942a2
change-id: 20251016-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-9a429ddb48e2

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


