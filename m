Return-Path: <linux-kernel+bounces-861935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B888BF40FF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B9664E844C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96612459F7;
	Mon, 20 Oct 2025 23:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fpDWC6sr"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7069238C1F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761004190; cv=none; b=qW/JWu8Qbn7FSQ/xXDeQQp2kLyv0ssXiRirOE3FGtIbH0mzI8Q9syBUkAlrtD6m6CkjJWbMU1qnmId0nLEAGsUHL8rbn1jHQFIVqoHF7qEUDxZsE7uF0yFI053HM/lDbC4yCdm0BE9/YfvqgLRA/trCRNs9VVThfyMu/qzPtFtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761004190; c=relaxed/simple;
	bh=zSYtD3HhQ97XH9Wrf3mufknJ6+YNLu4weydbXr6znmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjxbVYTAH0YB8/306c1M44BNotCD0/0AVnoXy0SLw+KAURnxYGeKsk6z/fsH+WF5eDoXseWsjmw5lzpvTixXQ435jJBwq17Gq7NYb5fxZHaDExemjOhDGDf7WSDnlXTfbIZEcvfIxoiv5v7kYPcZnRKGdTS1LT4c8N+UFcAdqx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fpDWC6sr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-290d48e9f1fso59255ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761004187; x=1761608987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=APIPLhdONSvh2oNS2Jy31QMeW+iB8sQZx3emBmCMWyc=;
        b=fpDWC6srUyXdkWEh5jq6d0Zs6HDMhKp0T6MwBqoZyCVRK+Nvb28zEbhb4YmWdT4g7k
         bSNwUdF637xC4T5E+x55zFGTWDKytkxe1iU4Y0VYAHaCzIivRKeZwyi12jbauBPqp/x7
         qOjPO5TBDVm/ddVMF2pbwll8VwQyW72xeEimBJ1R24UZfiS2e+izQw9IwDGLEC5dPaID
         ADvki+ZQIK++7yEI//qA+qWXsaSbHBFaj/ziXKD1fS2NF8tqnoF/XNSo8DJ6OS8AQimH
         Z7payORjR/QdUhFTez5Cg4maMdEXHWA8jMeyEyiexmcC9RXatDMBje4OrKU7TCBEQV7U
         Ah9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761004187; x=1761608987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APIPLhdONSvh2oNS2Jy31QMeW+iB8sQZx3emBmCMWyc=;
        b=PUh7t/wYxpFL394O05vHkWnFdgc4zRIVn4LdawPspXG7W9Rn7vhGwGsJnkmt/Uks5G
         D8t99a7JDzOMW8i5DRMXV6y0ESPChiTCitpeIMMVzYPLQbjGb1spXegsyXjUBibn3BPr
         4NQ11E5o1gGKlY+sBLweZKYff/9fQHV84hisWtsCYCB+fYbqeCl3/c0douwihj15HU/o
         9Qg7ueeRQAjPo7ERXo8U+WmQhz6NGediKGZf+GDdPiDSKwyzPeMxuVGfPPNPHoqRNrHF
         otjEFwq3Y/RHchydC/PZA0cwmI5UR+1GMLGkbSCBYRahGcnROKbD8YuhgRyeGKtDTLM9
         LauA==
X-Forwarded-Encrypted: i=1; AJvYcCXIIllKZ55VdCle4Wrgkqy76jhQdDMnEb4fZ3J1eEy5JEsPTfdvQzTIkNVIuyRh3K41XunJVrRPTUZbwI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZJ0e1uCHKDZfVqbh2JMbkVTDcX0LWHZk3V0LBfU3z+NhLxSpQ
	5jY5yLyYeSCeScCtrTBJLI2tt3XlCeXPL0M28TlUIMoFGPTFEqgCvLAKFDnQAhRIoA==
X-Gm-Gg: ASbGnctk3cSV4JGzZW+XrRVWyI5SHRNFct95XSwnApiksHksDNzuuuM6bUaii7tHCLp
	EDZe+bdVVc5Wpnopfj4GynBVJehsGjFLa4XX8M+18f2RhsiSerjtSTt7xe+Xku9Vp+zZkbzNtGa
	CCDa4jtb9KfdIfOspqppR7R0TdZtwEhkbdzW70eFX7YtiNsmkYVpihmm97RkDCQV8q85WxxQFqz
	o4u2pN3GLDDYz7PtEcpcvxoY+pWrC5IjeOo/sP53vK+R5C413Wm4CL7OPRtdcXmUyGDOYuRyGO9
	dgFNkBlyxWcc1IvCYfplaCEB95T1Kak5rEQBunlqTMZWeRzKoi2e29IZ5eSuu/LuZuR1mYZOsP8
	1p5lYjNfrQG4y8I28CPJqBVK2wQeqXZnT3p0xFEDlgCE8/7ArGiMwZc+WWZwiBET7dGnRqpbg39
	7ZXljrmzyjwrQMhdebrJf6BBDmp2dLTdYH6w==
X-Google-Smtp-Source: AGHT+IHpL+PTPx5cLpK4SolM4pA26Uh3D3RVyUZIGeMHX90GD8vWXwavzy2Wzm8Nw3ukyKcc1LWkjA==
X-Received: by 2002:a17:902:ef08:b0:292:b6a0:80df with SMTP id d9443c01a7336-292d429a794mr2192795ad.10.1761004179616;
        Mon, 20 Oct 2025 16:49:39 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ffef8esm91310515ad.51.2025.10.20.16.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 16:49:39 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:49:34 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com,
	alex.williamson@redhat.com, pasha.tatashin@soleen.com,
	dmatlack@google.com, graf@amazon.com, pratyush@kernel.org,
	gregkh@linuxfoundation.org, chrisl@kernel.org, rppt@kernel.org,
	skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com,
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com,
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de,
	junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 15/21] PCI: Make PCI saved state and capability
 structs public
Message-ID: <20251020234934.GB648579.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-16-vipinsh@google.com>
 <aPM_DUyyH1KaOerU@wunner.de>
 <20251018223620.GD1034710.vipinsh@google.com>
 <20251018231126.GS3938986@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018231126.GS3938986@ziepe.ca>

On 2025-10-18 20:11:26, Jason Gunthorpe wrote:
> On Sat, Oct 18, 2025 at 03:36:20PM -0700, Vipin Sharma wrote:
> 
> > Having __packed in my version of struct, I can build validation like
> > hardcoded offset of members. I can add version number (not added in this
> > series) for checking compatbility in the struct for serialization and
> > deserialization. Overall, it is providing some freedom to how to pass
> > data to next kernel without changing or modifying the PCI state
> > structs.
> 
> I keep saying this, and this series really strongly shows why, we need
> to have a dedicated header directroy for LUO "ABI" structs. Putting
> this random struct in some random header and then declaring it is part
> of the luo ABI is really bad.

Now that we have PCI, IOMMU, and VFIO series out. What should be the
strategy for LUO "ABI" structs? I would like some more clarity on how
you are visioning this.

Are you suggesting that each subsystem create a separate header file for
their serialization structs or we can have one common header file used
by all subsystems as dumping ground for their structs?


> 
> All the information in the abi headers needs to have detailed comments
> explaining what it is and so on so people can evaluate if it is
> suitable or not.

I agree. I should have at least written comments in my *_ser structs on
why that particular field is there and what it is enabling. I will do
that in next version.

> 
> But, it is also not clear why pci serialization structs should leak
> out of the PCI layer.
> 

When PCI device is opened for the first time, VFIO driver asks for this state
from PCI and saves it in struct vfio_pci_core_device{.pci_saved_state}
field. It loads this value back to pci device after last device FD is
closed. 

PCI layer will not have access to this value as it can be changed once
VFIO has start using this device. Therefore, I thought this should be
saved.

May be serialization and deserialization logic can be put in PCI and
that way it can stay in PCI?

> The design of luo was to allow each layer to contribute its own
> tags/etc to the serialization so there is no reason to have vfio
> piggback on pci structs or something.
> 
> Jason

