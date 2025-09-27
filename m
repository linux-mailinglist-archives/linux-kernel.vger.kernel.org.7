Return-Path: <linux-kernel+bounces-834775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AAFBA57E3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 03:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC34E380388
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 01:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA51208994;
	Sat, 27 Sep 2025 01:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gan/JCB3"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1A31F583D
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 01:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758937489; cv=none; b=h+SM0LMh0tvAdBE8ZG35TQrj6GcW6QEEjqWG+QDbKethBLxTZp8KDX1Bv11Ilk/FqXa391GEJ83SaJQBvIhM8B+yxmgCP1ePAN5hdxrHY1oe1IDiHvMKU0v9cMvYhnuDOXoQbUAasmgoBmB0xn9xpwMCmHrYNM3+4INdPTi9/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758937489; c=relaxed/simple;
	bh=dqdxCmArGa9yxPqwCNkcLXOI22MJukoEgJBNjnFbuNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuloXkjQReO0Kg356M+ArQZ94duuWXn5XRagYnUAZkBvAdBm+HFThSObYB6QMZoSRHS9BmLcR108f5qnGaECfyKliMG4YotVYXg0sH6LoAAmy9O01dEKvvWI4NIe66irSDUOVTOht3eTOr/pGgTEDSfUtBkWvtXYowbX49NJtZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gan/JCB3; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-85e76e886a0so167036285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758937487; x=1759542287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eLtYuDKI14SpP+23oPAYnH6nmb86y+sxjILKpo0x83o=;
        b=gan/JCB3r0kQMyh/Fi1W/RGWqgJipINImCGgW1AQA49Kx+QE1qBkn9QgKwzXI10Tbv
         EjmO+Lnw5v8Sckc8irHAODbNZRMFXLq8shvfhwURtnTCqVFedK9dXDJoa1a9wUlEj/NG
         Twhx92eGP5je7bj24VethvIovxAh71yOJYLkGxPfgPJMErOC9lrmNvhlgFhHh43fUfDf
         yxve6BOK4fTQSjZFKpAb1+x8g9fxDChbakeaYo3P7mqnmxXBcdmboEhRpg49rtkdpw2V
         Pbfcq1ApfVkRxUczAxUbecMIgXeHA6j+Wg3hv+z92yjYASo6GCYkJjkeVLbdY+JGVsjH
         uSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758937487; x=1759542287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLtYuDKI14SpP+23oPAYnH6nmb86y+sxjILKpo0x83o=;
        b=BiBS7R5uLQaAF3kixeZlACIxTY1FRnrY2xaH4mZ50xtSTlQcjaW71+NCwChdjgLUu3
         z5RXUoftiX3nc+De2wd+6mQs0m1mhZRvb3tp7D1DVztbs+E/L50fJH2qImyzIUZvsO8S
         mJnkMzE4YAGQ6i1xAUawz4OjpAnkhbX1MYvWomHUNo2gOWkuNVveFINShNaCJBNCv2Zb
         iXPmIhPTS7K/ZlgYYeeflOVivnJNgc2n3ahfQxPwvKZcr3/kKXE9NxGPTbvCU7q3dgHf
         Zq9dvVaL5VAee/2yJQqrouqChuc++mixJ77RMqKktRTh/MkRGxjMi7cYv6K7AnGI0lik
         CqVg==
X-Forwarded-Encrypted: i=1; AJvYcCURq1WTxq0U9Mhiw+W5ybXvpZynHdbWRFteLQEbN21LS9zaH5Gj8FBkyFZQ/P/UfWJBoXQAC565YJhYrjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUKQ8UEa3SBIvdX+fbIUMAmqez2hq3k6qqWHJTxxQqGbVSBkeO
	Qe2auQNV47Tc3hvq/P0A/A8OU92sOCE6kHWUiW38hf3wACNBJmMmjsAh4qTv0T2BVLU=
X-Gm-Gg: ASbGnctrgfxFVdFJs//f6XHcRsVvqOLwZBlnouxPQsD3anhInWplajI6yiVeey6zqLz
	ymmsI7Lm+/u7j+0QfQ6XEauEACHojzPjKGK+CDsGXQ8+Up+dk8OUbEcGat9d2STsF9oihnBgJHp
	WRSVUyYNb7bj9KHVN0MBFjjjZMG680D2Apn6bl8SW5kGFaKqf9rA/ejgDzXLSS+nk5/+W0f/JUy
	fYEKBUqUpO23IJ1JURBVYAo44cDZvcYaw2ZI3Di0dnVEzp2rw33KAVQ1wsq4G1qF82fhC5yTqDi
	iDtAoUeqJTPHAbSUz53MrxCH2jyt07afduU3vCTml0vOxZc4SkWML+TQ/QCNPE2Gvlyk2lnJZuD
	d5OC/UuRGp1WJKESsxglqpvkfYZy8JEyVAR9a+1tasvHBe3Wj1bQP518Qqxyf3+PzI+AX4TJX1F
	khAkXXNw==
X-Google-Smtp-Source: AGHT+IHp6aaJim+FGxPXwaKcRAhC/7o+RiCQEQ0xsgnerht7ZPGqeEPIy0Gt8By0UJ/GpFPpjGy09g==
X-Received: by 2002:a05:620a:290a:b0:860:e823:887d with SMTP id af79cd13be357-860e8238f93mr631609685a.71.1758937486781;
        Fri, 26 Sep 2025 18:44:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0b94599esm34985571cf.16.2025.09.26.18.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 18:44:45 -0700 (PDT)
Date: Fri, 26 Sep 2025 21:44:43 -0400
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
Subject: Re: [PATCH v3 11/11] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <aNdBixt1AzIxdCpX@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-12-rrichter@amd.com>
 <aNQl2ogOPKid7yyp@gourry-fedora-PF4VCD3F>
 <aNbGfOxB4LXaFL0Z@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNbGfOxB4LXaFL0Z@rric.localdomain>

On Fri, Sep 26, 2025 at 06:59:40PM +0200, Robert Richter wrote:
> On 24.09.25 13:09:46, Gregory Price wrote:
> > On Fri, Sep 12, 2025 at 04:45:13PM +0200, Robert Richter wrote:
> > > +static void cxl_prm_init(struct cxl_port *port)
> > > +{
> > > +	u64 spa;
> > > +	struct prm_cxl_dpa_spa_data data = { .out = &spa, };
> > > +	int rc;
> > > +
> > > +	if (!check_prm_address_translation(port))
> > > +		return;
> > > +
> > > +	/* Check kernel (-EOPNOTSUPP) and firmware support (-ENODEV) */
> > > +	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> > > +	if (rc == -EOPNOTSUPP || rc == -ENODEV)
> > > +		return;
> > > +
> > > +	port->to_hpa = cxl_prm_to_hpa;
> > > +
> > > +	dev_dbg(port->host_bridge, "PRM address translation enabled for %s.\n",
> > > +		dev_name(&port->dev));
> > > +}
> > 
> > Is it possible that the PRMT function is present but uninitialize?
> > For example if expanders are not in a normalized address mode.
> > 
> > This code would likely still add the to_hpa() function reference even
> > if the underlying PRMT function hasn't been set up for translation.
> 
> At this point during init, it is not yet possible to determine
> normalized address mode. Endpoint and hdm decoders are still unknown.
> Thus, PRM is enabled for the port. Later, during region setup, there is
> a check for that while determining the region's HPA range. Addresses
> are translated and ranges adjusted only if needed. Once the ranges are
> set up, no further PRM handler calls are executed.
>

Right, but that errors out if address translation fails (below).

Is this code missing a check for the endpoint_decoder.start==0?

static int setup_address_translation(struct cxl_endpoint_decoder *cxled,
                                     struct cxl_region_context *ctx)
{
...
        /* Translate HPA range to SPA. */
        range.start = port->to_hpa(cxld, range.start);
        range.end = port->to_hpa(cxld, range.end);

        if (range.start == ULLONG_MAX || range.end == ULLONG_MAX) {
                dev_warn(&port->dev,
                        "CXL address translation: Failed to translate HPA range: %#llx-%#llx:%#llx-%#llx(%s)\n",
                        range.start, range.end, ctx->hpa_range.start,
                        ctx->hpa_range.end, dev_name(&cxld->dev));
                return -ENXIO;
        }
...
}


static int setup_region_params(struct cxl_endpoint_decoder *cxled,
                               struct cxl_region_context *ctx)
{          
...
        rc = setup_address_translation(cxled, ctx);
...
}


int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
{
...
        rc = setup_region_params(cxled, &ctx);
        if (rc)
                return rc;
}

