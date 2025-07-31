Return-Path: <linux-kernel+bounces-752107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02754B17147
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB5C161FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C71D239E94;
	Thu, 31 Jul 2025 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GwKg8OzK"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214F922FE10
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964992; cv=none; b=PiU/8Tdi56fr5XufAICyrk4YGP6+8Uc53i1BRxxn3d181Pr/GnyrWiM1nA9EVtjcfF6mY1jkq1WKAAKA60LV1V/MF2JqiW6yEsKg+bvtt8oHLub2t4xnGys2k3VnpZVRXH3+/VUOfZbXBPHgxEbQO8SpOXgCLcYDDKjmYxrzhmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964992; c=relaxed/simple;
	bh=stFuxurLK8Z8AnaZ49l9W8w7aFsmtWO77oIxpAGLTIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1H0mJvCNNf0rPO0Mab/qKM4FAWmV8CITdAHGDwFSyQdGOkx+nNiEzcbWVVkZhT/Va7rM5MPArQeUkiXrNGlhzY+LF+lOwGU59/a9f074SWD2himA5Agv2RvX6Xi74tlmRhpu0KMF6l7giE/A2RVjbVINGBkV9G7PmN9yBVsn9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GwKg8OzK; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-7074bad0523so3304096d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753964990; x=1754569790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r16L0lPAepHRljLoRD2C+qwfP2TiLc2fMDqSQ/mjsSA=;
        b=GwKg8OzKH1FJJ0EGcYmgcoOpKXaG8y4xKTXo4OsawCfSQP8AmzYIzXZ7vHimU38ijP
         7R4ddgMEQpAOC9viO4g1BUb9/NFYlV8X9S7FHUmdcCmg3kCQN55JVeGd4frnBeIZM0Gh
         3pJ7p4KQnBdclbmmXiHGT+jzZtRD/1CMrYNV5EtDvDNVUvsVCRjqxMFG1yFPewdmOBU7
         ktLAI3orHjdvWetkW1iKqbF/UmimM+epIhWVplhWwmrD/FH8Oh+sTla1gXP2y7wSJ+fI
         OMkRroDn6+DKArFYAvBW2KACi4+aX2zxNdwmZ/M+ehTsyAwr7IH1F1xoBPehGrzF5h9/
         GbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964990; x=1754569790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r16L0lPAepHRljLoRD2C+qwfP2TiLc2fMDqSQ/mjsSA=;
        b=rOSPlCwkhHzx8tg96AAP3ftMIqky5Wtv1qvW5611XdWSwcmiPFU5x5w7I6kYFdN8bx
         Jr+JmpZIyNK9S8z97zXwo5FiNcsH+tjtq4XwuXDzEsByEitL0mw2NxQthNl8sPMzipAJ
         pEWY1VJeantny3UKIa1Z37IGIkKmLdxotBKhxaSFSYD3wgiX/41PYv22vCyX/b5dhrLV
         skFLXJj29+uyUq/UhUsynhX8A6B7o5rLVP/273ziUozAzZZJeGxxETLJ7/lKbfdyDcrg
         p8eCpgR15VEjN+ELGph7vjVFfHV+STnwKCMaMbwtt3ncmmQqQMDj0BoDw5ki8MFXYvqg
         h0Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXXfT/jWkMCG/e2W3fhWpWCQ/KGA76DxkqDb9tF834dHv4pC3YdtKzRfjCH4LVDjND8EtA8f8u7Mm7Q93k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG//w4TKa499tZpYa170bZIFspAnpNACycUdrGAyIYol+4NK2T
	E5zxdixHf/npr3i33pOD3CIwMa3/aBveN0EF5Oicung1biN+ZacrAh5eLAAHG2iqiWY=
X-Gm-Gg: ASbGncubATJd7+hvFoZqhXuHz0kyl9aBC80Uwjhnxbiz/aSK3dTHv6hbHD3YhAv6KaS
	VHGLuFpGBMaCdgb0HRZP7OiTVCGPRvZmrkZwUMk2GcXZpAU9AHKOjrYMfdWviUVxTdNS6O0upao
	eNgBYfrpWdPxzM3iNlfrXA6pB8G3TYRbJdus8ZT0tpNHIKUuWQo6E90+ICoR7OOkvz8jgVLTtM/
	Wjf469ivjPdzzEVj97J1RJYAPoiT3mjC4mHAfLlU3Uh9z1fjga2uzhZ78+C0WfjhHNRX3dCxSqJ
	0ZJ8XDZQAoGPjp6uRbsG1/zkPMehi1+Fx4ic58cQB0CmsqYgMo9afKHkL4wM9DGKU2H6OfXhucw
	H56m2FAKQhSh83NisPcN6x1/FHXV8u0LGn+S1nwKca541J13ocSWcv14QYzMI7IAeMN5CLrTuMU
	Lo1Eg=
X-Google-Smtp-Source: AGHT+IGFRiq4QY4lDaxJA1kOgdG4s98/jc148KJ+4RcbhXD0Gv7ljg9jqdQ+tgIuoEfTT/tXWxH4vA==
X-Received: by 2002:a05:6214:248a:b0:6fa:fddf:734b with SMTP id 6a1803df08f44-7076710c664mr94449716d6.24.1753964989913;
        Thu, 31 Jul 2025 05:29:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9d98ecsm6607476d6.2.2025.07.31.05.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:29:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhSPs-00000000obJ-3nd7;
	Thu, 31 Jul 2025 09:29:48 -0300
Date: Thu, 31 Jul 2025 09:29:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 23/38] coco: guest: arm64: Update arm CCA guest
 driver
Message-ID: <20250731122948.GU26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-24-aneesh.kumar@kernel.org>
 <20250730152204.00006f79@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730152204.00006f79@huawei.com>

On Wed, Jul 30, 2025 at 03:22:04PM +0100, Jonathan Cameron wrote:
> > -static void __exit arm_cca_guest_exit(void)
> > -{
> > -	tsm_report_unregister(&arm_cca_tsm_ops);
> > +	return ret;
> 
> 	return devm_add_action_or_reset()
> 
> Mind you, Jason probably won't like this ;)

devm in a module __exit function? How ?

Jason

