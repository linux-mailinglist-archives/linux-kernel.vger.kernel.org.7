Return-Path: <linux-kernel+bounces-752061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D15FCB170E9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C138E585FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D292222586;
	Thu, 31 Jul 2025 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AKd/qGQk"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07A71DE881
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753963898; cv=none; b=WCDBWsH22kuIAx+1UC3XdVv6Yed/4E5HqeoEqZx697hzKjixs9QPPyjhHAmAHbQ+8hRr8EW/UNcKkZq1/LCpmNtj3RN/BLDLsH5ILCBQAm1HNkmgXYiXm6JnFT/eoDzy7RH1g2s2vJYcnHsWN6kkNxtWyIrM/PibSkFmnQzS5oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753963898; c=relaxed/simple;
	bh=S1wXea6GSEkJsxBK8lGgS5pwcy7cCkvMsy6PmRLU7EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHpHPBMvqfe+8vjFvzOGWi7ssl82wjp55mJQ791NmvrQbLu5zufi0GBh9KHIQqar0gpv55ysqjc8Sg87U0UjLF7QXLfUQnE2jgKd7xyA+DgU0y40kEKido82Z8mhjsgB72KQgja+VtbI7zn3z3K70BQEH9zSuzrNKlip/Q0De5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AKd/qGQk; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7073075c767so4242186d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753963895; x=1754568695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6GiA2tw+gwtAnjFcFPQpD5ne+ingC66pFHpYZpZzeYY=;
        b=AKd/qGQkrW7llFLuy8w6v46LybV1HsN2BzpFEcDfLnUnzvRugDxTeNQxZhpTw0dgRt
         73qcuHnZzyXM8iG98NgzCBpneeqm6MZ6Rxb3marhpnHxp9b5uP1N07BLIiE1FW47Cc2+
         JfD7dvroX5zjrb8gNk1Dr75gG6Cjy69CWqfqBNtY31luS93sVMyDK5BmGm+nGdJ2PLzE
         PCw9MC9xws0Zf2zmVQq4CODt11ZIQHK1igoSNKFpoP6MPlhEiQXogPiUzqTdJvscRS9j
         aWeYTpok9+aNo3ruTuze7VJ/IbDpF8kJ+iKLwqc/twJvwOwfzCUuFS9G8P31/oHkTlLl
         ZMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753963895; x=1754568695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GiA2tw+gwtAnjFcFPQpD5ne+ingC66pFHpYZpZzeYY=;
        b=XZzPdcQZWaO6XFbOXj1G8DMghWyVs6U68A1C1U5u67nbeVOxBbO74TBM5z4eQoAxRe
         /6MMft8yzJj+GWJPcEipNJTbkpU5QAPPA4h5UJqgB1xAfOWQXc3RB1Yt2RHdhVfOprFV
         timTIdfDNTijbQrjC07e2+kph/PwCtEinQOtOTmMg+w+Yrzix7j2u+Su5LSgM7s/dT/g
         OaFte51lTe5lWOzT6OZQyIVCCOPajY2hpgTux0ZIOC6iVjscnVJjMWRyVCpf95U77deR
         vKSBkEct0K6Vg4ygOAsgay8vMXcKuXLC8k1LWLYMHDoeZ5fNY0FXYvDwo54u2Z8bBNQd
         j74A==
X-Forwarded-Encrypted: i=1; AJvYcCVfCaCfSc6ns7FexDgar+P7RtdY0u2zGoROo5mfkioGkS9YPJ4hWZkCJAuXy/GWlKZTP3cbz0TF9cEb2AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVLmg2wmIZgYVfkYTEsSfXkZK5+rnH8Lk1N7PEfNPKtJdpOdAb
	ncKzwycrh4TWRYfY39x25YfBCuRcT+7sKvSCMvKcMrRX2VChOLYZjFvL5PjTn1p4OTg=
X-Gm-Gg: ASbGncvffxdOmM2/DL67beRRF8FFfj+H9Q9UlMa9YwNJOjEXteswAWDasYdcx0wQGDN
	59di5BSBnI6a+6LtOeLrbfzIir9OthaS4mDKMPSVFnMu7cnx7RFvkRosMMGHcbMMFNkTO7ujjzR
	rdVAMbiFqVoUQlMj4dkL8gtfjKtIqs18iVzgrDNIZ6TSBtfqswRk64KEAkr//wc54W+Ea+fyEPH
	e1wAEXt9NB7zDmz9Ey90hHSBpODukcrYguW8yH9Pt+UvtMWX1YwFwkmQdpbHpLwp3E23vYtdGQN
	t4W+82LfQyvFqFzm4BOLG5ngj1LqncmXUaG+BXuXsae7GaCBhoRQkxU+Yfd1IFxO805GPCbzSB4
	kmK9Uk5LsnZHn/HcpmKEumPIgKemlDAqc1TVPllgoHTqCDfBQExubLPYlXSN8pwHDVtbfk1Ob9d
	J2jdg=
X-Google-Smtp-Source: AGHT+IHjUvGatsM+Nj0UuwSVsL9Oyl4RA08oAzeUsK3Cyb+xVgspshhI3seh3MnRe0x10Mxp0AXXeA==
X-Received: by 2002:a05:6214:4118:b0:706:fa53:9d4f with SMTP id 6a1803df08f44-70766dc979fmr80279936d6.3.1753963894472;
        Thu, 31 Jul 2025 05:11:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cea1782sm6330876d6.93.2025.07.31.05.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:11:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhS8D-00000000oUc-0rT4;
	Thu, 31 Jul 2025 09:11:33 -0300
Date: Thu, 31 Jul 2025 09:11:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, gregkh@linuxfounation.org
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm platform
 device
Message-ID: <20250731121133.GP26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com>
 <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730113827.000032b8@huawei.com>

On Wed, Jul 30, 2025 at 11:38:27AM +0100, Jonathan Cameron wrote:
> On Wed, 30 Jul 2025 14:12:26 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@kernel.org> wrote:
> 
> > Jason Gunthorpe <jgg@ziepe.ca> writes:
> > 
> > > On Tue, Jul 29, 2025 at 06:10:45PM +0100, Jonathan Cameron wrote:
> > >  
> > >> > +static struct platform_device cca_host_dev = {  
> > >> Hmm. Greg is getting increasingly (and correctly in my view) grumpy with
> > >> platform devices being registered with no underlying resources etc as glue
> > >> layers.  Maybe some of that will come later.  
> > >
> > > Is faux_device a better choice? I admit to not knowing entirely what
> > > it is for..
> 
> I'll go with a cautious yes to faux_device. This case of a glue device
> with no resources and no reason to be on a particular bus was definitely
> the intent but I'm not 100% sure without trying it that we don't run
> into any problems.
> 
> Not that many examples yet, but cpuidle-psci.c looks like a vaguely similar
> case to this one.  
> 
> All it really does is move the location of the device and
> smash together the device registration with probe/remove.
> That means the device disappears if probe() fails, which is cleaner
> in many ways than leaving a pointless stub behind.
> 
> Maybe it isn't appropriate it if is actually useful to rmmod/modprobe the
> driver. 

Yeah, exactly. Can a TSM driver even be modular? If it has to be built
in then there is no reason to do this:

> > The goal is to have tsm class device to be parented by the platform
> > device.

IMHO the only real point of that is to trigger module autoloading.

Otherwise the tsm core should accept NULL as the parent pointer during
registration, it probably already does..

Jason

