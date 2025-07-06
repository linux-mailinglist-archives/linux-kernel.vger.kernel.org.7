Return-Path: <linux-kernel+bounces-718948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A953AFA7D9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jul 2025 23:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E7F189A39A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jul 2025 21:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B61E1428E7;
	Sun,  6 Jul 2025 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m0RbrLaC"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CDB1BF58
	for <linux-kernel@vger.kernel.org>; Sun,  6 Jul 2025 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751835924; cv=none; b=laeoZZVLOHKt2j/h+cGAcV36w/QH8GVs/XXlmRt/BDsjg/wknZ/IwDBh+yQweZpb43q1zFs0LLmCQ+KO9GqF5UdHBA2C7IDLD8Srr6WMM8W3Ku/bpyAOF80wKcJKdbaFJNfohl1EHBSyCrbJzPp6517E4cxJHGoGUZ7JtuoQ780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751835924; c=relaxed/simple;
	bh=DQq8YRm3/ytQV12mFqCC31vcZJM2dVv1ItsuEHy3B0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e7f5YVd/6GLsakE014e3447UizBYDbT+e5kGzesQDaWJxgI6nIIiUSfjnlUrqmIIgowzBdTTUc+txy/JnOnP+NoHhq6L8CHPQ9S+oGhKaWNTRh7LMtnMPf/N7WUMzJ5JxJQao92HkNlvGiCdGCKE20AJjh5AiOz3ZXPBPYh0kGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m0RbrLaC; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f870e739-bbe7-4260-a847-1035f1c5b801@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751835910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cV4Rqtm91hjKif3BbwFfQH+ZWTX/llutJehbPJVtTUY=;
	b=m0RbrLaC9J8wxVcsEOtPnrCxYg7n7xp3elDOgNGnmrulrGJuxlwTIdtyz4dLifXV7RRYyf
	7++v/Km428YPzyKEWrrkoJyCyHiHgDbCQRVsE75A2y61WpLTU7/Mx6/vicfGxc/YaPYZbV
	3obKG5C5LLwUz/QoIsRzUnKCK5HY9ws=
Date: Sun, 6 Jul 2025 14:04:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] WARNING in rxe_skb_tx_dtor
To: syzbot <syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com>,
 jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <6865d59b.a70a0220.5d25f.0781.GAE@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <6865d59b.a70a0220.5d25f.0781.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/2 17:58, syzbot 写道:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Today I made tests with rdma-core after this patch is applied on the 
linux upstream. All the test cases in rdma-core can pass successfully.

I will send this commit out based on the rdma next repository.

Zhu Yanjun

> 
> Reported-by: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com
> Tested-by: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         6f8d023e RDMA/rxe: Fix rxe_skb_tx_dtor problem
> git tree:       https://github.com/zhuyj/linux.git v6.16_fix_rxe_skb_tx_dtor
> console output: https://syzkaller.appspot.com/x/log.txt?x=13973770580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=36b0e72cad5298f8
> dashboard link: https://syzkaller.appspot.com/bug?extid=8425ccfb599521edb153
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> 
> Note: no patches were applied.
> Note: testing is done by a robot and is best-effort only.


