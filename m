Return-Path: <linux-kernel+bounces-752099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0892CB17132
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4CC1C228CA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DA92C327D;
	Thu, 31 Jul 2025 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ELYgUIZw"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEB22C1594
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964780; cv=none; b=lB6YvBkZwvbHfEFzgmBozgd5Pznn4QfgGEIYO2mXkH8UIVPAuQlSh+gH2n4xI/USP9MKuJUuCvqJqkTaynFNau7kbwQKze9TS/xpVPy7VfIwE1PYFEuTnPx0O2EWhUVNN1td4BTSMUWD335iLmltxfLcU36xefHTiP60m4xqnIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964780; c=relaxed/simple;
	bh=DdxvPDAw0mc8/2mcJ0LEU5pxZezLf4CuYkBruMEyp5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCa1fsAiYRe+FquCL/ei34CLOPOdJuYUjjtmJMt0s0fqv+3bo3M4XITYmoP3Muj0MC7mpuIeH9ptNwusvpvYh3HnrM67By9jAIvkeOMpNoWWIPD2z+qDpQ4CRhtI1vilWIihml9NUFOKexTSm4psvQOMkpgF2QBhJph/0kZyd1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ELYgUIZw; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70736b2ea12so4852736d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753964778; x=1754569578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I0UTzXjMbQLF812F/cBlHHlhQP11knn9ieRgsIR0U4g=;
        b=ELYgUIZwQIAsqNJXhbwDMJCt9f6I/9ay7kMdcYgEIjyOqdd69Q19PwR/ZLGDCPbTuK
         Xu8O3YHl0OTsJqyYE/U6mlbRY0hIu5rg0npaN5qXpF+CN4nuAM1kob7ZPC3ynU5dSanW
         m85S/26N9/v6OyltlLIZPa5n0n/Xji5coPmGmruVwsgRueDAq23UKW4tcYbZL+KUSpqb
         kyXeuNZB2Wv7Z2miCRlqIB5hRgxg9fbR/9ZfJMyoQx1iWR+BdIXnxIrO7QBLnXP6K+e2
         e7/3v6lMVFPJkZ7W/YKmXN0JvQBKrZMvkULZynYcPhRYTSH+u2YKjXZggfe4vCKy1xP/
         qKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964778; x=1754569578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0UTzXjMbQLF812F/cBlHHlhQP11knn9ieRgsIR0U4g=;
        b=iPwvwGw65C2GJ4FFb8UcU6qb9EuW3qCrNkTuiKT75cgb2Yktb9i0Z6L3mOZXd/YWl3
         oFjQNfQbjeTT6JvmCiwkNa1zSdKbTfhVnW31qBCpEiNBHs/mfX4+kjZKwySYkRMMZDi1
         N5B2CbB2TJolLsBTlFALeyzCrDcm2NppHYr94th6NEhtGvrm+SRD5xzhnX/Tj5FJHwxh
         pcge03HAjPUubxDHKmeMFqK0viLWh9zlejcMKVb9vMsRR8ZKgYLUjxWFCJdjWSAW6bow
         aSys/9tNGH2YFWpIHgmSMAeq8/CPbHHgTvfdGUvigx+0ZWtt5EPQahNJfDi8HB7NidwH
         XNug==
X-Forwarded-Encrypted: i=1; AJvYcCUq+BvnvtAinCZbzwGl7IBkqIfAEORJtapX68n9r/wO6GLPhG8NuWfsqQfRWj9gMOcf9u2VFZG8zPx/cSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRdTiT12EnSb8D0+yWnGtf8q0/E7rDK1OS4j8B+kkXahR6A/BH
	QVcxE/5IXBuhbk/C+Kyj5zPhFxdGniye4RQGvfpnQO5Irb+U6pLWffTvH7mmUtHN2nXXk0MUsyI
	yV76J
X-Gm-Gg: ASbGncuCiWB3d96ncyJaA9MjCP7OdL5xYzH3PcZKCQJ0eDWIiQaXfsAVQ8YTtcXSR17
	zhxH/DaQuum7XNLE4fkMDLO2Zynu+T0uShITorRKZt5b72uboz+CAjMR+jyFVaI549SlH5MVYA/
	mZgaZctAHoxzkntzR5HLyCiPGvabchXU2IQVcI7d5VcQLbugr+1EfilTmZN/g+71D4//Qk4eBqh
	W3ZAoiVZQPZBS+eLYiBmzxtzB16bgyBQdRlXYGnIQ4jMFjES3cnNh1cHt3aj/PxmlQu2eK5CA9G
	frzfN08PggsQIQlgCdTMaC2zEa5SQus/f48QfE5snuFpom7I9IxnBtmW0LSZ1kWMeeGYp3NDVAK
	N+nZpK7u4eK0FJE1lRQx1yxZc/wVpBTj+QC0/7PiHb2HhY7Sy9eSTCZ8GjZV4Mxs9FWMr
X-Google-Smtp-Source: AGHT+IEV8Gmvc00o50P6OQKANpqFcknIb1Fql8SzhfROvZ160cWgmtvbR5AnJBSI+9ww0K1Z9AZwLQ==
X-Received: by 2002:a05:6214:21e4:b0:707:4daf:62d with SMTP id 6a1803df08f44-70766f89168mr126988486d6.21.1753964777814;
        Thu, 31 Jul 2025 05:26:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9da870sm6583536d6.1.2025.07.31.05.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:26:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhSMS-00000000oZ9-3Vfz;
	Thu, 31 Jul 2025 09:26:16 -0300
Date: Thu, 31 Jul 2025 09:26:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 12/38] coco: host: arm64: CCA host platform device
 driver
Message-ID: <20250731122616.GS26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-13-aneesh.kumar@kernel.org>
 <20250729182244.00002f4f@huawei.com>
 <20250729232243.GK26511@ziepe.ca>
 <20250730112804.00002629@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730112804.00002629@huawei.com>

On Wed, Jul 30, 2025 at 11:28:04AM +0100, Jonathan Cameron wrote:
> > devm is useful to solve complex things, these trivial things should be
> > done normally..
> 
> Sure, that would be fine for now.  If we end up with a large complex flow that
> happens to have a tsm_register() in amongst various managed resources
> we can revisit.  If they all end up looking like this then a manual call
> in remove is fine.

IMHO just don't use devm, it is so easy to use devm wrong and get out
of order clean up. It works well for extremely simple case where 100%
of cleanup is in devm (but then it is questionable if the overhead is
worthwehile), and it is necessary for extremely hard cases where
writing a manual unwind is too hard. But the middle ground it tends to
just make ordering bugs and not provide alot of value, IMHO.

Jason

