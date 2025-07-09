Return-Path: <linux-kernel+bounces-724385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EE9AFF1F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFF548828B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5E4242D60;
	Wed,  9 Jul 2025 19:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ47zJeM"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4D58479
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752090121; cv=none; b=hQ83Wu8wwElt1XFoJtGN25LWLZfv2kOWDLEVUNMegf6NNM4/0019G0P3JMFC4QoqXbPq04UdRqfaAO2mtaRrg3tV4iqKj8j/pzChzwAcxlIVd9UiM0dr2BrKQ7E8Z/B5vTraDL/DrCGW+JlUx1vZTo1zUQOg+5ESEuIFBDi3XDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752090121; c=relaxed/simple;
	bh=xYw0+8boV3WV5JzR3QFklqxSWXkCSjbIcRVNHoLu+Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YODnMUj9tQeDt5oFPkuy/9DPUGQ17UUYJ43YKUmN1GS95cv8baOGOgt7NhPb/pIpBIpj8e4nrqUoG5Y/dLAcrraYzjUO5jbifFrhp07r9Ih+D2izsRS4igjc5cAYjuFqij7KkQ0jONx4XE2kl1TwpqnbDtHDf9GLZy8hKEXTOH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZ47zJeM; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73972a54919so237339b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752090119; x=1752694919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gy/B6NBPKcfzCKxE9wxmvXo8e2xXoh7qBVxAdi5Pbww=;
        b=bZ47zJeMD5AB+oWaSrHeQ398XyNt4HzOY/o5hAAHaJeeqxQSVUWyR0EfN/CKThSBMz
         8+Yv4z6Vk7fY1IebVx84YIEzOkbn6GszPA59RFI4RwkCoRTXX1UG12JGRZv7Yitq0ztP
         3R6QpOaJj7OPD4SagD/uMnXcVBWfNlHGAP8ofRBiEnAUIzuPS6vnyaHjqPVjMD2nupVs
         4WnlUTEWrtsPCSOb8fmvK49jGqzvjgq3CGYt+U2tem12GxqDMbj8i9qnEA4MgdUmyach
         uPhGCit3YtEsRSzpdlYQRtIJH/M16ESZ1XjIKiSTN/GIcXuaSr7rv0S1PYAcGk0GwSUo
         Qnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752090119; x=1752694919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gy/B6NBPKcfzCKxE9wxmvXo8e2xXoh7qBVxAdi5Pbww=;
        b=IJkt+JYCiYIak3JObjqqjq6bVkA50PtIL/Kk9RW9Azt6ro6AU+dJhj9qkftelnEz8P
         BDptlZw52ScspdiIxaCNMo+TRv0OUhPqNYp93lsVH/hOVnxttW+JWSBtYTW0m4yc21+K
         ulgCVZHJh+m3KTq1Glm3iqa3xHCtXfT9fybnFtn5DXGFU/C3v4P5sqiqONySY56dqLMd
         IqOETaxGWPpYpr3GwjQFC9v6XFo1w+bJmSNop+Uvjldh0z4ewDuWLEaYBVCOmZWwxJ52
         iNaJlRZ9HOyb05VuoSJoLnxlizij51vxmVZ1yh2AgwlupLw7yyFTDBuV26YGGD4R15RI
         5uHQ==
X-Gm-Message-State: AOJu0YzaPTIR0fbg51uMI0uVhzrSm9Pm1Yb10bg7/59ljMEq9aoUFig5
	2cI+fVyzW7fJSTL1vt0fJTB9HGJAs0jaaPJjVCDEELaB5Y/CD9iY/l4Q
X-Gm-Gg: ASbGncsTb7Nxngox4iJ3X+21grZ1ujEy4AuYxCjtGB+V28MUW+EtRy/sJsTuDOmx8+O
	4xDEh6A1Ovsaha0mhD1ovPj+AYqVF3pWuq6blcNZ7NyCQVl0vhqDi1geHBb38u7sJAQhTOo7pyu
	pnSgnnxdShvA2/wc66YaM4mD8xr2DM4EZ5SVfx6TxyPpdNckY49S8amD+HTikBC+O5Dr+8iWq8j
	ccyk0mbMnXr9d6Em60xY8xZ9eoHMr+PpajCOnhbyfKZogG01MDS3CtCaT4yy3sU41sMBfheust6
	mHj1Wlilrid2qm4OoC3K0DWDUbqX0Ie1/OKUIpzt4OLHY5t5IpMZvUj1ZgIKhGUGlAvonaBcWXH
	PDIoOUXPoS0q8zfLiHw==
X-Google-Smtp-Source: AGHT+IF+J4xzNAoS8abJB7D0umcVwdnDgRDSKj8bf2i/kI9j1SnCLea7ih81myDJ10f06HtlDzJ57A==
X-Received: by 2002:a05:6a21:38c:b0:220:7cd5:e803 with SMTP id adf61e73a8af0-22cd719e18fmr7175946637.21.1752090119354;
        Wed, 09 Jul 2025 12:41:59 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b38ee4794f4sm15169458a12.25.2025.07.09.12.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:41:58 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Jordan Rome <linux@jordanrome.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 1/3] mm/memory.c: Use folios in __copy_remote_vm_str()
Date: Wed,  9 Jul 2025 12:40:16 -0700
Message-ID: <20250709194017.927978-4-vishal.moola@gmail.com>
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

Use kmap_local_folio() instead of kmap_local_page().
Replaces 2 calls to compound_head() from unmap_and_put_page() with one.

This prepares us for the removal of unmap_and_put_page().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/memory.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 1174f3001307..d63f0d5abcc9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6815,6 +6815,7 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
 	while (len) {
 		int bytes, offset, retval;
 		void *maddr;
+		struct folio *folio;
 		struct page *page;
 		struct vm_area_struct *vma = NULL;
 
@@ -6830,17 +6831,18 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
 			goto out;
 		}
 
+		folio = page_folio(page);
 		bytes = len;
 		offset = addr & (PAGE_SIZE - 1);
 		if (bytes > PAGE_SIZE - offset)
 			bytes = PAGE_SIZE - offset;
 
-		maddr = kmap_local_page(page);
+		maddr = kmap_local_folio(folio, folio_page_idx(folio, page) * PAGE_SIZE);
 		retval = strscpy(buf, maddr + offset, bytes);
 		if (retval >= 0) {
 			/* Found the end of the string */
 			buf += retval;
-			unmap_and_put_page(page, maddr);
+			folio_release_kmap(folio, maddr);
 			break;
 		}
 
@@ -6858,7 +6860,7 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
 		}
 		len -= bytes;
 
-		unmap_and_put_page(page, maddr);
+		folio_release_kmap(folio, maddr);
 	}
 
 out:
-- 
2.50.0


