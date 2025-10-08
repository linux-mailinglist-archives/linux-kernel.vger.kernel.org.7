Return-Path: <linux-kernel+bounces-845259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C669ABC42EB
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 11:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A181D3C746D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 09:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2172F3625;
	Wed,  8 Oct 2025 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FiRw7aLo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E4D23BD13
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759916609; cv=none; b=h3gy4TQfuaQP3iJhBEy74OuBm4wrQ3RpVx/By0cHk5KjYYWQECLjMbKsMBCFxXQOckhLdE70bve2maf+yR7sA+syvERlKYb4TGvJlIw8IIT5G7wrfyBaCZxz5Z2tI3o8tOg74Z2WVTpiyUHlXfKssvuULdwNcoBT154rLdOrVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759916609; c=relaxed/simple;
	bh=UTW5mtv7Lyr9/eDXszw01FGvctILLITZPcdY0ymNFqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1hGbnMEH9+skknbid1BvPdCIm9RowknzJEfVFERGvL+edpy2LVqWNY9LJ+2k9yoCLaLKd0e4fSVuR+3eJnfXgEW/5EdmMKqg9DZ0+ZOi6G9KhsTOTPGx4wgDd7roXiSs5yCSXhKHf/85VaYvjlynZQJ/h1IS1rx5/YCoFtcoIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FiRw7aLo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759916607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ru66GWqBbf75/3gN0RGafI2ekfutqLRJQg30YGzf8Nc=;
	b=FiRw7aLouzZ/7mvPr0p+ZZClU56/l1OAhG4yivlIkG4xoY9p4WYM0sGadG4ul+F2IzRFeE
	mnwXp3grdC/DtuE+f55urHlUqnf7zK/DtvQyyKDlCLYuw21pgWahYYOOb00smLuIXs4omr
	Y4ylJFCCxi/dfjYols5yarfbZ5gj0OM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-j1eoVJvdPpe3LHyolFbrnQ-1; Wed, 08 Oct 2025 05:43:25 -0400
X-MC-Unique: j1eoVJvdPpe3LHyolFbrnQ-1
X-Mimecast-MFC-AGG-ID: j1eoVJvdPpe3LHyolFbrnQ_1759916604
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso345237f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 02:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759916604; x=1760521404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ru66GWqBbf75/3gN0RGafI2ekfutqLRJQg30YGzf8Nc=;
        b=wGG1fSU+VYQRtYjkmvgN7fHpzXuhLDTOZgZfbl+0tEirP882B56HVIBEOjBV5l8Na6
         iCld9Rt/N+NaqgwY92cYOgDDENMmQXSrNEAvvESrGsZTTO+3IWwNhjUYkQ7byg+phple
         e3MTHw/qGCnmh1tqzMFsCkToMi6TdNT/VotfViXzwG+RkKz3zBh4t58N+/4mw2KoHCWd
         8KklE2jv1/LUfIVefIw6tpU+5oHaRJDRHt0oTexvcw5oXmFaGh2d5NFcs365PowxoyjM
         NvwUThi43fpIaoVI3De0oA7Eiu52akPaYm2P6jn6OBgGdK3qqwYojU5o+eVZ05/fvEQs
         7RaA==
X-Forwarded-Encrypted: i=1; AJvYcCU4AlUiqLtIjA3m9A8zv0PX3DQOiQzotck45robYIgUzccJ8u0m508PfgnHPIodxw9jbCMGdNVO3FkVXYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPaIIIsbqCgq1jTbSoiL3jFU3/mXByZcnEq3/Kbjb/1phvGbAJ
	9hboKcBH5cWhFcUzVlErWNTQQwuO/K6ljEp67eD54lOaVsKV15lj0B0HrxOi7etlp51eXMu2NVe
	8/q5v+YVXiJBypcnxl71EeVGAGEVNJ8VQTuw/rS21e01llYyMcoD9CFwYD/7w4YRqIA==
X-Gm-Gg: ASbGnct/3vm1+lwGu/Y5T0CWfpRVQMGaNVGq9vmPnk5l+y6Hee0emSJJRAtj04UFy8x
	qhz7N+RqENv22SkrJMRAr43tnj6h27ILv3KVAiSwmmJkhTTX4uvyxsKOAOrsNS3QWd1mUViElRZ
	W1kI75T4zZHsCP962zp4r9uljdl4y2/v4ESFuRBzfhE66nLBZYElxdEGfOIUJnjRrNrYE5d32KE
	jud1+qAqkGT2ANKXiv8AsVtGOV59tcK1IWy4qDMGcLtM9mua9YWyb60cLlsXAIRjvwOnZMC7/y1
	byZ/YlrIfJ1Do1v0C1Iz3TTBu8d+duCcuWs6rjxXByKB3EnfBv1gyY40uyFcRdYUe3DJ15/d1Uo
	4gw==
X-Received: by 2002:a05:6000:310b:b0:3d3:b30:4cf2 with SMTP id ffacd0b85a97d-4266e7beaa3mr1451509f8f.19.1759916604381;
        Wed, 08 Oct 2025 02:43:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9rUnK+CzKM3Tge7L83s/7DmaOGIMKz5YVjnXrE4Jnj285Du60+ERNzF+vGaZ3ET1i00K20g==
X-Received: by 2002:a05:6000:310b:b0:3d3:b30:4cf2 with SMTP id ffacd0b85a97d-4266e7beaa3mr1451484f8f.19.1759916603909;
        Wed, 08 Oct 2025 02:43:23 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f01a0sm28969251f8f.48.2025.10.08.02.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 02:43:23 -0700 (PDT)
Date: Wed, 8 Oct 2025 11:43:21 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, tj@kernel.org,
	linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 10/12] sched: Add locking comments to sched_class methods
Message-ID: <aOYyOYrzoKDLCl7F@jlelli-thinkpadt14gen4.remote.csb>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.694841522@infradead.org>
 <aOTjSla1Yr3kz7op@jlelli-thinkpadt14gen4.remote.csb>
 <20251008070419.GR4067720@noisy.programming.kicks-ass.net>
 <2025100822-drained-foe-2426@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025100822-drained-foe-2426@gregkh>

On 08/10/25 09:33, Greg Kroah-Hartman wrote:
> On Wed, Oct 08, 2025 at 09:04:19AM +0200, Peter Zijlstra wrote:
> > On Tue, Oct 07, 2025 at 11:54:18AM +0200, Juri Lelli wrote:
> > 
> > > Not for this patch, but I wondered if, while we are at it, we wanted to
> > > complete documentation of these flags. My new AI friend is suggesting
> > > the following, is it very much garbage? :)
> > 
> > Heh; its not terrible. I've been playing with local LLMs, but mostly
> > I've found they struggle with getting enough context to not be utterly
> > demented. And when you up the context window, they get unusable slow :/
> > 
> > Setting up and configuring the whole pile of subtly interlocking stacks
> > of software to get anything useful out of this stuff is non-trivial (it
> > reminds me of the sendmail m4 days).
> > 
> > > ---
> > > 
> > > From: Claude <claude-sonnet-4-5@anthropic.com>
> > > Date: Mon, 7 Oct 2025 12:44:13 +0200
> > > Subject: sched: Document remaining DEQUEUE/ENQUEUE flags
> > > 
> > > Complete the flag documentation by adding descriptions for the three
> > > previously undocumented flags: DEQUEUE_SPECIAL, DEQUEUE_THROTTLE, and
> > > ENQUEUE_INITIAL.
> > > 
> > > DEQUEUE_SPECIAL is used when dequeuing tasks in special states (stopped,
> > > traced, parked, dead, or frozen) that don't use the normal wait-loop
> > > pattern and must not use delayed dequeue.
> > > 
> > > DEQUEUE_THROTTLE is used when removing tasks from the runqueue due to
> > > CFS bandwidth throttling, preventing delayed dequeue to ensure proper
> > > throttling behavior.
> > > 
> > > ENQUEUE_INITIAL is used when enqueueing newly created tasks in
> > > wake_up_new_task(), allowing the fair scheduler to give them preferential
> > > initial placement (half vslice when PLACE_DEADLINE_INITIAL is enabled).
> > > 
> > > Signed-off-by: Claude <claude-sonnet-4-5@anthropic.com>
> > > Not-so-sure-yet: Juri Lelli <juri.lelli@redhat.com>
> > 
> > Is this the generally acceptable form of attribution for these things?
> > I'm not sure what the official guidance is on using these AI tools.
> > 
> > Greg, you have any insights here?
> 
> First off, Claude can NOT sign off on anything, so that's a non-starter.
> All Red Hat people should know that :)

Yep, knew that. But I felt guilty nontheless as I didn't touch the
change at all. Current SoB was kind of a (silly) joke. :)

> Otherwise, there is a draft of something that was going to address stuff
> like this floating around by Dave Hansen, I'll go poke him to see what
> the status of that is.

I believe it was suggested something like Co-developed-by: <model> and
then Signed-off-by: <human>, but indeed curious to know how that
discussion ended.

Thanks!
Juri


