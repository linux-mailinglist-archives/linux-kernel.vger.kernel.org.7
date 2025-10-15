Return-Path: <linux-kernel+bounces-854187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 655F9BDDC9E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E8D7501711
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1820031A57B;
	Wed, 15 Oct 2025 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H37JO8ck"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145191DE3A4
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520643; cv=none; b=YWVZBA/AKHshVNUmaNt/awn5Sv/RDkiyc9kBvXH1v6sWeYEH5I7yHfa5s1/6QuByk4ZTCmvrbYbWsz7Wz28VmEDhJK/j9XbVhC+9rrwjDrrhgjZNNkd0Ax48P96CghXtYnOgjYaTmmP2z4LLez2W0nRq6J4MML5NypiX7zkDGWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520643; c=relaxed/simple;
	bh=lVOibV+iWGIwrT0uJn7Qm/GWUejLW2DJH+QQTNdRMZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MrD0oWObUSVCL0qbqjYLe3YiyCyw0ve5DG1e6ST0C9+ZjhUbiVVbD45ITsDcFiYjdmAaw43RK8ewX8ombze0212W6V3sRPnUjWe1qoj0yUHAP2qRA4X3JFwoLtTlSQrmdqMqJZ8nWLDe/iHPwFqSV5456oHUoqrzX1sYrjqQqq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H37JO8ck; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2681660d604so68674825ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760520641; x=1761125441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XDtXgZFzYXZK/ibRrp5PX9uMJOOke03pAz5gDdS9N8M=;
        b=H37JO8ckh0jJua1+x4lRw9G2QWIKjBjZvp1Ky8xqJfZc0u9OcW9ScUmH5zGhSgM4Gs
         KbUYWwp+V7KztMTi9xoG0rmmyqJ7dalqFTVnIAx/OSfbkCNri2qnDgBGOLkGId4oZY8s
         EwnV0U9vAFNAjgNwHT4bRcuvnPZMo9UhSRiTmGrWRhtUFrZTpQNV4HA06sLEmJlb4szQ
         bvg8UEzD9BAG2DfFeDNByWwTX346Ci7ry8XWJuwjXSgkVeOUvSWvVlVhC4YfuhA2Sxax
         n0OwbMgsBTO64wIrrkwEfcXMDDjxrXZZztG391+D2XzBaPABhwdO4JzGWskg0ueAKeSz
         yd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760520641; x=1761125441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDtXgZFzYXZK/ibRrp5PX9uMJOOke03pAz5gDdS9N8M=;
        b=jDmJ7LRA+QoqkitCaBaoBOKA0s1O7j9m9SUZ1ph1wYJbGRWfKz4OXdUcJkCOW+VEyh
         wL+s4/L+5mJdxe7pj8xzD/Lzf5kJmnpETkGnTwiuoouEXcUrK0IHu9bVV2FjC91mc4PY
         M/LATKN7Brz+XWRFZCVBDAalGVLciz6yVg5unY1YSBaIqsOS0oOn+ECdbe05erkIF3i2
         B7l2pkQDM2gtqxFXQnQ6cpfv5gmbmc9jP1c1AsYyyfdVEPTLgWss5Il88ArZtvjx1Z6p
         NxlrEkbM2On5BM4VgVxbEjLlwhFt4HQIrlJS2zTA3L1iDnRcp44DY4lcB067zjiHwDIf
         HXzg==
X-Forwarded-Encrypted: i=1; AJvYcCX+WA3s67BDi9MNMPTgZbUVPDBnXRDYWjrjex9AwghORGVPeWh/vqmKlFP3HuSRoAqD8wbWugzX76asfGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/nkGPhmlFibE/Moiph5cIbmHQiO6SJJS4NQhjl1/BvWpti/7S
	hEJAxyY5RyMYlKRz55omcHpe/wD1LZajXuBpWzjUH6+Bz8+gZLGiZDfU
X-Gm-Gg: ASbGnctCn+OzYBldqg0fN02KHhRK4MvayYmD3v3BlaQI5cNE52tdt0wJqlY6GGkxphm
	YLor2SV5pQ8R2/RDNHNt7iyCyGHryRoahh4eANB8CaHM8pLKDtPGFzDF7zJcSs3PeAPfiBbCtty
	QkIi7LTnTEyWVEg5Mo63EezlFPfSnelZJH6AWzWwsBwURt0HCxmZAv20KU2ZaCmg2gK+cVckqDB
	1UDAJhwQbfROW4TcObQgW610XMwizi0e/JvgdqdxJ4jG54mHNMLNN0Qke7buvNl07g0vG373202
	sR4j2tjSAvhsl2GBGvS65NWqTSNZe5DYyCwcSyAxRCJ/OFR1YOvcxZ/jRFVgV1oGvQ3b7EGaKOX
	7mqi3seBGdeTeO7Wm/W+RAKKPUCXaWblrP+PVHogG9tTg2La1mbgORVtOmOIboLix2KpFBcnJ0A
	LmtRpDT3cBamMwoA==
X-Google-Smtp-Source: AGHT+IEK9gGd4ylhL+ohQ0j4ij/MvWMWaktFv9kBT3L4nH8VbW7kaaXONU81DrtfDoVueDQoE/cLTg==
X-Received: by 2002:a17:903:3c4f:b0:25c:5bda:53a8 with SMTP id d9443c01a7336-290272b5529mr333496115ad.37.1760520641158;
        Wed, 15 Oct 2025 02:30:41 -0700 (PDT)
Received: from localhost.localdomain ([2409:8900:1896:1396:9404:1b8d:6e77:8dd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df2360dsm14730127a12.25.2025.10.15.02.30.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Oct 2025 02:30:40 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Rik van Riel <riel@redhat.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	wang lian <lianux.mm@gmail.com>
Subject: [PATCH V2] mm/khugepaged: fix comment for default scan sleep duration
Date: Wed, 15 Oct 2025 17:29:57 +0800
Message-ID: <20251015092957.37432-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment for khugepaged_scan_sleep_millisecs incorrectly states
the default scan period is 30 seconds. The actual default value in the
code is 10000ms (10 seconds).

This patch corrects the comment to match the code, preventing potential
confusion. The incorrect comment has existed since the feature was
first introduced.

Fixes: ba76149f47d8 ("thp: khugepaged")

Signed-off-by: wang lian <lianux.mm@gmail.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e947b96e1443..d635d821f611 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -67,7 +67,7 @@ enum scan_result {
 static struct task_struct *khugepaged_thread __read_mostly;
 static DEFINE_MUTEX(khugepaged_mutex);
 
-/* default scan 8*512 pte (or vmas) every 30 second */
+/* default scan 8*HPAGE_PMD_NR ptes (or vmas) every 10 second */
 static unsigned int khugepaged_pages_to_scan __read_mostly;
 static unsigned int khugepaged_pages_collapsed;
 static unsigned int khugepaged_full_scans;
-- 
2.50.1 (Apple Git-155)


