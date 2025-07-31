Return-Path: <linux-kernel+bounces-752080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7493B17114
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51B71C219DC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA472C08DB;
	Thu, 31 Jul 2025 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Pc0Ruz+Q"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD352C08AC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964542; cv=none; b=Ek1fqghaEG1JrRuLacxVTKaVL/NlzUfdlIe8StV70+nxNFOlCZrSQwqcxNDxBP/m95uK0YvXHuazf4GnuHgtsGsnBSBrki+kUL/wSHn+4x328fdFkJnR4x79VWL0klTDNXp3NmssywmIyHnrknXWsR6o/PWf+hiCAvrvwXmlWy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964542; c=relaxed/simple;
	bh=X+4QeaSFicbF3O5vX3PUSK7qVCr8plMhgP2gRhF3p+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5vzG/Dc6pUkRKIKiuHU62UIY7h99EbLpY8UG5H7Uo3owjgyVWRKD4r5F0KrVw51pVErFjWRKcJyl+WQlfKSfeOmPsFgG4tIBIBGjJoKsIfzmsHudbGRuHUNvBQouAn1mS/yUuQzC4scD2jUfFxBt2pM83dLXcdSbBom08DO0jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Pc0Ruz+Q; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab60e97cf8so10750801cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753964539; x=1754569339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L1plMRIcW1Bcl6c/s/tE9fzsee7elDjFfonquyZ/HhM=;
        b=Pc0Ruz+QOm1sFbg3HZMcBFqvVzqm7XFlhULHymXu9AE90U5XEEX8IA7IofFEOxRtgF
         1KtolxwTgE+OjId2TjBvleon+q0ZH1S2FXbgdQuHZV1cTBEzkf0Fmp1+BEXZGQQa3AXF
         OZrePCjmNmVP/M/9gvrxvGg0imZZA6oJ4uZXAwsk4+2vqAmSl4hozkfMdOnM498X75ly
         t4lwzrXSuqP7nxHkW0h+PV5It5jF5I5+hhldVJgGcgsI7b7sXDvfp+/2uRMRRkg7bUGZ
         m89Yry3ZaDZzfjtsKqPxiyCVDZ/1PeCNlyFzdj0i6gr/3dK7bErUZRAx5wJ+2+7TjVlH
         v/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964539; x=1754569339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1plMRIcW1Bcl6c/s/tE9fzsee7elDjFfonquyZ/HhM=;
        b=A9xDd24UIBM/WJgw7/HRhHu6UcjCp2mHCTGkkHXnqwkF6JR6cK5nXWZfft/eFw8zRe
         I0/aKOlBGUhTBbQJM7jCCCfvA7P+xltWXoNMFZb4hJdv7DnmOWfvhhCO6CxTFwye1VAs
         82X8iUoBQykYZtgVtbGZpInHYF5CADOrIHwJ8iAro05b+2VDzrtxWx8VxxLaYqAzjocM
         urc5aOYS62vQJRUJUMTpQ5FinrC17Xxu9JpZjFfqTJPBDKNG1haouzzBLn4PZGt4tyr3
         qAdSrT4ZKW1ED0+xkEgwsI8ZaPMtYUMDiOtj7YEB7Fg9qcXu6j/Fsa8HRnYgrB5EFDcL
         GPUA==
X-Forwarded-Encrypted: i=1; AJvYcCWCl+DjgIWAU7JwbOhLogsJXSoMHrhWWSWQXl6I2QdacpApqWKlymZj/ma/7OhkO3jLxEVaolhTdoIiR44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSt2hdnCnPRfXEOoXkuGGdNvPaEPX89IdtD+ibfoig4KRKL/Tf
	OY0LBjojO5eff9AYi0VcMPh2WpZIoqHWz+weCrg5jmMaCpx8gtlFSlPPbFlheWvlTO8=
X-Gm-Gg: ASbGnct0o0UqEHYMZ+TMusXQciUyfp6poYcS1Z7fxnMio5+PhxEOKePzMAcA4LY1VjL
	kSXGuSZyn8xcWSO45dOhJCNb7Y9tnDhDkKK+HEvvTtqJqFC1JFDSb1sVy+Z59oJmXXmZssQrS1R
	1B7wMNUaoioaZ+RQdGvhA/kTDEvPdA0alP1Tw3cuYJvIVvE7vlZJQc4TFm+ix9sPcp2M7r0IpAN
	tHnJcXUuwvy+hK1quj/c9xkG4Q0aheDKkAmEjK+wWwgNqx0srrScxcMgW+9sr8D8gGX20FpRKBq
	lVPAJhCX2H6PIu01XQMWkF7G8CAzUXxgjRxmg0s9RfdGkbcEeGP9sErbSJQkJCoKNbWAZBaZ2VI
	Mjbaib0migzT845ol/cRZgHFEY5LLX4dxZA+LCotbn+E01GO8lwODCcDczr7E89LQX39O
X-Google-Smtp-Source: AGHT+IEG9A1JcQH+wdTVAVeKvLLO9IN7xUQV2FzilQVc+xKe0AMZGYYJKSglwslI/+w6Csl5DatYZg==
X-Received: by 2002:a05:622a:ca:b0:4a8:19d5:f8a5 with SMTP id d75a77b69052e-4aedbc45df3mr101058131cf.35.1753964538758;
        Thu, 31 Jul 2025 05:22:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeec0a6dasm7661341cf.24.2025.07.31.05.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:22:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhSIb-00000000oYE-2zpl;
	Thu, 31 Jul 2025 09:22:17 -0300
Date: Thu, 31 Jul 2025 09:22:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 06/38] iommufd: Add and option to request for bar
 mapping with IORESOURCE_EXCLUSIVE
Message-ID: <20250731122217.GR26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-7-aneesh.kumar@kernel.org>
 <20250728140841.GA26511@ziepe.ca>
 <yq5a34afbdtl.fsf@kernel.org>
 <20250729142917.GF26511@ziepe.ca>
 <aInBxnVIu+lnkzlV@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aInBxnVIu+lnkzlV@yilunxu-OptiPlex-7050>

On Wed, Jul 30, 2025 at 02:55:02PM +0800, Xu Yilun wrote:
> On Tue, Jul 29, 2025 at 11:29:17AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 29, 2025 at 01:58:54PM +0530, Aneesh Kumar K.V wrote:
> > > Jason Gunthorpe <jgg@ziepe.ca> writes:
> > > 
> > > > On Mon, Jul 28, 2025 at 07:21:43PM +0530, Aneesh Kumar K.V (Arm) wrote:
> > > >> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> > > >
> > > > Why would we need this?
> > > >
> > > > I can sort of understand why Intel would need it due to their issues
> > > > with MCE, but ARM shouldn't care either way, should it?
> > > >
> > > > But also why is it an iommufd option? That doesn't seem right..
> > > >
> > > > Jason
> > > 
> > > This is based on our previous discussion https://lore.kernel.org/all/20250606120919.GH19710@nvidia.com
> > 
> > I suggested a global option, this is a per-device option, and that
> > especially seems wrong for iommufd. If it is per-device that is vfio,
> 
> I think this should be per-device.

IMHO there is no use case for that, it should arguably be global to
the whole kernel.

> The original purpose of this pci_region_request_*() is to prevent
> further mmap/read/write against a vfio_cdev FD which would be used

No way, the VFIO internal mmap should be controled by VFIO not by
request region. If you want to block that it should be blocked by
iommufd telling VFIO that the device is bound which revokes the
mmaps/dmabufs/etc and prevents opening new ones.

The only thing request region should do is prevent /sys/../resource,
/dev/mem users and so on, which is why it can and should be
global. Arguably VFIO should always block those things but
historically hasn't..

There should only be one request region call in VFIO, it should
ideally happen when the VFIO driver probes the device.

Jason

