Return-Path: <linux-kernel+bounces-787221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E60B37327
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1507C7C60
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE24F37C0EC;
	Tue, 26 Aug 2025 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFDhNyMc"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9438D37427A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236842; cv=none; b=WX1qgH9ChkLinvWJKH+pfzURHdpo1au7s9yWpH8b/AdeAEOxFpD7cZfp4kQCo+Q4eAyEUdpmo0K0c9rUmYytVVNsXuv1Z58B7xtd0147GaFA4az8vXzudMpLgfe+8O/Eitzc235dawk7gUrCKVTsYJcb6dpjghuQmFBaxnqFkOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236842; c=relaxed/simple;
	bh=hMxsFCbfS4FNJ5KpQPQ814MUfYn5DLMes7LkACjORbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5qjcGLGn8nHcax8VSjaVTqRvUptxXKGwqzxvhc8dVSrYEdOTPAWHB7Ty5kSUUfW9Mko0BHWAc49jPt2hlXs5TPVoqnTYKb/vQPpnNPqz8Nw5EBXdk6pUPsUBE7emDZLps6ysG4z2ejaz0UZrEFTng3CzFlScCwED+V83BgGtQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFDhNyMc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7704f3c4708so3994266b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756236840; x=1756841640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tE4h8lAMatl8zOgx47ZsHYZprqFSGIay3bVnFsp5zpE=;
        b=QFDhNyMcZmjGSdzm1abnV/YLxKhJSGgfcXzRvN70wRE5/L8fQhBjXbDztCrbKfKK8N
         fe5XR+vFmMtWw/SB2Zu/9m7kFgnOVtImREUeIUIPx7oMdeoRXkf3be0fBMemj9jIjtgq
         4LSvONwfYgm8PjBm0DVp89nYUxKevVryZTVbS0h3DJcYmWIcdkVUe3eSZV9FLwVzYvGQ
         l33s/hKKQM5gC53ZGrBFQndRL0cDYt3zUIKBRuyrrw0e7XeFoZdcSXChxb3rliiDZooy
         t9NYDAc8fQeBONUcGyh7z0Sn0Q8SI2FrbIgNbknXXDbJgY/bZ4Jy3ho6syueV4qkt6hE
         rLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756236840; x=1756841640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tE4h8lAMatl8zOgx47ZsHYZprqFSGIay3bVnFsp5zpE=;
        b=KWSat3KqZBhzU0n+Cr1fbNWzj7Oo4GqD18WWrqGV7GhKvGYY3ZwX9gXdavtI7nHyMD
         6jyUZmMscm6HXTMAJKGngjQ61YISaclQ1F7v/APS9sP9eOqmhQXaUNgtnALYvDDWQGfL
         6MtSKJuE4sLGm5PgZ2NQ+aSVrGxJANkyzpafxYG8Y7DCJ3A1lPut1ibdDiBxDDjrMXE8
         BhzzoI6LDhmtkgQYMCEGhZDKuAifBJjkIXh5w62L5x38kIhui5Dy2AVsiPGjzL9SmS7Q
         I7p3Ray8Bf5O/u7IrlLBnMhdeiGVWrW7Y4GHDy6z/h2s2NxYxhZClvceuDyRg0558KM0
         PRtw==
X-Gm-Message-State: AOJu0YyRAt38sjU6L9FBUeCneIoeH2FXR2eq9s2d3ZPnO3TtFGhcrksa
	3c+MNYBbU0sSSRrQaCUX5GCfJhmG0zN4yrXdgDMGR+tHvRHH7atsKIgu
X-Gm-Gg: ASbGnct/BL02yk7qa+hLnmJVOsrrJP0Ll/x71vlE1bb8JaxT5y5afFYBEzNivFe5tUe
	kT7yMLB3c5Ez33PrCBstobcWLf+smp9oM5x2xeAjOZiRe2ZBDt2KwFFV3MlO+Nsprumlur3mWsb
	xPa7k6sG4cIN8ebLnUCkaIBuLBLzaGUG6aEBTMhzhohxt1kL4S5FLROQC+m7LMReyrmg35KCd64
	2h75JiuGsg63FSEVDL0WbSmc6LL8TV85WjT0S7HW+dihGH/MaKRoTQNU6jSXqnnIAoD5Qo7uKaP
	uIy7sAwPqyPMMlO9PxWhQ1SQmHzuV8kFrUY3o8eu1xYiqwB6Y/ByPRwGSUdFidE7RoPsbz/d7YR
	b9YrS+KvXfnRm2/Tn0/IMDaMiWky5c+O01iOYrouOiYd51VfuzNlMgw==
X-Google-Smtp-Source: AGHT+IEt51Fm84l0Nhom4aT3TpUwGphsXYN6NCk7M5kBdV97xqhaPC/zdbIbDC37KHt+mBDSbo30wg==
X-Received: by 2002:a05:6a20:729a:b0:240:a53:79fc with SMTP id adf61e73a8af0-24340d15c16mr25501499637.29.1756236839809;
        Tue, 26 Aug 2025 12:33:59 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7705647e03esm8054053b3a.59.2025.08.26.12.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 12:33:59 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 4/7] riscv: Stop calling page_address() in free_pages()
Date: Tue, 26 Aug 2025 12:32:55 -0700
Message-ID: <20250826193258.902608-5-vishal.moola@gmail.com>
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


