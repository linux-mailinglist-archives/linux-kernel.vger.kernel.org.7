Return-Path: <linux-kernel+bounces-733923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3767DB07AB4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217071C243B1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83B12F5326;
	Wed, 16 Jul 2025 16:08:43 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAB6264A71
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682123; cv=none; b=RzY43msGY1WUELRND5RFC2FEqzITAIxVtHgqVPQEZ89M6qo1qn22C92lg+aJ+bI8VxKBLfe0FoGgFkKmdUHZ9Wq+Ccd7HwsMP3knOaMWXy3IZ1//1+M9brw2bdTHllTb4N15R5VAl/Sojs+h9rEXeCwCDLEUZmyK8TrOXdVwOK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682123; c=relaxed/simple;
	bh=RuJ0y6y+QAI9WVzMzX/KikwojyoXGGOl1EPIuSN/pqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eabSS5BRBOjtWr5nRYBXKu6RuDbmSd2Uc9RXGAzQV59f0YmzTJmGSGr1hhu3gglxuKP17gqvMbHeKLzkSFDPv6vKEmSetFH1N9Nhe2vK61NRk5Jy9p9zNp2q7HUb4lBiBRAmYf1APSv9/7G8MGxBB8jrZAnjTo3Lt9QEh4WyhA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso11422553a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682120; x=1753286920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjhPeDzwKMbLRpiaCQVZDGt0RvE2h5eKhuFW3u9Cc4k=;
        b=nqpQ0EyIPhJPIP25ea+ukhI49JNnGlysgWf6w/flCY+jbag4+Iaxhnz1RZN//OcCYA
         sZJh0tfQa1epcXJlv1jIKU6cRh6LM6tmVhD7pJD1CbH/iuvCnHaj7qjp8cUTJ089ux0F
         GzHiPDXbUbHXhDsX1mu/N8/nX5dlBmV/ajy/VVM5j6msrcKG/qaHNABDMlCIgM+UGcVJ
         BHUljoxM7vafvmBMvva+qPreMm65h5Ke+YR0NR9Z9EIvFld+u65m8N4uQYtMfg6kz83+
         LKUZcXycT8aMRJzexhGmWZ2yRYa42IfTaQ47bJ17UVnDlu9a7VlXq6ezJCrSMTB1zVbB
         K92Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVS9vbkCfEw0SuGieI9xNWn8FzHq2y34FNKLaq4Hfu9xHV8Kw49hhFj/EnMaupbcfrYT0Lud2va68wNMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1JuOVUnmGyXgwdQag8wfRGj8Eufqr7YS5lBlaZm1l512YcV22
	286/Lm+Lw5osjgbiLFi8S8XW0QVyLi62uiF1Ch8K2v15E415rkeXDfHV
X-Gm-Gg: ASbGnctKVSIPqX1o+fDNavh8zp/kvXCSSvTxG5K6VUm/Gseqg42uaOmJNTgwhGUvkZx
	bP8u+Qp15+65rI/aA3o4Fg0fXOmE7AsxzOtAD2SiJcypZRwaQauapDW3OusxbSKwfcW42TnZz8y
	J0J0X9iSKhMT4lcUfApK4KC46T5cvUSEhsBNw6UDtjn7Z24I0SwImMb4/qKBpq0KSU1mHNi3I8o
	YAinEU8YpddRGbaj3sYrmD/lTn2GXSZFK4GI+qYxptyWH69JpcbbQZG+4I1t14nEPKwGMFzw/uP
	845YfwDqTDcRaotJdhdpolzZmqQDpVb8z/no8hq/G5AGElkA7ZFZreli8pon4plOA7LAVPaspl1
	cqDlxXJ2giuDk
X-Google-Smtp-Source: AGHT+IFnkeUOGi9pD7dry62krv8SIZuFe1pRe8oR5Vur8GS5Ex8kCG5MXl5cty9UiHysD9gduqJFnA==
X-Received: by 2002:a05:6402:34c3:b0:60c:40bd:8843 with SMTP id 4fb4d7f45d1cf-612859338a2mr2877101a12.11.1752682119791;
        Wed, 16 Jul 2025 09:08:39 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c976ecb6sm8848523a12.56.2025.07.16.09.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:08:39 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:08:36 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, jake@hillion.co.uk
Subject: Re: [PATCH] sched/ext: Suppress warning in __this_cpu_write() by
 disabling preemption
Message-ID: <imrfubmkw3a6qdznnpounrnen5ituzchwtbjmouocuk77upn67@ljrz32ppyqyr>
References: <20250716-scx_warning-v1-1-0e814f78eb8c@debian.org>
 <20250716125128.GX905792@noisy.programming.kicks-ass.net>
 <aHel4LvT_Y5gpYfy@gpd4>
 <20250716133631.GZ905792@noisy.programming.kicks-ass.net>
 <aHe2j6pIyQiBf1S_@gpd4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHe2j6pIyQiBf1S_@gpd4>

On Wed, Jul 16, 2025 at 04:26:23PM +0200, Andrea Righi wrote:
> On Wed, Jul 16, 2025 at 03:36:31PM +0200, Peter Zijlstra wrote:
> > On Wed, Jul 16, 2025 at 03:15:12PM +0200, Andrea Righi wrote:
> > 
> > > The idea is to track the scx callbacks that are invoked with a rq lock held
> > > and, in those cases, store the locked rq. However, some callbacks may also
> > > be invoked from an unlocked context, where no rq is locked and in this case
> > > rq should be NULL.
> > > 
> > > In the latter case, it's acceptable for preemption to remain enabled, but
> > > we still want to explicitly set locked_rq = NULL. If during the execution
> > > of the callback we jump on another CPU, it'd still be in an unlocked state,
> > > so it's locked_rq is still NULL.
> > 
> > Right; but doing superfluous NULL stores seems pointless. So better to
> > avoid the store entirely, rather than making it more expensive and no
> > less pointless, right?
> 
> Right, we can definitely avoid rewriting NULL.
> The following should do the trick.
> 
> Breno, can you give it a try?

Sure thing. I've tested it and I don't see the warning on my side.

Would you like to me post the patch, probably removing the WARN_ONCE()
as raised by peterz?

Thanks
--breno

