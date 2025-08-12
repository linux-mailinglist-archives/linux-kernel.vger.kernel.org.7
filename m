Return-Path: <linux-kernel+bounces-764171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 077BFB21F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0E67ACC1F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965882DCC08;
	Tue, 12 Aug 2025 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOP7mj6e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A242D8376
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754982660; cv=none; b=lZg0NkOhtknkQMOTpZ6I4c1J27ol5+OE8InXZL31SA6sAjSMX0jWZ0Dp4LptmgZfwSJ3320RcgDtehNHc1kS3sL3fOFAK3rvBZo7CSVkKMWu1iSCEhR17uCoxexVWlUuDoBRt9u3rt2hrbYS8UUa1SYnkpqyOEQv1z7+rNdrXKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754982660; c=relaxed/simple;
	bh=obdOWxAf7RFXJ2IB/8yF3uqWcTZG9h0+RKS1zCQ9UP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aojami4wPrJjm6cIlYTXEHKlU3OQbkRKp8O2VFYH0440f+CSpBk4eJ3bESJXLmY/yI5AHCu7jJLepLnLWxMGbz9ATSc2L+VAsgXlsXpdbhDeuybMnOPaq3RGwGX1XP4LTsETMw1jpqPbmLfluN7J3k8rr7ZMbJNs50JdQ2rwmBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOP7mj6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93824C4CEF0;
	Tue, 12 Aug 2025 07:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754982659;
	bh=obdOWxAf7RFXJ2IB/8yF3uqWcTZG9h0+RKS1zCQ9UP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bOP7mj6eg5jHCROEXjruEK4HythPameWSjzlj+oPPo0hvojrO1/WpDET+iDJD8mse
	 KWNqhP+95GM3HcOpwiBQrg8bcqV4h0tpe33J/q+TzIeNJOve1CzVPrSSHwSyJM8aZP
	 rD06s4wj3xZHNTOAJCdM4vQX9Nx0KTARmDerFL/6zR50yZoego+DTMzeRoKemji4XV
	 2bCb7oe2dq66FfEFvmgZDr0Eo87+Tbic6F1Y7+cZP3oK4DvqnAVjxIs3X+BOafmh91
	 RIe86BWh3X9LUkIID21z78uX4CqkNTDv0X9RC34ZmS2Tw9VHTfNa457rnxxNr2ZlRz
	 B2l5/ACkHxiow==
From: Chris Li <chrisl@kernel.org>
Date: Tue, 12 Aug 2025 00:10:59 -0700
Subject: [PATCH v3 2/2] mm: swap.h: Remove deleted field from comments
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-swap-scan-list-v3-2-6d73504d267b@kernel.org>
References: <20250812-swap-scan-list-v3-0-6d73504d267b@kernel.org>
In-Reply-To: <20250812-swap-scan-list-v3-0-6d73504d267b@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, 
 "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Chris Li <chrisl@kernel.org>
X-Mailer: b4 0.13.0

The comment for struct swap_info_struct.lock incorrectly mentions fields
that have already been deleted from the structure.

Updates the comments to accurately reflect the current struct
swap_info_struct.

There is no functional change.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 include/linux/swap.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a060d102e0d1..c2da85cb7fe7 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -320,11 +320,8 @@ struct swap_info_struct {
 	struct completion comp;		/* seldom referenced */
 	spinlock_t lock;		/*
 					 * protect map scan related fields like
-					 * swap_map, lowest_bit, highest_bit,
-					 * inuse_pages, cluster_next,
-					 * cluster_nr, lowest_alloc,
-					 * highest_alloc, free/discard cluster
-					 * list. other fields are only changed
+					 * swap_map, inuse_pages and all cluster
+					 * lists. other fields are only changed
 					 * at swapon/swapoff, so are protected
 					 * by swap_lock. changing flags need
 					 * hold this lock and swap_lock. If

-- 
2.43.0


