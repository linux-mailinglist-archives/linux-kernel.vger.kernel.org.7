Return-Path: <linux-kernel+bounces-777747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D202B2DD54
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 089167BAAB5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B7B31B106;
	Wed, 20 Aug 2025 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z90v5UK3"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C85311C14
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695252; cv=none; b=Z3tPPKXsA1gaz9UCsvCAEn29Y6jqTfldSoSvU/Im227BsCLc70h1rkbuuZMg1x2cC4Foqx/jHcxz8R/N6oDBIemH2D7mhtkBn8oyArzIb1ehnVirit5ClqEd18akjhc6n4W0AzcEcpjfc4t8C1fu6vXRFZgyhgoE0fj7az7+GEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695252; c=relaxed/simple;
	bh=X/HnEbOt1kxd7Jy+231ddpEnGbEAx2HX1Aw7LGzcYH0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3o4VvbNMBa1M+bnK9ZjHuExsEiuYDXaoUh+JF68wrP0JR91T5kyZqNUWLq1m9EhGPHdwJiNISk9pBB4UlWaazzSPyAGHWEKllyAz2wNDcUUp1kOxaxQ/44UunTkqJn061CVhUtk0PRaYjezqa51xRWfUOFSGYhQI6aD8onorhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z90v5UK3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9e418ba08so3539473f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755695249; x=1756300049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5OQS/emDfXIYrpr8riBnRkgKKKbGxRuLEAKZuS2I3s=;
        b=Z90v5UK36HBuw1VTYpild7A/Oal5ra7mugHxqlXyXDnupvc3EHhKCRNq3sCyidFxDT
         ogxLbUylBaarO1W75CerzBKVScgEnajMssq1+cjSCM4YbilAMVdE9Oi9y1Cx8f+0qL6N
         GhRD3/6pg1lJcMEx5qbYA98txoPnUcBcB987yKZDIipPm18GIdJeve1zXe862h4Xyhfn
         FHqm9Omo5+w9iBSutiCBKm1wrDi6XYL2/BqQkga99X7ZSFibitJfTQH5OeIdymQ1TUi7
         DSu+JRuOR+3h5KLzUlNzZ1m1kbyW3YDI1CG6WdeI7Mzm54pUgA4rXI6FtOenYSvU2vGt
         vfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755695249; x=1756300049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5OQS/emDfXIYrpr8riBnRkgKKKbGxRuLEAKZuS2I3s=;
        b=gF4oe35jNjsm+WsToxXcnyVLRzhoQutD43X3jm5VbTaMw4eYW9+85hk281El4lOxqq
         Mp5MYwShmhbK5dz+8o/dDLM/s1XZUWPthu4B2oTB+fWGTaAp6gz77Vyl/DH/09eCXKxf
         tkGv7UCuHEg7b9ez+6aFE+SvtJ2tax2D3HBp9yzEO9R17Ibs2j8zFZz4loqLv9+/qVhK
         71H/wQu8oVwXmw5GuOYsLpY5mEQDZ09aBlBMI4HQoZtMus0HTpQCDqiFzndmn5rGSxid
         +xsDamhrzuGAeD4Sra2R8JXzBe+nc1QiRKQqxbq4tgIs6AZjDF2Xp79TAmogOQik5ofK
         twRg==
X-Forwarded-Encrypted: i=1; AJvYcCVdrEF1gLU7w1C/VlQHhg2ni5eWMCxFTN+/NoJVV0FibIfylvR3nQEW+pj/ceEj0YJSD1rhFOFqG8JoGlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPqwkImuaW4Fceshtvkeae5MNDTBQfs936c7pzC7Afoe8mJnG/
	kVYxOXb8BMlzT55kRoQ1qui1XE56ZNZdzoq0pHCrDxO3+9cZQB4S0YHvW690wHijakk=
X-Gm-Gg: ASbGncsgZC/ifRMUyXvcj8uQoX2h67GqvQKIqCWJIeZYXOevYzaThaQbpbMMlXaC1xJ
	WsRP4Z+sh5iGQ6fxM76Gcb2wG0zhjWmHnrbe944CTnvaAw76JlB6ZlXHS0pvPbXhj4Qlg7bz3Dz
	heAOCWf4UOeHphhFMnQJYnaXdfX0gOmlaSDkT+qWEg0KBnt54KR6845+XjqkdenySvL6m7nuLn3
	E2x5xu/vg7uKaC7mmWwUxXJF4GOHtghl9ImGtPmP5UkvQpTfV/aPgW3KJON9HX8M+9dSHG/xf+I
	IcT75Esp4D4vumtIVf297Q2wNbvx74duu5bYSJKBCj7LXdswugGm+kkLCTdRbqS4F/oWX9Dnqg7
	wmUj0EpiRuuWeFWm+YPOFPtHVc1Em4BpV6xJON6LbJtUdJQ==
X-Google-Smtp-Source: AGHT+IG8orkF5yWVfvMT//81luXMNidmsJjDH/qnlbhHQmtj+2joW4b+rCnpdIDDxhcI41r837UxXg==
X-Received: by 2002:a05:6000:420b:b0:3b7:8410:22b5 with SMTP id ffacd0b85a97d-3c32bf5cc96mr2025869f8f.13.1755695248723;
        Wed, 20 Aug 2025 06:07:28 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:d9eb:6295:cf25:b839])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074879f5fsm7662631f8f.4.2025.08.20.06.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 06:07:28 -0700 (PDT)
Date: Wed, 20 Aug 2025 15:07:24 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 09/11] remoteproc: pas: Extend parse_fw callback to
 parse resource table
Message-ID: <aKXIjAGZVnMy4EYb@linaro.org>
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <20250819165447.4149674-10-mukesh.ojha@oss.qualcomm.com>
 <aKWI-izL5BooL61p@linaro.org>
 <20250820111448.tjaz2wld2nxg52aq@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820111448.tjaz2wld2nxg52aq@hu-mojha-hyd.qualcomm.com>

On Wed, Aug 20, 2025 at 04:44:48PM +0530, Mukesh Ojha wrote:
> On Wed, Aug 20, 2025 at 10:36:10AM +0200, Stephan Gerhold wrote:
> > On Tue, Aug 19, 2025 at 10:24:44PM +0530, Mukesh Ojha wrote:
> [...]
> > > diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> > > index ea7034c4b996..8456cca3f3e0 100644
> > > --- a/drivers/soc/qcom/mdt_loader.c
> > > +++ b/drivers/soc/qcom/mdt_loader.c
> > > @@ -22,7 +22,6 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/soc/qcom/mdt_loader.h>
> > >  
> > > -#define MAX_RSCTABLE_SIZE	SZ_16K;
> > 
> > I'm confused why there is a semicolon here suddenly. Did you edit this
> > patch by hand?
> > 
> > Applying: remoteproc: pas: Extend parse_fw callback to parse resource table
> > Patch failed at 0009 remoteproc: pas: Extend parse_fw callback to parse resource table
> > error: patch failed: drivers/soc/qcom/mdt_loader.c:22
> > error: drivers/soc/qcom/mdt_loader.c: patch does not apply
> 
> Yes, I did this edit just before sending when checkpatch caught this.
> Will avoid this in future.
> 

Please don't edit patches manually, fix the commit instead. ;)

> > 
> > >  #define RSC_TABLE_HASH_BITS	     5  // 32 buckets
> > >  
> > >  DEFINE_HASHTABLE(qcom_pas_rsc_table_map, RSC_TABLE_HASH_BITS);
> > > diff --git a/include/linux/soc/qcom/mdt_loader.h b/include/linux/soc/qcom/mdt_loader.h
> > > index 62f239f64dfb..92ad862e733e 100644
> > > --- a/include/linux/soc/qcom/mdt_loader.h
> > > +++ b/include/linux/soc/qcom/mdt_loader.h
> > > @@ -8,6 +8,8 @@
> > >  #define QCOM_MDT_TYPE_HASH	(2 << 24)
> > >  #define QCOM_MDT_RELOCATABLE	BIT(27)
> > >  
> > > +#define MAX_RSCTABLE_SIZE	SZ_16K
> > > +
> > >  struct device;
> > >  struct firmware;
> > >  struct qcom_scm_pas_ctx;
> > 
> > You added this define yourself in PATCH 08/11, so just add it in the
> > right place directly. Make sure you scroll through your patch set before
> > sending to make sure all changes are in the right commit. :-)
> 
> I did this intentionally, because there is outside user of this macro 
> with this patch.
> 

I don't think putting it in the header without an immediate user is a
problem, as long as a user appears somewhere in the same series.

Right now this patch touches multiple subsystems at once (qcom soc and
remoteproc), which should be avoided when possible.

Thanks,
Stpehan

