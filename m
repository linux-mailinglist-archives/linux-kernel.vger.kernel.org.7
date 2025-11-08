Return-Path: <linux-kernel+bounces-891288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6FCC42580
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 04:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F119A3A1A73
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 03:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DEA2BE02A;
	Sat,  8 Nov 2025 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="g6Kcxc39"
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600BF157480
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 03:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762571027; cv=none; b=ppBg3sGSyAHfOOltLtWl+2vsBfIwFDbwJ/81fnYbhqFMYtFNqbWOZcXf7/BqO0VoBt2ckrLnxN75cqRjVyudATbd02K4WDAeewS1VZ7DyfAJLc8iaP6UMWTnMyr7tXq69eIouirhwnTY0ZIaPp0FprmtZCEflhAeuL3TF+ex5II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762571027; c=relaxed/simple;
	bh=y0ft7HedlAAJCzKSKR9obS0q6Wz0+vb9eKXg5FskNZk=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=k2u4FVBLqyyIqlvFsH+oR5Xw7+P5vpfTogyuDrOWs/1Gec5K2gSpO5vTyBX+LjJQud6Gg1uo4zRxsZCtYwvdNZMnDiESXyk62YhZblavX0Mk2CMDM0VpSqHXMpJGBHA2NbXYI0oI3WNnvIN5/z1O8ZwuelsxQFtI5Zyncm6Bb2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=g6Kcxc39; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aeOxMzJ+i3IvySd7PiH9VVEq2pkYuGK1IybeIZufS9s=;
	b=g6Kcxc39M5z0HarPRlDQvDmT5RWQ7Oy5k6O+0cs6isVoOs5A04mX+zNuHttY3AFR6BCr7lVur
	pDJJhKYH2Nq2PZXMbgUmWx8z6/tpHeznO66HSGBhbx3J//OxLYa+qXgn69nW+pp5JTp6kAYv4bH
	sE80RxNBvs+1fEMD7bdtgKs=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d3LLh1fn9zpStp;
	Sat,  8 Nov 2025 11:02:04 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id A4412180493;
	Sat,  8 Nov 2025 11:03:39 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 8 Nov 2025 11:03:38 +0800
Subject: Re: UBIFS errors since Linux 5.15
To: Eddie James <eajames@linux.ibm.com>, <linux-mtd@lists.infradead.org>,
	<richard@nod.at>, <openbmc@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, <sethjenkins@google.com>,
	<adobriyan@gmail.com>
References: <068ba254-0053-46d5-bff4-74c948d2e8ac@linux.ibm.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <183bacc4-3e27-59a7-ceb5-0bcac7d566e9@huawei.com>
Date: Sat, 8 Nov 2025 11:03:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <068ba254-0053-46d5-bff4-74c948d2e8ac@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500005.china.huawei.com (7.202.194.90)

在 2025/11/8 1:38, Eddie James 写道:
> 
> Hello,
> 
> We are updating some BMC (Aspeed AST2600, ARM32) systems that were on 
> Linux 5.4 but observe consistent UBIFS errors with Linux 5.15 and later. 
> The errors seem to vary; there is a sampling below.
> 
> 
> We performed a git bisect and came up with the following commit, which 
> of course is completely unrelated to UBIFS. Reverting it does prevent 
> the issue... Does anyone have any suggestions?
> 
> commit 33fc9e26b7cb39f0d4219c875a2451802249c225
[...]
> [    8.180486] UBIFS error (ubi0:2 pid 66): ubifs_check_node: bad magic 
> 0x101831, expected 0x6101831

Hi, look here, the magic number 0x101831 vs 0x6101831, the difference is 
the highest bit(0 vs 6[0110])
> [    8.189578] UBIFS error (ubi0:2 pid 66): ubifs_check_node: bad node 
> at LEB 17:64664

[...]
> [ 3739.678968] UBIFS error (ubi0:2 pid 13): ubifs_check_node: bad CRC: 
> calculated 0x9179af29, read 0xa760f4f5

[...]
> [10412.723111] UBIFS error (ubi0:2 pid 297): ubifs_check_node: bad magic 
> 0x6100830, expected 0x6101831

and there, magic number 0x6100830 vs 0x6101831, the difference is lowest 
bit(0 vs 1).

So, I guess the crc error is caused by the similar reason, maybe there 
is something wrong with the nand driver or flash? According to the 
version information(5.15, and the unrelated commit 33fc9e26b7cb3), is it 
possible that there is a compatibility issue between your nand(bsp) 
driver with kernel nand common layer(which from different versions)?

> [10412.732436] UBIFS error (ubi0:2 pid 297): ubifs_check_node: bad node 
> at LEB 13:60248


