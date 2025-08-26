Return-Path: <linux-kernel+bounces-787227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E92B37334
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9C87C7E03
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646565661;
	Tue, 26 Aug 2025 19:34:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78E7374276
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236866; cv=none; b=gbogAe/WRapYqKcxfvCtgTauj5rQcwpqhIoVRQ142igpehWTXBcDVcBScP0tEoESZmC0Q0utWaU1og5+ajZ5Usuon2i/wVXV13rLRMLYe5MRdduPtebxotUCV3LsQqRU4IZnASLzUQHaNaxnqx0JkSO1Newk2ObbkfAc6llOOxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236866; c=relaxed/simple;
	bh=AzsEd20oIKOwqoEREVd/Prk2kxgfE3rwxETRRbq9+Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwE8oy4hHfgkKKz7ptM+vfFmupo3+176ZZVnv485qocgTgHA4ZKDsYj9xCtkxvQkasde68arhhfpdlhLd41wDqIsjYbTVC3hA8anWMydjhFFkkpY2Qt8a0Cc4AM0uZdQNMTGxiA8ltP363T2NK/1gWDKWElfF/u+8hU4F72Axbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0ACC4CEF1;
	Tue, 26 Aug 2025 19:34:24 +0000 (UTC)
Date: Tue, 26 Aug 2025 20:34:27 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip/gic-v5: Fix kmemleak L2 IST table entries false
 positives
Message-ID: <aK4MQ3dur0cyluGl@arm.com>
References: <20250811135001.1333684-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811135001.1333684-1-lpieralisi@kernel.org>

On Mon, Aug 11, 2025 at 03:50:01PM +0200, Lorenzo Pieralisi wrote:
> diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
> index ad1435a858a4..e8a576f66366 100644
> --- a/drivers/irqchip/irq-gic-v5-irs.c
> +++ b/drivers/irqchip/irq-gic-v5-irs.c
> @@ -5,6 +5,7 @@
>  
>  #define pr_fmt(fmt)	"GICv5 IRS: " fmt
>  
> +#include <linux/kmemleak.h>
>  #include <linux/log2.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> @@ -117,6 +118,7 @@ static int __init gicv5_irs_init_ist_linear(struct gicv5_irs_chip_data *irs_data
>  		kfree(ist);
>  		return ret;
>  	}
> +	kmemleak_ignore(ist);

Nit: if you ever respin, please add a short comment on why this is a
false positive (easier to see it in the code than the git logs).

>  
>  	return 0;
>  }
> @@ -232,6 +234,7 @@ int gicv5_irs_iste_alloc(const u32 lpi)
>  		kfree(l2ist);
>  		return ret;
>  	}
> +	kmemleak_ignore(l2ist);

Same here.

-- 
Catalin

