Return-Path: <linux-kernel+bounces-817451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A23A9B58263
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A171A20505
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C3C288505;
	Mon, 15 Sep 2025 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GkByLFyR"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F46286D78
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954721; cv=none; b=hU3oSzs/wVJfAfTTHn8sthd2n0uaMJzfMXdyjyNUAbhUhZeOjV923ORvM9ddsPUdzbQqph8h0EsSwfHxvZm/ZJBxCbXfUHUg6udtkppnqotXj9fAOQmhB3DRTsIUQ45gS/WG59PuMRpjCj/0Y+9dFk5Z03HE8XA+mRrKVYtdUuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954721; c=relaxed/simple;
	bh=vkx6SM9gqmpLvlgtVI8pwEBIHZtD0Q9irwN6qy/aYaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSyYOIDgOu5wdS7NAjAwl6QjbjkMcPqQpEN5FRpuH3z701I2FacvtmSjnVmfk2THM0RvHzBnsb5WpmlJXRtiGaD7AtxBElR1HZV+8+mh14zjBNn6bc9+nAbrdY6rFHlO9ODzKuGwgs0DPhtMVZvyNAPy1ZeAw52lt2xGuo/iYmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GkByLFyR; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-323266d6f57so5052453a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757954719; x=1758559519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MQDjqbiT9oGuFNrzjLvyS3Lnpn5E/CxPnw6kf2pPIuk=;
        b=GkByLFyRvqxEfuYL3huoTyBK0nkCE8uRJOgfcclMmwYFbyrNOzldcYQhxYeQPdaWKm
         js1U8uCjy5PDt+ESIHwafrbpHmKJtIAzWuBpPgRrHhWsbVjCmJO8FtYpR+pBDFfDmtk6
         xvHvlm7pFFGb0bqH/TEK4lqNkQ3c/suEP5d2YA14yUZqW/by0Xs3cTrZ6RPURM08evFw
         hnavkh4sBTMsSmG5IQgB3QDCjCijCjYM7yPD/Medmd/w1mURAxR+nOIAAeBhXNaMNLLJ
         GlO6vrLlwFyvVLHH0voiNeijSy97e7pVBFQY25wxztQ+XTzhoj91nrFTgJtyrA5lVRCU
         mGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757954719; x=1758559519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQDjqbiT9oGuFNrzjLvyS3Lnpn5E/CxPnw6kf2pPIuk=;
        b=Uq5mGSNEIv1yN3igarRKeJtveznMB22SKnnkWqXp9WUTbtbpOYHRou6ClK67XxBS/j
         6lMPq+h8sUUcbCwCEdUl0aVRARnxd2UzYXalKMQRO777aRLLzih/VC0IMPx+r1EEoOpa
         1PToY4dnoI66xBmUKyYF23LRscHiPXjGlaSXK68sz3jB+P8CQLdIuhWMgT5MYojlpgVE
         1fZXSy1IpOlrGU4c1v9E6w4bNyhz00ARSEdGg8bhjGFAwSQPjpvORkUjPyXDdXZTRFWT
         Z18zBeO8i3ReFReiLk6OOoD1Oa3QTxBARCFhDQE3RdPANavn5DB5FFyDy+gg7RcufPUq
         rliQ==
X-Gm-Message-State: AOJu0Yy3dsQdH5cCVez+1UYpIuDAM/AeROJI6J8MCO3sDln4HPKAvV2x
	sLCy6l8Bqdz4drUcVYg7/iYF+/h7Rx2vYQvBv3EhGiL3HNkS3l9ZorLz8bhjq4zULWQ=
X-Gm-Gg: ASbGncskziq1fbEIIFLllRYQ2nxJxOg1ChJ+unw1aMKrM55XHgCFGr219Ux5Z5AcVf8
	NwOlJw+vD7El/ikVxrKlrA66oNfHVVDLbKO12rXLsOO+bvFpDsaxo69cEzrqc9dyPMxZ2T7C1Cg
	TN6czw3nTvir6eBHf96Cm4BOvaYLK0TE8hYqPD86TX34lJySsBQwFA9h7dq+Vykx6M4ZK4iCJgJ
	UnPW68rYNztmRzEAbwv2shabfcMlQBSfoduacqqEOWdHrQj32GT5c487X6guAmrqt8M9u+Il/2H
	iV2oSOLrK+uECWxC1nIlr7HAMmoHr6TlXL2VkGgVaIPCUXd37Y5QYlfRMKxOTTgtI4EoTPLA
X-Google-Smtp-Source: AGHT+IEueZRPYz6Ovwnbpjg7oIfp7yjCHZ9L0M0q/iZt1RonHcNLG+PurDsqJLquezOzfjlKgS1iDA==
X-Received: by 2002:a17:90b:3d0e:b0:32b:ab1f:5113 with SMTP id 98e67ed59e1d1-32de4f7ee8fmr16124999a91.28.1757954719094;
        Mon, 15 Sep 2025 09:45:19 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3aa1a22sm12075579a12.52.2025.09.15.09.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:45:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyCKL-00000004TKd-1naj;
	Mon, 15 Sep 2025 13:45:17 -0300
Date: Mon, 15 Sep 2025 13:45:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 04/28] iommu/io-pgtable-arm: Move selftests to a
 separate file
Message-ID: <20250915164517.GL882933@ziepe.ca>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-5-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819215156.2494305-5-smostafa@google.com>

On Tue, Aug 19, 2025 at 09:51:32PM +0000, Mostafa Saleh wrote:
> Soon, io-pgtable-arm.c will be compiled as part of the KVM/arm64
> in the hypervisor object, which doesn't have many of the kernel APIs,
> as faux devices, printk...
> 
> We would need to factor this things outside of this file, this patch
> moves the selftests outside, which remove many of the kernel
> dependencies, which also is not needed by the hypervisor.
> Create io-pgtable-arm-kernel.c for that, and in the next patch
> the rest of the code is factored out.

Please send this as a stand alone patch, it looks like a good idea.

Also please add the boiler plate to wrap the selftest into a kunit and
use the usual kunit machinery. We alredy have an kunit for
smmuv3, it can just add another file to that.

Jason

