Return-Path: <linux-kernel+bounces-694669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AC6AE0F47
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 00:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA055A164B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 22:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B1F28D8E9;
	Thu, 19 Jun 2025 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/Q3Veqo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFFA28CF6B;
	Thu, 19 Jun 2025 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370430; cv=none; b=DWWdd/tDwvYNBP144TXz3wRzG5lLJfIoK8WKBBnMwBqbDWWTRI8gNy1dyHYFixkvf7EYq7JFZOW9InkfMwjYCyEvzWY5VEF+nunz/sdez8iBNkqpxjW8wo9oJiFTxkJlrjsGqPGV09k0nJilHWBdkKn2dPlIETG4zO2u3qb0tZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370430; c=relaxed/simple;
	bh=FL+q0PIy56zCfoaOYFZdf7xArsaTKGHGS5paNyqWubA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YnIxab6hUKbzs36xLlCN4TnMtpvKZqHFFOfOfpOn0wxxHFLLnoX63YTu+OVe2f3M+RnRNSDln0W3r2TUjDGAc4+Xq7l39ExZZQvWA1IkqlXRd7rPYb590978JQMECamByj/kpEmEWKH1AXFT+BdtuqKNtv9pUDOofGAccJMF9qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/Q3Veqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B789DC4CEEA;
	Thu, 19 Jun 2025 22:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750370429;
	bh=FL+q0PIy56zCfoaOYFZdf7xArsaTKGHGS5paNyqWubA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P/Q3Veqo05zrRL2NWOdDsxRdXpHEILquWBMELgpQQ+DHnYfM28d0FT3gKYgf+yWTK
	 JD5nvU2IHlyLGPDsCVWVQOUWvlsHypgC0wMYEJFPXtMm1fIVOGjk2LAYUFUQR5RdbB
	 kGPZy/sLuh1bTkF2xaN8EVEt/eVbXlQbDM7mQetqMVgCbCGi82o9E3+Z3/R4K0900J
	 RBPGyTZLWk1EToSRSeo8Q5ohng37MlsDK8w4nR6/7Z8Uy/t0gr5ADcoLPMTLsfG26b
	 jFG4k+9qjUBBTfcjlThWs0SZ7SXWZHYg/GJf/+NW9HW/cqtY9HN6JnjlDAAkWJDAvi
	 CDWK2sXkAxy/w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 01/11] mm/damon: document damos_quota_goal->nid use case
Date: Thu, 19 Jun 2025 15:00:13 -0700
Message-Id: <20250619220023.24023-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250619220023.24023-1-sj@kernel.org>
References: <20250619220023.24023-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_quota_goal kerneldoc comment is not explaining @metric use case.
Add it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 492be8319a25..39b835dd3c4d 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -206,6 +206,9 @@ enum damos_quota_goal_metric {
  * If @metric is DAMOS_QUOTA_USER_INPUT, @current_value should be manually
  * entered by the user, probably inside the kdamond callbacks.  Otherwise,
  * DAMON sets @current_value with self-measured value of @metric.
+ *
+ * If @metric is DAMOS_QUOTA_NODE_MEM_{USED,FREE}_BP, @nid represents the node
+ * id of the target node to account the used/free memory.
  */
 struct damos_quota_goal {
 	enum damos_quota_goal_metric metric;
-- 
2.39.5

