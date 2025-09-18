Return-Path: <linux-kernel+bounces-789886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A5DB39C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D285D366DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72B830F55E;
	Thu, 28 Aug 2025 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="JlW4VNX6"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A030F80C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382704; cv=none; b=ZF043fXahBDcOmN7mJrCbz5GsaFJegjqzDV7MgUdVkzUEHA4QLLlS7gB1ggGEZUY6SLjovnkEie2ha5bP9lWrNu8wDBNpyO2dC6yJA1YoHdjDDJLGERYG2ivOMKbw+RXwmGTm8uGvxHK1Kb1pIq/a1QVz5ijSIRroiJYJ4n0FjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382704; c=relaxed/simple;
	bh=LbO1QOgysbdLndSSd76TuWypzxpCmVsAoAlB9MGwu3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ngX55Y338yO84XIwqCKp/2EL/KM4SiJehgGSJjah1PhIzqr6E34p9P3cqaZXSbpXvV+0mS7pomZYcizZKsYUIWMkd7yMTUX5pYG2/iXNgHoVdE2iw5R1vjaoo1tv8OlrHbj0zOVmo4wsxQ2q8IRmI15d8KuDdxNNZ5hWz5RJ280=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=JlW4VNX6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ceb830dd58so84407f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756382699; x=1756987499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+BOPqGhZLfbIfYuD0MGvXzD0+z188+PonWYLkcs9RNE=;
        b=JlW4VNX6BdqYWS9szkD275BDdXumBiLaRT1RFXj+sRqpD1k5UwVH1LuZvisO1oJp5f
         mFa2YKdBVoP0GaXkrE/kKjKdQYWwjncGfQXPfsqo7IqOhXZF/1tm0ctQw+DkT1W2h+H7
         eE65Qq9Ha8y47q4eWJS0/mM0PuIezOjImV8YL/Xxywyp/gYtbXz8yGFo2qPRdrYUdJ7c
         GmYKZrUnGVEnJSVtdsPtAGT5kkEr9fIQ8QBZeBJ3CgJe2gMKN1O/eqr3vekcboG0HAuh
         6Rq0nfcohKrdlKzVv40HSvg+UGCIAbnhYz0ov703+Pe2nt1gT6waLzhDz/RSdhW1rd51
         eNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756382699; x=1756987499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BOPqGhZLfbIfYuD0MGvXzD0+z188+PonWYLkcs9RNE=;
        b=g9qZOyg5sSO0qAiEteHxJeRFVx9hZxsOzaAydli8iBTAVg3J4yOU8LpHGvUzNaLJe2
         2HR8TJN/TzeuxsyLuVJwRRidHwAqFdc73bgxnKmK20Fbz4C6VH4uk8OhUsvbNlBV+1q8
         B0mkPeNjpExif3XYc3sBJPLkmzv44e9mpg2fp8X08ofRTTSGlmRHc79OwV/wA55/FKa8
         Qt4mt0+g5oyvep2+lpQOanxDyMlqhTSphQDssYzFTuivy/Bxp7A2u32iksykh9+n+5IT
         uXS+z0C1L5xeeniY0lTQ/hcW+HGFD9uqI0k+/D31wiUUBGtoYLLlDdC+AX+6Dp8V7geI
         Qb/g==
X-Forwarded-Encrypted: i=1; AJvYcCXgg3+nZw37TRS0cSaxE+QAHi7+ZJfTOZytVZJ8z57lD6nzR0yEqrRJYypz8RUbbXYAjSCDxYzNzT1eOTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDOJRM9uuXBquA8kMkvns29+rmGqF3Gg7k+NlQfzQbffF4z2Ki
	pVlC+2WtCaFBJHqOIryW0Ybphn671+tb3W7uGrqSXGK/wbjCDmEir89q3PjmylmmBSk=
X-Gm-Gg: ASbGncvzOBLW67ofxpLcuRBFH6PSZq7d3bhQyyizFIwX/E40QRvSHOVkSTA4S9e27KK
	V5cfl9cnh/XzBfOx+NovgGnPL81Nt5v+tIjUt0KCqmK5IJ1QF6rTWRUH/UHsgp/mwHXqaOJBCpH
	G8Kgf/49+0IWMv0NRmhUUACtGkdzG5dYXLZMnq+losnc1Lo1wVLqXxGEXl5lZBGSBjM14o10Cgp
	O7ojgVC9z05YDghyPzE5wGSlCIhooDObtSJ9aGP5LORNC38IwXDak8oj6doBvoIKldL2pcsPPJe
	B1MCxRsprYrF4BHESvsDoDNgb2jJsvFR/mL66K0uI9peAHZPRVlnSAX9jboajP57AQu/5C2y0uC
	5iHfIggwmqsRCrXcvZqPQ79dG/b6nyTOEsT3NXIKXDYU2Rr4n6+v2PMpHqNW7J0U6gh8IlgJ148
	JMwcFBr9Y3Lu7GAR5ifL7Eyg==
X-Google-Smtp-Source: AGHT+IGzoTsypgvoIpQsTCGny5L+jcRoWYZSRf2lTXtYqJtN0aGMGTRo6Dqju9vXNW8/IdhIYpWfbg==
X-Received: by 2002:a5d:4f89:0:b0:3ce:5696:39f1 with SMTP id ffacd0b85a97d-3ce56963e87mr831053f8f.22.1756382699180;
        Thu, 28 Aug 2025 05:04:59 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b797e5cd5sm30266815e9.22.2025.08.28.05.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:04:57 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: Slava.Dubeyko@ibm.com,
	xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/ceph/addr: convert `op_idx`, `data_pages` back to a local variables
Date: Thu, 28 Aug 2025 14:04:53 +0200
Message-ID: <20250828120453.748058-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These were local variables until commit f08068df4aa4 ("ceph: extend
ceph_writeback_ctl for ceph_writepages_start() refactoring"), but were
moved to the struct ceph_writeback_ctl for no obvious reason.  Having
these in a struct means overhead, so let's move them back.

For the "allocate new pages array for next request" code block,
however I decided to introduce a new local variable `old_pages`
instead, because reusing `data_pages` for reallocation seemed
confusing to me.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/addr.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8b202d789e93..fc3192c79072 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -611,7 +611,6 @@ struct ceph_writeback_ctl
 
 	bool from_pool;
 	struct page **pages;
-	struct page **data_pages;
 };
 
 /*
@@ -1051,7 +1050,6 @@ void ceph_init_writeback_ctl(struct address_space *mapping,
 		ceph_wbc->tag = PAGECACHE_TAG_DIRTY;
 	}
 
-	ceph_wbc->op_idx = -1;
 	ceph_wbc->num_ops = 0;
 	ceph_wbc->offset = 0;
 	ceph_wbc->len = 0;
@@ -1060,7 +1058,6 @@ void ceph_init_writeback_ctl(struct address_space *mapping,
 	ceph_folio_batch_init(ceph_wbc);
 
 	ceph_wbc->pages = NULL;
-	ceph_wbc->data_pages = NULL;
 }
 
 static inline
@@ -1417,10 +1414,12 @@ int ceph_submit_write(struct address_space *mapping,
 	struct ceph_vino vino = ceph_vino(inode);
 	struct ceph_osd_request *req = NULL;
 	struct page *page = NULL;
+	struct page **data_pages;
 	bool caching = ceph_is_cache_enabled(inode);
 	u64 offset;
 	u64 len;
 	unsigned i;
+	unsigned op_idx;
 
 new_request:
 	offset = ceph_fscrypt_page_offset(ceph_wbc->pages[0]);
@@ -1481,8 +1480,8 @@ int ceph_submit_write(struct address_space *mapping,
 
 	/* Format the osd request message and submit the write */
 	len = 0;
-	ceph_wbc->data_pages = ceph_wbc->pages;
-	ceph_wbc->op_idx = 0;
+	data_pages = ceph_wbc->pages;
+	op_idx = 0;
 	for (i = 0; i < ceph_wbc->locked_pages; i++) {
 		u64 cur_offset;
 
@@ -1495,29 +1494,29 @@ int ceph_submit_write(struct address_space *mapping,
 		 */
 		if (offset + len != cur_offset) {
 			/* If it's full, stop here */
-			if (ceph_wbc->op_idx + 1 == req->r_num_ops)
+			if (op_idx + 1 == req->r_num_ops)
 				break;
 
 			/* Kick off an fscache write with what we have so far. */
 			ceph_fscache_write_to_cache(inode, offset, len, caching);
 
 			/* Start a new extent */
-			osd_req_op_extent_dup_last(req, ceph_wbc->op_idx,
+			osd_req_op_extent_dup_last(req, op_idx,
 						   cur_offset - offset);
 
 			doutc(cl, "got pages at %llu~%llu\n", offset, len);
 
-			osd_req_op_extent_osd_data_pages(req, ceph_wbc->op_idx,
-							 ceph_wbc->data_pages,
+			osd_req_op_extent_osd_data_pages(req, op_idx,
+							 data_pages,
 							 len, 0,
 							 ceph_wbc->from_pool,
 							 false);
-			osd_req_op_extent_update(req, ceph_wbc->op_idx, len);
+			osd_req_op_extent_update(req, op_idx, len);
 
 			len = 0;
 			offset = cur_offset;
-			ceph_wbc->data_pages = ceph_wbc->pages + i;
-			ceph_wbc->op_idx++;
+			data_pages = ceph_wbc->pages + i;
+			op_idx++;
 		}
 
 		set_page_writeback(page);
@@ -1555,25 +1554,27 @@ int ceph_submit_write(struct address_space *mapping,
 			offset, len);
 	}
 
-	osd_req_op_extent_osd_data_pages(req, ceph_wbc->op_idx,
-					 ceph_wbc->data_pages, len,
+	osd_req_op_extent_osd_data_pages(req, op_idx,
+					 data_pages, len,
 					 0, ceph_wbc->from_pool, false);
-	osd_req_op_extent_update(req, ceph_wbc->op_idx, len);
+	osd_req_op_extent_update(req, op_idx, len);
 
-	BUG_ON(ceph_wbc->op_idx + 1 != req->r_num_ops);
+	BUG_ON(op_idx + 1 != req->r_num_ops);
 
 	ceph_wbc->from_pool = false;
 	if (i < ceph_wbc->locked_pages) {
+		struct page **old_pages;
+
 		BUG_ON(ceph_wbc->num_ops <= req->r_num_ops);
 		ceph_wbc->num_ops -= req->r_num_ops;
 		ceph_wbc->locked_pages -= i;
 
 		/* allocate new pages array for next request */
-		ceph_wbc->data_pages = ceph_wbc->pages;
+		old_pages = ceph_wbc->pages;
 		__ceph_allocate_page_array(ceph_wbc, ceph_wbc->locked_pages);
-		memcpy(ceph_wbc->pages, ceph_wbc->data_pages + i,
+		memcpy(ceph_wbc->pages, old_pages + i,
 			ceph_wbc->locked_pages * sizeof(*ceph_wbc->pages));
-		memset(ceph_wbc->data_pages + i, 0,
+		memset(old_pages + i, 0,
 			ceph_wbc->locked_pages * sizeof(*ceph_wbc->pages));
 	} else {
 		BUG_ON(ceph_wbc->num_ops != req->r_num_ops);
-- 
2.47.2


