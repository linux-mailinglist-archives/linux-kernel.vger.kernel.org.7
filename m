Return-Path: <linux-kernel+bounces-783760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D702B3320B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 20:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B7E188EBEC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 18:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AF3223335;
	Sun, 24 Aug 2025 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nh5A02HX"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16A01DF248
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756059853; cv=none; b=TqHaa4R+pHKqrL8GfQ58b4aSfXShlEwmoETjClBmZmwld9pHricu/iny/OcsonXwlTz/dOpm8OB6YT1KELoDfpD5fZ/H7x7zWSrKe08DyBUoaYBGV7qxEP5S9HJkNsw2MLmJhXx81hVtrA71gX9ot/G4oyPyurslB+KMZI/4ZDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756059853; c=relaxed/simple;
	bh=5umpghsVLHvB2BsI0p8i+BZO8l0QUN/lne/qBEkpRmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RSVOVc+Oo16EYsNchVuV5RQUGcNiRn8p0LtOm5g5WRzEO2ciJ0vGW5Nqh3lEOfHbalcKVrrVUamhtnmIpIlmKs2ZvHOj0ZGHwmxYM6dzTc331foUY3nlDBiWastjkkwWViLgjA5kUa82bMhQtaGZKakU3/+KsV04Z3x/ego6loE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nh5A02HX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-246181827e9so26582035ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756059851; x=1756664651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2v1IYFTL9EjW4OmXMSiVEBKcc5tiC6DS+GF23hLI0E=;
        b=Nh5A02HX++wviGd6/RCKy1V3yl/Xamwh0dTKLDmaGTGnUYiV/TDEe2Lbzz//mzJY3X
         sFQa+x1GVNjJ6CBGlxhHtM7JD1RuFM7HOinbOMd6kBnloJW/I1HAVoxKuBzs45y26T/C
         pAbvwsWfhZEBh7VMu0b+5ju7zWCXGAkJp5GrogzXdL6+sMgxWokCL2Mi3S4hVu+YsGFN
         pbFBRTrr937FfnIRKz7AUcHIJE9xgMSUI6m4wGq3o5lZrbm7d6Rc9Y4Np1G+//fQ8oCR
         fkwdTD6RpFjJWvVtqLBhU7A0sV28ADApA92DWbfjo+wBV1Kkck5CoSzPu/JcN6i+2V0v
         l9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756059851; x=1756664651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2v1IYFTL9EjW4OmXMSiVEBKcc5tiC6DS+GF23hLI0E=;
        b=cSH1UHHoTPixbZTgPxYK+coa5E5kJGgAQvRDExIhS06g/mHi+L9LAGyrr1PLpFHQSj
         6SksyaobC89tDKcV4rf8t06aLgq/De7wFCMs4CBLlAShn4ANcQMui3tUIWwfcykq4HLk
         e/uYyxxssxg+1CuFbhLXGaZfDH35WmpygdUsBvoncvvLjOHE/H1n+2a8cEzT2SBSD5k1
         llwHNGOUwANrUjvP9/wYqXVET4NaIBtpMDoX11u0lmt3fKdCwpbUdRbCzBXhDj1XTkU+
         fX2tkPdvad9vyokU4Hf6gvhQ+HMEbe/l2WHTl4PrYdSFLBragpHwXzzIcPYE8mTxsGQK
         D5YA==
X-Forwarded-Encrypted: i=1; AJvYcCXZUwCGmMiGn+zxUZZjsPum6fr507CCjrbz9CJ9lfHDFSd7RcfNaIZqn4H5XE9oHI7LfJKrmgIxsxPU1iA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/mDksR7qrXSRz5YDy5UwzK8xEEfghkrGQjGHV7FLNAlrJQUT6
	lcp4vfmElQI6L5oX89xvkOGk15kBg2yy35/qPN+zWFoGkzKi3I3qMnOYEiM/HbiM
X-Gm-Gg: ASbGnctxJAg43K+JF5lw9kf6oOX+hSBcEcufR2SWJhS+Ozj7hsF+ohQdtz6TOWy8mky
	6ejnNeLqqckX8tS6y2N8n9nKDS5q5u3U4mlbue3SfyXr6af+3utxOL8zCnruVd7CPdh7lqmrXDR
	O9ecohvE8+Ffv3VqmVHHSoC8VBCF7K9LHMj2DFJaR7HR2goXbJ2jIlNZNRAOSnVr2WZUY0QEqgd
	dRGnjsCRYb1FlnuR22Gwm4PFmnSUj5UnfTVGiSieIvaWDBu5TDOubPKAkRcqKaxkTuBRGM/zVbZ
	sz5ZRHSmUKjyjj7Dv9lMffJElvr7qwdPVAdQN3YOQ44st+Esx3ts+Ixh0Pt++Y/IF/XdKNRebVN
	9kpzcOxMh/uyc41pYnu9139vCgSikiRlLAVqpljceQW2KzfP5NvcwsUYfx7c6DzI=
X-Google-Smtp-Source: AGHT+IEcmIAoNLGgWs51AJwLfXP1RCoyG3ATRWOL86MbvJbfx+dgqpWtFQD61mP3GyAan2qMIob2vQ==
X-Received: by 2002:a17:903:46c5:b0:246:7b42:a223 with SMTP id d9443c01a7336-2467b42a323mr57162615ad.25.1756059850757;
        Sun, 24 Aug 2025 11:24:10 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889f11esm47903635ad.150.2025.08.24.11.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 11:24:10 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: austin.zheng@amd.com,
	jun.lei@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: zaeem.mohamed@amd.com,
	wenjing.liu@amd.com,
	chiahsuan.chung@amd.com,
	Natanel.Roizenman@amd.com,
	Daniel.Sa@amd.com,
	jserv@ccns.ncku.edu.tw,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 1/2] drm/amd/display: Optimize reserved time candidates sorting using standard sort()
Date: Mon, 25 Aug 2025 02:23:58 +0800
Message-Id: <20250824182359.142050-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824182359.142050-1-visitorckw@gmail.com>
References: <20250824182359.142050-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the custom bubble sort used for sorting reserved time
candidates in with the kernel's standard sort() helper. The previous
code had O(N^2) time complexity, while the generic kernel sort runs in
O(N log N). This improves efficiency and removes the need for a local
sorting implementation, while keeping functionality unchanged.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Compile test only. 

 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   | 23 +++++++++++--------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
index e763c8e45da8..2b13a5e88917 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
@@ -2,19 +2,21 @@
 //
 // Copyright 2024 Advanced Micro Devices, Inc.
 
+#include <linux/sort.h>
+
 #include "dml2_pmo_factory.h"
 #include "dml2_pmo_dcn3.h"
 
-static void sort(double *list_a, int list_a_size)
+static int cmp_double(const void *a, const void *b)
 {
-	// For all elements b[i] in list_b[]
-	for (int i = 0; i < list_a_size - 1; i++) {
-		// Find the first element of list_a that's larger than b[i]
-		for (int j = i; j < list_a_size - 1; j++) {
-			if (list_a[j] > list_a[j + 1])
-				swap(list_a[j], list_a[j + 1]);
-		}
-	}
+	double da = *(const double *)a;
+	double db = *(const double *)b;
+
+	if (da < db)
+		return -1;
+	if (da > db)
+		return 1;
+	return 0;
 }
 
 static double get_max_reserved_time_on_all_planes_with_stream_index(struct display_configuation_with_meta *config, unsigned int stream_index)
@@ -634,7 +636,8 @@ bool pmo_dcn3_init_for_pstate_support(struct dml2_pmo_init_for_pstate_support_in
 
 		// Finally sort the array of candidates
 		sort(pmo->scratch.pmo_dcn3.reserved_time_candidates[stream_index],
-			pmo->scratch.pmo_dcn3.reserved_time_candidates_count[stream_index]);
+		     pmo->scratch.pmo_dcn3.reserved_time_candidates_count[stream_index],
+		     sizeof(double), cmp_double, NULL);
 
 		remove_duplicates(pmo->scratch.pmo_dcn3.reserved_time_candidates[stream_index],
 			&pmo->scratch.pmo_dcn3.reserved_time_candidates_count[stream_index]);
-- 
2.34.1


