Return-Path: <linux-kernel+bounces-787290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DFDB3741E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3721BA5758
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A47350D44;
	Tue, 26 Aug 2025 20:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSG8NVPE"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D1D2F9C32
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756241795; cv=none; b=g+rCbDDsuc49JnMWA9+vlasFuaJnjTmbC5u5iiLjqSpte46/8UG+01pxsm0XcjPKR9tcs3jFBQdatXSlzwetFwZA3nk9gC4RkC1jid++C+yA2pA92cduQ1FWM18rbzu5/g313gqJ+dcz6lJ/y7idgBnC+oPr4n0lxL6sTqD/muA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756241795; c=relaxed/simple;
	bh=pnFkkjiQb7RHUiaHaDH2a5S7Nv0DdMBx4OFEHLl460U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGwT0CEXRLRkHLlTVliJptAs/QR+uj0thLUP3Ftf+68+6fB8hsc5EO1tkTqmdb5HLpAz0Trs7cB/fb2QuiW+/f+sBNXymbB4JW7ySlgIpJfvL4QDp3zxwfVRINC+eP8K4t6ITJwjyEFLIC0JNarOXcCtmJ3kxiIS7UPIK4xqGpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSG8NVPE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-771eecebb09so2566846b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756241793; x=1756846593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhymPbMl1maujeQhGMIXlLhMPhVkZ1BpuEab9k3C4eo=;
        b=dSG8NVPEIn9t1GrlZosoSMuhd3bIgve0m4qvz5aVF2dFK3l9FWfdQc6McqXfBP30WA
         rCp3Gn03HMudj5D6zHqYTjaFEnafJyK0UiOaoM3OBxGUnQ7LsWWDeC6xMfPTlcH+HpSm
         ISiFfvKhen518dXK6vwGVLBcJU2m9b287eyRPFgIFoSu7dPtHbG9Q1iRAWyh1UFpFmrJ
         33tHQR1F7lVM7nN7hr/5lx7bQRTxlWok9XzER7khJDIu+niZ1JKZi10voH4Sa4LGqWDi
         voDPVYXdof8SWKNPzE1Ihp0UItpJDsId48fQocW0mnpQY5cXZ/xgfmC6Z//o01HW6/O0
         GzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756241793; x=1756846593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhymPbMl1maujeQhGMIXlLhMPhVkZ1BpuEab9k3C4eo=;
        b=wG3W9qUqkB6rjnweJ1c8gpGDa4aJJSZTi4T/t+bykq+bVhzkA5nwBaCTq7ZZ2dYL+k
         Xy3tqptnB2BOd7toX2LjiHzjgRoPcGkWFlbFA/EX91F94WMW5K7QRyVVBrwDPG7vp4zP
         V/dfxjyW3JMy/4vfq9C6ivDm67pGMRpofjsM3mBUVpMtfeRWeRJ2BXW4Sh7Iu4kk9G2a
         2QzoQ6VcSM8yi99DDOg7es4IdYj1JLwaXrmSzO6cobYK1YPIdFfN6FkLGijWPNzpj4Q3
         geiRtGo9HLn0AbuDJe4yPf7LCn9mmRMz/NejP/XawCD5AX7mHXmu4EUePtGhLg+N444C
         KclA==
X-Gm-Message-State: AOJu0YwJo/LgxM1HOvpZZuriYqt0zA9nXL0DNBbAD9Z51l+NtA4VZbkY
	vY+gT/rmznEiKDL4rR8Kspp4yZ7ORS908bOKm/anG36n5eVljl8p0/GG
X-Gm-Gg: ASbGncvwYXCENgzBEUKk05OnslVqkMm3gu96iMgW/xgA32wP/VPeJYSVjkE79Mi/h/B
	16iiIKyLD1wumNtAVP2C2EDDZf74n7CjhziNMenqcl4ZVqXCf3a5l05YGxUoLKqeqZ9TaKGAlHL
	/DQcu8fVQkM4JfpdYyLJHFzG1uw4B2x5QRQ3E16tlqW9Md/xrxaw5iZ222pxFizkv0OvG60W6HU
	taAjpE5d/wG1K45QcizkUHYfPH9qrdB8m0XkByS952veSg3wXKFi41my3vASeJ8ELJUMbeGSI1H
	iRf1l58cXtAMPApJRuPv76Ndl9ZcbWhhf6R6XXBFEuffVYSah505gI3PgvBCSOjz2weYwT3bSNH
	pXQ5Tmki20fIdNqQJfyI0qWsVOgAKWNKLqgNQaOajHHZ5Spdxvir8dHzLjjY5aqoU
X-Google-Smtp-Source: AGHT+IHyoITETX3mMO6OFZ+cbZSRTX/76LzPMEuMpyUTUsY4GlXP9qWB1WRt/5lzMarXBlKb/H7nPQ==
X-Received: by 2002:a05:6a00:2441:b0:771:ead8:dcdb with SMTP id d2e1a72fcca58-771ead8f33amr9122485b3a.8.1756241793611;
        Tue, 26 Aug 2025 13:56:33 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-771e814cbccsm5817935b3a.35.2025.08.26.13.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 13:56:33 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 5/7] powerpc: Stop calling page_address() in free_pages()
Date: Tue, 26 Aug 2025 13:56:15 -0700
Message-ID: <20250826205617.1032945-6-vishal.moola@gmail.com>
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
 arch/powerpc/mm/book3s64/radix_pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index be523e5fe9c5..73977dbabcf2 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -780,7 +780,7 @@ static void __meminit free_vmemmap_pages(struct page *page,
 		while (nr_pages--)
 			free_reserved_page(page++);
 	} else
-		free_pages((unsigned long)page_address(page), order);
+		__free_pages(page, order);
 }
 
 static void __meminit remove_pte_table(pte_t *pte_start, unsigned long addr,
-- 
2.51.0


