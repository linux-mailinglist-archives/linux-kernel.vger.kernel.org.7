Return-Path: <linux-kernel+bounces-730282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC5BB0424C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362651A64F99
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945D82594B7;
	Mon, 14 Jul 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Cl4f8I5O"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7902C256C60
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505023; cv=none; b=fYPSdjI6F/jP01H49ie5eGzl6ZaP0ACPXPWKTbfJDOnktcyy6XA3PblJkcg/xAp3rV1txUc8cSGvqXWdejFlOb6eJp/XmcHeT7aPyjsWUgGuPRqyssRU5Qg5I9pkIIY1V3eG1Fz20j+QIcoYrwTEQOlh9LbGlNE8em6HNbKh/RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505023; c=relaxed/simple;
	bh=3IIlCMfJ4U7NeBKqCR3g3o2v6EKvqqaNr0/XybAbX4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyF65Sk/3qTHeDMCnYrjSgkKiOZiR9Y+1rf79ENyhb5rxn9asBr1wRA3iXiSVFittYlFFO/3z0aCcFwASdxy81viulRjqZUt43ZpalmKLkUuTJGfx2yrathVAGSjNQzzPpQfmZOoQdDOr+6sGHqPbXo5jguCozK0R40/pGbws+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Cl4f8I5O; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e182e4171bso170059385a.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752505020; x=1753109820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3IIlCMfJ4U7NeBKqCR3g3o2v6EKvqqaNr0/XybAbX4E=;
        b=Cl4f8I5O2wo0PJMAUBzqgMAhggbXNXjQls73Xp3LlThcAt8Yctz9ChuzIbZQXWf6A3
         zvUajhRviNxdh9nJvxB+XQqYWojbPLay89xAHdA0Ri6I4Ux2mZVEKmuZ9wRAd5fitL8E
         YuV++iJyu2MO0clj3Xwae/nstVBaXYFqWcmd+Ji9uP8Mx2BCjUe+uIoJejxPc4DRvzt1
         5ufVGIeZtiGyWWAzoB4KeT5/F+Dyb50wDmrSvNAzsy43JLS///0jM0cPvXCIXDp0+W8C
         f+Cgr838Vr619vo9j12p507m7j9o0UQNY0YwjPMruR6GrwxUBRxFXU0Fgxa4yoFsec4P
         hxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505020; x=1753109820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IIlCMfJ4U7NeBKqCR3g3o2v6EKvqqaNr0/XybAbX4E=;
        b=A691b/ZM3lw5yD+LRKHpHaqDULQPUyrwElpnLJpJSvudJQaw5ozeET38WpinHRg1Yq
         v+gAmtUA22lEcrN9rss3lwqz2gZeZUa6MpGbo2TOHeuZfolq2Xlcor8ufwxTayqwuTAW
         DBStsPW3u2Groh9ntvVX3cCFvKuI9n9z2XepVrfCgt/aOmreBBDoTtecu2RH9c62MRtl
         1+iLhR6UyUSzWsAkUlIJ27HeWv3oyAC/vkChKU8ULoxWWl36iIljWf9YgCgeuLT13LuR
         vRu88DN8SP1FtZfts63RshYufcficnla6IFNqu7qeibch4F3t1r/qVXXi15pkgkMNKRM
         +DtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdcEcAaysgXDzO3aPPHDPxAGBi1O0p2Bc2X1NoRPhuo4GXVXovBjTRf6eBXOPhSl9Ggh2L8vrgazBodRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqY7L2M/yPLCXHQndbo8wftjUBNjxJkbnl9gMLjms/+0AIMmzX
	lICl5Avv84WaEh8CJiNiDjciRgP39SM0Ue3TvSXrgfrr3edcTfEalhrDr7VB52OKJ9U=
X-Gm-Gg: ASbGncsYggRZ9l2CXX4A8cDNhiP8On7Ib4YFXY9bnJ8N88z52xy3+Q4hFstzDHOozlK
	eVN8uRaygPwyUre1slL3Kmk6BMDMQAvXl/xcOtcPDQVjlqleV5eagdliipRMwENQnpsbND1WQDe
	ZFjWf86XUuKVjsFtXbJHnig/NJelo2Bzpmg2q7y8vqz8rK/V7dgmYlmybPE54INyBH5Vr6d6eaG
	K6jkqaT7Elx3RWHvmNNCOX2qEZ35E+XKbt3++OCXvaocDnsH8Y8k1qYpaewBaJXPW5du3bP8VVz
	oRwN1RfsF2HjgeVz4bnsdXoJad8QjaDTOuuvZqiWkENtrJjkaG0lw9FY5P0MWANOGjH1fx3DMmt
	/4MaBhfqy/+Vi15c1klZ7KZ0k+xorjvDShLG3NcajttlPmQhnF8IyI3joU/A3BlUwdKXhmykpLw
	==
X-Google-Smtp-Source: AGHT+IHSuqVDpU+T+A+aN5LmCFefpJXF5cyYnF3sh/w5kcfs3RhbyD9HgdX/Ma1LQ0vovQtXH7B3NQ==
X-Received: by 2002:a05:620a:56f:b0:7e0:8503:f948 with SMTP id af79cd13be357-7e08503fc13mr1214233485a.36.1752505020201;
        Mon, 14 Jul 2025 07:57:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdbb0ceb9sm519215885a.18.2025.07.14.07.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 07:56:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ubKby-00000008g2a-1Kml;
	Mon, 14 Jul 2025 11:56:58 -0300
Date: Mon, 14 Jul 2025 11:56:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1 0/4] Implement IOMMU SVA page fault processing error
 notifiers
Message-ID: <20250714145658.GH1870174@ziepe.ca>
References: <20250710134215.97840-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710134215.97840-1-sergey.temerkhanov@intel.com>

On Thu, Jul 10, 2025 at 01:42:11PM +0000, Sergey Temerkhanov wrote:
> These series contain changes that provide endpoint device drivers
> with the ability to retrieve information about page fault processing
> errors (the most relevant being PASID and IOVA PFN).

You need to come with a driver using this as well.

Jason

