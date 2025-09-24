Return-Path: <linux-kernel+bounces-831246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79202B9C2E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31033A7860
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213B632A83B;
	Wed, 24 Sep 2025 20:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHhB7NC/"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4532A3D7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746656; cv=none; b=dA14Df0gNPzc7v9sK/BsQJtp2XhxPiGsQcz7+6CWCNVbfbsWrdBMs/Ox2UA2Zt1dV9wcNMBFM0246xsZu0sX/H42oFJJOQl1E4IsYO5k0FNbo4iCVG8SMmNwEkUAMqNdN1+aWdZEyK4SsN7H+Oc9nsWvzzqstSzHlxmPZawSCQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746656; c=relaxed/simple;
	bh=rLdTgabQLvaSZYc/G0W7KRKvbYbATT4C5rij4oJJLSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKyE4mzIeu75+o8z/yyov0hl70y3mQFDFPg62QbUtEXgIevOCdbXCXQQqhTyPQCWYgdbn1qMXBkvXOJH3OQeNY69Nlr9SsdEkA+YeYg0xOqeqnbwwKQsgdAFpGeHD4Qe9nu1opRlOqKk7ilKGzBxhjZiWxPbd8InVXPk5lYrdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHhB7NC/; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-eb37bf1aedeso222609276.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758746654; x=1759351454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4V1oA69S5/U/dB8iW7L3zhYtpO3CQhgmwVtBdZtozY=;
        b=BHhB7NC/x7jNl43mNYEPtc5XaqavK3mO5xgDDggkAdY8e7V2zYG/cbH1kiGbED6lu2
         q3jjfTGKNG0Xl73e152vSkxm9Me1KjOXtvNKaxvDuio+tQTA9V7L+nop5t8M4W4oCGcr
         47v5uNHk4UVONVqXAZka/NRawInxwHsN44UlOtWprTI8FNt7qtVrX5T06VNwSyw7LrIH
         SO6eeO76fZUlgMycmXWr59mSVDzCcMNF/jrk7cfKeS5JUteBthcFilkG5Fj6CTIBi2Q4
         1HrIzKDZdDXY8Tdx9vaQRFKEYGlmBcPMd5oEDPObeqlLSfnDXzfFWx9Eo+jxbjVWleP/
         1T/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758746654; x=1759351454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4V1oA69S5/U/dB8iW7L3zhYtpO3CQhgmwVtBdZtozY=;
        b=n3htRJNH1BTPaFu34f4ZdN5rOW0TskqeoirXbkyBlFbTfjq7RRKyqTsyA1RoxObaNW
         H9xy7vYL5KikKhNMnHUFuczfsRpJRjpOH354mCQD1ytULxJrWg7wGsV2ELoNLV96hsNM
         ZSUw0MW2GtjWfiLJLgvLBpErL4amfs7wqDVxRlCe9xxs1O+LdKw7sIPZxf6e/iB7EEHg
         9GGnVNSq7fZQSdAFRtXH5ht9YmIHtiUOCiNX3ilVXtCdkVxv6gHqGr5HcDIaBIYYlq+a
         MX8LuVli1SDH7DLSgAsL/VdlI1eU9iLe94tYxAU/PtmcQyW6Hb2FMPxikYA7d5b+Q6vK
         glVw==
X-Forwarded-Encrypted: i=1; AJvYcCX2SwtZyiBcalE+QJ+GvupdK0Aqxx/MsD7El2F9chPYMr5gZ3futMdhNHgGqkZFHUe2M7YA+fnT4j3gF+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygc0JlzhD1lWA2/xHUhkajwc+MmGUSTqx1xedRpU60uj7p9VmJ
	yVzQCF/Qv1x0RQpgG7qRmakT+N7RIrdWEgOAENXosFE9hqA7Ilo6vtwE
X-Gm-Gg: ASbGncvB4vW5aNiWTq/wVVS2DBmGu8RzEGsUqnPQQd8vuBGvlSKuokII8bIB2VRj5mt
	/ODiYH7MJW44OIoqLpyRU/1b6qINDfELVOs1+fv54tLvnrMbVZmJPT9rz13OfrbnE49TALkRpPo
	9zdVFriLUw48AI19MDoaI3nsm6/3UVR4cRE9c3kW4zta/QGl4ENbL06f1P6RVBbH+Z7VM3rn7U6
	mAW0QhXMD/6A7WO5iuCRg8cUnrgestWUG5YXTSnFMAguWtLU/NEG5x4V3T/4O7/89k2IXgck9IP
	xSFNfkzTKjkg44IcqpELnkInjGNZf+4AI8y8YoLv630xl6LWwaJ1JZ84l+/iZBJ3Kllc8ojatlk
	dB/Drm3tEtoz8PJXFE+3tsN0PkslWPifWXp0G1Y+uFkgRqSXIMYvgTA==
X-Google-Smtp-Source: AGHT+IGLWIGeDS+w6/c7P5M+l3Y7Vr7lTF0TwgiRy/gr0sq1nGvpvip3WbgwHrGGfitCUV+W85wdEw==
X-Received: by 2002:a05:6902:c0d:b0:eae:2d09:81f8 with SMTP id 3f1490d57ef6-eb37faebc56mr1349150276.12.1758746653799;
        Wed, 24 Sep 2025 13:44:13 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:44::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-eb38384dd15sm18230276.2.2025.09.24.13.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 13:44:13 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v2 3/4] mm/page_alloc: Batch page freeing in decay_pcp_high
Date: Wed, 24 Sep 2025 13:44:07 -0700
Message-ID: <20250924204409.1706524-4-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250924204409.1706524-1-joshua.hahnjy@gmail.com>
References: <20250924204409.1706524-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible for pcp->count - pcp->high to exceed pcp->batch by a lot.
When this happens, we should perform batching to ensure that
free_pcppages_bulk isn't called with too many pages to free at once and
starve out other threads that need the pcp lock.

Since we are still only freeing the difference between the initial
pcp->count and pcp->high values, there should be no change to how many
pages are freed.

Suggested-by: Chris Mason <clm@fb.com>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Co-developed-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/page_alloc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b861b647f184..467e524a99df 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2563,7 +2563,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
  */
 bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 {
-	int high_min, to_drain, batch;
+	int high_min, to_drain, to_drain_batched, batch;
 	bool todo;
 
 	high_min = READ_ONCE(pcp->high_min);
@@ -2581,11 +2581,14 @@ bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 	}
 
 	to_drain = pcp->count - pcp->high;
-	if (to_drain > 0) {
+	while (to_drain > 0) {
+		to_drain_batched = min(to_drain, batch);
 		spin_lock(&pcp->lock);
-		free_pcppages_bulk(zone, to_drain, pcp, 0);
+		free_pcppages_bulk(zone, to_drain_batched, pcp, 0);
 		spin_unlock(&pcp->lock);
 		todo = true;
+
+		to_drain -= to_drain_batched;
 	}
 
 	return todo;
-- 
2.47.3

