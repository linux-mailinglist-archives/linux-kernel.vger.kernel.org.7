Return-Path: <linux-kernel+bounces-893613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E2FC47C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 920F134A044
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D87427E1C5;
	Mon, 10 Nov 2025 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itOuXl89"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5BF279907
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790914; cv=none; b=qANBH6NzutZTpXlmMKrYLLi+kj/IxA0BQK/lAImMRcmg3+0s9jepr0aWEzZarJqRCDYEevogf/h8+7rTUTZyEcxDFyv/o7GjlEC0rPUouZSN5pr1jmLSjrLy9t7hz0E+6hU3GGSv6F1TJ2yxF3W0tiNZj5bXN30SgLi82use86w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790914; c=relaxed/simple;
	bh=T5Kb884ZqzbqaXh40FCyBeSH7EcN5xOgWr9p1KkfkOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJ67hQlgSPqTeNvcBIgVsTbH9Pn9k1EF10GDJVLiaj6lwVX6MAIF1ua6HU/1IupuR49cTQ+bMx4MOYUyVCFbjRDySEnFFaRVsul3ORP/1npQgfVDDUpHFimU8ESJPoL5f/9AOyua46f/KB6qbIDhnB+HXtBHIDe9Z+c79mqD8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itOuXl89; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3437ea05540so1636660a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790912; x=1763395712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVE7mMINIDNpzopu2/zpPrHTRDdiMn+0L7S/Gt3fNJA=;
        b=itOuXl89juHHP+yQVUoyU1kvcvfYgdi3nfn7IHKU22IsXhjuwLSY+7kdTycxRa7myL
         O2gIkSqTMrqTBFGEieQpLFaM1mKkCKnIltu/QsDFOitlQlYR+tmoKmkUJUqq1Ytn1bSU
         +NErYVnU+Qn0fbiG4ra1agoWeBGqbPN/LkAri7HvocOI2J6i/gpeUicFy6Nwqq/xx6rF
         TEBmua6bQKJOIRi2g80g33BaMR8++BLneMXZowvKKTi9L1P8GeOT5973GoBLxgPLIjDH
         eaqnj4cIhj8TZ5EHkOfnnpfU0zzNhNrZ+hwkkBxBZsxgSHeMDg4kNUB1acug33RgQW8s
         tFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790912; x=1763395712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZVE7mMINIDNpzopu2/zpPrHTRDdiMn+0L7S/Gt3fNJA=;
        b=B5YAZKAdkyEMhOg9z07ymBUKIA67aHW7xqKC9MsRTMqNKkz+sDxJaQN3U+PV6R1osf
         EbY05nTVDXXGXVi+YNnDZ3eNPS8X23ALtDDe8U4LTpLzm1YqdVAqwXmF5Qk6nhAGUj+2
         RWAmNv5r4t/p5Gq6IZAruEa+VyTXBpHX3oczCjakFxlTLilCzbpWlZal6GdmFEhA0glr
         hoTXvW1qPSkOB+/imfWHhfcyYdJQuHcrQ7W1OJluaPqroPkf6T1pY4eDOtZ2UKMtr9HM
         awBt/bynjKRjdMFLMCOShqST+H0eLXqKtiYAgtxmlaAoko5IUtRgqkzYpZF18gXsZIkB
         Oa+Q==
X-Gm-Message-State: AOJu0YyIe/ZS09aWPcOaewbIpqe7nItConbpw/QVulMkr//lEoOWTGan
	0xzBeGAw2LyruYEmMYrmr32XXfobG/KfLyTfZKh4v75wKsUttC4ptPq/mi3Bbxns
X-Gm-Gg: ASbGncvNBFD21YvxpAtd6gqQW45T2Pyhlw8T5DaVvMtQxfEykdzJ2aXFhGx36qSswJK
	f74hiQ2Drf5W+b+0HGgdCsSVCODC2w3gANQgL/1XTDqzjr1Q46dwA4IzuFyTWhAas2OsKRgQzS9
	KU69aWYEnkHphPNCMcjQCdykhttbOhzmvBfF6mkLmuDyFjXslmpf1Jq2uEvx66DaAV/IIO6Mk7L
	M55Zh3O0d2TrbXAYs0DZ2kbZPDtC8IK/WrEo+N051f+aFKdhjxFJy4+mEPRO4p+170z7pOGXLyw
	Ht6UEt4oRbKpjuv2UanZ+4IyznigTCYUrvGofKZEQBZc4GUEp6am8S6R7fTqaWnalc4qVBHV7GQ
	yxu2STKrfRDJbMyN/+z3+VrOPPwSshRumUFoMZkUCUbeP11UVLMLJxKloHTpjXnfLfTX5busCnu
	pGhaZ74pgP/VJ8oKLz/CLhuX3MUkqupkiE5A/AdXyWtGI=
X-Google-Smtp-Source: AGHT+IHboFWnsEunfUdx7DnEXCq5unRFJ0uQNAfEgav/prVSXlSnil9ui8kxWk8RTLeK0C2Ray4voA==
X-Received: by 2002:a17:90b:180e:b0:33b:b020:5968 with SMTP id 98e67ed59e1d1-3436cb8de8dmr11147326a91.21.1762790912334;
        Mon, 10 Nov 2025 08:08:32 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34362f1f231sm9308893a91.10.2025.11.10.08.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:08:31 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 3/4] mm/vmalloc: cleanup large_gfp in vm_area_alloc_pages()
Date: Mon, 10 Nov 2025 08:04:56 -0800
Message-ID: <20251110160457.61791-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110160457.61791-1-vishal.moola@gmail.com>
References: <20251110160457.61791-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have already checked for unsupported flags, we can use the
helper function to set the necessary gfp flags for the large order
allocation optimization.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/vmalloc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 8fbf78e8eb67..970ee6756909 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3634,10 +3634,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	unsigned int max_attempt_order = MAX_PAGE_ORDER;
 	struct page *page;
 	int i;
-	gfp_t large_gfp = (gfp &
-		~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL | __GFP_COMP))
-		| __GFP_NOWARN;
 	unsigned int large_order = ilog2(nr_remaining);
+	gfp_t large_gfp = vmalloc_gfp_adjust(gfp, large_order) & ~__GFP_DIRECT_RECLAIM;
 
 	large_order = min(max_attempt_order, large_order);
 
-- 
2.51.1


