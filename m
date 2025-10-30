Return-Path: <linux-kernel+bounces-878351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12802C205FF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96321406D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DC327AC3A;
	Thu, 30 Oct 2025 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+ukieSB"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2984B253944
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832066; cv=none; b=iMIsYmhQFJDJ2F+xF6n5UPgE4/K2OF/8WXlwl33ofRndQGIQWGhTuIH5O9UH82pYn7SgtewiUiDDHlhdfAp5y4yfuCRDaaJNUbKS29u46tRTZTRqMCQiVCb+aZe1BxMaDHIT5thU9Jll2jAuBqe0VUylTmbm3h86S8xNdsHObk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832066; c=relaxed/simple;
	bh=AY+CDBY4PLxI7P+PpNy9Oj0nzr+S8UXCYjUpKPKUffI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PI+b8g0UNJIehVqTDyL8Jin8OZHhSmlWHmQAeSkRD6SFtk5fcSidWYFxSvwbTp7Y42T3oRzdPTWBblU2yQ8Al1lfwPWA/qn9GAjTpEEKZg1kQ9GZvSYKt5UtQAa3sMIDCh+hoyeNNHsFnDhw9SuK5by5FlJmGb8m0xehkc0Wgu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l+ukieSB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-475de184058so3677015e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761832061; x=1762436861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N5oy551G97AvWTlfPjNACgXvTrySxuVW8nynKmQcNfI=;
        b=l+ukieSBM7ZgAi1PKTt1uya7Yz4sv/bVf/s7tVDAIJt9vbc3o9JefAyUE5jPz6wnCP
         kjryk2BjJSRb6xw3e3B8c1WAXgrJDWxTrFvQTcyHQ7MbTiITPhgcEXrmzQZRN09h92qI
         vd1ex7+US8C+He3/sH/TLwY3JDdv0dOgG6oMT5WFBRDd4dpHhtP9AfYNqmUEf6cu4J7R
         gMd7ceagQ9BRMY2Lg5/0ijL/J78gbWdScoCGEZ2Gw/4/HKMqEii2JzO2juquTgnDJqdl
         qd6NW1Rjh8YE0a5INsH1XowZ7H9yt1fb2n9iJhhdwGmNWQjyw/yqL48O07nhyG5/mgXR
         1pyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761832061; x=1762436861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5oy551G97AvWTlfPjNACgXvTrySxuVW8nynKmQcNfI=;
        b=aYkJgU3DA5wt2w33lUTFuk12zwFeJWT0nTv3EsM+q5rfRQQwBScpOI6n8B9cBLKihW
         9RByTt+z0tJBj2ugzHOmgAuKfWjUm4eMgOkmlNPZTER2E9DWK9hPd6RAgEwRVUl3E6Yc
         Wa4OJILldDW626PFOfEIp2vv7M6fERpgOdcfcY27K1AMczhk3sm+nN6QMs0Mvw7p9rqa
         lm6+hev6Y3jnfHvdFc0vKt9peowXrDPaAdYWpi/CC6d1CZajD9e802H59/A7VXMjqbKb
         uPQby29gxiSHJEUYU0kvNHJ60GJbamdRN2t6l8wyBrtakBjywht1VaS3NWZvyThkeByi
         Detw==
X-Forwarded-Encrypted: i=1; AJvYcCUlVyNjAeoLZlGejuUZZg5z02qpzwEV3nJRmcWaP5QfmB4VE1Nl9dwqwf6UT1AvT5ZTATgvRsrAkseBMuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTFYVp66o5mAR0ehaHLH3v3oi+YVPlEUnCF2h+VpHO92AZbJTV
	n0CVn4QkbwZmiNmXKuRFMWL7yBMYzAVsAFpSpNzf29+s1QYusfCNJaGR/gcuGq8Iyy0=
X-Gm-Gg: ASbGnctumu6D80rvKgNLogQOw4Xqht922Tw20Vbl7JjQ67DVgdMmlsRc57dNRAt5rlP
	S/KMMtaluI/GqB6zQhw1LvLij+ri+NjsSAvjfBl2N5th2s4sWDvDmSpyHDq3dO6Qvp9v3SLvsE7
	+DSq+mF1w6nyEBjWUEBHJehq+fjcTc4t+pz62V7VcAJlu9oaArWyTsJLDzAd1qikI2iBoTJ/VoL
	tMmgvSo/o7bN1YZxqRKX8YCzw1hcMOO1H71NCIAnHmbScAyGIlVv+9iDTS9ggOJgEMRnC8nuHHl
	XSxzQ7c93+mJUxDbdn5AbVw0p9Dy0/iCI+BXDCP4JdhVQc7iojHnnjXfsihh0LONl6xeO7SJhXf
	tMDY9jDmM1L+8p1nnJckf7lEMnVhsnDQ8YbpIy1AAuEMPw3dAgr++zdLr6v/XoZaTGiKnbOWYWy
	qEnGg+LRXUygJQgIxz
X-Google-Smtp-Source: AGHT+IEGjvIHlQGkUBC+PGpTEGexGfWmAsl85uVWhUANnlfdtG1SHkJVwVUXptzoK6kB191rqoImUw==
X-Received: by 2002:a05:600c:608b:b0:475:de12:d3b2 with SMTP id 5b1f17b1804b1-4771e1f1dc2mr67237905e9.36.1761832061262;
        Thu, 30 Oct 2025 06:47:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4772fabe202sm690685e9.0.2025.10.30.06.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 06:47:40 -0700 (PDT)
Date: Thu, 30 Oct 2025 16:47:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
Message-ID: <aQNsecHJSO2U68Fc@stanley.mountain>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
 <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
 <60f881dc-979d-486b-95be-6b31e85d4041@web.de>
 <aa99eded-be51-af3b-414-7c3bbaddea4a@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa99eded-be51-af3b-414-7c3bbaddea4a@inria.fr>

On Thu, Oct 30, 2025 at 01:31:49PM +0100, Julia Lawall wrote:
> 
> 
> On Thu, 30 Oct 2025, Markus Elfring wrote:
> > @@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
> >                         goto out_err;
> >                 }
> >
> > +               memcpy(page_address(page), CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
> >                 page_addr = page_address(page);
> > -               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
> >                 kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] = (unsigned long)page_addr;
> >         }
> 
> Not sure what is the point of all this.  Try:
> 
> - target = object; memcpy(target, source, size);
> + target = memcpy(target, source, size);

No one will thank you for making these changes...  :(  Please don't do
it.

regards,
dan carpenter


