Return-Path: <linux-kernel+bounces-806727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B92FB49B01
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01059164340
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDBD2DA753;
	Mon,  8 Sep 2025 20:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnELPuDs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284E82D9ED1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757363106; cv=none; b=lpXB7GooWgUmzLCRAczH8Gnr6EA4f9s3Ix+AuqSeSO2qPMDGjaNi0DOGsBLdIQUGrrzr3CzNqzPlqbFjJ1w0cIsF6FccPP/mge/06mR5BytxLgvJG+52O2u97p9vmBx7dRY1W+anvPknwPp9tMqNPVe+oWlWdbB8AFz3KYxBEUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757363106; c=relaxed/simple;
	bh=EeZ5Fym6ni/5xsYhCIpDQXvwsj73UciVjDEiIfrAChk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SvdzgKGZx/keBPWnmGbP6W+8sMfwyBlVRCBGee4pKEfHzfO4pq4Bo/Aa8fWST9mY5EAwGmogmUzqT8UTpI3zYVmz51x/mUxZD+pjgYoaN8myZ7VsvJksBoH2AXObfjlxFjaXUpNoWonYWzuZCplNMTN3g9LZdUfhTaAWQTXKeuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnELPuDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502CBC4CEF1;
	Mon,  8 Sep 2025 20:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757363105;
	bh=EeZ5Fym6ni/5xsYhCIpDQXvwsj73UciVjDEiIfrAChk=;
	h=From:Date:Subject:To:Cc:From;
	b=pnELPuDs4BOhFPrizo3HkfcR9yX8smoxf6KaKfD1VpNbRyeRIM3hca26QHQOnnOxc
	 DoQ3JsdgPXDrp/zXAxgcUbWNIbKM/s2rlvKaz1p6W0pQCwBQnDryA18kwg2eNBjLb1
	 EHE1656r7Q+uApM+P4wNoqJmWS1jCg7pn08ZmZR5VQPK47rck91XwZ3THInY1XE56w
	 Pp3kqbIw+W7w/uVJrPVO8+iHiR4dEH7UYVdpDxyu0Se4fuw/Nb3D/TpiMV+rxLL4FF
	 rE3lJT7JhFRDMr/SIdd0j8e+Bi11b711873fox+cZ1e+AmW9UcPwuIfXy8MrZGaCIk
	 aEft8Skn9xEBw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 08 Sep 2025 13:24:59 -0700
Subject: [PATCH] drm/pixpaper: Fix return type of pixpaper_mode_valid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-drm-pixpaper-fix-mode_valid-return-type-v1-1-705ceaf03757@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJo7v2gC/x2NUQrCMBAFr1L224UktdB6FRGJ5qkLNl02tVRK7
 27wc2CY2ajABIVOzUaGRYpMuYI/NHR/xfwES6pMwYXODa7nZCOrrBoVxg9ZeZwSrkt8S2LD/LH
 M81fBxxB6dK33Q3ujWlNDtf+n82Xff//xYT55AAAA
X-Change-ID: 20250908-drm-pixpaper-fix-mode_valid-return-type-4228e531193b
To: LiangCheng Wang <zaq14760@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2088; i=nathan@kernel.org;
 h=from:subject:message-id; bh=EeZ5Fym6ni/5xsYhCIpDQXvwsj73UciVjDEiIfrAChk=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBn7reczaZ050WkvkJfa5tW3fKds3RTObQITubY6hG85H
 ya17lFhRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZjI5xhGhivHPIMf/XO7xOg8
 12LGHscHd47fUnAuNIrJ+X/ZsftIWQ/DX9E6oVXWZ+88Ejo1M71Sf85SibMsna+VHt34un3q6dc
 LRNkA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building with -Wincompatible-function-pointer-types-strict, a
warning designed to catch kernel control flow integrity (kCFI) issues at
build time, there is an instance in the new tiny DRM pixpaper driver:

  drivers/gpu/drm/tiny/pixpaper.c:982:16: error: incompatible function pointer types initializing 'enum drm_mode_status (*)(struct drm_crtc *, const struct drm_display_mode *)' with an expression of type 'int (struct drm_crtc *, const struct drm_display_mode *)' [-Werror,-Wincompatible-function-pointer-types-strict]
    982 |         .mode_valid = pixpaper_mode_valid,
        |                       ^~~~~~~~~~~~~~~~~~~

While 'int' and 'enum drm_mode_status' are ABI compatible, hence no
regular warning from -Wincompatible-function-pointer-types, the mismatch
will trigger a kCFI violation when pixpaper_mode_valid() is called
indirectly.

Update the return type of pixpaper_mode_valid() to be
'enum drm_mode_status' to clear up the warning and kCFI violation.

Fixes: c9e70639f591 ("drm: tiny: Add support for Mayqueen Pixpaper e-ink panel")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/gpu/drm/tiny/pixpaper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/pixpaper.c b/drivers/gpu/drm/tiny/pixpaper.c
index b1379cb5f030..32598fb2fee7 100644
--- a/drivers/gpu/drm/tiny/pixpaper.c
+++ b/drivers/gpu/drm/tiny/pixpaper.c
@@ -968,8 +968,8 @@ static const struct drm_crtc_funcs pixpaper_crtc_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 };
 
-static int pixpaper_mode_valid(struct drm_crtc *crtc,
-			       const struct drm_display_mode *mode)
+static enum drm_mode_status
+pixpaper_mode_valid(struct drm_crtc *crtc, const struct drm_display_mode *mode)
 {
 	if (mode->hdisplay == PIXPAPER_WIDTH &&
 	    mode->vdisplay == PIXPAPER_HEIGHT) {

---
base-commit: 490b30fbaca2abbd6afa8bdc7e2df329b5d82412
change-id: 20250908-drm-pixpaper-fix-mode_valid-return-type-4228e531193b

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


