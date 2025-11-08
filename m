Return-Path: <linux-kernel+bounces-891215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8542AC4229B
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 01:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E7018871E3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 00:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9035227B4F9;
	Sat,  8 Nov 2025 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HOr39PH/"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B0A26E165
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 00:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762562878; cv=none; b=kagcKrcDZLPR6lC897tIiTtiwPN01Gdy53iG/7q1RQFn61SNrqMCEo1lqq8/G3tH9idggexjNocgaLuMLd+mWnuRBUHNM0Mk5bXHLJ1Ov/6kyFMAz7z1uBLf6c+pN3WShCvpHYgFUAr3/TW1teeotcHqu9iS8hPrJSEnwfAxM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762562878; c=relaxed/simple;
	bh=/hmyZSHeuXe883AY8RZleUWbPkiy6fF/KxVQz8mwSfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyzqJQi90UP4sttKhx3DQ/YGYYI8BjAcoTHOErKryN0WXhOCV6Brz9XKNPf7rsn6/WrB8QN1vOvBVFCGehI71+DHW3qrMos6/Gid65lelR4xd8heHSpUX9RmHF/ugWS4KT0c5Eb8JID/MESUFGc1M3m9wYTqbx5v8TAMSiz6pKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HOr39PH/; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b21fc25ae1so130773485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 16:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762562876; x=1763167676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pfSbx8L4nPanVGMRr479mHYfADbovNNtvZzV7lTcOv8=;
        b=HOr39PH/ycfa+WIhEcpwn8iiDgeyZUOmSeNi0s9oWfdxQxA8CYL54Hi39lu2+SbkmB
         r5/AT+fLZBjAk/7G4OuFlDsV0gGaaiNDlHI2LdtYxoTp8R1ETFPw12pi/n6JS2im0tl+
         ARdkQ2B5TbNNrxxWZqHOWw77OyWCPkqJYLOHfnP4+YwC2q++l9aEzfNHGC03ojkxOmaQ
         eFeiu6n0tYLpJC4nezMyAiLcW++id4gwVrOPQydR3/Ri8+Wvi2EPvuBRmPWIbjEOXCGa
         cctjh+vU80Lf66C4HnQPUIlweINwcQj1M//gvRAkQddNHpjBWfUzwQf2j+tygJG3vGcC
         jk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762562876; x=1763167676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfSbx8L4nPanVGMRr479mHYfADbovNNtvZzV7lTcOv8=;
        b=fsoEPyOOcpxdaXxXvQqS3sAhjkANhfy15lVl4TjuTr0vR6myaZwtOZzSvnGAGPDVLH
         guIBh2hANvGcSkgfNCQE3ImpthiEYZuEqvFfRBygC1OmtNuHPAkrhgxqNkWSp00KFh9y
         a76TY8hoRYvtLaD3M1ngJLrviOasdDiqaurfGzwVnKAoxu1+nhjS645EySkstE2ekhVL
         I/akWVx4QvcYHAv6WWd0ojFLbpruTNVqu7D3tmMYuh27MACcXo4oOjUGddHh5Cyd4r2K
         Nq24mq70wgdy5ortphFtbsnc/YQ8MMOc/cnUgdBqil80Zb6Iz8Q4yix6A4aTiY+/R2aO
         m/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVXFNm09G0Zq365ECSQG5hcA/2Y44j2q1VBZJqUnpQcZJZt31jhHcNrpWeXuJcH7KYZifSM3KzJ0EllWtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqpj/IcmIb8p9yXV7tpilaL+CRaY9IDB6PuAZOeJ2Bh2m94Vxf
	9GykwvodKz0Swfm4yfWwobvgYw713ySsfw8+E0b0sHGFn1UAVA7fA62rxRzYHvkah2U=
X-Gm-Gg: ASbGnctGFO7Hf7VH0SL2ZCPSWCT5bVz+OEm2DCKHbogPUql77KZViJyAjQ0cufQc6qK
	D3ESbMj6Avk/mIyjupvZlRKQQ2GWPJnfIcUMcxJf82hcSaacW7eshpyMBb7fjCAfSrVOeMVvL6k
	3XiYsne9ilpObAZiJEEsguf9J7LGm81HZYQQVrVRcE7WmWVWSsNJNAJNxK/dli1ISeAu/P6SX2k
	v7vGoN+ZpIZkmuy3XZ3aaYWfsVZUnvGZ18w2JqbW2gvYBa+cepDoMh0baVTnIPyTSxT8XMkvIvv
	EBbwHRUOIDMLYUVZU7z5n8HHsGtQPVuOceCMcou+zptHoGa8JOwxVwR96NOnEGeTT62kF3RyFjf
	89obW60U5H4w0fFJJNzIA4Xg2xvYD975ZTgoFuCcr6Ry2WYl9poysi6VUO7AIG7MXgeqRPQ7mH8
	e2FGFSotyttwclp+AZdF4CY5QKeddOubHGS3db1e2+zl/lqNXKXtuhahFl
X-Google-Smtp-Source: AGHT+IGDHhTWDSUeTerMAq7I/MD+3vriezautMa1TSo1oodrv/Bub4/+qoCC1k7wUOs9qzstWCl4pQ==
X-Received: by 2002:a05:620a:1a85:b0:8ab:5912:45c with SMTP id af79cd13be357-8b257f3d84dmr149741985a.47.1762562875697;
        Fri, 07 Nov 2025 16:47:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2357dbebasm525663585a.31.2025.11.07.16.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 16:47:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vHX7S-00000008NOZ-0EnE;
	Fri, 07 Nov 2025 20:47:54 -0400
Date: Fri, 7 Nov 2025 20:47:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Winiarski, Michal" <michal.winiarski@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	"De Marchi, Lucas" <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Brost, Matthew" <matthew.brost@intel.com>,
	"Wajdeczko, Michal" <Michal.Wajdeczko@intel.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	"Laguna, Lukasz" <lukasz.laguna@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
	Brett Creeley <brett.creeley@amd.com>
Subject: Re: [PATCH v4 28/28] vfio/xe: Add device specific vfio_pci driver
 variant for Intel graphics
Message-ID: <20251108004754.GD1859178@ziepe.ca>
References: <20251105151027.540712-1-michal.winiarski@intel.com>
 <20251105151027.540712-29-michal.winiarski@intel.com>
 <BN9PR11MB52766F70E2D8FD19C154CE958CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7dtl5qum4mfgjosj2mkfqu5u5tu7p2roi2et3env4lhrccmiqi@asemffaeeflr>
 <BN9PR11MB52768763573DF22AB978C8228CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52768763573DF22AB978C8228CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Nov 07, 2025 at 03:10:33AM +0000, Tian, Kevin wrote:
> > To me, it looks like something generic, that will have impact on any
> > device specific driver variant.
> > What am I missing?
> > 
> > I wonder if drivers that don't implement the deferred reset trick were
> > ever executed with lockdep enabled.
> > 
> 
> @Jason, @Yishai, @Shameer, @Giovanni, @Brett:
> 
> Sounds it's a right thing to pull back the deferred reset trick into
> every driver. anything overlooked?

It does seem like we should probably do something in the core code to
help this and remove the duplication.

I guess it makes sense the read/write lock would become entangled too.

Jason

