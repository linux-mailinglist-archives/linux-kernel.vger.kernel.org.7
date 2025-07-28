Return-Path: <linux-kernel+bounces-747614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD92B135EA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DB8178491
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAAB239E6A;
	Mon, 28 Jul 2025 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivXQAtdx"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C39238C2B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753689246; cv=none; b=dKcLQQoJe7ig4l1vjkrHoNpWdre2oYtT+Hghiu9ZNiyFGc7oiKSylk14CODVbNnCUVYIUSs3zzNvJd+SyfoeZBS4yt3ZOHTagAe9ebuFoB3cPoJgfwsplYH5M2INJpqtzY58rlRsXpJ+s64KLjPzVYoGK6MUjcQfG8VEkXuT5mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753689246; c=relaxed/simple;
	bh=SZtmN31dgKGUcSFnkiYjLrUWC3XIbULBVU/oRWvVZAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pk6z4x4vHTS/ayghJusLzNnxruMAY/cOt7vYKxM+S4EzzdLGq1s7193hBS7snYFnTKPEf5LjhhUFyx0NpEQH2c/Jy/GqLnI619nYru3v7/b8vF/10f53B1C4NVM6gGy+Et9Zq+vG49Etzo+OuCqqisnQlwpNDTSHLgs1ABLNuRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivXQAtdx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24009eeb2a7so6596255ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 00:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753689244; x=1754294044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cd4AeVUs7V5lSylB8MQ/iKz7vLHt1zDPy5kzMmZDacY=;
        b=ivXQAtdxgz1ynjBqP4hCWssRFvVcM6P4XwEgjIklw1CBZziGr78rm/YZXeMDhrYGGW
         aE2VndkgeB9yS2g+p3XlaivdGD/em1k/JnWJKX1eF/7SbHzrVBtVHuIYH2A+dL7AyeGZ
         E3iwqOZv6+1D5EMLB6wO1ZOoomULYYTK/F65yVK56i3Fuc96OdLQNzGUN2sR4MKH3v0s
         9/ZTM+EHsoXrkUL+1aRdkjDqpSEGwe+lOVqbQGpCjlqV7I1Dh4qLWApHOlOHkcsyd0/y
         R6fhg6M19PLMOJnGBy35p/+7vRH9iBf/F/HUkOZ4oGcovLQRJGUhKv0vw3gX7qYNxnNS
         78EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753689244; x=1754294044;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cd4AeVUs7V5lSylB8MQ/iKz7vLHt1zDPy5kzMmZDacY=;
        b=DfMLawSZyHX4634idN+ZIiBxMHo98/DsFBqgO9Su+kdfJuLkIRFH++mYV8S4Rhxnx0
         5OSx4cLH5CpF3KKxArrv2zcFO2Ew5ujVu+P+iLyYN8//pxGG98E9hZfm9TptdvUhNw8B
         erjXMyaCYP4SOOAp0HxnYXUOSRm3UjHU2jCapdudxe10IdJN3JDbCVDjhkUCQBD11XFl
         ISoxuE5xYJ0QRVzppnWCx1KaLcmhX+aiHKW627Txb93vGhN48lugIYT4w+evZZwIUfCP
         XTqKFOIigRvnY6qC5mGq0wQCss9CD5EgdKiz5YAsWH3qJi0bGWbxbBvANE+GHdDj+R93
         GjSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyKeWnv7jmGmP+TvDeVpaq+XpVOrEy5pSlmjvEMF8OPbGx4qlsHB6GD6i9x3Iqx6lHFeg+9Osq603LmFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM+9kWzAW9OwVQTlSL+XiGJqftyPYfA+J4Y25qczbfyawbttYA
	/2MlBtUn8d4Bt3B3wDG47/rZ98xu0gBfRL8M9vEvsg9dgIyMGGCO8OEt
X-Gm-Gg: ASbGncudLNlmKhart2xtHJJlaFNJDp/z3EXxGo9b/374og8sFiWVh8UoCGRD/0EdXnC
	ilb5jDAuzkBXPTRkfSUqKytBvAdD4azV8A6DumO3wLYMjZhVMYkA1sZOHSHx2g1MNpIEcdeZiS1
	6cHFbkklSsf0Zis281aWr02P4BdEI63xYZLyqrKOXQzr9g0oSc7sbdt555A79YIHxEla77uhxk/
	f6lqNB9sCbNW8w2+mCDjgYp9G2+X5vuYdFzhEFP+CC1Ze3iDe3bILJFLG0dwVMV9Ks2etPLekvK
	6pkfcr7x4eBqnamPYR4iJdRpQdmBNS97owRFsCLBpQ8Xw35/FOvVznWm7dypEjrb2cUWvufRyX6
	Dn/wNFlpYCUBBmNTaNVvcek/TRH4Pxs6Zw7u5
X-Google-Smtp-Source: AGHT+IFb47kHtBhlXu+Lw2+aPCdPOkojIjE0li2wCg433P4HoUD2xs5ePpOf4KNv5nq2hut+xxfISQ==
X-Received: by 2002:a17:903:181:b0:234:d679:72e3 with SMTP id d9443c01a7336-23fb3100766mr169960675ad.42.1753689244060;
        Mon, 28 Jul 2025 00:54:04 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2401866c2a1sm20272305ad.4.2025.07.28.00.54.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Jul 2025 00:54:03 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v6 8/8] mm/shmem, swap: fix major fault counting
Date: Mon, 28 Jul 2025 15:53:06 +0800
Message-ID: <20250728075306.12704-9-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728075306.12704-1-ryncsn@gmail.com>
References: <20250728075306.12704-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

If the swapin failed, don't update the major fault count.  There is a long
existing comment for doing it this way, now with previous cleanups, we can
finally fix it.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index aed5da693855..41eb4aa60be5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2356,13 +2356,6 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	/* Look it up and read it in.. */
 	folio = swap_cache_get_folio(swap, NULL, 0);
 	if (!folio) {
-		/* Or update major stats only when swapin succeeds?? */
-		if (fault_type) {
-			*fault_type |= VM_FAULT_MAJOR;
-			count_vm_event(PGMAJFAULT);
-			count_memcg_event_mm(fault_mm, PGMAJFAULT);
-		}
-
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
 			/* Direct swapin skipping swap cache & readahead */
 			folio = shmem_swap_alloc_folio(inode, vma, index,
@@ -2381,6 +2374,11 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 				goto failed;
 			}
 		}
+		if (fault_type) {
+			*fault_type |= VM_FAULT_MAJOR;
+			count_vm_event(PGMAJFAULT);
+			count_memcg_event_mm(fault_mm, PGMAJFAULT);
+		}
 	}
 
 	if (order > folio_order(folio)) {
-- 
2.50.1


