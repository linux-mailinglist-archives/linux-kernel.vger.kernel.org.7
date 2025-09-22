Return-Path: <linux-kernel+bounces-827442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866CFB91C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D053B370E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6316027CCF0;
	Mon, 22 Sep 2025 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dbclt5RU"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A2C27B326
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552205; cv=none; b=H0HXmWReBIeAObEXpKH//7MCS2EP6nt5lkBjsQolp4wRXZ8qSVRhnjgeAD2dZfbk959D6/q31K2cS72GG2ZnvqqG4yVelpTIEk9Kx4A6/yYIc3sYtxZDbRi3oWEegTisQr2GSfsbGFJvVeF1t/23pGkGHS1tpvaLlfqSdXkUQFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552205; c=relaxed/simple;
	bh=01eLBwKsR2MPC5ljxSM0eM0q4VqlpbK29DMtnFjku3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aidj1O4MITAiMygBSBmtHr8wSZEeMWIN7BmyyDtSDdffFTtahfsmYo6erzL08U34J931xJeBEG5ALNWx2tgpFzm58wXrNnupxwV/zfa06Cn0k35ChiTEg4iABBsTZErUIGfUAul6FV2XIC1PAwDqvd9aOuZ+bLckNpXwNx32VNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dbclt5RU; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3635bd94dadso34716091fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758552202; x=1759157002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F0lMUB1ROfKuK75/vGdOophe58nNykYwwEOWTGObV+k=;
        b=Dbclt5RURZ5S3nBkBhGAJfnMXY5irBTsOgkqqkhfsEqo9yqiNRnYfnMkgdpnenNIjV
         95W7EqA3Sy0V9DEdK8H4DNqF91pKTaVo59yND4P9gszI62iSDxf7qVpMIWLYen0W6UGQ
         iC4J+Ej+d5iqAnl95fWncSOvi5/bA/yWr40pO+SOWK+mq9MPzUDttyxIczUjj4qIFqZB
         uPAB4W0wX+jmuSsRZXayXhqHEBlRsUb6s/5d9trZhPcEZMDO7rRqnWS6BZSVtM05I52w
         A4bnTYarvAfCEYoiIAktf+IrlGKiPtKbWDAa44kCvnAEmAt3jPPba+dj0s53JN+POOth
         UxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758552202; x=1759157002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0lMUB1ROfKuK75/vGdOophe58nNykYwwEOWTGObV+k=;
        b=lLgCVfzCB1YIotUuls9hrRVnDSTcFbkOqqjclLnAR/uJFxYA7AyTSWzhh0jO+Wr6XJ
         e+mX7kjWa8BNJb3dyqtYsQemYh+RN9V8FoD5JPqNIuHJIMJSQoxEjWZNdkF3vVCrWZcR
         b/ePNWqHdS+OnQi/RabO7Gg7hg9dDCPLN8haYUj9YGXeghQZWyEtXtb1bAUlCplVt556
         hyg3uEStAnGp3IJPSy0xMRqsYfcgRH9Xf+9idNmxweFUc49JhLW1OE4DBp6PkDRCPJhI
         1QP8IFdNc5YNgboCp79Y1fGYdfVIfKq4OgGrlcsoLaJ31bkwGTQhNb/eDxDDx5Y/tqeJ
         0oKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeapxDRrLx48MmLu9FbF7VK62s7WGDPmCXdOTTUW9IzemWFlKRtbcXyiVYG5VJUyI4WK6Bl5bW//RGzjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu+d19uGFbNYYPvR3Q0hUpuTTBSEqdt1Zdo9iEuZmVJ/d92M0S
	FFROcSEnhgz4Pr6NoiRLs/H6FcVSjxbhtGOAHsukbBZzdYImc/uohNyJ
X-Gm-Gg: ASbGncvDJPlL5Moh3nBo5lQ5sWDT2lFo/8exxFkpOWEz/NFZANtCSNUtMTaU7rM3sLI
	1OIbUm5QCBycaiJEnN1YSSz1HFr4IUGUg7vOtin3ivdGxhGraEi2i8E3bXX31dh353CgXqSTT+M
	q4CnpuLr9D09JW56+IYzcPZ/tBgT/i0bNfSB7iyKKj63lZtQRJdqUTpigHbWBhjJVuOwYwMMIyy
	5Vf8w8KyUy7cYnuSjyoL9i1HUllXYDykTORM6PpDSR4jzChiTY6Y/CbOvKpobW7yB/twb5KwLMj
	NFQQVphH9g7V5NgM+7NrBYGRF5b3GufARiIpZHFnO2VLJZFYE6NxGQGGEtQ5WjLLpb8k3qhcVXX
	8ilXwVA5KhT7UWAppIIY3B8KJFJi8KfV/6RkozvOpJUlrT1osIm3KOtiKyExPsl27+gHH/icmA/
	0Ipaug99JWN2iYil85
X-Google-Smtp-Source: AGHT+IG0k8GFm/GzeFNoiWTic6tM3XN6hehF7mLWcX6QsOfPfppRRO6H9eJxef5vfYTewNG17se7sA==
X-Received: by 2002:a05:651c:545:b0:36b:4cc1:15ff with SMTP id 38308e7fff4ca-36b4cc116b5mr18512911fa.5.1758552201998;
        Mon, 22 Sep 2025 07:43:21 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3673e015747sm15960611fa.62.2025.09.22.07.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 07:43:21 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	linux-media@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] gpu/i915: fix error return in mmap_offset_attach()
Date: Mon, 22 Sep 2025 17:43:16 +0300
Message-ID: <20250922144318.26-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

Return value of function 'drm_vma_node_allow', called 
at i915_gem_mman.c:670, is not checked, but it is usually 
checked for this function

Found by Linux Verification Center (linuxtesting.org) with SVACE.
Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>

---
 drivers/gpu/drm/i915/gem/i915_gem_mman.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index a2195e28b625..adaef8f09d59 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -706,8 +706,11 @@ mmap_offset_attach(struct drm_i915_gem_object *obj,
 	mmo = insert_mmo(obj, mmo);
 	GEM_BUG_ON(lookup_mmo(obj, mmap_type) != mmo);
 out:
-	if (file)
-		drm_vma_node_allow_once(&mmo->vma_node, file);
+	if (file) {
+		err = drm_vma_node_allow_once(&mmo->vma_node, file);
+		if (err)
+			goto err;
+	}
 	return mmo;
 
 err:
-- 
2.43.0


