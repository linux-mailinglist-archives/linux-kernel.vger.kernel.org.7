Return-Path: <linux-kernel+bounces-787220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A08B37326
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F8557A4EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B3237428E;
	Tue, 26 Aug 2025 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHrGdUL3"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2D037288F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236840; cv=none; b=mRm1yGs+TkM99i0ZbLFJLYc8C2HJHFDg3K3ix4Bcmoms2LVo7iJ0tjIgZMi1ZagQbUANr+vBUvNzELchGav0p2V59iX/iirDiflfXJUdMUWmwmK41tmxQqxSHH2rca+m15bcLsj0GSNmWKrVUoqbodBZhpvGJeUKrBk+8NoFnCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236840; c=relaxed/simple;
	bh=b/wlUMk4IKuAZ2GTwA8nDxHIbo2jrk1gE4wdCrMx7R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HE0tdqJUPpLWCkLztstg2wvXhEC4WyXiD6aS1J/tfl+nDM98A8GcHMGPzJaFYUeqrf9R6lT6ViDqKefo669nYjfbKtQwoJ//5UjSb5KQyZRJ4SU9mIHpmaTqx81rrbcYzzGnc6JopQ1ve0KqSfT/6eeuua4B59b97RHCGBHIGw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHrGdUL3; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-771f3f89952so242389b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756236839; x=1756841639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3RZecD6lOIXMEN4BMHwXQ5RekIY8XyyevlTW2TRt7g=;
        b=WHrGdUL3FJSoSAVGTXGMv4DRGOMlEmt2VmvNCsHj0OXMtHuPDnJ7F3S/A5XhvOVq8Q
         leYiunZxw4P4Kw41h2OCRu2M7s2Tvyeu6QRmcx601iu1BU2kZZe9fADjIwYbFY2JQ0s5
         cb5TDJRQbfiAVvo8qSkkJ8ewQL3pOvzyHBrb5prnDGJZZWSGZTat2NQDAI/wArV9MLJ0
         LbhArQjnVuxFAUkAUjcxLQsQN6CDzRbp1ge/ETH3KvhSsFad8AdwSiTLaTTHk9HKiVcY
         plS1AsYxhZA9rT/6WZUye7gf4A/422JlAZ/BS9Oss8bB0rsOeReLIvLRQRfBnm0c11NW
         yx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756236839; x=1756841639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3RZecD6lOIXMEN4BMHwXQ5RekIY8XyyevlTW2TRt7g=;
        b=TAQCE+yAvr2eEruyXZl0R9BhR0SN3EsWdCVvGlyxhOrt3zxPQ5e/TEOcUY/SYTHNGP
         1DRa4VJKuBb1FpN0l181FUU/31ZAHict+PIrEhFD9MyyevzajELQ6WAQiHJifsICK3V8
         lRzMiFTVU5+GAkHSCpfv+5CGn8uzAaCt0iZkrMx1czdrnpq63Zv/JySwzxBOsujEt86p
         /T90rsTXPdyAwyYw83q/GFaiUCnAtO6AACYf1zTau7GrUFD6Y5nMKDd2Vm9xnjqiQDFA
         K8b3Rg45cUIp2V6iXNesjWSm/v8CcUEmTktQ7bZgOyE4aDHft7jd+LA/k8iWAb6zHx/C
         vH7w==
X-Gm-Message-State: AOJu0YyNezOOU3FwCZMrDctfecHu8fzZd9Eg5I5+XSKC7ToSCNPatxUc
	p/CkkEZotcVLlL4WVRBkYrD1eb08vhptdEVqM56a0iRQfvCONwoXWIep
X-Gm-Gg: ASbGncvwKtg8Cr8j/W1IMiJz+78Qk1gHrdZeQBOUFC4Ryl3n93TAbQlM03U0wJ5yw2y
	IO/glplFZk19OayG9+u4QfmszGkvvDZ9g7pnKHqSzNGbP4624hTGqOkrn4d7O5uN5of1RYNmF5T
	yYDQACTDOMhBNI6Z5pRnqvpE7h1BxSbExGRb6BNLWSUMEW9qmEUEa+oxyi+a3EdgqyKStOc+6Ae
	gaset4869uayMF/+Jl2+5n8Hwvg0cYrNQOHGtPR4DDE+GMGBUYEWih5unyPU05rmi8TBC0vZsJf
	PT11Lk+lQS9Vd0wGDI8O69HEZTkyaCTc1gPsuA3MWbpWCfDq70nZE8hjwvCLYLgoFnIy5UDiMSu
	8A94UwNcYnfizwGZsNd5d1LdA51O+6LGAq6lueSbuTHz5CT1RrK9JUw==
X-Google-Smtp-Source: AGHT+IHlNUyW55X01A0f5EEFBXuViJGDeQdu3GLU6vSJt5YhnhB0dXsh/ZnXWPC1g92p9Hw5k0RjEw==
X-Received: by 2002:a05:6a21:6d93:b0:243:27d2:61cd with SMTP id adf61e73a8af0-2438fad28f4mr3498164637.27.1756236838595;
        Tue, 26 Aug 2025 12:33:58 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7705647e03esm8054053b3a.59.2025.08.26.12.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 12:33:57 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 3/7] x86: Stop calling page_address() in free_pages()
Date: Tue, 26 Aug 2025 12:32:54 -0700
Message-ID: <20250826193258.902608-4-vishal.moola@gmail.com>
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
 arch/x86/mm/init_64.c          | 2 +-
 arch/x86/platform/efi/memmap.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index b9426fce5f3e..0e4270e20fad 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1031,7 +1031,7 @@ static void __meminit free_pagetable(struct page *page, int order)
 		free_reserved_pages(page, nr_pages);
 #endif
 	} else {
-		free_pages((unsigned long)page_address(page), order);
+		__free_pages(page, order);
 	}
 }
 
diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
index 061b8ecc71a1..023697c88910 100644
--- a/arch/x86/platform/efi/memmap.c
+++ b/arch/x86/platform/efi/memmap.c
@@ -42,7 +42,7 @@ void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
 		struct page *p = pfn_to_page(PHYS_PFN(phys));
 		unsigned int order = get_order(size);
 
-		free_pages((unsigned long) page_address(p), order);
+		__free_pages(p, order);
 	}
 }
 
-- 
2.51.0


