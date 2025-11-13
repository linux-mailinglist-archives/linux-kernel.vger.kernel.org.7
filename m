Return-Path: <linux-kernel+bounces-898930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C13C56587
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A8824E9EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D82B331A68;
	Thu, 13 Nov 2025 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3H2qB260"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCA420ADF8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023237; cv=none; b=NNXdS+ne4eeg3h49L5uWb0/9Sz501bc/azegVzvy2Qz9AaDvZhktE58p7tPAnfOxWtjDyRvqwj1BjJxA8r3g/Bc7JsKllew7iUiPQUEz2dbzf/v+JDr4cG9Q2oyQeVPe0hyk+9eTKDt2VCHXA2kjbH0lw53Uj/6APT/yAVpX76E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023237; c=relaxed/simple;
	bh=60ZZn0RaxFokmxrmn9HfISJVT1aIkYNfunnuj0np1Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4uTMBV0uzZ1pSno4ZyjN8a31CJJy8eAWHzZFYlT6u6ZJV0V1IeVDhRmQObhABikdYMYWRCxGp5GzjUGOBqC/v8AK6WRDm8v9b3NtIb3Z8mY5mIyPfDm9pPKyEC/RhwLT2YdJ+LoEVixme8kUbTdFRBCG2up11XAouRvptD9vUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3H2qB260; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oJ3MIZLrxHKL3HXjB9g5ZhKNNJWUlT+3FdxZLvo6TYU=; b=3H2qB260bJGzdc+mmZgu7gbjP6
	1tD87ZP9O2SQYeVz0R5sOPzmZUiDzhxP5hMx4R7leLOcXctMCAKcG5vKLyy9X+ppA+1/z49+ZC2KO
	2KpYYgSaACQwf4BzVa7sPYVcLw9ABkTLAakb1cSccaVOrDJi6Kpf3gYH4WSokTCp3ib8fsjhaaTDC
	wAMU/QnGPc05g8wj/PrFiL203dpiEripAEpep5/4LLaxLnUq02mJcdQPKphySrabkUFuQ36qIVpkQ
	uoB7AeMpdvoml9M8Tp/iYlTBhsLy52Ipw5QoVCCT1q2StYTwG6fR6WbFgVrGOLdjF3q4Ufn5hZWAG
	OHBPvXbA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJSsa-0000000A7Nb-3vnA;
	Thu, 13 Nov 2025 08:40:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Eric Biggers <ebiggers@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] fault-inject: make enum fault_flags available unconditionally
Date: Thu, 13 Nov 2025 09:39:42 +0100
Message-ID: <20251113084022.1255121-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113084022.1255121-1-hch@lst.de>
References: <20251113084022.1255121-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This will allow using should_fail_ex from code without having to
make it conditional on CONFIG_FAULT_INJECTION.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/fault-inject.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
index 8c829d28dcf3..58fd14c82270 100644
--- a/include/linux/fault-inject.h
+++ b/include/linux/fault-inject.h
@@ -8,6 +8,10 @@
 struct dentry;
 struct kmem_cache;
 
+enum fault_flags {
+	FAULT_NOWARN =	1 << 0,
+};
+
 #ifdef CONFIG_FAULT_INJECTION
 
 #include <linux/atomic.h>
@@ -36,10 +40,6 @@ struct fault_attr {
 	struct dentry *dname;
 };
 
-enum fault_flags {
-	FAULT_NOWARN =	1 << 0,
-};
-
 #define FAULT_ATTR_INITIALIZER {					\
 		.interval = 1,						\
 		.times = ATOMIC_INIT(1),				\
-- 
2.47.3


