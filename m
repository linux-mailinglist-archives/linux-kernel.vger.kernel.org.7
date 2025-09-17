Return-Path: <linux-kernel+bounces-821009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC45B800AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957EA1B22781
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041AD2ECE95;
	Wed, 17 Sep 2025 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BWfsuI5b"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610602ED141;
	Wed, 17 Sep 2025 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119433; cv=none; b=o2paIf/4MmN5laWdtfBuZMeSWHc9M7ezvAjAV2/3/7lxjic8FGzaBl1Qj6cAZ3y7Lz6VxF+1xksjamvzrM4X4xIBVd09HDs3IgdZ5vUkx4IXCMGrcTg/cndikNaa/kzVQBh7c34Zgy6aq9M61aiWT4hGG8nfemd0iSYSC88JL+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119433; c=relaxed/simple;
	bh=cj6+/2eXBy09YqfNtn5AMsUZ2NewJPSo4MWBRtD/yXU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQRe0JvwRWPgCY/2OG8q0VQs6F1fLRkNGyaCWSWkO79XlFHeD/uWgvN8rQLJ4l0YuX0oAN1oYnBZFilbzZxB6ZMink7DAtBjxRkribsZ/h7hJ1BmhNtSe9lUex/DZN/Yx4Imwo5pGrlz5S0EbTNf2uLyrY/sZLQHnX8Z3m8+t2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BWfsuI5b; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58HEUNOn271708;
	Wed, 17 Sep 2025 09:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758119423;
	bh=U9zDJhovKbcpmhyz3gEhzY99qKe9+nLbwMu+0klK/DU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=BWfsuI5bflyRxT+M7Vp+9nWqxUh09W2j/nE749ZUoc4yL2AHHm6AQACBdlB0hf0Pz
	 I9lLFo109Ks+vYgX4qy8zWeO894+F4ncVu4vP93S7PKieT/xfMjxDjpFSPIYs9shkJ
	 mfdQXfu8DyOsLAGtcNNZaR61sKesnyEFFSErIPxQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58HEUMLF1607512
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 17 Sep 2025 09:30:23 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 17
 Sep 2025 09:30:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Sep 2025 09:30:22 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58HEUMAe3192299;
	Wed, 17 Sep 2025 09:30:22 -0500
Date: Wed, 17 Sep 2025 09:30:22 -0500
From: Nishanth Menon <nm@ti.com>
To: Raag Jadav <raag.jadav@intel.com>
CC: <kristo@kernel.org>, <ssantosh@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] clk: keystone: sci-clk: use devm_kmemdup_array()
Message-ID: <20250917143022.vqp77wmu47yumwh2@revenge>
References: <20250916124518.2857524-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250916124518.2857524-1-raag.jadav@intel.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 18:15-20250916, Raag Jadav wrote:
> Convert to use devm_kmemdup_array() which is more robust.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/clk/keystone/sci-clk.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
> index c5894fc9395e..a4b42811de55 100644
> --- a/drivers/clk/keystone/sci-clk.c
> +++ b/drivers/clk/keystone/sci-clk.c
> @@ -480,13 +480,10 @@ static int ti_sci_scan_clocks_from_fw(struct sci_clk_provider *provider)
>  		num_clks++;
>  	}
>  
> -	provider->clocks = devm_kmalloc_array(dev, num_clks, sizeof(sci_clk),
> -					      GFP_KERNEL);
> +	provider->clocks = devm_kmemdup_array(dev, clks, num_clks, sizeof(sci_clk), GFP_KERNEL);
>  	if (!provider->clocks)
>  		return -ENOMEM;
>  
> -	memcpy(provider->clocks, clks, num_clks * sizeof(sci_clk));
> -
>  	provider->num_clocks = num_clks;
>  
>  	devm_kfree(dev, clks);
> -- 
> 2.34.1
> 

Reviewed-by: Nishanth Menon <nm@ti.com>

Also ran a basic boot tests on K3 devices i have access to.. so all
good.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

