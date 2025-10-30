Return-Path: <linux-kernel+bounces-878218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A86EC200B6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3DC3BE0A1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4991E31A546;
	Thu, 30 Oct 2025 12:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="aC2x86qX"
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11234A926
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827770; cv=pass; b=nf4RPc9XN2tQKt85vfCtS7PiniLFnBQp3QeL/d34JSFwOyuCv4u1RD323CXo8i1xoTK5sTSgNfUL1vgFqlZjUjcApOAPc6NJnt3cgJnGMUy2gwks8fiAwFUz677aBXj2HM1TNDJT2EFvHzZFDIS2m6G0fp1V4p4w+r4dBpUXoAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827770; c=relaxed/simple;
	bh=Pm4gfPGpEvl7urYYvAAc//M9O+0YLVRYbm6O0V4Wi5E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lupbedXNho3yxsOouA4N0VpR9EWfhds3cwesemjUryNuO6dymRWUOu/RR1b7uBZIYG5oq+FRXoOFUtsMR5qyyIG3DYkQYX5/mucRCkZuPjdMr5GjTkvfPQGY7LI+uqYpCCk9Wz9GZK0KYkzEesATZ1HwrLS6mU5yaAG5bjuaqfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=aC2x86qX; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1761827621; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WD6MzwZLw+f1i4E6IGchnSdOtk+am2Sii0xKDNsIARExAr3ZvCG3sDvpqZpfCXHqDMYHasEr0yjexWFCT3YIa7TczkU7WYz0Ko/vUR8KE94dS3BSFRz6iCS2Y0NqEsgsatfm9Z7hRaR1xdRVTa2QDSO5bEsnEmrNF8d9SQxaRtc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761827621; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=LWxPD1jqIGf0eGjGt5kSF5OaU2M0+DsfoZfQTI0FPb0=; 
	b=OqYNl8i4mQXWmzp8BsYYSXofV1VrEK9hRj7ss/Eht2nVfa6Jb4YIi9MowjxzAXl/Ecxcle5ZzYumLmgGGHesepPjrOag0QsR9y6dlYm6bRT5mqqZ+d/3kIwydrDt8dhI2j+etJHYBWC5qZBhRRrUACrvNrubVKwISg4jFIFQJNw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761827621;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=LWxPD1jqIGf0eGjGt5kSF5OaU2M0+DsfoZfQTI0FPb0=;
	b=aC2x86qXNi1GODrvOiiJ5+MPt731zhANJjxBf2b1FV6BxD2fIMvkBLgeWNS3Szsb
	sh77LwFbJpm8ePijkd+owC5a+Yef9Gtq1X/EdFvLHdogTqse45OaR6fxOUNhjqhvyhr
	O/ZeG32tT2pN4SRtf97VqcLki4hj5PG2LT7tqZnE=
Received: by mx.zohomail.com with SMTPS id 1761827618663161.67818038594123;
	Thu, 30 Oct 2025 05:33:38 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>
Subject: [PATCH 2/3] dm-pcache: reuse meta_addr in pcache_meta_find_latest
Date: Thu, 30 Oct 2025 20:33:20 +0800
Message-ID: <20251030123323.967081-3-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030123323.967081-1-me@linux.beauty>
References: <20251030123323.967081-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

pcache_meta_find_latest() already computes the metadata address as
meta_addr. Reuse that instead of recomputing.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 drivers/md/dm-pcache/pcache_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-pcache/pcache_internal.h b/drivers/md/dm-pcache/pcache_internal.h
index d427e534727ce..b7a3319d2bd3e 100644
--- a/drivers/md/dm-pcache/pcache_internal.h
+++ b/drivers/md/dm-pcache/pcache_internal.h
@@ -99,7 +99,7 @@ static inline void __must_check *pcache_meta_find_latest(struct pcache_meta_head
 		/* Update latest if a more recent sequence is found */
 		if (!latest || pcache_meta_seq_after(meta->seq, seq_latest)) {
 			seq_latest = meta->seq;
-			latest = (void *)header + (i * meta_max_size);
+			latest = meta_addr;
 		}
 	}
 
-- 
2.51.0


