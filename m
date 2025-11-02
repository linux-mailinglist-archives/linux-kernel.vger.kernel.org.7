Return-Path: <linux-kernel+bounces-881845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B313DC290DD
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 16:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F903A985E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 15:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BD5220F3E;
	Sun,  2 Nov 2025 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRPE7+8X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4C41E9B1C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762096276; cv=none; b=HeHXRrsptlGWVsRnySq95Kp3aXEui6GhieaZxemeLTjvOGfSYs5QhOivdfJJm9WFWyLOLQ5U4lyaSwXi01ye6TAwXYqpAZ0UkcSVcrjf005NPn0bZ4i5yxEg8eMKHpT1Yb/m5x5EpZGQoFk8DBmVrER8z4k7zSYfXdiSbctFsnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762096276; c=relaxed/simple;
	bh=A0aoWXU60Hd4meD21jQel/DOJpC5UpQ5yvBIUwRxGi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Yd55UPAPqpw7kXn1nWAC07aaXuRVTvadEhjeYt7kZ/J8Ynl7F0bRpOxO3bx9BOIjJPdJcS1lo+Q4PoPXWFYtSDQOWcu+2NSV49+HMOcukPV/OLijGKqsjOF/7wCYfpNYWwPyfRH6VUQpSR/zP1jQ+XlAaD0OO4tcBdWPiYEugHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRPE7+8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DA4C4CEF7;
	Sun,  2 Nov 2025 15:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762096275;
	bh=A0aoWXU60Hd4meD21jQel/DOJpC5UpQ5yvBIUwRxGi0=;
	h=From:Date:Subject:To:Cc:From;
	b=tRPE7+8XfS/EkvzHOtjZx3T84AShgQcj176E4gqaecQVzcAn1d56oBd4jOIbXMTpA
	 3FeF/SzNcUjo1cutuaIZ7Kmo0H02E4y38URPFND8An3ba/h6ulasXjAu89b6idm0WB
	 i1JSEWsE6SwzwkQ6Euze5VKWSoraYH32dSTpo+byFNsSaDJCmZNOamietzsTAjUlkQ
	 kNnJIeELtzSuUZf/pXQjVbgjRoj9JuKlHEEKvnoZwBQ6c4ivvU6XIN8uEb8rs5hl/z
	 SSZZicAXU3B5ihH1TmOQrPLZFHOMbID2f3n/xZSmqfmofQsmpoOFHZoP2j2q8EBwM7
	 8csxy0d6Q4CRw==
From: Chris Li <chrisl@kernel.org>
Date: Sun, 02 Nov 2025 07:11:07 -0800
Subject: [PATCH] MAINTAINERS: add Chris and Kairui as the swap maintainer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251102-swap-m-v1-1-582f275d5bce@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIp0B2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwMj3eLyxALdXF1zSwPzNCOTVBNjw0QloOKCotS0zAqwQdGxtbUA2kA
 b/FgAAAA=
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 Yosry Ahmed <yosry.ahmed@linux.dev>, Minchan Kim <minchan@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
 SeongJae Park <sj@kernel.org>, Chris Li <chrisl@kernel.org>
X-Mailer: b4 0.13.0

We have been collaborating on a systematic effort to clean up and improve
the Linux swap system, and might as well take responsibility for it.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2628431dcdfe..8b5af318a0c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16497,12 +16497,12 @@ F:	mm/secretmem.c
 
 MEMORY MANAGEMENT - SWAP
 M:	Andrew Morton <akpm@linux-foundation.org>
+M:	Chris Li <chrisl@kernel.org>
+M:	Kairui Song <kasong@tencent.com>
 R:	Kemeng Shi <shikemeng@huaweicloud.com>
-R:	Kairui Song <kasong@tencent.com>
 R:	Nhat Pham <nphamcs@gmail.com>
 R:	Baoquan He <bhe@redhat.com>
 R:	Barry Song <baohua@kernel.org>
-R:	Chris Li <chrisl@kernel.org>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/mm/swap-table.rst

---
base-commit: 9ef7b034116354ee75502d1849280a4d2ff98a7c
change-id: 20251102-swap-m-7907f24e431a

Best regards,
-- 
Chris Li <chrisl@kernel.org>


