Return-Path: <linux-kernel+bounces-772985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C556B29A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD833AF818
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC06E27814C;
	Mon, 18 Aug 2025 06:52:17 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2E8274FDB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499937; cv=none; b=LRWceFrinJWVer2oWNvXDklTaK3tKuxHMZkuBOgGcWS5/+hyB7RsZuvtmJ0NHMhaTVisWwkbYHsm2xGzNbb1NsRIb/4zCmbWj+U6DTqqR35zgUgbtxZyrp+Oe+5hMPFe43VPoVSgNuBYxJ5K0TuyBJC36t0oQjbnd5+q204Ao7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499937; c=relaxed/simple;
	bh=tLdUSVQJziw542UiyKHR579WigJbsENu6bbs19bsk5k=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Q5q7t553jBvm91Tk1rkxRMuQoUhfZYmtIt9hV1fpjW/UFW/kU9Uz8L/VzBbkhlXFA73uyo2bhMyUO3wEPpmHHPw54tglzDsLh+FNMU82vZP7bdjNQZ9dsctmWvWRk8OGDKrQMfHSZxhC/sH4ci+xj4K+hA/7sfQ1TNj3gcT7RMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c53Gv1BhBz2Dc38;
	Mon, 18 Aug 2025 14:49:27 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 205661400CB;
	Mon, 18 Aug 2025 14:52:13 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 14:52:12 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 14:52:12 +0800
CC: <yangyicong@hisilicon.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <wangyushan12@huawei.com>,
	<hejunhao3@h-partners.com>
Subject: Re: [PATCH v6 3/3] MAINTAINERS: Remove myself from HiSilicon PMU
 maintainers
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250814091622.23269-1-yangyicong@huawei.com>
 <20250814091622.23269-4-yangyicong@huawei.com>
 <20250815095606.0000606e@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <b51c2ce9-d93c-29a2-65d4-915226af8c16@huawei.com>
Date: Mon, 18 Aug 2025 14:52:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250815095606.0000606e@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq200018.china.huawei.com (7.202.195.108)

On 2025/8/15 16:56, Jonathan Cameron wrote:
> On Thu, 14 Aug 2025 17:16:22 +0800
> Yicong Yang <yangyicong@huawei.com> wrote:
> 
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Remove myself as I'm leaving HiSilicon and not suitable for maintaining
>> this. Thanks for the journey.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> Thanks Yicong, it's been a pleasure working with you.
> Best wishes for whatever you do next.

my pleasure too. thanks a lot for the generous help provided along the way.

> 
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
>> ---
>>  MAINTAINERS | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fe168477caa4..22999fccfbd7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11059,7 +11059,6 @@ F:	Documentation/devicetree/bindings/net/hisilicon*.txt
>>  F:	drivers/net/ethernet/hisilicon/
>>  
>>  HISILICON PMU DRIVER
>> -M:	Yicong Yang <yangyicong@hisilicon.com>
>>  M:	Jonathan Cameron <jonathan.cameron@huawei.com>
>>  S:	Supported
>>  W:	http://www.hisilicon.com
> 
> .
> 

