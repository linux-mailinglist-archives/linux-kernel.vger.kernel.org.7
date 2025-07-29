Return-Path: <linux-kernel+bounces-749441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F89AB14E72
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CA23BBC30
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449634438B;
	Tue, 29 Jul 2025 13:35:44 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448DD8F54
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796143; cv=none; b=CllJ+klCsvbQm3kzzsyYazB5HO5WrJ54ypSqU+n73l8eepVeB2eC4y6ee0cfoVOTbEXdhE7wTQl4rBKRiwEQ/K/gTDC4R+rN8hmGD6EGHRWUv9CNZB+U2XmzAV4OnPSkZMVOBkp9MbdJ1SfrgJFLjmb2iiE28KasOpEFUDam/Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796143; c=relaxed/simple;
	bh=LRbZjoRsy/N210YquygoJHo2Im3wuuyFFcLYtxSIYC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tvX3hKwN4Y1jL6Yak//DnYtwz8ETZ9Xpj+D9ATXTtjJjFXiGwTZLJt39faqRGOTxojPwhcBiQLFyfM36r9tnDf6VJF0IBk2F7a3Z45hEVjKNHiazb8kee/sxsFKR55hYfCR04bCPZKc7Ca5y2umOF328ckdFLEgo6+Viv0jM3aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4brx960zPLz13MVg;
	Tue, 29 Jul 2025 21:32:26 +0800 (CST)
Received: from dggpemf100018.china.huawei.com (unknown [7.185.36.183])
	by mail.maildlp.com (Postfix) with ESMTPS id 212DC180087;
	Tue, 29 Jul 2025 21:35:31 +0800 (CST)
Received: from [10.67.111.115] (10.67.111.115) by
 dggpemf100018.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Jul 2025 21:35:30 +0800
Message-ID: <4426d19d-7f7e-411b-8573-36b8990e5d9a@huawei.com>
Date: Tue, 29 Jul 2025 21:35:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT] x86/apic: CPU Hang in x86 VM During Kdump
To: Thomas Gleixner <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<peterz@infradead.org>, <sohil.mehta@intel.com>, <rui.zhang@intel.com>,
	<arnd@arndb.de>, <yuntao.wang@linux.dev>, <linux-kernel@vger.kernel.org>
References: <20250604083319.144500-1-zouyipeng@huawei.com>
 <87ecu1pfnn.ffs@tglx> <87tt2vnzsv.ffs@tglx>
Content-Language: en-US
From: Yipeng Zou <zouyipeng@huawei.com>
In-Reply-To: <87tt2vnzsv.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf100018.china.huawei.com (7.185.36.183)


在 2025/7/29 16:53, Thomas Gleixner 写道:
> On Sun, Jul 27 2025 at 22:01, Thomas Gleixner wrote:
>
> But looking even deeper. machine_crash_shutdown() does not end up in
> stop_other_cpus() at all. It immediately uses the NMI shutdown. There
> are still a few inconsistencies in that code, but they are not really
> critical.
>
> So the actual scenario is:
>
> CPU0			  CPU2
> ========================  ======================
> reboot			  Panic
> machine shutdown	  Kdump
> 			  machine_crash_shutdown()
> stop other cpus
> send_IPIs(REBOOT)	  --> REBOOT vector becomes pending in IRR
> wait timeout
>                            send NMI stop
> NMI -> CPU stop
>                            jump to crash kernel
>
> So the patch I gave you should handle the reboot vector pending in IRR
> gracefully. Can you please give it a try?

Hi Thomas:

     Thanks for your time!

     Indeed, It invokes kdump_nmi_shootdown_cpus() and uses the NMI 
shutdown.

     I started the test run today, but this is a low-probability to hit 
this path, might take a while.

-- 
Regards,
Yipeng Zou


