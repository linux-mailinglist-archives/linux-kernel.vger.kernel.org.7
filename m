Return-Path: <linux-kernel+bounces-770945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0049B280C6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25D41C27CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0313F302CA8;
	Fri, 15 Aug 2025 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOLn2gat"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10192FB98C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755265348; cv=none; b=ESFRKjIfXsy09QX5ArrrewSZnXewjeIwpBEQ8tm5cRIR4bvQK48/Ls570I/7Fqv9sI+WhBLaymF+fbvxHtICtqH9GSwLN3ntx4WVvt1H/XKudTRKmyoOGntAzb+lelrW11Y1Eo+qhN6lkZLBmC60hsbOLf/OAzSDR5/zDNaVfX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755265348; c=relaxed/simple;
	bh=PQ8+dfSydKrkvzfm2HENartemvX6MLXX0jZP5Wi/v+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+Yo5VrI0PGB57f6Gp535nvJ3eTF/BJ2QwFVNSfoDv8Cr3N1WSBqcmeJN5s1c0mIfI1I6MVURipuLWD80wANak4VpV8A7369dIoAfaj/DSdSCUdu3WMzdYAh0QpIppMvmqgxePPG8MqBU5q8pO3wqwVmAtl647A9qXdZWGb+wJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cOLn2gat; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b0bd237so14958825e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 06:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755265345; x=1755870145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tay3gLmD8Frwd0JSmKUUlrGu9kRRhF6pKhplgXjle5s=;
        b=cOLn2gatFPWBYGNe3cTRFGUqHek6Ba4rGEbgsc0dkLuynegdo6EBaVj5ltan662UsZ
         kovgTVgmBzzyJ9bQE/ssjPuZId+Za7HlOxZn/cXeKgrZR4q4g+MyE5KBvBWWcFwDyP/o
         AM33KgRkBju8lFD9AEaNYDTP16B7F7tQEChPARoI7nms4rslScEvXi7/iRBc20dcXYvv
         fxhICqvAHo4TLMLF38iPWIjUL6FAPb5jOro5s9Os+U7JQbopkG219xJLU0h0t1sh5S86
         8deCy/0UEB02vpMm4XU1Uf7V8VVmnzqLS/8CnREb0EYodmr9M/L2h6lAVd5RbRvann6m
         3TVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755265345; x=1755870145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tay3gLmD8Frwd0JSmKUUlrGu9kRRhF6pKhplgXjle5s=;
        b=Xgx2LWdc4QI0P3WfwaHxoZ0mXVcFQAwtpwiDvGf0sBPLDTUZxuVY5Cbkv3cPKrVQSd
         cY/Khj0QhmiVuGvUapFWLWdJxv3yWh0eJG0Gi2z21ZsN8UPlpocnIsk8W9tguc4kEew1
         78dig7loksDPnpqeYthgaY2dZDewh7Ll519/2Bxdt2ukecpYkwvw99q82fQSbU+Iyn/Y
         o/rq4e+NmoPk6PP9sXnzcvqQllKtyoGyQZ3pvq0euYpAEE41Zipy7eC21DMbsImL4Xiz
         ofSYSycJs3qD1rgw+m4NkjlWuGaxZMLvOfw3kmaiU43IUIEBD2AT2UvVn4ZIWl6Z0oP0
         pgFA==
X-Forwarded-Encrypted: i=1; AJvYcCVokcYmChzi6we7lueHFVxzAYNdedx7mkO00BnKdVaKl04kkWLjzEVB26VZMHZSR5iTfRJ3uKECEH0s3Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG8VDczVZo2kQRt2m7A8q+DcW59T5zLBERlQRqUTff0OWuHGXj
	Yhj6jIQg7JkaouMRavqyWO8joERGXD/zvUqlMe4sOCSF3MgQBg4IpYtmUUjZ7nleNPA=
X-Gm-Gg: ASbGncuuwwoBffKGpU3cV8J10i3sxNypclWSqK5FKh0fg5VOeohQqNiqbZb7GexLbSP
	aTwCnCUM8g4m/FoTTWQr11JBmamqKcsWYw0uOAouJp6S+TnhFdwVi03OYOw9j6PhFzwlgaQhpIr
	wlYHMiHAL3HS///saXxYuQ1wxqEl7JKCNSadWdkGM6jmXpwasuzXcbOqtfOBOnNR6hq2oZyY1Dy
	lEzqhwypwgkE21pqR67531s7/EgZslSnp8AQ8WiLjaYdg/v/0ik/5DEaAHW6cbwnmgk+vGWRco6
	By36QifiZKqQ4bIEwfERlJxHQnPD/uBsAQo6WrOw2Vf3F8X2aRMV+cLf1mfL64RXq/7jWVTdlGI
	by2IYGIrlX7lmHBoJDxl6cdcJpb19T92dbQOKkvadGw8=
X-Google-Smtp-Source: AGHT+IFlajPT5BztdSNYp4ivjV5fdtLyMwPsBJGF7bEW9Ww4T7y2G/wB+Plg/hRmOIzKKeMUkjMMbQ==
X-Received: by 2002:a05:600c:4590:b0:459:10de:551e with SMTP id 5b1f17b1804b1-45a218575d8mr17339135e9.27.1755265344897;
        Fri, 15 Aug 2025 06:42:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1c78b33csm62016055e9.25.2025.08.15.06.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 06:42:24 -0700 (PDT)
Date: Fri, 15 Aug 2025 16:42:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: icc-bwmon: Fix handling
 dev_pm_opp_find_bw_*() errors
Message-ID: <aJ85PQbujQe-IZUH@stanley.mountain>
References: <20250814063256.10281-2-krzysztof.kozlowski@linaro.org>
 <e35ca54c-252f-45c4-bfdf-fd943f833bc4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e35ca54c-252f-45c4-bfdf-fd943f833bc4@oss.qualcomm.com>

On Thu, Aug 14, 2025 at 11:15:08AM +0200, Konrad Dybcio wrote:
> On 8/14/25 8:32 AM, Krzysztof Kozlowski wrote:
> > The ISR calls dev_pm_opp_find_bw_ceil(), which can return EINVAL, ERANGE
> > or ENODEV, and if that one fails with ERANGE, then it tries again with
> > floor dev_pm_opp_find_bw_floor().
> > 
> > Code misses error checks for two cases:
> > 1. First dev_pm_opp_find_bw_ceil() failed with error different than
> >    ERANGE,
> > 2. Any error from second dev_pm_opp_find_bw_floor().
> > 
> > In an unlikely case these error happened, the code would further
> > dereference the ERR pointer.  Close that possibility and make the code
> > more obvious that all errors are correctly handled.
> > 
> > Reported by Smatch:
> >   icc-bwmon.c:693 bwmon_intr_thread() error: 'target_opp' dereferencing possible ERR_PTR()
> > 
> > Fixes: b9c2ae6cac40 ("soc: qcom: icc-bwmon: Add bandwidth monitoring driver")
> > Cc: <stable@vger.kernel.org>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/aJTNEQsRFjrFknG9@stanley.mountain/
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > ---
> > 
> > Some unreleased smatch, though, because I cannot reproduce the warning,
> > but I imagine Dan keeps the tastiests reports for later. :)
> > ---
> >  drivers/soc/qcom/icc-bwmon.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
> > index 3dfa448bf8cf..597f9025e422 100644
> > --- a/drivers/soc/qcom/icc-bwmon.c
> > +++ b/drivers/soc/qcom/icc-bwmon.c
> > @@ -656,6 +656,9 @@ static irqreturn_t bwmon_intr_thread(int irq, void *dev_id)
> >  	if (IS_ERR(target_opp) && PTR_ERR(target_opp) == -ERANGE)
> >  		target_opp = dev_pm_opp_find_bw_floor(bwmon->dev, &bw_kbps, 0);
> >  
> > +	if (IS_ERR(target_opp))
> > +		return IRQ_HANDLED;
> 
> So the thunk above checks for a ceil freq relative to bw_kbps and then
> if it doesn't exist, for a floor one
> 
> Meaning essentially if we fall into this branch, there's no OPPs in the
> table, which would have been caught in probe

It would be really hard to silence a false positive like this...

regards,
dan carpenter


