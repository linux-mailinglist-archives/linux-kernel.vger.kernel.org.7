Return-Path: <linux-kernel+bounces-786698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FEBB363AA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10748A56AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0F434A304;
	Tue, 26 Aug 2025 13:22:37 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C82345732
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214557; cv=none; b=G4atEEZENt3GAhPCoIqwO7sIefAj+iQyneMJUZDd9VvZXjKLYBtRyn+sZUGUdapQDhj6zVx4dJizT98xepR9jG+oqBwRor2DO/dQK2e5EVCC1JIVu863qbatrqsgro+Zlh0ol370xUIGWA88Aae9nG/m50IiunSX0LHGKJFG/Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214557; c=relaxed/simple;
	bh=BYcur8mV/dcpB34SM5kezxjh36DpE1hvRGAA6hpORUM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1mhvjP2k7XK1TheBNQ42ul6v8oi4PTI9zMVCpEr7ZiFvTVMHlF8Xs7eekwCqRNERBty91VTmulemKPAx8yODqefGSa0LPvT6CKXnfOAzL2usSnCnrAYa6/Yru8Bi7P0mdLvzjsLBy6wISLMmszLceiEemx/LVqo5l5wXUJg98M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cB7c95Tg0z6GDcJ;
	Tue, 26 Aug 2025 21:22:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C3F5F1402EB;
	Tue, 26 Aug 2025 21:22:31 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 26 Aug
 2025 15:22:31 +0200
Date: Tue, 26 Aug 2025 14:22:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yushan Wang <wangyushan12@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robin.murphy@arm.com>, <yangyicong@huawei.com>, <liuyonglong@huawei.com>,
	<wanghuiqiang@huawei.com>, <prime.zeng@hisilicon.com>,
	<hejunhao3@h-partners.com>
Subject: Re: [PATCH v2 9/9] Documentation: hisi-pmu: Add introduction to
 HiSilicon
Message-ID: <20250826142229.00002092@huawei.com>
In-Reply-To: <20250821135049.2010220-10-wangyushan12@huawei.com>
References: <20250821135049.2010220-1-wangyushan12@huawei.com>
	<20250821135049.2010220-10-wangyushan12@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 21 Aug 2025 21:50:49 +0800
Yushan Wang <wangyushan12@huawei.com> wrote:

> Some of HiSilicon V3 PMU hardware is divided into parts to fulfill the
> job of monitoring specific parts of a device.  Add description on that
> as well as the newly added ext operand for L3C PMU.
> 
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>

