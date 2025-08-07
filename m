Return-Path: <linux-kernel+bounces-759240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D2DB1DACF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73AB7E143D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F84626CE31;
	Thu,  7 Aug 2025 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vn3fKLPR"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90A826CE21
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754580473; cv=none; b=X9Yq3hPSs0WUNrYfjgkoMFpZjC8dJCjZFcfz6P1Lfd+kZzQQcrnWna60xiz0+n5vNrp8lCckwwSKTiHHDZOgXf19JznH5R4RBMs3hXYm5nFLWFLTuYVWcybM53gE/DIVzk5rWBELsKUW22GvVaW25Sj+tW9IH5WJUTL9ljUFdms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754580473; c=relaxed/simple;
	bh=zIfKdNQEjciKQheNSJbyteKBoqestP8UHxIeZa4T0Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCZFLfwzEVwuzuKgp1OulPLxKfn9lfGYTzXabeur0lOyChmiq6zpad7neU6bc+t7RLXtkMCINRHPLmtRmEAlciewHv4btpHR3shkgvzm8TybMJl4kuC4dEbFKXQgTxgSVVe3y3SkwrvOYkJTg20KGTJjZ4kR+6ZMEWTH2VEaOxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vn3fKLPR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76bd9d723bfso1070288b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 08:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754580471; x=1755185271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y9fWWBXBlNjUcVIevwpnMzei9v9cyPF2woT3bX1UmP0=;
        b=Vn3fKLPRhcoLL7NDDYaTs4bYeCp7YM8FgWnM+T8dw46rGa3d4maE2cX6/mTABw/BWH
         wvZANnYJqs+Bprmgi/RgmOJrfVbk7epuN8vIg1Vj5iZB9hW1srJKH5/wl6OgMBEtRpuW
         cMvSgOM9MankReo8OhMyymAXrM/zS+58AcMbEb+l4qHd5YA0a9ooTmkbTawOEMjphfG7
         o14RLb2gID3aKUX39F+Q8unTgZvCzFSB0O4Y7xfhRsKD7MDHRJpI2Y7aShgtscsg26ST
         CrTT/bnk2kNS1WUymBP/7isleRe6x/kBbL1zZNGBx+9QZYC7re/A9My7cruaTHb0avOj
         D0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754580471; x=1755185271;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y9fWWBXBlNjUcVIevwpnMzei9v9cyPF2woT3bX1UmP0=;
        b=Tk9P0oLVCVQRgO7LsYvqHRNaM/aMNHfsajypBYKWcf1+c81e+s4omMgIUJivsUPay9
         Q7y2WgByORKY5kp3Y7iSSD47JrfX9C0Pogu0yYKVjhpJjFwBk1+bD/LiOUCo5ZAZwyqk
         CUX8W6Ajl8D8zf5fM8NWr/KTopbG97tpBx4mqJI/k9P58jn09y8gC/aMtkMQa17KNVjZ
         AWwSqptxPmf7rk0B4dWUceqD8O4U34cZasBYLf0PIiXHi5d6hF3UKjyCwIOdoNXfLbk6
         +kZchtqJQqbRWQepw1XTOYE6QlrT+yxCy+YQy0tAEDAvrKadmovxaULxjPApELJVN4UN
         L2mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXec5JzJgIAgWONzyNjczJGoaKieWimqVS4vD9vcZpRcPTsi+w1uJVPnaRBUnADR1aDuC3MD5oq+Rycy7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKwyWCWFsd5EXooPPQq4PHM2I03jNx+jyoUCXIBZEEhabK7OgI
	RU+9VzycGnEVWs5+t68n5nz2gjE5KiWQoziEasnfEsfZSUcVsK04qy6x
X-Gm-Gg: ASbGnctWWyCxTjllL9jvfXPcdkxB+w1qhtHuhRFcV3xi6zl/SB96u8Gpdb3uPLOymr3
	QCq/8gT8DbdK5BxKepsrDIvR8kBuAKMZDsoAib3RDmqrzGnGmK5SG2YqW2Ipf0tLPLYtQQNFWYi
	bcESC/8x2PdpzVw+96WlRR3svkJFWKt5GLwx8RWWyXO9Dnh/+Bu8pagRBRWdDsKcN4rSOORK2Fd
	7rJ6VNwkMkCa0Bvwdq10mnOrQxoNvLfEPR8OuB2ueAXGYs+w4feghQvuh48x4s075GpxLIBIE3Q
	So5FukM1jxAY5X6oyAPph0+lGfhXUDEV7KcxNiDtjE31E1Oxr1/YMn4XvE2LZ+CJrpULJu784g1
	wCiFukb6tMUlJh8o+BkudTToukgzouHPRkQh/4Q==
X-Google-Smtp-Source: AGHT+IFg/IpKtoHQfbVW4m9sQKEKh4HvSlaXW/D9l5o9aVDbN1SGN/f6aejupBVl7miZ3sFekXHHKQ==
X-Received: by 2002:a05:6a20:72a0:b0:23f:f99d:465e with SMTP id adf61e73a8af0-2403144953bmr11066684637.16.1754580471197;
        Thu, 07 Aug 2025 08:27:51 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f319sm18430540b3a.18.2025.08.07.08.27.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Aug 2025 08:27:50 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH 3/3] mm/mincore: avoid touching the PTL
Date: Thu,  7 Aug 2025 23:27:20 +0800
Message-ID: <20250807152720.62032-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807152720.62032-1-ryncsn@gmail.com>
References: <20250807152720.62032-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

mincore only interested in the existence of a page, which is a
changing state by nature, locking and making it stable is not needed.
And now neither mincore_page or mincore_swap requires PTL, this PTL
locking can be dropped.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/mincore.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mincore.c b/mm/mincore.c
index 1ac53acac239..cc4460aba1f9 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -153,13 +153,13 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		goto out;
 	}
 
-	ptep = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
+	ptep = pte_offset_map(pmd, addr);
 	if (!ptep) {
 		walk->action = ACTION_AGAIN;
 		return 0;
 	}
 	for (; addr != end; ptep += step, addr += step * PAGE_SIZE) {
-		pte_t pte = ptep_get(ptep);
+		pte_t pte = ptep_get_lockless(ptep);
 
 		step = 1;
 		/* We need to do cache lookup too for pte markers */
@@ -192,7 +192,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		}
 		vec += step;
 	}
-	pte_unmap_unlock(ptep - 1, ptl);
+	pte_unmap(ptep - 1);
 out:
 	walk->private += nr;
 	cond_resched();
-- 
2.50.1


