Return-Path: <linux-kernel+bounces-725283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C779BAFFCE1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F17586322
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A2428DF44;
	Thu, 10 Jul 2025 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RBbP7lt5"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB852900A0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137662; cv=none; b=TEcBRuXx3P7ccWi0DQQXq/PVbR1p9LL9gxUPeTDEU2mtLzHferLE+LsjfMaBFHtClc6SQW7QegNFXB5PolvylNvrcQGKb8iBbH6p4sR3D+DzEbcF7W6Tva3i2Oc5jLEbtoIklLpWmff5LOFaibGEbQnxxZ2INGCyMP33TblAqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137662; c=relaxed/simple;
	bh=4N5I2w5e2jHfjeqUUs8UP8e7d+l4qfu2b+4DBY6K2Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hiLAbUjotb49Jh87Mt2dYJBlRy6MNwCp2Ya3MHsg8C6tcUNs6K94FOkVfhBdRLiX+f3d8c/jUTLdyvg+e7nSgQJHU/3v5vOhHS6F815YcszQ4GtpM891qwlJeFqe46LkMmY2iei25EE3tMwvv9eRVNwTNVEs1LsuTq85Xvv7kVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RBbP7lt5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234f17910d8so7865155ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752137660; x=1752742460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nx6tn515BmvVRbPQz9Ke+EyJMh4nGWIC6oD4cxq1tFQ=;
        b=RBbP7lt5E2/ic+C0dUkuLmZYndw7LSu9MUGrM5BB8v1z+2l8K8zJMnWsjYN+7ilOiH
         TQGinApXthUPYA4B0dLDGJDpsa5qn25lcRzzqg7QMaVqyk3wdyIG7DCorP6eVjTqfHip
         i2ZDWrtt7ZnIi/35+nMXuKmO8z00lXQ3giisi3oYU8Kf5cw4W5ayCgGRXL8CPB5hdZgc
         1TyEmDzLuDGTddmhcxggefBzBd6ZEd+YFi+ciiDwsAejhb1Q8i4YC3JIumT11l4A7zmZ
         x66Tl+o7OlQu7SDZcAAv9sVnzsleTr5SPHqcajHML6KvDiZ21Q2N1ElwMFYkd571G0GY
         kDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137660; x=1752742460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nx6tn515BmvVRbPQz9Ke+EyJMh4nGWIC6oD4cxq1tFQ=;
        b=oDWwe/6k3rlNW/uz617nsfm9qWPdfLwn1hwwA8pQ8xFrFunh/MD86LXeQ0hvOwwXYE
         bpGzhvST+fLbpd7y9J0Mxv3z3psTzuaGEa3/wR/1DaQhhSTCbCPWQ1FjDST7rMLidFVs
         FhE64k2YdkH+/0Ib7/CYlyfn0J+p4I8oEz49JW0xoN95r64J+nqgw+OSoHc6Cz2oPjvv
         ZZMUhbtCalk+WMheN4Bztjw2XJPdhN4+q46Lup2jN2+ErbubfaoONLpOKlF7UdbK7H2a
         jNn4fS+GHcYiqDtGakPkhtxBNuQOr/3WvqYjKLDHCvUgPWfErPnUCQdBBUa2Sp9R3Wuz
         0g1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcmDFq2IfkQgQh4X/fQzryIxiSBpUXzOqK/uxfqYPRz4xzuWWDCvZg2jy8aw4SMetGG4gvi0zH75zQuqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsqUrDf8wvCmUkSRXCl2Kvx0z7jghmCidP58b9lQBzx6Cmg1ae
	XZhbEo0oCGhs1JnwTLNoZgb8YT/5rwRJBfF4f5iZaOnCUuYMIfc0HmsRiJ8WYWL1TJ8=
X-Gm-Gg: ASbGncub8TfDyIekTRRCMHX/3vVVwaAYe1SzvEecWa182Pijx81CpbLNrdlpaETrl47
	R4CmtWlVadcvb4r1Q+xq08XpIKkNLC7N7Qb7gIcSL4dhBEp6nL1kTwtS7QmPuLAd4eU5p/K4gWm
	ZOPIsghUpMbmhY4Vh/D9oKE0uVHDRNnaEn+LNnafhG75rYy+XpjrbiwuJZBdLR9SCCxdXm17Xpa
	JBrqs3qRS0CQ3gR39sizQZAaRreG6xl4WW1H5/Z6Hl3HiAbniuOCKE8y2JvOhmufB9W7xa/KpSL
	+UAmFEhWle17cUx4U1/SD6VodDySnB5qMh4P+C3A7xJ6racbad1X+m9fi1lFcw71KXDI6JON8l0
	06o2AJDRZVf/5lQW64Xuyr8Od
X-Google-Smtp-Source: AGHT+IHinmUo1Q8JyIR8mVroxGH87B3iRX98m8gWf3ZeXBpz/jGd0mYLjHRrHOq8wekDWW+AqoXtuQ==
X-Received: by 2002:a17:902:db0b:b0:235:225d:3087 with SMTP id d9443c01a7336-23de24d9865mr39979545ad.30.1752137660449;
        Thu, 10 Jul 2025 01:54:20 -0700 (PDT)
Received: from localhost.localdomain ([203.208.189.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3e975d41sm1650228a91.13.2025.07.10.01.54.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Jul 2025 01:54:20 -0700 (PDT)
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
Subject: [PATCH v4 3/5] vfio/type1: batch vfio_find_vpfn() in function vfio_unpin_pages_remote()
Date: Thu, 10 Jul 2025 16:53:53 +0800
Message-ID: <20250710085355.54208-4-lizhe.67@bytedance.com>
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

The function vpfn_pages() can help us determine the number of vpfn
nodes on the vpfn rb tree within a specified range. This allows us
to avoid searching for each vpfn individually in the function
vfio_unpin_pages_remote(). This patch batches the vfio_find_vpfn()
calls in function vfio_unpin_pages_remote().

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 drivers/vfio/vfio_iommu_type1.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 6909275e46c2..cade7ac25eea 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -794,16 +794,12 @@ static long vfio_unpin_pages_remote(struct vfio_dma *dma, dma_addr_t iova,
 				    unsigned long pfn, unsigned long npage,
 				    bool do_accounting)
 {
-	long unlocked = 0, locked = 0;
+	long unlocked = 0, locked = vpfn_pages(dma, iova, npage);
 	long i;
 
-	for (i = 0; i < npage; i++, iova += PAGE_SIZE) {
-		if (put_pfn(pfn++, dma->prot)) {
+	for (i = 0; i < npage; i++)
+		if (put_pfn(pfn++, dma->prot))
 			unlocked++;
-			if (vfio_find_vpfn(dma, iova))
-				locked++;
-		}
-	}
 
 	if (do_accounting)
 		vfio_lock_acct(dma, locked - unlocked, true);
-- 
2.20.1


