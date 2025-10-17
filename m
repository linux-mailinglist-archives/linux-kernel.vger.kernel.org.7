Return-Path: <linux-kernel+bounces-858324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 233F8BEA314
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 075054FB3F8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2949A2745E;
	Fri, 17 Oct 2025 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yhTknygV"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FD8336EDB
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715361; cv=none; b=etZ2JaebFBMuJWax1083EaP2v3k/oHq9RUgZBrYjbsOZmV1fa9H/lapI0d3WzCY0tqghaNooCWngHfcQbRw9HSVj34ucfkB1s7v8rPHCEbZ8byHbc3Je3GljkMD16L5/6lPMGABMjtxmbUevh/SuCGkUt+DnLxB3TmmGGTCBW6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715361; c=relaxed/simple;
	bh=TjjLU52Q5d/rZNqi2NManBkuFZiSVeO6kuhlVXPTWTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgR1VGCSfipZ2WyYAinHtKNtQ0v2uCpPY0AIOnolecIoTwSwvFUIe/eHJASkPufXNfpwwAJG/Vi1F/iCfdF7fSC3fROL7FaS3ZJDZdDS0gTP5TBwJ5aVWDsclOO7GPR4KPTtCUuU4vRmkm0yl9aiZrUwTE/DtQoAoxQbBLdDT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yhTknygV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7835321bc98so2018069b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760715358; x=1761320158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0WEmOLvT/CbsBcdqkr/ZZZBMBFXH3ro5/9WyE8yUpjQ=;
        b=yhTknygV4Koe21N3K/uypVYA5rk3uPDuFNCKPlvlsju2XXO2gCQpucVUl5rHPKagEp
         V1xHGhuQcxRAObIUUa07H1+OHmy1BcBHiOnIVVjkAACHl0EASr991oP4lAR1Fa+nPl2X
         Kw6SvBi2CVOVizX+UscRs+hosEHc+3fEigeiNJQorIBq5/Ox4A7gwMNiNJ15XNisEM2t
         k3P3WkhvedephgwoNbQjRtxGjkj4Qjq9Ufexv9N8cEHjRV7yhBtYsDBQzs1x4IHoL+pn
         KqBui2tyrfRO7U7e1Vr/mt2PIThbrfYE1NbeN8QAxBGubp0UmPRfNAmOeACclwtvw/CH
         DkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760715358; x=1761320158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WEmOLvT/CbsBcdqkr/ZZZBMBFXH3ro5/9WyE8yUpjQ=;
        b=erGItPRaa69YNB2PdzQmDf08H8rkOS4te4i0HFmM6K4wfhfe0LxVhwfsjyCfP18eqK
         +PUwlLimGToM2F5fzcAhuUrN6u799ohhYod/YuLPunLFiWaWroT90TEfHMQpDn8jj/NA
         GIYgmUR+8viuOyD+WuQHCgZMwGDqk+QEaWKPAEOiuq/A0bh1NXPDc3yy77V++LfMr52q
         v8YE01vGZ9peNhF0cLGt27GSMSUItLeYKdBMWLbkxdllbqx1PnA0ov9ox2XAT2GuYQQc
         y3c6Se/jwBENj/ZyySWH9VoR9cnF2C5vG3CQ94RpLVs1gYAa9ZE2wCkOpuYJjQEi6RsS
         1vCg==
X-Forwarded-Encrypted: i=1; AJvYcCUQnQjw06l5Mam3dp3rv/mABi04qZ8PmkFCC3c6/FKEa/ILSM5URPYpaRQ7e9Dw62vn++jNv5q7tiLfmu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmBVIu+oY9ZScfO/zMRwMUbIG2ajT0VQqPugAqZQ3xXne/XKEb
	2CXCTbXaRGzpl5dZYSLyCyImd/GfnbSIHMXTsiZw0wW9XJkLlvIbIZ8TgITdEh1BUhP9uWJG1Gp
	YYGkhc5o=
X-Gm-Gg: ASbGncvU/j2M7gTV+8K1VmZuxMxvapDER6ZhfBowMPwJBuB+yWlkIB5hilgzkaN4IjR
	d/Jtw5Zo1PzyeCakXNKHc1iretodFr86rlSGlJfseFE9n4CRVQKfrzIB7683IDYxlYHX5tHG9Zj
	B/LvocE+VVPV9ayi3VvbCKTH79sDRPjftNsaVoZRgyv1B84EM9iLJQ05cnho2zV00pZerspUoeg
	iWNBVMyiD8N+IVql/gqDHy7FYNSnQ71McqPWBaQvnNUZgHcrGU5sIoFFkZIRAaN/XaXhGkIF0Ps
	0E2WFCN894spxaQIMsTEZ7GMcJKHzM2k2eufFm6RkzDsj5S2igbimvjDFCCXazf1FyJneqAIoMW
	L6zuKNjog9gV6p2KkqQsu4gTMpFxMA2gwVP1aeVRJCu2FMpoNQ0HVROABNEvE3UTkScZ6cNK1F0
	AwiZJ4XSlK/NFY2A==
X-Google-Smtp-Source: AGHT+IGedO9tFL/EpWFPArjedfoWI3S0dMZGzYNYhP+QQWKivTjQyK5CIRcouFVSwQFSWwwBtOsaNA==
X-Received: by 2002:a05:6a21:3283:b0:2f6:ec69:d448 with SMTP id adf61e73a8af0-334a860700emr5515770637.31.1760715358374;
        Fri, 17 Oct 2025 08:35:58 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:a70a:89e5:9a8a:630f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bd79dda6fsm3329615a91.10.2025.10.17.08.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:35:57 -0700 (PDT)
Date: Fri, 17 Oct 2025 09:35:55 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] remoteproc: core: full attach detach during recovery
Message-ID: <aPJiW2ROdaUuCiwi@p14s>
References: <20251002153343.766352-1-tanmay.shah@amd.com>
 <aPELVfhkk0qDXqa9@p14s>
 <9e22a020-937b-4965-b7f8-140853ad7d37@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e22a020-937b-4965-b7f8-140853ad7d37@amd.com>

On Thu, Oct 16, 2025 at 11:12:26AM -0500, Tanmay Shah wrote:
> 
> Hello,
> 
> Please find my comments below:
> 
> On 10/16/25 10:12 AM, Mathieu Poirier wrote:
> > Good morning,
> > 
> > On Thu, Oct 02, 2025 at 08:33:46AM -0700, Tanmay Shah wrote:
> > > Current recovery operation does only virtio device reset, but do not
> > > free and re-allocate all the resources. As third-party is booting the
> > > remote processor during attach-detach, it is better to free and
> > > re-allocate resoruces as resource table state might be unknown to linux
> > > when remote processor boots and reports crash.
> > 
> > 1) When referring to "third-party", should I assume boot loader?
> 
> Here, "third-party" could be a bootloader or another core in a heterogeneous
> system. In my-case it is a platform management controller.

Ok

> 
> 
> > 2) Function rproc_attach_recovery() calls __rproc_detach(), which in turn calls
> > rproc_reset_rsc_table_on_detach().  That function deals explicitly with the
> > resource table.
> 
> As per my understanding, rproc_reset_rsc_table_on_detach() will setup clean
> resource table, that sets vring addresses to 0xffffffff. Please let me know
> if this understanding is not correct.
> 
> If we do not, call rproc_attach(), then correct vring addresses are not
> setup in the resource table for next attach to work. Because,
> rproc_handle_resources() and rproc_alloc_registered_carveouts() are not
> called as part __rproc_attach().

Your assessment is correct.  When the clean_table was introduced, it was to
address the detach->attach scenario.  At that time the only recovery we
supported was to stop and start again, which did not involved the clean_table.
Re-attaching on crash was introduced later in a scenario that may not have
included a resource table.

> 
> > 3) The code in this patch mixes __rproc_detach() with rproc_attach(), something
> > that is likely not a good idea.  We either do __rproc_detach/__rproc_attach or
> > rproc_detach/rproc_attach but I'd like to avoid the mix-and-match to keep the
> > amount of possible states to a minimum.
> > 
> 
> I agree to this. I can find a way to call rproc_detach() and rproc_attach()
> sequentially, instead of __rproc_detach() and rproc_attach() calls. I might
> have to remove rproc_trigger_attach_recovery completely, but that is
> implementation details. We can work it out later, once we agree to the
> current problem & solution.
> 

Humm... You might just be able to call rproc_detach/rproc_attach from
rproc_attach_recovery() if you enhance rproc_detach to be called in a CRASHED
context [1].  Let's see what you find when trying this on real HW.

[1]. https://elixir.bootlin.com/linux/v6.17.1/source/drivers/remoteproc/remoteproc_core.c#L2065


> > If I understand correctly, the main motivation for this patch is the management
> > of the resource table.  But as noted in (2), this should be taken care of.  Am I
> > missing some information?
> > 
> 
> The main motivation is to make the attach operation works during
> attach_recovery(). The __rproc_detach() works as expected, but attach
> doesn't work. After recovery, I am not able to strat RPMsg communication.
> 
> Please let me know if I am missing something.
> 
> Thanks,
> Tanmay
> 
> > Thanks,
> > Mathieu
> > 
> > > 
> > > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > > ---
> > > 
> > > Note: RFC patch for design discussion. Please do not merge.
> > > 
> > >   drivers/remoteproc/remoteproc_core.c | 15 ++++++++++++++-
> > >   1 file changed, 14 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > index 825672100528..4971508bc5b2 100644
> > > --- a/drivers/remoteproc/remoteproc_core.c
> > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > @@ -1786,7 +1786,20 @@ static int rproc_attach_recovery(struct rproc *rproc)
> > >   	if (ret)
> > >   		return ret;
> > > -	return __rproc_attach(rproc);
> > > +	/* clean up all acquired resources */
> > > +	rproc_resource_cleanup(rproc);
> > > +
> > > +	/* release HW resources if needed */
> > > +	rproc_unprepare_device(rproc);
> > > +
> > > +	rproc_disable_iommu(rproc);
> > > +
> > > +	/* Free the copy of the resource table */
> > > +	kfree(rproc->cached_table);
> > > +	rproc->cached_table = NULL;
> > > +	rproc->table_ptr = NULL;
> > > +
> > > +	return rproc_attach(rproc);
> > >   }
> > >   static int rproc_boot_recovery(struct rproc *rproc)
> > > 
> > > base-commit: 56d030ea3330ab737fe6c05f89d52f56208b07ac
> > > -- 
> > > 2.34.1
> > > 
> 

