Return-Path: <linux-kernel+bounces-720479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CF8AFBC56
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E77F1AA1BFE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BE421D3D6;
	Mon,  7 Jul 2025 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KgiG4ptO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E51217736
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751919201; cv=none; b=nKPHyUuAeME510/Ap1TbKBtlc+kgShePxQAPjCylToIBB75CDR3EuYx0sFiK8WRx0lKWVkZwIDj/Ck4AUU72xT8zSuaIsXx56kr2fhH/H67eup/MhNVwpWG8enXI7rzrUHCZpG1OwZOt+ju3pL/G6uZh9HfBu7eIBisb4+RNPeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751919201; c=relaxed/simple;
	bh=ny6c289FN8Mu76v5QsWEeh4OjqoLdbJ0bsZ28vVAQ60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d0R5oxGDUe8HJrsUr0ewqDS+1o5OvVQBlN9RoLCTxb34HfF94cqB1rxz3JKqDHrIJIakXnED5OWFfkwed1tkuNEQlwNu6nFRRN2ybmAxCl5orD+FtkMm18Qyb0zou44mkd8fP05IHp+AwzqPYFhFFAkcZCVwJeLRFrNgkNCiMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KgiG4ptO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751919199; x=1783455199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ny6c289FN8Mu76v5QsWEeh4OjqoLdbJ0bsZ28vVAQ60=;
  b=KgiG4ptOqP1nyytrJjuDT2/7PqtvZPaEIpeBy134gXOKNzkv/nHdwNk/
   3dOcjhnw6qdzpnO3+M4nZ3+m501aOviwUqPqKWy60wnU2bQEXsgCd/vke
   8sg203mKDb+EomJ6Bh4yjOv/Z8iETvTKvwmtgENNfvJPpOpaZ+6tzBaBo
   5jRr6abWrt5tSNWUnrC/aRtqW7zBwo3wXJC7PClhcyh8Ho0JtzdXauBDe
   y993L2srmmGkjMQWmZcxwXt1dUJPbPYm6BsO1DuGjh1qkxNlY00PqsisX
   7pi4lae50AM1bBUXodjXo34ksQlxf6DfzjyyNKojoz6HiS9fxSNkVr2o1
   Q==;
X-CSE-ConnectionGUID: X2A1c2scSdOlbfObHnucwg==
X-CSE-MsgGUID: 5cxuyPQTQX+7/XfZO2eEYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="71729817"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="71729817"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 13:13:17 -0700
X-CSE-ConnectionGUID: kBtRISmtQyulWJFFL+fdlw==
X-CSE-MsgGUID: NXeuO4r/Q/SzvBJwMUsyMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="159343033"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by fmviesa003.fm.intel.com with ESMTP; 07 Jul 2025 13:13:17 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	21cnbao@gmail.com,
	ying.huang@linux.alibaba.com,
	akpm@linux-foundation.org,
	senozhatsky@chromium.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v1 2/2] mm: zswap: Consistently use IS_ERR_OR_NULL() to check acomp_ctx resources.
Date: Mon,  7 Jul 2025 13:13:15 -0700
Message-Id: <20250707201315.9497-3-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250707201315.9497-1-kanchana.p.sridhar@intel.com>
References: <20250707201315.9497-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch uses IS_ERR_OR_NULL() in zswap_cpu_comp_prepare() to check
for valid acomp/req, thereby making it consistent with acomp_ctx_dealloc().

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/zswap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 7970bd67f010..efd501a7fe29 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -893,7 +893,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 		return ret;
 
 	acomp_ctx->acomp = crypto_alloc_acomp_node(pool->tfm_name, 0, 0, cpu_to_node(cpu));
-	if (IS_ERR(acomp_ctx->acomp)) {
+	if (IS_ERR_OR_NULL(acomp_ctx->acomp)) {
 		pr_err("could not alloc crypto acomp %s : %ld\n",
 				pool->tfm_name, PTR_ERR(acomp_ctx->acomp));
 		ret = PTR_ERR(acomp_ctx->acomp);
@@ -902,7 +902,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 	acomp_ctx->is_sleepable = acomp_is_async(acomp_ctx->acomp);
 
 	acomp_ctx->req = acomp_request_alloc(acomp_ctx->acomp);
-	if (!acomp_ctx->req) {
+	if (IS_ERR_OR_NULL(acomp_ctx->req)) {
 		pr_err("could not alloc crypto acomp_request %s\n",
 		       pool->tfm_name);
 		goto fail;
-- 
2.27.0


