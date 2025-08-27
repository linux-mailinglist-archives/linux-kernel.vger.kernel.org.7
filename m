Return-Path: <linux-kernel+bounces-788759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C13B389EE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA4D47B2BF1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2142B2F548A;
	Wed, 27 Aug 2025 18:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUTN97vw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9AE2E2EF9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756320965; cv=none; b=Cwo2lvUY1m5uX3BgVDUvjJMW1CSlddPOUu/3ADyRql9CBaAI6cGe6SqAyBDrrcQZj2aUT+ZuB0gXmd4X4jb+0si1Ml65FyOE3R+UvxaY4Ckvf867pQJwRyNkpAu/u/1oQM1m4pwfF/cGU0gvBcnvskgJ4PxgKKJZPo/uFamRd8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756320965; c=relaxed/simple;
	bh=8ok7WAgHWHzIb67w4OKsGxYVKHOMk/whxVn9yr022jA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CfyB20aOLJQTSgcuOCnN6MGs+Eg4hLLSPgBdmxpZMgGpXzEnrcBT28muzFVT3nVhVy/JHFl2OmtWuRU1XJTKdU2Fl8Z4R7tTcfxHJHMuLNpli9BZhTpms+GYsk1odKjTkyTeU0pb0cCijGM99e8x3wh35yISDyMdJVY2VrEiVxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUTN97vw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756320962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LaJTrQIELffdqMUepm7rFcVjoX613nWdx1blyGA6qhk=;
	b=aUTN97vwL9BL4hxJI34Ko0hvlxejVXgi994aWCHyygpp4Xm8lkb41ajbaUk0uP0s8+Npad
	gt4HcoV9srBB+n2YYyIq37hHkUO8H7qROCn0ebWZZ7yonY7aPEQPn13PtQ1iscpzSQsSkI
	qbxx3Vb8slFve9kDZECrWw99sNEGsrI=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-qhMuA2YGNUmoZo3dr6HPRQ-1; Wed, 27 Aug 2025 14:56:01 -0400
X-MC-Unique: qhMuA2YGNUmoZo3dr6HPRQ-1
X-Mimecast-MFC-AGG-ID: qhMuA2YGNUmoZo3dr6HPRQ_1756320960
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ef01263b4cso399295ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756320960; x=1756925760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaJTrQIELffdqMUepm7rFcVjoX613nWdx1blyGA6qhk=;
        b=BM9XuJRiumvOOKhp4OJRdIexIrw59sLwj4bzlcdUpfNGVmK1VMATeoK+wYwDq6qVQE
         GyeUgxLmEUPNXzBqrdPuuZVTcY6rPOuO/rUHPftdRoXUY+TTR77hUgGNGY1fIUAPhiQC
         5Yib9tWp8tOxOuhsYKh6nPrWnCkm1Mat7GbFquSqqN8h0FPDdayI9ZdYkJ9o9s9VF65P
         is417zIhf1UfJDYvwuiUrpGtKukKJrC8507XKB20Vj4Mvoi8nNzobVVkr5I+C+qzWYfF
         KNdL8P3oA7WEW47ZW3bUukXJfTUGD2fYXazdLQBNIAt7rr2X1UBEOD0YZSGN0+6sqIY7
         41fg==
X-Forwarded-Encrypted: i=1; AJvYcCUrxU2LnE9T2bAh9TSl54BproSwNc0yDaFm7FUq8NMDdHcpBJteyxntWUKMHCSXaqPmWKVT27bQGXprGfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz76zIiVvGdrxtuvGXrmAhsF9oN9G1Nqx5UngaRGVhiULZGGvGD
	e9b6ONIPDPO6Bpd4OcE3YyRk9CJJHXz45XTXTr1lvjrefXvdRqHfniPqiWKExzAdIhmB2L07wzf
	lzpfURB7CaUXl200+bXSd6CZSs7UIpQR09Ybyk1Ik0rhUATYalNRNf3i0j8BK2ezQPw==
X-Gm-Gg: ASbGnct8nfLSo72IDqW2GGl++NZZ/tqc6FPwpUDomeiT4Zu0SMmXnUK+RRbELGlpUGf
	isP89etJ9O7toAX1qkyB4DgY7DxJlaTqLZOIlIM4GEdmBQE9COXS5aN2uWoaVQY0BuNSwtN+ARo
	uvtHAVaZDMccVQKAXBpIYJcokUfMqWOn+3cdxqt91NMLZHq0b/XQmB1aFUBvBr7rKinBKjKW0Wr
	I9nl7VojV4AXDfwSVo+pXTviVIESjv4t0kKZulKHqGAyqOO9cvGYzC7Pa4F/4/0/YYMoU6Hx6LF
	iS1TwouK/LOTcwH2CyI2evxo18oyY6alNi692Dlsm5Y=
X-Received: by 2002:a05:6e02:1c0b:b0:3ec:173e:8b6c with SMTP id e9e14a558f8ab-3ec173e8e6emr65344255ab.4.1756320960260;
        Wed, 27 Aug 2025 11:56:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPb2pJYAkguncuQSx6IZaNOZrvdB1Zk3MUKrevEct/LLAhqT63GRfQVhKzRAZJNEzz7BkGLQ==
X-Received: by 2002:a05:6e02:1c0b:b0:3ec:173e:8b6c with SMTP id e9e14a558f8ab-3ec173e8e6emr65344105ab.4.1756320959727;
        Wed, 27 Aug 2025 11:55:59 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f0a3a1ae9esm10463375ab.3.2025.08.27.11.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 11:55:59 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:55:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Gupta, Nipun" <Nipun.Gupta@amd.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "llvm@lists.linux.dev"
 <llvm@lists.linux.dev>, "oe-kbuild-all@lists.linux.dev"
 <oe-kbuild-all@lists.linux.dev>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "krzk@kernel.org" <krzk@kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "maz@kernel.org"
 <maz@kernel.org>, "linux@weissschuh.net" <linux@weissschuh.net>,
 "chenqiuji666@gmail.com" <chenqiuji666@gmail.com>, "peterz@infradead.org"
 <peterz@infradead.org>, "robh@kernel.org" <robh@kernel.org>, "Gangurde,
 Abhijit" <abhijit.gangurde@amd.com>, "nathan@kernel.org"
 <nathan@kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 2/2] vfio/cdx: update driver to build without
 CONFIG_GENERIC_MSI_IRQ
Message-ID: <20250827125557.6340d8d3.alex.williamson@redhat.com>
In-Reply-To: <CH3PR12MB91935A30AE6BFFA18A5D4B32E838A@CH3PR12MB9193.namprd12.prod.outlook.com>
References: <20250826043852.2206008-1-nipun.gupta@amd.com>
	<20250826043852.2206008-2-nipun.gupta@amd.com>
	<20250826102416.68ed8fc6.alex.williamson@redhat.com>
	<CH3PR12MB91935A30AE6BFFA18A5D4B32E838A@CH3PR12MB9193.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Aug 2025 11:04:12 +0000
"Gupta, Nipun" <Nipun.Gupta@amd.com> wrote:

> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> > -----Original Message-----
> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Tuesday, August 26, 2025 9:54 PM
> > To: Gupta, Nipun <Nipun.Gupta@amd.com>
> > Cc: arnd@arndb.de; gregkh@linuxfoundation.org; Agarwal, Nikhil
> > <nikhil.agarwal@amd.com>; kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > llvm@lists.linux.dev; oe-kbuild-all@lists.linux.dev; robin.murphy@arm.com;
> > krzk@kernel.org; tglx@linutronix.de; maz@kernel.org; linux@weissschuh.net;
> > chenqiuji666@gmail.com; peterz@infradead.org; robh@kernel.org; Gangurde,
> > Abhijit <abhijit.gangurde@amd.com>; nathan@kernel.org; kernel test robot
> > <lkp@intel.com>
> > Subject: Re: [PATCH v4 2/2] vfio/cdx: update driver to build without
> > CONFIG_GENERIC_MSI_IRQ
> >
> > On Tue, 26 Aug 2025 10:08:52 +0530
> > Nipun Gupta <nipun.gupta@amd.com> wrote:
> >  
> > > Define dummy MSI related APIs in VFIO CDX driver to build the
> > > driver without enabling CONFIG_GENERIC_MSI_IRQ flag.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202508070308.opy5dIFX-  
> > lkp@intel.com/  
> > > Reviewed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> > > Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> > > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > > ---
> > >
> > > Changes v1->v2:
> > > - fix linking intr.c file in Makefile
> > > Changes v2->v3:
> > > - return error from vfio_cdx_set_irqs_ioctl() when CONFIG_GENERIC_MSI_IRQ
> > >   is disabled
> > > Changes v3->v4:
> > > - changed the return value to -EINVAL from -ENODEV  
> >
> > What are your intentions for merging this series, char-misc or vfio?  
> 
> Yes please, this can be taken via vfio.

Series applied to vfio next branch for v6.18.  Thanks,

Alex


