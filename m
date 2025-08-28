Return-Path: <linux-kernel+bounces-789951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BDCB39D46
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836A7189EF41
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5DB30F7EA;
	Thu, 28 Aug 2025 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ufILy1/4"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35608303C88
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384088; cv=none; b=KcySFKm1eL/Q3wvBjlLFBqZaMQ1UaK83ur5aFr/daEX9nQU84UEZUNiz5iRG1ayLLofYAuXX9zRK20CP9dVY6UEglfCC+J8b1TWJJlRBP+ZkFHuW1Vhi26zbmmek+gTOEnAqib7i58WVawYNC07kDAFM2NP5ptZtNF4M/FGQrLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384088; c=relaxed/simple;
	bh=oDVybuqSaQ+0lLzUMjgRMFGOJZh+Jfqqlz6cbSH7KNc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oRyEDrQ6BLTM46bevYfsZUcxxAbQn29szpJTiBPVYFRh6cl2rlrMFZMCa4ehNWRwWYoAHIMEQtwiIJkLzbmOeTaRPIzE7fpg4cE1VvoWUpuhLHCw9pzTMO3fUx8R3XfjMVV0I03pkIu8p457iTtNAxeSKy9Hnyb11eBMDPuE7t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ufILy1/4; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3ce3e098c48so419627f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756384084; x=1756988884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FqQKwAIz2LU1OWm7bXmF144o14s2i386mLuf3AdVSG8=;
        b=ufILy1/4JHcL3kjhjaptxtclR1c4uWg7ruh3R43ORBB47WhhgDfcANbEF94DhIXnTe
         hRzORkWsrzm8Gpy22NRuLIYZJBCGK9xnq4vsvegVvMfyCFpq+Q9ORFkBHM9wT9lCKHiG
         xN3hwzsKzvTz1yfhCL0fE3ZvVxorwqG6nHGxDgwTshe39+xodqtgvlhGsX+NJVOZjIoy
         r+/x6RdsEA62l8ZHdmdttUtc/QFOFg6b3wE4xTu6XMx9Qhj1FOHF8HQoUN/rXFYfDLdg
         sZkyNQ+PyXmC+ZVMkXpGD7U5l2Xzsflpfgh7v/SM5BJu3aDcA7UGoyYTMC5uTYjWY/YO
         yHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756384084; x=1756988884;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FqQKwAIz2LU1OWm7bXmF144o14s2i386mLuf3AdVSG8=;
        b=H9wQtvhM+Q9OWFv/iH+VKeUbxm+rHyPSU7XMKghqpqYVkK7K+6DjWYhv+WtOjBM/wq
         DF2y5BvRMU5Jy0r1DZ+zLOfpgtjPfVwOQK/5Gq6dqtihqNyh0/wbNHhUgUJuCQxXI1yZ
         93z4f0jfW378h5x9EssWgPkGaDiDMDH8cpu2KDtSKGFhuQDxjQKsdxJ4Bntr/PDn9qxw
         bSsBqqhmCgqdqn0FFn85W5GeMc3zvY2MpHt/a0zbURksbO4REd/HwY0MOajw9mM8ANLM
         g1uKoC9dDWDB7V/07MUCtsDrVh7vMMiSbWYhPWWy2ajsHW1Athurru/e/rypKJm2slOi
         ZRdw==
X-Gm-Message-State: AOJu0YwpfTaBeGUo3n11OCIyom4P8DOhjB6J2ik2hfutrH6wwpobbYgL
	LKjuz1s0cxj2d+x372rmab16QnJjTQPhIUh3I7ESL5/Dfc3/mI12+TJaj75PUkJH4+9YOpf7rUR
	/T1xoetSfYeWqBA==
X-Google-Smtp-Source: AGHT+IHZCHmwCefpydsRTcY/KLOL+C0u2I1bBuHeaqD36WPuC2sTn7PhhQE1Zs20gugP/+7/d3IKRiWaT7ybNw==
X-Received: from wmth22.prod.google.com ([2002:a05:600c:8b76:b0:458:715c:51a1])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2f85:b0:3cc:b206:bca2 with SMTP id ffacd0b85a97d-3ccb206bdf3mr4803717f8f.33.1756384084504;
 Thu, 28 Aug 2025 05:28:04 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:27:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAE5LsGgC/32NQQ6CMBBFr0Jm7ZhSQcCV9zAsSpnCJMKYljQa0
 rtbOYDL95L//g6BPFOAW7GDp8iBZc2gTwXY2awTIY+ZQStdq1Y3OFQYF4OroNlkYYszKtfSYLW
 jynWQhy9Pjt9H9NFnnjls4j/HRyx/9m8ulqiwHi+mqwxdG+Xuk8j0pLOVBfqU0heA8kz5tQAAA A==
X-Change-Id: 20250827-b4-vma-no-atomic-h-0f8ebc2fe4f9
X-Mailer: b4 0.14.2
Message-ID: <20250828-b4-vma-no-atomic-h-v2-0-02d146a58ed2@google.com>
Subject: [PATCH v2 0/4] tools: testing: Use existing atomic.h for vma/maple tests
From: Brendan Jackman <jackmanb@google.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

De-duplicating this lets us delete a bit of code. 

Ulterior motive: I'm working on a new set of the userspace-based unit
tests, which will need the atomics API too. That would involve even more
duplication, so while the win in this patchset alone is very minimal, it
looks a lot more significant with my other WIP patchset.

I've tested these commands:

make -C tools/testing/vma -j 
tools/testing/vma/vma

make -C tools/testing/radix-tree -j
tools/testing/radix-tree/maple

Note the EXTRA_CFLAGS patch is actually orthogonal, let me know if you'd
prefer I send it separately.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Changes in v2:
- Added some new operations to atomic.h (in support of the point below).
- Fixed garbage synchronization in mapping_map_writable(), thanks Pedro.
- Clarified commit messages:
  - Mention where $(SRCARCH) comes from 
  - Don't talk about radix-tree for maple tree specifics stuff
- Link to v1: https://lore.kernel.org/r/20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com

---
Brendan Jackman (4):
      tools/include: Implement a couple of atomic_t ops
      tools: testing: Allow importing arch headers in shared.mk
      tools: testing: Support EXTRA_CFLAGS in shared.mk
      tools: testing: Use existing atomic.h for vma/maple tests

 tools/include/linux/atomic.h            | 22 ++++++++++++++++++++++
 tools/testing/shared/linux/maple_tree.h |  6 ++----
 tools/testing/shared/shared.mk          |  6 +++++-
 tools/testing/vma/linux/atomic.h        | 17 -----------------
 tools/testing/vma/vma_internal.h        | 12 +++---------
 5 files changed, 32 insertions(+), 31 deletions(-)
---
base-commit: efa7612003b44c220551fd02466bfbad5180fc83
change-id: 20250827-b4-vma-no-atomic-h-0f8ebc2fe4f9

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


