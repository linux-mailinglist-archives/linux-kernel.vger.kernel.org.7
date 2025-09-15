Return-Path: <linux-kernel+bounces-817073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCD0B57DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27AF2188D43D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5158321F24;
	Mon, 15 Sep 2025 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAo9Kp/s"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A8A31D73A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943653; cv=none; b=bj12h6DeP6SlMkk48AxVm4CqaOPpSxzkLzVw3eYFXxgngsaZQ5ITL3QUF6xFQWTzYH5Dpkv++SEHtbfM+3URZV4KD6uM/5/UTJFhfHpAOgBRJC7Ys+N093C+AanSwPcQyMmYGw8ylUVM+K3tuT7UA2QPIJnvLBlPA0vsgIbBpJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943653; c=relaxed/simple;
	bh=ttjmvio6QfWzCovg1C7MzOvfsRCArSCL+o0LkD/11Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dncy/FQ11B/Av9ptCL4xa2L+W2+rbIbrWAKVKIt5fiTsLuz8TYMFu9r/TD8gXEAzezb9ZVx2cxRdCgZUyZWDN+9+L3pJR28dZF8LvwPS8yVIf8T6gGCFtqWBxpUCOnyFpzryQ46jXwNbTPYEOxvjEAwZDj6xFVs/P8MfWS43TJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAo9Kp/s; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f720ffe34so4781345e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757943649; x=1758548449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tWr/JqVgOvXu/F9fhJXup17MiB9k9fkyyqujUfoMQs=;
        b=QAo9Kp/s0X8JE1WvvTFC/Qoj8M/9tj1mFqXdWldX9QyfePfkM/2bXCW99LUyETTF55
         xTEnx6KLxgLexahO4GGtUzFL5DewnztFbVpvS3ADuzsQY6fcEIFgoUnM3yFU+htq3q6l
         AM4VZciOZR3TK1nNm2uXR7Fgrl41ARYRdqseM5oHc+9z5tA33/k+TxAc3IJ8qTtn5RIU
         6tPBnEcUCoaGTlfbXKhtKMG6QF0g82mg73IYc0WRxEACAoAbQYKW2uLXECMvIMKpFrMP
         ZjpSman5aFS/2mKqcyaO0I8sK0IXJTG6ePYCa1gHQd2yNefOR80DsDN+bcYhDNirpwJo
         LiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943649; x=1758548449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tWr/JqVgOvXu/F9fhJXup17MiB9k9fkyyqujUfoMQs=;
        b=NTTLSzfSYBEAojI7WLDuEPiGvEL2alQMiFUpKqBw1DjEH7OTf90pVkIdYOaNv3TMRM
         aiAWptFgVoo1aoyKmO7iWCF3LmStzA6XgsconELhWP2MPyaE9lxm7zMEhMkIKnpFa8NJ
         S6/JUYndtk6BkNNYrvRfk+TyjGdM/R6Ep4tBoSkgy0nd+t/HLL9oC9SPbp0TieClmo6n
         jxrbfSyL5lsRfQLBx8jt2QMXVYCOX5/nsbxz/hIAz1QunsgdoH0JXCqP9sVectBVdtIx
         MVJmpfTjvtgbRU02FamhQnCUMqIN0RrhtM9wlMW4rJDroRaAlJvsGJ00jZ9C9S82VgYh
         jYbg==
X-Forwarded-Encrypted: i=1; AJvYcCXT3A6qOA8IAZ12EIJpWAlhEXTyzPLNatrscT2VsI0yWcrnV0CHuTqnt4xafQvexhqRr8KenScvHAq8c/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyafS9+XvMBJ7rG++9kMZDUeAOk6lU4vuj0dZUfZyE822VrOKWB
	yWGySWDcdFz3hF53pWQafNV28NNkU8uuR8sypg7mY/5V36lS3TWPzcVQj8A2iw==
X-Gm-Gg: ASbGncswjDw2cIyrqy4XlVd+Gi1VdzhoZ6lv1Yg3ELgw6X2ID2Cgmg0WNgjRviCD6JH
	oVww9Uix0MgbCW9Z3lRFqnTqcJc94U7ac0kFauWW8RM7Ua5p7OOlXGuy3RRNZXvr8rQAP2ougpQ
	p4nDNXDJGSCzsfW26qOkLJCX9Haupt0S/zv2+YhMZoEb5O2NfReriK+UmEH2Gcy20h8hGIt4lDk
	28czFPA2CQiBMJip9jjSpbRbCKXRS4Ti758DteZJQJL6xE82C99mBCd0WWRNcTZb20W5jsn6hgm
	h5i8SKlgfTziWVfAcH5zI8qaaNQqiYbqeFKgcs2uAgKuIAIhZk3UaK6OYOKEh1N7hLai7LPjtCG
	HrhYiok7i2wkx5aygoWtOND12Uxk=
X-Google-Smtp-Source: AGHT+IGZUiqgRibPAiA5DgB0BOAerZLdpk29rMvBlfQxC3FGQGHcSpvUlZ5Nw+aF8RQ+y3vCwdokTw==
X-Received: by 2002:a05:6512:31d6:b0:566:41cb:671d with SMTP id 2adb3069b0e04-57061436fa8mr3784043e87.23.1757943649092;
        Mon, 15 Sep 2025 06:40:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-573c8330e54sm1150719e87.63.2025.09.15.06.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 06:40:48 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: [PATCH v2 07/10] mm/kasan: Support non-blocking GFP in kasan_populate_vmalloc()
Date: Mon, 15 Sep 2025 15:40:37 +0200
Message-ID: <20250915134041.151462-8-urezki@gmail.com>
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

A "gfp_mask" is already passed to kasan_populate_vmalloc() as
an argument to respect GFPs from callers and KASAN uses it for
its internal allocations.

But apply_to_page_range() function ignores GFP flags due to a
hard-coded mask.

Wrap the call with memalloc_apply_gfp_scope()/memalloc_restore_scope()
so that non-blocking GFP flags(GFP_ATOMIC, GFP_NOWAIT) are respected.

Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/kasan/shadow.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 11d472a5c4e8..c6643a72d9f6 100644
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


