Return-Path: <linux-kernel+bounces-746091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A5AB1230B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45D24E820C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358D32EF9D5;
	Fri, 25 Jul 2025 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ni8AG76n"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE33240604
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753464949; cv=none; b=T4Wue97wd9K0F7ALGDXRpdl0whIHzW1qGy12sz1DdtOxtoPeNYxeExUAOE5yu4ylxjeh4hfrEtlfwg7tU77X/oSxbBY0ykPisTEqkywH350tkdgUHp0lxMhVwGZz4LG30GUbkTs+WbQoRP1tfl6JLG0x35rTD/2YhliIC2UGrJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753464949; c=relaxed/simple;
	bh=W3GESIoheEe7tF5Bj5+TfCVslUwn+MC+ykha9kVsVV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nM60jDp6W400y59AupfHfjHWkHJ5+w8I5c7jCM52NJtqpo4yA1jWh9wUuHxTNbvRhopLJNd/x1rx+88DPVlAd1zeOl7C0eAa0AcekHB5hnXnJryJnFwBLrS+ONGPLzfRbdllbs/7IRbL59MXNweh4G6aKWlfYHDcQX3focOXGW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ni8AG76n; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8b3cc12dceso1830443276.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753464947; x=1754069747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rXoHcgz0BuBvSlur0K+rM4eE0Cd8HhmoNnuGF/EZk6I=;
        b=Ni8AG76nXJFRY1/5us//QeQxqe1/5tuR3uRT1oa2hD0rZpbtfialAOBj2fydlE5nwo
         5sKmpWklmzRz5xtKMn6yEsjtOIa9pjEWaP3VEERUh/HXif2W1w0ZFNRy508OHMCTRW/X
         qA2KBFnldf+5uxFK7gIu/IahjAXKj9xpqVdYpg3/LSuSaVkBO8SJml3IcK7iXZSVhGJT
         6Hph34GSdLNYGvyDAiK86t5HyrXiQefKcMqdafYJv9oz5RTX2pBx4HrKGRZHyrnAoFQo
         jD6kNQPblMiN8no0TWJgMxHcMGZxrgUCUY2/p4FIm/MwpjCQAocol4sXzW2Fho4IHCDm
         lc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753464947; x=1754069747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXoHcgz0BuBvSlur0K+rM4eE0Cd8HhmoNnuGF/EZk6I=;
        b=jESES5ijbt9MBs9cf7qb5gUlJKrbxlLolErsq6FHu8wcG9E5FwnAQxH4lvBSqs6mJN
         qftkWuuzPW0qFKwBIleEAN/9ZUuUbkbcjYXmR1H5x7H1rgAxxUqh9VfJzNMApWE9zRxt
         DR58siGlUq8lU4Cs1Wa8NyidJAnNO9MR82yrrXSfOHLba2wGV/3kW/BZR9Ni7FrE6fBA
         CeA5whJbwUoVD3yFimMQTPTWOld1wJlkOhCAuHbp4sGhmlfsBjn1/N4SVPQIunD0a183
         sNqZSLJ9bMB3zAKGWeBtDvwmsj+VQ7sQfNg9ejtdykGFgWd4k4eOVYrRXlkozGrtawxR
         RpeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi5yNqp9dsO9VCwK8jr6ts/vd9FR7IFNjtdDXJYmJDHfrF3tj6TPwvPO3A6kVD+X0wqNP+ciY86Y/slpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdeTWGIQW2OWDV86i4ceeDdqWzWVeEGNxn32Dwk7Be+ovNfKk1
	D/MsYqJwn/phbEVBlX0ISEJEGxsiupt1v4agbMBhGIA/TF7/SzTzSHcs
X-Gm-Gg: ASbGncuK+OBKmLtO0now3mLzpLque8jWM/KJkFlMwgYtAyLCrvcakX99AOVkcu6kgwE
	uqqK2lAhob/PIW30Glt9PI5+4AUc8pjeatzEO224FiMNFU2yigNRBWWWqVL9t6K6wGn0Rf8OnTE
	hu9gGxp/nGV69dH0gSlm3ADycgrXSTe4g5c+kvX+2UbN6qJH8HSzCg+ageEeralckssj6oAmnDt
	MD5klxxggTCunnJaRpDHVNrUVUk+BRxao10vBQKe3SPq+tLF0mP45RkGnURpVkG5+NJZfqGKeIy
	pru4DZTfYouNEZfxeR6kwovXf1lcrt3bY/JWq99nGCmGBFk4L9WDpvpoI6g5GMcVFY/FwHf3qzN
	eIFD7LzS+SEHRYYzoacjIWQ==
X-Google-Smtp-Source: AGHT+IFC4bRN6MyMlkLu60vIdZy0jDA0GQB8a+RomATv34IfNGV8yvzSBB7SsYElFDMEApC38s1j+w==
X-Received: by 2002:a05:6902:1204:b0:e84:3657:e50 with SMTP id 3f1490d57ef6-e8df1172419mr3406693276.3.1753464946920;
        Fri, 25 Jul 2025 10:35:46 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:42::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8df871bab0sm138800276.45.2025.07.25.10.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 10:35:46 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH] mempolicy: Clarify what RECLAIM_ZONE means
Date: Fri, 25 Jul 2025 10:35:45 -0700
Message-ID: <20250725173546.2295177-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The zone_reclaim_mode API controls reclaim behavior when a node runs out of
memory. Contrary to its user-facing name, it is internally referred to as
"node_reclaim_mode". This is slightly confusing but there is not much we can
do given that it has already been exposed to userspace (since at least 2.6).

However, what we can do is to make sure the internal description of what the
bits inside zone_reclaim_mode aligns with what it does in practice.
Setting RECLAIM_ZONE does indeed run shrink_inactive_list, but a more holistic
description would be to explain that zone reclaim modulates whether page
allocation (and khugepaged collapsing) prefers reclaiming & attempting to
allocate locally or should fall back to the next node in the zonelist.

Change the description to clarify what zone reclaim entails.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/uapi/linux/mempolicy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 1f9bb10d1a47..24083809d920 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -69,7 +69,7 @@ enum {
  * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
  * ABI.  New bits are OK, but existing bits can never change.
  */
-#define RECLAIM_ZONE	(1<<0)	/* Run shrink_inactive_list on the zone */
+#define RECLAIM_ZONE	(1<<0)	/* Prefer reclaiming & allocating locally */
 #define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
 #define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
 

base-commit: 25fae0b93d1d7ddb25958bcb90c3c0e5e0e202bd
-- 
2.47.3

