Return-Path: <linux-kernel+bounces-835960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87953BA872A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4031A1678D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BE027C866;
	Mon, 29 Sep 2025 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cszLsQXK"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D4219A89
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135733; cv=none; b=kVlnouSbVmiOQGAe/NQ41W9DFN3uw9Ol34N3CY7vYuvykbugung1JBp8T7XuNvNzJXpAdiOosXhSIBfRwCidzbM3ByVAnVGdezgBs4RMh9mHMzM5H5wEOuEI0A3CdmgtEBPZvrhbfkNo4yhlnt3fbxV4FI/n35dt7Of2x61L8uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135733; c=relaxed/simple;
	bh=g1mm24DACTecjNAJvzrdNdg9fsLkeeEtFb5wtV+hB2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKu9M4qZcg8645svtOYFeT/8QQmKR9eSpHlfrjTddzHyVTtn83s0QTjU7fiugDCzASLf3yLEoXV1Zp4EX8VeTZv/SgOC3VSfOEIMFSnQjAq9YIFqzi/YlmJbvAeNsorj/z2+29gjRfMQiiqpsVDnyAd1pPle8MgN1RILfPFdtjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cszLsQXK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-414f48bd5a7so2591794f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759135730; x=1759740530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vltcl8v69f7bQvSIghkVp5oW+UsVhLKoUiMkT13h1P8=;
        b=cszLsQXKA+hQatxVZmdT/IBnFLmBjYDfohxAB8MmgODQ03G8bjEVJFjKbdAPdF5V4s
         dfiBpFj+vz8tqAffmc6Z8ztZLfXfddDbzo8RavdFxRhmjQ8oLD4LJsbyDEzQzdkJhi+B
         UV704jEiv/+Zvrs1TqiDUJf5575NlqkkaRUFfSFJ1brsnc9486v09Fiu8MSWF7A235X7
         y2rg0LMJttn+RufI7IoTyUO1gzjiUsPazyv6OJBn7MZlN1zyzuRNEyMJUwh798lrVPFt
         sV6ijIGTcerhi4304Of1MgyEXCkpITqMc6WUadzFh6XmnXt76Cc3vw9lvo/BNNvwLiUY
         BctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759135730; x=1759740530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vltcl8v69f7bQvSIghkVp5oW+UsVhLKoUiMkT13h1P8=;
        b=RJ7BO+/tZCEgdON+RwwwORlRxn4hKs4eL1a4rtrDUq6UZ8i7IQ2n2GTgEU21lXPWXV
         2iZdugauENF6cm3TaLYPpiCGZ7n1qrBUi5v202aQl+bZ/6vhTC514IUBWs+o5wC6iSMW
         /TpD+Nb4qfhGuHQxdYpXVg0r4lPkpg94yuJmJZYp8l/SQ8PwS7c6vO/8JF+WIyQCbjeM
         Zs+0TqjzCy9TOe4HILd357Pi0Nss5+1gJngDxyKQ8E7dKzyVuRz65yLs4tAjHYmdGgym
         43CWDpsTlwAXtBwBUIsvjXQT6GzuDubF5gKuePn68PDtRJWV+SrZNKVhLWh4f05r76ZE
         m2Ig==
X-Forwarded-Encrypted: i=1; AJvYcCX8GnkG05KW3W/0GrDzToqzD75NSiTxxImmRVUpyHiCs3R9heYnZSEU6Ja5HfPwKH9i5XEjQB1ouA0evsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVPQuzrf7Is5o5CVTISnx/zmE/v2eVvO6kGAmb6UU32LKVIFH
	ZH5ofkAcm2xRDu3IVSBbgIswpLNFXqiGZL//aw6251x+KN1S/SdMBlEFRgpzR1tpg1KRTDYoVJL
	dixjx
X-Gm-Gg: ASbGnctPt9r6xkgNlcX7oTwylfechLgo7MwujCrci0z9UO1Q/ugD4oR2NxkvOHFy3VM
	7gjIDP+FnvgZ8cVcxh7VkyFvF3xR3cG6J7zPTnOwPYWJNooWkzGLohevQXz4SIWUNyByQMm+klO
	xLyosMiO74dnvdp5Bp0mBucf3/SSXvbAGrWwl8Ekbp7fHPgu7xcbCTLKeT1pM0wGNdQHd2Q04RY
	CVo/18PwdvrE3zMV4BfsjffLR8Z+fnOUmlkAhFjQIsiGyiyvgFyAON1b4iNQoefAdXfl6Oi7Nxf
	s1Bv816oKbACU/ZALC7JzMT1JQJSaua9gyVRlvIXVKShg3E8jV0Nm2Qh03CnPtghH5CON45TCFR
	/LRfO/i+ru+qWyyeevGVMYZnWMPbQ4TAbiRoz6tyLtqVqMrzY5g==
X-Google-Smtp-Source: AGHT+IHq24YEQ+NGSgOKpmgkwFuU/SY2eluplaIZkQeebKuol6LbVx5PSlBlDAWVI5mgbmhWjPxYOw==
X-Received: by 2002:a5d:5f45:0:b0:3ea:a496:9ba8 with SMTP id ffacd0b85a97d-40e480ca410mr14224093f8f.29.1759135730161;
        Mon, 29 Sep 2025 01:48:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fc5602efdsm17883106f8f.34.2025.09.29.01.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 01:48:49 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:48:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Mary Strodl <mstrodl@csh.rit.edu>,
	linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linus.walleij@linaro.org,
	brgl@bgdev.pl, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 1/3] gpio: mpsse: use rcu to ensure worker is torn down
Message-ID: <aNpH7gfhJXIBbCQZ@stanley.mountain>
References: <20250923133304.273529-2-mstrodl@csh.rit.edu>
 <202509290823.hreUi6Tp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509290823.hreUi6Tp-lkp@intel.com>

On Mon, Sep 29, 2025 at 11:46:24AM +0300, Dan Carpenter wrote:
> a14b0c5e3b0741 Mary Strodl 2025-09-23  339  		/* Make sure list consumers are finished before we tear down */
> a14b0c5e3b0741 Mary Strodl 2025-09-23  340  		synchronize_rcu();
> a14b0c5e3b0741 Mary Strodl 2025-09-23 @341  		list_for_each_entry(worker, &destructors, destroy)
> a14b0c5e3b0741 Mary Strodl 2025-09-23 @342  			gpio_mpsse_stop(worker);
> 
> This needs to be list_for_each_entry_save() because gpio_mpsse_stop()

s/save/safe/.  #CantType

regards,
dan carpenter

> frees the worker.  Or kfree_rcu() inside an rcu lock or something.
> 
> a14b0c5e3b0741 Mary Strodl 2025-09-23  343  	}
> a14b0c5e3b0741 Mary Strodl 2025-09-23  344  
> a14b0c5e3b0741 Mary Strodl 2025-09-23  345  	while ((irq_enabled = atomic_read(&priv->irq_enabled)) &&
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

