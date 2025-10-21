Return-Path: <linux-kernel+bounces-863845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D59BBF941F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1A23AE29F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60E22C028F;
	Tue, 21 Oct 2025 23:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NDlvo7Cv"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512AC1DF985
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761089896; cv=none; b=cthpt9AhdpR0wewZfO27Z+B2k/6fwJ/anAqduxMR/r6P7ovdPRirvQpskyTgdbvE16E3XNlZu4V9eDN/tWGn/MzEz4oWlNavp5Tf+8Cpc6GG9WWOT/c71oauMYIlikUG3mmnMdQdfEw1St56DS2EGRQ4pej7qtPzlPKOTsKOHZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761089896; c=relaxed/simple;
	bh=V+u2TYehBCwVH8vLJaq4e/OoHFBT+xogbeFOuIIuxAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfKBG32yoDPAh6z/XwvYbmXd0luZePEs8C9h5F3FM4yhz4gBfUahwp7QDVZFqTizrctOLnSrHOouRW/pF5an2TOQ7UDNjWdOl+l+MVHNXZGlnZXbHMuES+cA+fo+aBZed2Xjk0TlZIU7bwWPHyosy/nzkOCahPXJTrXtC+7viGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NDlvo7Cv; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-891667bcd82so60577185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761089893; x=1761694693; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l0T6gaWR8wRqUaz48FqGAKEBOYEGIQ3pcXRlgXnhgn0=;
        b=NDlvo7CvjiZpIxPgybTZ2QAfqVZRpFbU7W2AjJ+S3EAlu7EZ2lwrt+5ai9lOo7DTac
         C/jTjGr20OGptUxkLt0IHS8Fw54acZwPnp5Ea0KSLjEOYPaJsqf4BYqj+XpX+ul0igAr
         /hNeBpVapL1Rf/AODWncFNO+gcifUvyZ8yTZehRNPllevDkrpis+NcGMpo2+AWVEOJ+8
         XH1EdbTQ+nfhyduLpnZyfnBjB82906JSRPynA1IqgFrBgFKa9HfzR7jRykPCMBFGnPOM
         8G2BGyPf2wE6F8sHqDfDJBD5cRoS+2AeLNJv4jC+xZ2ZZURVr471+xmBlGeMEEpQKkJs
         gHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761089893; x=1761694693;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0T6gaWR8wRqUaz48FqGAKEBOYEGIQ3pcXRlgXnhgn0=;
        b=KKoJ6cmz0rHfm5wxzfsVBsXnoh9NOPp7gZIwcBVTQ+qYmkKbTkoI5fZuh1JeFQynUV
         FLIWIvotHHYOegT7s8H5Lb0FH5BMFguvAKpJs90f+91RyxQ2JYaMJWNKu2lHW4Jczrs/
         ztEgFFgL3DIUz3B6X7tHIPJMoql+aP+YTmAivl7bT5kKsdBNtrSBDn/R3NGAvQRhq293
         cTMfLPm9xjptRomXjGKejFw7F180Dxj8cyFwG151G1j7f2gVBrLa8/kqEJPub0qxJvwb
         YMKyfg7+MRBz/SNBUb67VhCp8VtpyIzX2jgTS8VehhDDtOxSczf7PySkqSCi7bho0HRH
         ZjIg==
X-Forwarded-Encrypted: i=1; AJvYcCWKaG6asKn6whAVUyla9yV/YDZPh2tbCr/OfytOko2Ki0ZqJ9oUKHcGYsr5A39EFKTFX6n01/vMgwVHnBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxx+DCBWLbcx5SQEhNPQ7yA/J7ISQq9dRKn8oVcf5PtaQZi9Og
	ge1QBeRqLLDrTDszR96hTgWuxkvzCTKPRViXTDGEJ4Qf6i0gRWNXghxo4Jz0j3RIi3Q=
X-Gm-Gg: ASbGncul6p5nRpCbgAs4aFBbZrkHh92G6/zAtzPGaQrb2AX+3w4vHG2WRN7+4gND0xm
	XBvq81Asw9fcAsLdTOVuLFW7UtcnXv97QWX53XqouVYbdzwrFnP0JYEJnZsGDfaAdCqdMVGnzAU
	RkJ3uscb+1fvQECPWFrIB/7XRBqdGPnSK1LudTvBKZxlH5N0WmP9pn1yOT0QwIc2/8JZ6EctMzj
	viNn7tlHNKzuGnPY9zi29zBjFMUboXMiUuAWJ58gMYR+NvlfNvoPd0zH7R8FiLXETutdSGEtbmq
	LLjYphjde2HoWyed61uGoUhULwKg0yUqvosdCSytRr3OyiwW2LYq3O29Y7vssWONwhMtNwpmymT
	ua4qcwf5gWd6AREz0FMw8bi0q8Vaqty3gp7jmpSK5dyHze+qM4LM3TWTDd+aI8Dhza96nktm6tL
	TbqunPD4ise7iozJhnaIAZonDbCyHzHtq41pneTPJl1vR80g==
X-Google-Smtp-Source: AGHT+IESZxgXwvIqIMj9dzYjccElH5tAxo9dER4LfWd2lD11GISceznOVY3S2mBydzghuiBWXmdJvQ==
X-Received: by 2002:a05:620a:700c:b0:892:a71a:bff with SMTP id af79cd13be357-899ea1350d1mr183689785a.44.1761089893141;
        Tue, 21 Oct 2025 16:38:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab0c8c1csm83229571cf.20.2025.10.21.16.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:38:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vBLvf-00000000cBo-0n5B;
	Tue, 21 Oct 2025 20:38:11 -0300
Date: Tue, 21 Oct 2025 20:38:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Matthew Brost <matthew.brost@intel.com>
Cc: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Lukasz Laguna <lukasz.laguna@intel.com>
Subject: Re: [PATCH 26/26] vfio/xe: Add vendor-specific vfio_pci driver for
 Intel graphics
Message-ID: <20251021233811.GB21554@ziepe.ca>
References: <20251011193847.1836454-1-michal.winiarski@intel.com>
 <20251011193847.1836454-27-michal.winiarski@intel.com>
 <20251021230328.GA21554@ziepe.ca>
 <aPgT1u1YO3C3YozC@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPgT1u1YO3C3YozC@lstrano-desk.jf.intel.com>

On Tue, Oct 21, 2025 at 04:14:30PM -0700, Matthew Brost wrote:
> On Tue, Oct 21, 2025 at 08:03:28PM -0300, Jason Gunthorpe wrote:
> > On Sat, Oct 11, 2025 at 09:38:47PM +0200, Michał Winiarski wrote:
> > > +	/*
> > > +	 * "STOP" handling is reused for "RUNNING_P2P", as the device doesn't have the capability to
> > > +	 * selectively block p2p DMA transfers.
> > > +	 * The device is not processing new workload requests when the VF is stopped, and both
> > > +	 * memory and MMIO communication channels are transferred to destination (where processing
> > > +	 * will be resumed).
> > > +	 */
> > > +	if ((cur == VFIO_DEVICE_STATE_RUNNING && new == VFIO_DEVICE_STATE_STOP) ||
> > > +	    (cur == VFIO_DEVICE_STATE_RUNNING && new == VFIO_DEVICE_STATE_RUNNING_P2P)) {
> > > +		ret = xe_sriov_vfio_stop(xe_vdev->pf, xe_vdev->vfid);
> > 
> > This comment is not right, RUNNING_P2P means the device can still
> > receive P2P activity on it's BAR. Eg a GPU will still allow read/write
> > to its framebuffer.
> > 
> > But it is not initiating any new transactions.
> > 
> > > +static void xe_vfio_pci_migration_init(struct vfio_device *core_vdev)
> > > +{
> > > +	struct xe_vfio_pci_core_device *xe_vdev =
> > > +		container_of(core_vdev, struct xe_vfio_pci_core_device, core_device.vdev);
> > > +	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
> > > +
> > > +	if (!xe_sriov_vfio_migration_supported(pdev->physfn))
> > > +		return;
> > > +
> > > +	/* vfid starts from 1 for xe */
> > > +	xe_vdev->vfid = pci_iov_vf_id(pdev) + 1;
> > > +	xe_vdev->pf = pdev->physfn;
> > 
> > No, this has to use pci_iov_get_pf_drvdata, and this driver should
> > never have a naked pf pointer flowing around.
> > 
> > The entire exported interface is wrongly formed:
> > 
> > +bool xe_sriov_vfio_migration_supported(struct pci_dev *pdev);
> > +int xe_sriov_vfio_wait_flr_done(struct pci_dev *pdev, unsigned int vfid);
> > +int xe_sriov_vfio_stop(struct pci_dev *pdev, unsigned int vfid);
> > +int xe_sriov_vfio_run(struct pci_dev *pdev, unsigned int vfid);
> > +int xe_sriov_vfio_stop_copy_enter(struct pci_dev *pdev, unsigned int vfid);
> > 
> > None of these should be taking in a naked pci_dev, it should all work
> > on whatever type the drvdata is.
> 
> This seems entirely backwards. Why would the Xe module export its driver
> structure to the VFIO module? 

Because that is how we designed this to work. You've completely
ignored the safety protocols built into this method.

> That opens up potential vectors for abuse—for example, the VFIO
> module accessing internal Xe device structures.

It does not, just use an opaque struct type.

> much cleaner to keep interfaces between modules as opaque / generic
> as possible.

Nope, don't do that. They should be limited and locked down. Passing
random pci_devs into these API is going to be bad.

Jason

