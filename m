Return-Path: <linux-kernel+bounces-752072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A51BFB170FD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890DA3B738F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D8327FD51;
	Thu, 31 Jul 2025 12:21:00 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB932367A3
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964460; cv=none; b=gcySqzjjcMUYv0OXQ5ZRVlrH8d6M/YSs5FNukSabOGj8QxqR5hiliiML0905UIQ8nhJHnw0fencLtC+Md09IQWMZXz2JAbC+oYSIKUugFrXzABG7XY7MP+o3kbLiq4S9m6jY7PnZxOtMDT9ZmvG9WoYXvxwSvMf/a7ftSeW9MGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964460; c=relaxed/simple;
	bh=+gNtK1rjPrK78GiWKHQpH5ULn/3HvJqJ2CdQ1Jz/MYI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIZXwLCcbTGKpjgM+QNghP2E8BpLTulMU/PFucJlXPuqIO1fIGzgFe7LeLcr0u1qbdatMTY1B+7/2SbyrJTqPeC/+63nbarhuzgl0QPaBHdCx/TNjhtI4Qp6CNdebBMAT6dzIy2DoC16kq7Gdha6cuLig671jvIFkhj9JDpUyAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bt7Nn0knXz6HJgn;
	Thu, 31 Jul 2025 20:16:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C8E0B1402EB;
	Thu, 31 Jul 2025 20:20:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Jul
 2025 14:20:56 +0200
Date: Thu, 31 Jul 2025 13:20:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yushan Wang <wangyushan12@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>
Subject: Re: [PATCH 4/8] drivers/perf: hisi: Extract the event filter check
 of L3C PMU
Message-ID: <20250731132054.000074e1@huawei.com>
In-Reply-To: <20250729153823.2026154-5-wangyushan12@huawei.com>
References: <20250729153823.2026154-1-wangyushan12@huawei.com>
	<20250729153823.2026154-5-wangyushan12@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 29 Jul 2025 23:38:19 +0800
Yushan Wang <wangyushan12@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> L3C PMU has 4 filter options which are sharing perf_event_attr::config1.
> Driver will check config1 to see whether a certain event has a filter
> setting. It'll be incorrect if we make use of other bits in config1
> for non-filter options. So check whether each filter options are set
> directly in a separate function instead.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

