Return-Path: <linux-kernel+bounces-725281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C833AFFCD8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A296C1C83699
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0EC28F50F;
	Thu, 10 Jul 2025 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="C1gasASQ"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4A228E604
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137653; cv=none; b=GXEx16EQgwD6B2mRIe8sO9fccZPfUq8+yjN9VwD8x58TtrFbwnUBNdFyy59EE7xQnvo9muYmETpgI+P7qrKidAZInxJFFtuwVODNEIkIqdadoD5w/X5hEO33BvfgxAuhd6j4lFpMRWimDHqSK/7gwGtoYGCTLtJqHJNN0rLRp7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137653; c=relaxed/simple;
	bh=0PVCuB/OvGXxkc33B1dLuwyIQOpnfJD+l7vZ5f9Ss+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xu+Pvx5bR9z0w+cCHaaQ5da94IgchDdd5+mZ9dSUZRm5leAp4mySBoN29p0/MDTnuTnmi2IFxoPbTu80ixrW34zy52/FYzuHOz8RqOBTvJF2Tq8NkWctZvKbOaEvvzZ+rmkF8XqhJecreZi9H8rnf2x2kF9Hc4surwEH35ClgX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=C1gasASQ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so673663a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752137651; x=1752742451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUKujTie/xgtNbVO7AZBjb1RhL5nzywDx5C8kGbmtCs=;
        b=C1gasASQIwtHVg5001ryHxZtam1La1Qi0Fwv2hJ8ahZdrQT7JeoOs9M499n4+dFHZa
         Tchs5oEjcMmas9dXo+CLs5LK2Gh0rOoatm81SvZDcFlXAKPOeMK8Ro24iAGlxsrH2WiI
         1LzaelgY2zkQrKgTCpXzb14L66RlArspoOGa15ZHXs25mRmNM8SbO09fP9Y7HAmNoLAT
         6RD3qxNwXEsj1Cr27fIgXzE8++Aijj0WDz64Au3UOU79a4PxImMK8NI4+S4f+FXIgnE8
         9AEBpV23CwsyKz46cIZnDWS3YcTN+0FdQH6BVEN0GQR3dvvbdpSL0O+Ys/6PsgpyS1Zn
         E27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137651; x=1752742451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUKujTie/xgtNbVO7AZBjb1RhL5nzywDx5C8kGbmtCs=;
        b=Sqw4seVb8ldxEIORNDQSJebMDFs4cHKg6ynODcFguLHLEzWlZ/Qp8SjI9htfAnui2/
         umlSezeTXDnBf3rI35c2KQP+XVJBGqC2odiEEHsr853exgLg3lENMJcPultCYxiAhcsg
         v7eiE/5fwnsRCxCgULr1MiztokOxy73EhijPWu1Zzsi6fObE3a1CC63aceJUxlDZ2+0f
         TOtd7valsy1xxsl4X5Qje2EVcq090a6PCTpDu8L1OrNvzaaOwSBi7K6Z44NT/Psk8Z9x
         R73s1Z1ivzutQn82H16xB5VM7MYaPU1RqHoqfZF9+g9tFg/8s0dgmKEIadOh5rV9b5Pc
         vGRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJxtxvYpwbb2wfQaS/U+0hA6RdViN7aPQ6bXeqTb8ZlC9RLaDjVicJn95GGBVPB6KUxvfaJR6TyWRghwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpbDhooALwWSRnvhNFYNmO9lksF7PcmuxI4ovc2bNBIw89+VrZ
	5TLbHfTU/SNrXm/R7hYmA1LyYRvpGyXOyU433KmEeQq6ufmFuYt80OE7ii+RPBvWZDo=
X-Gm-Gg: ASbGncsfWDvxjm88fN43wndtUyIacvGE/SyVH5uwUs8e8fOd7JyA1iDcYavsVNbcaeR
	tFEIL9hMq71f47jVBylJ4UABKU3KD7hH7JYji8x+O4SqExNj8u1kYgsC0Co8EBgjx3mlkNoFQ+e
	p27X+o8ECuDa2pGyrhnKYQSLrDCWp5UB4bnbg65lJ7hpplOzjtU1eDW0ASm1G5xivWhR3+VCJD+
	s8Ga+BIkzi9antLA6BgD8cJgM6xSKJOiX9ll33cLfh+f5L3C+SEa5Ea3N2iqxI9horOcJHtnlFh
	Yr+DXd0e3B+gcVWqHaZ7rbqCBdudUnffb3+JFO64p6W4sQgDsZc3Vwzrn+FlVPgPpN/FvFID3sD
	+4aQ7ZL7HeDiCSA==
X-Google-Smtp-Source: AGHT+IFBl6XWSS3SCRPprWFOA1sj7pbVIrvseX/rWxTSbGo3aaOmi/r+s3MsC/OYlpN25M32JL4H2g==
X-Received: by 2002:a17:90b:57e5:b0:311:b3e7:fb3c with SMTP id 98e67ed59e1d1-31c2fe0ee60mr9144636a91.31.1752137650816;
        Thu, 10 Jul 2025 01:54:10 -0700 (PDT)
Received: from localhost.localdomain ([203.208.189.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3e975d41sm1650228a91.13.2025.07.10.01.54.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Jul 2025 01:54:10 -0700 (PDT)
From: lizhe.67@bytedance.com
To: alex.williamson@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	jgg@ziepe.ca,
	peterx@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lizhe.67@bytedance.com
Subject: [PATCH v4 1/5] mm: introduce num_pages_contiguous()
Date: Thu, 10 Jul 2025 16:53:51 +0800
Message-ID: <20250710085355.54208-2-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250710085355.54208-1-lizhe.67@bytedance.com>
References: <20250710085355.54208-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Zhe <lizhe.67@bytedance.com>

Function num_pages_contiguous() determine the number of contiguous
pages starting from the first page in the given array of page pointers.
VFIO will utilize this interface to accelerate the VFIO DMA map process.

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0ef2ba0c667a..fae82df6d7d7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1761,6 +1761,29 @@ static inline unsigned long page_to_section(const struct page *page)
 }
 #endif
 
+/*
+ * num_pages_contiguous() - determine the number of contiguous pages
+ * starting from the first page.
+ *
+ * Pages are contiguous if they represent contiguous PFNs. Depending on
+ * the memory model, this can mean that the addresses of the "struct page"s
+ * are not contiguous.
+ *
+ * @pages: an array of page pointers
+ * @nr_pages: length of the array
+ */
+static inline unsigned long num_pages_contiguous(struct page **pages,
+						 size_t nr_pages)
+{
+	size_t i;
+
+	for (i = 1; i < nr_pages; i++)
+		if (pages[i] != nth_page(pages[0], i))
+			break;
+
+	return i;
+}
+
 /**
  * folio_pfn - Return the Page Frame Number of a folio.
  * @folio: The folio.
-- 
2.20.1


