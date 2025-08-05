Return-Path: <linux-kernel+bounces-756467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F333B1B4BF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1DFB3A77C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D341275AE6;
	Tue,  5 Aug 2025 13:19:18 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C629F27584D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399957; cv=none; b=A1tsv3HCgzY/2nx5yU+0O9pKGn33FDIGJN/JzTld0ph8TeBS3w/1tu184Eh8vaRMX4fBfGVp4cLnk+UpIZluaKcrcxuUNUMG9nto2IAZxyAMBbVsONqAFSe61YHC33IRZca6H4DCXY+gy+VTreMLhhHgVuX6LP2Hcbr7tfMfAi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399957; c=relaxed/simple;
	bh=jZu3Ja/n3q2HhBA/RPQa6Fol8dxKXQ79tEfAFjFO8jc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLHfrTym+C6rUSLRrWTYgWlqBk0b+w20SXMnL0FODrGwZJTAHHDoQCv8Sx83EMNgSQhec+TFZ0ycOUdcBpeq3H2pArJG00bLSH3c/maoh4tlXNxWurhzWT2k6O46RzdddA0+lpog212BujxWZ2iQCsRIZ1ZqWXqRA+rKHug5PTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4bxDT02JhkzYl4n0;
	Tue,  5 Aug 2025 21:16:04 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 5 Aug
 2025 21:19:05 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 5 Aug
 2025 21:19:04 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <akpm@linux-foundation.org>, <andrealmeid@igalia.com>,
	<dave@stgolabs.net>, <dvhart@infradead.org>, <feng.han@honor.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <liulu.liu@honor.com>,
	<mingo@redhat.com>, <npache@redhat.com>, <peterz@infradead.org>,
	<rientjes@google.com>, <shakeel.butt@linux.dev>, <tglx@linutronix.de>,
	<zhongjinji@honor.com>
Subject: Re: [[PATCH v2] 2/2] futex: Only delay OOM reaper for processes using robust futex
Date: Tue, 5 Aug 2025 21:19:00 +0800
Message-ID: <20250805131900.17075-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <aJChI-LMwmuWEwpH@tiehlicka>
References: <aJChI-LMwmuWEwpH@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w002.hihonor.com (10.68.28.120) To a018.hihonor.com
 (10.68.17.250)

>On Mon 04-08-25 19:50:37, zhongjinji wrote:
>> >On Fri 01-08-25 23:36:49, zhongjinji@honor.com wrote:
>> >> From: zhongjinji <zhongjinji@honor.com>
>> >> 
>> >> After merging the patch
>> >> https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u
>> >> the OOM reaper runs less frequently because many processes exit within 2 seconds.
>> >> 
>> >> However, when a process is killed, timely handling by the OOM reaper allows
>> >> its memory to be freed faster.
>> >> 
>> >> Since relatively few processes use robust futex, delaying the OOM reaper for
>> >> all processes is undesirable, as many killed processes cannot release memory
>> >> more quickly.
>> >
>> >Could you elaborate more about why this is really needed? OOM should be
>> >a very slow path. Why do you care about this potential improvement in
>> >that situation? In other words what is the usecase?
>> 
>> Well, We are using the cgroup v1 freezer. When a frozen process is
>> killed, it cannot exit immediately and is blocked in __refrigerator until
>> it is thawed. When the process cannot be thawed in time, it will result in 
>> increased system memory pressure.
>
>This is an important information to be part of the changelog! It is also

sorry, I will update those infos in next version.

>important to note why don't you care about processes that have robust
>mutexes. Is this purely a probabilistic improvement because those are
>less common?

Yes, My device runs Android. I added a log in futex_cleanup when a
process has a robust list, But I have never seen any process on Android
having robust mutexes.

>TBH I find this to be really hackish and justification based on cgroup
>v1 (which is considered legacy) doesn't make it particularly appealing.

It seems hackish to check the robust_list during the oom kill, and it
is also hard to see the relationship between the robust_list and the 
OOM killer from this change. However, it is indeed a simple way to
decide whether to delay the oom reaper.
Would it be better to use a function name like unreap_before_exit or
unreap_before_all_exit instead of check_robust_futex?


