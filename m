Return-Path: <linux-kernel+bounces-788270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8DCB38204
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D173683AE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DB2303C81;
	Wed, 27 Aug 2025 12:14:53 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79923009E7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296892; cv=none; b=D0qbDp04v0yZmYmDS2iK9sY+TuYYCxJ8c1zwojnOqyX2ilYOCEQ6JTSY9Hnl94ypSfLmq9R4xdRV4/N9wzqF08rth3zfPL7mVfxu+GoW2pHUc4TgSaA8wbbznAeG06CyaV9hX9dJKMYFFp15qg4AxFD0+5uaIq/7xtB+m+t6FEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296892; c=relaxed/simple;
	bh=c08bYXeQBDX62Nt7WW/4Z4NM1uIjvu+SJ5vsSbMTwR4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqaS0a3tnybuAfUjyEY//e3hBOXzhOHhJ3rg+MC+BGAY5pxh0BX63bpW8TTQRmCLznCVWV438tVSVmRWjSG9pRxoU9vuJ+Usob7czFuT6N2gNfum7zNz+kx6yNHMJwkM1c/2N6uXgR0iyw52HnpcM9qv4lrytgOcK1wsoK+lSU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w013.hihonor.com (unknown [10.68.26.19])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4cBk3h0zcJzYlHYL;
	Wed, 27 Aug 2025 20:14:24 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w013.hihonor.com
 (10.68.26.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 27 Aug
 2025 20:14:41 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 27 Aug
 2025 20:14:40 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <akpm@linux-foundation.org>, <feng.han@honor.com>,
	<liam.howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <liulu.liu@honor.com>, <lorenzo.stoakes@oracle.com>,
	<rientjes@google.com>, <shakeel.butt@linux.dev>, <tglx@linutronix.de>,
	<zhongjinji@honor.com>
Subject: Re: [PATCH v5 1/2] mm/oom_kill: Do not delay oom reaper when the victim is frozen
Date: Wed, 27 Aug 2025 20:14:36 +0800
Message-ID: <20250827121436.10795-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <aK71W1ITmC_4I_RY@tiehlicka>
References: <aK71W1ITmC_4I_RY@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w002.hihonor.com (10.68.28.120) To a018.hihonor.com
 (10.68.17.250)

> On Mon 25-08-25 21:38:54, zhongjinji wrote:
> > The OOM reaper can quickly reap a process's memory when the system
> > encounters OOM, helping the system recover. If the victim process is
> > frozen and cannot be unfrozen in time, the reaper delayed by two seconds
> > will cause the system to fail to recover quickly from the OOM state.
> > 
> > When an OOM occurs, if the victim is not unfrozen, delaying the OOM reaper
> > will keep the system in a bad state for two seconds. Before scheduling the
> > oom_reaper task, check whether the victim is in a frozen state. If the
> > victim is frozen, do not delay the OOM reaper.
> 
> I do not think this changelog captures the essence of the change really
> well and it suggests that this might be a performance optimization. As I
> have explained on several occasions the oom reaper is not meant to be a
> performance optimization but rather a forward progress guarantee. I
> would suggest this wording instead.
> 
> "
> The oom reaper is a mechanism to guarantee a forward process during OOM
> situation when the oom victim cannot terminate on its own (e.g. being
> blocked in uninterruptible state or frozen by cgroup freezer). In order
> to give the victim some time to terminate properly the oom reaper is
> delayed in its invocation. This is particularly beneficial when the oom
> victim is holding robust futex resources as the anonymous memory tear
> down can break those.
> 
> On the other hand deliberately frozen tasks by the freezer cgroup will
> not wake up until they are thawed in the userspace and delay is
> effectively pointless. Therefore opt out from the delay for cgroup
> frozen oom victims.
> "

Thank you, I will update it.

> 
> Thanks!
> -- 
> Michal Hocko
> SUSE Labs

