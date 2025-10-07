Return-Path: <linux-kernel+bounces-844237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D30DBC15B2
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AAD219A1DA1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5612E090B;
	Tue,  7 Oct 2025 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzTqmfDP"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4BF2E03EF
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839651; cv=none; b=cxNWsrn7Gq9/79hM1qvY2KVcqzXOpE0XytcVGTuLvXCvRK56KGMReIGT6j8wlDDkXMwDlgfi9AfkDGgbmLpwTzCrOz+QvqDpDGGDPrpsvE+mCH19MaKfudXhVSt2RuSYx4MAc5/93lKZr6z7ChZ88fCjUfQpoxvegfdiFtXb29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839651; c=relaxed/simple;
	bh=xgrKQtQTGQJxm4PXSr9W8MvsYHHNgtLsWXzVqBHDSr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVlDczn8iX+VL20SUxLHNXEzne0zU6/Lf5Sss2HjEvGchmYImLJcj8i04TK5mnVFtg9RaunlG2awDq6nZKsDi7JAhRfHADp1qNa1mb1Fg7X+zOkEg1L3dZc3EKeOYz3JYitmEYzKMl0aT4a/ErbzXbM9d+GmzJU+p9wPe6UDOrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzTqmfDP; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5797c8612b4so8179855e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839646; x=1760444446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTx3t8206FADCajKY+kyp/2YAJmhuLjY8XEm0uYYaD4=;
        b=jzTqmfDP/kcGgwCPSs//amFyOklyF7/Q/pwefFrvi3hLIlopzz+R4h0wQ8QaaojQFL
         9or6zkLJUMgybNMTs+rFky2uvddjwKZ20EsCOEOQEB0sDZDNciwS4oNdwYCKoS6GurA3
         1a3appUMY7j3yYYLo57cJCxSCe/UNeE1VQmD2hDG6GmKHApza6Fgx5eaAIoa8neo2/fz
         K+dluXsdf/e7lzZODu+4/dc7zr0lkW/FIG8YEKHcuTfeF+NV1xX1CgskFJNqrfk0pqbi
         CqD6uRtTtVxOR+Nkun6xHYH7qMRmDlzexXCRKie41CjJXSa+CJHQJdmo55HckFJ/m1Ye
         g+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839646; x=1760444446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTx3t8206FADCajKY+kyp/2YAJmhuLjY8XEm0uYYaD4=;
        b=IvuRw9DooT5hkGscOah3gFXYl3ytwEHaUPVS+Ct3P8zoh4gusIkGr0qr9Da5foMgMM
         Ys8APnLO8pSrn/WuiqHUoVgQrQoNXE2oMs/J/TBrvVItJUSLkQYEPfpL3IWN25k4jTCJ
         LreggU0pVCxnff+Y5bltbmv9uMaQPVdQob5ErFvM+XAV2ZqAIvTK8U57Pqd4KHaWqhsz
         b67f4kiDQdrkAxpavH72GNwqOJLwrqEtcq5ok/LMsPQ2P49YTfJ1cljpvbUT4VoabAAU
         R4YUnfr/Md6VXviYdwzZGphSb5T2qQCU8h0Yv7ka6o8igq3kBdimIJgwxKZAcbdPLIC5
         x5fw==
X-Forwarded-Encrypted: i=1; AJvYcCUgndxgQcKRrTnar81m+KMkA1h12p694CvGmYcmExHjiKAn+1meUZIwLMPTzNQM6dp7AMZlkrdf3vNZnd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFZCLGALuknh0HMbc2IF4nlLRWTgHY27nSodeVtBZn77lX5HVl
	CDzwu6640mr/QujxWceh+3SGY10tBj1J+3V51OeQLVmZFZeKnYmyBFuP
X-Gm-Gg: ASbGncuE4FvoEWPVAeJ4AoP+3sebZiPCTAoxBweKhFBFT6nhDqfTZmT+j+Dv27yoUZg
	F+YWSxHW1XKIDQwM01n2GXvglFPmUo8OPlc/i2RlrXm/+IJDzTj/wvFxE43rMVXgqaeJIwPP3nH
	8ptjd1khtvekbdNufbdFdrJMaDwBP2hKc5r7zrxlISneWjrerHcAojsty1Cgle2TNZJ6lkhri8R
	+SXSs6p357brXokkOXtbpkIMi299CLwDIEKaY5ii75L8Pab81OslVdk6/UWhKT66iqE+GMWy0hY
	Q39wrffGS9tsXtRwJ63r5V8pE7DVw03S2PWsYAXTMBIgGxGD21FvSqKg4xkLh2f728uQyYPte9d
	On69dumCMzD6g49rhiW+jVPyKWK/qXaHI8b5apePy
X-Google-Smtp-Source: AGHT+IFBISJsnLRLg6R99DyCufi90oiGK10CgIZ6THuFjlwNfx/elYDiBcir+/FIn6ZcCpkoSUOyAQ==
X-Received: by 2002:a05:6512:23a9:b0:58b:6f:719e with SMTP id 2adb3069b0e04-58cba6c1968mr5532094e87.17.1759839645937;
        Tue, 07 Oct 2025 05:20:45 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01141151sm6061947e87.59.2025.10.07.05.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:20:44 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: [PATCH v4 06/10] mm/kasan: Support non-blocking GFP in kasan_populate_vmalloc()
Date: Tue,  7 Oct 2025 14:20:31 +0200
Message-ID: <20251007122035.56347-7-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007122035.56347-1-urezki@gmail.com>
References: <20251007122035.56347-1-urezki@gmail.com>
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


