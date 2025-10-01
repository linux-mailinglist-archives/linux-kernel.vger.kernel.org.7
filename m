Return-Path: <linux-kernel+bounces-839651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09484BB215B
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 01:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88A34C1855
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 23:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F263C27B4EB;
	Wed,  1 Oct 2025 23:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="cjHhxGUT"
Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888A154918
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 23:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759362547; cv=none; b=KnGM97XhTRFSC9R2f3HtZ1V1Dt9JscRiO2gSefE2T7JFfuYE3S4Le3IKIcDqvq0wqxoX2IhP/JDIO7cp8w9N/IpilsODZJ0TGZRrE+qPdKNKhbSgVr9Ys06NKInBL7GSVT3VEffAQLe8fn9UPD4+00afiYTlqvPeHyNn6bvSIdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759362547; c=relaxed/simple;
	bh=ZGVK/tjvx8a/Obw+A6g3fTAfpXgwUTb6bL5m3LfKQF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZ+LDbvaIAHdJCMYX++fwo/UmgY2vQzvGDSEm60S4lNuKsT+g/ty2PF/MIHETqqm3tB5v8bQEyKv0rt7fArSYQDLqibhfeQWvHEXkTNdLm90P3g1xdRDDd/vgGAdStNX4JA3Hb0Sw4KXqhJWjd2uI8QPDiMoXoPoycxQfiAdmM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=cjHhxGUT; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1759362542;
	bh=yZQWondl07akNaSbykBePufOpb6YbJS3NJLe/Pq4A5Y=;
	h=From:Subject:Date:Message-ID;
	b=cjHhxGUT20E8FPWa0bNCgmEqcHwqlvj09iYz8srB7R9rW9Il4Il1CjvAdvYYKyzJx
	 6EYT7T7w4Ez0ynpJkbVAfviO+WEm1meebJSzZUfFh8fw6tMJ7vyB2MlL0Eur2ovKhu
	 EuwY0WDqOkQ0ayJjY7UrOLGYB3Ax5dAmN60BCYuk=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68DDBDC600002D15; Wed, 2 Oct 2025 07:48:24 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5327776685137
X-SMAIL-UIID: FC1CA3AB1CD149779B717C7E815BC1F3-20251002-074824-1
From: Hillf Danton <hdanton@sina.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/4] mm/page_alloc: Perform appropriate batching in drain_pages_zone
Date: Thu,  2 Oct 2025 07:48:13 +0800
Message-ID: <20251001234814.7896-1-hdanton@sina.com>
In-Reply-To: <20251001153717.2379348-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  1 Oct 2025 08:37:16 -0700 Joshua Hahn wrote:
> 
> While I definitely agree that spreading out 1TB across multiple NUMA nodes
> is an option that should be considered, I am unsure if it makes sense to
> dismiss this issue as simply a misconfiguration problem.
> 
> The reality is that these machines do exist, and we see zone lock contention
> on these machines. You can also see that I ran performance evaluation tests
> on relatively smaller machines (250G) and saw some performance gains.
> 
If NUMA node could not be an option, there is still much room in the zone types
for adding new zones on top of the current pcp and zone mechanism to mitigate
zone lock contention, see diff below. Then the issue falls in the config category.

> The other point that I wanted to mention is that simply adding more NUMA
> nodes is not always strictly beneficial; it changes how the scheduler
> has to work, workloads would require more numa-aware tuning, etc.

Feel safe to sit back with Netflix on as PeterZ is taking care of NUMA nodes
and eevdf, haha.

--- x/include/linux/mmzone.h
+++ y/include/linux/mmzone.h
@@ -779,6 +779,9 @@ enum zone_type {
 #ifdef CONFIG_ZONE_DMA32
 	ZONE_DMA32,
 #endif
+#ifdef CONFIG_ZONE_EXP
+	ZONE_EXP0, ZONE_EXP1, ZONE_EXP2, /* experiment */
+#endif
 	/*
 	 * Normal addressable memory is in ZONE_NORMAL. DMA operations can be
 	 * performed on pages in ZONE_NORMAL if the DMA devices support

