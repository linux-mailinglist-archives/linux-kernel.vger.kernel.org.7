Return-Path: <linux-kernel+bounces-786669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA64CB361A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E29179494
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44853223DF6;
	Tue, 26 Aug 2025 13:06:20 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B196A223DE5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213579; cv=none; b=YkYKShgOMbXkIzQF+9mDdORSA9evGC3luijY5lUBqHLku3umwcOqEj3ef3D1W8u2q6smg2ik5lgaoD4EYLl5fA0dIIWr0kOXMmPvyuDrVbnJRkDsyRW8c7fiUgE5TvvtpJVQHO7QNXgoCBqZV1szVME43C6aAbrQNqSHcZXcDlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213579; c=relaxed/simple;
	bh=r9whsh5+k+f/FIPb1Ix4MFKkHrYRPVObQyQ/KKZ+v3s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kt2dlYsYSHmzu2CrbmBporQYQkVUmVGWz+yELVi/KG6bKgBXgXWG7d0qvkg/rM4EDb8/zqlSua5tnotjjuoZHHz8BHXMkINBzh76yK28MX5LMKFcr/WC46xsWpKqpIlToEW5p8Bbkp4xp44vpiApeAmDsoaLDdc6JZ6QEAKyGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cB7B41CXqz6L59W;
	Tue, 26 Aug 2025 21:02:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D642140122;
	Tue, 26 Aug 2025 21:06:14 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 26 Aug
 2025 15:06:13 +0200
Date: Tue, 26 Aug 2025 14:06:12 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yushan Wang <wangyushan12@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robin.murphy@arm.com>, <yangyicong@huawei.com>, <liuyonglong@huawei.com>,
	<wanghuiqiang@huawei.com>, <prime.zeng@hisilicon.com>,
	<hejunhao3@h-partners.com>
Subject: Re: [PATCH v2 3/9] drivers/perf: hisi: Simplify the probe process
 of each L3C PMU version
Message-ID: <20250826140612.00005287@huawei.com>
In-Reply-To: <20250821135049.2010220-4-wangyushan12@huawei.com>
References: <20250821135049.2010220-1-wangyushan12@huawei.com>
	<20250821135049.2010220-4-wangyushan12@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 21 Aug 2025 21:50:43 +0800
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
Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>



