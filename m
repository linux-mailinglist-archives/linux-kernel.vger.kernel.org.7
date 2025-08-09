Return-Path: <linux-kernel+bounces-760903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A35BB1F1DA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 03:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E9B1AA82CE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 01:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB827277815;
	Sat,  9 Aug 2025 01:28:13 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7F4274FD0;
	Sat,  9 Aug 2025 01:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754702893; cv=none; b=SQaVSLu12L6Ggq7lNb4gvnKs+hHXLjZnlG2qT3CVoF/xCWYK8TyNgVSVRPBV9ix+alZSlc7FNVORHY7KcwigCa917WTUiNhlWTT4LF4GuAikIrkP1Du7wsv3JrqLz/N33BOkUU6Ttxd0VYELavbNdFYzn/xv2YP2Pkjt0Q4i6l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754702893; c=relaxed/simple;
	bh=0tnJObmLVMaajEbPMCFklfyQV4KEKh7V4lU30FVW2B4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=etnHcbnD4+TThXbPh+6C40HJaCyLKZNJdjJHfhObgwyjvi/l2WBJCQL3eBPIUjgg9luf4yohjqtOH9561H1BTLp/9w1BfUIZ3iqOXr4r6XuUpWgQ448y++kpp78IKVSaCP7KP02E9lqm/J+DZKHQOB+Sv6RAwFna/cSbE30D9Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bzNT72THRz2CfsP;
	Sat,  9 Aug 2025 09:23:39 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 04E2E1A0188;
	Sat,  9 Aug 2025 09:27:57 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 9 Aug 2025 09:27:56 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 9 Aug
 2025 09:27:10 +0800
Message-ID: <8634445b-0462-4d86-9bfb-af10569566dc@huawei.com>
Date: Sat, 9 Aug 2025 09:27:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: hisilicon: kunpeng_hccs: Fix spelling mistake
 "decrese" -> "decrease"
To: Colin Ian King <colin.i.king@gmail.com>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "xuwei
 (O)" <xuwei5@huawei.com>, <lihuisong@huawei.com>
References: <20250808105751.830113-1-colin.i.king@gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250808105751.830113-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)

+Wei Hisilicon SoC maintainer

在 2025/8/8 18:57, Colin Ian King 写道:
> There is a spelling mistake in a dev_err message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
Thanks,
Reviewed-by: lihuisong@huawei.com

