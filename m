Return-Path: <linux-kernel+bounces-791265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ADEB3B42E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64AEF7B94B7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B99269CF0;
	Fri, 29 Aug 2025 07:21:51 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C61EEA49;
	Fri, 29 Aug 2025 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756452111; cv=none; b=G/dRxnPqT8boJ/CfYe5WCFMAs4yIXIm2Is2NCUJf/6xsgtqf5VEcrlKy+FF7+4J1Y23Vdx8GA24Yiu5x9bOVMuQk0nNW2SCJ/bBImO+yxDnBN5188kExNlVdGFb2OLeD37Qjkk9UZ3GKLn0O/YzQ5IVnvb3cPI18/BKQ1XIHLbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756452111; c=relaxed/simple;
	bh=9e6937TvswyiPc6f7lM0pelqK3lmBBm/5nTriRK/bxE=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=E1xTBOotMzdWQyhvv37vhBdHQWnKYwNf/sI1PJBBgnJcgFmrnn/j8bK46P2O9MAvoHSoo7aCts/6pfZKxMkMaOaoN/QfGiIOp7D7pb/Feuk/sDR2J0RoOHMQWq6QCmjqSa4vCXq+QYegwuuJ4zVPayyrwMZLubjUvmnjJBo+fOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cCqMz3Jlbz2CgDb;
	Fri, 29 Aug 2025 15:17:19 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 3744C1A016C;
	Fri, 29 Aug 2025 15:21:46 +0800 (CST)
Received: from kwepemq100003.china.huawei.com (7.202.195.72) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 Aug 2025 15:21:45 +0800
Received: from [10.67.113.98] (10.67.113.98) by kwepemq100003.china.huawei.com
 (7.202.195.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 29 Aug
 2025 15:21:45 +0800
Message-ID: <68B15509.4030605@hisilicon.com>
Date: Fri, 29 Aug 2025 15:21:45 +0800
From: Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: "lihuisong (C)" <lihuisong@huawei.com>, Colin Ian King
	<colin.i.king@gmail.com>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<xuwei5@hisilicon.com>
Subject: Re: [PATCH] soc: hisilicon: kunpeng_hccs: Fix spelling mistake "decrese"
 -> "decrease"
References: <20250808105751.830113-1-colin.i.king@gmail.com> <8634445b-0462-4d86-9bfb-af10569566dc@huawei.com>
In-Reply-To: <8634445b-0462-4d86-9bfb-af10569566dc@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq100003.china.huawei.com (7.202.195.72)

Hi Colin， 

On 2025/8/9 9:27, lihuisong (C) wrote:
> +Wei Hisilicon SoC maintainer
> 
> 在 2025/8/8 18:57, Colin Ian King 写道:
>> There is a spelling mistake in a dev_err message. Fix it.
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
> Thanks,
> Reviewed-by: lihuisong@huawei.com
> .
> 

Applied to the Hisilicon driver tree.
Thanks!

Best Regards,
Wei

