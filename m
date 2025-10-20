Return-Path: <linux-kernel+bounces-861391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FACBF29BE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2103ACC36
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FB932AAD6;
	Mon, 20 Oct 2025 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Mn1GWW/A"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBCC302CBA
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979986; cv=none; b=qf9JDsVE3UfDY8QAe2QaJWKnCtWqq4y5lP5nYmjN8pLmBqv8roC6KGuDa9HepOHqWJ0X9q3bRrKsm8L/P6LI7xwzsKuGRNnmQosz0BBwmTFJML1vBtsqwNzFxwf9MV4jq0pvbR1RYhyBa82kCYa+Jr6pyagiYY+IYfS1MeQwUlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979986; c=relaxed/simple;
	bh=QgYcIbFLeCBFS78eiCOh9eibxN5S3fcKWebf72YjRdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S/qg5FKbRYorAYxxxouibVdmQdS7zz6uMBIocVXxGun/snrk74VeQU5YGEv2PTzY9JkLaJ3ehmOHAXfYJJbfj+yRtOZhI9OL4TrNGsMpsDffEnGDLqxeCP16hi34+wPPsdzK76rIhTfW7H262RQ0duhk4XB4xgv6W5gHtoLzOxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Mn1GWW/A; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8906eb94264so619821485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760979984; x=1761584784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TFkTuuRQXlkMnnPltH8vwxRb+c44/fonOE7Lw0HeD9g=;
        b=Mn1GWW/AHgkGMPHnt9L8M4roT/mgpWqhe84w3j5FihXuh6sjYa53JiSh92eo9MeL1l
         fBt659+8ahYpmzuMZkKqW5m+7QERVt5Xl0fA5YLnLFR6mbRv7w1zgbsRGev/MC/SkcA6
         UjZdDgq2j1H3U1VDmTkQh1k74XYU9u1FIlnwjk/a5jUveHLcHVDHYRx+4qRs4XZUGKpk
         zhhgaFMJNXP9wftQlmJLrt0nDNWngfpO1Rt8X8tzH5BCOkQ9Y6NAs3XGtzdxkClpRn1p
         PW6Ed96vZNaqNG8tc+FSQv0V/iv3Nl9Y9gwU6xjyWpxA3qNXgXQTY0Cbt2OsYAQC/6R1
         4R0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979984; x=1761584784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFkTuuRQXlkMnnPltH8vwxRb+c44/fonOE7Lw0HeD9g=;
        b=Ozd5eU336t45gW0M0ckpY3C7354Hzzk5lrB9hmir13chSQU/Fc8zGXmlp7KbsPc+jo
         o9up8U+F86hNKU0NVVsf7dAjRvCO8MdnfgaZeV8glcGzg29vx+1n0ay1tncdPN5w5GhG
         iuh4/L+n+7QcufnK7ke/oX+qXkQ6Da+z0FIk78267HQi6Denj4frLkfUxaDvxHE/t+hU
         ztdEZVxTZmowiIkOZKPNLhJrjDkQL4mIDGcodEOV2bgeKWJOSPX9Nyu50bTFE8B1PmJ5
         e71dGcZVW5FHdMzpy8oqS53H87plHtfTrSlgVBS3jg93gSEeS9erlkydOObKypOmLued
         7vvQ==
X-Gm-Message-State: AOJu0YzoZKjOdXt9ePTy01CA9DY05TT2HuRRhOSXKn44j3IpMqW5WEiE
	/LGJTCUHVwwm7GuqmyUD5s3gWERDLoYxm995thusjZR3ErMe0UZkYDHp23Jvb9gxN7M=
X-Gm-Gg: ASbGncvqgp5VmHOiXYcqLuVk+hhO7hsVkvKMVsxMm/sT/8bcnyYmoUPAYvWCfb1yWsV
	plUktVPWUV0NpAZNIjPBspO8hE6MAOhsFnIL0bur5ZGrF6FI3hEFHFmMo/MuJFnr/BkRr+pdQsY
	X2ysaqP+fe4XZdF9NEBSF3KHVEVdCrXb64BI2Fz2MOV7oPi5ulwNyVFD7fcFVjP4E5ewOAW9Lou
	8ZgGkTnAoNXW5sFD5Os3IUTrRX9wVZ8p6yKwL2j+65yROv0fRzOIJdjwV3+dpqDFmtDKCaQiT5h
	ze4lX83APqFLffMJYBMhL4/4eF24Bq25idFWZN9F57mVi5WQMviNW5s0z2Unm6fYnshG270HMKS
	VfWhFLhu/HaT86ZP3KQr58Gq0N8JetmT1PbZhxzfHM1N+qXjASFmniDnaiEUV+cSO+hz757Mj3R
	9Y+/6w+kPI77XFBCpl0YocLHReIaAXHThELfACkGtU4p7LsH9FqNIYJ5+JQU0+4cifbkUoTPc41
	yov+UClxQpkJQ==
X-Google-Smtp-Source: AGHT+IENyRFurSh+wbWbcVaHpRj7awwAJlh3XPUSrVwGppDU+1z9lIbBic1IDJdMet9PvI80YFT/dQ==
X-Received: by 2002:a05:620a:2586:b0:85a:3d7c:3ca1 with SMTP id af79cd13be357-89070115929mr1639543685a.45.1760979983803;
        Mon, 20 Oct 2025 10:06:23 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cefba919sm593806085a.32.2025.10.20.10.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:06:23 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	David Hildenbrand <david@redhat.com>
Subject: [RFC PATCH] page_alloc: allow migration of smaller hugepages during contig_alloc.
Date: Mon, 20 Oct 2025 13:06:15 -0400
Message-ID: <20251020170615.1000819-1-gourry@gourry.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We presently skip regions with hugepages entirely when trying to do
contiguous page allocation.  Instead, if hugepage migration is enabled,
consider regions with hugepages smaller than the target contiguous
allocation request as valid targets for allocation.

Compaction `isolate_migrate_pages_block()` already expects requests
with hugepages to originate from alloc_contig, and hugetlb code also
does a migratable check when isolating in `folio_isolate_hugetlb()`.

We add the migration check here to avoid calling compaction on a
region if we know migration is not possible at all.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/page_alloc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 600d9e981c23..e0760eafe032 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7048,8 +7048,14 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
 		if (PageReserved(page))
 			return false;
 
-		if (PageHuge(page))
-			return false;
+		if (PageHuge(page)) {
+			struct folio *folio = page_folio(page);
+
+			/* Don't consider moving same size/larger pages */
+			if (!folio_test_hugetlb_migratable(folio) ||
+			    (1 << folio_order(folio) >= nr_pages))
+				return false;
+		}
 	}
 	return true;
 }
-- 
2.51.0


