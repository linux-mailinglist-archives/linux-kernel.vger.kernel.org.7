Return-Path: <linux-kernel+bounces-830096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F39B98B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537EE4A7AC3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE703280A2C;
	Wed, 24 Sep 2025 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LL3km+It"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B3923506F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701017; cv=none; b=f1xAZXEi17PQkOrjNZdPkTvatFoqIQ0lXVp5QZdLTChV/zO2ep8m0o3LsKTbKJi90ItTmtLu/9BikweIyMl1+wd/37GmObJElr2D5K9MJhEsD8a1/hLSne9niRB26ECxaVlQcd0cI7+pyuMc9CSYf6MfDRbW7fNk6DLewLCF6yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701017; c=relaxed/simple;
	bh=81G3ehiC2XjLqQUYUmv++p6b+oE6dZ6FqhexIoz5X5E=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RJP2CG5UrWr+5T7Sg2u9MOMeQpdTvKv2TkpsO9fzlrdHqauf0LhaVVowJPGFrqwwd/BaLZ8Jnnhm3GGlLeDRJb/FTHMoMAts3YzjbpDWoORDdkMtB3VZ5ejsh45Ldyzj+Z/yJnfBkUEjdZbMsIYQZH2KeGPduOtWmDoGqnYPHP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LL3km+It; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=jPl2PJPpsUjXGW4y5gOPBSspzLqtyrK1u2yYfSklgn8=; b=LL3km+ItppXBmfG7pT/LUWWaY0
	i4xVEbILSsJ9XF0Nf6rzku9Iq1RVd3U5uDMcjFNdPl0z7qYxscRnpTWha68oxu3zSwnAoAYH80RMM
	rEyZnENEmK+sGlAOUBRxrGtqE3VUTtZaLLJE1ojYsLcFOcH0+4vLz1FQJFWY/3b6TxnNHSwPTggVa
	VmwUb9S6fK9oq6a3tBq1vjrTDazXX3U2vvxepsVPE870dCJ9kUDhYD1Sr7qJNeN0S3NlGsULjC/Lk
	0lTkASoxVylJB7BGoXJkvYFDvypZTzXd8AVN48ymoYdZ+3zaWp2M49+EVIPOjYHpXMrBJ6SF5TH0G
	1IOev7Zw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KTN-00000008iB0-21dT;
	Wed, 24 Sep 2025 08:03:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 0AA23302D93; Wed, 24 Sep 2025 10:03:33 +0200 (CEST)
Message-ID: <20250924080118.665787071@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 24 Sep 2025 09:59:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org,
 rostedt@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 03/12] unwind: Add required include files
References: <20250924075948.579302904@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

To be self sufficient, the file needs to include linux/types.h. This
provides things like u32/u64 and struct callback_head.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/unwind_deferred_types.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 
+#include <linux/types.h>
+
 struct unwind_cache {
 	unsigned long		unwind_completed;
 	unsigned int		nr_entries;



