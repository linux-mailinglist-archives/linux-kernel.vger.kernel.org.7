Return-Path: <linux-kernel+bounces-816561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DD9B5756D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2EA1189E0B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314422F9999;
	Mon, 15 Sep 2025 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="aiHspCza"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37422777F2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930533; cv=none; b=grh5hEH108oGMKSL7CIJzbuyXBQYci/4fa8Iz7LpIYe4R3UsJQ4vpcR7tZhuaGlPzDy3D8C8y424k4kAi6qvVhOee06Wy+dAG1wrnUX8nAv5TdH4c84T3rrb9mIIbROcIzm5Q3h+X5+HE+ylxQN6UizJssrvMtFAd0Nx9kKvaKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930533; c=relaxed/simple;
	bh=E3+oVjwbyn39N5bbJ8PtDEtoLjERba4fXbVGOjw/WDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENCa40Lf20gKhYI5FgiTJjolUq1ImAiGmffroB3g9MtnmKU8A3vYAvX0JHLw7SZWVqd4AJgIHRFYCSjQBU+YsZgET0CARE33zU2AOrQUSbQEqQ3eFSnuJFXg7Q4kOsuYhZ/c0prM6ubcABINouHY/BOYaeOb3MneXgWkb2MkuL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=aiHspCza; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45f2a69d876so7311085e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1757930530; x=1758535330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aRVL9IUAAqgHrjK9nkhZ1Oduj9r/xQ7fhJ7EmcfoG/8=;
        b=aiHspCzalk7rtf1PwXf86Uny47ZFswkpGATv2fmnFHHPUh76nA3cr3kXBJmbIAauLW
         bGflJwF4qDjLEl4T4l7QXxRhAP4W7tL8xjlOJSuRnHfe5w3/10NeGldnlke6hcaOHzi3
         E9Crf32imTfbeIWf6yJLSptDEzIHH7ipE7rmcaxR1RptzRVdtkbK/B1CiumIjGMhVrEQ
         8trowDztboYB7tcdrENMGFQNO18LcJfBwl/CAc8Vgb3NTYZdaRYvLHTes9mo5T373tIa
         7VSnxARPM34RUI3ACoO92V2olg1+ZCqRveARdwgz3NeT9R/3Sp+df6rjV5xKHzTgJ+Yh
         K3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757930530; x=1758535330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRVL9IUAAqgHrjK9nkhZ1Oduj9r/xQ7fhJ7EmcfoG/8=;
        b=AmhO7JQ4vRlc7Sev53qjJ4dJ5RaARYFqSys34LzmkDdcHkC/azDusTQdT23iytkWle
         KHnnL0bPWVquGi2enLI+cVmG6n5moZHgEbwq2Nl6EgVoRWhj0lRUD4eHzc4goBvDaTZ9
         m4l/dIkzby9BOddn+pXamMGlDZifp/DZSg1y3U5suYr7wi1dLF/cDG7y5+D3Csm6OGvR
         MLji9x/xB1cL95rgeQ/4rvEJ+sFYHEzMc9LDWoM8md3Yx6kwWLY7bPOWRtmEyENmUpji
         OiAxt18ybhbThW7EA8OgLGIaDBTgcwL7jrgIX9bwtxbWzPN9ARQNEZvq0lSO3E2RKX6v
         G58Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBruiTXltjQx6qqNvcUnALSnggIl4H3ze3GKqM0HheBpy0MnplG5Fpds0LE9XWRVkJ5yqA+I8BJjV9dYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaVMcBDeKtGxX3SCRWdW/+W4psKGKeftsyas0BB+vUM5JUw6vG
	r9+RhunzM68VFf0n8z3eOrI/VsgqvCAfndmUdzDSxw4vpCXP+rxMnG4U5v80PdV8+rc=
X-Gm-Gg: ASbGncudMduieyIIosVQrbBA6BnO8VL8z6uU8oXR92FRBEOICg6mvneE6TKjDlpb8Kt
	1/uxJvuMH1P0AxY6swrI5LQZXvTiP1BqpOpWWpuvUimTnTb9BbzXy1i9sG5bWijBSmidSirqh0a
	IBoGVjyiDtbe55vfTFULAdVYz4xd2ycb87TuoJ63RPp/7mWmUzIh5uWMhn1rTHbE6rn5RaUxBk/
	t1fjjPB+Mcbqk1IV9z7VYRN0xIhv9Xt3OTwMFclzWpH3C0PHNeIRRECJp3Gz9rkJcz2AE6V5Tsi
	oXS+IILJohRPZc5UHOpDtR+YW/WY7vzrQJAcm4ssrnTtBP46sNBRsg5bYTP8AHvQjw4zN3V5ws5
	Py2jNw4utzHda5L5YROzXv9JbLyHh4ETeciQz2hm1ZBtGmmatMcuZ1AThp81kIHgN7vpvUfJcZt
	pshUhCpw==
X-Google-Smtp-Source: AGHT+IFWv6FkVBTnKeZEQb3UM8U1+lQXiSAg03mu+qCRATFWX8WcP+0O2Dka4KG3lOwejUMfLpLyjg==
X-Received: by 2002:a05:600c:6b15:b0:45d:d88d:9ed9 with SMTP id 5b1f17b1804b1-45f2120568fmr70439915e9.34.1757930529767;
        Mon, 15 Sep 2025 03:02:09 -0700 (PDT)
Received: from airbuntu (host86-160-23-239.range86-160.btcentralplus.com. [86.160.23.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9c2954b10sm5957250f8f.50.2025.09.15.03.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:02:09 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:02:07 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: cap the default transition delay at 10 ms
Message-ID: <20250915100207.5amkmknirijnvuoh@airbuntu>
References: <20250910065312.176934-1-shawnguo2@yeah.net>
 <CAJZ5v0gL5s99h0eq1U4ngaUfPq_AcfgPruSD096JtBWVMjSZwQ@mail.gmail.com>
 <aMQbIu5QNvPoAsSF@dragon>
 <20250914174326.i7nqmrzjtjq7kpqm@airbuntu>
 <aMfAQXE4sRjru9I_@dragon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aMfAQXE4sRjru9I_@dragon>

On 09/15/25 15:29, Shawn Guo wrote:
> On Sun, Sep 14, 2025 at 06:43:26PM +0100, Qais Yousef wrote:
> > > > Why do you want to address the issue in the cpufreq core instead of
> > > > doing that in the cpufreq-dt driver?
> > > 
> > > My intuition was to fix the regression at where the regression was
> > > introduced by recovering the code behavior.
> > 
> > Isn't the right fix here is at the driver level still? We can only give drivers
> > what they ask for. If they ask for something wrong and result in something
> > wrong, it is still their fault, no?
> 
> I'm not sure.  The cpufreq-dt driver is following suggestion to use
> CPUFREQ_ETERNAL, which has the implication that core will figure out
> a reasonable default value for platforms where the latency is unknown.
> And that was exactly the situation before the regression.  How does it
> become the fault of cpufreq-dt driver?

Rafael and Viresh would know better, but amd-pstate chooses to fallback to
specific values if cppc returned CPUFREQ_ETERNAL.

Have you tried to look why dev_pm_opp_get_max_transition_latency() returns
0 for your platform? I think this is the problem that was being masked before.

> 
> > Alternatively maybe we can add special handling for CPUFREQ_ETERNAL value,
> > though I'd suggest to return 1ms (similar to the case of value being 0). Maybe
> > we can redefine CPUFREQ_ETERNAL to be 0, but not sure if this can have side
> > effects.
> 
> Changing CPUFREQ_ETERNAL to 0 looks so risky to me.  What about adding
> an explicit check for CPUFREQ_ETERNAL?

Yeah this is what I had in mind. I think treating CPUFREQ_ETERNAL like 0 where
we don't know the right value and end up with a sensible default makes sense to
me.

I think printing info/warn message that the driver is not specifying the actual
hardware transition delay would be helpful for admins. A driver/DT file is
likely needs to be updated.

Better hear from Rafael first to make sure it makes sense to him too.

> 
> ---8<---
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index fc7eace8b65b..053f3a0288bc 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -549,11 +549,15 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
>         if (policy->transition_delay_us)
>                 return policy->transition_delay_us;
>  
> +       if (policy->cpuinfo.transition_latency == CPUFREQ_ETERNAL)
> +               goto default_delay;
> +
>         latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
>         if (latency)
>                 /* Give a 50% breathing room between updates */
>                 return latency + (latency >> 1);
>  
> +default_delay:
>         return USEC_PER_MSEC;
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_policy_transition_delay_us);
> 
> --->8---
> 
> Shawn
> 

