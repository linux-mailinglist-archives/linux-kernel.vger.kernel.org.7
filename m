Return-Path: <linux-kernel+bounces-830104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DA5B98BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254842A4C9E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC1B2857F0;
	Wed, 24 Sep 2025 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CCLl28k5"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787082820CE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701020; cv=none; b=hrE7RlirGP6vd/9t10GWpWsQ9pDeKdwuokKJNrFuWMEuAD1M56/oc2Yaj0lorCXHppkPbNfspfQ/QCzC8I+QwEx14dziOr3DYHFwmhflxuyK4MAykUI/P8WzwdzZdR4RVVbBIEacpEHK18peCjlbTYekyJDAXK9wxKKN13sQl34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701020; c=relaxed/simple;
	bh=VG77jIrBtuiMeWb+0UyzSJZgzckUa/NXxaBr9lzP4sc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GzPGap9xVX3gKrC3Kfm4gTbO8UOXqi6yD+sUAg92lWa7bdg9qYMEm+Dbxb3XfU7h0BPB7So3YX8deL+fIMaiTGiPGsllxWygpdevyUZWB9kZw/wWqIx8bcBLOy01Xv3Z3owdKUZIxIZzFIROpJGkLIuewmMYhZilcPOSSRPub5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CCLl28k5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=0du3iXCSqL6lcLgfL4c7Fl9YQ4+y8lzBi1ZnqMrkphg=; b=CCLl28k5+4LZTC9kR0cSKop3PX
	34qdCfLnuxRtISBW6Nw/fqCoE1OXhqsiJVKwu2hNLcMiNifcg5vo5cGK78LaANxtGSaCf48uwr5ZI
	Ga05ut9Tx/ocuh+5kUbB1QC3zyDkY+cbc+IhLmKfQNw0Ttj9FYHGOji9TKjCPqkZXtHxtXPf+DTYn
	vfH1LN4pEijcn9FR1NGXnS4Xat/pDOp6gbahqSXl63uUouraMLLSMtPP1MHRAHjUhJ1V0DaSkR8/Q
	ftSrpxqKPYNYQFkgyX1QI8r16M0nmupVCEuItCWTEL/RGWosbRY49yLphmrkE9XFLM62CXSfD07pf
	ZylPwi4g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KTO-0000000BeEJ-2UKH;
	Wed, 24 Sep 2025 08:03:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 216BC303002; Wed, 24 Sep 2025 10:03:33 +0200 (CEST)
Message-ID: <20250924080119.271671514@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 24 Sep 2025 09:59:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org,
 rostedt@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 08/12] unwind: Simplify unwind_user_faultable()
References: <20250924075948.579302904@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/unwind/deferred.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -128,17 +128,15 @@ int unwind_user_faultable(struct unwind_
 
 	cache = info->cache;
 	trace->entries = cache->entries;
-
-	if (cache->nr_entries) {
+	trace->nr = cache->nr_entries;
+	if (trace->nr) {
 		/*
 		 * The user stack has already been previously unwound in this
 		 * entry context.  Skip the unwind and use the cache.
 		 */
-		trace->nr = cache->nr_entries;
 		return 0;
 	}
 
-	trace->nr = 0;
 	unwind_user(trace, UNWIND_MAX_ENTRIES);
 
 	cache->nr_entries = trace->nr;



