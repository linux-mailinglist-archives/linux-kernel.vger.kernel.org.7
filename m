Return-Path: <linux-kernel+bounces-777858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B893B2DEAD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C09B5664C8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6281261593;
	Wed, 20 Aug 2025 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQcdrCxi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E4425A2C7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698521; cv=none; b=UfLAr11/pk79Ew1Z3kDBrkN+5064ZWvVQpffdP3QtJw8YC8fPqxARNlnCv12pEjdpwwoB3opbqQhyEtepyOXl/vWqyEero8xA3W6mLOGMtlpkF2T9+mV9VYnOKTan2tcD7btLSuygV5I2E9jBIzq/LNoKRdjyz8rm3zJccpO9Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698521; c=relaxed/simple;
	bh=mwCmxnOMZLyjttEuHM2BZfc5kOf2MXquAOxaMhYfY1s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Nn8sMEYfQbfbWWc3gZLX6k0+1YzkVPH+LcYzYVZVra1lgSnFCX8dVAuxTyLfPfSRcaO8PYhxZsoDE/uWZL3WG0+qAsWopaIlxPdQIeR9Eu0Yg7SShW6KYOrXnIBxhhEIVyVf80+xh82einyP8nlw7P8ZOEiNFer1LiYvXRXOEf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQcdrCxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008FDC4CEEB;
	Wed, 20 Aug 2025 14:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755698520;
	bh=mwCmxnOMZLyjttEuHM2BZfc5kOf2MXquAOxaMhYfY1s=;
	h=From:Subject:Date:To:Cc:From;
	b=JQcdrCxiW0Ojm4NJRf0qtMQcotY8t9YVO0oivu8i04+lGaH9WJs2ExI0cUOKoy5Ta
	 3QHlZGqjai23FdiQChFCYjODSgXUzf8bquSKGIgOwmSSFxvEM3gxPHLnF+3k1sxAqL
	 vMF4jMlMBR+/EpHifpO/IVloLqUf5Pg6l8/1htzHQewlW91NfoGWVoLVUgjSBmUDsJ
	 LwjSPU5QuyfLjgqgjOMdkOtFN7thC+av/8fRvlRP2frzXX+ZfuQPtZaEiPhgUVYIlS
	 M+cpf8+N8H4TIze/N2ix+vEUEY409ih/N1xqJ7+o2hPN7lyVCnKzryjd/Pf+4Vnrbx
	 bdX3APWNipmww==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2 00/14] drm/tidss: dispc: Convert to FIELD_* API
Date: Wed, 20 Aug 2025 16:01:40 +0200
Message-Id: <20250820-drm-tidss-field-api-v2-0-43cab671c648@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAETVpWgC/22NQQ6CQAxFr2K6tmYomAFX3sOwmNgCjQikQ4iGc
 HdH4tLle8l/f4UophLhcljBZNGo45CAjge4d2FoBZUTAzk6O08Vsj1xVo4RG5WeMUyKeUlV4UN
 FXBSQlpNJo6+9eqsTdxrn0d77yZJ97a+Xu7+9JUOHwWdBSmbyJV0fYoP0p9FaqLdt+wDqw7JJt
 wAAAA==
X-Change-ID: 20250729-drm-tidss-field-api-382947a92d44
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1808; i=mripard@kernel.org;
 h=from:subject:message-id; bh=mwCmxnOMZLyjttEuHM2BZfc5kOf2MXquAOxaMhYfY1s=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBlLr/pxJe0UMpe7r6li1rG1otgo9Gol5+IH7AJt7/i01
 7/6dPF1x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhIrjpjvReD6LrdhjLybTtm
 ajA9C24qtSngPmF7/f6Th9vfxCj4X9v+7v5WM/45sTnex/JfXYhYy1hfrVA1i7OcRX7NkxfH5+3
 O2bZeWk0qTfG/vZZx4Y75P5dMeewifdl65aHDt2tkJ/86VHgZAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Hi,

The tidss driver rolls its own API equivalent to the FIELD_* API already
provided the kernel.

Since it's an ad-hoc implementation, it also is less convenient and
doesn't provide some useful features like being able to share the field
definitions that will come handy in the future.

Thus, this series converts the driver to that API and drops its own
version.

Let me know what you think,
Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Changes in v2:
- Switch to macros to prevent a gcc error
- Link to v1: https://lore.kernel.org/r/20250730-drm-tidss-field-api-v1-0-a71ae8dd2782@kernel.org

---
Maxime Ripard (14):
      drm/tidss: dispc: Remove unused OVR_REG_GET
      drm/tidss: dispc: Convert accessors to macros
      drm/tidss: dispc: Switch to GENMASK instead of FLD_MASK
      drm/tidss: dispc: Get rid of FLD_VAL
      drm/tidss: dispc: Get rid of FLD_GET
      drm/tidss: dispc: Get rid of FLD_MOD
      drm/tidss: dispc: Switch REG_GET to using a mask
      drm/tidss: dispc: Switch REG_FLD_MOD to using a mask
      drm/tidss: dispc: Switch VID_REG_GET to using a mask
      drm/tidss: dispc: Switch VID_REG_FLD_MOD to using a mask
      drm/tidss: dispc: Switch VP_REG_GET to using a mask
      drm/tidss: dispc: Switch VP_REG_FLD_MOD to using a mask
      drm/tidss: dispc: Switch OVR_REG_FLD_MOD to using a mask
      drm/tidss: dispc: Define field masks being used

 drivers/gpu/drm/tidss/tidss_dispc.c      | 295 +++++++++++++++----------------
 drivers/gpu/drm/tidss/tidss_dispc_regs.h |  76 ++++++++
 2 files changed, 223 insertions(+), 148 deletions(-)
---
base-commit: fbb0210d25fde20027f86a6ca9eee75630b5ac2b
change-id: 20250729-drm-tidss-field-api-382947a92d44

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>


