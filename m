Return-Path: <linux-kernel+bounces-744885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F54FB11223
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52FA16D3E0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B3424169E;
	Thu, 24 Jul 2025 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="JnL8EF2c"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECAA1FC3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388626; cv=none; b=XSb++pMv1ju2hBpo0F7I4tUv4xHZd+2IbVJRqHKp8wKSvolZ+PvvL8W81XCG0J7QOj4mqywhY1D5kZVKXQAA0wrZiNr0XcQ8y1/cpTqFm0T8/kW9FYMVHyaap/BysqXud7CxEh1dxCO62dp0WKL0v2nPZ7HWZ0uMAajtzEljJSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388626; c=relaxed/simple;
	bh=CPSldl5hqRKOFHGgVldI2p+/nx7cULLJ0sN3T0HMf3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BOBhJdZYsoRrHoAoRC9t5010k10FYZGjLVdesSA2ndvQVHN2dDZuOOAmLZX3jdDTM0BVspIgtmvKGJw5RrykxbERYL/EVNP76AsmJWi382JxtUBB2tICCW6iFpLSCgCWLJZfYXXc4kD+TqFrM1fG7qauRSsLdTjySl9fVs3jXHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=JnL8EF2c; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-75ce8f8a3cdso1020643b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753388623; x=1753993423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aNZbwQw5iHEb9CKajVAO1swZ1MthUYrqZ1xdxET+ZZU=;
        b=JnL8EF2cLy6k8FwVSliLn1usQAk9lzAqWjGMecLKGOa76iVSPNZfAC8ApOuVzjQjy0
         iyioEuC1s9vA+eWrDnG/ROGadGArZDf0Gj97/Ms1vRngXr9SilLbHrtYECKK9SLMnTm9
         C1GS6rIv/KUmFrTtVcKs/fa63gMJzeJGiuBB22OJ6knh4MuEU2Xv5hUAuWnUS3xxBfBE
         kf6DQTKauNbDvwIZnpQwFTygUCik4KeC46zOFRXZsI5kb1HwivnGRmxDf6A50cIrugsW
         i8mu2zxMLcvZl8Btd3THvbLIV3ugoUJrVBoGDWFxDf0Ae7k9xG6EdvJISMOqs2YeJx2+
         2Nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753388623; x=1753993423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNZbwQw5iHEb9CKajVAO1swZ1MthUYrqZ1xdxET+ZZU=;
        b=GORZS1R+rWOhOeVtS40LAOWbZ1VNbvirhlO3Oc7SSxgpu1EZo2HD15krAZPae8FxRr
         PExyUOni7XsECs38mg1xIBh++9CEcebQvFDwIOLLVLt4dO5fBEYcC/TQUmPTgXNY65eB
         ObZ3G3KmXmH5+JtfJRD5dFtvo2P602vAg28NJHWaQVPUFKddPYQaAe771gUnKPW5ABLf
         txX3AnIT0hZGPw5nst0osBW7LSMz32HYXJYF+NE+NoBehGR7DdX6X6MxFsj8bPD1p3AU
         Vn3apWe+aG8prOo2+4+DmbX0Zb5fq17I+8WQShBa1nztVaFzp4c9wqh8P7pox2TbKKSL
         bxvA==
X-Forwarded-Encrypted: i=1; AJvYcCXGnZXEJHZ+Pr3G1slv2XKOo1zj4z59j0fKRX5SXoLdgBubWyq2+5fXWBkEVYdtkiV2rQhcOBMmfELxCl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS82mB6RxzjQ0HXgCQr8JyeL9uWTF3RaskRZYHC1tyq+uexh3S
	vzR8YU4k5x+Xik8wVZ0vWepQu0eDtTGPiwCgTS6LImP+HilI/ovKfyUY9j2aJCJwuYo=
X-Gm-Gg: ASbGnctVWKDl7yqVheqiLMhUzKlEjhK0WBDUqQLgo2ifrPlxxOhE2pOfD6e+PA/JnNv
	+UtQzw5FhR7ZkZj7Wybnrw46tnkmU5SP7APsB8iHBY72MMURW6/5MILSVCJScf42/nwIFLK+pud
	9e6N+MblURkRivpOQ/QuIsnIeVe+QzUJOT1PVXjs1jJsSRDhkZJS3VVH6oCczQ0dl9Tj4sAjwVs
	kx9FZg7gtQd74jZL/cmRPxFBeBZuLpce7d/4lLZfcHNnB+Su+1TvhTosBjBHSYAAJVbC0pZYZLp
	1jm1nZV2TU/fj6iU8869sgDnRlwr6gKJ2CsQIEwB1yTPY7PHIFZeiGnBtfm7EdjnxUytzlclhn/
	kr113IR0iBQhhySuWzFFreaG5kIdpZz5MD08mkTJMkcSoYTFXOw==
X-Google-Smtp-Source: AGHT+IGPSLo7EaVXZqu37vUKdjxS3cia3ql+tqXEMZ48FC5JJP2rAz+cHkmUkDzlL3JzUsZOXDC49Q==
X-Received: by 2002:a17:903:8c8:b0:23f:6fa4:1567 with SMTP id d9443c01a7336-23f98146861mr98965735ad.8.1753388623215;
        Thu, 24 Jul 2025 13:23:43 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48dbfccsm22077815ad.138.2025.07.24.13.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 13:23:42 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	linus.walleij@linaro.org,
	neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	sam@ravnborg.org
Cc: dianders@chromium.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH 0/2] drm/panel: novatek-nt35560: Fix bug and clean up
Date: Thu, 24 Jul 2025 14:23:36 -0600
Message-ID: <20250724202338.648499-1-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series does the following:
 - Add mipi_dsi_dcs_read_multi() to drm_mipi_dsi.c for improved error
   handling in drivers which use mipi_dsi_dcs_read() such as the
   novatek-nt35560 driver.
 - Fix a bug in nt35560_set_brightness() which causes the driver to
   incorrectly report that it "failed to disable display backlight".
 - Clean up novatek-nt35560 driver to use "multi" variants of MIPI
   functions which promote cleaner code.

If there's a reason that mipi_dsi_dcs_read_multi doesn't exist, I'm
happy to drop it.

Brigham Campbell (2):
  drm: Create mipi_dsi_dcs_read_multi()
  drm/panel: novatek-nt35560: Fix bug and clean up

 drivers/gpu/drm/drm_mipi_dsi.c                |  37 +++
 drivers/gpu/drm/panel/panel-novatek-nt35560.c | 212 ++++++------------
 include/drm/drm_mipi_dsi.h                    |   2 +
 3 files changed, 105 insertions(+), 146 deletions(-)


base-commit: 1511d3c4d2bb30f784924a877f3cef518bb73077
-- 
2.50.1


