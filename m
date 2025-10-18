Return-Path: <linux-kernel+bounces-859485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C66BEDCCC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 01:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045BD3A8383
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 23:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED8A28689F;
	Sat, 18 Oct 2025 23:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FLwH/k9Y"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B601E2441A6
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 23:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760828806; cv=none; b=qQ7IQ68vsjDoc3vIzkd5okufywxaHxOt1SgCR+8U8z3myzbmKAAuyaRLu1f/H5zZvU/3/BHoYwFps/jCIDu7HwhR/JjsRpA+FKFDVszgn6yv5Dp3ZY5Mhz2bP/Wc8xspynqDa7tFwrG7yUGV1RI9ccJYWmLSsPv3OIY54xh52mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760828806; c=relaxed/simple;
	bh=MRKqkuGtWZ0bwCJMZ7uFCHFFiA4GJwYDaNgMbBAuVxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jX7EBxbBI+llH9nr2EeAwmNZhok8fTLVibQjBwH0loGxN/Lwiw3jeG/QOJ8mxWW74uwVYllJPASNHWkQXRLVGMfj/AMGQJZ9g1yDwPzmLhd7/mf7VROOl0Bpu8z2IJmIoFRFA/5WVUQeiG9msVdtXajBrGGhQw1btCkeRKJBy/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FLwH/k9Y; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c28378681cso582785a34.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 16:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760828804; x=1761433604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dxNFK3ZGCsrxcWO/xofHDy4T8uFM9VvZEHwMPfXMD2M=;
        b=FLwH/k9Y4dPxHcErOowvbSJz7DZ8oWGLxmVKnbjANwD6ByAXalrtD/zapRCIosEolG
         mprOajFB+25GOTQzNF4bhqLua5UDQRaSRFIgkmRyU3ifKcSbxlNSX2PtZTs3eJyJqUeu
         nut7px7QoVR2+XEkboxPgZuQHKzAYI0OEpACJF9W3xXhIjvYvIh4+wsGn7Juax3uKo5y
         vzoWBq9joI7GnnkBdLEghkzCT9x673yWzZ/dCCBobW+DgxLHQWhzl09hzJ6Zcmo5X3p9
         YmMyK8EApcBZ4hdZS0g+Na69IDFw750V2d3dYxEujZ8DUtzGdgyuTbXrnqM3oQlP3G3C
         mJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760828804; x=1761433604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxNFK3ZGCsrxcWO/xofHDy4T8uFM9VvZEHwMPfXMD2M=;
        b=UAHv1vOpNYjGnLbDOpom3fiQuFn7gCkwk/Ar/Nq/38lAIBU08O/v7yrCqkLD2Nkfxl
         gbroca5mWPRUEN8Nfj32hW9FIgb4HL7BcFmH6I3AghK/Omssf8rsm7xa5w/sbzL0wZUh
         Z0EJcpBzNe8hYTVs4gvgjqwRkokTF1PpDrcbmbNpN7AiZYV4K65vSc0JkqV87V2hU2Nh
         29CA5f3tMBjSlAZ1YuyZE1JuIAFBc34ruOaSttz5d86qzP5Yux0kP/HYWlNiisMni0jk
         tAgtm1dgxrTLLHtOohvStmb5eCVorKNTD6GO8OXIQxAXiuLc+0iO0HfUb375mgzSZ/2G
         wEQg==
X-Forwarded-Encrypted: i=1; AJvYcCWp5w+8ADzzAUFdY/VhqrsjmriPt8fgto+qRktmqETVDIfWTQxbPfUCYdys1BxfPY2eNt3JrniK2awwRZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1+vYp/zVzdzaMg/M+b5eJijWHfxTDhvP8BvaZi8QomhRFb/PK
	4fTbRq4EeDUVhcckgqa3OtIZ4Z43tak2LVX2JNFhuvu+BT3oaJahGU2mmuGu6PO/bq8=
X-Gm-Gg: ASbGncs2j3YoByo+MQBF8MWAGj7GUHHd5oqOx4QdXJX9VhdDCqWqfulCmk3WIVCTy69
	9hU4V1DBwr3ggfWP+RhV+rNOb/dDHMYWwJi1uQjUK8vnTshAkKSs1FHt1GBrCfPXiLdzNaz9yje
	NBSurdM7EXC6KPfY9R7HZ6zO5oY1u+Q7gs+nOULcWGrjDuuYDmOBRrFy6uKimxyWcL9iOnhFGng
	O9DN/K/fXlpyvzNT+qNwEwpGnwBDKXWEDOHcp7rkTAEowqc2JHHwKjnFtIuEn7hp9xwWDKnYtp0
	dOW9k0obcn+MsOcxv/4FVJlS7xeVUfPOUw6pu1tN5TDQq89d0jwOnDHiIAnuDjSpHoeB2NrorA9
	m934ZcBt7hxy1ebISnBxhT+/a6eP5cTCyzBhvkxB9uPgwoyH0Bw==
X-Google-Smtp-Source: AGHT+IEts/2bQfz049IAs+xRI494sCkbsaGqrWMJcYh93QsC8Ouq9KxA1mU9DAni5be+yG+bXoEwKQ==
X-Received: by 2002:a05:6830:3703:b0:7bd:cfb7:1853 with SMTP id 46e09a7af769-7c27ccc5c25mr4810038a34.35.1760828803804;
        Sat, 18 Oct 2025 16:06:43 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c28879e8d5sm1168286a34.5.2025.10.18.16.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 16:06:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vAG0X-00000001ddh-3262;
	Sat, 18 Oct 2025 20:06:41 -0300
Date: Sat, 18 Oct 2025 20:06:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vipin Sharma <vipinsh@google.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, dmatlack@google.com, graf@amazon.com,
	pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org,
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com,
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com,
	david@redhat.com, jgowans@amazon.com, dwmw2@infradead.org,
	epetron@amazon.de, junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 00/21] VFIO live update support
Message-ID: <20251018230641.GR3938986@ziepe.ca>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018172130.GQ3938986@ziepe.ca>
 <20251018225309.GF1034710.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018225309.GF1034710.vipinsh@google.com>

On Sat, Oct 18, 2025 at 03:53:09PM -0700, Vipin Sharma wrote:
> On 2025-10-18 14:21:30, Jason Gunthorpe wrote:
> > On Fri, Oct 17, 2025 at 05:06:52PM -0700, Vipin Sharma wrote:
> > > 2. Integration with IOMMUFD and PCI series for complete workflow where a
> > >    device continues a DMA while undergoing through live update.
> > 
> > It is a bit confusing, this series has PCI components so how does it
> > relate the PCI series? Is this self contained for at least limited PCI
> > topologies?
> 
> This series has very minimal PCI support. For example, it is skipping
> DMA disable on the VFIO PCI device during kexec reboot and saving initial PCI
> state during first open (bind) of the device.
> 
> We do need proper PCI support, few examples:
> 
> - Not disabling DMA bit on bridges upstream of the leaf VFIO PCI device node.

So limited to topology without bridges

> - Not writing to PCI config during device enumeration.

I think this should be included here

> - Not autobinding devices to their default driver. My testing works on
>   devices which don't have driver bulit in the kernel so there is no
>   probing by other drivers.

Good enough for now, easy to not build in such drivers.

> - PCI enable and disable calls support.

?? Shouldn't vfio restore skip calling pci enable? Seems like there
should be some solution here.

Jason

