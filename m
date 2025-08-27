Return-Path: <linux-kernel+bounces-788527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A26FB385DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81FC17B681
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3325D27467E;
	Wed, 27 Aug 2025 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krcEL/Gi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8A25228D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307564; cv=none; b=bZ/eUZU1OCfT8y2TWzqSw/ftDL2Ht7KQrdG9Mb32Xerw2anMtj+TKPn8OfrBAsdf2GFMrm4x2NMBdinzIZ2loS0D5Mm1jGbyXMuywjErYK4+S51t46uq7ZxsHEx+JBDrz9wgZBEiq197DFN6OvfM1WaCErTWCLQZZ0PIAXN3hMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307564; c=relaxed/simple;
	bh=aLiyfjU336whNq3393sg2CHM0Hzlo1BbRuefTjgMLrM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EEFUC9woiRrusBdDXY0zSOIk1Dr4lQo2JT36kLsUYeMULt8LnUBd6aMzPIFdxwKF4ognd91I8Gqo3DPdhrNp8S1jwGiRotJBQzBk8Vm4lvLt3qT9mnWOgtBnOpSMSsyPfwMKAeGOYBTFSVC7JpdOOX/hQ4wZxADC3DUkigD1Xw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krcEL/Gi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B105AC4CEEB;
	Wed, 27 Aug 2025 15:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756307564;
	bh=aLiyfjU336whNq3393sg2CHM0Hzlo1BbRuefTjgMLrM=;
	h=From:Subject:Date:To:Cc:From;
	b=krcEL/Giwz/COhvgw7Rm0oBys/NBCudHzl8YBxZCDgB/U3ttRw+AfDQcrdP1WSjen
	 n8R1xDwrEKa956dOMGtiPlLM4Na6X4VeI2mGxRvbX6hdUv/Tr0ttKKirBsmWYtqTcZ
	 ZyqSPudQ4RLyujf3OLEw6bniTeYSLl7ezOhDK7Haqp+GDXInZMMnAS5rkaGTY+Bqzx
	 JWJOCBVtdg+KPx1QOv3zzTL3msYt1f4N5lz4l7Dw+ZonwIzMRyWmZqwDLC0qs5dPHE
	 4dXuuNzbDrsrNXddWDIisVxsi8Zkzzw8/bIAgH34p/v47zLge6Ls4lLeloWxK9Kmjt
	 0XyV4Y9xBIWKA==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v3 00/14] drm/tidss: dispc: Convert to FIELD_* API
Date: Wed, 27 Aug 2025 17:12:31 +0200
Message-Id: <20250827-drm-tidss-field-api-v3-0-7689b664cc63@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF8gr2gC/3XPwQrCMAwG4FcZPRtZs2o7T76HeKhr1KDbtK1DG
 Xt3OyeIoMc/kO9PehHIMwWxynrhqePAbZNCMctEdbTNgYBdygJzXOQaS3C+hsguBNgznR3YC0N
 hsFTaluiUEmnz4mnP95e62aZ85BBb/3iVdHKcvr0i/+l1EnKwWloyzqE2uD6Rb+g8b/1BjGCHH
 8TgHwQToorK7pZaVktlvpBhOtPT9ZZ+jtOtYmcDQdXWNcdV1tA9wrtCpo3hCWjZ9J4tAQAA
X-Change-ID: 20250729-drm-tidss-field-api-382947a92d44
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1984; i=mripard@kernel.org;
 h=from:subject:message-id; bh=aLiyfjU336whNq3393sg2CHM0Hzlo1BbRuefTjgMLrM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnrFZJ+nXicKBgR8je4XvgCd1/04x3v/wnfZ+XyFfT0d
 uJ46h3VMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACayM5Cx4XTcJlmZyG179Pcy
 LlnwzPhZZ2bPims9fczLla79YZ7iJij3W7aLd+Nt6V/eEcJLLsglMDZM+h2Tyf37snDk9jDNzRa
 SCu3tWyJfmnw5KXjgbGH5pVe2G+w+SCn1+WXK9jqIv8pfpAIA
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
Changes in v3:
- Rebase on top of latest linux-next, fix merge conflicts
- Link to v2: https://lore.kernel.org/r/20250820-drm-tidss-field-api-v2-0-43cab671c648@kernel.org

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

 drivers/gpu/drm/tidss/tidss_dispc.c      | 297 ++++++++++++++++---------------
 drivers/gpu/drm/tidss/tidss_dispc_regs.h |  76 ++++++++
 2 files changed, 225 insertions(+), 148 deletions(-)
---
base-commit: a6d3da9a268e3d0a20b76fb40fd3484fe219ff17
change-id: 20250729-drm-tidss-field-api-382947a92d44

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>


