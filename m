Return-Path: <linux-kernel+bounces-878694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CB3C2143C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1C2834DD6E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82C43678B7;
	Thu, 30 Oct 2025 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id3UMZeL"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760C0365D39
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842629; cv=none; b=ozcSwrwDsO8Vrlpt8gtIFeTMWEb7nx3aNkUpRyC/LnzTsQ74vHfz7SFJ8rf2nKIl8DIZORY/Rnci6xgLg7HQnSArUkJb/jCy8z/X8ZAZntjPKw2RKT5tO0NB7V3Jio8BT4cs+k09J2zhgikDHcHJBOT6hT78eS3Rz+RiaSjbW3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842629; c=relaxed/simple;
	bh=5K+zEEtfv5RdDNLJe0O46hz0oCIPix+nPsEnYni4IMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLA5f1dYeTQmzm1NBu1Hul466XsSn86Yh5MA3f1M8uWiiLvByKG8DImzCStYqU/8z+EusJolsuIqguQHUEQWx6vyT8qwM4buLc180hTaTCdj9ZKnYSutaEGTuY2EltQcr18PtCZRv2NfASMojAaaygARxtp4TDhPuukmIE+i/VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=id3UMZeL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so14612045e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761842625; x=1762447425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3yVuDV1mz1n/tGmCVMXJ1/yI+RC84xz3XcNqwP/C3s=;
        b=id3UMZeLNOFeSrUCHBrEbSvR7tbtbi9BTlIGk6B71jzv8WOIw7K40sDbR4Hm1+5oHP
         7bea5uUJ2RqPpDh8gJbGF7OmpvCPW1fQd83QNMmCXq/6uT2ZvQljy3eFl/QEDl5Fyzj5
         ZG1KUtiQvsN4iYFlr0axtXOtGaR2qAXdOEPjpSn7Fv2NIEhuDnXb+WrVzJqD9tZLl9+Q
         2nH9dWmGDKUXUzSMV2rS9K3dLbcazLR/lBhbxv495NuJnwYKhNuyrMqAsbVzflo7kJTw
         2wVrmm4WRF4x7pxesYnK1EpF2rXo79IDq4leyekrvOWlLAYZfEe7BFOcH+3B3nl77mpa
         Q+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842625; x=1762447425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3yVuDV1mz1n/tGmCVMXJ1/yI+RC84xz3XcNqwP/C3s=;
        b=cE+jh4KWrRpE85ubbs7JMcqeH9rXYWo9qrPFY0ccpKJr3QT7fcxJfgDcpacHb9ALKq
         8eRufsVGqB9Y8oyk9xuurMxGesKv/FtoOUI0JO7JfNQeCFuseBcAbS4M1w6lsWxgD1LZ
         WHN2Mmc4SYEyttdx4FgeABQEPb394WKSnMMb3qqkPx4MU1+ZtNWo9eH25n1g0SjSqv+3
         eC2ogS9wi6NtX77WbRUqIpGf2EdM45FYqugaqUSIBCUAEDHJkLw4Utu1GnZlTpLPraoB
         f850KNexY4ckrgvA9hd8+13AbWvyaRl6+pTbQHCr8rSutXM36ACQdWmfDiB6GXXHOf9K
         l8CA==
X-Gm-Message-State: AOJu0Yz0b3GmUue+cXKO6Dxbuv9FtVQMopcvKi7oFtdJHqY0x0OiwFeH
	BkCGhx4xOS/Y60D3xJ5qMdKAfxz9C7AseQAdHXUbSqU7MiHRDiaRNNkpw0Vrp+8m6Ec=
X-Gm-Gg: ASbGncvfPhT2BCV8+BUmJKYJBW6GdaA5YkCsbQznKqIFB1I7L2b8LYsQ0gL7YEqEfvS
	uLhRlIjQhFZceal2KKkkg7bFxuZJGBsuipCnUp+4hdNUwTdw4ZQbAD9DnZtBBFJk22EC28RKF5l
	X4PceZ/UGN1cQElTwcFyI8NWETx5wDVDvSEyR3SETNrv5zZ146+ZCAPXBJUfnc3gKSy42DIFbeX
	/LD0DL6C7YunfewR5FBWOOcU4dZbmT+RwJTGiLbIGilcibc91QGHjUTiMe2JkaP/PwFXwaxVEYt
	sbUfGsYTzUlU5ybZhYnNZ6PdzU0J6H3cu9dEtcWbqYc5thARN95twazsd/RbmPyj7gBc3tMzerv
	iqw+od5JXa8r2AlImLzWzYLFDAnG5VF/RnxUOai1UZXcI+GYTtyG8rW0dER5bcxveoN48Hm/gsk
	n54HW8LvW6eg+EseTkJYn9tRw9M1RXwVYlBZRTMz36Ynb/q29eVOmbZS9UhcCUoQ==
X-Google-Smtp-Source: AGHT+IHNQ45nUcwfK8RnMTd3oZeMqEiqKprwpjCjoEbKxBa+N5gErTpRDrXNo3YuT0kyNcEXTUfb7w==
X-Received: by 2002:a05:6000:24c7:b0:426:f9d3:2feb with SMTP id ffacd0b85a97d-429bcd849bemr498223f8f.23.1761842625164;
        Thu, 30 Oct 2025 09:43:45 -0700 (PDT)
Received: from fedora (cpc92878-cmbg18-2-0-cust539.5-4.cable.virginm.net. [86.16.54.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429952df62dsm36796839f8f.45.2025.10.30.09.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:43:44 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [RFC PATCH 3/4] mm/vmalloc: cleanup large_gfp in vm_area_alloc_pages()
Date: Thu, 30 Oct 2025 09:43:29 -0700
Message-ID: <20251030164330.44995-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251030164330.44995-1-vishal.moola@gmail.com>
References: <20251030164330.44995-1-vishal.moola@gmail.com>
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
index 76c060ef2bf7..8ad0451a7bd7 100644
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


