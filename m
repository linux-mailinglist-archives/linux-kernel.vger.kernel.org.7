Return-Path: <linux-kernel+bounces-741115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A53B0E03C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05B41889619
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C48B248896;
	Tue, 22 Jul 2025 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LWewC+kF"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245EF24A043
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197422; cv=none; b=smSyYLxsPgF4gv2SSWiraOedXzbAHnFnnyfxdefR/Hj/g+MEEeEi0YbeCKu2RS0ao3XUS4Jz2aOTF2lLNrfPrjqwZ7ACRr2DZMD5OoJZIjE/Kpnc5TWmol/hw9dnOKwa1lD7s0B+hDyVB00H47AfaiF0l6UZOM1A8ek0Y8/FqfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197422; c=relaxed/simple;
	bh=PdMBMBDbTmgkREq8Szn7ylbIItPWbL2sfvCT+Ci/LFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoIgqwfYk6UqBsqv2iGj0ewPEOLSeArszOs8A+oQZf+eiGJRaJFgOqxJRR8g2RA/mDpJ4CZysLdJZhhBP23xCF5ZoM67pl6+F0qVFb0ADBQLGZCtdT630qAksA4nzzyPhRCbu1Ptkxxtak+3gmZjnCa0tZGYiyoLD0Uk56y6ABQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LWewC+kF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74924255af4so4895939b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753197420; x=1753802220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ngGHnN+wVTePIbSvvDu8hrTxMCBEaKhAX0lcY1Jf1Tg=;
        b=LWewC+kF7b/cC1HTK25mQjAlCAlZKQhBmcKVZrOo5a7xZYYfYTF817JHONc9By32L/
         wghxhinZpL92juW35Rwsjh3SbJGpbAprbPFl9rqy82zB9LO63BywbUOGtJO8FpJx3JJK
         edNickmvWBMUpFc2gF8I9orzMOgcO0HGF8u5cZGLX+XYnA3RjU1nXTzu4Lq8iQVIkaLK
         3vilprfDzjfORSwPs3fL93oPJMZLQJh45bcLW/ZhXAA/KRjLOuiIlesGKVZMopMsP2Fk
         3kFTNxDcJh9U4cz6f3VC9VQdWRYFslmsvCMuuKw1AcUAtcCzj/HNsAwYh6mnndk3v2ti
         77lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753197420; x=1753802220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngGHnN+wVTePIbSvvDu8hrTxMCBEaKhAX0lcY1Jf1Tg=;
        b=r0Gu//AipKCMIeXkWbkL/pSapI4O3i/mlP7bS9loJcbefXaix243dbRZqrTlrzFyvP
         G14pPRUGg9z8gIi1AD7LuEKSxvW5ubuy4FBUgmMhQ1TnrFW4umzV/beN7Fokssp2Pdt6
         9kjupibFiNWXCW1LKCXC8pqNIZKsILg9rFJjqZeVZxKLtZ8kdNit5EJlZNt3DCmYD7nm
         OzA9EMW6myhOyuslKWF6GPuC0UJLBXa9i7ekzn5IvwA4Mq3GvaMVwtSReYixvRobR0qy
         0MHTiKD7MnTLTzYmU+oL5vJckr1TVAnlu3N6j3rex/s1iRww2s2H9CdDKzz9FQlazDmC
         xIMg==
X-Forwarded-Encrypted: i=1; AJvYcCXbAGnFQv5tcoFW83A3NaeNY/UTSW01h5QGncQvRQLUBkdd0G/Wb+ZpN2yRLosHQTh3HSS1hfYIo0oDkqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO0bVyu3WitHzsO3SPWLn15ba73S4Aq7+VW+Av5nee+jtFqcYJ
	p3AXKHbhPwnlT76HW6j3GQaXPGc3S46zWBoDp5UqqEfpyD57fk2CrTG2rGxN/d7mC68=
X-Gm-Gg: ASbGncsnvUTEFOtscYXWXXe/wxVgrQMEsFiPSS6CnOrZVN8RkeB/OnW/S2RCtu9atwN
	6bZYgL4g3oULI9RrkYqN5HNoM62r9/MLEKFguepKOgPt9WLgnpKFGaJ8nEiN873HZtp5dUGWP+6
	Hhs5nZF3iQmCd+nelZaR6Gi0EQvyCVPchTzWjSAgOCdnMKMIh9jUZ41QAkmSPuxUtQLxlcls7kO
	75LYWlS3U+PLGsLJ7fV8Tk0t5rLpGJk6dtV6AH6cd8/4sZxYvS/yS2dq8MfPlHunVXqkKZhE6Vn
	qxjC860cioFX4HgD9cTg7PJpYTP5hV+YuNYkg0qo1kxUdoofi/SxF65qRqgQCBdLOhw7ildK9U4
	ZHuQsQ13tWy90a8CypmN2wA9CGw==
X-Google-Smtp-Source: AGHT+IERDsmZrSb6T3xrKFJ5eyMKVGje4EKWy128gDJPtvFbEZ2lIVjD/hPVUzYvwIvIMuIoNCXtWA==
X-Received: by 2002:a05:6a20:a109:b0:232:1668:849f with SMTP id adf61e73a8af0-2381376841bmr39703159637.38.1753197420257;
        Tue, 22 Jul 2025 08:17:00 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:20c2:197e:4b2b:9e1d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe67facsm7329696a12.9.2025.07.22.08.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 08:16:59 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:16:57 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] remoteproc: xlnx: disable unsupported features
Message-ID: <aH-raYufMNNipI7u@p14s>
References: <20250716213048.2316424-1-tanmay.shah@amd.com>
 <20250716213048.2316424-2-tanmay.shah@amd.com>
 <aH5bynQwaHbCJR3f@p14s>
 <ada00b1e-b717-4051-9b33-3f43b5c08097@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada00b1e-b717-4051-9b33-3f43b5c08097@amd.com>

On Mon, Jul 21, 2025 at 11:37:23AM -0500, Tanmay Shah wrote:
> 
> 
> On 7/21/25 10:24 AM, Mathieu Poirier wrote:
> > Good morning,
> > 
> > On Wed, Jul 16, 2025 at 02:30:47PM -0700, Tanmay Shah wrote:
> > > AMD-Xilinx platform driver does not support iommu or recovery mechanism
> > > yet. Disable both features in platform driver.
> > > 
> > > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > > ---
> > >   drivers/remoteproc/xlnx_r5_remoteproc.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > index a51523456c6e..0ffd26a47685 100644
> > > --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > @@ -938,6 +938,8 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
> > >   	rproc_coredump_set_elf_info(r5_rproc, ELFCLASS32, EM_ARM);
> > > +	r5_rproc->recovery_disabled = true;
> > 
> > If recovery is not supported, and it is set explicitly here, does it mean the
> > present upstream code is broken?  And if it is broken, how was this tested in
> > the first place?
> 
> I think upstream code can be improved to change "recovery_disabled" to
> "recovery_enabled" and set it in each platform driver if feature is
> supported and keep it disabled by default.
> 
> When upstreaming base driver I wasn't aware that there is recovery feature
> in remoteproc until recently when I started working on it. I guess too
> focused on fixing base driver features. That is how I missed to add
> recovery_disabled and test it as well.
> 
> That is why it's better idea to replace "recovery_disabled" with
> "recovery_enabled" and keep recovery feature disabled by default. Same as
> "has_iommu". So platform drivers enable it if they actually support it.
> 
> I will add recovery feature for xlnx platform later, but until then it's
> better to disable it in the platform driver.
>

I have applied this set.
 
> Thanks,
> Tanmay
> 
> > 
> > > +	r5_rproc->has_iommu = false;
> > >   	r5_rproc->auto_boot = false;
> > >   	r5_core = r5_rproc->priv;
> > >   	r5_core->dev = cdev;
> > > -- 
> > > 2.34.1
> > > 
> 

