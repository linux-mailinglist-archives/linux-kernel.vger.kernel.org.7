Return-Path: <linux-kernel+bounces-894397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6A4C4A289
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A6664F64BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC707262A;
	Tue, 11 Nov 2025 01:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AP9bnl4z"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FB225F797
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822845; cv=none; b=pmcdABz9+TOPIUiJnM18oyrwESBFxDLcvbG+VPy6RDcO8zvxVMv+JmnWVE1+qbzuuc7u0ZFxIP/S4VOLtAKG+sZq0AgGXhTR9p04edZ+IjZ5OOFv2To4p17P+5trK+Imz24FRETTCr+GGtj+X5FSQ/XO44AlC02kVvPXQAqftV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822845; c=relaxed/simple;
	bh=f+oMxC5qmmdsppFnUbHN3sr50aIBOImrI6V1HFvClKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvB+QSINh6IcqLU1oSvcW3NDcJIsXZEssDwGK17OEyn1y+/T79Jh1Q9WMh6rvWAk+ukhpm2q5+nkkk8YppEx+znAMmjgYUdhFEZYgqm2lfiQHbhSRSwYiwsEIsJOS4KSAcljRk3hXQYNoKBWIyoSRIZ5MYmj9Qm+GF7fje/Jgus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AP9bnl4z; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29599f08202so46463695ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762822844; x=1763427644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8DKKG/b2Ml/VevY+oANvvTeILuRGs8NqX1/6ypJaMU=;
        b=AP9bnl4zyLU0x3WDIen49dEdejhXkdervGSedZ5lN7k4pRf81hD9EXtuhMCWdxe7/n
         kHj52UBrTLLY3pV7c/gmTDapGXwrwo+hxwxtJVTAM85KbeNOsr9qrpKlQFrZe0A9qtDg
         fQ3g9WHS7vUa1IS/SwmOPk02fYca9qnA1XSNw/uk5OzxHYLZ90HWaSCRhk9jNR/l98gp
         SQVlkR15pz+Qq9IC3vMkbec+vtH6o90T7B7xFPrKFIw2gT0FisKtEzLnK6nZ+f6Q1ois
         sRIDW5rLDpPy5Qng95lll0QrfVHeL+y4vwpP627at5GhTlGx8G7aJx3VYdkpA88WPljz
         66Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762822844; x=1763427644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e8DKKG/b2Ml/VevY+oANvvTeILuRGs8NqX1/6ypJaMU=;
        b=ZR1yZzJTTHrfPeS96BK+Kx6dCqV2/kk/r1Udc1lmtlKTi9SeGUkf9fPOJMpCqJ9bp7
         J8bmX5m7ZPgjT7LiGyZuqaZCVCo4/3qTwh8zgRK84Ur/vBV3x4U0gJ4piPRT2SifnCkm
         mN1Pd+qYl3ZP774+jBRiMpN6dUtF9SLlY9DgcsiOXBqzIAOpQe3s5tHX8lSnjtOk755g
         GmdKtwyV/bXJuVFBjyk1u9DskrPZZ0fl4nKPFFb9KKmZ1B0tMpQWXDgaeq5fkLYZ6bny
         RiGGEmjSVtZz/fjnofK7gubildY1ynEdUEz0E+dlMjfItBEKPY+A1+FiShaYGZGWtnTv
         fCug==
X-Forwarded-Encrypted: i=1; AJvYcCUBQTcDDMG4mHLuURNJwKq6Z8yA6bAi1x8DT4qI1JIUJuEdwtj59vy7IoPJFBuigaWC6tvsRhZsEMvRYVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygdNDQzixgl8UABWP/jsA6bSquZKpPTsthIv0nMe9zOL3jCkvg
	/Jrr4zkMuQHiAkaBnYsEyWOvJVdkByYR8+vxpoZ6qYZWwXRBGHampXIc
X-Gm-Gg: ASbGnctRnvK6e5uauq3Fgu6S0v4wuIDd6DNFBiM7+J6f/X0QJwfLrognUy0zLfvfeCw
	r9hb3GCoYpd10yG2hxGY2xkMx1ffhAR39j8hyN/2mLdcOtJjKQovYgqm8AIaQZSrkgTjy5J1u0V
	9g/gDaiGGpIiPHAD5Y1Wq0XHP/mtudMpINKTlsrCrQpM5k1O0j5n+EAdEe0ztCtLpBgh7M9xZ5e
	5WTQ4i0/XGYz9YK28htpO+xlwWUqG3iPe1XC6l0ix5IGCHCCsIWR15LxR+1nBYxUpBH/YsNxQVx
	fW0kIi7dPjSgbKDEV6yz68vse+vfW/h8a+z52AppcHe0ux2v2Nl5jps7C6MG/asIODArFqs+WL2
	UkG4EhxRYx6Il9CngVpwvT5VaMaeGRja82tQIpwvKujgiCOu4gjDtIhg1Mg/nLH7gw0411q7cJq
	PPwGl58YGf1SHZArsiPVna0BrnjA==
X-Google-Smtp-Source: AGHT+IFxgrUWy77gbsunqJhGkWdQe0ZI1d5eQkSH1uE+PZ2zCTXOzCFHVH40iYpbqAAUkEG/NUEFKw==
X-Received: by 2002:a17:903:1103:b0:298:43f4:cc49 with SMTP id d9443c01a7336-29843f4d12emr612625ad.24.1762822843523;
        Mon, 10 Nov 2025 17:00:43 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:d90d:a2eb:35df:9157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca1b8csm163515505ad.85.2025.11.10.17.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 17:00:42 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rppt@kernel.org
Cc: akinobu.mita@gmail.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	dan.j.williams@intel.com
Subject: [PATCH v2] memblock: fix memblock_estimated_nr_free_pages() for soft-reserved memory
Date: Tue, 11 Nov 2025 10:00:10 +0900
Message-ID: <20251111010010.7800-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aQo1VjjQw1OZG8nY@kernel.org>
References: <aQo1VjjQw1OZG8nY@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memblock_estimated_nr_free_pages() returns the difference between the total
size of the "memory" memblock type and the "reserved" memblock type.

The "soft-reserved" memory regions are added to the "reserved" memblock
type, but not to the "memory" memblock type. Therefore,
memblock_estimated_nr_free_pages() may return a smaller value than
expected, or if it underflows, an extremely large value.

/proc/sys/kernel/threads-max is determined by the value of
memblock_estimated_nr_free_pages().  This issue was discovered on machines
with CXL memory because kernel.threads-max was either smaller than expected
or extremely large for the installed DRAM size.

This fixes the issue by replacing memblock_reserved_size() with
memblock_reserved_kern_size() that tells how much memory was
reserved from the actual RAM.

Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
v2: instead of subtracting only the overlapping size,
    replace memblock_reserved_size() with memblock_reserved_kern_size()

 mm/memblock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index c7869860e659..905d06b16348 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1826,7 +1826,8 @@ phys_addr_t __init_memblock memblock_reserved_kern_size(phys_addr_t limit, int n
  */
 unsigned long __init memblock_estimated_nr_free_pages(void)
 {
-	return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
+	return PHYS_PFN(memblock_phys_mem_size() -
+			memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE, NUMA_NO_NODE));
 }
 
 /* lowest address */
-- 
2.43.0


