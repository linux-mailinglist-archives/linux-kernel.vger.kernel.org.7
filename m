Return-Path: <linux-kernel+bounces-869446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE1DC07E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E2B3BDB14
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D34B299ABF;
	Fri, 24 Oct 2025 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rmW2Um8U"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBAA28852E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761334134; cv=none; b=sNV3xT1joMkeeMq452g4TFm3EQViH77Fw6wDjQeHRI1AfNkYHcWQnQlyaMYbq/lJ/TylPQlbk5UtfUY7txla+nw0hUOzR5EKIbWHdE2RFzIDTuug9WhULWq0VuTlqEhHWT3raOA6l6xX2uHfngaSoBIWG0q3k0HMW/c3GHIXUEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761334134; c=relaxed/simple;
	bh=zRLLyMcIx+YxpJ1YN6i1yMmoU67jVcgo6oSJWSiZh4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xe4rsdTZnAq364pdNB6su8j5UkdbY6OPWKS+YilC2nnfGRrUGNVpAPG+eDZkkUBB27iBC/uvD0eZjvVvKTWv7wuBaoiDwBV2XGOXdEEPSMdHN89haqOcmrBH0atCxwnRRoa276HKUR2oclsLGspj7J+WFOC0YnhaHZdfkCM0S+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rmW2Um8U; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8906eb94264so264081185a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761334132; x=1761938932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G+EzXJSaC9FZesJJ13eYezPswFqRH1YsBPLx3UZSy1o=;
        b=rmW2Um8UXKa90nFYblKNlo32pICqMJnGSgskC5hdaQHZQgPN4Qs7LcZBBZvKi+ZpUc
         baUSXFCgtGnyaP9XbMEcsghMcsauNlXM0cKyABQKU+k4hXek3ecAFCXs6+Jaoq8CiMYI
         disE7FLkQLjqAcPb12eQxhFBWnfNkCxUuyV/3TntTtAXyv6gjIKPFnEHrbACngFs0f5D
         Nkyxidrw7xmP2LAzJ1ouNJV0ITt4E5IegbH23TcqHyEqcNG0klnDNAA0DsM/Dy0NdtH2
         U00k/GZNXOi3m/Ai/ir5gjDrmyuqSKXV4E0uAZhtOyd452c0k2IPbywroC0g4kWhAAfU
         p3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761334132; x=1761938932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+EzXJSaC9FZesJJ13eYezPswFqRH1YsBPLx3UZSy1o=;
        b=asajtgtyUazKxNGXsf/hFtKNuH37A6OEV7K1BotPuUSeshCBXRIlEsdBn+ePGC4JO1
         8c9RO4LPDC3fqHFgkF/hz9o+NFTNGG3icE8Uzl/xuZXeaL1f+J+lnEUgBrj44dRayMty
         xLNfgLnFdsRG0A253zR9VsKycRiDdHvvv40HuIUNvL2GESN6sdAlklIbUlxuw/gYd76A
         1iP0fxypeceaM1SRhhvvrLPRjUF82pXamVdNQ3S1vpS5j9UxCoi+uz8I3jpDoulzURny
         oI+dR1m1o7ox0qn3BqT6Km2OV1lAK6dYHO+2riI9BKb4nV7iU/ahUw8dhpV6YicC7u+8
         9Q5Q==
X-Gm-Message-State: AOJu0Yx1HTwY4nKCNVTMFZYW6OGvVkgHq/Fa3u9VII3n4R42Qiw3xESp
	5tH2waT/1qMRbl2KuwH4m5BD4Kp1beSML2GoE2EmfvA2s3N5Xq9Ic1h3EBxj5+/lz8U=
X-Gm-Gg: ASbGncsXdalbbRqgCW52Hec7UxKc8Ag002gL7vqsDjkNZhQ/1dV3jyCobGcd8cvnMY2
	PWj6OCwwRotyjbPN1ukNYHo9/N72NQ1XAX67XIM/6w9ZvEmi+4Ysmb+bUHAIQ2LAvRTxPDLF5jh
	WxoBBcim1KZ6cxQ6o1/TOdADQwJpzZRkqUJK3scEHIGzgeEPEtRZeRHSIV1ddtrRdS9LR1GhU1A
	RWTIXJtfG59dG2SUsJJTJc27UpjdhiNTEpGiBx6x0h7U8De0sB8+YfwUQCiN8sjTVYl3Y7tmzzE
	p4QjFC3X7DmJuSlsEbHVGps74y59sfMBnCFQdfYzfnsLVgl5Ibvz/l2F/roJR9xiY3FbUefC8LJ
	V0B1vJvlxIHqviKnwVhjaRycc2gxFtdcUZN/1oxj0P2z3/FWBJ5wbWBpaqoRKspPi78fAnEGXuG
	XCLGdDE0jhS8LHXtxbwIMMJOBs+8UYFWEfZU2zLqORESdEJReMSfHi3WzZ4uYQG+nT
X-Google-Smtp-Source: AGHT+IEPJ7nVMn0D8TuLagAJ4ryAScORRQC55U56zQKFV9s7QmiDF4aAPmvidtBw7n/btM7IHVS4Xg==
X-Received: by 2002:a05:620a:319f:b0:891:c248:a513 with SMTP id af79cd13be357-891c248a792mr2915298485a.66.1761334131761;
        Fri, 24 Oct 2025 12:28:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c0ec61770sm441930885a.26.2025.10.24.12.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:28:51 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	David Hildenbrand <david@redhat.com>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v3] page_alloc: allow migration of smaller hugepages during contig_alloc.
Date: Fri, 24 Oct 2025 15:28:49 -0400
Message-ID: <20251024192849.2765667-1-gourry@gourry.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We presently skip regions with hugepages entirely when trying to do
contiguous page allocation.  Instead, if hugepage migration is enabled,
consider regions with hugepages smaller than the target contiguous
allocation request as valid targets for allocation.

isolate_migrate_pages_block() already expects requests with hugepages
to originate from alloc_contig, and hugetlb code also does a migratable
check when isolating in folio_isolate_hugetlb().

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/page_alloc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 600d9e981c23..23866d4c26ff 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7048,8 +7048,19 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
 		if (PageReserved(page))
 			return false;
 
-		if (PageHuge(page))
-			return false;
+		if (PageHuge(page)) {
+			unsigned int order;
+
+			if (!IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION))
+				return false;
+
+			/* Don't consider moving same size/larger pages */
+			page = compound_head(page);
+			order = compound_order(page);
+			if ((order >= MAX_FOLIO_ORDER) ||
+			    (nr_pages <= (1 << order)))
+				return false;
+		}
 	}
 	return true;
 }
-- 
2.51.0


