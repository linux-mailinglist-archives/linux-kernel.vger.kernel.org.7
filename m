Return-Path: <linux-kernel+bounces-895540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D767C4E3F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574E03ADEB6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B5231A81A;
	Tue, 11 Nov 2025 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vfmHbSQo"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FBB3590CE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869195; cv=none; b=hf6L7yvR53TT7If2UEny6oSNUit8UqxVylMyhYdGoot68RAJpkM8omolMFEdohjJEBspRVYmmT4EE2ihzrrVCJbQOA4zRZuABCGtrxRcS2e/6m5dWbYSnYJypRPbSiVDdJWOPCKrMRL/Acv0xlyt3VzwRYc5+/MDPhySv80v2LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869195; c=relaxed/simple;
	bh=60ZZn0RaxFokmxrmn9HfISJVT1aIkYNfunnuj0np1Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRW1em0DraYgys/1G8IJcapCkQR4NXi3+VcyfGpcYGSym5KTdngr7Co4QMDgLInyYP4pPBlVQ3fD3wPBl78XtC/4gvI7HSy22j1oVBgDl40pnivEjZmDAZOJBwVYwkSdDh2KljDAA8eoFBDHNSA6bvUszbyN8uxeFkR8ihsKphk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vfmHbSQo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oJ3MIZLrxHKL3HXjB9g5ZhKNNJWUlT+3FdxZLvo6TYU=; b=vfmHbSQoKbk/eHEQps3YF+WiP5
	PhmLX7JIBBxB6ei3KUT/QQJE6o3WL7OqfHPAsnzJqb/Fk0K9MAsjUevroY/pdxq9CpdL8ZDMCiPS5
	phsTWN6C0u1We8I80KKJOWu30SwhSDZ4hMf4Dj+YvHeTl707vhGh2sU44aBLPKHietRYx1drr5Gzg
	x+RN3bDDI5Om4oh6zYjT20uZWWkgEdBm62bULDw7pMkc2zjFRQR2CVnj1Zoe9rQH4eYG7eqXm61F8
	XeArfYKWEg9wQNlvET3Y5NElk/GlO7g00tlfCX6gakmyvcaDEVEBKpZmrJfRq0lwqBe61lAZCf+ia
	VBe747fw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIoo2-00000007GYa-1FVy;
	Tue, 11 Nov 2025 13:53:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Eric Biggers <ebiggers@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] fault-inject: make enum fault_flags available unconditionally
Date: Tue, 11 Nov 2025 14:52:29 +0100
Message-ID: <20251111135300.752962-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111135300.752962-1-hch@lst.de>
References: <20251111135300.752962-1-hch@lst.de>
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


