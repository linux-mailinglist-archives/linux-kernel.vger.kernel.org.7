Return-Path: <linux-kernel+bounces-753579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79296B184D2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD9CF7AB1B2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C757D271460;
	Fri,  1 Aug 2025 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXbt7dKw"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06C26B75F;
	Fri,  1 Aug 2025 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754061464; cv=none; b=GX0zk13lMhEPigDCDMCTu52OoQjCSEPvH1iaJSLpgkGocntmwmFgWh/VWVASXvdys7x3Y2bq7HOKwXi6meINq/+mlhfH1K5Y6ACZ3EvGsU4vYNom4sdCG+JytEu/PGrzXYOrcNRL9qzF/DQo+rIhUBORXMi78fXVIl8mE7pJxhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754061464; c=relaxed/simple;
	bh=0XFJpofwPISorHtoKWmxA5PJTR9N1EmploFPYmOE0DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d64HRcifFYlIrrAE1W8UFCoPSnto23fFY7LnzyycH97gr/zwI46iAZ97/jFWEptFPbzICSItqhXz0NPbKLjgvPC6bJoh6f74CHKFbfcNH2dj/065hilCPr7ALzZpQr2LyXk/JdAcRadVILiM3eoYBdw0XEuEW38zOyS9X9XVsYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXbt7dKw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4561ca74829so10999605e9.0;
        Fri, 01 Aug 2025 08:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754061461; x=1754666261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1E57IOXM33KGklboNf9yR2RywI8PRQ2Op6eR7QA/9PM=;
        b=VXbt7dKwthriGkCp1qBZ3MrhNu/2cwKiOX3ofRbVLGlBHOreavZ2oJdIaTunTsrDzP
         i/BZhu4XsfVTl4YIBbBh1G1siFOUtc3hMH/0YS1HiDbmG7XtUnvHt/OaOxiZCVxZrYAt
         qW9HEAkwjq8gXO+S5mE6JjwjBXvrOFo/rA5wL4hZzC57Gc1BFHKVNZpN9GYq8w+HJJev
         C070F/AR5Zknahr6/G6UprYUUCcY9qDZ4eDqrNxo4QiTeSCS2pDp4FYXnKom5e914k3/
         8On/Vb89Ly/UhGRKdG78X+DwyCOfZ19LUqVYfOPAv4Gy8rQ+aa009f+QByR4nwwFSgXa
         YfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754061461; x=1754666261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1E57IOXM33KGklboNf9yR2RywI8PRQ2Op6eR7QA/9PM=;
        b=L1V4OgBsVaKL+O+WAh9YCEzsFj1nFEPG6XYOhP8mFfy3iRUSS9AtYzkaC1ZGgP3t8M
         p3lUQpphfjFfN1SPx1s4HBoo686zpvt2a0Ivx+03BM05We3qgsWESYcnyeADP6SbJdao
         5+glBzKEuxqgg8JY4Z1ObPXaVcDU1E9+SSGSkcih3Kmq7VtDSFmDgCPIIH5ezDQlNpQf
         Hc9RiWTpQfEjU0aUNOpKw6AgyuIF2ftoKGJQMobcVGsOyXhlse/PD7umF/zNocGl13Sm
         wEP32VApZGdcubp1YBl2PrjYczfIrncv+TT2RD+5lYsFoc+IYkK95PK9Q5W4JR2QqpGH
         DRbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKVZaPoLAWXABNcDm3Y8Tpbu4Y2lMvZZkJeNUu9tANIBz+8XtgXc3IF4JwUhsKK+nh9LA3NTcMo7bnsoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWXTUIYJ0aXBfHf9AjaUfkK5sOE/4uo0twFrY8cuMzXHpM0PG8
	yzv1x6L3FtNNHvfJ1NcJ75xkoa3CwxFwy1xnur4qbSlTqpEVtl9jnA5K
X-Gm-Gg: ASbGnctLkZ8h/4BKuQD6F5iXPjUXFODYGUGMy/Z4NXnzftPaWcoFuC6i3ZBHYymJ0ml
	KN6rpKl5InwfpXgDtV5zcmDcG3xOx5sV9suHCW20z6oMjb+fijIek9831rqRY5Y/iB9MxC58f5j
	FFSbDMRdn4jWEj1OHw6gN6rTQv7ZG9z24n4a+QL58UBmSX9uXxa+zfiSil5xdTKC3JdtBL9dQ7e
	LvWqKaH9MPqo4NZyE0nEz+fkeaqapCLUIqrHspVi9IDirJWBqyiTUyOH8z/U6gxJyxOlkd23zY9
	eNSkYzFStSw1kvrl1iW0/RVHG9ONzb6VaAyTFSP6PEwstazhvX7NsXPLW9Qm2aX18lOM3zv4JOv
	gKtan4lZiQ0nXKB5cZ7t0
X-Google-Smtp-Source: AGHT+IGvQuM9rEr7bK55M16XIZ/h5Sn3bJHPTfgaK19BoOh07/ewMbmlWBC7nIYl2set3+TRbMW5uQ==
X-Received: by 2002:a05:600c:810c:b0:456:f9f:657 with SMTP id 5b1f17b1804b1-45892bcfb1amr109220805e9.27.1754061460654;
        Fri, 01 Aug 2025 08:17:40 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4589edf56e0sm69231365e9.1.2025.08.01.08.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 08:17:40 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/i915: remove redundant repeated checks on err
Date: Fri,  1 Aug 2025 16:17:04 +0100
Message-ID: <20250801151705.2432911-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are a couple of redundant repeated checks on err being non-zero that
are always true because they are inside a previous check on err being
non-zero. Remove the duplicated checks.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c
index d8f4a10d71de..3913b48cece7 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_migrate.c
@@ -142,8 +142,7 @@ static int lmem_pages_migrate_one(struct i915_gem_ww_ctx *ww,
 		if (err) {
 			if (!silent_migrate)
 				pr_err("Object failed migration to smem\n");
-			if (err)
-				return err;
+			return err;
 		}
 
 		if (i915_gem_object_is_lmem(obj)) {
@@ -161,8 +160,7 @@ static int lmem_pages_migrate_one(struct i915_gem_ww_ctx *ww,
 		if (err) {
 			if (!silent_migrate)
 				pr_err("Object failed migration to lmem\n");
-			if (err)
-				return err;
+			return err;
 		}
 
 		if (i915_gem_object_has_struct_page(obj)) {
-- 
2.50.0


