Return-Path: <linux-kernel+bounces-807689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9ADB4A811
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36C1188761B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5979B2BE7C0;
	Tue,  9 Sep 2025 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvf15wQG"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E22D2877DE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409671; cv=none; b=STpqOmvdqZZEDGEcqpYLL8tJtwgURYovkVRGco/UJKXFWCSAVj3oJ/WTDu/gFJSlZ512qMAmS0Ne5kgjS4kiQJyA7fjjz9WElqT2C105fYNGZtvy0TXD8w68qk7tX3RUpYY3vG7/bxDGNonGPZkeyprdcrYlYie3Ip0HKB94QLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409671; c=relaxed/simple;
	bh=TysH0KcIDWtQmpgrnqprdLyER9+50qnr9VJO916vIuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QVN8Q2vqRFeeUSU3wZYGqvmP/QnIcsrxA9UWzuksxH1pqqF9wvqICDcEsEYrd0LkhAj5zu+jCGVK+7X3TBgWUeg4/KjUYQbVp/If2GIioh6El3EOL1GCdHBRoxereu0A6oGyy9lMMTnGAx+vlsk2KDKr0WFzJpL1QCR+EwGS1pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvf15wQG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24c7848519bso54912895ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409669; x=1758014469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKDAJyjAQ049TwS7OG7Kz3OMIFj6KbuH8cGsBEe0hLg=;
        b=dvf15wQGI5uYHdi+Hs4JOQQ5tyUrrF3HksIz5rEkPX94jws3/JEqtBFlQ6Y/a/Wk6V
         g8Rzry9WwD+BtZEmDxSHLT3QVnWPLXUKUDyJpDEJ8+a7/fdBc16hpY4eLBpiUTCuqwFi
         zU1RBhUJ8aGyeHqqikrPdH59VwZX71G7ARrvEG5n0D23JTT4Yv/jfoDMUk3osQuUBbQG
         CSB/rbvuUAaUPE+6P0xTxIgmtRNM5WVjQQfaQuM7S7y/527RvBE20hp2IQEZ27r6s2k4
         Gd8+z4kBBq+m04R4Lt+LjVkelfS+VsyM5rJrhsQqQdAP0jqC3SI8KKSAbK0tlu0K4ekR
         Nzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409669; x=1758014469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKDAJyjAQ049TwS7OG7Kz3OMIFj6KbuH8cGsBEe0hLg=;
        b=MWOPyd5M+NrI3W7ndcAjpF4abf0tZusOHbhznsliTsXGVyEF4LJ0a9po0G0YHrq5Sw
         BCtBnEo9SmeAsGhrq0/M2NGNkAAjCQNCk7IyyEkxvqxVODFOT7ZNxyr575ESg7dKV1oA
         czki4jWXf0KO5NNNPZEqDuThBdc9SucRCvvgxTxC5AIThP8+vcKeRNeQDLcNaELYikCA
         hAfhoTm8lHx414x2oAK22pxxODcHxSh1fJMYhXCiagLgO+LDOixnCN8RfyFJYNz/aupk
         B6VQ8/6Hpx8taxmxfPgUP9Y5dOsEJVP9DKJGaSEkaPRoAhH4vujsH+JJmz1ff1IXWxZ7
         V01w==
X-Forwarded-Encrypted: i=1; AJvYcCW00W4Q1bgNopO71wBVlgdwSZ243hlEPYDg2PwZcNTv27c5ybibC3306V1odEGZVCfLXIjDXu2APC4d8Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzINCXMiwpJTB5Oaw+sW1GQnHpSwr5y8qtg9sKsfUSJBs+ZdLz5
	xgXn2vxfItVkHhcYQw4Mo9L+2R+LMmhM2pLozE4lvUPbIUswf/uVM0eL
X-Gm-Gg: ASbGncshgZ7M+XzVjfOvLtToqXBp60+IzrDzCYQ6L0PO9HZZ2bgQBHpUFaN62oLx2Gu
	bPkcrydOtbJ+89VZsrHIFtytE1vr6adCYcyyP0Lgs/Ml+urLmvT9P12LqHdc3k8H0qdwT+eQdzL
	FLDax9OZOq1UauA2DgZrbEybWk6jzbIw97qfE5k/+5HFWFN6M8fTZGQae5qfyiHkeG8ofqSsV1R
	4q9+nkirFQD/GzqP8q4QZ1XYscXGG0v+SnvPP2mi9QXn+bt9aUzfNM9woLJrxzPv7542NtIb0aK
	AdK0rW6VzQ/Z5kh2aZW9elGQ0D0LBK2i4lpluXDiX0foVlyIBTyhShjddSg6nxrBPAJFcLfKuUY
	iOsyRExU0jgj2Xk1eZCsUmLE3gIDPYgXwy+H+ySd8wNgpThWxmSvjWv+zDOg+fEk=
X-Google-Smtp-Source: AGHT+IGaOl1wQ4PxTl5LanHyvvod2ptDH/j57RDM1rdkSlxdHYHqnMJKyWpfZPuecG3QE0g5+Xjegg==
X-Received: by 2002:a17:902:dad0:b0:24c:e3bf:b469 with SMTP id d9443c01a7336-2516fbdb555mr171735475ad.15.1757409669303;
        Tue, 09 Sep 2025 02:21:09 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25125d76218sm88522165ad.119.2025.09.09.02.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:21:08 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: austin.zheng@amd.com,
	jun.lei@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	siqueira@igalia.com,
	alex.hung@amd.com,
	aurabindo.pillai@amd.com
Cc: chiahsuan.chung@amd.com,
	nicholas.kazlauskas@amd.com,
	wenjing.liu@amd.com,
	jserv@ccns.ncku.edu.tw,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 1/2] drm/amd/display: Optimize reserved time candidates sorting using standard sort()
Date: Tue,  9 Sep 2025 17:20:56 +0800
Message-Id: <20250909092057.473907-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909092057.473907-1-visitorckw@gmail.com>
References: <20250909092057.473907-1-visitorckw@gmail.com>
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
Changes from v1:
- No changes.

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


