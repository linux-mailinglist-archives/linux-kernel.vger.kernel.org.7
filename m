Return-Path: <linux-kernel+bounces-899669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B442EC58889
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5DB1835B961
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08AC359FA4;
	Thu, 13 Nov 2025 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AKOg9J7D"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036FB35A12B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047955; cv=none; b=Lh2fSmegHcwNuiVgu0g7517sNnqZWUf7zNDBHDPIDf+ZXZnclN0V15HsQymVho+Ps4ghnlHIKG7sNEEi7fUChoqx1OqlGk+5FVTirIybCSg8HiddRkGXr6fVsZSyELS/QaZznNaCEofiILWj0DPKoZgstxrdxgFjQRaWY8o0ZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047955; c=relaxed/simple;
	bh=Z1vu2MOiIFQBcyrWVUVPL9kCsj3sq6loXCLsmGoUKac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Po3rNdLK62pnTP6awymHrT01jhp5IO/9DDOx4NLIi97H4cmxaPUhyb2B1fgchw3czfZU8fHt2qGt8G2rFqYWyl2fB+IE5BnEWoI2erQDJzMcIqafT3v4Us0j4NgqHPTz1/aWwL4A+AIgw2ikxfNLLprQV/h38caIjNJEyxNllQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AKOg9J7D; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2964d616df7so12033715ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763047952; x=1763652752; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dc807XTs3vahOFZ04ibLRMSAJaCm4V/IMq6B1/2zPgY=;
        b=AKOg9J7D1B07L3Zh86GSs72adKKQAo9kFP0iXvWJ909llen+LapyTKuuk246YLU+SW
         9ZrrsIEiPHi9soWwzFXzwQXsLZVyLxxNnuKUuKg2ZO9ft+J+jiN5BEoxuZxXGWTAa0zy
         YOeraq2pUM8BG7X3A+qbpTcPaepIP2B0kN3YbDuY8f1VKOIZqSiDjmyCvH7z6r2kaHnH
         osp6dwA5tbmapRvjSmA32Q4C5yl7WUd6dHTSWoXdsSitS76CGkYxUdhxdKDWp+iSbPYJ
         2kQgNBYmsARlIYl/TVv7i1W79/CjvyLvkkFwBzEaRRSHvQwddKPrKwnlP0P+a2QC4PYV
         +o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763047952; x=1763652752;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc807XTs3vahOFZ04ibLRMSAJaCm4V/IMq6B1/2zPgY=;
        b=uRoQLgTzePTBfX2SNknRan9oh7FJUYcuVfcF3ft4HU6wf2ksegD6rLwP9GBvyCiBBW
         StGThs4+lUT8RDieASSztV1hKbg0W9uzJTtHbLMTgXxI8LJQmVONBPPM3krb3tE7fI2N
         d0b9uaVYA48c3yw6ti5EKfTMgQnLEZc1yfWUu1iGiFOT3muVj6JCgUG1czKmBSkTKNIb
         EasJjN3eDKWV5q+FmTU57Sls7spavPzoGbub9QGwrKet7xB8pz3Gw6BFeHguLtwv0JIn
         XBsDNdw2Sq52QmXbs+DBjUX5CDvVIwq1z9qZNwki3IMpe+Mw4dJFqPaGkQtHWU4J6+EI
         r4ow==
X-Forwarded-Encrypted: i=1; AJvYcCVQ+JRbxRAjnbUCoNcGQTsfaAnICIAzbDvehQNeWHDNnWqlcHlG6KvJLqPhnRHGS7QyvDBgCqb3i+GMH4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVkjpWM3xDX+7x3gs1hbIYi49iU+8HEeQUBF2qLkPwMKZQ5vHI
	b4B6Xh/qxn+37b+4cmMnkDUQpBcMNHWjmYPUuwOC3gXz5WUQnWgMG0oRHhYgNLN11Ao=
X-Gm-Gg: ASbGncumnB7xTM0LXAmAUxFm2EgRizSIUfACxEdnTo7bsjEIR70G9YY8LFwmmblI9d6
	frtG64pqoafVrYTkdS/tHCcC6JpgYH3dMTYV/2l3oQ6rCi+6uNuzmdZ2MRLU6MEcdj9b57tgGks
	R2O0CfGV4rHlBO7ci2Zoj2iDcYHhGgycALJpFiULreVVRCtaMjYkK3xR5uBYoio/2gmt2/aNFRq
	nlW0FtRcdWAITSL+06gd54fEpQaZn4b+XuabLsATwBiQkgUqV+QFH5LxQIp6R35hXK1b2RqZ4Ot
	3ytZ7nAb84Oo/AEdJpgnPsBLJiBDdXYnrW8f9X3fob9YsWUR4GaBE7mgH9pO9m2XP3O+k7tG31F
	oTs0femc13RX872PkjKBaR3yz+vOaYrAkwq91QWOISC8RXRBNDQ1NCaMn3KzPYPP3oDvVujjYH6
	CZDg6OWtIvP3TjocE6kCy3He4=
X-Google-Smtp-Source: AGHT+IExGtwG81uwzj9JgnEK26nwTkuowQ0TGIoI/B/ng4jHpuOWuk3RVAjeNdIAjjrFddHoISsZ3w==
X-Received: by 2002:a17:902:d54f:b0:295:34ba:7afa with SMTP id d9443c01a7336-2984eddf6a5mr85532495ad.43.1763047952195;
        Thu, 13 Nov 2025 07:32:32 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:aee4:3fd6:a52:8e9a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed4fsm29590765ad.75.2025.11.13.07.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 07:32:31 -0800 (PST)
Date: Thu, 13 Nov 2025 08:32:28 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Peng Fan <peng.fan@nxp.com>, linux-remoteproc@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v6] remoteproc: Use of_reserved_mem_region_* functions
 for "memory-region"
Message-ID: <aRX6DJoaP4MXG3fN@p14s>
References: <20251031175926.1465360-1-robh@kernel.org>
 <aRN0fdOAV0B728qo@p14s>
 <20251111195923.GA3629535-robh@kernel.org>
 <CANLsYkwcbrTaKASdr5fj0m9ARS4xUgzVH8iWQKwTCvEsoZDDsQ@mail.gmail.com>
 <CAL_JsqL7HcDkPgJjcqJSagdN=gH2rv6noVS57QMGNRp0YCxUBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqL7HcDkPgJjcqJSagdN=gH2rv6noVS57QMGNRp0YCxUBw@mail.gmail.com>

On Wed, Nov 12, 2025 at 10:59:42AM -0600, Rob Herring wrote:
> On Wed, Nov 12, 2025 at 9:43 AM Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
> >
> > On Tue, 11 Nov 2025 at 12:59, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Tue, Nov 11, 2025 at 10:38:05AM -0700, Mathieu Poirier wrote:
> > > > Hi Rob,
> > > >
> > > > Please see may comment for st_remoteproc.c
> > > >
> > > > On Fri, Oct 31, 2025 at 12:59:22PM -0500, Rob Herring (Arm) wrote:
> > > > > Use the newly added of_reserved_mem_region_to_resource() and
> > > > > of_reserved_mem_region_count() functions to handle "memory-region"
> > > > > properties.
> 
> [...]
> 
> > > > > diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
> > > > > index e6566a9839dc..043348366926 100644
> > > > > --- a/drivers/remoteproc/st_remoteproc.c
> > > > > +++ b/drivers/remoteproc/st_remoteproc.c
> > > > > @@ -120,40 +120,37 @@ static int st_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
> > > > >     struct device *dev = rproc->dev.parent;
> > > > >     struct device_node *np = dev->of_node;
> > > > >     struct rproc_mem_entry *mem;
> > > > > -   struct reserved_mem *rmem;
> > > > > -   struct of_phandle_iterator it;
> > > > > -   int index = 0;
> > > > > -
> > > > > -   of_phandle_iterator_init(&it, np, "memory-region", NULL, 0);
> > > > > -   while (of_phandle_iterator_next(&it) == 0) {
> > > > > -           rmem = of_reserved_mem_lookup(it.node);
> > > > > -           if (!rmem) {
> > > > > -                   of_node_put(it.node);
> > > > > -                   dev_err(dev, "unable to acquire memory-region\n");
> > > > > -                   return -EINVAL;
> > > > > -           }
> > > > > +   int index = 0, mr = 0;
> > > > > +
> > > > > +   while (1) {
> > > > > +           struct resource res;
> > > > > +           int ret;
> > > > > +
> > > > > +           ret = of_reserved_mem_region_to_resource(np, mr++, &res);
> > > > > +           if (ret)
> > > > > +                   return 0;
> > > >
> > > > The original code calls rproc_elf_load_rsc_table() [1] after iterating through
> > > > the memory region, something that won't happen with the above.
> > >
> > > Indeed. it needs the following incremental change. It is slightly
> > > different in that rproc_elf_load_rsc_table() is not called if
> > > 'memory-region' is missing, but the binding says that's required.
> > >
> > > 8<--------------------------------------------------
> > >
> > > diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
> > > index 043348366926..cb09c244fdb5 100644
> > > --- a/drivers/remoteproc/st_remoteproc.c
> > > +++ b/drivers/remoteproc/st_remoteproc.c
> > > @@ -120,15 +120,19 @@ static int st_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
> > >         struct device *dev = rproc->dev.parent;
> > >         struct device_node *np = dev->of_node;
> > >         struct rproc_mem_entry *mem;
> > > -       int index = 0, mr = 0;
> > > +       int index = 0;
> > >
> > >         while (1) {
> > >                 struct resource res;
> > >                 int ret;
> > >
> > > -               ret = of_reserved_mem_region_to_resource(np, mr++, &res);
> > > -               if (ret)
> > > -                       return 0;
> > > +               ret = of_reserved_mem_region_to_resource(np, index, &res);
> > > +               if (ret) {
> > > +                       if (index)
> > > +                               break;
> > > +                       else
> > > +                               return ret;
> > > +               }
> >
> > This looks brittle and I'm not sure it would work.
> >
> > Going back to the original implementation, the only time we want to
> > "break" is when @index is equal to the amount of memory regions _and_
> > ret is -EINVAL.  Any other condition should return.
> 
> @index equal to number of entries returns -ENODEV, so that condition
> is impossible. We can simply it to this:
> 
> if (ret == -ENODEV && index)
>     break;
> else
>     return ret;

To me this needs to be:

entries = of_reserved_mem_region_count(np); 

...
...

if (ret == -ENODEV && index == entries)
        break;
else
        return ret;

But taking a step back, it might even be easier to go from a while() to a for(),
the same way you did in imx_rproc_addr_init().

> 
> If you want to keep the prior behavior when 'memory-region' is
> missing, then '&& index' can be removed, but I think that was wrong
> behavior.
> 
> Rob

