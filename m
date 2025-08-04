Return-Path: <linux-kernel+bounces-755061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B05B1A0BF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EFFA3BD958
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96465257AEE;
	Mon,  4 Aug 2025 11:50:47 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D7F22D7B6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754308247; cv=none; b=Ky/eFFCnifsUOI36df9ZE1Zw95QRdPaNNJVW/BOGf+h/957OO4AZ+OZGwPBOp++1G88YZuqHphyMwDWazfUy/ptP7z5fgsOxLaJWUkqnXAfCXM+WxhOGzevlHxI5bHNBKKcyYmHkGeriQdGe/Z+lK94CncAILXkYtEImcZ5ohA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754308247; c=relaxed/simple;
	bh=r4+XJv2ekZZ72IOq/zDVrMGNgoXs45E46HerLQ/SbNU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQXgz4dU1I3Z2aSCoJfTnR0PORw2G9zxSN6UHf0cGJE8/1OXWJyNESyG/bVZ8PtOSjUeCOCOrFTKgZq2326SV3NvgkvGAdAVMII67c5erpzcERzxc0OANhotEysS9J1O5NHg6fX34t0MhzC183HCNdmXuxAInXG4KhaHPkzjWvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4bwZYV2Mn9zYm5N0;
	Mon,  4 Aug 2025 19:47:42 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 4 Aug
 2025 19:50:42 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 4 Aug
 2025 19:50:42 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <akpm@linux-foundation.org>, <andrealmeid@igalia.com>,
	<dave@stgolabs.net>, <dvhart@infradead.org>, <feng.han@honor.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <liulu.liu@honor.com>,
	<mingo@redhat.com>, <npache@redhat.com>, <peterz@infradead.org>,
	<rientjes@google.com>, <shakeel.butt@linux.dev>, <tglx@linutronix.de>,
	<zhongjinji@honor.com>
Subject: Re: [[PATCH v2] 2/2] futex: Only delay OOM reaper for processes using robust futex
Date: Mon, 4 Aug 2025 19:50:37 +0800
Message-ID: <20250804115037.19690-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <aJBKijr1nR1CleBL@tiehlicka>
References: <aJBKijr1nR1CleBL@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w002.hihonor.com (10.68.28.120) To a018.hihonor.com
 (10.68.17.250)

>On Fri 01-08-25 23:36:49, zhongjinji@honor.com wrote:
>> From: zhongjinji <zhongjinji@honor.com>
>> 
>> After merging the patch
>> https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u,
>> the OOM reaper runs less frequently because many processes exit within 2 seconds.
>> 
>> However, when a process is killed, timely handling by the OOM reaper allows
>> its memory to be freed faster.
>> 
>> Since relatively few processes use robust futex, delaying the OOM reaper for
>> all processes is undesirable, as many killed processes cannot release memory
>> more quickly.
>
>Could you elaborate more about why this is really needed? OOM should be
>a very slow path. Why do you care about this potential improvement in
>that situation? In other words what is the usecase?

Well, We are using the cgroup v1 freezer. When a frozen process is
killed, it cannot exit immediately and is blocked in __refrigerator until
it is thawed. When the process cannot be thawed in time, it will result in 
increased system memory pressure.


