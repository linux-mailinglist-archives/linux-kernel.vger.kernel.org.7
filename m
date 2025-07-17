Return-Path: <linux-kernel+bounces-735100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF52B08AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B39F1898657
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D3F29994E;
	Thu, 17 Jul 2025 10:39:56 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A393E28B417
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748796; cv=none; b=IVKdXxx6mN+cnnYgVNEEjFtN+Qx0IQpT32pj6JOQqW/CEd/iT1lAV9QpLmOXvSQg85L7RWkx7ZGZflNXd0KjxnGjb0PjfhhK4hfnNgoY9SzmxHTeBmsHqxkChQ522oRADFiC+UcW6LeBKC4IY5faFFcln+hJx1je4UQGT+pp5N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748796; c=relaxed/simple;
	bh=2GTjSLGWUJ/j7i++Ob0ccnd3+sw0zNB7PEVVFPQWsaA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bLNoXTD8TF1QFRSbYhQ2ZGyX6JgIatiC4+2OUDzRw0s0dtuk8hxmXFdjTqPMbGujFkInI9moEzlTe6Aq4J5GSkFUn2yE1COqTJ3DYZ6nSNJrMMh7kLxifndgZS2VmuUtBmCxi42fzHEaPcB9cDXFpBscK0HCwevW1kYRVVlUNe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bjTt64g9hz6L5Js;
	Thu, 17 Jul 2025 18:38:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 71655140371;
	Thu, 17 Jul 2025 18:39:52 +0800 (CST)
Received: from localhost (10.48.159.214) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Jul
 2025 12:39:51 +0200
Date: Thu, 17 Jul 2025 11:39:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<hejunhao3@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <wangyushan12@huawei.com>
Subject: Re: [PATCH v4 2/2] drivers/perf: hisi: Add support for HiSilicon MN
 PMU driver
Message-ID: <20250717113949.00002eff@huawei.com>
In-Reply-To: <20250717074138.39903-3-yangyicong@huawei.com>
References: <20250717074138.39903-1-yangyicong@huawei.com>
	<20250717074138.39903-3-yangyicong@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Jul 2025 15:41:38 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Junhao He <hejunhao3@huawei.com>
> 
> MN (Miscellaneous Node) is a hybrid node in ARM CHI. It broadcasts the
> following two types of requests: DVM operations and PCIe configuration.
> MN PMU devices exist on both SCCL and SICL, so we named the MN pmu
> driver after SCL (Super cluster) ID.
> The MN PMU driver using the HiSilicon uncore PMU framework. And only
> the event parameter is supported.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Looks good to me.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks,

Jonathan


