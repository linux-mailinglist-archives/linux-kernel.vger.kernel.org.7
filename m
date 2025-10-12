Return-Path: <linux-kernel+bounces-849752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCB2BD0CAB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 089834E4B0A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5EC2356D9;
	Sun, 12 Oct 2025 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pJmfdGec"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066A223D7D3
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760304271; cv=none; b=sPR6iNpVT+7tpZhKNB52c88Q9cAaO3ANcpuAPC6sqgG52onXIlsP+UN5Q/YN/SLNjyaCVEkwAPKJIJmGyXqC3KlpLrB/BJhOQSgQownwxsI5y+/h+tCFiniJBkzwli2azUIneIwqyDGmmhzC/NtCQKDn1tbic4/q7+0jcAa8Z5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760304271; c=relaxed/simple;
	bh=QhB19pcOpxyDzk2Ur3Y2O3RcyjRlLnMNVwMCOcElCIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaK8vLMHgPnKiTGXepnz/exPJT1MV2Fdw+rezI+ohZUPIcfgoNFShvot1rF4azIgtpjjFhFXvCRZcLHA/GY1fOLtoUnME33WR9A8Oe8OmkhQ7OnlpHdsXjfS7O4yLNO8dyLkSVJtzxh44l+zsQxaLNZXyhx1jCObWVIbgSOElHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pJmfdGec; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760304268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E41ygSrpXGOBskATUwM6ql0sSacMMv3vaLKjgxUJMAk=;
	b=pJmfdGecKZf6Wk7rf2ac1CQj8dkuW6CpRkWsfQTbeinpqtdHQDCCzkCzqFEwGF2lHJIdMl
	XTzNYdpF2r6gUyBkKEtTtoWINHju4v9woxd61UoGEN3haV/NK9E7853aW6lwdasQ+uqlmt
	zoj79j4NKAFYS93u76OHPH9oeLVlDG0=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 5/8] lib: Give closures, min_heap config opts names
Date: Sun, 12 Oct 2025 17:24:08 -0400
Message-ID: <20251012212414.3225948-6-kent.overstreet@linux.dev>
In-Reply-To: <20251012212414.3225948-1-kent.overstreet@linux.dev>
References: <20251012212414.3225948-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Give these config options names so that they show up under the "Library
routines" kernel configuration menu, and can be enabled by
distributions.

These are needed for bcachefs to be built out of tree.

The closures and min_heap code originates from bcache and bcachefs.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 lib/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index c483951b624f..badcb5ca9efd 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -367,7 +367,7 @@ config ASSOCIATIVE_ARRAY
 	  for more information.
 
 config CLOSURES
-	bool
+	bool "bcache/bcachefs async widgets"
 
 config HAS_IOMEM
 	bool
@@ -646,4 +646,4 @@ config UNION_FIND
 	bool
 
 config MIN_HEAP
-	bool
+	bool "Generic minheap algorithm"
-- 
2.51.0


