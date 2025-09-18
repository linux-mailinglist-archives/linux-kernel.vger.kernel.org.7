Return-Path: <linux-kernel+bounces-823389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0453FB864A6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB64B1CC43CF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E9631D75D;
	Thu, 18 Sep 2025 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUGZ0eI/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757331A81E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217234; cv=none; b=YbHWrP3DINc/mQC4gnoJqF2TsWqaTDl03CCxdDZBhy0wJsOeZwUAufpa9V+cAa/q9mTu36yuVHF30F9D1OFxwfgbjcZYpz0+bbDnuHyE1Ys2s9VZuVgbD8TGgqe340R3XUCpDL4uDygjghUM7ylemaUC2MjyaABP/UrJHCjn8Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217234; c=relaxed/simple;
	bh=PAJGdxzVh+hSxDOx5VKS60t2Dt2GkMypMDcKSqxK0Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaI7se6e882XtzIcMHICl3UvwjtOSQOOe0qyalFWzsYBAhZBVDeu6Aj4hzmMNDBMFYkK1z/isQSObfHs5wbRb87QeXTLHD+tEJIZn1zgg6PfkckxXyf2LqzS+h/MPUCE977u/735P+wi8yXtqVXjipbnlLbn0fsTD97duZ0rk7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RUGZ0eI/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758217231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t1W/1phtqwQuVUIVURl6ScoEnd5TdTDKATokoKxzRnw=;
	b=RUGZ0eI/ZnBFQkTCZ0u+8BmK68rg+oCa2UfZG1Fs3IVdh76I7fgfxIyehLcISkxKqy1RSn
	JxT9lAY6lJ4b/91wnXpb1hySOFYey1B5x5NBplgMd9P5Q4Om1SY18Dk5hPBWUSmswF+vtK
	sbS0aqwKHT5CxhR6aP/f1LbmbLPIOmM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-BaFTykobOteAQAh7CLelrg-1; Thu, 18 Sep 2025 13:40:30 -0400
X-MC-Unique: BaFTykobOteAQAh7CLelrg-1
X-Mimecast-MFC-AGG-ID: BaFTykobOteAQAh7CLelrg_1758217229
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45f2b0eba08so7557455e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758217229; x=1758822029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1W/1phtqwQuVUIVURl6ScoEnd5TdTDKATokoKxzRnw=;
        b=mc50xOutybOlRWLJVviRUqL9pXAql2uLYWbmOCm4XbFzDYpnIwJzpd6AyAX5IZONWJ
         PHDLzRCaIPqb8Hrp83TQp1UegirMSF1wPRmj5bSURwe7ZYJKqALw0Lh0g3c/3HGUmPQ8
         xsZuNWVfdO7NkBsftgiZ5k3d4+oQY1/f+Po7M0EXZJLoZxGSY0c0PXdDbtlnzvOMu6Ub
         5yvEkKoVxEX4GGDZJ/NY8qhGyRLYR/u3nQLWgUfTMF1inThPlUCYQSM1oJlofY1czv1v
         9MboPvuNsG6pUT3v5JoSYTd7lhUEp7SqYfbqAI89alksmth7EHR/jKF5ssPYw7ivFUZ9
         OvHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+/J8mpbJDgzaxKfC2cQdYWuO1iHkXSUJY8X001PNpxqSxiKvqYPpR8QpiH0Ukt+3A92tmmlHh/zsmpdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynBErP7T6+A+4y989ArAouuK9LBZt08Ia+xva1Iq6rHdy6edHL
	+Y1AEM+83zRDajTA/QcUbcw59t8MKWvKAXYsqMCwYTlU/yyMgjwvL0TteUVyJ+IORwGuCPLhupY
	trI84svWH9bP/YJ72hLKYbFU9Ka8o2jSR8ejAWSxECfXEBnyDyYrs2EerMPi43de/Cg==
X-Gm-Gg: ASbGnctMrW0SBAT7dc+SS8JLr6yAeo+MifqTWRLnBMgc85AO7xiEz4wKirtNKRvE2vS
	O7KrH9932jt7s8piLiZPWwwvqfhmgwS/YlOKzC+GnXEz7FjGLjb93+dKjyQ3lrDtzXUeOhw7S9u
	0wM3ZWXf0nKmsi257nN3dSPGQRmC7zU4wxnsykK2+KErFLyGqlhDOq8sPOEJ4e70OEKo97sbtL+
	NUcW1UDDgRpdCFiDpi+yOPQ/CBk/4kBZThgv90iNmWIO7fhc5LU5lLsr+NOD4p3b6ObrCBitG+e
	0b6pLuxjBIOp3QMXTE0BF8C3J34NnjCszLE=
X-Received: by 2002:a05:600c:48a5:b0:45f:28ed:6e1e with SMTP id 5b1f17b1804b1-467e8afde63mr763605e9.16.1758217228689;
        Thu, 18 Sep 2025 10:40:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOoCiSMZx3r6ahJEsPst7vmWcAL9LRHA1I1NtHk23nXFndZVGSronTsEuZNCUr5eL1KdExGQ==
X-Received: by 2002:a05:600c:48a5:b0:45f:28ed:6e1e with SMTP id 5b1f17b1804b1-467e8afde63mr763425e9.16.1758217228248;
        Thu, 18 Sep 2025 10:40:28 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613e93dd85sm103570545e9.22.2025.09.18.10.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:40:27 -0700 (PDT)
Date: Thu, 18 Sep 2025 13:40:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited
 task
Message-ID: <20250918133938-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org>
 <20250918154826.oUc0cW0Y@linutronix.de>
 <aMwtd40q44q5uqwr@google.com>
 <20250918120658-mutt-send-email-mst@kernel.org>
 <aMw4wx5ENt-odhYS@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMw4wx5ENt-odhYS@google.com>

On Thu, Sep 18, 2025 at 09:52:19AM -0700, Sean Christopherson wrote:
> On Thu, Sep 18, 2025, Michael S. Tsirkin wrote:
> > On Thu, Sep 18, 2025 at 09:04:07AM -0700, Sean Christopherson wrote:
> > > On Thu, Sep 18, 2025, Sebastian Andrzej Siewior wrote:
> > > > On 2025-09-18 11:09:05 [-0400], Michael S. Tsirkin wrote:
> > > > > So how about switching to this approach then?
> > > > > Instead of piling up fixes like we seem to do now ...
> > > 
> > > I don't have a strong preference for 6.17, beyond landing a fix of some kind.
> > > I think there are three options for 6.17, in order of "least like to break
> > > something":
> > > 
> > >  1. Sebastian's get_task_struct() fix
> > 
> > 
> > I am just a bit apprehensive that we don't create a situation
> > where we leak the task struct somehow, given the limited
> > testing time. Can you help me get convinced that risk is 0?
> 
> I doubt it, I share same similar concerns about lack of testing.  So I guess
> thinking about this again, #2 is probably safer since it'd only impact KVM?

I can't say I understand completely how we get that state though?
Why did the warning trigger if it's not a UAF?

> > >  2. This series, without the KILLED sanity check in __vhost_task_wake()
> > >  3. This series, with my fixup (with which syzbot was happy)


