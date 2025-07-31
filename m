Return-Path: <linux-kernel+bounces-752065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B364DB170F0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8DDD166FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B1A223DED;
	Thu, 31 Jul 2025 12:17:13 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE378F66
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964233; cv=none; b=M+U88nv7QOVqRrq5rRp2unTWpkihJAgOU/hi4Xnu4rXzNVfIgvzHnki+nvW4fONZ5xJZGtptndmSM7eTxhck3dwe6+Aiu25UDXl2lYc2teBp8mVXNFJCyi1fO+L5+LL9flX/CAcw+bjBRnbvjgTmBI6/Isd3OhPPAXAM9Ew0CIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964233; c=relaxed/simple;
	bh=FRMJkSvirXntp+9uyOUAjrFCtGi5b0jQPq1G+6xaXd8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XG9T7aXvsxLf3v+MwI1KX8COBWBLvzM/VIZ2zALIrKtJy8a7y8qKfsEgHA5gO+OUvnsdq7KDy79tLCx8DLs/F218NZzwyeLnE7K4C4icOKL2dfRKqWUtnILHJgwxBeBgvIsMmOrX2CokJOS3lbESQIm8SvARkCfw6Upq75uPyw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bt7MR3Klkz6D9XW;
	Thu, 31 Jul 2025 20:15:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E72BE1402EA;
	Thu, 31 Jul 2025 20:17:08 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Jul
 2025 14:17:08 +0200
Date: Thu, 31 Jul 2025 13:17:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yushan Wang <wangyushan12@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>
Subject: Re: [PATCH 3/8] drivers/perf: hisi: Simplify the probe process of
 each L3C PMU version
Message-ID: <20250731131706.00002219@huawei.com>
In-Reply-To: <20250729153823.2026154-4-wangyushan12@huawei.com>
References: <20250729153823.2026154-1-wangyushan12@huawei.com>
	<20250729153823.2026154-4-wangyushan12@huawei.com>
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

On Tue, 29 Jul 2025 23:38:18 +0800
Yushan Wang <wangyushan12@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Version 1 and 2 of L3C PMU also use different HID. Make use of
> struct acpi_device_id::driver_data for version specific information
> rather than judge the version register. This will help to
> simplify the probe process and also a bit easier for extension.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

