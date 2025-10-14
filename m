Return-Path: <linux-kernel+bounces-852461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CED43BD90B4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E5DC4F1835
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F6D30F937;
	Tue, 14 Oct 2025 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BufL00nZ"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106C930E849
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441513; cv=none; b=Y9SZzAOkUVq3KA1dLbckQIuOtuZxctGVAlPuErOYPbm0JAYri7E9JImyGaiGVDFzriyqPctEYMqoJGOI28lNwgUSA6clMEfp3BiY/sIH7d4TVLJkA1YCxR+0JzgFnYZSOceiR2c0ToI7lyBJR/JGwZCZ1BG60fVV7KBoQYkhAX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441513; c=relaxed/simple;
	bh=3w4nQi9hgenkrHPxz75XSwpRlBt74vHGiJuFZQ2tndI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o67FiuIsOj01hIumw/o4ipHGC4+nJLinyhTu9jvbgQxMyYwk21tgKWaaugdxBapcdKUoDlgkxbM3ifJuaWZ7cSvmyB6THjOCcFHrVQFrjJ4yLXLyNCZ1ns2ap76o5ZRJ+/kqGiPxNdAEfQGrmqxx4G8zmzMY+IlsfDkGTSNPGuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BufL00nZ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4257aafab98so4417272f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760441509; x=1761046309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ofkJNulQu/wtU9ucbaTHhfLlEv5BRzrjhZDncPD/y2M=;
        b=BufL00nZh9qhuBc5qgR5Gi7wrEyoyBJ2aCnu38k6xzJqx5c4e7Ofc2nWW7Ckquh4hU
         TffDOrnCd0DEUCpmC/7BZMK89drnwfWoi8CAsatcHK3dkzbLvzHZ0dtRa3KICIqnxJPP
         DE2+mYd4h2gqbI10/7LJwE6YYmeJEOoPq/6M5Gi7W+wqP1WOJjmnYhtgIw4EjEjR6aTP
         f0pxTpmOMWezUCQ4DWxmuFqrEG5MD1Wlb8KTc41UJWNlVHaSY5JXpC0VU6YivRWfvlyM
         PqSsf9u8hBO+wPzxbNtuiwBEReUeNO8ftTLCMFWK/xoA6rjrcAUoZyIGAVtJyLDSF+8x
         n4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441509; x=1761046309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofkJNulQu/wtU9ucbaTHhfLlEv5BRzrjhZDncPD/y2M=;
        b=ZousbfRbXQPO0cA3PAbRS9nr2tdm2E8iOgbMQd0CQCgnFBNM/cM87ssbsCxr4hkDWA
         IHpVn/ytQa0xzaBb2iUrotiTpge8C+D67MCYJURXrDm4qyQP6TzUyn80F7nLV7Vq2x1t
         UwSZUKfvFnyIo5TBfvbZHyIxV1cFTSnMIDf8K3rHFFByLxj8/TxdxGCS4Pu+W8YQh9jA
         ClYh/4huJAr5nK7f1ukX5REO5NVsOX3xesvruPSHAk/V/bahsPJWLMAu+HHxNSDU3V2R
         G1R73d9+Wu7sJx9lEPI4JM7qE4KbuLVEnd42jm1YGik9yiJlTk1zQY5bikm/kOqP8A5H
         +rTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlRTNqa+WmcBoHPOo1jLq1eAStVGI2xcOI7bJp8yDTWaMTySM0ufo0OY//xc/kFCYzlud0+cZgeZy1rxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4IfxVqhLAIMLZq3plTL8PrhdEY3WTHYHVHCpS7sc7+uN63ezz
	OFg8tIN6Oxmv0Fuv68n75qG8KJwWxkBzYsJqTKLnvyHYgUbw0VwENce+FrByarsZYoGrVGwZ2NM
	ADYMV
X-Gm-Gg: ASbGncu5mZdBgTR6dl6lJRFGBMl6CpP8sYARvaj7YhESkgo0dlHTD933eVFsYZWGqnr
	qflrW3Kpqw0IKuVTAQ15t+E8hOwJYOUBn9PdNARDa3NLCyLWqhtLqoRvub5gkTe94HBmMGGgruu
	wmqCn3DAmAnnj7LTrRkVaZ+4DQaTbAVMcKL2NjQhk7lU/LnHs4y+i77X+kaMjmXgPcp8OPstGmp
	LcTKF9zC4ssyj2Yn03/PK93RKASRa3h3JpezotmyZ+Wviy2Vn5LClyRbGsSWE3vw4Up1ivptSsY
	ZlGmbQqeczWDVQGUvaFzZaNM4fnFXjURbOehFaVO29mAnQfeNBmcBGsa3i+rOc2snCHhsUmQ7hM
	A7E2RElYFduWNHYR9yu5Uv/aTVf3Hz5eZFjzhlL+8FSLpZHEnTwQ=
X-Google-Smtp-Source: AGHT+IE7JRJVgX/0XRZqqgOQ0IMTJn2bfv2E4RS1BB14d24blTgxq9Or2UqVDIrAHI/wbElOafShvQ==
X-Received: by 2002:a05:6000:43c7:20b0:426:f355:7c9a with SMTP id ffacd0b85a97d-426f3557ce6mr628338f8f.25.1760441509084;
        Tue, 14 Oct 2025 04:31:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fb49c4027sm234419565e9.17.2025.10.14.04.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:31:48 -0700 (PDT)
Date: Tue, 14 Oct 2025 14:31:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: oe-kbuild@lists.linux.dev, Peng Fan <peng.fan@nxp.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Andrew Davis <afd@ti.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/7] remoteproc: core: Use cleanup.h macros to
 simplify lock handling
Message-ID: <aO40oQkj9sT78bMV@stanley.mountain>
References: <20251010-remoteproc-cleanup-v2-4-7cecf1bfd81c@nxp.com>
 <202510121908.7aduLIkw-lkp@intel.com>
 <20251014104511.GA14479@nxa18884-linux.ap.freescale.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014104511.GA14479@nxa18884-linux.ap.freescale.net>

On Tue, Oct 14, 2025 at 06:45:11PM +0800, Peng Fan wrote:
> Hi Dan,
> 
> I am not sure, Is this false alarm?
> 
> On Tue, Oct 14, 2025 at 11:39:41AM +0300, Dan Carpenter wrote:
> >Hi Peng,
> >
> >
> >vim +/ret +1841 drivers/remoteproc/remoteproc_core.c
> >
> >70b85ef83ce3523 Fernando Guzman Lugo 2012-08-30  1829  int rproc_trigger_recovery(struct rproc *rproc)
> >70b85ef83ce3523 Fernando Guzman Lugo 2012-08-30  1830  {
> >7e83cab824a8670 Sarangdhar Joshi     2017-05-26  1831  	struct device *dev = &rproc->dev;
> >7e83cab824a8670 Sarangdhar Joshi     2017-05-26  1832  	int ret;
> >7e83cab824a8670 Sarangdhar Joshi     2017-05-26  1833  
> >c42baf6f84c7694 Peng Fan             2025-10-10  1834  	ACQUIRE(mutex_intr, lock)(&rproc->lock);
> >c42baf6f84c7694 Peng Fan             2025-10-10  1835  	ret = ACQUIRE_ERR(mutex_intr, &lock);
> >7e83cab824a8670 Sarangdhar Joshi     2017-05-26  1836  	if (ret)
> >7e83cab824a8670 Sarangdhar Joshi     2017-05-26  1837  		return ret;
> >7e83cab824a8670 Sarangdhar Joshi     2017-05-26  1838  
> >0b145574b6cd2b3 Alex Elder           2020-02-28  1839  	/* State could have changed before we got the mutex */
> >0b145574b6cd2b3 Alex Elder           2020-02-28  1840  	if (rproc->state != RPROC_CRASHED)
> >c42baf6f84c7694 Peng Fan             2025-10-10 @1841  		return ret;
> >
> >Please change this to either "return 0;" or "return -ERRORCODE;"
> 
> ACQUIRE_ERR should already returns 0. This change does not change the
> assignment to ret as my understanding. Please help to see if this is false
> alarm or I miss something?
> 

I guess if this was already merged then it's fine.  But "return ret" looks
like an error path where "return 0;" is obvious.  This code will always
trigger a Smatch warning, and I always tell people that old code has been
reviewed so all the warnings are false positives, still someone will
eventually change this to "return -EINVAL;" because it looks so much like
a mistake.

regards,
dan carpenter


