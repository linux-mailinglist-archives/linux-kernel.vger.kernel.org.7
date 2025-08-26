Return-Path: <linux-kernel+bounces-787291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6ADB3741F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56FD51BA5611
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A523C3728A1;
	Tue, 26 Aug 2025 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrUQP6jh"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEA931A560
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756241797; cv=none; b=JS4HdEfVb2mpM+WrIy3JrGZH6Uqm6rh8PrzAwv73C410X2EyiBJAPu/wSgjciywJwCaVOW+/qpETLgglFX2p5R2sE/uGWANRurV+/lLluraV9c9DtJz+bzE8Ml8vPVq1/ucgKAbTD7tXmnFR/CmbciPKku2JU010745Imb7kmiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756241797; c=relaxed/simple;
	bh=EF782+62IHDbVLD3KMl5vNoUe2viHMRQ2eStiiAsIR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y29wGr8GXR3X/t5gZd4gmss2CTVF3tILp73Ic3Ul/FkeqoPeeZTbRQOfbi0KxkQbiJTTuRYsd03KHJdL32FrSwnTGLtf65H6e7nMXztdLV7c34ad560eJ0DW/VTkwfNOv/aWMBGgpIXGEmYDUEo1dBAOZx4iZUud66S0tJyja14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrUQP6jh; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-771eecebb09so2566868b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756241795; x=1756846595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzlN+dsEa0DyjaimvacceBZBAxpbehfow7bvljEAvnc=;
        b=SrUQP6jhOCQZuLDzFWSHhMPVGwzEIuG8quWnOrOboB7lzywOcQ7o7uqiYaSPVBcnzD
         tkakv14gnvVmNINoX5lkSxY0H2jIIe083wuXK3pOdH3mEj3MzlCJKHaDDMXSDHBgJW4z
         cBfpsFVoTcMasopraoSpnNrQ720RZThjiSKslXjiW2E2lLHQv/9iN04XezCpRIA09M48
         efONZKKxc1e1iZR1Q8N13sGw6xg5BerVX6KvkOvfnmGCt5jqF6jg3M6S0cotLHNnPkJJ
         wqmmPWbXPl2IXTC0yI5yT3vs16EEVVkMIVJdHkAfTpESXhUlmjmc/NEcSesYnst6N/3a
         JAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756241795; x=1756846595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzlN+dsEa0DyjaimvacceBZBAxpbehfow7bvljEAvnc=;
        b=xIKUZ6uGmz2MD1AQCIMF4TE3ZkrLWHF13GbxnrmCZmYayr5Lhy1s+cyoLF7sXHlXFP
         m9ES9sNiMIqhObEdAy3bhBhEXogYJw6zUMeQKZCAK+lusAiM6hwDpl8mhKEC29XEln+V
         ctR4P1lNnyQYtacG3tyzasS+eMluG5RhEiTqN5ObEysXUP7XmktMZQ4xiQBFK2MPGoSl
         Di9I90l+VSmKpVRfz0FgoTL5Mmix4CVnV3lZewtHyHkj3SNe8UTvijDSsdnTB7dvMd9h
         yE/mD5HJn1sreG+K+RMyRNcotxnW4+CLFl2+mwYlEo+vvuX0//U7ar96hvVLv3WJ8rXO
         /8Iw==
X-Gm-Message-State: AOJu0YzmykQMafHJZD9nTvdzn7n2+z/AdEiOnxzXr8If7zMz2Gk5J5iR
	qJ7vLJoVZCRI+qSN1Lr7mkv8AH+PIlI9HFAGbztEvHfcyaJaVXmHlYjT
X-Gm-Gg: ASbGncvAn97Mc3PiFR9RDx5cdrKy9dBNWFVUpGeduFqtQWZDhZ7xgkE1zNHsZ2R1Q2v
	D0QxZk1zK/UBKx62KSgaY6GqeYpHmU8rdbngOAIHUmgNwalRDX3VTRfJlCdmlzAS+mk+8NSyelJ
	R9wNRXr2lVI4mD9LtbwP/XHownW39Ezf9MfMUhIiMJQTFTxQ5Wftf9Qn7hO9amUfJmHbQ1yXtrW
	EC8Svd5Hui2RtAMLQ7OL0XOukoBSOM3fHJ2EL7WNLYfZ7oGX0crIwepGtpUn6dua1OKaVffWSmL
	BukYBy8CfXX/jatkmlgWHR8c2nX1/vxEsT540KzbZeblbjkLggCjcDAmBtJynvMMelBroidcY1p
	Z2+eB727l8NtTsAxzYdVnbj7Gv0JtoE+DAkI8Dr+BOSzLSFFpwi6URlaVZFMLx7+v
X-Google-Smtp-Source: AGHT+IE6v8CNLQIgw+Ku+i/WxqO4TvinQJJMdkDw3LTLIMW5yYdgZnYjPm9+vx14ZzpiizsAY7GNkA==
X-Received: by 2002:a05:6a00:10ce:b0:76b:f01c:fefd with SMTP id d2e1a72fcca58-7702f9df093mr22128819b3a.7.1756241794935;
        Tue, 26 Aug 2025 13:56:34 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-771e814cbccsm5817935b3a.35.2025.08.26.13.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 13:56:34 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v2 6/7] arm64: Stop calling page_address() in free_pages()
Date: Tue, 26 Aug 2025 13:56:16 -0700
Message-ID: <20250826205617.1032945-7-vishal.moola@gmail.com>
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


