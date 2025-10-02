Return-Path: <linux-kernel+bounces-840020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3A3BB3587
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 10:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD471880874
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 08:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7C32F1FFE;
	Thu,  2 Oct 2025 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG2OsD2p"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63902F0C69
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394916; cv=none; b=FNhztlhWaPY1965TxLVNoW0vTzVhMsB+XEiYrZSAYnk/9ghcjI7O1l1I5pj2E0eBcJzhWSSitM1IwrE8tDNfWHaE9wV1of1GXGR/5WAPNl0NIjZ6k8+xj+r+VVsTQzWbK02U9vResrghNulYFgsOTWuRyroWxTvmdicrXdlq6WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394916; c=relaxed/simple;
	bh=5XEzoo2HfzAUhZ77KJ7gqJTgs1GrYseR5LL7SGMhOTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+ZGhJaDoMDSxozQ12Bn69YohLcEPE/PUnVTZC6nPzAYNzqpQFR1XbHcvVbKZDtpFJk6kEi6B2AmyIhiqwoGF+Vpir7tu3oP4H5nuw8LFAc3Rwt8b+MJHSMu5PAmzz2tb4L0MvEAVDjsF2x4n+UkqBt5rLj/VHkR/FL/1okHwtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GG2OsD2p; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-367ce660b61so6618891fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 01:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759394913; x=1759999713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z69FFVofVQpQbXPazzIrMIWvZw9YVt4e5mOAMA1/qQ0=;
        b=GG2OsD2pj25nBWg2DiWnZDkj5WklapFP8mmyKqLDIERBYVpP4s9lpVjBPXTxTtUNjP
         xfqRoZvBkTg3GHZw9hujqER7iOEoGv3aAJ+LfoiraxAQ86L9l8IjHOv0SaASAOs5x7qb
         wxc3jw9Ga50WFDetpMKHXfc2WuCJvj54D2zkMje6zjb8fr2AB9GEk4B6fT9ShlP9UVaT
         R7Yz8IVyG63qqmI+ttb8e1jvEckV+kjdhPWDj6T2k/0+2wnog9VLigwu+5xSFI2W1IEr
         vVw+y8kp/NSYN7/LBmJokzkVM/KBMFBWm4SrA8t4rpyMTGyfZXMQNK66KeRM8LIOiDZm
         /g6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759394913; x=1759999713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z69FFVofVQpQbXPazzIrMIWvZw9YVt4e5mOAMA1/qQ0=;
        b=U241pP/d8Q9IyhjdocsiyyLzixwQRg3y/stlL4drVshU95k11vwbJmDmElGAcXsGnl
         JJBzKglYnvTRSYw8JgaLHjzMt118ssna8LxcZf2DyIccu0SDoz9FqljV7GTmlQhnpm/e
         WPrJJN5Ih1IerQpHazScGQA/UD71jxfVZBEyl20D7g2PaYqEIQ3EoeMA3iWNP27g5k5Z
         WI9/JLHRip7OIpBspPtOP8OyLf9LcGUCLiQFzt2eVjdBDPrj1QZXGVqK4FQpdd6EpPUC
         jB/LT5ZN0jDHRhhaoKn67iuTopiTS6Vhh8MAul0zlefSy3oellUXKf5vN2cmU/6FskBe
         UVPw==
X-Forwarded-Encrypted: i=1; AJvYcCWL7TUa/gJDydIDOk9zf3x2kKjrt+TWPrKM/GwFQK2pdvWIcl+NzEq0YeFIyEOxz6KlRGbmbQc1kAYnAiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxcIS5OARqWNFDd+IaPLg0bpvbze03fPnzpUCvwqEzUpUBBnuT
	Krw/q7A/Ny4R+YCHZitmDQ04obxBeV7HnVhlM/DKC8Y33L5vLV5k+rFP
X-Gm-Gg: ASbGncvuHHZ6qwN2u7zoLyZIWhT9YgYKv57KfOL6Q2T5zAq1fs9gyVhWqgDo9AMpucD
	lVsodcX0E+51Q2ZvB9nwMvEF6Hwz3EqC2HRUNF/XQfr7X8g/AQw3pJxsoIYbcU+id8Dt2J/XZe6
	igk2o2+h51IvduwVuAVzayctRULXif+fputTyd7LPgkzpUK4F/klidGcCMfSW+LCKOQuMW2G8wr
	un8jOKk/WlmZd6A9lkq+LU0Z6Rvek5Cgrzgd83yZ24Qd4bLVSJB7u9BI6yQI550IUNk+KRqkZoU
	x8iz4nD00Tjb1F67T+rGWd37V4oH+EBVZ8VC0Q3k5/xRdnDL3zm0QZmaefwKd3/TWRFMggqDCRf
	Vr9RZGZB6L15N7il6tXoMrdg/vPVtjEpcilfPC28WU+61NRiWhtGbX9fS/8KTUA17AG913U+dGP
	5lbUIUt4HIxCgi77Aux6h1gTaIf6MuADY+kRkQU3y3
X-Google-Smtp-Source: AGHT+IHSpWYO4jWecZ3WaJ5bbAKSHrzDEFpF/Bo9oTWfMoBxUJCFoeCGVTF74e3XeZ0egpGJ1oJ8eA==
X-Received: by 2002:a2e:a912:0:b0:36d:501:76d8 with SMTP id 38308e7fff4ca-373a7430622mr20975301fa.31.1759394912620;
        Thu, 02 Oct 2025 01:48:32 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba4cdf62sm5338621fa.51.2025.10.02.01.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 01:48:32 -0700 (PDT)
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
Date: Thu,  2 Oct 2025 11:48:26 +0300
Message-ID: <20251002084828.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

In the drm_vma_node_allow function, kmalloc may 
return NULL, in which case the file element will not be 
added to the mmo->vma_node list. It would be good to 
not ignore this event, but at least log an error message.

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


