Return-Path: <linux-kernel+bounces-829420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 857D3B970E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C5897A3310
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EA9281503;
	Tue, 23 Sep 2025 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AemZ1BTB"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B4327E041
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649090; cv=none; b=qZK6C+2pui+A4K7sdGtwhiWhp1fENGdhdX/QND7VCaWXrJGBqZyHGXY9NardyPWQf00eWbcnr2p9MN6zw803rph+WFpi4BWexiZ/69VDRgcotPltP/CatjjWxEtIfM+6ATKeKMSgK7QR9Lfjo1+TXmUme+WAIRGc94qOUK+ut4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649090; c=relaxed/simple;
	bh=nKAZfoAjOKM9CWFiJ6E1W5BaQQoUhnD1jwF7C/Ohzg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KV8sLa4279fC+DpguXCXr/EAz/MorxBIQT9n6qQ5Y0LV/lcLoCrM0BOX899ybvLCa5QjvJXMTpTsn5zFyumdLlWj67wqLluZGPQcSNH8F53hi205jU54INPjpTsAVNn9+fxU+NWtPoEVeG00r+DHN6VeZu0U5dNhvY24j6HCPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AemZ1BTB; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30cce50dfb4so4417269fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758649088; x=1759253888; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZBIJqbmEZbrWURHaKZlCYT/zn1TgwW+8+aRFRZatnkY=;
        b=AemZ1BTBlQTbK34gqUlSZbT4wMx7cVUIZWf2btapVA6G6w7wnM3iSZDa78oWRnYQZ2
         YqNr+C8nLBIeHBD/48uLu7Bct2iR2CEVV+9SW/+GUZIJyHljgMIFGujyMh3gAWwvtI3D
         nTbNGMvgmuk2/wgmRo4FbRpv86dZDenMJKa9tXhVFaTdlOYa6WUF5I1W9x02K2FVhVBc
         pRUa0MaW/FkUKpIZ3h8wzsF7zhoa1Bn0503UK366Oveknbx1cWReDZegBlCG5r8oTXeS
         WCdYf9ArBWuZ3rt4txP2WxYGH+1Me0WBzUe56FlWTYO+8h+aCRcTMdTpXsy/tCEZgv1V
         QEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758649088; x=1759253888;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBIJqbmEZbrWURHaKZlCYT/zn1TgwW+8+aRFRZatnkY=;
        b=ZgnA7PRiUjMyUiOxuGuZTVzNCGZpbadfqc6e0XXK2SA65KOGLtR8hFuHkh8wqZ4M0D
         T+UlDOr+CmNwzH11EjYrJiRIJUpZdVpDOZoEwk1pj9ddUzIhM1ltnlF8TQGwEQjAgjiH
         32JkA4v9XNnR0c51Zt/NNz5mh5q4V2ano/76aZ9ffpfsYfvhUwAVV67KnDL6+N69Qv7M
         Y0qZohRtGXUN728OrRLHQ0Xu4ACQ99cnOgyKpVxo3KYzBKPgGkTOVMiDZ1juf9AMRJqC
         1PZhMxWl9Lkq1RzuJkuI4O37FRqYWw+sLCdbAXrQAyFPgqVkr13XfZr43LUhqSHMPfx0
         F5XA==
X-Forwarded-Encrypted: i=1; AJvYcCXnz8gcjhbfzPKeX6jmFicaqa/fS3pAY15q5WyaV1jbopcs/W7cys2VtOT8Yz6PHWOEooATMGsapN07W/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyJCwizDb7rQnTz7+6kM2EKFFVF+6E+bx5BJ/sIyjV3kqn5Y6Y
	xHg5uD+zD1Gnt5ZrK3a3CYKmjGdaTy/jXXz6EdZ5qLDumy1GOoHdkcpUjs9p58ZRTS8=
X-Gm-Gg: ASbGncvq6bVVDInd9usLWHJys1dX/jHOiW4feySsfu6dxXRC1YpbH7VoowiA9nPmt+U
	5CH7+K9EzwL9EJaYLoVDWTufMRu8Oz2v1E1AoBMWRo6HDXcfp1rnOqB01Soto6S7GvGtnNfTUor
	aw8/RgECfgOyAcKvVTE9B06HoGYVQEYFyCmpu7SOgGNB0wfSTfChfwYZpCbgcq/eQwZ+NsRBFR0
	i5+Y8prK3gn4DfJjRcAsX8Vhzs5yCiv/e6kIEd+2BXJMn+pKrrnSMJk8ZZSlOWb8oAciJWsslA/
	95JAH04z/6mmNFpRN406ZGjJqsr43Xsf8vck85hQRCaWWKXzDcUCha7XrV7Y/bswBz7E3i57
X-Google-Smtp-Source: AGHT+IEiUq4ZNiIQ/kvtshlpB8TY+qUCVv3sM7ttZqsjKZyYCVp5SpveErcNASTGPSdrjl/Eyj3Y1g==
X-Received: by 2002:a05:6870:15ca:b0:32f:ec51:a716 with SMTP id 586e51a60fabf-34c83545b23mr2456188fac.29.1758649088337;
        Tue, 23 Sep 2025 10:38:08 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-336e3af73f5sm9720934fac.6.2025.09.23.10.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 10:38:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v16xq-0000000AySS-4AaP;
	Tue, 23 Sep 2025 14:38:07 -0300
Date: Tue, 23 Sep 2025 14:38:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 15/28] iommu/arm-smmu-v3: Load the driver later in KVM
 mode
Message-ID: <20250923173806.GF2547959@ziepe.ca>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-16-smostafa@google.com>
 <aMQmA9cLaeYWG5_C@willie-the-truck>
 <aNKwROPzDCWgJBGQ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNKwROPzDCWgJBGQ@google.com>

On Tue, Sep 23, 2025 at 02:35:48PM +0000, Mostafa Saleh wrote:
> If we really want to avoid the current approach, we can keep deferring probe,
> until a check for a new flag set from “finalize_pkvm” which is called
> unconditionally of KVM state.

I still think the pkvm drivers should be bound to some special pkvm
device_driver and the driver core should handle all this special
dancing:
 - Wait for pkvm to decide if it will start or not
 - Claim a device for pkvm and make it visible in some generic way,eg
   in sysfs
 - Fall back to using the normal driver once we conclude pkvm won't
   run.

It sounds like a pain to open code all this logic in every pkvm
driver? How many do you have?

Jason

