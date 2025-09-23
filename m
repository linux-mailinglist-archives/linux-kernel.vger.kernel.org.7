Return-Path: <linux-kernel+bounces-828206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F377CB942C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2A816C138
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C1227381F;
	Tue, 23 Sep 2025 04:10:25 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32183AD5A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758600625; cv=none; b=Ieg9FjwTpz30IaJsShfXGRodtdfFi4B1h/JU/6pFIjjm12uT/oEHdZ4Zet+cQuKWHLFMKw2cAtc4qa/NFz0TQ8iqM58dL1Rzv7HSGIxYPRCVq7B54m4ZhE8NLrujxPZFF859k2+x8onqWv+aJKDi54El48Gl8UwIXYXuh3nOuUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758600625; c=relaxed/simple;
	bh=DCSwt1IsfVly5T/2MV76YHppCE2j0ni5IpDIvlW7YDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQivACgRoOrNoLqbrfiyHJ5zRKQcW6tgnNfnuC0k4pBM9iBX2dEbR/84ZpFxmtN03pB8282ynLzYchmHZDb+jJ1WHW4ee+a11if5oFb9j/MU5VaNbPXCW08z2lFV7R5sQJksQv1Iz3I0nzrp1CnkzPv/t8G8lHViHj90aaEL/L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cW5x869rMzddRl;
	Tue, 23 Sep 2025 12:05:32 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 178EE147E9C;
	Tue, 23 Sep 2025 12:10:11 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.108.232) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Sep 2025 12:10:09 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <linux@armlinux.org.uk>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<linmiaohe@huawei.com>, <nao.horiguchi@gmail.com>,
	<rmk+kernel@armlinux.org.uk>, <ardb@kernel.org>, <nathan@kernel.org>,
	<ebiggers@kernel.org>, <arnd@arndb.de>, <rostedt@goodmis.org>,
	<kees@kernel.org>, <dave@vasilevsky.ca>, <peterz@infradead.org>
CC: <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <liaohua4@huawei.com>,
	<lilinjie8@huawei.com>, <xieyuanbin1@huawei.com>
Subject: Re: [RFC PATCH 1/2] ARM: mm: support memory-failure
Date: Tue, 23 Sep 2025 12:10:05 +0800
Message-ID: <20250923041005.9831-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <9c0cd24c-559b-4550-9fc8-5dc4bcc20bf7@app.fastmail.com>
References: <9c0cd24c-559b-4550-9fc8-5dc4bcc20bf7@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj100009.china.huawei.com (7.202.194.3)

Arnd Bergmann wrote:
>>> It would be helpful to be more specific about what you
>>> want to do with this.
>>> 
>>> Are you working on a driver that would actually make use of
>>> the exported interface?
>>
>> Thanks for your reply.
>>
>> Yes, In fact, we have developed a hardware component to detect DDR bit
>> transitions (software does not sense the detection behavior). Once a bit
>> transition is detected, an interrupt is reported to the CPU.
>>
>> On the software side, we have developed a driver module ko to register
>> the interrupt callback to perform soft page offline to the corresponding
>> physical pages.
>>
>> In fact, we will export `soft_offline_page` for ko to use (we can ensure
>> that it is not called in the interrupt context), but I have looked at the
>> code and found that `memory_failure_queue` and `memory_failure` can also
>> be used, which are already exported.
>
> Ok
>
>>> I see only a very small number of
>>> drivers that call memory_failure(), and none of them are
>>> usable on Arm.
>>
>> I think that not all drivers are in the open source kernel code.
>> As far as I know, there should be similar third-party drivers in other
>> architectures that use memory-failure functions, like x86 or arm64.
>> I am not a specialist in drivers, so if I have made any mistakes,
>> please correct me.
>
> I'm not familiar with the memory-failure support, but this sounds
> like something that is usually done with a drivers/edac/ driver.
> There are many SoC specific drivers, including for 32-bit Arm
> SoCs.
>
> Have you considered adding an EDAC driver first? I don't know
> how the other platforms that have EDAC drivers handle failures,
> but I would assume that either that subsystem already contains
> functionality for taking pages offline,

I'm very sorry, I tried my best to do this,
but it seems impossible to achieve.
I am a kernel developer rathder than a driver developer. I have tried to
communicate with driver developers, but open source is very difficult due
to the involvement of proprietary hardware and algorithms.

> or this is something
> that should be done in a way that works for all of them without
> requiring an extra driver.

Yes, I think that the memory-failure feature should not be associated with
specific architectures or drivers.

I have read the memory-failure's doc and code,
and found the following features, which are user useable,
are not associated with specific drivers:

1. `/sys/devices/system/memory/soft_offline_page`:
see https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-memory-page-offline

This interface only exists when CONFIG_MEMORY_HOTPLUG is enabled, but
ARM cannot enable it.
However, I have read the code and believe that it should not require a
lot of effort to decouple these two, allowing the interface to exist
even if mem-hotplug is disabled.

2. The syscall madvise with `MADV_SOFT_OFFLINE/MADV_HWPOISON` flags:

According to the documentation, this interface is currently only used for
testing. However, if the user program can map the specified physical
address, it can actually be used for memory-failure.

3. The CONFIG_HWPOISON_INJECT which depends on CONFIG_MEMORY_FAILURE:
see https://docs.kernel.org/mm/hwpoison.html

It seems to allow input of physical addresses and trigger memory-failure,
but according to the doc, it seems to be used only for testing.


Additionally, I noticed that in the memory-failure doc
https://docs.kernel.org/mm/hwpoison.html, it mentions that
"The main target right now is KVM guests, but it works for all kinds of
applications." This seems to confirm my speculation that the
memory-failure feature should not be associated with specific
architectures or drivers.

Xie Yuanbin

