Return-Path: <linux-kernel+bounces-817070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE3EB57DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7C43BD2CA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1377A31D742;
	Mon, 15 Sep 2025 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpshFscY"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7E531A551
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943650; cv=none; b=XXGjfjXskvwa6yb9Rmv8chQkqWJ8mZpF+J49sH+JmpzblyskaGhmGTt+kyZ14D3RBLmy8c/7A55nVahrwaxoDPgefrJO7S9sCzhYh31aGEmjN5EDMIC//Bsnv/3oK4HW9Z/a3M3iMjQh1NinXGC6WhNVVz3/7Ett319B9MnY16c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943650; c=relaxed/simple;
	bh=e6KwawUHwlDsoeQfcPpKLB3WBKhMwuphbIv5QMaRw6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVF1dqz2VL9lHDQfuSfLtoFNWybZ5m1l9S3Gj0G3gdR5m4XxLmuvQKmhVNUd6kSDVFea2hK+YTHyQkdodawX17n85iTj8Es9xI+3vETYVogqjnB7ifsgEXveZp/DRQ6MzUtTeVWqb/jSuQtrR+DXo/YQ1OSse9tH7NY9/dOmzgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpshFscY; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f98e7782bso5135946e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757943647; x=1758548447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3k+HMxvoSODNJg+aOvvtyLIc8HnLU1Qgi5sDsLaNJTQ=;
        b=NpshFscYGtaHviU0tXUkI9jsUViss2iC303a/qDCTp9RahGIqUtdJTzsBcM0FZOHZ5
         BJoi8tfxokZ8pMpOmfBIbm3PRGARpY05/age0DBTd03Wp5ZmwIqZhuBIchmmuVhk85lT
         BsWXD1vEgoudRKSqrX5yxA78uHeYoX2VxV38tI4Juotb5aQpGR1f5vMes7DXWRFMC0gT
         6sDX0mfOErr1Jpfyvf0DtRMtiFtGcFVqfVhG2W5oIZi6I50v4e5wMSewGfnFFimbW1JY
         07HZ75DxEIAinAMbc4QcFA9vf1PfWbGUqzPKViG/qb1qjPyuR0J+wFjsh4CJ5sz2tEmu
         3Hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943647; x=1758548447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3k+HMxvoSODNJg+aOvvtyLIc8HnLU1Qgi5sDsLaNJTQ=;
        b=VI2swb7BJ4iYIc0xHJhRd4n/G9oUQgVoiK5JpoGjVunxWCVcAh431OXEuxTl7xtkVU
         EenbYNRKRI/u/0LwaJzd4FyxWOJwl+SIGqcB5ESFyGNrC2twqdY2f5so3qxNuneyMdJ+
         +yj+he0Hz8U2VAdCILTV8n1yi9uRx+UoHLxl6RT+I54iI+wh37eyvXZA+piC/SeF59kG
         jvWDo/Y/dvcdS2fAnr6tFB2YxKYvwdwXSWsO337pjYc7O2AS5DE7KHlENuzUp6inQL/C
         HWoInF6s4ACYSrB1N2iZqY1dOd/9REjmkdztTWxvXj52uf3m7qqixuzFcJPUhjGCPf7p
         LXrw==
X-Forwarded-Encrypted: i=1; AJvYcCX02cqnS++79+7N+5+0ogBI9iv6f3uckFljAAm2Ji3o5+0LpAJYosldFgUEhnVGQCEOr4nx019/hE17OVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwClms+nn40qQo9tLJFaLB0d7TzQmAy9lGdkKBj7iVBuD31UPo0
	XudoLetwPJExUfah69W9LpIPTNCnhtvRE6tlrvXONPc1AwiVqW/uAjP9
X-Gm-Gg: ASbGncuNupJoiUch/L5UrsNC+HTaHQ89HyYpfOh5Ymm2Sa7eWHmSEAoqD8nPErAOIeA
	nqDRe530SOHCd+OOIIjOjI3H7fvbKVhagaL6uSEFmo2gASSqPIAn1eH3ENCdW/+ha56Q3iAOIxQ
	9nYDL41onqaURKNHB8bswMI6eKI/v/euYnGc3S7AjyC/yob/r7zU4IDYHfX6TU9TPFDFn0u/fWv
	x72o99zvua2vGt9GfQD3l8pCdpkopK1pyF0LDHL4oq2OueXZz5Fr/W1Lun+/crI+iCBM0LNVRSv
	vfZ1wWtPe1TocK84M6r/vn+Bg0MtbP8VB18f4xRU3FmVuAaiQKJyiA23x5OPEhjGelt98gvPWbq
	L134mtd4hrGnpJfLNCLmnB8gGERk=
X-Google-Smtp-Source: AGHT+IERKcOtfpXRTiN0QLo0iio7095LVUAyN+kLUsrBNmWW6XKvJmTj2p0WgeUQPLxrRtNOxCYwTw==
X-Received: by 2002:a05:6512:ac8:b0:55f:3ae4:fe57 with SMTP id 2adb3069b0e04-5706133eb11mr3302428e87.20.1757943646550;
        Mon, 15 Sep 2025 06:40:46 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-573c8330e54sm1150719e87.63.2025.09.15.06.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 06:40:46 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v2 04/10] mm/vmalloc: Avoid cond_resched() when blocking is not permitted
Date: Mon, 15 Sep 2025 15:40:34 +0200
Message-ID: <20250915134041.151462-5-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915134041.151462-1-urezki@gmail.com>
References: <20250915134041.151462-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vm_area_alloc_pages() contains the only voluntary reschedule points
along vmalloc() allocation path. They are needed to ensure forward
progress on PREEMPT_NONE kernels under contention for vmap metadata
(e.g. alloc_vmap_area()).

However, yielding should only be done if the given GFP flags allow
blocking. This patch avoids calling cond_resched() when allocation
context is non-blocking(GFP_ATOMIC, GFP_NOWAIT).

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 49a0f81930a8..b77e8be75f10 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3633,7 +3633,9 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 							pages + nr_allocated);
 
 			nr_allocated += nr;
-			cond_resched();
+
+			if (gfpflags_allow_blocking(gfp))
+				cond_resched();
 
 			/*
 			 * If zero or pages were obtained partly,
@@ -3675,7 +3677,9 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		for (i = 0; i < (1U << order); i++)
 			pages[nr_allocated + i] = page + i;
 
-		cond_resched();
+		if (gfpflags_allow_blocking(gfp))
+			cond_resched();
+
 		nr_allocated += 1U << order;
 	}
 
-- 
2.47.3


