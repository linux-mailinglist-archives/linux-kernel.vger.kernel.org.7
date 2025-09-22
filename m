Return-Path: <linux-kernel+bounces-826883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2DDB8F8BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010FB42179C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC1430C361;
	Mon, 22 Sep 2025 08:29:12 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AB130C359
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529752; cv=none; b=bPHvPeb6GlAQMe4a5tlqmAJoaoGCSbjKLNv9wHW3+SBWid3kgLt4WeIaN1rTYWNT1DrQSe8xhNCQTFFQV5ipdLc/WjckXmxkLF/2Kx1eocjN5r1hYNSJ1ngVSgyaawU5nQgs/O545RwMOHiq4u+WcV4jzrpVuvz2qZF3ewbZCPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529752; c=relaxed/simple;
	bh=BMMk8js8DlXGWjrIYIjSUpVxF9gNtUyoQmQlNbWXboo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkEq6ZG9Dv+8io7nbTj1TwcFbEsoAEGq60gXDBN4IsxG//S36cKEA1Vp0u94a1ipvD0aXgoynq1rK3S/0bJ98pyYoL8mRwTaFSYZ8cPE5nFnfq49QQJHWMohiNVfRqcXAWUCrMA9ZKeA7NLBxpHw4YL0Ki/c/qB3IlUP3Qy9igU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cVbkP0p5tzddGH;
	Mon, 22 Sep 2025 16:24:29 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id ECF3F180486;
	Mon, 22 Sep 2025 16:29:06 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.108.232) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Sep 2025 16:29:05 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <arnd@arndb.de>
CC: <Liam.Howlett@oracle.com>, <akpm@linux-foundation.org>, <ardb@kernel.org>,
	<dave@vasilevsky.ca>, <david@redhat.com>, <ebiggers@kernel.org>,
	<kees@kernel.org>, <liaohua4@huawei.com>, <lilinjie8@huawei.com>,
	<linmiaohe@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux@armlinux.org.uk>, <lorenzo.stoakes@oracle.com>, <mhocko@suse.com>,
	<nao.horiguchi@gmail.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<rmk+kernel@armlinux.org.uk>, <rostedt@goodmis.org>, <rppt@kernel.org>,
	<surenb@google.com>, <vbabka@suse.cz>, <will@kernel.org>,
	<xieyuanbin1@huawei.com>
Subject: Re: [RFC PATCH 1/2] ARM: mm: support memory-failure
Date: Mon, 22 Sep 2025 16:28:43 +0800
Message-ID: <20250922082843.26722-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <727caa4f-5be5-4b59-a10e-8dc9bbc384bf@app.fastmail.com>
References: <727caa4f-5be5-4b59-a10e-8dc9bbc384bf@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj100009.china.huawei.com (7.202.194.3)

> It would be helpful to be more specific about what you
> want to do with this.
> 
> Are you working on a driver that would actually make use of
> the exported interface?

Thanks for your reply.

Yes, In fact, we have developed a hardware component to detect DDR bit
transitions (software does not sense the detection behavior). Once a bit
transition is detected, an interrupt is reported to the CPU.

On the software side, we have developed a driver module ko to register
the interrupt callback to perform soft page offline to the corresponding
physical pages.

In fact, we will export `soft_offline_page` for ko to use (we can ensure
that it is not called in the interrupt context), but I have looked at the
code and found that `memory_failure_queue` and `memory_failure` can also
be used, which are already exported.

> I see only a very small number of
> drivers that call memory_failure(), and none of them are
> usable on Arm.

I think that not all drivers are in the open source kernel code.
As far as I know, there should be similar third-party drivers in other
architectures that use memory-failure functions, like x86 or arm64.
I am not a specialist in drivers, so if I have made any mistakes,
please correct me.

Xie Yuanbin

