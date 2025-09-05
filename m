Return-Path: <linux-kernel+bounces-803645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 873F6B46352
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F72F168B22
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ACD2773DD;
	Fri,  5 Sep 2025 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wcy2vwDS"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D9F1B0437
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099668; cv=none; b=n3iMXb+XIZ58v5GJN27Ho7wEKOsZPrwDfeGbOKojOe4u/k2KTvh+hRyZvo0UFhAM6jGU6BBpQMhHgQo+C6NVDsxZXFNZZpeOOsiwgykAXr50t4kEtHR/P1a8LsGOyIvMSciWS0bSw8mDLvDyKCmpzD3WKBqtAo7NC+VY1QnZ88k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099668; c=relaxed/simple;
	bh=3GSOhd9YKGJLP3uKPaY5KWa5kFw9s1KPG8wavA4BW1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVDyOpR4RufcOejAOSgzpP2/fT95XmBe4PtGV3B/LFX8KeLO1I4IKWcyxnLpwn+IFXrdaYpYGSlrQZdmwxWLLQPh957i6ywjZlRPbvN21QMDTX/GFJmjUYfogJRbsdX+QBfJl1rKGT4l4XVn2b7DuYfc+6sQHfiauM967z3WosE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wcy2vwDS; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-323266cdf64so2035161a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757099666; x=1757704466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V/6xkjxZiS4WkuxSj7iGXQCi48pk2b1g9CeSbkf+6vY=;
        b=Wcy2vwDSVxJj2zcrw12YOTCcSHzb/LIJhJvpOG2j38PEZzsvedfJG6sB+rJ46ubgu9
         05Hupv1iPTQMQHSBvaG7Lw51emQvl2IGw0ndSkvqP5eUuiiY+jFVB7eCDHQuJfbh4IQL
         GN156vabYMYYQqkmUje9NdNakoZHMyAxg/S+0jXRwnsGxqk+YCT/6uhm9CwrPJTd2n8y
         Fndloy3/GZIeXSsUcpvnmJpkAjTZ0H73v+VmHqaosh+iLRfofX6MrLnUiM6nDO8alkxX
         KdyvZrA1uum8baJg/TN33OFH/3HdFPFXl0jXr1NgBipQXz864Ouw0CMju57SgI1WGw4Z
         plrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099666; x=1757704466;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/6xkjxZiS4WkuxSj7iGXQCi48pk2b1g9CeSbkf+6vY=;
        b=rUY2bMAoIv+8DrFGzvAK/RhxeIKseDog232D8DEMqFjBZnvjhj62zeXfaYI1w3bMCb
         z18qJYDLaTySHK5F5VW8Vxo0Wrb9chJDhWNkihkwdUSEFd93D1vtjb4okM1EyoAZtZ16
         /MiDMo82+yK0+5UhOA30oYXB3Qyb+nATZ01QIiX2lK8lcXGluoMffepIFgve+AkQ1l22
         5zzN5BQf8q/nN1zjf6N8DKfFVR52bwaX3mBHkaG9cs8naLqarfgMB8iM0fUwD5gcBQdZ
         XdD1Xjpp9WtlfB/AqpbZnOTHDtSnti31evYQMbxtRG5nxuIQCXoeS331NaHUl4OGLmpg
         6eVg==
X-Forwarded-Encrypted: i=1; AJvYcCVWHl4EOn18IgdV/zVwoq0kYyDGQE79De6nIrwrN3zrhDHqOHmx+qPtB/LBD79/mqTC3CJD9iVG7qnlDro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHlzMThZ6nPjAc1gZBEuzrLyTxNLQ5Zm2L+UNpj20+kRO+KEN/
	4Kcsccoi6g3c/HpWEtQ8d4Sp+M+F9BOmP5ZJBcwwYeR8vigYZxZ8kr+3
X-Gm-Gg: ASbGnctJZez6a1X+Q9pGx/q+ZFS3iU+gRr64ChBRZIOneLB496tGqy7arCcdn/ydp0p
	F96fBh7Jhx48/snEDMx7cxs+OAHFmcJ7ZMCD7Zt+/F0KqRsLNiYRuOQuomVk/kxe7MaILCYo5z/
	c5VfWnxZoj7qL/T0NYvBzRwcWskBS4T/Pafi/xNN/kj7VaGea/qR80GrkLr9r9FIrTrCeJZdwAX
	ariAW2yyPqxbBz6M8CiKocg1KvPXDJs/oV8uIBLt8ByKq1gtDnrX6X6keAtx0GaXY98ykWLxuBs
	XuK+3Mpt/ylQoGsuLy8vxYLLkEf2rtBl0AfZ0sfICuHIILB+GZOkmObeLK0L5AjvaaqSfKVMTmv
	QWV8A0SSkcvxeZv4k+Q7yuISRBc+1IZayI6dnT4nadT3mZsU=
X-Google-Smtp-Source: AGHT+IGAxCtVPjTCtyLUbjnAoA/ve5psp8+Ku1jl/RRWXT1povQsWgKxWs9snjl6Uh0QMXzMKbPaaA==
X-Received: by 2002:a17:90b:380e:b0:329:d50e:2f24 with SMTP id 98e67ed59e1d1-329d51d757fmr22448731a91.24.1757099665908;
        Fri, 05 Sep 2025 12:14:25 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77256a0f916sm15871442b3a.63.2025.09.05.12.14.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Sep 2025 12:14:25 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 03/15] mm, swap: fix swap cahe index error when retrying reclaim
Date: Sat,  6 Sep 2025 03:13:45 +0800
Message-ID: <20250905191357.78298-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905191357.78298-1-ryncsn@gmail.com>
References: <20250905191357.78298-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

The allocator will reclaim cached slots while scanning. Currently, it
will try again if the reclaim found a folio that is already removed from
the swap cache due to a race. But the following lookup will be using the
wrong index. It won't cause any OOB issue since the swap cache index is
truncated upon lookup, but it may lead to reclaiming of an irrelevant
folio.

This should not cause a measurable issue, but we should fix it.

Fixes: fae8595505313 ("mm, swap: avoid reclaiming irrelevant swap cache")
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4b8ab2cb49ca..4c63fc62f4cb 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -240,13 +240,13 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	 * Offset could point to the middle of a large folio, or folio
 	 * may no longer point to the expected offset before it's locked.
 	 */
-	entry = folio->swap;
-	if (offset < swp_offset(entry) || offset >= swp_offset(entry) + nr_pages) {
+	if (offset < swp_offset(folio->swap) ||
+	    offset >= swp_offset(folio->swap) + nr_pages) {
 		folio_unlock(folio);
 		folio_put(folio);
 		goto again;
 	}
-	offset = swp_offset(entry);
+	offset = swp_offset(folio->swap);
 
 	need_reclaim = ((flags & TTRS_ANYWAY) ||
 			((flags & TTRS_UNMAPPED) && !folio_mapped(folio)) ||
-- 
2.51.0


