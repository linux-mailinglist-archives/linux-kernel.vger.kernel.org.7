Return-Path: <linux-kernel+bounces-828378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82877B94800
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93C6E7A9C09
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EB130E0D8;
	Tue, 23 Sep 2025 06:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrXo81Y6"
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6A025B1CE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758607582; cv=none; b=CD0VH05mpy7V4e8oOZAF1zaFksUWQ5BrumxzOoQ0a4IHIt6ZeACewMgUcpl7BzX/WATIMzCd+EO7GAfJQqO2hK3+Oe5mi+n0n8B+REmjy5TEFi0HfahCXEJ5/tMs34UZ2b6GWDkTWbOftls+mN4FyPNCTUBxR/XH86ITkajLXVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758607582; c=relaxed/simple;
	bh=Er4W8MIpmwD3PLCWmK+B4k++5a8DHlRT/jgXJD2s0sU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IF3cAWbg1W3OUalIHwfRkdIO8J3eVKJtsrqu7/vdKW92E1JrQnNj5Z+RfJX/B7lua5r2JKpTKdx7R/SkEL0icPvFMBYHFlyhznXtEgedCi6oZBdSiy2VqBqomJBG0C+n4mcMQuiPnqipUvoPV9r7MBZi5RYQi+eDDJLxWqF48Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrXo81Y6; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-32ee4817c43so3943808a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758607580; x=1759212380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=omk+3E3VbH2i+N8tji9NWKgODSvwpWUngMp/3zr1rgI=;
        b=OrXo81Y6/x3McQ9nk3fL5LKDPCiLm6MADQ7DXICO1fjtmzvSpDYA+do8zQI3prDsoz
         wL47PqaWzBK0+htmxLl+hjmUAQJyIl89lihHOnzDeI8yYturKpCIPIfYYbrk/TYoXma3
         p6DqA5dOlr+YiHjzHQ30gmcxHmXg65YogOpDASFIA1WVCJLbG5xXoMb0seaksdoFRO8Y
         WDip8zO/p2hOwdNfowFU8Cxh5pX+ZJZIs7SuVHXtzUGWNgYHLIhQKuqPFx0H5v+g/Iqa
         er/iNIdkv+M65FACke/iHAkyMQKHb4nov4FqMciilIb1xkxJBtqxe4mz7sHpYDbk7kgi
         889Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758607580; x=1759212380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omk+3E3VbH2i+N8tji9NWKgODSvwpWUngMp/3zr1rgI=;
        b=cXEDbdLvi38cDR1hcezzJzLRqwfsP+QCYI1B98A/deNdqPprn2yeacIXzN0VBc4RPh
         EOgseggkWsck1aQdkXI0GZr6KNwP4EEEdtgr1PZ4Kdqq+Oasb+RuH0a4zDYBf/UAychm
         nk0AfxOOPiZavlxty/Vz5048PucLwZJzYdKz3JFl9XwUtUcUuYTT8/QcPjAAgUDpG+QZ
         LKVCQxcSfkk0K/vcslJxwQRhdJ+rSEHDhWECso7qdmhNIHa3m3f8Qy+IyHlkDLUcgVYO
         4+flc0xOlj/L7hMLKjvTp6j0A8HliYo65Da4+CT82GJAJemC5s8Xe6AX+rDpbJt6caUM
         g5Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUgfEy9f8HwBS0UMSQVI0VrZ9NMARgqqhWJzxh5P0fT+o2MCyhSTbKgtYRQHoy1/oUPL7lXe3pe5ixSIIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgniSpHO8ad7wR8wHiNajAdVAsk1H6SFWFfe775IVykD7ug/mG
	BIrhK5WR7y/qosh8Y3GYZGHmWbsv7vj041S+F4qEe8qAXqctnzVzOyfZgYxR5mr66YA9pg==
X-Gm-Gg: ASbGnctt//mYKGsl3tWmIxYnToD44Ew86Dp0wanpVIxM8kl6Dp7I7IEw+5kY/nMT+4A
	AMi11gBF8wCNuVc7+ttP+ctpWMCsgIgB2aLON3v41EAXoPEyOzZJXgsGoJlrjWO9Bje1pE48yse
	UvimILv8MRP7RI/vj+oeX93D3uwx7JNktihT9GJpVRG3DlRiyf0RFifqK3WqhHGdPeOy54Vi/gG
	Bz/teMewb+ZTeqvwovh0PHt4zLWEz6TL/O4pLza58LFj744aHGDlTnvy6NgpgwBf50Ns3jjnWoO
	Ly+sKclL9hqdK/b9WcSQakBD76507XJnrbXERAjX1PQNUkQy9rLYUT7AM6LUXarpWoIj73ZgIP8
	ZPbuKfSTwdt4fO+q7QAU=
X-Google-Smtp-Source: AGHT+IFjh9VwSK8iG3IMnKGftTZdz3zGpcCmuQXcy2PSoEUaE8GN+Ok52y1XVrwZHbztSofbKH8EHA==
X-Received: by 2002:a17:90a:dfcf:b0:32b:9506:1782 with SMTP id 98e67ed59e1d1-332abf16faemr1446491a91.15.1758607579783;
        Mon, 22 Sep 2025 23:06:19 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed26857a0sm18103451a91.2.2025.09.22.23.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 23:06:19 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: herbert@gondor.apana.org.au
Cc: tgraf@suug.ch,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rhashtable: add likely() to __rht_ptr()
Date: Tue, 23 Sep 2025 14:06:14 +0800
Message-ID: <20250923060614.539789-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the fast path, the value of "p" in __rht_ptr() should be valid.
Therefore, wrap it with a "likely". The performance increasing is tiny,
but it's still worth to do it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/rhashtable.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index e740157f3cd7..a8e38a74acf5 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -358,9 +358,10 @@ static inline void rht_unlock(struct bucket_table *tbl,
 static inline struct rhash_head *__rht_ptr(
 	struct rhash_lock_head *p, struct rhash_lock_head __rcu *const *bkt)
 {
+	unsigned long p_val = (unsigned long)p & ~BIT(0);
+
 	return (struct rhash_head *)
-		((unsigned long)p & ~BIT(0) ?:
-		 (unsigned long)RHT_NULLS_MARKER(bkt));
+		(likely(p_val) ? p_val : (unsigned long)RHT_NULLS_MARKER(bkt));
 }
 
 /*
-- 
2.51.0


