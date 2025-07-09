Return-Path: <linux-kernel+bounces-724387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC63EAFF1F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6A617D708
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E046C24467D;
	Wed,  9 Jul 2025 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+hsC1WS"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0500D238D57
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752090124; cv=none; b=moomnGNGMd9R5a8rAxpfqTpSeomHcpKjxzATGypes87HaHXoivsHk1EFbmmYjKdYGsSsogOUwHtjp6eymMTGMMU7Y2DjBkGnt8tA5iiaZsdC8/WAlwb0TlRTpLw1S9D9wCETIm1V54tCoFkjWqnNKF9AsFCAb31X2v5K3e9eKIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752090124; c=relaxed/simple;
	bh=ylFQOjDJy2VIX2Et9x2ybTu139vD3iPRQgrZBCQDrpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5GD1+XZr5LAGjNpX0LiXMYFJzk7mLWat9navEOZssldehKK1UHOnqmmpeJrN4F4B9tT60CTNaMm/HgWGfwM9DAB5M8+sGlEXFXZi6sYd5BquKLme21UKwKT0DyC+tEGeItOKLOGaliCmzDYl2hThIJjb9+krBlty3riHK5LqdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+hsC1WS; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-748f5a4a423so188822b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752090122; x=1752694922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDsLE6E19Td298KPd6Qq63sYGmIzE53+0WIbG+4OKpc=;
        b=O+hsC1WSUYfh/JQ5n05R+XGg2bHacocFoIXAcvAbGJHVHrLjdEXrxsSlfIPUR/mR4i
         Ks3B/Cc4b6Nh8BIbRjjtShouSlRvBTLAIsT6/B31KzPV1Y7C601glda5QhpES0YW2p8+
         j9nSSa1t1IAqenVGh09c6DWQ8770OZACUSsywPSv30RPifLHsa0BfajEl3t4omxZzH4v
         nCFyHAZA7h90man6XoWMC5vKfxkkO9kWHMKstEA1advXWkA6uqjaUpVHqoivAPDvbKAn
         E7r7LJWxMXviTvjviurUC69vsCwS2EFCETo+nKdit2fTj0fTI903beqlDd4CJElxyuQm
         g0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752090122; x=1752694922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDsLE6E19Td298KPd6Qq63sYGmIzE53+0WIbG+4OKpc=;
        b=QSLlZ/KB6HO/126gUlJk5BRxR3K2TO3DzLujVr+A4Uc0FKciUPNFzUF8n1GyxmbFO5
         Qxhd42G6WyQaeFyv4Hd+f9O3Zms/fOrvuIMKg+wrdMG8I7oKxrCqrKnERDnjqB8qadkd
         s+1MSRlFd3BcEwwPKf20NjaBFwAXOIL79pQ6PWm6acwwCsCA+H7E5xHP78VYpPoJ+14q
         mO5kmRQln4g1mmKnBmNGdosD5nkPE0iUYiOO8zgLkkfd5mxJH8gC/+NJGqntcgvhlAsD
         trm9aM+dEGPXS6dtSwXM1ZcmxguQ0mYYwdr8F2gentvtVHkE8EBg5kUQcL6FmnQcfO8Z
         x2qg==
X-Gm-Message-State: AOJu0YxFtIt0i82J014I0Wm+QBDUrR9HPrWEi3xMynBf/oPv2USWcJT0
	55SvME6B/5Eif5QvrjFaDrWYGjoeM/GyGvA3GCPlW+DneXCsS9ZlJ6qH
X-Gm-Gg: ASbGncuemUQ5cQy9A3r38PJtwgpLq7NcgZwE6gvRp+kEvQR0Uc+3MP0vTkCOqZ4LDpZ
	41cyTMRcLXgJvChLab3A3lOmlhnnI/1KvwJLg1CwcqoWK/FE3mEzQjnDN6TlxnN2uMoPmcoUUJw
	H98rH1cNRc6GtFwP6M9BSnO9//Od6S4CEOEZ5/lEEtM/wICser0uWOG6JfYtIxsfj85L9EWzlzl
	Olf/RPGpsEXa+wU9Iw6U2IGylM5on2ZvGTWGkbaOiq19fteZsqMD2E0vtZ+LJK12PXTk+ySNvLP
	+hBCgjtOmW5P3A6oTf2hOAe2BnQ7Q+luC1AUYsbNnkhclSMm/0WULt+caygnQLAVZyJzO8AFjCj
	Lwyp25/lXxx54mutChA==
X-Google-Smtp-Source: AGHT+IEKkj8AUeRF1Jg/QfPh0coh0wIszbW+smznCaJ6WfXRLyL5Ttheut4QP3l44p5O3BDPR9+Tvg==
X-Received: by 2002:a05:6a20:3945:b0:21a:de8e:44b4 with SMTP id adf61e73a8af0-22cd6cb0db7mr6036132637.16.1752090122184;
        Wed, 09 Jul 2025 12:42:02 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b38ee4794f4sm15169458a12.25.2025.07.09.12.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:42:01 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Jordan Rome <linux@jordanrome.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 3/3] mm: Remove unmap_and_put_page()
Date: Wed,  9 Jul 2025 12:40:18 -0700
Message-ID: <20250709194017.927978-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250709194017.927978-3-vishal.moola@gmail.com>
References: <20250709194017.927978-3-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no callers of unmap_and_put_page() left. Remove it.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/highmem.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index a30526cc53a7..6234f316468c 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -682,10 +682,4 @@ static inline void folio_release_kmap(struct folio *folio, void *addr)
 	kunmap_local(addr);
 	folio_put(folio);
 }
-
-static inline void unmap_and_put_page(struct page *page, void *addr)
-{
-	folio_release_kmap(page_folio(page), addr);
-}
-
 #endif /* _LINUX_HIGHMEM_H */
-- 
2.50.0


