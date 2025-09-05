Return-Path: <linux-kernel+bounces-803049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8885EB459ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323C81CC3A0D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF7135E4E2;
	Fri,  5 Sep 2025 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GgIuW4Bu"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB19535E4CA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080744; cv=none; b=Jf8r8SOYpsLxfVViAqiRhvNnVXPmpj+3R1NIEVDyjEw8OegRm8cXqSf94Czpr76abuIZt2qelU4AHAL2sB7kCjbulzSbrDRzotgBoqp1Eylu4rHy+kMsXL141/gR5SXiLHPiweX/rdDghoOgy/IdieWFgnaLXQWOEkycUPOrv0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080744; c=relaxed/simple;
	bh=9LxxYhOkJgXUvxE2ZO4TrHjls5tQc2g6KQ5jlrd2xUk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZKCciyp13I3BHuDHyxCrh1PwQSFBm2v4Dps4TVi6QfnWnZHbKp7zUjmno3jwgA8R6luASrItb+3ey+pzVzoGhwO8vuARVvx6nd9uwcS2eEVdFoHqKBQMwOzKUyiF1ziT9iLF/ulnQ+xfNLKXBUifCd+m7fDGsNImFu4KgOb19sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=GgIuW4Bu; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9BF1EF09;
	Fri,  5 Sep 2025 15:57:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1757080669;
	bh=9LxxYhOkJgXUvxE2ZO4TrHjls5tQc2g6KQ5jlrd2xUk=;
	h=From:Subject:Date:To:Cc:From;
	b=GgIuW4BuEzKLQei3pMC5Edx34buE2i/iqREHUH695VXOYk7qFYxun52nPYwLbjOpW
	 G/a7Su4cVbVecaQTzqvZvlSFnxlWikxrWzysuBNnWSkHt94VYhkCBC0oHSiK/4cAi4
	 vf7BQtD3YpR0bSV00mEQzMClmG5ZPPl8HjzKXk+k=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 0/2] drm/tidss: Fix issue with page flip timestamp on
 enable
Date: Fri, 05 Sep 2025 16:58:05 +0300
Message-Id: <20250905-tidss-fix-timestamp-v1-0-c2aedf31e2c9@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG3sumgC/x2MSwqAMAwFryJZW4hVQb2KuChtqln4oSkiFO9uc
 DcD814BocQkMFUFEt0sfB4qTV2B39yxkuGgDhZtjyP2JnMQMZEfpZ0ku/0ysUMfBkuhxRF0eSX
 S4H+dl/f9AOCPdQ5lAAAA
X-Change-ID: 20250905-tidss-fix-timestamp-f40cd82ed309
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=765;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=9LxxYhOkJgXUvxE2ZO4TrHjls5tQc2g6KQ5jlrd2xUk=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBouuyeFWGVBsF4GOdkJTxKgD7opR6+5vfxTy+uG
 C6aG1GFol6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaLrsngAKCRD6PaqMvJYe
 9SU2D/9RRtZ9XeXYOrDFhK5MPJ7Cdkpu0mMwNz9DaqP90uKts0AmesMe+OFZGFqN9XEj+8ACS4z
 48rqeQSi9n5q0TcLC59NLYsQXhwKkJiblKJ1HbuuSp0JEa1wQ3imkTScuqh0l43Evhl//G3Gs6D
 CXT1HuOo4OpjI0bx8zVN0zF1c/uGuLIMeGIftkg3tqPpx/YMkeDRd9NwxQWFzgSKwq/+EVuyelP
 tcUB98etNUCvSlrqMDWjGksiPSLEz6A6H8N+LLoPg/NiXAet0OCPWHjtCDVXvNL/nfuzfo5gLnY
 H2H1ThU3Vi3rwYCaxIKA/INlHwT8jC6H8x1BGTsrJkQICNEM0bSvYLCkDEqnN4OxI94Nrm/6VXx
 4zZocSDyLL3NbHqI7ZGBvZ7OIOgK1ZHFaS14emUhXr2k8YrXNqCUDrwYc3eZ5qXVAu1EuimwfBO
 MROs568TEkrWJaWvfIOtnfJu2pCMypR3R+rrg070LF9GLgXRj/B1yl0VZTBHob34H4FXjsBJspE
 cwnvT4mgrp3lPmNEXvAMvOhb3qOCDLmQSlVQ+2ry0thr39zqDT4rk+3p1/uera2arQ8TNpTaFhM
 8+mDAxd+zQ2R4HrjRbMtyp3BKqxOjoD7Tjr7FElz+edzd4kft4vAVBp9QjTRs9PWT2FYO9l9r8W
 CkNdnbSxVg1MszQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

This fixes an issue with the page flip timestamp being 0 on CRTC enable.
See the second patch for in depth explanation

 Tomi

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Tomi Valkeinen (2):
      drm/tidss: Restructure dispc_vp_prepare() and dispc_vp_enable()
      drm/tidss: Set vblank (event) time at crtc_atomic_enable

 drivers/gpu/drm/tidss/tidss_crtc.c  |  9 +++++++--
 drivers/gpu/drm/tidss/tidss_dispc.c | 22 ++++++----------------
 drivers/gpu/drm/tidss/tidss_dispc.h |  3 +--
 3 files changed, 14 insertions(+), 20 deletions(-)
---
base-commit: 03e7ae93c6e32206797c13118659a966ae84a3bb
change-id: 20250905-tidss-fix-timestamp-f40cd82ed309

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


