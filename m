Return-Path: <linux-kernel+bounces-783020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E33C4B32882
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD91560372
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEBC2528EF;
	Sat, 23 Aug 2025 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="TZpicumQ"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E811F4176
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755951432; cv=none; b=f6gQSNKeMH8S/mLBpNPpmYuGpDJH7UvctPhp8FEA63nHy8tGtZ34zuIPxTfOFku5fmtmLS9hdF31If+fMzAiYX/7HLGwTnaRZabkPrG2kLdi5eDwLm9jUuHaePSUcXqpmiooot3ni02rouUACnShpfPFoB88KAUy7St1yTmX/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755951432; c=relaxed/simple;
	bh=nelDG6qITPbqnt1Z/Aezgq/uJ9++e3AOOsrxOOWiQYI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cDOeQqJKuA7wrGOOqExZ/61cIKNGhnz08ocpT58frOYdmDOm+rCtrz9dDgoyXsQDpncGWCdbBF3RxrUlZca4I0HPMREWzYD3LG6WvPMTutz3yOFIjPIuXFV++/ucPP1djA3zljH7fpKfbufee1K/VuE0HNzgaODfihcbYkVO5j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=TZpicumQ; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5A29F3F116
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 12:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1755951427;
	bh=tHRlOV1gcalzCWbpUniF1ug9QqZWPgVHTvYS8H+hUMA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=TZpicumQwx9P//l5pS7RKN21LIiNy8BQKnnuI0ltCmfbNzNAnDULaxK81NYYFzRI+
	 ph8OrWZXkA2nxRnSarj59BPiZfSeQLwvZp6yqiqkGMCueTLLwjtWof5dz7n7+h4+sv
	 wYMFdG6lkrGl80VpvtVUqR0+MFEnYkC2+XHQCKVuMEQqslBSno8nzejczher4P4B4A
	 luCDtLMxXrQtdwjgYHdf94JgUg1isPRP3oirXGfk7ni8CsKI5SidgTf2dQmtIGYG1r
	 6/xhhDWoLr3xyV2dhJ0ZO+MwfQRbhNjQfcgVZ0aF+GrN7u5YM2xDPPy6JaAphQVq5H
	 LIbAVN/GwMjRA==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b2955f64b1so84293571cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 05:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755951426; x=1756556226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHRlOV1gcalzCWbpUniF1ug9QqZWPgVHTvYS8H+hUMA=;
        b=cKU4sabw4OH2iFHtwJlHroBWJA+s3pt0nrEDDMLkI7qVowlvQ+ZSLVOPLOs/3vQhgN
         NCtVvJYaurDVbyfOV6nj7S6Am+f/+dYtbwcadmc8Y9sAU2g3qGBOB1mtRPYxFOHzt+4o
         uciGlFoOsUUNKBq91uG7oiggJOg6puseDhUz6M+djY7RuJN1CbJiT1p1b4Xni/L+dIL5
         7yGTZQv85tdEoK8gh3Ie9/5vZRovQsRkGjv1YMYhgUhnfuoj/AAPljgfR2u2eP4G+RDP
         a7oC1ypJyGObcZ4JUZYxTchTFdxoV542od7LIiBz8q5NbMi88t/coKIszdZ4Fx9ADZDE
         301g==
X-Forwarded-Encrypted: i=1; AJvYcCVuxpXRSjwSDl96i/7bdiVWvV359U+YmZ1iYpc+S5R9ims4PBnxzsc3ahj1zkR+AiFEXaZb8D3SVmi/10w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbbfab0aLXrVrf/Atu8+IEd2q63bpETUAiBHDJVxwdWGATAX44
	v3Kl5cQgPuykECB7vb9Lplk0inRf3hUwuCB6y0V/B3s4OEuPppRDQHTdYDzQMqRpHA+ZaMCjHkq
	dFywAWMpceCGc499gHcdZUW9ZFCFrSRyWy4/E1RNlDhP8k/FUy2gi4MMQYe6ljVeJAGhJek8UkK
	RbCqiKhg==
X-Gm-Gg: ASbGncuAFhR84mpWYUkx2NLCvw3bnOQ8vFJAFDckj1KeHLBMxprrxoaBH+d8eP/u6ZV
	YpBssgcq+cXPT9DNC0WUMf98J4z44X/+zQqjO1zRrqkmhSyX65axx9R2kii9/skUCQUOJzFPN5e
	bz2U443+pufLsBqRocj6NbUz3mYahIcCQM0/c7YfqgpWK+3spBj7lYyrZ71pzTNgnrHD3knSnen
	dqUouTXjznk4oDWvPfJCITI46YZgSpt6Tr6Mz95cKZrkfoF6jSVPfGjfueJOKMbkgfNeLRJgE0P
	qfBKPeh43Ay4YzNlOBaTIhQ+j2OnZ43H37fzlIO/AcXKuPwLxM7Eg29B
X-Received: by 2002:a05:622a:a:b0:4b2:8ac4:ef5d with SMTP id d75a77b69052e-4b2aab546bamr68378001cf.84.1755951426351;
        Sat, 23 Aug 2025 05:17:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnIKajDSfV7NO4Hfrf80vUm5NXdkjXXgtLCjExMGkFAp2FhrBW40tEeu25Y2rj3Y+K0BtRNA==
X-Received: by 2002:a05:622a:a:b0:4b2:8ac4:ef5d with SMTP id d75a77b69052e-4b2aab546bamr68377701cf.84.1755951426018;
        Sat, 23 Aug 2025 05:17:06 -0700 (PDT)
Received: from localhost.localdomain ([162.213.32.233])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8c618ddsm15429971cf.10.2025.08.23.05.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 05:17:05 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch,
	suraj.kandpal@intel.com,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/backlight: Honor VESA eDP backlight luminance control capability
Date: Sat, 23 Aug 2025 20:16:47 +0800
Message-ID: <20250823121647.275834-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VESA AUX backlight failed to be enabled becaused luminance_set is
false always.
Fix it by using luminance support control capabitliy.

Fixes: e13af5166a359 ("drm/i915/backlight: Use drm helper to initialize edp backlight")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
index 41228478b21c7..0a3a3f6a5f9d8 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
@@ -546,7 +546,7 @@ static int intel_dp_aux_vesa_setup_backlight(struct intel_connector *connector,
 				     luminance_range->max_luminance,
 				     panel->vbt.backlight.pwm_freq_hz,
 				     intel_dp->edp_dpcd, &current_level, &current_mode,
-				     false);
+				     panel->backlight.edp.vesa.luminance_control_support);
 	if (ret < 0)
 		return ret;
 
-- 
2.43.0


