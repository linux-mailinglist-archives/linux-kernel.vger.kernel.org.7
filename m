Return-Path: <linux-kernel+bounces-731634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA2AB0577E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1016561A59
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D022D63FF;
	Tue, 15 Jul 2025 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vh4ZAeVk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20FF274658
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574058; cv=none; b=V6Lzr++FVkGFmJjRu8OA18IKEs/tEER48p8rVps0l6izY2iCGGJwHvsHq6klcJPDgYZqZrskejptKTqSg0vWUUkpxJGcBme+seM5+xujH6g6WW8dK6KJyphDnzUx9dpINHo7cY35Kuup7LTf84hDfsRI8AKzdp7BlcD3JKOYVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574058; c=relaxed/simple;
	bh=UzwXrJwycwJWy/NcZKFDHeVh/aoQsaYHD2J/ccXCWys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9j8QNRg5JdHU3AvOmPoHL0Tt6ir1T5IE//WjMKhDwNNsKqAjOXNvSGCC4/+/AtRCsEeCLP2c48k0kEvrxjuNzdv1JIXDXTOQGlcRdZh6PR/sx7U2Bjv0pmRcVuUY/Oaa/oRJU9f4yX26NUnDds58NKavqZv2hZev0QnvV8fRVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vh4ZAeVk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752574055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E1OtBhLpz0fp+4FS3ln8CJlHsb+OYSQUEdOqt1IqZZQ=;
	b=Vh4ZAeVkhuRQRD79GAR1lxfjFK61yz8wWnNH+WhMrCdgELyNj+inPklP3kLE/M7JQgszcw
	lnjUXsDwtzsyyJrjUlz4P9zfnFhwS67bkBw1yKgKpHf5txOo5fIPwYOB9gnmZm1N8m+TUn
	wO6hudBASFdhusHbQpaXDr3aSaApo30=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-Ezxc6F9kMzWoa4w-qwxLGw-1; Tue, 15 Jul 2025 06:07:34 -0400
X-MC-Unique: Ezxc6F9kMzWoa4w-qwxLGw-1
X-Mimecast-MFC-AGG-ID: Ezxc6F9kMzWoa4w-qwxLGw_1752574053
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4eeed54c2so3021160f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 03:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752574053; x=1753178853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1OtBhLpz0fp+4FS3ln8CJlHsb+OYSQUEdOqt1IqZZQ=;
        b=CSmFhwAsf203nBmZAKvOSKsdufyh89GZ5lwks9+udw5RmeDhUxv8P7VkcDbKXbnqjv
         M4zL50EGDGGIwVaYRuq2SXXO0KliDGooUb1EP1v0qJpaIpod5mLA/6iT2nu52JatQdC2
         Npzts1dHMXDeaLzAc0rGCtGHvxRVFjFE5mb2hMOX6Hje1OOIDTJmh2D/P+9600z1e2Bj
         Cx+NRG6RbY4jnG6gcWFk9lyrdcZ6k8DdleT6YW6mqe/JDW4JdLjuYQ62hSBpZ0w59ySR
         6orOXGIBdDXLxjC4yCPKG0Ft29iNHu80JwMSjils3Og8zDXDoLT0YESKRc9q9Dh5jVZL
         T4CA==
X-Forwarded-Encrypted: i=1; AJvYcCVisaUjiknUcJGenJRLaEDCzuod8rjYIZDkNdeX/3wyKpRbx/cXCfSv5MgPsvf78GDYPs+o2eaWtSHtHVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywui+o+aD9Zw7VqZpmORIIm5lhjvKmKmt++YIWfFRnt7UJ7vGbD
	ArOvQ6+nymfx7vWsMtqldKVVwgAoxnlxI8UhcICi1mnepdVih0iPphkLJ2UlTWVHZz5t4sG0xuV
	ucAKbFVDeE3xZTRYvW9KesrqGGCcBRJX7sV8wtNNmBE+ay90uX7ulAx+uUOYK+eGjsA==
X-Gm-Gg: ASbGncuWG8D/2GlIDGgujbmDEBEzbLnrBNMTJE451fkFAPfu2tz8ze+UVUexABGdMle
	re0WKKt8/BcP8/rfxI8Txcw/fuGMYGmncu1xI4skSrWU6a48SiZ6ttnfV0N+rIm1tw7mo4oLM1M
	tfaK92Gq8J5aEStBpM39YLaJHe1FrE4q/AEJnzz/3w8NALgaCViVvQAwb/TLU4O1h1i4wnp1HCs
	t6K7RbE70KHiqTny62+WlNzgu9KXq5DD0PkFMRTwzP5TbzpdcXNvJ8Qwr+0LH7H9rj0ajpqBTFH
	HQT/NwaFiCjGP0EB8WPN4CkBvZ2DM+Tl8Acgt2VJAANMqPqS8zD/BNn3sQI3fZbiZT7Bqw==
X-Received: by 2002:a05:6000:43d5:b0:3a5:2ec5:35a3 with SMTP id ffacd0b85a97d-3b5f18e82d8mr10511579f8f.45.1752574053397;
        Tue, 15 Jul 2025 03:07:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMm50zMmAiU870Xt1GMH3GpC4f7NoueL8gcf79lmIfGNuEDk4S130D4WzwLBTgO1oRF078xg==
X-Received: by 2002:a05:6000:43d5:b0:3a5:2ec5:35a3 with SMTP id ffacd0b85a97d-3b5f18e82d8mr10511555f8f.45.1752574052937;
        Tue, 15 Jul 2025 03:07:32 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.54.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2464sm15039671f8f.38.2025.07.15.03.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 03:07:32 -0700 (PDT)
Date: Tue, 15 Jul 2025 12:07:30 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org,
	Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>,
	Luca Abeni <luca.abeni@santannapisa.it>
Subject: Re: [PATCH 3/5] sched/deadline: Fix accounting after global limits
 change
Message-ID: <aHYoYnnzqUlM1Bng@jlelli-thinkpadt14gen4.remote.csb>
References: <20250627115118.438797-1-juri.lelli@redhat.com>
 <20250627115118.438797-4-juri.lelli@redhat.com>
 <20250714085901.GN905792@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714085901.GN905792@noisy.programming.kicks-ass.net>

On 14/07/25 10:59, Peter Zijlstra wrote:
> On Fri, Jun 27, 2025 at 01:51:16PM +0200, Juri Lelli wrote:
> 
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index 15d5855c542cb..be6e9bcbe82b6 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -2886,6 +2886,12 @@ static int sched_rt_handler(const struct ctl_table *table, int write, void *buff
> >  	sched_domains_mutex_unlock();
> >  	mutex_unlock(&mutex);
> >  
> > +	/*
> > +	 * After changing maximum available bandwidth for DEADLINE, we need to
> > +	 * recompute per root domain and per cpus variables accordingly.
> > +	 */
> > +	rebuild_sched_domains();
> > +
> >  	return ret;
> >  }
> 
> So I'll merge these patches since correctness first etc. But the above

Thanks!

> is quite terrible. It would be really good not to have to rebuild the
> sched domains for every rt change. Surely we can iterate the existing
> domains and update stuff?

Yeah, I agree. Tried doing an update at first, but then the involved
locking and the not so pleasant thing I could come up with made me
decide for the big hammer. Also because it should be a very infrequent
operation anyway.

But, I will try again somewhat soon.

Thanks,
Juri


