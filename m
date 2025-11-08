Return-Path: <linux-kernel+bounces-891289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FC4C42585
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 04:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9769B188F72A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 03:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955902D0636;
	Sat,  8 Nov 2025 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3JB5MYKt"
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CC12C3276
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762571429; cv=none; b=PVIvaaQQL0ZZqRa3AUXM66U9II2e9yZKxf4CaG2mJzIsBGn3ctc1vsVEbyO83V2gw3oCWSOhqkLZkBYUHo80LbFitX9nQIVSg6VZ41iPVxXGkCAeskKjh65frmm7Wn9VUuZhwKahn1kSFnXfUkiqHurIpUWvn4zccOFcZEcPgUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762571429; c=relaxed/simple;
	bh=mQqbWGVOOQaCHo+JyHm75c1MG7ch0SoVA7iY4uQf16M=;
	h=Subject:From:To:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=h3BZdP/V1XM6qYVGoknMYaYREGyDpOBnhz4zXz6/HPDSnqDtKHA1nuSYLqrij5YpSQODfbJdZLHZtdmmHlnPvAre/w7jcMIodotPFCzCBD3YvTTTdalvcDFTR00ZxIGQhGHMiKU7ITWslIvfxQgiK41+QDZ61ace0aQUA8nKyp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3JB5MYKt; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from canpmsgout07.his.huawei.com (unknown [172.19.92.160])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4d3LQh0hRdzThBT
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 11:05:32 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fWTb2pOcM9CXmYC6UdWot4dWCYfXpxLg0tPmGPgdwak=;
	b=3JB5MYKtzMDOEFTMGqRYCsUNmJnLgQLHT8NUaT/G2qYNOfCyLO/TgCL7udDTHyLBDIFdzqsmv
	rx4WV+baK74czTdS+9ZPXLRcqlK0tAmZxI5m1Tk7tqKt9/XLS4ieYqRUM7ve3nXgVyfbKrOJlpg
	/Px2qfkM5/JwdsDW1ZqfVCU=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4d3LV837zKzLlSX;
	Sat,  8 Nov 2025 11:08:32 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id F17B7140142;
	Sat,  8 Nov 2025 11:10:08 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 8 Nov 2025 11:10:07 +0800
Subject: Re: UBIFS errors since Linux 5.15
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: Eddie James <eajames@linux.ibm.com>, <linux-mtd@lists.infradead.org>,
	<richard@nod.at>, <openbmc@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, <sethjenkins@google.com>,
	<adobriyan@gmail.com>
References: <068ba254-0053-46d5-bff4-74c948d2e8ac@linux.ibm.com>
 <183bacc4-3e27-59a7-ceb5-0bcac7d566e9@huawei.com>
Message-ID: <b48c9bad-3224-d606-d1a4-72239c3561e4@huawei.com>
Date: Sat, 8 Nov 2025 11:10:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <183bacc4-3e27-59a7-ceb5-0bcac7d566e9@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500005.china.huawei.com (7.202.194.90)

在 2025/11/8 11:03, Zhihao Cheng 写道:
> 在 2025/11/8 1:38, Eddie James 写道:
>>
>> Hello,
>>
>> We are updating some BMC (Aspeed AST2600, ARM32) systems that were on 
>> Linux 5.4 but observe consistent UBIFS errors with Linux 5.15 and 
>> later. The errors seem to vary; there is a sampling below.
>>
>>
>> We performed a git bisect and came up with the following commit, which 
>> of course is completely unrelated to UBIFS. Reverting it does prevent 
>> the issue... Does anyone have any suggestions?
>>
>> commit 33fc9e26b7cb39f0d4219c875a2451802249c225
> [...]
>> [    8.180486] UBIFS error (ubi0:2 pid 66): ubifs_check_node: bad 
>> magic 0x101831, expected 0x6101831
> 
> Hi, look here, the magic number 0x101831 vs 0x6101831, the difference is 
> the highest bit(0 vs 6[0110])
>> [    8.189578] UBIFS error (ubi0:2 pid 66): ubifs_check_node: bad node 
>> at LEB 17:64664
> 
> [...]
>> [ 3739.678968] UBIFS error (ubi0:2 pid 13): ubifs_check_node: bad CRC: 
>> calculated 0x9179af29, read 0xa760f4f5
> 
> [...]
>> [10412.723111] UBIFS error (ubi0:2 pid 297): ubifs_check_node: bad 
>> magic 0x6100830, expected 0x6101831
> 
> and there, magic number 0x6100830 vs 0x6101831, the difference is lowest 
> bit(0 vs 1).

Sorry, I need to make a correction, the differences are the lowest bit(0 
vs 1) and the middle bit (0 vs 1). The number of flipped bits is also two.
> 
> So, I guess the crc error is caused by the similar reason, maybe there 
> is something wrong with the nand driver or flash? According to the 
> version information(5.15, and the unrelated commit 33fc9e26b7cb3), is it 
> possible that there is a compatibility issue between your nand(bsp) 
> driver with kernel nand common layer(which from different versions)?
> 
>> [10412.732436] UBIFS error (ubi0:2 pid 297): ubifs_check_node: bad 
>> node at LEB 13:60248
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/


