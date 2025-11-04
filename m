Return-Path: <linux-kernel+bounces-884844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 083FDC314C0
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E0CF4F07AA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAF03218B8;
	Tue,  4 Nov 2025 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="485pWYjv"
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FBA19E968
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264124; cv=none; b=eTFoCr6bt1icdtvKodGw/Qt1z+Kds7lMIMg7yw16LUvqPBe4PqTGfLGwOvIazC4b9wb/oic43elif1gDgsBrUmTULoqeAbxNtPj23IPcUKLiDHrDcZvmyIL1Yyjbgo20b68STBEgXV0k1/+0BhFg7hvrXMeWdGqVhtW0xVswlkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264124; c=relaxed/simple;
	bh=3/OARezs29eUq90xKny6FQe3l9UwiuCpXkYqxg2+/iY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgKYPqkPInZ6VNYfN9w84d5CiCXCUCneYbCN+uLYH8hQiOzaXAd2RWo+EoF0B9j3NWXefsBNJ7aYna9hU64Kia6+3cme4dS8YdXGTAuL/bHJu14N2YsMehyiAQyfzn4P9RB24dAte37sklLEdBsOdrk5npX9tPbeSmpMtk46HcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=485pWYjv; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3/OARezs29eUq90xKny6FQe3l9UwiuCpXkYqxg2+/iY=;
	b=485pWYjvuZXFV9mKiWgarmKxkGqcVR6VQWU2toTQMryKr2Ccu9GXeoCSUTGB9tmbqKoCpniXy
	I+RSyrWRIamnsSyRhH5kbEOoRupCQmkdnbybmsLNDjkuvrFDBpROPDmUvLZ+CmZ8iM4HeydHHQC
	MM1lAeLT19FUO479+LA7qEA=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4d18rj1mzYz1prL4;
	Tue,  4 Nov 2025 21:47:01 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B967180B69;
	Tue,  4 Nov 2025 21:48:36 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 21:48:35 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <david@kernel.org>
CC: <Liam.Howlett@oracle.com>, <akpm@linux-foundation.org>, <ardb@kernel.org>,
	<arnd@arndb.de>, <dave@vasilevsky.ca>, <david@redhat.com>,
	<ebiggers@kernel.org>, <kees@kernel.org>, <liaohua4@huawei.com>,
	<lilinjie8@huawei.com>, <linmiaohe@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux@armlinux.org.uk>, <lorenzo.stoakes@oracle.com>,
	<mhocko@suse.com>, <nao.horiguchi@gmail.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <rmk+kernel@armlinux.org.uk>, <rostedt@goodmis.org>,
	<rppt@kernel.org>, <surenb@google.com>, <vbabka@suse.cz>, <will@kernel.org>,
	<xieyuanbin1@huawei.com>
Subject: Re: [RFC PATCH 1/2] ARM: mm: support memory-failure
Date: Tue, 4 Nov 2025 21:48:31 +0800
Message-ID: <20251104134831.147584-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <e323f1f3-f543-4e81-af6b-243fcf9ba750@kernel.org>
References: <e323f1f3-f543-4e81-af6b-243fcf9ba750@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Mon, 3 Nov 2025 17:53:18 +0100, David Hildenbrand wrote:
> Can you go into more details which exact functionality in
> memory-failure.c you would be interested in using?
>
> Only soft-offlining or also the other (possibly architecture-specific)
> handling?

Thanks! Let me describe it in as much detail as possible.

The functions in memory-failure.c are currently used in three ways:
1. When the application is using memory, and ECC detects a UE
(Uncorrectable Errors) bit flip from DRAM (the detection is performed by
hardware and is not perceived by software), it reports an interrupt to the
CPU. The relevant driver (a third-party module) has already
registered the interrupt callback function.
Based on the configuration, the driver calls `memory_failure_queue()`
inside callback function, or wakes up the related kthread to call
`soft_offline_page()`/`memory_failure()` to take the affected memory
offline or kill the process.

2. Hardware memory scanning function: The hardware periodically performs
read/write tests on some memory (This hardware is not a standard hardware,
so it is not included in the ARM spec. The scanning is not perceived by
software) If bit flip is detected during the test, an interrupt is
reported to the operating system to do the memory-failure,
just like what described earlier.

3. Software memory scanning function: The software (such as kthread/
work-queue) periodically use `soft_offline_page()` to isolate some free
memory and performs read/write tests. If bit flip is detected during the
test, it is considered a failure, and the memory will not be recovered.
Otherwise, use `unpoison_memory()` to recover the memory.

Unfortunately, the driver code for these three methods is difficult to
open-source. I have also been thinking about whether there is a
general-purpose function that could use memory-failure, but I haven't
come up with a good idea yet.

> Cheers
>
> David

Thanks!

Xie Yuanbin

