Return-Path: <linux-kernel+bounces-893614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F99CC47DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6D934F5086
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C1627FD71;
	Mon, 10 Nov 2025 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAhUz7+c"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C501427CB04
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790916; cv=none; b=AOXrbbQCTjEzmx2t24PQUcrztVVQen86JG4eH3MAxkSvow0yTBoYjUm+t/3ThweGJ9l3mPMVj5zV9JO4ewEqUkP8gURxtR3z1uHoG1yyxRn9kOlp+j4ZujMtZ3/2IiwjGdshFa0NPQ4ZQDUOIs4j2/edoobAYT+ZNX5cJO6JqA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790916; c=relaxed/simple;
	bh=j+A69YO9GPyr0gWQ3u5mkLwW0l6/fn1S8Q13eXcie+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHCfgHBiYxpAKKOKHY4TS8xhIWuAZjxnJx48ZDK0pHoKRMw13BIZdkL97K+shEpFOMS6clspzVsVf2AI/1/TYUoADPmAVOue5GLF8vOLub5EMRZme2PKdS6c8G/u4wMPwPm73dPocuwqPbwmPSHI79D8y4oh8IUjuJtYh5LW0nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAhUz7+c; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34361025290so2079672a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790914; x=1763395714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuKiYqKXaLoC/HHi2F0UDEkiOMPWnRzm7yH74kwlVYw=;
        b=VAhUz7+cB744WDIjMdpLWRHtOyHixJB3ushc15ds7a5ETYLKmE83qn78jNHMX+BEq7
         hjjPnd1oynAxPHTaP73MKClrOUm6u5SRLifHgQVjxHnWc+xaEIN398p69jfftzWOVdSK
         +TIBUBvDb+epT0FqSe5na4EBog0cMlMFSVBiKZbzValpEkBw5qnL9Cm1LJYtF6WlqGsY
         9lSz0XeguumeXvlZ+Ju7xD7Xwkk5FMSobZEhGTrv7SLkqLdPyO0VfT7lh/LVOM2Xi17Z
         761PEQn8uNfWJfrxo9x/385DFejm+4W+zTw9nQB5uRp/ip2tt1iHvj2GQU/GHv4JgFbZ
         EvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790914; x=1763395714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FuKiYqKXaLoC/HHi2F0UDEkiOMPWnRzm7yH74kwlVYw=;
        b=bw38vrqFpcjwHakXr0rW0Em7DWLK0oz/EXhslQr4z+GBcYvJC1OrazM4ddaxikgiAZ
         y23oZvJPHMaTGlnVItuvyOb8zz8xvnAu4C4eccpG0FZ0EA47JXJfgS//9pNSvwNaoouX
         GP7Pgx3Gs3fdrA4yb5WzqZgqZLMSI/cxaCb29PMgrZK7RwngXkJixLMicWQhBjVLDKlY
         AbSHvITvSWtsz/rPH3UgQ+VTuw5V+ySX6OyFMVm1dxmQq26tPYgJ7mrWLypJ3R8ahbSO
         sObpLW8W1Nzj1UL86EHpErCRqXlnmgKMswHJpu4Xw3xhhjpUu72a34Sv7lJ4or8g7SfO
         yHEw==
X-Gm-Message-State: AOJu0YzfcbjPJdgr37LHaPL6lCQvJY+lMIHjrLKAXyRiSOE3SQJ9/3di
	Ac24DE4kaxtuj8yMUZwo1L3ZJmaMa/k0kDPgpIQqMCnPaJ7vf7g7K1Ngufkvd0pq
X-Gm-Gg: ASbGncvoUW1R/ok1753j7buvJDPEreN+zaWk6I8+bNB6l35Q6kVVTVeO4kEYCTnbhvR
	Oo9gx3mdLUGshHL79wrkJ8DpfBuF2UWVEbWUXl3RKCptuMYFQYsUg+MePTvgyQ0PyByDyN+odhS
	DBQew9RYY0oKiRiUPSgNnMAfANGiMO/++vlVs//Ms+iNipxD3wcEP3DXOys1XdGo9UuAyGXfsVZ
	esTjCH4kTeBKDcarwB4YlFtdnvU9KuZFGktpKdEwterUVGysD+lflSEc+EIDV/7l7YvIyUj+sYI
	4Rdgh9Nms8gr0JjTrFv3JEQM/8yhq+3prF12N8+dQfzEe5LTdLXjG0MDytMTr/++ib1kYl5dc55
	4irhbjMUBuVt/E74xeS4/xDFcrpW6pxaEwC6B+MWHKiwhyrc1xzZerHIhna6mqXF2MJoNf72CTu
	O13vlj0O+7WOfB2QG9RanT2rH5To59zvVUvCoc04GY19A=
X-Google-Smtp-Source: AGHT+IFxL86gMO8C+HEUrlebZRsB/XS5G9BUSOq9q06RQ47+OUHEKa103lg0GYFY88+iDHCfSgaIwA==
X-Received: by 2002:a17:90b:1c0b:b0:330:7a32:3290 with SMTP id 98e67ed59e1d1-3436cd1cb48mr12509736a91.37.1762790913565;
        Mon, 10 Nov 2025 08:08:33 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34362f1f231sm9308893a91.10.2025.11.10.08.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:08:32 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 4/4] mm/vmalloc: cleanup gfp flag use in new_vmap_block()
Date: Mon, 10 Nov 2025 08:04:57 -0800
Message-ID: <20251110160457.61791-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110160457.61791-1-vishal.moola@gmail.com>
References: <20251110160457.61791-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only caller, vb_alloc(), passes GFP_KERNEL into new_vmap_block()
which is a subset of GFP_RECLAIM_MASK. Since there's no reason to use
this mask here, remove it.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 970ee6756909..eb4e68985190 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2699,8 +2699,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 
 	node = numa_node_id();
 
-	vb = kmalloc_node(sizeof(struct vmap_block),
-			gfp_mask & GFP_RECLAIM_MASK, node);
+	vb = kmalloc_node(sizeof(struct vmap_block), gfp_mask, node);
 	if (unlikely(!vb))
 		return ERR_PTR(-ENOMEM);
 
-- 
2.51.1


