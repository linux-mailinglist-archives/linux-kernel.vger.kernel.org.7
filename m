Return-Path: <linux-kernel+bounces-787289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8018B3741A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A61688392
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D113164B3;
	Tue, 26 Aug 2025 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6Hdri7B"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428392F7468
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 20:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756241794; cv=none; b=bh/IQI9aVlZOzKFq8M9nZmIoFzxZg7QDphaYRnChvP+m4UHiN1KK2wKE5mO0Myl64QgRNN+TcsE1BaqPo7A4FSiOgjr3ygM9A8RVNG4HeV74GObDSP6I4wmrF+Fk5IgNxfRTaXbJQDMX2a491vKHe4qCawDW0sDTVAVMHLpQj5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756241794; c=relaxed/simple;
	bh=hMxsFCbfS4FNJ5KpQPQ814MUfYn5DLMes7LkACjORbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZH0dGmW3JE47iZQpVKtS0Os8GCGESG+KDaVSol9P280pO1eN5hfMl+n3VP17/i9SFiPgcjqd/ILdongFhPYWBIO+tI5ZhLuaA2bY+gYxO68tIK1matevHPHDgD3VDskfX54zLNWgZHmu9vB7PCviy9PZITfkhcV8qaBZfJfvTsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6Hdri7B; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e434a0118so7084283b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756241792; x=1756846592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tE4h8lAMatl8zOgx47ZsHYZprqFSGIay3bVnFsp5zpE=;
        b=H6Hdri7B9nt9poRXEIAJgsb7/fDLImstBpVxp0c031FYVFkJCHjDpF0eXR4Pf1sTT4
         CkZeW+kpA3v0X4F5k3360D/nWK5R3L+mmtDsldtwUQ1ofMaeBAB5+qs0IRV0qwOgdbvI
         Wf4jWjZpXp2pU+JEtb94aeXG2xiAuUF7ZzutpMAFy/GjsDO3/YyUjEFWl3Y0BRSC5Xk2
         xXiq6qFBTN8QulMjzhMdLfqgBBVv245E2MrNZS4Bvqt0+aN9W1T2dIAN7p/xtQME2N9C
         R+Ls2fa+Dfddv4OrGSobfmlVOs9LhXGvIXkzUe57SzOG8/5+OxrlpzPfgVluZU6Dxqty
         U2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756241792; x=1756846592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tE4h8lAMatl8zOgx47ZsHYZprqFSGIay3bVnFsp5zpE=;
        b=FvGz+t5aKNEZqhbDXdD9undK/gzjIqwyAfKGOduRLfehjeDmJ63DY36GChgNfcH9tf
         K2jcgz98Qk9C3lUd9h87Ix7PfiBQyFp5XxTiZOIp+16jI4GPM9LxnxzfQge1wa5y8Ln5
         TFfIyDDTd2rxMz0QAeI+/NXuAe0vPbCU+O9ZwP8koaN+kj9BcwsOclrdbsVcrrc0fcUK
         7iXit0OepsM0v1j4aC7Y4ThsIXO7bhgRoQPyRFU5ycfC1olkNWgU039ktiyf4IResz6+
         x0fkWJ9gJwoQi/8QLulTXpPHZ5dyliRDg6UBf8FH+7gx5O3IEDEP1jgkEC/0PvBD9rVo
         Ejjw==
X-Gm-Message-State: AOJu0YxqqMF2qwOL6Rir16Y9YzYTyrb+efahLwJdLrQsAlONAKJi5Whf
	8noBguIqLuQCdIuSUWMr3ldlUCz/nvah1PyjPp31aLPgQwlOx836B1Uv
X-Gm-Gg: ASbGncv0WGGEhJWLo79SYr3LwIAzeO0Bc0EdXSIjqN3N6Nk5kr2BgcdBWA6ExuxNrZc
	Eo/7RPBAro4JbKiF/w43ydEpxCcWihnAmn2SzmIc3MBQs6BeHC14luFCNDJ+2lpT+927icgT/RF
	NMP0A2QjRFFU36+UTPkuNTCH/GjviYKaBLMEQ7BdQVEm2ZXyEnVeLQzpOuQhv1bddHdGLlnX1yI
	+z4CN/g3EX1yEerHbjry7OUlOS+5FZg+eoGj1brbQvBuyYpHT/x+rDzs2RSu7DrcQvrDURn2rw/
	DLnxTkxwFWRkDQ0YrZHUy0iLlbRTj0hk1KQ8+sClex3FCqeTLgkKquQoNGFWkvTtYuxfQpm54Xj
	LZtoM7AvWoAyJFNmuJiQx79KfRlkZHxBe2BKJs+5Nyn1QYf6hvXuWJg==
X-Google-Smtp-Source: AGHT+IE/cTRK/9DLrD6W7x7VSwKVtmRq+MEUMw7J+ZbQGu720fz9Ao2X05nVX2flS6X87Ne4tC/Vag==
X-Received: by 2002:a05:6a00:10d2:b0:76e:386d:94c5 with SMTP id d2e1a72fcca58-7702f9df076mr17387498b3a.5.1756241792456;
        Tue, 26 Aug 2025 13:56:32 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-771e814cbccsm5817935b3a.35.2025.08.26.13.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 13:56:32 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v2 4/7] riscv: Stop calling page_address() in free_pages()
Date: Tue, 26 Aug 2025 13:56:14 -0700
Message-ID: <20250826205617.1032945-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826205617.1032945-1-vishal.moola@gmail.com>
References: <20250826205617.1032945-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_pages() should be used when we only have a virtual address. We
should call __free_pages() directly on our page instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/riscv/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 15683ae13fa5..1056c11d3251 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1624,7 +1624,7 @@ static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
 	if (PageReserved(page))
 		free_reserved_page(page);
 	else
-		free_pages((unsigned long)page_address(page), 0);
+		__free_pages(page, 0);
 	p4d_clear(p4d);
 }
 
@@ -1646,7 +1646,7 @@ static void __meminit free_vmemmap_storage(struct page *page, size_t size,
 		return;
 	}
 
-	free_pages((unsigned long)page_address(page), order);
+	__free_pages(page, order);
 }
 
 static void __meminit remove_pte_mapping(pte_t *pte_base, unsigned long addr, unsigned long end,
-- 
2.51.0


