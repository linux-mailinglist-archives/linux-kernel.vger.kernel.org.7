Return-Path: <linux-kernel+bounces-683637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C09AD702D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 14:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72AF1BC5AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 12:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BC621B9FD;
	Thu, 12 Jun 2025 12:21:50 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166E92F431E;
	Thu, 12 Jun 2025 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730910; cv=none; b=IrhAyz0MVbM4ZNLDH0g3n/g9oLwYDvj3Sf9Anr946vIYqIKtOiQYV2XWd38MvjHU0XkxSwYK0DvlCx/K90VeVPUS7QOWj9M79SF+cNn7REksqOXRjGNr6pkzRgKoiUjDXcvGfMX7Sdds0Rfspbp9nc1I+SqsXjEeGmKGpj4M3kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730910; c=relaxed/simple;
	bh=4Fo/1W1kabTZ2FkPuDY915cDbo8OaFCKSSYQl//Y98A=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CRLtVPJevcBRkowB0kEiShrTNS3poizVqJ2uPshc5gxW7N1Ghl/a1FNhO/8pV4y0XyI+RpY5JWZASYRrAzPP+1J022TvAByhATZZRYRSNehTgAFKlGFTaF81MET4vXt3i1gCWOEyNwdXDFtpoTb2krQ3UZ5ezPHZvD6yP0VoFMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bJ1kl5XMdz2Cf5J;
	Thu, 12 Jun 2025 20:17:51 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 80C9A1A016C;
	Thu, 12 Jun 2025 20:21:43 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Jun 2025 20:21:42 +0800
Message-ID: <70b3f869-26be-4364-9658-8bfe56d16594@huawei.com>
Date: Thu, 12 Jun 2025 20:21:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/8] net: hns3: add the hns3_get_ae_dev() helper
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
References: <20250612021317.1487943-1-shaojijie@huawei.com>
 <20250612021317.1487943-3-shaojijie@huawei.com>
 <aEq3DgCDh98Deidl@mev-dev.igk.intel.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <aEq3DgCDh98Deidl@mev-dev.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/6/12 19:16, Michal Swiatkowski wrote:
> On Thu, Jun 12, 2025 at 10:13:11AM +0800, Jijie Shao wrote:
>> This patch introduces a hns3_get_ae_dev() helper to reduce the unnecessary
>> middle layer conversion. Apply it to the whole HNS3 driver.
>> The former discusstion can be checked from the link.
> The definition already exist, so more like "use hns3_get_ae_dev()
> wherever possible".
>
>> Link: https://patchwork.kernel.org/project/netdevbpf/patch/20230310081404.947-1-lanhao@huawei.com/
> I think the comment is about going from netdev to your private
> hnae3_ae_dev. You need hnae3_netdev_to_dev/pf/whatever().
>
> Using already defined helper is fine, just please change the commit
> message/title.


I will change this in v2.

Thanks,
Jijie SHao

>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> [...]
>

