Return-Path: <linux-kernel+bounces-762648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3107BB20953
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75CC42554B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAE82BDC38;
	Mon, 11 Aug 2025 12:51:52 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F9D225793
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916712; cv=none; b=n1dhXgiSMo5UVUa6OxXLBRC8sYveknDFwwfq+eVCPeuEhe0FTqeSr7A7Pm4GQBnfurwvF9pbsdEaTWNxqdNwowCOV6VSQ7FPOAGP3F+loE7HpplFw6qVjxwmn0915LyeHKwUMYReYp13YFVUN9V/XorsFqode5H3jSISZf8fy70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916712; c=relaxed/simple;
	bh=UfWloCpGHL6SM4IDF9Sai2JQuqbdUtevLetjkdvFHy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G1MRv4d/oTRf/jTXGjYwzjvOU79YTPm5hFiFRQzTWmYwZVuRMNGFV4Yj+vYyS/nu5o1Zi48CTTjHueX4PG+6QDfNLEbxY5jk+3oQs3vmWe1b6UV0bXKwFOeUQIsI3TTFpfhr3DD0CD9O5c76GNsi58HkB+JROIiA0SN41A96rw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c0vb14blFz2TT60;
	Mon, 11 Aug 2025 20:49:01 +0800 (CST)
Received: from dggpemf100018.china.huawei.com (unknown [7.185.36.183])
	by mail.maildlp.com (Postfix) with ESMTPS id 71C4914010C;
	Mon, 11 Aug 2025 20:51:39 +0800 (CST)
Received: from [10.67.111.115] (10.67.111.115) by
 dggpemf100018.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 20:51:38 +0800
Message-ID: <9dfd8510-91e5-40c4-a3ec-6f70667fc366@huawei.com>
Date: Mon, 11 Aug 2025 20:51:37 +0800
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
 <4426d19d-7f7e-411b-8573-36b8990e5d9a@huawei.com> <87a54mkccu.ffs@tglx>
Content-Language: en-US
From: Yipeng Zou <zouyipeng@huawei.com>
In-Reply-To: <87a54mkccu.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf100018.china.huawei.com (7.185.36.183)


在 2025/7/30 3:48, Thomas Gleixner 写道:
> On Tue, Jul 29 2025 at 21:35, Yipeng Zou wrote:
>> 在 2025/7/29 16:53, Thomas Gleixner 写道:
>>> On Sun, Jul 27 2025 at 22:01, Thomas Gleixner wrote:
>>> So the patch I gave you should handle the reboot vector pending in IRR
>>> gracefully. Can you please give it a try?
>> Hi Thomas:
>>
>>       Thanks for your time!
>>
>>       Indeed, It invokes kdump_nmi_shootdown_cpus() and uses the NMI
>> shutdown.
>>
>>       I started the test run today, but this is a low-probability to hit
>> this path, might take a while.
> It's trivial enough to enforce that, no?

Hi Thomas:

     Sorry for delay - after resolving a few environmental issues, 
anyway, it works.

     All previously failed test cases are now passing.

     I also think this solution is reasonable.

-- 
Regards,
Yipeng Zou


