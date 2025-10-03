Return-Path: <linux-kernel+bounces-841491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1D7BB7824
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B6B1B20938
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCA92A1C7;
	Fri,  3 Oct 2025 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hY8gpfse"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F3A130A73
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508206; cv=none; b=Po31WFRohBAng2XvR/YRF8ZFRROySnP+laAG0AXEFp52Lhj9bfNiNLY02TuM6aAX2okGvihiNKUmHOdmKxoilKV4P705/smwJigr2TAf9ottSCRkWVmfkYq5rKzsWCrBrbD44IQpp9UpU7faqSs+WqqNp3T4yJY3G2InfsO+GLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508206; c=relaxed/simple;
	bh=J7G2MdL975D7YMHDvu9pwpiM+WnuaEaHvwKlzluJq+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tx70vIkC9opTp0/5b34n/gBupiDggtxFmsvjA3xXz5b3jqv0wBFkxw3YaQXz6hJEw/H+yUZPyOGjKweF+TrDqGGysIfHxxknMQH/U8sQpqzA+OLBufersZ9ElRHsuCGvSJ321IFqEO548jy1y5Tlil2Vug9+x+cJvHj1sKjuON8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hY8gpfse; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-85b94fe19e2so239652385a.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759508204; x=1760113004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHzBYo1MjQ2gNHA4Ou9zKHDW/3eoS79ip6vnBeMEx9c=;
        b=hY8gpfseN2RHARCfqSepw6mxk/IanL8IW5CTWcBeCUENBnjS+vVcxE+pwx7Nja8jF/
         PlDIPW3fX8dBB/DfbzMZ/QdEcIn9kP5Alp7TzhYtyTpykavoQpdh3d4OwNhrnfiLVw9V
         RcdpAePSfhbbzB4kAxW3TmW0V/wXPAEiXA6hiyG0VFD5ulrBz+4l5wHlUElVTWab38x3
         Bmf+qs1gJXJChyw0i7GOjjv1d3WTo2+b4uDnD/3iE5V78eX4no0bEt/0wIQmpC+9+y4s
         SaynzjHrZCYwNIsNqMnUVRXfLYX98P5hgg/A39hk++8RrWAZP0iCHtodkv6JfSP2mxzW
         Gojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759508204; x=1760113004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHzBYo1MjQ2gNHA4Ou9zKHDW/3eoS79ip6vnBeMEx9c=;
        b=WrjFStdUdThzHazmIMmTuaAnK5X5eUQogZfrLYz7jvtXCEpYgUAbFptx6HH+peA177
         tLfnorrd37whjnRpxranKmtnjlr8MA7r/i8m9OM5UGtDqZHZpcM43mqTOOm5ROXAHyKX
         kB5E8Sud7sYISyjHsBaYSXE9FC2PCp7Ccg8T1kCbeE5A5xuVlxK3VgzgVwiyxClPW9b/
         Jbecou0f4P3oy/q+xBhy7y6UqZSxRSXBPHYJBHC+LFf0wnuOzWWRALbagxmQ1Pm/2vO8
         +iAASVsPL5Lp9J0BQkly8kdLZt2OyrHBYiEqexr4SM6I+GzXDvsmDtyGoe8XkslY5s46
         rA2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjASx2EgzhJz49pO3CBJHK/+FcLla3HOXbNHrwJ3eZd+vOvpM8dClpQEE0mMT0vbQi50kDLcfBiFERBvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWOCZ6ISEjJXEaEPzbkn6kSGzvm2hrNWiBVoaRs7KeaZyB7Gjc
	cs66kEaogCGrFp1d+Fz4tm+CgJ4weSSRZwB/JNCNecGC48w610lO+tr2Cp5CDd3iwHM=
X-Gm-Gg: ASbGncvD2YFktBPjXFUJWy0gArmQCJMNsp/EHBh0Un9h0AgrfB+bHv7yqmTKXvdxjip
	NwmCE9pQIZ9EAWQsnLLrLYoMyUgdyxcoSzSQ8AsJfxlGErok8MNVlYnpOnT2RjxfUxQvl0OgKW+
	W/ZBzHY82ToE2/uY2Jo9KrZv/Lw1PYzPagPfuwR+3Q059cu0xGvLaQiDb5f5K2j6spL9KzZXzZl
	OUV1b61lyLLYkdznAy4PpUo6F6r4u/iG/amLdHpIFaDhnfN31RlvjOu6pnZB91Pi5YE+MhhdgkO
	aDa152cZaV/Dfm3syTlSkRD4s4oq0sfL3i4a6Jmeo3woC2vTd2VRZofTHCqQacc5CfEt/JfIXlT
	QS7QCT1H1eauJ4Ab1AWq1PNG40Y1/zEK8rOGZltrdHG7FcEc5H6pqM2d6/+j8wAH7rEm5pZ1mL2
	7i8V4YYiOjebfrHCFv
X-Google-Smtp-Source: AGHT+IHcvVeJnp0yo4YrLyzLlnUpQOjbGbzXCXdxnvZebMwwT34i0tJEoniE7psM/n2xn/wBpznSFQ==
X-Received: by 2002:a05:620a:600c:b0:860:544b:ba39 with SMTP id af79cd13be357-87a33f1f287mr554353985a.13.1759508203970;
        Fri, 03 Oct 2025 09:16:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87771129484sm460715085a.5.2025.10.03.09.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:16:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4iSY-0000000E7Mt-15kL;
	Fri, 03 Oct 2025 13:16:42 -0300
Date: Fri, 3 Oct 2025 13:16:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Matlack <dmatlack@google.com>
Cc: Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Brian Vazquez <brianvv@google.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
Message-ID: <20251003161642.GQ3195829@ziepe.ca>
References: <20250929174831.GJ2695987@ziepe.ca>
 <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
 <20250930163837.GQ2695987@ziepe.ca>
 <aN7KUNGoHrFHzagu@google.com>
 <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
 <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com>
 <20251002232153.GK3195829@ziepe.ca>
 <CALzav=cYBmn_t1w2jHicSbnX57whJYD9Cu84KJekL0n2gZxfmw@mail.gmail.com>
 <20251003120358.GL3195829@ziepe.ca>
 <CALzav=fci3jPft+SXJ6tPG3=jRX7jjJPwnP=zWAb2Sui++vKPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=fci3jPft+SXJ6tPG3=jRX7jjJPwnP=zWAb2Sui++vKPw@mail.gmail.com>

On Fri, Oct 03, 2025 at 09:03:36AM -0700, David Matlack wrote:
> > Shutting down enough of the PF kernel driver to safely kexec is almost
> > the same as unbinding it completely.
> 
> I think it's totally fair to tell us to replace pci-pf-stub with
> vfio-pci. That gets rid of one PF driver.
> 
> idpf cannot be easily replaced with vfio-pci, since the PF is also
> used for host networking.

Run host networking on a VF instead?

> Brian Vazquez from Google will be giving a
> talk about the idpf support at LPC so we can revisit this topic there.
> We took the approach of only preserving the SR-IOV configuration in
> the PF, everything else gets reset (so no DMA mapping preservation, no
> driver state preservation, etc.).

Yes, that's pretty much what you'd have to do, it sure would be nice
to have some helper to manage this to minimize driver work. It really
is remove the existing driver and just leave it idle unless luo fails
then rebind it..

> We haven't looked into nvme yet so we'll have to revisit that discussion later.

Put any host storage on a NVMe VF?

Jason

