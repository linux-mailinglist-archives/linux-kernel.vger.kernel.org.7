Return-Path: <linux-kernel+bounces-777479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D980B2D9EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DA2F4E289D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F8A2749C2;
	Wed, 20 Aug 2025 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b="CBAjhmSF"
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 7DC602D9EE0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755685162; cv=none; b=n6ONTaMVdyvDt5HLA5DT7QHEZTyRqNVw5mBAt4wgnDlGUDSNL5UWkUGo0mBP7hhsEZ4W63E7nQBucWuhdFVwubxZAIhAnrAJ3kFV1meQVqzoxhhpw9mP7HAjmX83VKYEB6j13XJN6A9xriJZGroBuf8QGd3OZUZNvWPhgJl/sRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755685162; c=relaxed/simple;
	bh=8R57zviloCLKjnwcDGUINGdKeCAknIoYrQGHcRS6u7o=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O072wIkM+ItG3OxAXLpJIUYxT2ZAaBUQbHaMwi8nsZDsGdkJbITmlY5sAcySqQ6PGVEsuBCWgG5Q9oisLohWfivXzMVBBMtAehYmUGT8KDnNkif56lPoY9lQKXuzw+osBAyLfJac5sI8nSQ/7Hb5v8ZqrbUA2SKedF0LUcaCvSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; dkim=pass (1024-bit key) header.d=didiglobal.com header.i=@didiglobal.com header.b=CBAjhmSF; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.19])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id C586418080F17A;
	Wed, 20 Aug 2025 18:18:03 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.71.102) by
 BJ02-ACTMBX-01.didichuxing.com (10.79.65.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 20 Aug 2025 18:18:54 +0800
Date: Wed, 20 Aug 2025 18:18:46 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.19
From: Tio Zhang <tiozhang@didiglobal.com>
To: <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <tiozhang@didiglobal.com>,
	<zyhtheonly@gmail.com>, <zyhtheonly@yeah.net>
Subject: [PATCH] fork: remove #ifdef CONFIG_LOCKDEP in copy_process()
Message-ID: <20250820101826.GA2484@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	zyhtheonly@gmail.com, zyhtheonly@yeah.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BJ03-PUBMBX-01.didichuxing.com (10.79.71.11) To
 BJ02-ACTMBX-01.didichuxing.com (10.79.65.19)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=didiglobal.com;
	s=2025; t=1755685095;
	bh=jmDRQ7mALkgnPpAzC0uNEbUjI56GDSMJ8bcTnl4R62M=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type;
	b=CBAjhmSFFW7Qvn+IJtDg6ae6heVIu6o5AwfbLfZc0p7APFBrsNRrBV4BEiCJYQEQE
	 E2l3KceQmdbmbfIePRdPlSZzBjJV7+2YT+boss92eYYRr2i5KlI0kRshGqByBlWIU8
	 ghWZrifIMrdlIyS2Rg2Yo4dXkXGipu99chkv1BuM=

lockdep_init_task() is defined as an empty when
CONFIG_LOCKDEP is not set.
So the #ifdef here is redundant, remove it.

Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
---
 kernel/fork.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index af673856499d..e06cfaa85a84 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2124,9 +2124,7 @@ __latent_entropy struct task_struct *copy_process(
 
 	p->pagefault_disabled = 0;
 
-#ifdef CONFIG_LOCKDEP
 	lockdep_init_task(p);
-#endif
 
 	p->blocked_on = NULL; /* not blocked yet */
 
-- 
2.39.3 (Apple Git-145)


