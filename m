Return-Path: <linux-kernel+bounces-756959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7AAB1BB89
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 22:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF095163F6E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DF6230278;
	Tue,  5 Aug 2025 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2jJhdE7"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A1D78F2F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754427052; cv=none; b=rWIu5CmutsAch5RyfPeeDrWBJUz9GV4n0cu96CRm0nD9XWfRhjZtaWh29+gY5JupAbE5QvlsGd7FMhNFPjAiNkmEs8q4x4iznOdXzFAQp+OcIDqwJtlEwxggK8AUZbdhAi8qJo6TvMX6fD5uRNF8TvbOQak6RFz7iG8AGgti/S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754427052; c=relaxed/simple;
	bh=35D6FbVvvLFW8FOqAnPGgz7wAShnz7uCahD0d4oogdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/mFSAc9lFxbv3xak89NpvygZCU8UWDEBNHdpMHGx/eJY69ePTuQz9EHwOVJUUduqgLdCOW7FoGK1Lki2pqdACFkzNY/RNiiynEeYlTbsA/i8noPSxyVtLVrHat9cDsN1RoaXmppYuJ4/Kc+MLchOZcHFZMUnc5FO40x5gMsv+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2jJhdE7; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71a3935fa8dso33623887b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 13:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754427050; x=1755031850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkJR3JDYsaMg5EgtLQqsM1EFIKcngzfD0e3IWoupzBg=;
        b=g2jJhdE7TCYItuZM7hoR1+HctO9kRb/Zv+gkpGM2dRuVjo5B1I6QfIoy2u8ZpsXuik
         2gLgpGTlSXu0BGz4FouvCt0822JjYbE2xSpASE6eQmuO61VHjfNIQitsNJswZ/ASEW2X
         rt73+gEjaamZ1q4C4891BN3FwFz+liHSj7r00rCkEZCPz3Upac7V529Pn3vrkY19OyQy
         uKMOHn08b6lQoRWLIq6xl4eYDt70lXn1Q20UHAW3YoOz27nGY43JzMrGF0Wzvirl3uMq
         9wunO0S6qkbZtWCubtGqyaCCIfVNeF9C8FhbwrJWM0Ltu6Dx+7yLdpec881m+dzyfZ0E
         RwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754427050; x=1755031850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkJR3JDYsaMg5EgtLQqsM1EFIKcngzfD0e3IWoupzBg=;
        b=descaM1tn4O1JIwcs9SXzRs2SsI2S4GZbF+1xWkFXiCpGalEFnJIV0oG1GTtZWcwvm
         olSa3OQ/iNeW6TUSNwL8jKF4hTSRB8iuG5Do5AjLHQCk4fLoSiHlpwGQ0KKazZWHeRem
         CtFrt/Dn6C8nCe5Vbem953KKdMILZQsRx3918UkvL7LWkSSljqgJ0GtIsUZSy4e/J5o0
         97RZzMEPZZKNNHrgnwZJ0K8xJTMyKcozd/Wk8X7VWpWIK4yjTys+MHGVB8PsfVvdeaug
         lm7L2QEByZ9EBa8Uu3gkzltnmEbaQi9hzMYhYXmnkOHcYFJRSdeQMRn8ajyMHkkQuhJT
         2Vzg==
X-Forwarded-Encrypted: i=1; AJvYcCW4dbbeIG5vOll334iWumgk2Xx+FfG9vG0Lhc3TqXmgeGRXmXppMf6IYrK31x3jGRVN1tjE/JyTjE12Kao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeBp34NuKRiYZoxGQQ+5Rqze5rW9/Qau8S8r8r1fawjgHnRjH1
	8Xbk7y/DpscOTGgtCYrnU/Zs5IM+ejCazswWu0Xo8MRQKdQBu6CQiJD8
X-Gm-Gg: ASbGncv6VvahIPY2Sr6S9yzsLnU6CNYyBrZ7Fd0bLu+DTxQj1tbiod/80liT7SBIeKo
	IIq7DeDKuueO5KRW7Jukn5afidLlOrrRsDjrrnDKub0rfQqFaLVwjJAW31CmREaYAPdwtw0Ki21
	AOTNRxyAPt/lDPnXoRczOr0HmcZAdKE/Ksh9aKlOJP7+SMy7HJnNx3ssIz2j2fEMvsCd2EKzNgs
	LhilPBm+6f/7n89NRuaoUuo2Y/BbJel2oJgS6SIdEWxRNpgQMlZ5i5FQ969me0RWgvjPu4N7uur
	z65l0rPu4S7QddF/UL7A5+rerJBeK8tTu0qkmbp4Q5w5A/41vwrZJx7/hq9Ns7bEQHRC8++4oGf
	YzfT4K6M7/TVttTaPXt+5sQ==
X-Google-Smtp-Source: AGHT+IH4CQSD7STnqr5i8+APTIpIexp6StX2qIcGqhM3cINeLyQLcygJ0t2OakkLViUtS25xwvzYeQ==
X-Received: by 2002:a05:690c:3588:b0:71b:9213:a75d with SMTP id 00721157ae682-71bc973e912mr9178537b3.18.1754427049647;
        Tue, 05 Aug 2025 13:50:49 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5cec4dsm34333237b3.75.2025.08.05.13.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 13:50:49 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	SeongJae Park <sj@kernel.org>,
	Ying Huang <ying.huang@linux.alibaba.com>
Cc: Alistair Popple <apopple@nvidia.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v3] mempolicy: Clarify what zone reclaim means
Date: Tue,  5 Aug 2025 13:50:47 -0700
Message-ID: <20250805205048.1518453-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The zone_reclaim_mode API controls the reclaim behavior when a node runs out of
memory. Contrary to its user-facing name, it is internally referred to as
"node_reclaim_mode".

This can be confusing. But because we cannot change the name of the API since
it has been in place since at least 2.6, let's try to be more explicit about
what the behavior of this API is. 

Change the description to clarify what zone reclaim entails, and be explicit
about the RECLAIM_ZONE bit, whose purpose has led to some confusion in the
past already [1] [2].

While at it, also soften the warning about changing these bits.

[1] https://lore.kernel.org/linux-mm/1579005573-58923-1-git-send-email-alex.shi@linux.alibaba.com/
[2] https://lore.kernel.org/linux-mm/20200626003459.D8E015CA@viggo.jf.intel.com/

Acked-by: SeongJae Park <sj@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
v2 --> v3:
- Fixed typos
- Softend wording from "never" --> "should not"

 include/uapi/linux/mempolicy.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 1f9bb10d1a47..683c130782f0 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -66,10 +66,16 @@ enum {
 #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
 
 /*
+ * Enabling zone reclaim means the page allocator will attempt to fulfill
+ * the allocation request on the current node by triggering reclaim and
+ * trying to shrink the current node.
+ * Fallback allocations on the next candidates in the zonelist are considered
+ * when reclaim fails to free up enough memory in the current node/zone.
+ *
  * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
- * ABI.  New bits are OK, but existing bits can never change.
+ * ABI.  New bits are OK, but existing bits should not be changed.
  */
-#define RECLAIM_ZONE	(1<<0)	/* Run shrink_inactive_list on the zone */
+#define RECLAIM_ZONE	(1<<0)	/* Enable zone reclaim */
 #define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
 #define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
 

base-commit: 6bcdbd62bd56e6d7383f9e06d9d148935b3c9b73
-- 
2.47.3

