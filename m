Return-Path: <linux-kernel+bounces-817852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBBBB58776
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C2B207FFC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E664C2C15AC;
	Mon, 15 Sep 2025 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3cdnVJF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798C2C11E7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975032; cv=none; b=uF1Ola1NuGMZKDPRcQ9tQTjbomjowtQP9kFHfRC+gkf07caBPnl6X8kGtQdEwYyCug7ACm7TFRRjrXKkQSIpYcdqussXX+3HVnARFH/XrbQYY1HtWNyovsdDAUaqKYGGOfolinolU1fhPUUgktN4pLtJdxm4cY5aEGlc/r+g+Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975032; c=relaxed/simple;
	bh=Deus/OWdVLZ2R3WKItEKOGVXH14LkytRL6v3j0WjP48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHnTah+qH538k4Xea1kJSk5R8tdNnI9q+GI9l9grWHxQLgtCkr9gP5tpyVM6kdYRklBCXiascUtafCgdGKmI5feVLNgbG+UNppxoNZlZPujZcl+BKW2YLholhY5agzjIIAFfEZdkkaTPOphE0y8f3FLrR7W7q7mNS5xHuTd/Q+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3cdnVJF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757975027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGRejJG0eDtlNIu2fdRBanuS2WqJ6w4xAk6USL54XjI=;
	b=O3cdnVJFlYtMPQ4ye7kOXcFiwhm2K5TCQJ0xVSQwBeNbw2kJDyX3wFwhyAUG2HGURIh/cU
	Kr3tvtniybzCFn3vhOSAgwmc906E0DD+JwyVJROreNtpO5qU4UHogOXJRgjbS05CJogmV+
	HdG82lq/YGkh4H1DaFFgrBZ42S0x+lo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-i09Gu_eqMzGKbEJDZf8Jew-1; Mon, 15 Sep 2025 18:23:46 -0400
X-MC-Unique: i09Gu_eqMzGKbEJDZf8Jew-1
X-Mimecast-MFC-AGG-ID: i09Gu_eqMzGKbEJDZf8Jew_1757975025
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b04b06659d2so319996666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757975025; x=1758579825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGRejJG0eDtlNIu2fdRBanuS2WqJ6w4xAk6USL54XjI=;
        b=DilG6NedrDMt2FeY4aLVz3Dc+IzXSdUo4JGZC1cNiHHwCss0+U2szVjqMsren4phQK
         39iHGPPcTtpdq/hS6SB7ExfZ2St0l6wd/4MdWLiLDb+Sk/kwDkcZBesd4iHXZcLthX/c
         YXbL/Hir7zOL+MX7vJynbAgrUGXSx6v+d+QeOI1Wrjcg35XBLYCmoUPmVuvCCy3Kffgz
         3swodldE9SsQzZekRbwG6TWHOBXX5GiWSKEofWgxsmhQ5hSBoIR42zB3AyxDAyR+F48D
         tN6ihmukGxkVJRePIIrg5wkXeC2V0Njgq2KwV1lhR708aCTV7CLZZryj8jXWdcd2Oj14
         5kbw==
X-Forwarded-Encrypted: i=1; AJvYcCVDQ5mAeeZrXAmiM/yqgbwf4De/2zXtAnxXXMgbjYU0EQAkrnXdUnZDBp10ccEBb2w8+UjjrPOVRQod3Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnIGqh+W5oveTlSVw3/84Mp1/lA1qL4cSriuyZC0+GBhnXyg01
	0cizEnRSw8ZRDY20J6sQdY8U0t8Q18+VRPMhR8jtBUZlYkVaE34gt2QDZV5mzirQz+cmJZXI9Pt
	EkS/vR1CYR5nxW9aS8TKSr1SBMLJhUk0QZ21Txo/Xf7ZzQYvuYQg0ATb3T2l9k0nhMQ==
X-Gm-Gg: ASbGncvGUcXaYvJvKYBYmSxrc5ssFCuCZj9mwuSwGv117BWE3JudXUGx3RqGPLhpnlj
	PYNsIzisRWdsCgrknBNplecYHFnO77aRNCsXS6mA9uHXiw3tpvjLWbtYefIdkQ+PIaN5OyaqYxP
	9Nj9Ey1nYCyZHhh0C+nY1Hj+vskn7p5nmkNWO5ooVSxubR1pWvBfvrqTM1gn189ghrnW9omXVDe
	OBfl0sEJvulmeWfLlVGc/NscrzZcoBED+32SDHhfI3u786NUe5W+o/zvy6p7O0A58KiSEIM8X5h
	r3V+AV21p8ASBE8KRnh+Zv7PlLCN
X-Received: by 2002:a17:907:3c84:b0:afe:7909:f42a with SMTP id a640c23a62f3a-b07c383f22bmr1387709266b.51.1757975025361;
        Mon, 15 Sep 2025 15:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+pGzLsoXLRChFyMRuXFtC2HnABVGjt1L9MQILzU2f9q6UKgKHj6iY8Hiri9BM8h4OsvMUXA==
X-Received: by 2002:a17:907:3c84:b0:afe:7909:f42a with SMTP id a640c23a62f3a-b07c383f22bmr1387708066b.51.1757975025017;
        Mon, 15 Sep 2025 15:23:45 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62edbc829b3sm8379978a12.28.2025.09.15.15.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:23:44 -0700 (PDT)
Date: Mon, 15 Sep 2025 18:23:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited
 task
Message-ID: <20250915182232-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
 <aK-f45qszH2VEzV7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aK-f45qszH2VEzV7@google.com>

On Wed, Aug 27, 2025 at 05:16:35PM -0700, Sean Christopherson wrote:
> On Wed, Aug 27, 2025, Sebastian Andrzej Siewior wrote:
> > On 2025-08-27 12:41:04 [-0700], Sean Christopherson wrote:
> > > Michael,
> > 
> > Sean,
> > 
> > would the bellow work by chance? It is a quick shot but it looks
> > symmetrical…
> 
> Gah, sorry, I flagged your earlier mail and then forgot to circle back to it
> (for whatever reason, I didn't entirely grok what you were suggesting).
> 
> > diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> > index bc738fa90c1d6..27107dcc1cbfe 100644
> > --- a/kernel/vhost_task.c
> > +++ b/kernel/vhost_task.c
> > @@ -100,6 +100,7 @@ void vhost_task_stop(struct vhost_task *vtsk)
> >  	 * freeing it below.
> >  	 */
> >  	wait_for_completion(&vtsk->exited);
> > +	put_task_struct(vtsk->task);
> >  	kfree(vtsk);
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_task_stop);
> > @@ -148,7 +149,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
> >  		return ERR_CAST(tsk);
> >  	}
> >  
> > -	vtsk->task = tsk;
> > +	vtsk->task = get_task_struct(tsk);
> >  	return vtsk;
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_task_create);
> 
> Nice!  This fixes things too.  Either solution works for me.  Or maybe do both?
> Attempting to wake a task that vhost_task knows has exited (is exiting?) is a
> bit gross, but even with that hardening, guarding against UAF is very nice to
> have too.
> 
> Tested-by: Sean Christopherson <seanjc@google.com>

Sure let's do both.

-- 
MST


