Return-Path: <linux-kernel+bounces-754763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 946FFB19BF4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E1D37A93C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5B3233722;
	Mon,  4 Aug 2025 07:10:43 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9615B230BD5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291442; cv=none; b=UJHqS97AS2muTZ8Fd9N7c+8sL8Ug0N77I9EtThO+YoHYYCz5dbRi74DsmBf5Mk7UqvkftMfEhzogfdiAX1tb8l6hG9lUzO01nXu0BgnCENmgSnTQXmEjKdaYEihxqiQsqRzZZ7gLX+zK4qzQyjy+Ek/sDXR5ZgbIPUbFNFjL+YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291442; c=relaxed/simple;
	bh=U+FDt261cHXT2gw3UMW1+V0D3BXJz/vHsRz+bMtoHS4=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rs8n3vvWF3GoWL8RxOAbWgvEAgW9vjJC8KVsBQLCER24bkr+sLh/yDs72vsHfEzdLG0VQHMhUgIQTieVg196KXcdADkHw4k4YluWeP8asm166TmVqmu8RxUZqEy6P3IZmkQrD5bzr/p8ot3o8xHiCoVwSi2HMEs44WMK4n0piSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bwSJs23b4z2Cd6d;
	Mon,  4 Aug 2025 15:06:21 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id C48E614025A;
	Mon,  4 Aug 2025 15:10:36 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Aug 2025 15:10:36 +0800
Subject: Re: linux-6.16/fs/jffs2/readinode.c:189: loop can never finish
To: David Binderman <dcb314@hotmail.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "richard@nod.at" <richard@nod.at>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
References: <AS8PR02MB10217F68E5D37ECD491495E669C23A@AS8PR02MB10217.eurprd02.prod.outlook.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <df923d94-92ee-f824-01e2-21e6ed3d593c@huawei.com>
Date: Mon, 4 Aug 2025 15:10:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <AS8PR02MB10217F68E5D37ECD491495E669C23A@AS8PR02MB10217.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2025/8/4 14:23, David Binderman Ð´µÀ:
> Hello there,
> 
> Static analyser cppcheck said:
> 
> linux-6.16/fs/jffs2/readinode.c:189:24: style: Expression is always true because 'else if' condition is opposite to previous condition at line 187. [multiCondition]
> 
> Source code is
> 
>      while (next) {

Hi,
The 'next != NULL' is also a condition for the loop, this snippet of 
code finds a leaf node in 'tn_root'.
>          tn = rb_entry(next, struct jffs2_tmp_dnode_info, rb);
> 
>          if (tn->fn->ofs < offset)
>              next = tn->rb.rb_right;
>          else if (tn->fn->ofs >= offset)
>              next = tn->rb.rb_left;
>          else
>              break;
>      }
> 
> It looks to me like this loop will never finish.
> Suggest change ">=" to ">".
> 
> Regards
> 
> David Binderman
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> .
> 


