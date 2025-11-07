Return-Path: <linux-kernel+bounces-889838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9340EC3EA74
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 07:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF92C3A4977
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 06:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E721A303C9B;
	Fri,  7 Nov 2025 06:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMyxZLZm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKzkoYgb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7861E303C9D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 06:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762498321; cv=none; b=jk7IXjCW0jIK1A46fQPYWNX0R8ReShisG+3153XEIcdH8LCDrynkTUfbVEK4Yxxt4HlCrjG0zXzk9Eht+AEoAOCNqMBgTBk0kSKCl6UM1nwom6PLqJj+RGidiC0kI5yfl4DFTGg3/zTjBD3QcZqnzciRlEKWOdYWfwMQTwBIlc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762498321; c=relaxed/simple;
	bh=uPG2qaEExT59WP2ysS8ErG3/JwdyIv1CjufizYF4whg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbQ0mbG7GiatbPycHiZ/3AsZ9a1H68/GQW7YIqgY2iBEbnfDZjUqHf//xDYVLjrAKZ90kqWsY9aNmcRjYxlq+9ZIH/fONRO/RCTg4NudZ87G6WtKAnomBQE3bFRB5YGdq9xTefMboI7NruIzIpsjeCa8CEbQjjtlCgabHV8P2dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FMyxZLZm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EKzkoYgb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762498318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zYmb/mOjOmAnHynzCc5urdD/k2k7E8plshDwUAI/8Ps=;
	b=FMyxZLZmTZeDDXiBH8aKuAojectx+J4HzkWr34j6GL9ebZSNsPXm5OynGV/azzM2RINjiy
	RZm4MJUOMz2y/KztKTxRw8KGypOGYnoV1By+sp0/hhWFMAjLc7OEB5yFno/AjufiyKU9Ns
	yn6Dz9BSpOi8S2Bqpok8O6pvhSBsF64=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-edkcTVKmOlqtLM20DkyfUw-1; Fri, 07 Nov 2025 01:51:54 -0500
X-MC-Unique: edkcTVKmOlqtLM20DkyfUw-1
X-Mimecast-MFC-AGG-ID: edkcTVKmOlqtLM20DkyfUw_1762498313
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-427015f63faso154932f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 22:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762498313; x=1763103113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zYmb/mOjOmAnHynzCc5urdD/k2k7E8plshDwUAI/8Ps=;
        b=EKzkoYgb4nd7vgjuHN3sK1Zb6TwwTj5huwP5mFyPhZEkqWJmsK1CbKxkuR4OyyqipT
         4dY4SoijWxLLwv6FCnY0gTkdPB3sPFroiu6ObJPSGKR2DZfsnIVUVM/V5HNBZehO/uHC
         yTdPubeWwr4mPa0ALB6VbEv3PnWEL3HyDypmDT+qqQYV8ttzcP04HOQCFWpXFqdEYDVr
         kSXyhbNQY+UCP6TeoGabigtK6GzZoopwzbGQWKj6lzeHjNMGlkQbY5oZ9PjsQkKrGQaY
         ukbowRDKOp+EhyMWCLfxBsxwhPuGkwxsHefK+gQdB9os32BaLKhtt6TLk1lBEt9BVvJK
         oFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762498313; x=1763103113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYmb/mOjOmAnHynzCc5urdD/k2k7E8plshDwUAI/8Ps=;
        b=AxeGYVFxlDMLkLi7dtYWQdfrFa1FvQY0pOugmiO3S6XmOJzynZ/GJkGzoSxXdA9zwA
         7fhFfcbuqBvXGvSvzQoC1nHZWL6R/2zBII1PVZg8U2ehPfmLAS6h6TllQ/+s0UDc15Bx
         102COsas48eBHPFpJ/TvbRH18SABdnIrFqRFcYniFfdTgx7mUJnBbX/PqKlpW0beD6kW
         vDMiWj8wibFBCvae30/FLrjeEPpB6v+/Gb5j5RLbtF43W4f3dSw/CCl7NasOZZqyuJCV
         24qTbcd5+w+eBv+i32n2n02cK4h4RH1d5lgWD9nhoDhBBJfxj0TPNEa3VdXewgleD+Yd
         LUhg==
X-Forwarded-Encrypted: i=1; AJvYcCWaIA5InFx80Me+hr/0sQ3ITCbh7yHwtte/hu830bcILooQ9mxKuZUBjObysCN+XGjEN5lWaowqrhvfR7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvsgDK3vmpJPt+4nICnrPxeABXXGumOS/0GyU80bG0j1OdDACR
	FPz3mOz78ucGBLWgtFmpmmL6LiRf4TsNFpB5r/cXGWijz9Fja/hj4KqO8rvvShhj3lrkILzr9d2
	LneCuLYS5ycCAGb1M1O4Y+fMs3n/P+VW4+Pi1+BkBLXCvRmVfUKyKldMxZbqBpiHFqA==
X-Gm-Gg: ASbGncu4Hg5f39Ubfd/bwMOWA2lBZAaXRHKZtH1OifhRe8Rm0nMbuBbSGNA/6AQGd2O
	DBZTGeZutGfZ+QLrl5rRCLHnRHAvAOfXHDkVk+gmnXhAWl1pXxvLYZrNgsmBxPGAUPXXI7JbQaE
	bFZ+bgCBQY9loOYl9BzjED09TBAPoOtJHl8tIykjcCvZzS9utZ12oaAb3BZitUrQ4OBdu4LOavX
	78d1jxN57Gyf665mToJJW5YAYkyVB4wPI2BGXqCA4RmNNWwIkkFUiwcrPeA3lcnfqNkCdZqFLOg
	ehCN1pSxZly8kX8OcOzCzQZCDb3Z6qQHmqpqXSySwmkXK/CCsja4Sqnm8VdrXAOsDalpCmR+PaO
	WZC7RgWlB93OISNDEyR+Wp9oSfi0NIg==
X-Received: by 2002:a05:6000:18a7:b0:428:4b76:c8cd with SMTP id ffacd0b85a97d-42ae5af3d30mr1473399f8f.62.1762498312787;
        Thu, 06 Nov 2025 22:51:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkTAZvSZYGErM/J0GLN/rgaF1MnsQc3qO4BrVNXh5vafIXUbVWfdF5xK+Ug878KB2EOdOBvg==
X-Received: by 2002:a05:6000:18a7:b0:428:4b76:c8cd with SMTP id ffacd0b85a97d-42ae5af3d30mr1473371f8f.62.1762498312396;
        Thu, 06 Nov 2025 22:51:52 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63dfecsm3408533f8f.12.2025.11.06.22.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 22:51:51 -0800 (PST)
Date: Fri, 7 Nov 2025 07:51:49 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] sched/debug: Stop and start server based on if it
 was active
Message-ID: <aQ2XBQ4vGGFWaykj@jlelli-thinkpadt14gen4.remote.csb>
References: <20251029191111.167537-1-arighi@nvidia.com>
 <20251029191111.167537-3-arighi@nvidia.com>
 <aQxKo68TJge5dRZI@jlelli-thinkpadt14gen4.remote.csb>
 <aQzPVuI-dHEfee4W@gpd4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQzPVuI-dHEfee4W@gpd4>

On 06/11/25 17:39, Andrea Righi wrote:
> On Thu, Nov 06, 2025 at 08:13:39AM +0100, Juri Lelli wrote:

...

> > > @@ -376,8 +378,11 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> > >  			return  -EINVAL;
> > >  		}
> > >  
> > > -		update_rq_clock(rq);
> > > -		dl_server_stop(&rq->fair_server);
> > > +		is_active = dl_server_active(&rq->fair_server);
> > > +		if (is_active) {
> > > +			update_rq_clock(rq);
> > > +			dl_server_stop(&rq->fair_server);
> > > +		}
> > >  
> > >  		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
> > >  
> > > @@ -385,7 +390,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> > >  			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
> > >  					cpu_of(rq));
> > >  
> > > -		if (rq->cfs.h_nr_queued)
> > > +		if (is_active)
> > >  			dl_server_start(&rq->fair_server);
> > 
> > Something that I noticed while reviewing this series is that we still
> > start back a server even if the user put its runtime to zero (disabling
> > it) and I don't think we want to do that. It's not of course related to
> > this change or this series per-se, but something we probably want to fix
> > independently.
> 
> Should we just call dl_server_remove_params() when runtime is zero?

Looking again at it I actually wonder if wouldn't it be better to use
dl_server_apply_params(dl_se, 0, dl_se->dl_period, false) in both cases.
dl_rq_change_utilization() deals with dl_non_contending (inactive_timer
armed) case already (even though sub-optimally, but we can fix/change it
later), so we can probably remove the special handling you do in
dl_server_remove_params(). The WARN_ON_ONCE(on_dl_rq()) could be moved
to dl_server_apply_params() as well.

What do you think?


