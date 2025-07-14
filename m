Return-Path: <linux-kernel+bounces-729457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885B7B036F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1947217B9B9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FA222422F;
	Mon, 14 Jul 2025 06:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KD9Vli0A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB76C194A60
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752473937; cv=none; b=brcbsyWmFKFbYsTATn1QHcIOZ4XNfQb2GO4qy1mRPi8R96rpJm28muNwExp9ye9ubCcF1mMeD2e56+npJfql03xcK7l302qPDx020jMtt8gX8PU2X0QWZGbLCjxxqAhxLR1nC4HhvJlIEhw8t3+ZL1GFAGuYyu1nzZj6yAPtBok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752473937; c=relaxed/simple;
	bh=VHG1aIFrPJUNQ533qITRdf+7pKjRccdsFYN0w/Nahjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxDXpE1QKtPGlk+cdyz3Y5sSsTTeW7WhRhFpTIEoH6K1+IEeksK+z9nLjZEunt/BDJoE68HrQv4PVq1xlRFtJeX/LBuRGyMD4voq8/9XaYLVO5t109ATagz7pPXbPtG2QPumCTVGSE+n/ww22zAHCwTmBsLKGYeYX8KcZbHoo6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KD9Vli0A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752473934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaLtarIqWAh+adH9k5nWd36ANmOKF2pw7KpXjXJAWkI=;
	b=KD9Vli0A9yaC+c/o90rw9IUQ8dDcurZ3oTg1i5vr5oE0AlnJsPikmXc/lfFYCTSXH1Nzda
	0CFuBkHjFVyiGkBRFQCeI12h9riIYPfwSa1nAvFaTcsir1303Y4xQPKY51ErAdicz3sT8E
	nw2pRyVGk2tNTokoDp4RSSVaWdP1O8g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-NLpM2b0jP1OYfPY0XLhaPQ-1; Mon, 14 Jul 2025 02:18:53 -0400
X-MC-Unique: NLpM2b0jP1OYfPY0XLhaPQ-1
X-Mimecast-MFC-AGG-ID: NLpM2b0jP1OYfPY0XLhaPQ_1752473932
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso2031914f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 23:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752473932; x=1753078732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaLtarIqWAh+adH9k5nWd36ANmOKF2pw7KpXjXJAWkI=;
        b=pKiYIMuA5xAyVRavCOGIjyblpIy9o/Ds4dLY8uF8WTVNNcPGuehjG3eMDa96ETJf6M
         AeeHbmSJx7KXQ16jZxKmDn1KYJnxxawx+HvEY0vq7YkJIFbClSD0HRq8RtbmaoXNlMGz
         W1PENJVrRGZgZzp6vHvaWoodXq0TbqLZsXRlQjE+/4nzFBJXdZ/iKsFzDrxzGeb7rnJt
         IGIq+b+UnlR9z40ScG13QFtbMUmwthoDWDl4+5lAVcu/Xu8AevIhjx2us7pkiZVBTVzM
         1qT2M3U4zdQxDbxt7gtVtU2NeVEGjC+SE4lT7XJfh18Blv5cBpOdHUKPGoeZWg7PRY5t
         NLXQ==
X-Gm-Message-State: AOJu0YwtioWHiL9I9bRBhdt3VWbGLL9dMHaEH0orC7X3vIIqXoSQNrB7
	JpI6uES4MbbDNcoFR3jI3cZPl37rXHK/Lxun32Y0+Ij8MYBshKR0IpwHe8cXwcy7nEkSL7MsXBX
	+08rI/aKEvQtpQh7/30xRJpCQFVHseVUG/oGMAYV/FUXRVOhWVKw8e2scFNsedQa2AQ==
X-Gm-Gg: ASbGncvW730GtmPzLP3WHG+1n4n6q6TlTP+SPMJfodx2q0RFvd1Lkr/Xv/YO4GzkoiK
	il1IW8nMOGkE7r5Ny7ieDTz97yZOudWQFr9OR3DR790kMDYn8CNyeCNoByEpT1cI9o3fkfL3dQk
	5aM1s8D4yIrIE8356DJvYYMhZLvHwyyqdoZGMgciGYtNdrOq3z6webRoAf24ioGGtxFAZsmHWhY
	AgEEe8KV/pq2DSNNv3JwhJc+NJN19DPiiqcQSBmXG8TWtLPWc5oofhlSDA6APINIyVt9atTTEk/
	KfW+PRS5v51u70nT66kS3DN3/mgcAiUA
X-Received: by 2002:a05:6000:210f:b0:3b1:8db7:d1fc with SMTP id ffacd0b85a97d-3b5f1868fabmr7767202f8f.21.1752473932019;
        Sun, 13 Jul 2025 23:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMb84z873pnVV/n6jQQxSrdFm4nCG9iSlLegUH4ZMFaaB/j4zesmp3EvIUrK0S9tmMwnXgsw==
X-Received: by 2002:a05:6000:210f:b0:3b1:8db7:d1fc with SMTP id ffacd0b85a97d-3b5f1868fabmr7767181f8f.21.1752473931613;
        Sun, 13 Jul 2025 23:18:51 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e285e0sm11260714f8f.101.2025.07.13.23.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 23:18:51 -0700 (PDT)
Date: Mon, 14 Jul 2025 02:18:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <20250714021751-mutt-send-email-mst@kernel.org>
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
> 
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

Did not realize. Will look into addressing this, thanks!


> I also agree with Bjorn's and Keith's comments that the driver should
> use timeouts for robustness, but still wanted to provide additional
> (hopefully constructive) thoughts.
> 
> Thanks!
> 
> Lukas

I'll address these comments in the next version.

-- 
MST


