Return-Path: <linux-kernel+bounces-787223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FD3B3732E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718CC4637DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094DE31A554;
	Tue, 26 Aug 2025 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhZUp++w"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E8F374294
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236844; cv=none; b=OyvcMWAknwz7qCNrDx16zH4M8gXwXgu6bUNI1XQUvofASEd3zEG/E+hWz09mACyXHGJXOSawlsXIFztR2hz4U88EuBslEFTLJdmH+3BH0jlih/VS+L2U/1esKw+ibvICeXweE721gk7bxqk0dgfQdk8yjfo9tYNUwkYbHhmDFs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236844; c=relaxed/simple;
	bh=pnFkkjiQb7RHUiaHaDH2a5S7Nv0DdMBx4OFEHLl460U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEtCQIhgqqcwA1rl1S6pMuSJWYaken7I5sjCIouc30HYI+2ecMMlWyuGQQabuGmvmWpnm2caxR4cMktzo01ug2C9qnHNOHHx25xHVZ7IFlIWTygYuHBpYojGMYJjl/gIKS4b3/IFlKMjVMsUMSu9zib/WX66rVXtx/l05TqBKKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhZUp++w; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-771ff6f117aso786117b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756236841; x=1756841641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhymPbMl1maujeQhGMIXlLhMPhVkZ1BpuEab9k3C4eo=;
        b=lhZUp++wtAPmgwglaE+TEMDABQlF+3NihGsfn0dmAZDOSLsuUVUn2R11P3eJqG+Qj2
         nS3xPAzGlZ6p4TabmqKyO8xEhTPTuG9vE09hEqeariwIBl39XZzA2hnG81eULdYz4jri
         ecsjuuM//UJt7dSYuEG65zzI/IWwRh57YHh1Bh0ON970X23a4WuxcNwjeMLCs8jiH6kW
         MrlXVtthvSi6/H4P4VBe/fPpqpDyPcp/73bwhykjRin8tezSqGPuf1vfZdX7unsdLQV7
         YMgxgvLUNOYgY14LV7NiF8MApjgpurO713Dmd0GChyCUy/6F5IYcUJmFHMDZULkbm8bP
         8zdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756236841; x=1756841641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhymPbMl1maujeQhGMIXlLhMPhVkZ1BpuEab9k3C4eo=;
        b=go1orJOftq6/4kC5Dzo2ZqYYMrwaRuP5w5EBG5jqOFyyt9ronJtPx9QWbqnxjXa/hu
         5E7l10q8G8FSqLGRLNN1McrpFs8PCVnmac5Sm8fyR0tIk9iSucusxGujmfW+zu6yduWu
         WRfyZibX6VvqJkZJkHzZ9/IIrARU77oLOakR9qce6lKHUpz8el8dL+ZW0ScsTdmoq2vv
         h5mKyliFPUcpMmE9KdgwkZxRWTzL1Z2rtYpEU8B3lHEt+2gN1rPo3fyu90Rwm4QExM7T
         b7t1dVcRGNxFhsNdny6hbTETqudRM/FypuivVDZGm2/Se4DHQ9CTtimYAsNnuvJRsK0N
         dYbg==
X-Gm-Message-State: AOJu0YxqzKSYyBizgapDawLD3rVTHz//G29ea3VPHOi63jdZ+6/xcPQp
	2oHYnzaX5q0UnOrAeayrX6tOBw4yoe8OHSnBufIWWyeX5mKe5T7w9BUL
X-Gm-Gg: ASbGnct/B9eo74z06+DwCfvvkUl2WNjdSuj02AQCb8LLJcwlavsVIbQPd1bfYsi0Fkz
	8vu5zFTk0kONI5zrhTSaTOPa9yQ18HJpCJm8G1mhIs8Ihlhmp1UxhWxr0caiM8L1lPUDzAfTbrR
	TbtNpTalP5iAlX04dD6059GvMqNO3XhSlzg05CU/X0HbLKaRnkhxPkYsCO1KOIlzCzLP9au7x1h
	n3GNBQSvO8jl0xDTpoF3AWv6UL6RkqQoZERiAV8+XCQvxhIkxzHFhAhKZvWxTRIKAUsK31kytLj
	Ne/TXjLP8iPRgnO4Hfx9aVC2xUqPQCrVnCNe8TrGoRhxQSlOwD+lbcxLW0s7KXMHQXYHDlrPm23
	3RYX5jR14cqlq7Adm4P85sb9wFJm9wWmhOyjC+ihwUbJl+Plh7Wc2zQ==
X-Google-Smtp-Source: AGHT+IFCoX76El2Mf5sfrILAjK6lmue1KJd0eRu5drBUMEuKmWziund+YR4+bkdXsg+VCXD6lKKhgw==
X-Received: by 2002:a05:6a00:1a89:b0:770:5683:cc56 with SMTP id d2e1a72fcca58-7705683cd6amr10201780b3a.26.1756236841011;
        Tue, 26 Aug 2025 12:34:01 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7705647e03esm8054053b3a.59.2025.08.26.12.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 12:34:00 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 5/7] powerpc: Stop calling page_address() in free_pages()
Date: Tue, 26 Aug 2025 12:32:56 -0700
Message-ID: <20250826193258.902608-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826193258.902608-1-vishal.moola@gmail.com>
References: <20250826193258.902608-1-vishal.moola@gmail.com>
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


