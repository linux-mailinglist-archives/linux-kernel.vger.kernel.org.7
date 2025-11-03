Return-Path: <linux-kernel+bounces-883063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 883BBC2C653
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3472B34A6CE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EFA30F813;
	Mon,  3 Nov 2025 14:24:42 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA80C2459C6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179882; cv=none; b=dFvR9PcI1hdYhL2Wrqr+f4EuFD5zhx/LdTlpR880eHwwstjVwZt67nS6urItSypXRSou4LvhbUHveOazU2/401Ca1xb1zAWItKmyi/W0KWgvT0pNQSEvzEsvFDgN3uy+xD3PoT5aiYbz0S6jvP07+PTNS8grhaXZrw3ZHc/3bb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179882; c=relaxed/simple;
	bh=cyM4AzO0A6rUekqlRLbCNAuSnjDEOwx7myGCyFBJzjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=duk5yRG+LDMTQn53wlHoPAux8eWhNZEydseYeMeO+WcPkWE2DzBf9xt0qPdUKKIE4Y5B9anIyVA7QS4Ha1Fs2aai2pJRhbfcd2ycgC+jweS3EEsbgHIUDrWvBEhWnAgJbLZf70qGah9JNw3HeInbP1tNAHRXVkXcH7uXFJHGHBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5A3EOYEI036852;
	Mon, 3 Nov 2025 23:24:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5A3EOYFN036849
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 3 Nov 2025 23:24:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e7958eb8-05f8-48a7-ae71-bc15af6abcf2@I-love.SAKURA.ne.jp>
Date: Mon, 3 Nov 2025 23:24:33 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [crypto?] possible deadlock in padata_do_serial
To: syzbot <syzbot+bd936ccd4339cea66e6b@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <6860c5d3.a00a0220.c1739.0009.GAE@google.com>
 <68c34150.050a0220.3c6139.0045.GAE@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <68c34150.050a0220.3c6139.0045.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav403.rs.sakura.ne.jp

#syz test

diff --git a/kernel/padata.c b/kernel/padata.c
index f4def028c48c..d2dce316e607 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -253,7 +253,7 @@ static struct padata_priv *padata_find_next(struct parallel_data *pd, int cpu,
 
 	reorder = per_cpu_ptr(pd->reorder_list, cpu);
 
-	spin_lock(&reorder->lock);
+	spin_lock_nested(&reorder->lock, 1);
 	if (list_empty(&reorder->list))
 		goto notfound;
 


