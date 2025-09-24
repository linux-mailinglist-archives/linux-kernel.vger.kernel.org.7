Return-Path: <linux-kernel+bounces-831243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D159B9C2DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93171188928B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D4732A3D4;
	Wed, 24 Sep 2025 20:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYBc+6yn"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26632951E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746654; cv=none; b=pzqkmP/siDFwl8n7W6/sy4HyAMUCFwICjgJmOd89iGQ8m43h/UYOaqANfxvZfFDezla4MXGTk8naYhaT9fQbfgOnY4F0kYDPAbpFykVUtb9ob2GUhJQmh64mEdUn1vOpsVYPs95vJDKX/zvBhymOSzCcvFk7afP0lROik7+jKCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746654; c=relaxed/simple;
	bh=Fp2jccBxUtGZXi6pBuGlGTYCkNTYj1GDND11dk6mGPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d8kOEEGqAB5spt1Lz0FX3zxSDKYz2s8AfoIRqBFQ3KAPr3OrphjrWAtzrX+NqJw4GOpuTpth6rbQWQrNbV/TX3MaYeho9dNsR0SIR0x3MNPI0+lRL7GgkFA9OG3nWrwtSKiwoTdcIx9cR8uBOm2bYRLV1lXTAGUl9shb/B5jBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYBc+6yn; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ea5ca8dbd37so221043276.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758746650; x=1759351450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nfUQ5D8UXsQpdFNJBj9JNJ56MdGhDsygR0SMM5MuzEA=;
        b=bYBc+6ynqRdtNr7u96mDCRoTJj0Bh27Vi0OjimYxRF+SnHPLlLfrT933/GsnUctCXy
         1AvIGYlZ3da0n82YQ5Pe8CbojOweajUjKUQHo1Biky1mShC/GuK+E6NiBwZ0s/7HRjZT
         HQEYWufzcn39sfEiB1p85rZtwcCUO9UAIoudPluiKsSS2AnD3WqkGXdMloUGgL/NLrKM
         uF4TcGp56FTTtr6X5QX5GP+4G4TQSwjOkbAvlcckI6UW+kTomjDp5UqzN2mTWaR7brCG
         8CXzqeX8jZ0EgX6GV1baFprDnuzbuDrVvI5yrYdqjlH7B4IWnvtnCc+O+xQFw8j9ydMv
         +SFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758746650; x=1759351450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nfUQ5D8UXsQpdFNJBj9JNJ56MdGhDsygR0SMM5MuzEA=;
        b=swPD+0kv/ypqRm5txhbfy5GgBrZpLOnTzZI1FL9yGW8e+rLZA/TOMm8T3YqbLbGzga
         CNxqexON8TR2Yj/HkGPrdKSfQd9c4qB6PUxGLzBRzTL4IZb/JoSmG4XI9s8EfZrDUiA1
         LFSwJp95Zg0T0gxOoVbG8g4QOl5GqHMWXhf4slxH6ZsR7kogEiHh6qYDEKnD/fVHcqa3
         fxFFjHgUVHsClsPKNUUqWr8R79oWvuwiXYX3xvl6Iw7IDFipggMpnT4zc1v2yInM9urX
         XupOW2jBasG786RIGs4AON7mlh47iktRuGEcaEH448EzlbmAtruZ+djtrRD/gsM+JErf
         hEPg==
X-Forwarded-Encrypted: i=1; AJvYcCVO6TVeoOA1URcTVfxvKRSR29uOeqa0ja2EAsfPZZVSjHAC+9zdjDbkJUtTlPDDrXwwl/9HRjFfjejZhJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXAaYzTlKqidl6Pn4yKfLMcYNc8Y0brc+HSibZvweBXiEbNwvV
	NlbMf0YHJk66X9QpBnBvCbCgHk6ZbZraokjdcVaCwLjepRAJA/bhh555
X-Gm-Gg: ASbGncu1QfMR46MlY7oxHOqab3rPQXr9o9Cu11Z8znaSei5UEGC1ri8jwL0RhC+a6v2
	NhRXq7GZlFrJkpES1MBu04DzQc94AwThwWjR/3C7vlq14rCQKPYh6kU/EPQssdi48pdP9xHAjzz
	1g2XHwfPm+sq2PmbyA7sUJKSMXLVDQJQBNDs/5N19G0sLMVIOvUf+DdCOMDSsKMqBUfaIf39MRY
	PuIMxAlhUk3BQSh3rFm4Lfq4rbgtkMwkfbiHRNnqhh4Q3ACEP61o7xBprDyomOYj1i5ywGXqVEN
	wfJ7uijuqh3ke85slBGIeu//N6NN4eD/P9dSF7KMDukTrnwmSs1GwUN8SIod4bnW7U6IpTaFinL
	LPIZUub8LHh8v6p/Q/KMn78nqIDehmb7Q03xBpnRimen8J/hJsFOoIg==
X-Google-Smtp-Source: AGHT+IFBq8AJRMzTJK0klOcnC1vLPRjpjHZy9TRw7dLM8P5C4iSy9O6k75u6x794jG7F5vuo14q5NA==
X-Received: by 2002:a05:6902:300f:b0:eae:d640:42d6 with SMTP id 3f1490d57ef6-eb37fbe9b1dmr1046467276.5.1758746650314;
        Wed, 24 Sep 2025 13:44:10 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:51::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-eb383929b93sm9854276.21.2025.09.24.13.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 13:44:09 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 0/4] mm/page_alloc: Batch callers of free_pcppages_bulk
Date: Wed, 24 Sep 2025 13:44:04 -0700
Message-ID: <20250924204409.1706524-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Motivation & Approach
=====================

While testing workloads with high sustained memory pressure on large machines
in the Meta fleet (1Tb memory, 316 CPUs), we saw an unexpectedly high number
of softlockups. Further investigation showed that the lock in
free_pcppages_bulk was being held for a long time, and was called to free
2k+ pages over 100 times just during boot.

This causes starvation in other processes for both the pcp and zone locks,
which can lead to the system stalling as multiple threads cannot make progress
without the locks. We can see these issues manifesting as warnings:

[ 4512.591979] rcu: INFO: rcu_sched self-detected stall on CPU
[ 4512.604370] rcu: 	20-....: (9312 ticks this GP) idle=a654/1/0x4000000000000000 softirq=309340/309344 fqs=5426
[ 4512.626401] rcu: 	         hardirqs   softirqs   csw/system
[ 4512.638793] rcu: 	 number:        0        145            0
[ 4512.651177] rcu: 	cputime:       30      10410          174   ==> 10558(ms)
[ 4512.666657] rcu: 	(t=21077 jiffies g=783665 q=1242213 ncpus=316)

While these warnings are benign, they do point to the underlying issue of
lock contention. To prevent starvation in both locks, batch the freeing of
pages using pcp->batch.

Because free_pcppages_bulk is called with both the pcp and zone lock,
relinquishing and reacquiring the locks are only effective when both of them
are broken together (unless the system was built with queued spinlocks).
Thus, instead of modifying free_pcppages_bulk to break both locks, batch the
freeing from its callers instead.

A similar fix has been implemented in the Meta fleet, and we have seen
significantly less softlockups.

Testing
=======
The following are a few synthetic benchmarks, made on a machine with
250G RAM, 179G swap, and 176 CPUs.

stress-ng --vm 50 --vm-bytes 5G -M -t 100
+----------------------+---------------+----------+
|        Metric        | Variation (%) | Delta(%) |
+----------------------+---------------+----------+
| bogo ops             |        0.0216 |  -0.0172 |
| bogo ops/s (real)    |        0.0223 |  -0.0163 |
| bogo ops/s (usr+sys) |        1.3433 |  +1.0769 |
+----------------------+---------------+----------+

stress-ng --vm 10 --vm-bytes 30G -M -t 100
+----------------------+---------------+----------+
|        Metric        | Variation (%) | Delta(%) |
+----------------------+---------------+----------+
| bogo ops             |        2.1736 |  +4.8535 |
| bogo ops/s (real)    |        2.2689 |  +5.1719 |
| bogo ops/s (usr+sys) |        2.1283 |  +0.6587 |
+----------------------+---------------+----------+

It seems like depending on the workload, this patch may lead to an increase
in performance, or stay neutral. I believe this has to do with how much lock
contention there is, and how many free_pcppages_bulk calls were being made
previously with high counts.

The difference between bogo ops/s (real) and (usr+sys) seems to indicate that
there is meaningful difference in the amount of time threads spend blocked
on getting either the pcp or zone lock.

Changelog
=========
v1 --> v2:
- Reworded cover letter to be more explicit about what kinds of issues
  running processes might face as a result of the existing lock starvation
- Reworded cover letter to be in sections to make it easier to read
- Fixed patch 4/4 to properly store & restore UP flags.
- Re-ran tests, updated the testing results and interpretation

Joshua Hahn (4):
  mm/page_alloc/vmstat: Simplify refresh_cpu_vm_stats change detection
  mm/page_alloc: Perform appropriate batching in drain_pages_zone
  mm/page_alloc: Batch page freeing in decay_pcp_high
  mm/page_alloc: Batch page freeing in free_frozen_page_commit

 include/linux/gfp.h |  2 +-
 mm/page_alloc.c     | 67 ++++++++++++++++++++++++++++++++-------------
 mm/vmstat.c         | 26 +++++++++---------
 3 files changed, 62 insertions(+), 33 deletions(-)


base-commit: 097a6c336d0080725c626fda118ecfec448acd0f
-- 
2.47.3

