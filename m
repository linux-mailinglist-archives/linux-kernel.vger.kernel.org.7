Return-Path: <linux-kernel+bounces-892381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E24DC44F7A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96C2188D392
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15852E6CA6;
	Mon, 10 Nov 2025 05:14:51 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE09C1F5847
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762751691; cv=none; b=mMKBqYjYuaXodwmpejOq76T/BnEPZdJL1a+g+ejixvq0RvX1Ptnt4lwfyLHXGUJNpl5hq7oYINnD49BTM2c1m+DuAZ2VgO5IZ4dHS1vCEqlJZzggChkudDl3ez6febbm6PmUiDxD/mLtyxP0+TdezwbL8pqUMEbwmE5KkNBt3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762751691; c=relaxed/simple;
	bh=LP/krErh2evphX/wAKmsTFB0iANF81HybgXPtXCvaAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F458pTHyYbQnwbtF+OhSMdhkAmbaDen+bsKNFOlNlwCjQIyvzFnAhk9Ee3l3roZZShsHB45dlX5UMyONLsmM5R5gIM1pE3hKu1BD2lkXWKkeiPCA98je5p3MS9rlkPxKAX8eGHMbI5q24+ybx/8PVXqDLty1S8Og+BcNIWK+m7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3434700be69so3494287a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 21:14:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762751689; x=1763356489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCIIbUmCkll5kK4hfoqHENGIwveb/KYptctyAPm2WyQ=;
        b=YJVxV04hm9r3HYCRQhKT4tYsPEB4uzHJqnmNSYFVhkEf4mwBns5ZDigOPmXhEer4l5
         703GX7sDexVLSpfcdEduYttq7ihgO7Wlh9Jx1HgCDuuin1aMSv6xjXTppkL3BgTapcRg
         kDdnBcM9rHqkE+6AwOVuw+DK5Q19SmmjgEOZGlFZN9UgwUYSyHzRioTIEdk8p/bk8b9L
         Ae/HSNiEZEGG7rA9zyN6O1yhNpQViAMvuKrzAO+pMZtN5YX8NPuldVRK6708y30fWUun
         umfwANcmEmMI5E9vOdP9uJ1krorZ1fod1/Su/WrikurbAeNPzLs2czPXGzu+9cc9nHPu
         y6Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUmdxWOfPVv7xJzb6wP65koDMk+mLHzso2CR9QRisqlk2MU/5GO49Q2cMCCJ5o5/cHFSfRJd+xZ35MMwQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7kw9Tx9yD72DeMEeuIuavSYXgsbKqfAXvRPyaEluFlmjEuMbQ
	VQMydTI4W1zvfA1hn1aWyYZwxGV6Zd4w/oX/ZoQZoxvG0VJvjZ+30JZ9MlkZZA==
X-Gm-Gg: ASbGncu2CSsr9nLvy5ia/E7jrD15gSU2S2X5kxxIratTvvioOf/Ai5y1/Y3XmFFAK6L
	t6IjeivvCqCM1P1uctdEWJfgXez5Wb+HviJS1cR6bt02hUqMeaJ7R2e2Sfxus/kzJcVk3gW+RLY
	ES3amstRv/B+HKLpanuHGcEpZTxGk0W/FMmpaZRTIL63S2ODz1sIBg2zb9ivYBN5IQYFpx5zMIF
	kO1KtT9yueHfAoRVe797AX3NfWVb4Mp5lJ+7Xqd0TpNm8nCIii8/5hn3pFfrfppmO39VQnc5KGz
	bnW9ng/vWwbqwT/72YsMtg0TTT/O5OMyP6LE37yMZ3Sry3Z2Em89YFtHNUlaUcgkhhfUQhRpWTF
	921Y1MaJCR5jrgjFNWwfsWY2+Xy1xtiJA6DEaTY8q7L7pB/uKEEqR95XDnFpZg2V/Id7ivtm4EV
	rjIrKrYIM=
X-Google-Smtp-Source: AGHT+IG5OdmbBwJXRmUUCVVuWc4/Mx82Y2ZMrKWq8DF2KYtATXtarldtXNJxCgWZCKf8AgNQKtWNOA==
X-Received: by 2002:a17:90b:270a:b0:340:ff89:8b62 with SMTP id 98e67ed59e1d1-3436cbb4076mr8393863a91.21.1762751689221;
        Sun, 09 Nov 2025 21:14:49 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([2403:2c80:17::10:4006])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a699c011sm16182816a91.14.2025.11.09.21.14.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 09 Nov 2025 21:14:48 -0800 (PST)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: syzbot+3f5f9a0d292454409ca6@syzkaller.appspotmail.com,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	syzkaller-bugs@googlegroups.com,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH 1/1] mm/hugetlb: fix possible deadlock in __hugetlb_zap_begin
Date: Mon, 10 Nov 2025 13:14:21 +0800
Message-ID: <20251110051421.29436-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

The hugetlb VMA unmap path contains a potential deadlock, as reported
by syzbot. In __hugetlb_zap_begin(), vma_lock is acquired before
i_mmap_lock. This lock ordering conflicts with the page fault path in
hugetlb_fault(), which acquires i_mmap_lock first, establishing the
correct dependency as i_mmap_lock -> vma_lock.

Chain exists of:
  &hugetlbfs_i_mmap_rwsem_key
    --> &hugetlb_fault_mutex_table[i]
      --> &vma_lock->rw_sema

Possible unsafe locking scenario:

CPU0                                 CPU1
----                                 ----
lock(&vma_lock->rw_sema);
                                     lock(&hugetlb_fault_mutex_table[i]);
                                     lock(&vma_lock->rw_sema);
lock(&hugetlbfs_i_mmap_rwsem_key);

Resolve the deadlock by reordering the locks in __hugetlb_zap_begin() to
follow the established i_mmap_lock -> vma_lock order.

Reported-by: syzbot+3f5f9a0d292454409ca6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/69113a97.a70a0220.22f260.00ca.GAE@google.com/
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b1f47b87ae65..2719995af18e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5327,9 +5327,9 @@ void __hugetlb_zap_begin(struct vm_area_struct *vma,
 		return;
 
 	adjust_range_if_pmd_sharing_possible(vma, start, end);
-	hugetlb_vma_lock_write(vma);
 	if (vma->vm_file)
 		i_mmap_lock_write(vma->vm_file->f_mapping);
+	hugetlb_vma_lock_write(vma);
 }
 
 void __hugetlb_zap_end(struct vm_area_struct *vma,
-- 
2.49.0


