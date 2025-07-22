Return-Path: <linux-kernel+bounces-741097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 708E6B0E003
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B88AA5583
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E062EB5DB;
	Tue, 22 Jul 2025 15:06:28 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01EB2EAB88
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196787; cv=none; b=Ms+VCgzQZGrfYU+uPFf5nB3TREc3UjYAxsuhzFP1IhtIHHLj0W9dvqvkDjwf7FU6EGzBPeNfbqnC0xyW+pMrklqR5wRf36jt3DB6EarGkjrgRSIPYeaNmwePjmuRm5/LhNilbIodJb9sSCyRVnwPCwnpdpVA3UpHxH7+1vaerKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196787; c=relaxed/simple;
	bh=1jZ0+Cej6ZpsPWurWvHhQrdO6TxHoqgG1ejRKx1MFIw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2v9xS58WtnNFW+ZPWSh39HtlV5NQhSk92akb7xdxAZdqB3nWxzI+YNqGRNJEsO9/SLHlk9hbKHZhg3+/VVinlFPAZCU63mrbhKOzVWXCohtSAiiZSRhVqarlUoKldFcG31nIu+pnKqZt+5LJWy3pVNvAah5CDZ68T65auy+0f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bmgY56zWsz6H7X6;
	Tue, 22 Jul 2025 23:04:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 08056140446;
	Tue, 22 Jul 2025 23:06:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Jul
 2025 17:06:20 +0200
Date: Tue, 22 Jul 2025 16:06:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: James Morse <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	"Rob Herring" <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>, Rohit
 Mathew <rohit.mathew@arm.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	"Zeng Heng" <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
	"Carl Worth" <carl@os.amperecomputing.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <lcherian@marvell.com>,
	<bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
	<baolin.wang@linux.alibaba.com>, Jamie Iles <quic_jiles@quicinc.com>, Xin Hao
	<xhao@linux.alibaba.com>, <peternewman@google.com>, <dfustini@baylibre.com>,
	<amitsinght@marvell.com>, David Hildenbrand <david@redhat.com>, Rex Nie
	<rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>, Koba Ko
	<kobak@nvidia.com>
Subject: Re: [RFC PATCH 25/36] arm_mpam: Register and enable IRQs
Message-ID: <20250722160618.0000598f@huawei.com>
In-Reply-To: <20250711183648.30766-26-james.morse@arm.com>
References: <20250711183648.30766-1-james.morse@arm.com>
	<20250711183648.30766-26-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 11 Jul 2025 18:36:37 +0000
James Morse <james.morse@arm.com> wrote:

> Register and enable error IRQs. All the MPAM error interrupts indicate a
> software bug, e.g. out of range partid. If the error interrupt is ever
> signalled, attempt to disable MPAM.
> 
> Only the irq handler accesses the ESR register, so no locking is needed.
> The work to disable MPAM after an error needs to happen at process
> context, use a threaded interrupt.
> 
> There is no support for percpu threaded interrupts, for now schedule
> the work to be done from the irq handler.
> 
> Enabling the IRQs in the MSC may involve cross calling to a CPU that
> can access the MSC.
> 
> CC: Rohit Mathew <rohit.mathew@arm.com>
> Tested-by: Rohit Mathew <rohit.mathew@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
Sparse gives an imbalance warning in mpam_register_irqs()

> +static int mpam_register_irqs(void)
> +{
> +	int err, irq, idx;
> +	struct mpam_msc *msc;
> +
> +	lockdep_assert_cpus_held();
> +
> +	idx = srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_srcu(msc, &mpam_all_msc, glbl_list, srcu_read_lock_held(&mpam_srcu)) {
> +		irq = platform_get_irq_byname_optional(msc->pdev, "error");
> +		if (irq <= 0)
> +			continue;
> +
> +		/* The MPAM spec says the interrupt can be SPI, PPI or LPI */
> +		/* We anticipate sharing the interrupt with other MSCs */
> +		if (irq_is_percpu(irq)) {
> +			err = request_percpu_irq(irq, &mpam_ppi_handler,
> +						 "mpam:msc:error",
> +						 msc->error_dev_id);
> +			if (err)
> +				return err;

Looks like the srcu_read_lock is still held.

There is a DEFINE_LOCK_GUARD_1() in srcu.h so you can do

	guard(srcu)(&mpam_srcu, idx);

I think and not worry about releasing it in errors or the good path.

> +
> +			msc->reenable_error_ppi = irq;
> +			smp_call_function_many(&msc->accessibility,
> +					       &_enable_percpu_irq, &irq,
> +					       true);
> +		} else {
> +			err = devm_request_threaded_irq(&msc->pdev->dev, irq,
> +							&mpam_spi_handler,
> +							&mpam_disable_thread,
> +							IRQF_SHARED,
> +							"mpam:msc:error", msc);
> +			if (err)
> +				return err;
> +		}
> +
> +		msc->error_irq_requested = true;
> +		mpam_touch_msc(msc, mpam_enable_msc_ecr, msc);
> +		msc->error_irq_hw_enabled = true;
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +
> +	return 0;
> +}

