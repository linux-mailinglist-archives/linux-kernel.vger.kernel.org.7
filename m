Return-Path: <linux-kernel+bounces-782947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97748B32777
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 09:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0AC686364
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 07:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1582253EE;
	Sat, 23 Aug 2025 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9nA+RQz"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8C527472
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755935508; cv=none; b=ENksD7hS16DFXRNdaibp6XjgsyxHAlWt7CK/ApLOuhsp0k6V2qXTybxv3XJ6cMUpabh+24LGyI5o0gQu01LFwX0qzwcGtYnC5wMUF6SWENoa8VG1e1C3doAZ/lWIQEuqZG64uknvjfgP17wmBCgvQsHjj4XqbOR5oRPRavQC5mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755935508; c=relaxed/simple;
	bh=y4N4yq15xhN2drC+s1p6bVxQuNBLG6XDRL6YsoOMHdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KdzvibzJQgDc8KkjicJNBhM4Nb4H4lpLmkVx7Po1UvsjH6vgDqBG7ZYiL8zZjWd43jlyx9XEh2cOk3TlHpZya+mrVIFSoy7x5FGcfwMZILPbMXU0xF1WRCsK7zrLaAL3salG4QmKuHolF40jwkE2z6eTM7y2PSj88Ng5bS+J3W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9nA+RQz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b05a59fso21648485e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755935504; x=1756540304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sz2f2QFTThl8V+w+SjkMsQ8CHMm6qM1hpnb1DkeVvE0=;
        b=g9nA+RQzBYs/CIgbOvPBfGo2zNi5EvS9VCfuelMJZ5qaXYrq3UqGA5e4yekomTJbTY
         vL4FNbW2WOM9a53lu3u0R31+Mj0P0LCBcU5oBPEixs2zN2OIBheClJs2/WjIaYyufYUB
         LOhBt1jbXHSf+EvCaptjQTN1WsNY/jjT98L+L94O14NL61SlgQeXX4J+ifnvTzbb1l7j
         jo0iv08IEZ5lxQkUEIgrp7mZyHwZ0O2g5u4IYwpp9mFEy40WJ7QZNIBB4XXVRaqIG6j5
         NthZ/UX74rPN36kupGDVWTlfXW6mcftKWP2EZkqvGBJ4PYNxRkjHkh8ZxrzNhWxz8cDK
         L4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755935504; x=1756540304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sz2f2QFTThl8V+w+SjkMsQ8CHMm6qM1hpnb1DkeVvE0=;
        b=OtOyJjKOAGDfLlT/vFr2IMc5TS1GVQXRMI5jwWnHf70ThOOxji30CepHPgxMU5A6mk
         7wnSra6NJEhOsNBmqW+kMg1e7uzwnqpp1vGnj19QLaAge3CEv/1OA0TswJiYW7/NCsm1
         6IBRw6apNRLmktc5fsaoHWabnOz97sDnqJzsZve7/nnNJq8BMTXnSaRWaz8dMBY4EJgd
         0JuobVQSE+6/cjA5anpD+HJEeO5Cn2STg4peFtCAVczhMxnAMe28I6ljWKfqIwL7MkZs
         A/gTHRskDPMQDFfUPy39I7hklQvKqqvz/WXfLRhhffPj/10DhlfdkOruFJsRf00WT0r1
         nhww==
X-Forwarded-Encrypted: i=1; AJvYcCUKLse/+vh1f0OUqgW4yRwTXnGnMsmtPoJ3wukXyNFrE1vhFaFnRmPPXz2Ov6ur4lOR0zZD+zUX57YGsXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrTRLFYyapuGW95WgzFzRNEI6kQ2mJ53sfKN/ittcF3AjEf9jC
	l7ihscOz1BeBGWbICpV5xdO0P4Ll0Fws6ALWUTGMkY9EYPW1TNwx1fXC
X-Gm-Gg: ASbGnctWRwd5g4BycNi+Yg46OVhlx4kdAnpF8Buj0b6duL5oicfQRLXalXAKRt2xgZw
	pREAnxWttqJ3B4ZHRadWRBLthMSQL9kk8t1g4cUrhk+mL9bx6/0+NOtAFk7Od8bxMwWOG615Oeu
	Y9kDsR8iWtv/G+wmtS4UdXl81cdZCjVazaKTrleB561PNmJNQV/gq0FDdabcb2Ka3uu8ivoIWO5
	LV2wjGws93NtM6ost/Zo7i6dlm8imvJHbFZGjU+sVKsYc5Ti5oND3oECVRajgOjwvzDppFX/Y2V
	fPKFbbQwKkHEyqJPqBdn1A4L66OSlwSX2L0sDOjq6z9D0Qu+4tIwcAWBjBU8nljZE2Nf4GB40Y4
	xN9zWj0/m+S0fme9K6byI89y/YXHmC6n2aRpDEBabh2cUEeOBGbNHJ/M=
X-Google-Smtp-Source: AGHT+IE3RaqMrtRJ8FsQPb5ZzCK/iJZ86quiPA0MKkT6xRcXdlnZCzFL7JCYSdxXpZVPglPCYeosng==
X-Received: by 2002:a5d:6ac7:0:b0:3c6:cb4:e060 with SMTP id ffacd0b85a97d-3c60cb4e54amr2455902f8f.34.1755935503518;
        Sat, 23 Aug 2025 00:51:43 -0700 (PDT)
Received: from dell (117.red-81-33-123.dynamicip.rima-tde.net. [81.33.123.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211cd3sm2512295f8f.40.2025.08.23.00.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 00:51:43 -0700 (PDT)
From: Javier Garcia <rampxxxx@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Javier Garcia <rampxxxx@gmail.com>
Subject: [PATCH 1/2] drm: fix kernel-doc struct tag for `drm_format_info`.
Date: Sat, 23 Aug 2025 09:51:38 +0200
Message-ID: <20250823075139.34797-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Add needed "@" to avoid warn messages about duplicated symbols
as there is function and struct with the same name.
- The fixed warning is:

	./Documentation/gpu/drm-kms:360: ./drivers/gpu/drm/drm_fourcc.c:397: WARNING: Duplicate C declaration, also defined at gpu/drm-kms:35.
	Declaration is '.. c:function:: const struct drm_format_info * drm_format_info (u32 format)'. [duplicate_declaration.c]

Fixes: 84770cc24f3a ("drm: Centralize format information")
Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---
 include/drm/drm_fourcc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index 471784426857..ba25beeb28cb 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -56,7 +56,7 @@
 struct drm_device;
 
 /**
- * struct drm_format_info - information about a DRM format
+ * @struct drm_format_info - information about a DRM format
  */
 struct drm_format_info {
 	/** @format: 4CC format identifier (DRM_FORMAT_*) */
-- 
2.50.1


