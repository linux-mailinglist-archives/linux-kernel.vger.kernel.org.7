Return-Path: <linux-kernel+bounces-848071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F9DBCC6B6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 91D6F3551B9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D6B2D12E2;
	Fri, 10 Oct 2025 09:45:38 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE9281529
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089538; cv=none; b=JQZlLL/qNkPP80Ogn8xgISKq8IZoKtSqqF8IrPH6G/d6CAuKGqIHQHxvoV9Pk8pDNES8QDNxGjqRRBx6lpK9XN+ZWOhpKkeu2G/iUdrM1szO1gWVSAQeep9OKJx3vApkWmR6corBHqcdsEUyjnV/jkfTRDF5yd+TVfKaXPmEacE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089538; c=relaxed/simple;
	bh=RMXAJnAkU205MbP6vX2oZI4xHvNmkJEViuibbSmCIyk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N15szj6gAl6RgcnXIs0qivS6MSdFcJW5mBo/ndGSQfSOUY1FlHWYqutDlsbsonDbjNAJJhqle6S36T/BmTfawV+QSU+oHLADsAImL8ptZwVcDWb/NhUvmO+lWNq1mMLRXHbh1OMKWrslKZ/vfdSRzINH9goltiLdiE+cad0OE6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cjhcZ5Rp5z6L56H;
	Fri, 10 Oct 2025 17:42:54 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id D50E71401F4;
	Fri, 10 Oct 2025 17:45:32 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 10 Oct
 2025 10:45:32 +0100
Date: Fri, 10 Oct 2025 10:45:30 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: Yang Shen <shenyang39@huawei.com>, <yangyicong@hisilicon.com>,
	<linux-kernel@vger.kernel.org>, <fanghao11@huawei.com>, "Zengtao (B)"
	<prime.zeng@hisilicon.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>
Subject: Re: [PATCH] MAINTAINERS: Update HiSilicon PTT driver maintainer
Message-ID: <20251010104530.00000186@huawei.com>
In-Reply-To: <81d63996-41e3-029a-7de4-cb78c9bbfb26@huawei.com>
References: <20251010014847.2747140-1-shenyang39@huawei.com>
	<81d63996-41e3-029a-7de4-cb78c9bbfb26@huawei.com>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 10 Oct 2025 11:23:43 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> +cc Suzuki.
> 
> as ptt patches are usually kindly processed through coresight tree, many appreciations.
> 
> On 2025/10/10 9:48, Yang Shen wrote:
> > Add Yang Shen as the maintainer of the HiSilicon PTT driver,
> > replacing Yicong Yang.
> > 
> > Signed-off-by: Yang Shen <shenyang39@huawei.com>  
> 
> good luck :)
> 
> Acked-by: Yicong Yang <yangyicong@hisilicon.com>

Sorry to see you go Yicong but I'm happy to have shenyang on
board.

Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> 
> thanks.
> 
> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9a6f4ef1cca3..e9a40db0f368 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11278,8 +11278,8 @@ F:	drivers/perf/hisilicon
> >  F:	tools/perf/pmu-events/arch/arm64/hisilicon/
> >  
> >  HISILICON PTT DRIVER
> > -M:	Yicong Yang <yangyicong@hisilicon.com>
> >  M:	Jonathan Cameron <jonathan.cameron@huawei.com>
> > +M:	Yang Shen <shenyang39@huawei.com>
> >  L:	linux-kernel@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt
> >   


