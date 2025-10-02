Return-Path: <linux-kernel+bounces-839843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F415ABB28FB
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 07:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6AD17A3756
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 05:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4A0255F28;
	Thu,  2 Oct 2025 05:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="G3nqAeIc"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6774C1482F2
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 05:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759384142; cv=none; b=pQl0TFBYzpLfXyThix8teMkbH6A9v9U3c0SN8vu/3av8WmPitN5/fBUZ7CbVwhp1sz2BxRSMRTfGPuDMnhLTVVZxEdYcip17UGAwpR/F54IjL6gaGXIfqKduLd3NKAhCuFRsN0ICyzF5Wwd3vx27hPVYrfd673r/M/X9VI0eRDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759384142; c=relaxed/simple;
	bh=wcyEKCO6iRV6aRiIOdMgZ+yCTGNmYXo0JcYAp+28Yd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbmYcfr1CqybGJer05KkYqK9sjIiBRs2nhlUjvXXGmSaR43rFdhXjykJvdmS/klte2lOibBaKmiK5zs0vBye2CK0e21SCCB00kP3KQ48pUDMW7WGPavbFEjGpRHN4AVV/zZj3gIHYFXhIxy/4BQV+I29D0KlBE4o3AVK6X1Wxv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=G3nqAeIc; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-87808473c3bso61448785a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759384139; x=1759988939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qPH+KrW9WWxU2Cy/czL4pPvnzuAqDNan3io0ryUNydQ=;
        b=G3nqAeIc/mS1fO15vQgOaDwngfytKFhNUSMKc2SpvBo2aXD7QGRZNFocVFAX9+mM9c
         q8dAxt3lzh8EqWhT8wtli9iPsGA2fyZyHaEVSykxAZjdtZHSXcGS9DIyQDqe972odGpr
         z8nWRYyE0YjtMv82bk+FiLW1ouIFZPD1pEJJIkgtoTfAEOOjJeE4tk2v4cq7HAHSTdZU
         rD1ajaF2/8cPlSRg3yX8vmjbfz4tm93Bs7UQf1cta4iprv41ygNaUEqzvwrj37URyc60
         Q19XYtg5oX6up61l9iLgy+xtUVLP9tOw+NN4m54rVR2YqESzPbZM4dcbSjL0nSc7C+uS
         VLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759384139; x=1759988939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPH+KrW9WWxU2Cy/czL4pPvnzuAqDNan3io0ryUNydQ=;
        b=SEClsjhFVvh38lD+Ju0ZHHyZntANXPOschsPlBafyyVD42HieeIQxXJC8ubmtl6z3T
         2B0HwzoDLJc/Q3Ap49LRRqzRfk4WAK9QZnYVzW1czv1kmhQeyNBqSfMg7bkO7hvrGynp
         xVenIBV/2IQzOyT/FZwW5S66VvJZ9lbsGxbOhRGJXzN8/mED9BDBxN55kv66A3NqymsP
         kCVu3zI6RUrrKQSYs+P40qrmuwfIQBuqJtzBXjbQBnsnRRfyJwcBp2zePYBFm+k+1uqC
         ZN//lt3yvkuAPXWnMZLFgIkIFGc/Egmk+jxx+o2NweOT+AhoEslyIjYM7jPOHX48X3XM
         WPnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCJ0U3mIrxg6fxSJZk559OrmTtTj+2Q8SgU+jnv/f1qJG4ec3DmaR3qWo0zsC0juAUL2PFDJP2YoffaaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1n3SODgcX36Rrln6i/LjlktkmnmKk6ji0oKPpbm0N8qaKLl3J
	ncMyZqRs1mwPTxA3bGozF66lJC2YVTUHqpWR79jF7H8g63mjcvb2L4gbd2eAu76g4kw=
X-Gm-Gg: ASbGnct17U5ftslgfSs5vsGslhKQeHrBZRyxI74zqvFB+v8QJ3KTYShGx9ZDO+4OsEc
	ouI2jrA01N5PVPg/0IZ4GTGMfypXQzw9w2bm3Qif5QM4lNUrxeClQMGCHW/i8DpT+BQCIF8hiCx
	3tPSbIG3cqrlUzfkolM5HmrvaEwZiuu/3M++FDZmJodG2cbZO2HXaknERwr8+W4vOy2QE4Ecs8V
	vhojoQiJS2fJCbALx54merRYNXm7I+O2Rpkl5RXnW8AurDdCZqXuPKmTX3ir226S2ZIYC/8DKEH
	isbNes8TJJubvI+d+gl6JZTlamcnva25n2aPgnLoN5Cons2HGVQPN30RVlGwkQq0qQd8Ftw21Ob
	fwVxT4SgbeCuz4D6VKU6XsEKmPpQJuvAIEUAf03Tx1c5ERI4EfBAwfWArqis///ORr5TRU2GyaN
	vFVyWqji5dErdhpBmy/mTM6RWCnjQmRg==
X-Google-Smtp-Source: AGHT+IEhx9gZlJzZ4Qi6qF6wm60KnmFGKzm8v1QKTSYmj/krU2YemQjmdbWHw9GBA4Ia0vSPsAekKA==
X-Received: by 2002:a05:620a:a08d:b0:877:8704:2c1c with SMTP id af79cd13be357-87787042c37mr230208885a.47.1759384139185;
        Wed, 01 Oct 2025 22:48:59 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87771129fdasm149560185a.6.2025.10.01.22.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 22:48:58 -0700 (PDT)
Date: Thu, 2 Oct 2025 01:48:56 -0400
From: Gregory Price <gourry@gourry.net>
To: Vishal Aslot <vaslot@nvidia.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Zijun Hu <zijun.hu@oss.qualcomm.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
Message-ID: <aN4SSEmaCaxbeiwJ@gourry-fedora-PF4VCD3F>
References: <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>

On Wed, Oct 01, 2025 at 08:37:26PM +0000, Vishal Aslot wrote:
> @@ -1210,6 +1210,11 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>                 rc = init_hdm_decoder(port, cxld, target_map, hdm, i,
>                                       &dpa_base, info);
>                 if (rc) {
> +                       if (rc == -ENOSPC) {
> +                               put_device(&cxld->dev);
> +                               rc = 0;
> +                               continue;
> +                       }

How do you suggest actually testing this? I briefly poked at this in
QEMU trying to commit decoders, but i found myself incapable of
exercising this path.

>                         dev_warn(&port->dev,
>                                  "Failed to initialize decoder%d.%d\n",
>                                  port->id, i);
> --
> 2.34.1

