Return-Path: <linux-kernel+bounces-780887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1EBB30A93
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA96582175
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 01:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F409C1482E8;
	Fri, 22 Aug 2025 01:00:42 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5961FFE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755824442; cv=none; b=Q2luFLh24dfyyePff2WXP0QvP/QM/13rPtHq1N4RUE665unR/R36kWLKiHu1yNOZ0DIilnSpahk/jAiz0a9cSjWWJ8zxcJMrXY4C/PXGtB7L2vUDg7TICXtdHwAhxkn9QJlYin3gvNZTvYv/x1J/6VkNsSqGxbS2ijP29NEzrTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755824442; c=relaxed/simple;
	bh=F6QMCn3MhAWxBopStuhMJhQYy1gSOcb9rHF4UKcf+xA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nFgEmdAMn0X9KjOFeBACpk4IslC1dGYujfHmrhAGsA1+i/YfqF4Yznu/XcVzPflcIwkZ7k4H6eZjVTRJ9yPDGmto+fYqijaZ2OVALCS+phO9HjzWwoclEYcngwE0F7NDvK6tiBd33JXXjEDu5vJx8qx5DBYcLq6ipaOgSpa0YNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c7MHG1wC4z2Dc3f;
	Fri, 22 Aug 2025 08:57:46 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id F23C4140258;
	Fri, 22 Aug 2025 09:00:36 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Aug 2025 09:00:35 +0800
Subject: Re: [PATCH v2 1/3] irqchip/gic-v5: Delete a stray tab
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Marc Zyngier <maz@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <cover.1752777667.git.dan.carpenter@linaro.org>
 <670bb1dc-7827-4916-84f3-bb46ee408b20@sabinyo.mountain>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <329bff25-69bc-1bd5-16d9-7b0fc8173851@huawei.com>
Date: Fri, 22 Aug 2025 09:00:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <670bb1dc-7827-4916-84f3-bb46ee408b20@sabinyo.mountain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk200017.china.huawei.com (7.202.194.83)

On 2025/7/18 2:45, Dan Carpenter wrote:
> This line is indented one tab too far.  Delete the tab.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

