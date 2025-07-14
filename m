Return-Path: <linux-kernel+bounces-729491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 107EEB03771
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487D93BB873
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062AC229B21;
	Mon, 14 Jul 2025 06:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Il16xPEm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EF31CD1F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752476103; cv=none; b=oDbz0Wf7JrCs3GFNLkbCzg6nqtNfnCNtV7ohfkaxDwmFMtKfw84+DJBkusYREm0oH7AqgK7rFHHFs58X4SbXo6AGaUznRcgjsnptArDAw+/AjtpOfgPbc/Zrc3NXN+kRP3I7yhfwTsKRXdfnlwBB1v79buzLuvmxMT9a1GPHvFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752476103; c=relaxed/simple;
	bh=UGs/+B32gn3cy1d8qhjGPSwAy5GCOeHq/3OLNLkco8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkGc8Zi3097kNDoUS5bN4jUqPWLT7iMdFnWuwvOf8GCdyEEFNNq5WcwR011iCZzb+WLR85gABuEAfDjauGXgRjEJZVnCWfNLP7Wfn+bqdIFvXKCWEHJ/YWbAz8Js5Ea2ITYuToj8NATBRN3HrploXkcjLKFUmcLyXAennFaubKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Il16xPEm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752476100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sPMw9tnfPBR1vsdCImTl+h1akpJagNiW0hA8bPj+ieE=;
	b=Il16xPEmlJN4ebqeQRYH0wDxWSXzdhB8xkTsvGiE9ryzliixlkOUAF8K64EJigfRxzT3i9
	DzMXt3Cl4/RiCnJAupCBglwhqgeTfKF6VXirpImDsADRojHyPK08f76GvN623AGcC+aZ7X
	3/y/czG55KDDvAmWXN+h5cCU3jtiwaA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-KkM41J5UNteiWzFGGE3tEQ-1; Mon, 14 Jul 2025 02:54:58 -0400
X-MC-Unique: KkM41J5UNteiWzFGGE3tEQ-1
X-Mimecast-MFC-AGG-ID: KkM41J5UNteiWzFGGE3tEQ_1752476097
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4532ff43376so36260165e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 23:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752476097; x=1753080897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPMw9tnfPBR1vsdCImTl+h1akpJagNiW0hA8bPj+ieE=;
        b=XkitQ8LF1oLG6zocsMFTVgfj9JMVKjGezw+ottqzpNqJVn0Or4T59GZQMdHCkubLna
         UBZ3TtTJR0JvFYdEPSvuSHchRfVvGYv9HfVbxY7OwuT3K+2o474OtpxiNXtPXJkwbH88
         Lz68YjlZhLE/fy2u/YY5qcSwY226LoADX136vE7H4UstHgZHJIPD+mDuhJqQHb4cLv5k
         vT7pUBXIap1BDwyKCyBcEEHgBVH2MmM5REjPA3AWSk6QyVrfm6fxwCv+IWRFMiETwJpu
         A+ADrG+W6ukG5Tbe4+SS6cAoZwHMMCfH4t3ha9xss7X8L+8jQXc9UCz2NKUPqn0xnwC9
         AvVQ==
X-Gm-Message-State: AOJu0YxpFeA4A4/sWfpSriJ+/XEN3LLkogjyTJU99Ba0/vBig4cdeHVc
	emRCR4RTElYRb8OqtxD7ylPnJLoFUgN6n90p8Sy+s3VJiqRcDyEoqWYNkc+FB3kdjbFWB2T8aru
	lyDPm+k6D9nkC+6FKmjPPztxpBvY+vYEIzSSMLN/Z7jQW3MqSygq35VXr/mwSm4Qeiw==
X-Gm-Gg: ASbGncsxc1IvIpmRMAFbabn54Lh6BeSnqx0YzICWFakgUvrZsZx+qI7ppNsbywgd3Bc
	YfRiwm9JscQCH9UXcy9gEb/86T79paGSWq8G04edkbvBSuIGRJiRQ9DLd5LMNWXV50G6HtZbQ6x
	zZ9wCwmY+OUvYfsPAqCIQlE1ldUnxTFdnXIm9NjwENMIXYyG+9jxka9aH1hT13urhyQlSB1l2MK
	VMlSEet/1EDtqfREhCC9uAl8G1EO82vGNHrFFkSRPylqbManPfd6SxIqHUl1FQ/2h9S/tmapC3R
	KBu1kF7wQZj3ZvObSObZ6btEGAzKj0ql
X-Received: by 2002:a05:600c:5024:b0:456:1611:cea5 with SMTP id 5b1f17b1804b1-4561611d3d6mr30785825e9.18.1752476096935;
        Sun, 13 Jul 2025 23:54:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE022c2VHr8WA+kO3hbXoaSxylmvCVJc9OW9gVm8pRiIUhm71J57/fOnW6tWgm61Q3Ykw7IA==
X-Received: by 2002:a05:600c:5024:b0:456:1611:cea5 with SMTP id 5b1f17b1804b1-4561611d3d6mr30785655e9.18.1752476096517;
        Sun, 13 Jul 2025 23:54:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45610c518e9sm46492725e9.17.2025.07.13.23.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 23:54:56 -0700 (PDT)
Date: Mon, 14 Jul 2025 02:54:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <20250714025357-mutt-send-email-mst@kernel.org>
References: <cover.1752094439.git.mst@redhat.com>
 <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>
 <aHSfeNhpocI4nmQk@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHSfeNhpocI4nmQk@wunner.de>

On Mon, Jul 14, 2025 at 08:11:04AM +0200, Lukas Wunner wrote:
> On Wed, Jul 09, 2025 at 04:55:26PM -0400, Michael S. Tsirkin wrote:
> > At the moment, in case of a surprise removal, the regular remove
> > callback is invoked, exclusively.  This works well, because mostly, the
> > cleanup would be the same.
> > 
> > However, there's a race: imagine device removal was initiated by a user
> > action, such as driver unbind, and it in turn initiated some cleanup and
> > is now waiting for an interrupt from the device. If the device is now
> > surprise-removed, that never arrives and the remove callback hangs
> > forever.
> 
> For PCI devices in a hotplug slot, user space can initiate "safe removal"
> by writing "0" to the hotplug slot's "power" file in sysfs.
> 
> If the PCI device is yanked from the slot while safe removal is ongoing,
> there is likewise no way for the driver to know that the device is
> suddenly gone.  That's because pciehp_unconfigure_device() only calls
> pci_dev_set_disconnected() in the surprise removal case, not for
> safe removal.
> 
> The solution proposed here is thus not a complete one:  It may work
> if user space initiated *driver* removal, but not if it initiated *safe*
> removal of the entire device.  For virtio, that may be sufficient.


No, I just missed this corner case.

> > +++ b/drivers/pci/pci.h
> > @@ -553,6 +553,12 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
> >  	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
> >  	pci_doe_disconnected(dev);
> >  
> > +	if (READ_ONCE(dev->disconnect_work_enable)) {
> > +		/* Make sure work is up to date. */
> > +		smp_rmb();
> > +		schedule_work(&dev->disconnect_work);
> > +	}
> > +
> >  	return 0;
> >  }
> 
> Going through all the callers of pci_dev_set_disconnected(),
> I suppose the (only) one you're interested in is
> pciehp_unconfigure_device().
> 
> The other callers are related to runtime resume, resume from
> system sleep and ACPI slots.
> 
> Instead of amending pci_dev_set_disconnected(), I'd prefer
> an approach where pciehp_unconfigure_device() first marks
> all devices disconnected, then wakes up some global waitqueue, e.g.:
> 
> -	if (!presence)
> +	if (!presence) {
> 		pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
> +		wake_up_all(&pci_disconnected_wq);
> +	}
> 
> The benefit is that there's no delay when marking devices disconnected.
> (Granted, the delay is small for smp_rmb() + schedule_work().)
> And just having a global waitqueue is simpler and may be useful
> for other use cases.
> 
> So instead of adding timeouts when waiting for interrupts, drivers would
> be woken via the waitqueue.
> 
> But again, it's not a complete solution as it doesn't cover the
> "surprise removal during safe removal" case.
> 
> I also agree with Bjorn's and Keith's comments that the driver should
> use timeouts for robustness,

Yes - we can consider this an optimization, as robust timeouts
are by necessity minutes.

> but still wanted to provide additional
> (hopefully constructive) thoughts.
> 
> Thanks!
> 
> Lukas


