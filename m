Return-Path: <linux-kernel+bounces-749510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CABDDB14F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C257543D56
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD0C3597E;
	Tue, 29 Jul 2025 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E+uaL2OW"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9503347D5
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799495; cv=none; b=Bw05E25kfS4A/m9iyN6piICg/iF/cSZtwc3+iOaUYuvw4sn0Aa6KuzuqwaRNw+AvoC7JzaEvgprbRA3EYdAFmHx/0/kEY/psxNase2AAMQEYInyoeoVEvfVNOiauAqODk20iZ2X2lv1M4i9vpVL8qPjKUerhn9fkN87HjX1IA0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799495; c=relaxed/simple;
	bh=AFA9S8jJFe+5kqGl8N1DKFqAh45nYl/JtFITblQV6NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzS7R9K42Fx2yKTkHBYVQe9+yoUfPMq1+WaW5UdKrrAn3zGTmnUqGEiIhMdnaQVBflbbZqKd2+XKo5B4xXvrrfYuPQWWwdwNo5eMBMI50TRcAoEVXay3CY4vQIa7KPy0euxDkoWthw3RlFOIbN24q/Z4gdgrO0wdphnF7LNAYaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=E+uaL2OW; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e63adcd6d8so404565585a.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753799493; x=1754404293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZNnUHdSPfcp6QWb5ggqY8dXU0goduBd5NcpjKFrjAU=;
        b=E+uaL2OWxdC5/J56TlHmecdyGUYvC3Ij9eisBZDESDBkDHLISJkAevbf9+4SKWXuHI
         xy2kHiWL4DcPGGGF/K0wnvPlJtZzv8vxxR0k9A1yN88osSML4sBX8Drw9MJu3pppqBsB
         eB5pBddGnjmbF1t5Z2229X6QiR52JyMTOyTsXnfoTELp1O2GCSzXsCA+c6SLZiURMqkF
         jcQ7AYcOZHiNZ7rQY1Y8McIZaUl5cgGSdJ0ncCJRMAMvtWajbuYicQIhGL5r/bJhbnQ0
         Zhyx2vD/nUOsKgkJDishpPlVX3LaADvA8vH9sh43Imr/LkTzLd2zkURBocrNj70NYdkg
         MXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753799493; x=1754404293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZNnUHdSPfcp6QWb5ggqY8dXU0goduBd5NcpjKFrjAU=;
        b=fEhvIGL0Oa55XlasIeYmUGvQ46P2QdrN6vYr2lW5NF6mvGioVVQSJeBU26zjbtBRkK
         Ke85yZdRERdleGIqQ2Q8bNvokRVVyxc+Q6kr2s8Wy4rIS6l1RAZWqt1zlPwMbPa9EwB9
         mUSPZjjkHwmrYat+E798F5t4Fbt68u9tOKApry5YMWzrjGKbS1YHey/ytyz+fqq+/OKh
         Gly6seDftCCi7aPohxrhe1BjnmTZV3ERPJcBLv4PK0ftxYcBwFgA7aD+Lx6QlXzMQjm/
         Lf24rZDOnsY3Lxt+cRiu0gAU5+s3aT6CpKAPbmBVVAp0VNOrcmjydjC4CpLfbgP+f0Mc
         pb1w==
X-Forwarded-Encrypted: i=1; AJvYcCUXZ3csU/snZK/RstazCgTBdf7Z4I0duLqRXsxx3nGH1qUz6jlenRvmt8NId5iZ2874XDW1qZSRhUZ1jB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF3CAvhE/tmuC/mIjah0uqPBKY1LELJnKk/LKMjlusZpXDY7jH
	n8GO2i8KxqNe21iou+EjhUim/nvd/o61oL9S8d1hPrrxE3x/SZ/gzHCcnJFwH0DRelo=
X-Gm-Gg: ASbGncs0lKnski+l8DTIcOmKemqMkA9rWpbPTRBEe1nbDOX1MCW1Z51gXqwe884nUYE
	PlR85CKoSaIoXxxC6kXSR/kzXJBzeChsIcaRJhUsSufdb7f9ZM6MoZ7Uv/DoIIwmy1AwI9RR5js
	7Aeedft0sTlDfSOeTvP04tTAR7Xmqu3IfcXfuTXCgq6fxHHvlT7hnxMaQvf3jbbSkrM3g3Q4J3u
	zWTHhz6Ufs0Fp/n4xB+vlKeeWN7crQXl1VZFqCfZ1y3IIj3SeGL4/3N+FnyERGT+epz/izVk+Y1
	hWAw2YK1pGOvH7TD9A36Mi7KzinJgUtLuNg3grunwvnXN4GXfgTQuSxSC+t50d7zKrMOXFuTGHL
	UXdLOKYu0sV85QcDt7k5gg0Bge2SJ/QJGMrA8TdGrgx8E+wA9ibLYdV2XTTlMd6jPo49W
X-Google-Smtp-Source: AGHT+IFtTSRa0Wzwdu/obR9nIK/NWqbYkP5+Vs9fYL5e9jSRCtuDURGeBrwm/w4UzvcIKUq4y49L+Q==
X-Received: by 2002:a05:620a:1a0e:b0:7d3:8ba0:614f with SMTP id af79cd13be357-7e63bf964d9mr2141405385a.26.1753799492694;
        Tue, 29 Jul 2025 07:31:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e643879481sm435354385a.57.2025.07.29.07.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:31:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uglMZ-00000000JI6-2o1I;
	Tue, 29 Jul 2025 11:31:31 -0300
Date: Tue, 29 Jul 2025 11:31:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 10/38] iommufd/vdevice: Add TSM map ioctl
Message-ID: <20250729143131.GG26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-11-aneesh.kumar@kernel.org>
 <20250728141701.GC26511@ziepe.ca>
 <yq5awm7r9yu4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5awm7r9yu4.fsf@kernel.org>

On Tue, Jul 29, 2025 at 02:07:55PM +0530, Aneesh Kumar K.V wrote:
> > But it looks really strange to have an iommufd ioctl that just calls a
> > KVM function. Feeling this should be a KVM function, or a guestmfd
> > behavior??
> >
> This functionality is equivalent to `IOMMU_IOAS_MAP`, but in the
> presence of firmware like RMM, we also need to supply the realm
> descriptor associated with the KVM instance.

There is no IOAS here because the secure world is using the KVM page
table. Since KVM owns this I don't see why iommufd should be invovled
in any way.

You need KVM to push the guestmemfd to the RMM and pin all the memory.

> > I was kind of thinking it would be nice to have a guestmemfd mode that
> > was "pinned", meaning the memory is allocated and remains almost
> > always mapped into the TSM's page tables automatically. VFIO using
> > guests would set things this way.
> 
> We need to allocate and free these pages dynamically as they are
> converted between private and shared states.

That's still within guestmemfd's area of concern and it can
immediately pin on state changes.

Jason

