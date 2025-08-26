Return-Path: <linux-kernel+bounces-787224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24580B37330
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96777C7D79
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896A130CD8F;
	Tue, 26 Aug 2025 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWhVuO0M"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB022F6572
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236846; cv=none; b=k0qxNssgVKmnfYpQ2VqvwwURTsmairssZ51Go+d4KXbvJR/bA4h1/Sc0LxxxMIljUstLySuZUJyBtvAYGHjf0naCD7tGOra9H+N9xFhMmwstgC5VlnrO1MuQHAfFtkz9qiZwrco8E4FC10k9NRg4sSgI9YqXBaQT9pwwslPzemY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236846; c=relaxed/simple;
	bh=EF782+62IHDbVLD3KMl5vNoUe2viHMRQ2eStiiAsIR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrFGsDm+OKgVsS/MT9KPzh//QBcVceo2883wzfEwX3S6TsUXeBEY8jBbUGPrAb+qrXsadP7ETjKbtt53TLw/Ge5LqfbgGqEAOBvoQ0W7HbN0b+SuQqoFrF02qvShBCwh74PMBDAQZ2CeDXMG5WIdo8NpXCq5rx03SvdWZKeuvms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWhVuO0M; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77033293ed8so3912313b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756236842; x=1756841642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzlN+dsEa0DyjaimvacceBZBAxpbehfow7bvljEAvnc=;
        b=JWhVuO0M+xucjGleO6duyqw53sAMNJfDGGRajtTQXj4nddRuIFkxygGRVkINN+Sver
         zz3gpCxwcnFxWOPr83eI2G+mde3xoi38cldghj7s4UmCFhgJXPrzTgAUOxDOauoOW+kg
         wu34EbNVVq3yBdxCMfrm7UJ4L05WQ4RlqPfNpdFGDEnsI5BBO7oC/rKym/xe+Ev1JzzG
         f6aKM9uwV3eAfqB+Zm0j8xs2cB0uKIwizAI3rwWzw3/1IKbIOozjoXnB/js/L7/V79O4
         807BNSasIOLc9eLGwqf8f23jJLXVS8owiGxF3Mz/w1suBYEKoMr/QCPSSYCMjBozpZ3z
         JNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756236842; x=1756841642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzlN+dsEa0DyjaimvacceBZBAxpbehfow7bvljEAvnc=;
        b=cGl1u+8JAsXqrs1b+a5m7ce+411uWsnhT23o+6esDmzpCg5l1+2/rtaXwjUKLIYfum
         iCzjNsZGw8mu4rpMSnvq8wwx4aNSlKu/8poyVzU6P98ko1Va7Efn0y0OvsS+wETIQiEE
         //VqA1DXzCNu24jERVo0Iji2OYuwilHkIfte6IRjZGAyVtWH1FgHkqabqSVPJ0fFIBna
         99AKgZoKrFKXDmEW+GNr37iVdaPMhKtQROWDXf+Am5Esp2yPZ/AR+dideqbiTMAYhOmn
         b666qy4EXWq59x+fWvG4eRMAiyMm2QLSpmz7zp3ilxYJ9z2N+Dh+P0Q5cYw7pDePWJtt
         jg9Q==
X-Gm-Message-State: AOJu0YyW5UeXuxNq6msqjBiKl8YaftJChbXXU6Q8H2jl2CdTFppqHm3H
	rZs5COpIUOKZH6KOhpRnNTYj78r0TLCJZYH0T8FG6Sdu9HIYDSK5JQ2F
X-Gm-Gg: ASbGnct9X+0X8GWNDALstOkqrEW+dpw7JUF3DgYt5OqYoIB/ivBGTmHliXdmY1FruIW
	1zW888cLV3Yb0+AmmGc4Juz3DQp1+Qg8IqoFowTB2b8NjdelBg7R2a4HnKk/XxGvcDVPbvq+y4O
	cCbLkO59x6Wfx/m5pKYh2Bu08uum61kU0GOLbkG/tjehiJjk24QEssFTyyzrd2zf4FJQdA6vSQj
	DdAFsRr1nG4ZtjCM8fKXmZkGOhBayqi3GHxPQOnnDTJlfk01gHCx9uFJxF70BIasDowzNUTFXKS
	8EmNv9AIdH8Chy0UJqr5ADVg/JZDuQH/ru2CeHCw01rpbPWoXA8i19IabBa2tIANePZVPXvagcH
	GAc4qPB4oM38tnVb77vSEPYZZ7vF3NAyin9zmbtYSYOjR2/vBAFU3oQ==
X-Google-Smtp-Source: AGHT+IH4BJZMpmDBwjTODxEVoRjvrj3wIA0wcVLqavVX3GxXvO9+C4C22HXp1pSwIPrS0jFhWI5imA==
X-Received: by 2002:a05:6a00:1954:b0:76e:885a:c344 with SMTP id d2e1a72fcca58-7702fad491bmr17378055b3a.26.1756236842358;
        Tue, 26 Aug 2025 12:34:02 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7705647e03esm8054053b3a.59.2025.08.26.12.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 12:34:01 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 6/7] arm64: Stop calling page_address() in free_pages()
Date: Tue, 26 Aug 2025 12:32:57 -0700
Message-ID: <20250826193258.902608-7-vishal.moola@gmail.com>
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
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 34e5d78af076..e14a75d0dbd3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -843,7 +843,7 @@ static void free_hotplug_page_range(struct page *page, size_t size,
 		vmem_altmap_free(altmap, size >> PAGE_SHIFT);
 	} else {
 		WARN_ON(PageReserved(page));
-		free_pages((unsigned long)page_address(page), get_order(size));
+		__free_pages(page, get_order(size));
 	}
 }
 
-- 
2.51.0


