Return-Path: <linux-kernel+bounces-897969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D57C540A3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D35B3460D2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7C634DB59;
	Wed, 12 Nov 2025 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWjUaMe2"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B534CFBA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973928; cv=none; b=Wt29En8xhKv2m3WNLViZFIKKlX00/WbM04VgFun6Y4MPvYDMdrhorW66bLb+O+2HUexZqqwiRXlUrx4/S74Pq64J1xfXx+QEW7UjHQzwTd08NX1edU6XGV4+aNzLegxeBEAL81HQI7NqSWVuYlwc/P3mpUMFhp3/vnlJqQpVvGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973928; c=relaxed/simple;
	bh=qsNdbwfqE6guWk73y8bMN7Nv80rnoFe+JZvWLXyQBdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0H5mILAspBp2gD9Qi/yZUhNzHgs01DH/UEqeZhecq1ztVi0mvsr16pm6BJulljMcL3pPRo4JEdZia9TxtPkKI67FXsMzkNf0gss4I7art6Q+LdrJB5sId3nnTmP0Oz6dMsbPcfEAFcoODN+7n+FlM6KFwdO1Xu4V7HxBAylFDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWjUaMe2; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-343d49b7227so1437436a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762973926; x=1763578726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3WsKjgbP+KqyauiXgVNPCy7vp9KyRxhPHjuMUUOEgo=;
        b=iWjUaMe2L2h1IY1l1pCs3BsNJZvQmefuL5Q+VEO9w0OrtMtbf42W8fQZePqxQLWjo6
         h5/lRzo/Axbif78RF3EOXko20luQAH93nkn890X1brI9cqzqKIC8qOZn5EEL8AU0pvXH
         /Ftc3vX6X3W7uQX3TJy0gJQawjsjsBqvZB8xlleOKu4N0sBtNHBAUGmDsyPQYA1eyrP6
         gnZxPxWSAn4m19CEzZYjSwns7LfefEDGYK3O94bt1ACwGR7HNT5uePRrdqk/hT9U1LwX
         d45SZGwgmybByMqJL3H0e1QV5I/yvUJhYH9JlfkdUkaZxYry24Zu1093GvMzLOC/gxIW
         2ClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762973926; x=1763578726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z3WsKjgbP+KqyauiXgVNPCy7vp9KyRxhPHjuMUUOEgo=;
        b=b8EQDI3fZFF1eXb/JjoFx4v5HYfy7zkvm2RsDvn5PPHxgRxasi/i12MuAz93MRUYA6
         7VNvgHBaaUD3Xn234eoKL1+LbMIqJ8BQriAyXcLyCjmnyuDpRc4wPDVj+lowWLuBd0cH
         gStb5lJeiFMEapPAS+PlMIkfoyMsGDhQA8MEywEYLXDwN06EmGuOWMbgjpZVdb3ddzDh
         V/g+Cb9luVarPSUgpB6z8tBVZDjZD/P9jSO76xBEC+9XcqLPhT1hJGbgM3s6m/ludm6Z
         c0qOO8sePpnkGdojVq7CefK8IoUQ/UKWoYLIflwvBAdJuO6kIpQy3Mh83SOX1EztYC+f
         /g1A==
X-Forwarded-Encrypted: i=1; AJvYcCWe3KKVwRAEjnCguU8gRJrF644gz1BH7fMUY71gxnDWSzYHCC9wnrmQPLmuwgyflMwClGV3LwHbiq7w4ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Ak5gPbsKvth2o8PL/uLVsumLBVzAyeUe5kLUbzJyV8CoLNfW
	kuyd67LhkMAKYj8Raxt333CUOuNiKJ6dIhWA0KVAp4wuG91qqmSmhNSy
X-Gm-Gg: ASbGncunMjuNKa7PehLMI6tWMY/8ECdP88KRJrVYBZnlGHr5ymsSMBU9Dtb/xbX+MeE
	BlFesuEsCqiUFGcEYq6koDXxbXVDt8QYUah6XKsZfgzHnKGL3iKFAm/fhi2S+4z+Mlch5VqUKom
	T8eMqBDaNJrWqAWf78yoRFEsR1lwp43cg5DoP/Bz5kUzHJtiYXVra4/lyPLzEd0AJsRBTJKfqDo
	PI+kMAZqFtqsctIQOJzHTLPNYLPRnp8PziI5IpmQyRFSX6OQ+uevf1sU7Wwx+GWtTF8geEbK63M
	tgZu1r4UO47dRO1u1tw4lhverjLAtwa4PKbmkwC7UWlBA7OnUMN4q4T9FiYVrPcztRpmYw8unEI
	lRpKdtoDGPKTAeu0KCmGTVHjl3HumcsGbmCK04G19RsIZn4GFlN/nV4O0EfOYBy1vow8y+g559V
	E3y61Vj8XQGVo/YKUh/G3LB1w+kxoQ+/tL
X-Google-Smtp-Source: AGHT+IEx8zgd76NJsV1NswRAalmGvg4jw92jAb5hKFRpnzCjVrgOWDoh6LdvYOwY3ymtnsLGhg2L3w==
X-Received: by 2002:a17:90b:4b12:b0:33b:6650:57c3 with SMTP id 98e67ed59e1d1-343ddec59b1mr4825254a91.21.1762973925965;
        Wed, 12 Nov 2025 10:58:45 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-343e06fe521sm3491565a91.1.2025.11.12.10.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 10:58:45 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 3/4] mm/vmalloc: cleanup large_gfp in vm_area_alloc_pages()
Date: Wed, 12 Nov 2025 10:58:32 -0800
Message-ID: <20251112185834.32487-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112185834.32487-1-vishal.moola@gmail.com>
References: <20251112185834.32487-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have already checked for unsupported flags, we can use the
helper function to set the necessary gfp flags for the large order
allocation optimization.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/vmalloc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c0876ccf3447..6a3ee36d77c5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3634,10 +3634,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	unsigned int max_attempt_order = MAX_PAGE_ORDER;
 	struct page *page;
 	int i;
-	gfp_t large_gfp = (gfp &
-		~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL | __GFP_COMP))
-		| __GFP_NOWARN;
 	unsigned int large_order = ilog2(nr_remaining);
+	gfp_t large_gfp = vmalloc_gfp_adjust(gfp, large_order) & ~__GFP_DIRECT_RECLAIM;
 
 	large_order = min(max_attempt_order, large_order);
 
-- 
2.51.1


