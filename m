Return-Path: <linux-kernel+bounces-829940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F35B9847F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C812A15C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CE622D9EB;
	Wed, 24 Sep 2025 05:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQd7hyGr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CC76FC5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758691638; cv=none; b=lPJJ3BxMdFt3cil43rsUsKdkDL8pxl1lyQzM5JWue3V43M6wjt/xq4d5fRrelc5uDEHAn5OP4y3YlpFk1zYgGH3kXWHDmKnbGbOhs1Sxv73Kvtnz/BMrzgPRweEmBhJM8OYCCJ+iWIcllMtJyTYZYclD/RzrJ5Mh6DMB9dbdH6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758691638; c=relaxed/simple;
	bh=rcN9V5LgKmUDWSRQZxN6EScS8uDKfYLSUyVCZijz34s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gG07cYm43pIC7Mmqbx1UvAxLl0emDOGSGSo5ld4PfCBFXt611cR6o2mQxOPCdCL6f5b9/2jXTk9sIuqWKWzobkHX1nhs4zXTkXtE1dCyopMkPKrxfM39AgxlKHq7ZtXEm0g55/mQQJk8NStqf9ESZ9r6vTcgURUWv5NjwZwFktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQd7hyGr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758691634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=ERAoYpMxtDzUD7G3vhLO8DlEI+eK/IUeWFrCKYCHy9Y=;
	b=iQd7hyGrzzois5TJK8ptSvEst5QJEYkadMRoIUIC7kIWqU3Rc5Cm8TUjht5ziFY78IYTi4
	NszjHS5EAXgLi5rBbqSa1k/ob226hgTcUZBchX2k8L2aYLhKdI+F64DLH1pyH/MSRTH7R+
	ZjLh0br2Z8VGixIHxarq9aOJMEZ3Y2M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-6_Q1hsUHMJ2c9kbn6gyeFg-1; Wed, 24 Sep 2025 01:27:11 -0400
X-MC-Unique: 6_Q1hsUHMJ2c9kbn6gyeFg-1
X-Mimecast-MFC-AGG-ID: 6_Q1hsUHMJ2c9kbn6gyeFg_1758691630
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e1e147cc0so21472835e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758691630; x=1759296430;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERAoYpMxtDzUD7G3vhLO8DlEI+eK/IUeWFrCKYCHy9Y=;
        b=Q32M5UeUtw331i0nGYG6sQYud/8JDkH758gYQqbvG4IDKZRCKDd0a6zIsLcPJe7KF6
         eV6g+Zbx2xTgaiw99W56t6l7HAirkWoRwkP+hxiG6Er+eFy1FQajRXSdXjjFDDs3booO
         ktoMUglRsgVt4fpa6lJDzAdNNbLgVzo3vlZEstz2R57aGJ4SRChMzHoi/O56Tw8TW45n
         ej9BoelZw/n9hLh8PBphTJLIfLzuJXfG2cajSZZUz2HKtq0Gz/xmg5ph96iUhsBkBVHg
         WIkqZXBnEscZBkn4K1JWZgNfCeUcFHrmpFu5EbTJzi68UyKNj45whR7wAQj2M4+1AxpG
         TJdg==
X-Gm-Message-State: AOJu0YwKJH4ReVygl2Fh0yashYwE6zUdNzgn8D+mD2IyRS2UaJu6p9Vg
	FsdbJj+y9P0MHK8EdfRim6iFlJSlwmsv07yL7GrV6lcNkKU6u6kmcn84narTq9G/WGoGjYBv9NT
	ywYC5o5mJo6e11TN9PJXYTT+MP6z+2DxKq8ecCY83TxR6xkB2MfZqmZ4MdIINWVFccRb2qIAWEs
	AGwl/z273hk8GCbWzTvz31Lsj2WCMYdWx/E50joi6JfVg=
X-Gm-Gg: ASbGnct1QNGFUduzwzo/sQDvaRXtP050+U5w4E4HAldpHDIUKzpjHD3YjaPZ41UY2MN
	+Gq9BHTpLheYJoHQxQUO3n6lbz8tQC8GAH6oGvNZBfNiTIGkXwVHYBZZ4+30RT5GPehCYHlYSVG
	SkhuWSB73/WsIOR1IFbVdcPJ4DGFxdRo+4L6/RsMyAvwZHx2zR8tgtEi1gjhL1QrvlBdEjUSHQF
	sbHX1Zmu8QJrNPrZM4GFgkji2o94e9/ZKjtA4gO6Z1xcjEvizIJpH/tq1xBoVuBlesyuRmDlP4k
	8EaH5qAbyt0hfv0MC/qkor4Oi+SlHrwe/pY=
X-Received: by 2002:a5d:5703:0:b0:3ed:e1d8:bd73 with SMTP id ffacd0b85a97d-405ccbd7134mr3235980f8f.57.1758691629699;
        Tue, 23 Sep 2025 22:27:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5oQeVT7CKEbf5OCtcMlY7u7zZmn5BQoE+KmwNxb2YtEQ0G5EhwtLvtdy5csjDyGCS3ujNUQ==
X-Received: by 2002:a5d:5703:0:b0:3ed:e1d8:bd73 with SMTP id ffacd0b85a97d-405ccbd7134mr3235962f8f.57.1758691629177;
        Tue, 23 Sep 2025 22:27:09 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9ac5basm18752475e9.7.2025.09.23.22.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 22:27:08 -0700 (PDT)
Date: Wed, 24 Sep 2025 01:27:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH net] ptr_ring: drop duplicated tail zeroing code
Message-ID: <adb9d941de4a2b619ddb2be271a9939849e70687.1758690291.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

We have some rather subtle code around zeroing tail entries, minimizing
cache bouncing.  Let's put it all in one place.

Doing this also reduces the text size slightly, e.g. for
drivers/vhost/net.o
  Before: text: 15,114 bytes
  After: text: 15,082 bytes

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Lightly tested.

 include/linux/ptr_ring.h | 42 +++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 551329220e4f..a736b16859a6 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -243,6 +243,24 @@ static inline bool ptr_ring_empty_bh(struct ptr_ring *r)
 	return ret;
 }
 
+/* Zero entries from tail to specified head.
+ * NB: if consumer_head can be >= r->size need to fixup tail later.
+ */
+static inline void __ptr_ring_zero_tail(struct ptr_ring *r, int consumer_head)
+{
+	int head = consumer_head - 1;
+
+	/* Zero out entries in the reverse order: this way we touch the
+	 * cache line that producer might currently be reading the last;
+	 * producer won't make progress and touch other cache lines
+	 * besides the first one until we write out all entries.
+	 */
+	while (likely(head >= r->consumer_tail))
+		r->queue[head--] = NULL;
+
+	r->consumer_tail = consumer_head;
+}
+
 /* Must only be called after __ptr_ring_peek returned !NULL */
 static inline void __ptr_ring_discard_one(struct ptr_ring *r)
 {
@@ -261,8 +279,7 @@ static inline void __ptr_ring_discard_one(struct ptr_ring *r)
 	/* Note: we must keep consumer_head valid at all times for __ptr_ring_empty
 	 * to work correctly.
 	 */
-	int consumer_head = r->consumer_head;
-	int head = consumer_head++;
+	int consumer_head = r->consumer_head + 1;
 
 	/* Once we have processed enough entries invalidate them in
 	 * the ring all at once so producer can reuse their space in the ring.
@@ -270,16 +287,9 @@ static inline void __ptr_ring_discard_one(struct ptr_ring *r)
 	 * but helps keep the implementation simple.
 	 */
 	if (unlikely(consumer_head - r->consumer_tail >= r->batch ||
-		     consumer_head >= r->size)) {
-		/* Zero out entries in the reverse order: this way we touch the
-		 * cache line that producer might currently be reading the last;
-		 * producer won't make progress and touch other cache lines
-		 * besides the first one until we write out all entries.
-		 */
-		while (likely(head >= r->consumer_tail))
-			r->queue[head--] = NULL;
-		r->consumer_tail = consumer_head;
-	}
+		     consumer_head >= r->size))
+		__ptr_ring_zero_tail(r, consumer_head);
+
 	if (unlikely(consumer_head >= r->size)) {
 		consumer_head = 0;
 		r->consumer_tail = 0;
@@ -513,7 +523,6 @@ static inline void ptr_ring_unconsume(struct ptr_ring *r, void **batch, int n,
 				      void (*destroy)(void *))
 {
 	unsigned long flags;
-	int head;
 
 	spin_lock_irqsave(&r->consumer_lock, flags);
 	spin_lock(&r->producer_lock);
@@ -525,17 +534,14 @@ static inline void ptr_ring_unconsume(struct ptr_ring *r, void **batch, int n,
 	 * Clean out buffered entries (for simplicity). This way following code
 	 * can test entries for NULL and if not assume they are valid.
 	 */
-	head = r->consumer_head - 1;
-	while (likely(head >= r->consumer_tail))
-		r->queue[head--] = NULL;
-	r->consumer_tail = r->consumer_head;
+	__ptr_ring_zero_tail(r, r->consumer_head);
 
 	/*
 	 * Go over entries in batch, start moving head back and copy entries.
 	 * Stop when we run into previously unconsumed entries.
 	 */
 	while (n) {
-		head = r->consumer_head - 1;
+		int head = r->consumer_head - 1;
 		if (head < 0)
 			head = r->size - 1;
 		if (r->queue[head]) {
-- 
MST


