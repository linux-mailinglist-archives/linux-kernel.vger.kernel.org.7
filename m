Return-Path: <linux-kernel+bounces-843286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ED6BBED70
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E202534A8D7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C6A248176;
	Mon,  6 Oct 2025 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Azr4PsSJ"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56B421C179
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772789; cv=none; b=mGxdNDkuP6Lz6pLJ54G4ArsZctrAt7xjPiDnAWV9sMDHlDFYH9khM+422aESJ4Tggeldf+JWv/JBKltSi0R7d8TzhMyYHo6O739bPVIkeOSHN/+XgFH5/cA81j9gSwK9grhbFrNQ0rarUk6g2BTNZ2uxMJ/K939AayGyrSfhGkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772789; c=relaxed/simple;
	bh=BGtlhNEOznmLiP8Td9R6UOdRpHKv83zIL/Fw14yz6Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiBvkGuMMRoZc9x2K3RCx5WT9mAi3I0yNOFHW99sOT5EX5eZnOs5pa1dzwa72ndUgiOveoWM1W4hNkzPMdHS+48oL5Og0XP2f6d+PpNXO0b0pHG8bFTiTRPpX5/gvc8hug5Xs7dnv3+iuuu3BUu05CpZtv+uAgz03nUTMEQ5nD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Azr4PsSJ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-78febbe521cso58294066d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759772786; x=1760377586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mV5BjCFzof/sFlEEwNlSlREaw9vi7GsMBGBoLtecLf0=;
        b=Azr4PsSJmwu73Gq7Q6Wypi5cfiPLOiVgHe62iNVFQIT2UeiPtoxrSH8FoKrDTsbNEw
         mDkG8AU/tCr0NBQaJn1zHy7eAxy/PCApRKyDMvQ0eOP6Od4zmwZN7KumzY+jdJBKGS4o
         /Ra74Jk5lMSuRpb9tNSDhTDbae1CXonczD3KAjtmweekGaR5WhuPqU/8zumVRK4aln4k
         vGTsqUM/RlU72NWhH3yJHqDKsNBakxrQAMKNgsGhy28aVa7eCKROl4Lv8fBLFAsM7U6E
         5ymnH62eP7+rBviiuIetXZLc1lJWfgZfpFGZd+2dm87edorWLYDCnqT9L57IGOUnk0Dp
         vi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759772786; x=1760377586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mV5BjCFzof/sFlEEwNlSlREaw9vi7GsMBGBoLtecLf0=;
        b=D4cLBXsVyOFqtAxq4EHXQXRgTUg7RUgzSVwgW3VFoObMU4qE1pcLDtZJEF70cVnq0F
         sTASZS0aDAmsBvEb9eMs2JCnALFtnwhzZq5ynSIpHl6b8HbThD1syrAfo4BVEolFFJvL
         SKvAqP29Gu4X0KRC48U8PG8MDC0bz+dY2Y200fDExfKp0zlvUCSFXRel7G4T0LhRlom9
         KD5Gs/QqxfSw4vZAoix9nC2arbQQlavpnTGeUldDxANIsvwCH1DcCWBRDJDnU5ldXAdN
         V/pumnhOXe58WCbiu6Ww1hPia5gCgG4ot6/v/1Cl0QUbsmfZiDtDqGIzaOeNAV1AjYO3
         NTWA==
X-Forwarded-Encrypted: i=1; AJvYcCWGLGuvM5808UPDAWsdRJFMNCMDjyYWGbaTVteK6UJCQUFYEvCwJvCGO+5Usvov3UK2PjSMNe9LpGdww0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQGy/wiYeD2/6zevqYZNrmS9yAjGtO30vk+mLYEAd7U0lP7Dx6
	DP8U71Qf46RRxuKfaSoA/fs0kv923+8UgGTb2yF2uvXhVPAjzWxmTsfIZaoCmMLCnJU=
X-Gm-Gg: ASbGncuLSsX+n7ZKSTt2bs/QjEk40nfM2FTKzUxja60rp4IatM/B/AV2yTY+Lgp/kQ9
	osA43lASssNCOAWn0d165gUJBMc+/nHa42B2pCBKvE+e6ybbW5xOocf0wiDhUAk2ls6hGr9ehKH
	j/+IBpmS6CsJGGEg4XcLs/NSriwqb8P5APEBTY96g7VAN2YnTx5+hO3vfDsuNEoo63k21Qq4baa
	yzuXLn2wstIMd/ToQIKh3oE+8QMyfNOt3GTxxTPlSX2sgbdMSRTAm1WLBPt/YokPmA11nMvDlLi
	NrlZBlcCwugWO9liRnToyNDefJJfduCtQPferfu4F/W5gTt6Cv58yB5Shw8w5n6B1jUa/mF0rBl
	VSid4FfJKm54CK67g7MjtAWHY/uNQSmVOX9jRPYelJFrL7O8VfP63zDJA7dc2ejOscUpB8YSwPL
	SZ1qReHxtVZVSGKCQLanvq/3akbtR472m9KY9VXVEK
X-Google-Smtp-Source: AGHT+IF/GPa4ozi9y7BOzBQqoUumY05J+0iFBW4qq7MNJrp4XZQ1zNaIlGSXGXlJSe7DbRBRRQjNVA==
X-Received: by 2002:a05:620a:4709:b0:85f:82c1:c8ed with SMTP id af79cd13be357-87a37cb2f16mr1907191185a.37.1759772785714;
        Mon, 06 Oct 2025 10:46:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-877796a1de6sm1267593985a.49.2025.10.06.10.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 10:46:24 -0700 (PDT)
Date: Mon, 6 Oct 2025 13:46:23 -0400
From: Gregory Price <gourry@gourry.net>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robert Richter <rrichter@amd.com>,
	Cheatham Benjamin <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 3/4 v5] cxl/core: Enable Region creation on x86 with LMH
Message-ID: <aOQAb9H-wIxc6j31@gourry-fedora-PF4VCD3F>
References: <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
 <20251006155836.791418-4-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006155836.791418-4-fabio.m.de.francesco@linux.intel.com>

On Mon, Oct 06, 2025 at 05:58:06PM +0200, Fabio M. De Francesco wrote:
> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more
> Host Physical Address (HPA) windows that are associated with each CXL
> Host Bridge. Each window represents a contiguous HPA that may be
> interleaved with one or more targets (CXL v3.2 - 9.18.1.3).
> 
...
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

Couple inlines but just nits

Reviewed-by: Gregory Price <gourry@gourry.net>

> @@ -1770,6 +1778,7 @@ static int match_cxlsd_to_cxled_by_range(struct device *dev, const void *data)
>  {
>  	const struct cxl_endpoint_decoder *cxled = data;
>  	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
>  	const struct range *r1, *r2;
>  
>  	if (!is_switch_decoder(dev))
> @@ -1779,8 +1788,13 @@ static int match_cxlsd_to_cxled_by_range(struct device *dev, const void *data)
>  	r1 = &cxlsd->cxld.hpa_range;
>  	r2 = &cxled->cxld.hpa_range;
>  
> -	if (is_root_decoder(dev))
> -		return range_contains(r1, r2);
> +	if (is_root_decoder(dev)) {
> +		if (range_contains(r1, r2))
> +			return 1;
> +		cxlrd = to_cxl_root_decoder(dev);
> +		if (platform_cxlrd_matches_cxled(cxlrd, cxled))
> +			return 1;
> +	}

Is there any concern for longer term maintainability if addition
match_*() functions are added?  Or is this upkeep just the unfortunate
maintenance cost of supportering the quirk?

>  
>  static struct cxl_decoder *
> @@ -3406,8 +3421,12 @@ static int match_region_to_cxled_by_range(struct device *dev, const void *data)
>  	p = &cxlr->params;
>  
>  	guard(rwsem_read)(&cxl_rwsem.region);
> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
> -		return 1;
> +	if (p->res) {
> +		if (p->res->start == r->start && p->res->end == r->end)
> +			return 1;
> +		if (platform_region_matches_cxld(p, &cxled->cxld))
> +			return 1;
> +	}


if (!p->res)
	return 0;
if (p->res->start == r->start && p->res->end == r->end)
	return 1;
if (platform_region_matches_cxld(p, &cxled->cxld))
	return 1;
return 0;

?

I like flat, but I also dislike not-logic.  Style choice here, unless
others have a strong feeling this is fine.

~Gregory

