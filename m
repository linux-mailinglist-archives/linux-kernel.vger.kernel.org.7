Return-Path: <linux-kernel+bounces-821641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7094EB81D64
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F9D32444F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449F62C08AC;
	Wed, 17 Sep 2025 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="j6qnyWFP"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE763208A7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142302; cv=none; b=Xyg6eLZk+PV8YfBJgrQSKO8s8asqGinIa1st26WwTaY6zZlhK43M9nJGyxQ9kh3/b4L+nB86kxUucnqi7DgrNvMxCZSWqrA+cR/0ueSyW24RVrLkQ7OXAzqWIL2xj5YJh4KoPExR7SiCx/8A+YvbhCIZBAvHAqZUBYZK1ouC3xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142302; c=relaxed/simple;
	bh=wQvLRiBXDj6VtyhIkweb+J/LGGpX+Bj5UgJ7DmBBbPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISbtEcjY4mnIUj4HBfksRKoOtzqi9JVuSBk0We0jQ+zu7kotsSflHuuX+6lE/jrLNL2uO1439u81I4Bh/4El9m7btdBqTMeaAbwldHyPy4KB4TmS2en8sE133Ly9ZLHieO5N5BlPSbzjzLgk+a7pM8GHvgZ2s3+dhppwj1ZREc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=j6qnyWFP; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b5e35453acso2368961cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758142300; x=1758747100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w67NJrFvcjqAdTQ9mCPnhFNgXmY6BD3kGRa56ePYCWI=;
        b=j6qnyWFPiqtKdAnQJx2LXC9hXuH7hfhmHJVINlv6k1S6q25G4defMWQyZBo8XmlzJX
         iDUxN1xJmdVxNvlh9mufTvxhQBF88lHO+ifCkQ++mt4YUaF4pPYnuLq5akG45xVQdaOe
         hIznLTpsZPdpL7A26fTolB3vogbJC4sd5tAaEn65xqf4HfRytjRWWKBuXFJ0ORptCLDi
         ddV3Jiupbnm1pwNGtvS21ADKKLn95RnhsK+DqmIHHXAsQ24dO8LjzFeaLRy2ibHb7gHS
         N4Rw1LPqwd9holM7a5B3ODhKPq5JI1lkIVwIrqzo776QLHoTe+sHLywrVJpq6Uh1/Ycn
         az6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758142300; x=1758747100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w67NJrFvcjqAdTQ9mCPnhFNgXmY6BD3kGRa56ePYCWI=;
        b=IH984VFRQkSCWtVilDQa9Zf6hcVU3DDT3Of9CcAsvF8N9yI9RhQJ5Y/XzLjUv7joMT
         UHP/L8MjeAHbqTX1aIwGrNt4XGDnBvZkPwbp32MV/dZNxY1lc5kqNcCMsR+4U/uztqy+
         3ix41kidIY1ALRboAhJj5IqM45bfSvw0fh3VJr7gVj2picc+aXanGv5Ye0/NX2OpRrGZ
         tFs1Y+urOTYzjwBXD/RJO0qhj4NvVmnQ1myZmPkfNVnLQaqXsnav+jNxxjkj0E6h3Pcz
         xrzCCcs388OxTK18d9hUuB7LzA2eL6ySFN0S81PpTUJE9eiCXY6Qt9NnDcIy/Z2BERrb
         Brmg==
X-Forwarded-Encrypted: i=1; AJvYcCV7LE/YugL31HaTZPxv2OICLKn7sgOE103MjejSAlRrBJWXZ/aQoNnRbIHZ5LRPY+h0rogVc+X0Ur/fZow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNWpE7CZVFwFOJWBjiGt+TwTe+boTnvoyaP/yYMoU8SoirsD9K
	ZU45ok6ryVhzE4YUBdSZrOQO3z24eOwHjGakP4C0AWkPxtqi467p7lbUQooXIWc56P8=
X-Gm-Gg: ASbGncuVqka6DFiTYcmfPVhVfaAmDqBhnn9cGA3YjWAWpqTUg85+a2/KVsOmV8Jighd
	/fW07rgBv5akSHNBTPC+mntlKXx0DndWm5GSGVIj8FodojSvBtDdzVCn+bplCtXsWlbMG91NWeQ
	33x6WHV0phHYXTT3K1O4zqsWs1SS3VweQUwiAWSkTRkSvbPaOckQayUXBZw+wDkyYJ6TbW8S2TP
	sowXGQEO+mYNtyhTWXDRy8e13AJ+hP68A5qGV+Tb9cnOL1Y1Rymi019kVwyJNdd2F02X/eHFWTV
	5dWxh5DCjFKTrkhPWuBeFfoKKQeZoWFs5BsLpZqCQ40CV5yy/2dI2VEhWC5clrTd3Hae7kMdcVu
	YFKsxR8X7feD3/zGRax8Tkm+teCcCaNDnIj+3mfOt7vzWnW0qJNeCExfwZPGPrBHpVaVgCELgHl
	qClGw=
X-Google-Smtp-Source: AGHT+IGg29GpEvK32YLKgF/pd7sAjd5cJDb0a27ozoPbfeRjzihNQCeXTcdSxSoxPfGqLWFUkOLPJA==
X-Received: by 2002:a05:622a:48d:b0:4b7:a44f:5263 with SMTP id d75a77b69052e-4ba6cd712ccmr44103361cf.71.1758142299817;
        Wed, 17 Sep 2025 13:51:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83626780107sm44548085a.5.2025.09.17.13.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:51:39 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:51:37 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Robert Richter <rrichter@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 08/11] cxl/region: Implement endpoint decoder address
 translation
Message-ID: <aMsfWfwMhewTjHD3@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-9-rrichter@amd.com>
 <20250915114614.000053f1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915114614.000053f1@huawei.com>

On Mon, Sep 15, 2025 at 11:46:14AM +0100, Jonathan Cameron wrote:
> > +	/*
> > +	 * Since translated addresses include the interleaving
> > +	 * offsets, align the range to 256 MB.
> 
> So we pass in an HPA range without interleaving offsets and get back
> one with them?  Is that unavoidable, or can we potentially push
> this bit into the callback?  Probably with separate callbacks to
> get the interleave details.
> 
> Overall I'm not really following what is going on here.  Maybe
> some ascii art would help?
>

The endpoints in this case are encoded with "normalized" (base-0) with
a size of only the memory they provide. As a result, the decoder
interleave settings will always be passthrough (iw=1, ig=ignored).

This chunk translates the normalized address region to the relevant SPA
region, and translates the IW/IG to what it actually is (i.e. what it 
*would have* been on a "normal" system).

Took me a while when i originally reviewed and tested this set.

Example - this is how you'd expect a real system supported by this code
to be programmed:

region {
    .start = 0x20000000
    .end   = 0x3fffffff
    .iw    = 2
    .ig    = 256
}

endpoint1_decoder {
    .start = 0x0
    .end   = 0xfffffff
    .iw    = 1
    .ig    = 256
}

endpoint2_decoder {
    .start = 0x0
    .end   = 0xfffffff
    .iw    = 1
    .ig    = 256
}

when you do the translation from either decoder's hpa start/end,
you want the following output:

range {
    .start = 0x20000000
    .end   = 0x3fffffff
    .iw    = 2
    .ig    = 256
}

If you assume a "normal" system - this is the settings the decoders
would have been programmed with in the first place.

You have to do the alignment because the translation function (may)
only work on granularity alignment.

Example:
endpoint1->to_hpa(0)         => 0x0
endpoint1->to_hpa(0xfffffff) => 0xffffe00
endpoint2->to_hpa(0)         => 0x100
endpoint2->to_hpa(0xfffffff) => 0xfffff00

So this code applies the appropriate alignment and returns the
translated iw/ig for use elsewhere in the stack when validating the rest
of the decoders.

(haven't gotten to later commits, but iirc it was eventually used)

~Gregory

> > +	 */
> > +	range.start = ALIGN_DOWN(range.start, SZ_256M);
> > +	range.end = ALIGN(range.end, SZ_256M) - 1;
> > +
> > +	spa_len = range_len(&range);
> > +	if (!len || !spa_len || spa_len % len) {
> > +		dev_warn(&port->dev,
> > +			"CXL address translation: HPA range not contiguous: %#llx-%#llx:%#llx-%#llx(%s)\n",
> > +			range.start, range.end, ctx->hpa_range.start,
> > +			ctx->hpa_range.end, dev_name(&cxld->dev));
> > +		return -ENXIO;
> > +	}
> > +
> > +	ways = spa_len / len;
> > +	gran = SZ_256;
> > +

