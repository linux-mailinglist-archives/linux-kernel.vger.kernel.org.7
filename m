Return-Path: <linux-kernel+bounces-744840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B84B3B11177
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949C5AA271B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2B22C15A2;
	Thu, 24 Jul 2025 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHr2C+Rr"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7C81FC3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753384440; cv=none; b=eBbcyvPeSALJG/iY7Dy5Twsn6jiIFHOxCk3vtUV0uRoUkuiwwTlV0puYKa8FyqNU2PZPjolCDlPktEOOnH/EwhOMyuQq0tydoCtLXDMef9jwMj455OQhnAV38BiN2V75AWenE15Ow+xGtJFjEuucup3qrzh/v7sG3+61+tF/4iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753384440; c=relaxed/simple;
	bh=SKCMXsnSeRtRSHspFusROaZkjfL2iP9BROPQgWT4iv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MpYAxhqnVRT2A77ZMCVkd4TaaTDi6mMZ8YO7SUT/9FnTr/m+935zDT8X6aV8q/qniluFwxPVn7P3Mr23fv78NU9z9ZN8GHfnCD8e3TGpBd2Tx+Kx0l6LbCleXtt5FBBRCsYuDBiKT6Nzqf8ns549ngtrwHD/Zn6egYHehFJYURY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IHr2C+Rr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-456007cfcd7so14575e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753384437; x=1753989237; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wvqjKgmAxHvS61kQHKCMppQbPZSjiiJdgG3hMaDeD04=;
        b=IHr2C+RrsbHn1ZYn1rU1NJ1FMD0VheYekMRO2/VncrBAf9+Je0/F/O3A+erZu2Urwb
         apVJrjCxdzHX+9MlNf1++bxjVbjtS/exKQeLIR5mBvre+WCFQ1ErK+YzTReS8EGSMaw6
         mAg973uK4xiVn6JyHmzZDr/b7vQpa+/JMKKq8SkXH6YealCGZj9cPLylSde/qs+4f3Wq
         P1KrWQo8MChcWahC/HpqbIDQyooZ/NRRrtpgXD4fTtdTGR0Q7KsPYQY0RV4ATOAgvcT9
         OefnkBPuJBbJnCrCMKkWUu7gCR0Bq2ZBIUZJREQJe9b7URwXazsdCygRyeXyCl26vMfN
         rYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753384437; x=1753989237;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvqjKgmAxHvS61kQHKCMppQbPZSjiiJdgG3hMaDeD04=;
        b=wcDzgK/HasazY+QwV0CgO6QyZwRCxU/ivuyD12bIkuLcW1YWu1ntjkIWYkpiN2J99T
         3E244fMRjHfyzBrYB67AQHN2E+0CyUC7cCsf0tTSRcvva+i0CmQ0cP7z8MMRKsgFQ8Md
         kV1CU4KKekv80auxqOHqxtTQUWxK/19kbG1HBeUp/758fJ2OlaJRBVxROWQDqx5sX3i7
         15PIKhpMLiD32v3VHdXhf/whl1Hp8IiHn2Ep6OvOO+BGkeyTINon9qo4EjTapV/xBKW8
         eD2Vgbd0FsHBJeZzFS+eYlineb8wq2A8eK0YNx4848+ZHVf7j3ItTRU0KMbzGTo/S0AP
         sKWw==
X-Forwarded-Encrypted: i=1; AJvYcCXb/Zlj/94X/N0jLgBYqu8m4hECjuRK5VXyDCsXe1/XjuXdxkE/5TI6MeuqUNGQIJn26Igtt8JaEPmz55o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq0vvh2loSHXP75F1L4nrvP5C6PZ1GVcoGkkhzJ0IoCdZmXrcJ
	9k1RQ2PPwX6WJNAY3yW+3syvKU3JBx+S5Lq0lgDDr7s3MsQRWOEyzvcT/SGXe8Pkcg==
X-Gm-Gg: ASbGncs0ubH1Lf9w59ygwTGFAUNNEfiGaJw6oV+b1uOQqSuSGcHkLubwBSrFc3TzBA9
	gIo6sdQyuo7w/u/HZPRqQ6u87JTkGCLO5FEty02iXsRJq7dZCJUPoM/wNHHgrG8IkJcL608YMn3
	leqZywdXbcXHgOKwoDdxyOwv++hvPxFAgCaWivIg58PIHQLZJJoxGARolcn74ivN493I76Rmy1E
	zHOBVMH1DgXYWA2Yq07OPsRqz/pkYX3xca/ki3+h2ry9vTIxlmGf2r2cKtgNMm0A4qCvR8OOd6n
	1AXw8ZNpmIlvUn+9sU0D3x9X5M5NxVhvcMxHOB6UcmKEErUdwxC4bVOrjX1CNh0FfS6lA+tQPZl
	aCTRaalB61vty1rZD/5nS
X-Google-Smtp-Source: AGHT+IG6HqoTeM/LvEaoDun56uV6GbzB2LcdJNB2rWhSL7A+EL6K8+TGgrzGYXW7vR/+FcFvXmR4cA==
X-Received: by 2002:a05:600c:3ba9:b0:439:8f59:2c56 with SMTP id 5b1f17b1804b1-458730842b5mr158385e9.2.1753384436268;
        Thu, 24 Jul 2025 12:13:56 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:5757:f399:9323:7f5])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4587054f338sm28555995e9.13.2025.07.24.12.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 12:13:55 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Thu, 24 Jul 2025 21:13:50 +0200
Subject: [PATCH] mm/rmap: Add anon_vma lifetime debug check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com>
X-B4-Tracking: v=1; b=H4sIAO6FgmgC/x3MQQqAIBBA0avErBswKaSuEi3GnGwWaShFIN09a
 fkW/xfInIQzTE2BxLdkiaGiaxtYdwqeUVw1aKUHZXSPFGK4D8KLNnRsL480OqvY9p0xFmp3Jt7
 k+Z/z8r4fpYaNUmMAAAA=
X-Change-ID: 20250724-anonvma-uaf-debug-a9db0eb4177b
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Rik van Riel <riel@surriel.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753384432; l=2125;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=SKCMXsnSeRtRSHspFusROaZkjfL2iP9BROPQgWT4iv8=;
 b=CmyTLcNCTvv132ht3agMAqhsH0w3t2N0h4jtV81qEiHKf4I9vTMHkGg5eUxTETvXZtqOUenLw
 vMLIuok4ECtDxn4DH/9iAKnXiTygPuCPBxz3AtOVG5JcraxI3tYwM5K
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

If an anon page is mapped into userspace, its anon_vma must be alive,
otherwise rmap walks can hit UAF.

There have been syzkaller reports a few months ago[1][2] of UAF in rmap
walks that seems to indicate that there can be pages with elevated mapcount
whose anon_vma has already been freed, but I think we never figured out
what the cause is; and syzkaller only hit these UAFs when memory pressure
randomly caused reclaim to rmap-walk the affected pages, so it of course
didn't manage to create a reproducer.

Add a VM_WARN_ON_FOLIO() when we add/remove mappings of anonymous pages to
hopefully catch such issues more reliably.

Implementation note: I'm checking IS_ENABLED(CONFIG_DEBUG_VM) because,
unlike the checks above, this one would otherwise be hard to write such
that it completely compiles away in non-debug builds by itself, without
looking extremely ugly.

[1] https://lore.kernel.org/r/67abaeaf.050a0220.110943.0041.GAE@google.com
[2] https://lore.kernel.org/r/67a76f33.050a0220.3d72c.0028.GAE@google.com

Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/rmap.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index c4f4903b1088..ba694c436f59 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -449,6 +449,19 @@ static inline void __folio_rmap_sanity_checks(const struct folio *folio,
 	default:
 		VM_WARN_ON_ONCE(true);
 	}
+
+	/*
+	 * Anon folios must have an associated live anon_vma as long as they're
+	 * mapped into userspace.
+	 * Part of the purpose of the atomic_read() is to make KASAN check that
+	 * the anon_vma is still alive.
+	 */
+	if (IS_ENABLED(CONFIG_DEBUG_VM) && PageAnonNotKsm(page)) {
+		unsigned long mapping = (unsigned long)folio->mapping;
+		struct anon_vma *anon_vma = (void *)(mapping - PAGE_MAPPING_ANON);
+
+		VM_WARN_ON_FOLIO(atomic_read(&anon_vma->refcount) == 0, folio);
+	}
 }
 
 /*

---
base-commit: 01a412d06bc5786eb4e44a6c8f0f4659bd4c9864
change-id: 20250724-anonvma-uaf-debug-a9db0eb4177b

-- 
Jann Horn <jannh@google.com>


