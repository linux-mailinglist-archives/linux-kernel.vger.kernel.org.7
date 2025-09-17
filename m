Return-Path: <linux-kernel+bounces-821642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B267B81D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602921C23311
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0722C08AC;
	Wed, 17 Sep 2025 20:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="k3FYtjxT"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35BE25A630
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142380; cv=none; b=A7FjfIV/2anAuGBWGYALjcfllX0tHDyX3iRYSE+isx64LZBsRXmw0FyZCv7mE6Ld5sSUCh2wUCtc1tkcjJedUaaoFQHMxDpq4LOxd8Ksdl/0A+kwJWnOvPvtb6L8DbNdEiKMaZQhexWGiJK4pVv2EI7PqczrtNU+TbSwtPp4LEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142380; c=relaxed/simple;
	bh=vyVcKrjsi5rK4rxpJ2J+62BpiNtzCyvjQ6i5MbvZYaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gb6JyY17oNZ+ZL4C1UmDGuLKCq6ARlxqsdGHw8pgkkA5l8oZkYoU4npuWrI99kGsSxuax3uD7/fljbYgHzsKo7kLctUFNTeNOD8AH7C8ZTGsac4MNGqKDuNxAAiVdYrOdTXyUpJzHAE1cLLvF8M2FwM2IDkcHiMEteYfgXJ+6N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=k3FYtjxT; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8287fedae95so34622485a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758142377; x=1758747177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Slb/89aiZWbtb1+MHqNTYU2kFl97qu67CctbxFKmgbc=;
        b=k3FYtjxTHDzwkMPd5GJEkRFr8fdqAFbPuulkg7EtXvq1L/RE7LwKWgftqH/Yy46PTD
         LT+pO7ts/6c1PJGya3k5GHHNOu5GvFoiu0Nc4SoNzoex6PJkcuCL2aNUVDDkffQgpvAf
         xv7vMwOyoa1qNv62Q4RPOL8ceTscqZFadhb2il6VdAROU8c8hoDptxn2ZidGrZ1pYDX4
         H4cwgCe1fsdumIi8BKK61VjSvh4rJc+Hh2o1HlLscuJbqL4pPXzUVBKU5qmuC39tlwIp
         eHXbqkLV4oThR6CXLSbWvfwiMwLQl0castCemdAht4dtRbUgx5wrJvb3OH5s8VTfUVhV
         tqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758142377; x=1758747177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Slb/89aiZWbtb1+MHqNTYU2kFl97qu67CctbxFKmgbc=;
        b=qI1fEciqSeiZVyXkMug2gVMh2fMAhRcXvg+OU7K26vfO4OR5BdUr8OnGBW2gl7/r16
         65sw0SgrADkqIc725HHCsXu0v8y22k7wTtkd/AxNvpGbTZqzCivkxJd+jG/v8cA1bBEk
         at/0ZfNmQpzh6nEj77vXUVi7OI9fI6dz88tMIGG2MpDZbqQbuJi64e46UbzMu/Q7t62U
         hD+iXt5aMF3t62H0AfHYytJdaqfp5mPvUkLT5p453UoMgRlB7pv+SPChhcxLVLVHvKve
         1zNv16vSZpA3bCH2FvqpOU5lj2dztdYyi6Wo+jR113N8qxiHPdCixBJwJONIIf1hpVQH
         ln6g==
X-Forwarded-Encrypted: i=1; AJvYcCXEUCCuwbvDggC3eSflvgvfYLLdJOOMGKA/1mCKv1BHtt5IdU3WcbNrf1RL8Hz7oNoAKZIzXEQygUpGOAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl3oI9eAvvv/durLNqTgmT4fWbI/k1OHtzX8M7PEdCYiTSJR30
	+B5XXWzV0XoLlcnBhEauFL/Jh5g4hcNp1QFO1pts0p47lJirHZiwwLREKRX0OLU0Bt0=
X-Gm-Gg: ASbGnct1NtxFi0hhxPaRethutJwINu23iQhpSuRKVWVIsUEwVo5Coy8rEY+9JWoTURX
	1F1mirsgZcvAF8AZDxP0Oa2EGoPrK77/jygVE5piODirTsGs+DOBLWw/ru0kYvUXtpuyQ55g3zo
	pR3eD54MvwwF8aOHrXawaCbB3gD2paZkNahY+YTHTC5E0TnRyoTk5LbdmIsokIKrS3upezt4UXG
	PsRTV9r7FDx17chqnsK2mXu/TGKMBzLpYLPWuC+lWcAPndPQ8UINVqsF6JWBGX5XDHotThs+aiv
	o62BVm+Hd4UPOlOyD3Y7xe1mw9UVh5keYiBApHqwClGerXpVB6uVFjLO7gUX375l02KjBzsMMzJ
	HVu6qACcIvVcaDXS0QkDR6a/xi4RTBmf5SgxRtIUj9+o/KWVAxWeAX1GgPHRX3NQm+WrPVHq4nN
	3XYoc6beBIgwzJWQ==
X-Google-Smtp-Source: AGHT+IFdINzcp5ACzbS6sICuhrGg2dW+wCoDRQzC+nV6ZAWpS7tnpWl27o6tLSuka8FSPl31p1uORA==
X-Received: by 2002:a05:620a:170f:b0:828:a0f7:7aa4 with SMTP id af79cd13be357-831085ac45fmr515569585a.23.1758142376686;
        Wed, 17 Sep 2025 13:52:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836278b80bbsm44715585a.25.2025.09.17.13.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:52:56 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:52:54 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 09/11] cxl/region: Lock decoders that need address
 translation
Message-ID: <aMsfpvHmTlfJVMK3@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-10-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-10-rrichter@amd.com>

On Fri, Sep 12, 2025 at 04:45:11PM +0200, Robert Richter wrote:
> There is only support to translate addresses from an endpoint to its
> parent port, but not in the opposite direction from the parent to the
> endpoint. Thus, the endpoint address range cannot be determined and
> setup manually for a given SPA range of a region. If the parent
> implements the ->to_hpa() callback, address translation is
> needed. Then, forbid reprogramming of the decoders and lock them.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  drivers/cxl/core/region.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9fb1e9508213..44ea59252ff0 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3497,6 +3497,16 @@ static int setup_address_translation(struct cxl_endpoint_decoder *cxled,
>  		return -ENXIO;
>  	}
>  
> +	/*
> +	 * There is only support to translate from the endpoint to its
> +	 * parent port, but not in the opposite direction from the
> +	 * parent to the endpoint. Thus, the endpoint address range
> +	 * cannot be determined and setup manually. If the address range
> +	 * was translated and modified, forbid reprogramming of the
> +	 * decoders and lock them.
> +	 */
> +	cxld->flags |= CXL_DECODER_F_LOCK;
> +
>  	ctx->hpa_range = range;
>  	ctx->interleave_ways = ways;
>  	ctx->interleave_granularity = gran;
> -- 
> 2.39.5
> 

