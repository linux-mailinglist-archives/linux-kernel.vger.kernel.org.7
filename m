Return-Path: <linux-kernel+bounces-756622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FDFB1B6E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A592B3B5FB8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782AA27933F;
	Tue,  5 Aug 2025 14:55:14 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646472264A0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754405714; cv=none; b=k3YIKmRY6vNLa7iSVArYP/lg4tsiDBzC0ptH3SiRLVq0kZEXk2MlLnTslITf5NKpen+wbu8NDhiyvhXNRLSQJ9+bf007xNDbyEig8LIvR8O0TWWwfxdBEQuAvIoyQjxQHf8Xvbl9eGe+JCjHZHLse55ZF3Bu8ZShlSdX1SmET34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754405714; c=relaxed/simple;
	bh=yelDPjfGZ0GU+7KgGEsKbC7zBuLGWWs0DGXI2TxJ5oQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJSPRsSgdalCgSiOm1zmI8h4KYjI1dh4dl4WdSDrW7qNSdo9yO94WtqcuOpTgDmOmJpM4BQZDAEYKUS8FulreXiH6FV7BPepnKcJeFsJ1W+Guo+jseTmb9CmFy2Fi1TAPO16LzGJPJn3hKYWasEiFoiIbw+h52Ygonp+MTPh/hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4bxGbl51hszYlngv;
	Tue,  5 Aug 2025 22:52:03 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 5 Aug
 2025 22:55:04 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 5 Aug
 2025 22:55:04 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <akpm@linux-foundation.org>, <andrealmeid@igalia.com>,
	<dave@stgolabs.net>, <dvhart@infradead.org>, <feng.han@honor.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <liulu.liu@honor.com>,
	<mingo@redhat.com>, <npache@redhat.com>, <peterz@infradead.org>,
	<rientjes@google.com>, <shakeel.butt@linux.dev>, <tglx@linutronix.de>,
	<zhongjinji@honor.com>
Subject: Re: [[PATCH v2] 2/2] futex: Only delay OOM reaper for processes using robust futex
Date: Tue, 5 Aug 2025 22:55:00 +0800
Message-ID: <20250805145500.29079-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <aJGiHyTXS_BqxoK2@tiehlicka>
References: <aJGiHyTXS_BqxoK2@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w002.hihonor.com (10.68.28.120) To a018.hihonor.com
 (10.68.17.250)

> On Mon 04-08-25 14:01:40, Michal Hocko wrote:
> > On Mon 04-08-25 19:50:37, zhongjinji wrote:
> > > >On Fri 01-08-25 23:36:49, zhongjinji@honor.com wrote:
> > > >> From: zhongjinji <zhongjinji@honor.com>
> > > >> 
> > > >> After merging the patch
> > > >> https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u,
> > > >> the OOM reaper runs less frequently because many processes exit within 2 seconds.
> > > >> 
> > > >> However, when a process is killed, timely handling by the OOM reaper allows
> > > >> its memory to be freed faster.
> > > >> 
> > > >> Since relatively few processes use robust futex, delaying the OOM reaper for
> > > >> all processes is undesirable, as many killed processes cannot release memory
> > > >> more quickly.
> > > >
> > > >Could you elaborate more about why this is really needed? OOM should be
> > > >a very slow path. Why do you care about this potential improvement in
> > > >that situation? In other words what is the usecase?
> > > 
> > > Well, We are using the cgroup v1 freezer. When a frozen process is
> > > killed, it cannot exit immediately and is blocked in __refrigerator until
> > > it is thawed. When the process cannot be thawed in time, it will result in 
> > > increased system memory pressure.
> > 
> > This is an important information to be part of the changelog! It is also
> > important to note why don't you care about processes that have robust
> > mutexes. Is this purely a probabilistic improvement because those are
> > less common?
> > 
> > TBH I find this to be really hackish and justification based on cgroup
> > v1 (which is considered legacy) doesn't make it particularly appealing.
> 
> Btw. have you considered to simply not impose any delay for _all_ frozen
> tasks?
 
Thank you, it seems like a good idea. I will try it.

