Return-Path: <linux-kernel+bounces-846723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C50C9BC8DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B45CD4F831C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1192E03E0;
	Thu,  9 Oct 2025 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zke8aiqn"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F142D63E5
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009966; cv=none; b=W+mHU87kE/FJvoxW5rCASSZsm2p8YJ6aKCYcYaQpuHjSwXSJoIi7Zry9FJ7EsubxLQCzRq0XbRDN4cp7WHJCaKBM8NaXJYRFnXOVDj9RU45Zv7Sw5m6eGF0SnWPJe/ihL4rlnY3MT25wEUb/H8SNJSjlqUseKVtwZ0VOlPL3anI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009966; c=relaxed/simple;
	bh=17G+thxl7sZTuX5ANwA/8RCIpiZ/n/ttbJ+yOwQCkAA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uqiPubv7nJmrZcrVmTfouR7OYgHNuqfuc3E8xqgNICLXzAWZcbrkBGIzzHNj01sQezziLKMer3ETyuQ6gbXp4/BmyS898l6KJNKHl+rQi0aAP3fiLvWmYam4Lq1vfZt+b5WilOpLgcheMqqx2h16jdC2UeLgy8XkHqpF6rviJvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zke8aiqn; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8BEF8C0359B;
	Thu,  9 Oct 2025 11:38:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E2B6A6062C;
	Thu,  9 Oct 2025 11:39:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26ECA102F21B6;
	Thu,  9 Oct 2025 13:39:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760009953; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=hfVcbnLGjx4Znw2zLlmguUyQgxO9dRHalaOneqN03RI=;
	b=Zke8aiqnuai6wA9G+lfSgOgUhtL7HhJC/mN5Ym0BcEr8debI/EmSFsnfinioYWxc6J5CWA
	b4slEyLb0t62OejVa0o8rO2dSplAyH87lKXl2RLkD//nHF2DmtwQgvk5oEqtJBct7ukvTu
	KgVs1ejZ0ZpdnGBdq0CfoZPQRIyIIVUXB8JYjfed8XzjpaltVB4FNII6IoKC4seWafgHq0
	qsIqpvfFoJTIsPZH5HqYrJPu3NwgvjZJhEdOoqXbw7pcPzPlldxQxCEJ9XEXL5wyYhYXrK
	0DEHOmNxIW4O5yZOXjPdGfyMIFhN32hLjmZC3JQgZRSeQ853WM5nVQF60nLXkA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v3 0/7] drm/bridge: protect encoder bridge chain with a
 mutex
Date: Thu, 09 Oct 2025 13:38:55 +0200
Message-Id: <20251009-drm-bridge-alloc-encoder-chain-mutex-v3-0-c90ed744efec@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM+e52gC/42NQQ6CMBBFr0K6dkwptqAr72Fc0HaQSaA1LRIM4
 e4WEk3csXwzP+/NLGIgjOySzSzgSJG8S1AcMmba2j0QyCZmggvJz0KCDT3oQDZ96q7zBtAZbzF
 AmpOD/jXgBLqsrBK8koiSJdUzYEPTlrndE7cUBx/eW3XM1+s3oPYFxhw4iEIrYU5lIVV91d4PH
 bmj8T1bE6P4aXPOi51akbRlpRuVy4rXXP1rl2X5AB+5NRQxAQAA
X-Change-ID: 20250925-drm-bridge-alloc-encoder-chain-mutex-b78d62085ee5
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

This series ensures that the bridge chain of the encoder will not be
modified while some other concurrent code flows are iterating over it.

This is part of the work towards removal of bridges from a still existing
DRM pipeline without use-after-free. The grand plan was discussed in [1].
Here's the work breakdown (➜ marks the current series):

 1. ➜ add refcounting to DRM bridges (struct drm_bridge)
    (based on devm_drm_bridge_alloc() [0])
    A. ✔ add new alloc API and refcounting (v6.16)
    B. ✔ convert all bridge drivers to new API (v6.17)
    C. ✔ kunit tests (v6.17)
    D. ✔ add get/put to drm_bridge_add/remove() + attach/detach()
         and warn on old allocation pattern (v6.17)
    E. ➜ add get/put on drm_bridge accessors
       1. ✔ drm_bridge_chain_get_first_bridge() + add a cleanup action
            (drm-misc-next)
       2. ✔ drm_bridge_get_prev_bridge() (drm-misc-next)
       3. ✔ drm_bridge_get_next_bridge() (drm-misc-next)
       4. ✔ drm_for_each_bridge_in_chain() (drm-misc-next)
       5. ✔ drm_bridge_connector_init (drm-misc-next)
       6. ➜ protect encoder bridge chain with a mutex
       7. of_drm_find_bridge
       8. drm_of_find_panel_or_bridge, *_of_get_bridge
       9. … enforce drm_bridge_add before drm_bridge_attach
    F. ✔ debugfs improvements
       1. ✔ add top-level 'bridges' file (v6.16)
       2. ✔ show refcount and list removed bridges (drm-misc-next)
 2. … handle gracefully atomic updates during bridge removal
 3. … DSI host-device driver interaction
 4. ✔ removing the need for the "always-disconnected" connector
 5. finish the hotplug bridge work, moving code to the core and potentially
    removing the hotplug-bridge itself (this needs to be clarified as
    points 1-3 are developed)

The per-encoder bridge chain is currently assumed to be static once it is
fully initialized. Work is in progress to add hot-pluggable bridges,
breaking that assumption.

With hotplug and especially hot-unplug, bridges will be added and removed
without notice, and thus be added/removed to/from the encoder chain in
drm_bridge_attach/detach(), concurrently to the code iterating on the
chain. This can result in disruption of the code iterating over the
chain. The rationale is explained by a detailed example in patch 2.

Avoid bugs by introducing a mutex to make list insertion, removal and
iterations mutually exclusive.

[1] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/#t

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v3:
- Re-added the drm_bridge_put() in the for_each macros, leading to largely
  rewrite them
- Removed the drm_encoder_chain_[un]lock() wrappers
- Fixed a potential ABBA deadlock in patch
- Improved some commit messages
- Link to v2: https://lore.kernel.org/r/20251003-drm-bridge-alloc-encoder-chain-mutex-v2-0-78bf61580a06@bootlin.com

Changes in v2:
- Improve commit messages and add documentation as per v1 review
- Patch 4: fixed infinite loop when encoder->bridge_chain is empty
- Link to v1: https://lore.kernel.org/r/20250926-drm-bridge-alloc-encoder-chain-mutex-v1-0-23b62c47356a@bootlin.com

---
Luca Ceresoli (7):
      drm/encoder: add mutex to protect the bridge chain
      drm/encoder: drm_encoder_cleanup: lock the encoder chain mutex during removal
      drm/bridge: drm_bridge_attach: lock the encoder chain mutex during insertion
      drm/bridge: lock the encoder chain in scoped for_each loops
      drm/bridge: prevent encoder chain changes while iterating with list_for_each_entry_from()
      drm/bridge: prevent encoder chain changes while iterating with list_for_each_entry_reverse()
      drm/bridge: prevent encoder chain changes in pre_enable/post_disable

 drivers/gpu/drm/drm_bridge.c  | 83 ++++++++++++++++++++++---------------------
 drivers/gpu/drm/drm_encoder.c | 18 ++++++++--
 include/drm/drm_bridge.h      | 73 +++++++++++++++++++++++--------------
 include/drm/drm_encoder.h     |  4 +++
 4 files changed, 109 insertions(+), 69 deletions(-)
---
base-commit: a036f5fceedb9fbd715565fef7b824a121503de7
change-id: 20250925-drm-bridge-alloc-encoder-chain-mutex-b78d62085ee5

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


