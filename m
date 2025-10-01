Return-Path: <linux-kernel+bounces-839424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B32A7BB1977
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9CE1926338
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE89302CA2;
	Wed,  1 Oct 2025 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6WjRsZe"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9B32EDD7E
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346817; cv=none; b=eKfb4PeB5fomVP1Dzk3K+PqQLZNDwCNQLYvME8NWVOa7Zi132wrSGsMBzuBjmy+yc5ifXb0o6fzXbBFCAlZ3isISoWJHh5OSFP0aF+rglSXK5QY5nJDFQsRL+5zNK3pOyZCdPmISWPW6LnP9ywhmsEEz/d+4TWiHEHBnj1SFpLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346817; c=relaxed/simple;
	bh=xgrKQtQTGQJxm4PXSr9W8MvsYHHNgtLsWXzVqBHDSr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEv6p/HE3kYZxH6B1gtRsVonHJh/txvv3aIw998L+yFZ4t4+JGCwiE52nVSy8daAiE/1hGBjgPo0o6V7/g48Ioc2gu5cGSB4AAORWVmlgs9R6gILaLX/4PO8jt0iib26MuLdFVAuVSjD5AfWh0n7FeD9hMHgU2I6EOciiviBxJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6WjRsZe; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5818de29d15so221684e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759346814; x=1759951614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTx3t8206FADCajKY+kyp/2YAJmhuLjY8XEm0uYYaD4=;
        b=j6WjRsZe76FJu3RAaL/70yRB9pbIdE6lNvWEAD9hgUn5po/UVpiOejT2ORRcmEXx6i
         fFls7RlAi50GKfIjsMHhn+fsCzqEKqgqoTCI+gEE6hee0RP4qeshv4UUqYJjL3EuWeFN
         qYLdb+HTiVcQcy0zapZd4KeWFEdSJZDFwmsWj/cpIowlplpohZ2p7Eg3T5mN5xGVFFvD
         y3zNrND3/j6O/fETkrjAuT3/QPWV936P7ku7EgYCu5yKCRmD21712qprho39nUfS/Sls
         rUawvl8ze0W15fcYFEqjW4SvTtXYCH63aFvIV3eVHtvG34qBclVtyW+UECDtvR5iTxyr
         cyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759346814; x=1759951614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTx3t8206FADCajKY+kyp/2YAJmhuLjY8XEm0uYYaD4=;
        b=O85OlwND+dNyC14yC/Twa7Us+ucZTSZ1UZaliWEEP36J1E/s32U575aWlUD2RNjk3c
         sA1KokGZShRdaoiiVjT4GrXJrkCVthk1YgClUt+hNJ9qPT/U6ve7la1sobFSYKRLt+Jj
         AEI46ryHoSbnG0X9TYzS1I9nlj6vv1wHVS1QP3kgPRYTEbdyhcke/jiCYSqwdAiPkMTn
         3oeYebJV7M1r5Am3vghlWR6NFmnZwdTKnZus9jWR9zG0wsJW5nrtmhLQ73axQzVYCHP2
         IWabtNMKv5ZGSsYqtJRz0GVVvtgK9DbXU76XcGnvq5elV3rz7KT3UftIPdVAC0M52bJ+
         gqdg==
X-Forwarded-Encrypted: i=1; AJvYcCVcSeEDPlad7ZkiLpez+j2fQvcK5Tigny5N6NyuKS09EwdL5mCsqnWcQ6t4I9CfnTjV+BcpF8+j+5I8+gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAha5ERS/z3cozD64veZuD2PM8d/5DbdUiErsU4d40r923VTUJ
	CHJTVT3+lZF9mhuvJNE7cZ8hzIOWtg7nC6YjjZmGBkguU5ddxN4K8a6+
X-Gm-Gg: ASbGncv2U0XB+Q5P7U/ocggBX2OYOBsMUwPtJFBORtpQfppSdXFc81X/gRf7my+w8fT
	PuE6z1DEtMEKjlGZViMb4JK4OdfvKU7V5ySFpFh0hh+i2S2+tezj8KwJh9mjDNuaeGw5sH2LsJW
	1T/qlcO7w6LAcwaPtKW74lJuRsm4KXGLGTdivgzj+d25uuEttYUI5nRrzSOMIhCAi6ZY3bq/riY
	TIA/JrRpKIx6YUxzThKUFKVEPRS8EtcAq2IUtmw7JU0RA1oROqUNO6s6RxwFOPhaY1j0UKjcOpN
	iP4xSyxAfBSdCet/OQACjH1zZXNb7tjDkMFXJOAA5S/vvjj2slB0uXil6ogGJ7EbxJeDIdDtOlG
	1IWFfPvqPdyoL0aqg+/iAnQ1yo5o4rxJ8EtlXta0u
X-Google-Smtp-Source: AGHT+IEdIYEhyfROGcpz5tzh2C/c8xPkZaS+cLjfPY9+92lHTiKC3SF2fw4puKKC6CoPwT8eBnXURA==
X-Received: by 2002:a05:6512:3a8e:b0:55f:4423:f52 with SMTP id 2adb3069b0e04-58af9f425cemr1391668e87.37.1759346814169;
        Wed, 01 Oct 2025 12:26:54 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0112414fsm136627e87.28.2025.10.01.12.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:26:53 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: [PATCH v3 06/10] mm/kasan: Support non-blocking GFP in kasan_populate_vmalloc()
Date: Wed,  1 Oct 2025 21:26:42 +0200
Message-ID: <20251001192647.195204-7-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001192647.195204-1-urezki@gmail.com>
References: <20251001192647.195204-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A "gfp_mask" is already passed to kasan_populate_vmalloc() as
an argument to respect GFPs from callers and KASAN uses it for
its internal allocations.

But apply_to_page_range() function ignores GFP flags due to a
hard-coded mask.

Wrap the call with memalloc_apply_gfp_scope()/memalloc_restore_scope()
so that non-blocking GFP flags(GFP_ATOMIC, GFP_NOWAIT) are respected.

Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/kasan/shadow.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 5d2a876035d6..a30d84bfdd52 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -377,18 +377,10 @@ static int __kasan_populate_vmalloc(unsigned long start, unsigned long end, gfp_
 		 * page tables allocations ignore external gfp mask, enforce it
 		 * by the scope API
 		 */
-		if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
-			flags = memalloc_nofs_save();
-		else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
-			flags = memalloc_noio_save();
-
+		flags = memalloc_apply_gfp_scope(gfp_mask);
 		ret = apply_to_page_range(&init_mm, start, nr_pages * PAGE_SIZE,
 					  kasan_populate_vmalloc_pte, &data);
-
-		if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
-			memalloc_nofs_restore(flags);
-		else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
-			memalloc_noio_restore(flags);
+		memalloc_restore_scope(flags);
 
 		___free_pages_bulk(data.pages, nr_pages);
 		if (ret)
-- 
2.47.3


