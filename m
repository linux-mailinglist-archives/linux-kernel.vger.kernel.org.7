Return-Path: <linux-kernel+bounces-603429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AA7A8874C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 17:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1861170BDD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 15:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E3C2749CC;
	Mon, 14 Apr 2025 15:34:38 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DB0129A78;
	Mon, 14 Apr 2025 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744644878; cv=none; b=fY6tJCJmbHezzdLqAApzcFjrbGd1+gcvRfIxftLr5Wb7CE197LtLb9TudIivKOC72kMZfnJojQiFyatX1SvLwOg4H58mehtcxFwtsxiBfWEl+FeV3dKSayg62h/75B6AGJsTPxYr7oBny8be3690PFxVjvGPWdLqm4wnbudJr1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744644878; c=relaxed/simple;
	bh=gFlC8pSnRT+u0CJ6ST85nzTpHMDivVZ1XyVfvWuCW20=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBhnludjRD46slPtFMX7tXrB8f/GZgvC5VfXVYSe7mFFBmpqiJrKep1UQAvTWC+dRiuxLvTJauTsCMOdTlBTGvZA+61B6DTF3V6/0zjRUG3cnONStJWAMteak5VZcbJIp6SUf/1dBtfvEuloDAYUtRg/mYPvIANTUZcvOKrPzNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZbrsW4Flwz6FGcT;
	Mon, 14 Apr 2025 23:33:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AF90A1400D9;
	Mon, 14 Apr 2025 23:34:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Apr
 2025 17:34:34 +0200
Date: Mon, 14 Apr 2025 16:34:32 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 05/19] cxl/mem: Expose dynamic ram A partition in
 sysfs
Message-ID: <20250414163432.00006b60@huawei.com>
In-Reply-To: <20250413-dcd-type2-upstream-v9-5-1d4911a0b365@intel.com>
References: <20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com>
	<20250413-dcd-type2-upstream-v9-5-1d4911a0b365@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sun, 13 Apr 2025 17:52:13 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> To properly configure CXL regions user space will need to know the
> details of the dynamic ram partition.
> 
> Expose the first dynamic ram partition through sysfs.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 

LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



