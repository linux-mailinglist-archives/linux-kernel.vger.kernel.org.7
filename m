Return-Path: <linux-kernel+bounces-752103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E1FB17133
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A273ADD9B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B98C2C324A;
	Thu, 31 Jul 2025 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HNfjI489"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696562C1585
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964917; cv=none; b=R8lsA0Ms/6HxkbOw4ErPEo7tRiX04ZaByvrE8uX80BBqwMC2omzbEZh2nIjnFUnm26mqW4s7iUqvSUnQsFfZ8WDWlthcJPGaeXGYuc2zq6WK/wMMbwpb5UfTVtcbbVbfN6y38XK0kIP3qHI9xFUQvmtODzK5rvMy9Et0NxojfFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964917; c=relaxed/simple;
	bh=b7z5hjyg2X+VeoFo1PgyUE9sKzY0a5OOB4fYEBfffec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHw171guKZyIGC1BlJ/d55o8PHhceyje8gZK90c9yeJMPb6Xeowu2MGy+2KQp0WQilsZkflvRe+1eLWw37s6LzIEY8DQK4fo88elEecBOq4wsGBRZ+8D9PDIf2E3LagJTRhu5IXooA7MMtPbeIqN3I15Ud4vjydKowfNTOuLS3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HNfjI489; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e33d36491dso30316385a.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753964914; x=1754569714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OW/Iya9h0ABUEfHeAI61tqBJP6UR+IkHJ9+YZwygnb0=;
        b=HNfjI489w/nmm9v4KPmn2rIBwTUX56yvucBIsp8A+P2kHlMrpYC991fnyl2jPaPE1o
         YDGlknxsVwbDyt1Q01wRZxWKTsr0ViLyIAmUslu1NJ+orvOX1RU0Cha7ZIsUwJcyX8wh
         dK3OzA370jwxBE2ayFCWz9PVsw1lC27hld8Cvtgs1jX2sGipWDiwRMNQ0cFZblol9cBD
         R+kEgul4XexdcpbmDTQu9PE5SI0AWEYqCzNktzkjO4yYFV/BW+wvFc7UY407zpyInf57
         x3qkfP5Re09HMNKUjrvmYjjwDI+2/55SwlMNalLkpOpOmzHxFw9F0DF2VYdD8KuQwyYm
         QaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964914; x=1754569714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OW/Iya9h0ABUEfHeAI61tqBJP6UR+IkHJ9+YZwygnb0=;
        b=wgIYDCUJoza8VaOskKOZC8kEc+pQZR2WsFPGVgta+h4i9TApyLnzyAJzMWZZMVdaYp
         F5TxuYzAvoWqddv0iQYk9/D28pDbrJpto7yz1rmb6+IJp2FqLpOEALTXJweqXVGU4I1s
         y0CY2nB1JIYEQLFvJ8wBWFOtJPAjBPr0HkhggD8sBnGyu3m5TlBDVvdPm6Jdh1NDx4Jx
         40SjqkP+bhcI1tc1JEQmL6GkPAr2kLCAbqRjE9GKuSdyNGDqLvOSH0qr3Q+5HLKFdFc7
         oYz2VxpDmTmTjCh2QiIr7FxK3qpfLbr9nK+GdCFgGmwuQXZoCiWG08Vy9GdxKWir3uOW
         7QeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoQLDXKuS5LlyDRLHe8lyRxr7TFb+2ZwvxJqyzZSkBoxj/7Qz11qQ2owZv//BL+L6Pag5Crb1EiZKejs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ZFCl35IVioZ5jcKEmtq+jJaUXNYLM0GChVgFtoOMr8bJ/8Pw
	LYaQUayXuD84AzVr7+iuxwfKuTA4xLXD+tZ+eBgVsOL/Qx06ZQdIRza4FCyu+zQcEQw=
X-Gm-Gg: ASbGncu8ZWSXe0Fg/FrFxdHfLGhIhEd/ofAv4FR6jplv1J+BrRs2Jdb1iLUzK03LKuS
	JRCWJpfabe5+4RWjN9/4LASQvyvLPRiMbTeQH8N5Hmes5T+qVuEv6OCpBRrFgfoj7h+hfjDqZPM
	uRRDR3xpyNhmJ/N7cUQ4gSi2QrkunAIS+qtNgu6r2prak3gDC31NEstzN+x7rhto4s50DNNnuvX
	37q4A2pC/KxqlSxsKhqVqDJfC8/qWGAi9CjPUwBglzCYj6ML+HY2tCyRMqf/lmpd4v25QGYMYcf
	UL2M7U8WD9Ryk/g9awhaA2fKpK5wqX8oksINC3noyK7dRUWIveCafjFFShwM42VWQu4l3metafO
	D2TFjVy+OKLuvDF9e8YpyuPSe/ds2FYDQPRqgVnFIb6ZYX2xhxn0TL//N5SrXVTdIFzrE
X-Google-Smtp-Source: AGHT+IGB5rbfhCfpEBxYzQb9tShfBv5DP1x7P0EzX5XLP6rdIVy17VMQfI03BZoFiDbqj4lwUzglhg==
X-Received: by 2002:a05:620a:571:b0:7e3:5129:db49 with SMTP id af79cd13be357-7e66f3515edmr758031285a.45.1753964914155;
        Thu, 31 Jul 2025 05:28:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f702578sm77242785a.57.2025.07.31.05.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:28:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhSOf-00000000oaS-0Yjj;
	Thu, 31 Jul 2025 09:28:33 -0300
Date: Thu, 31 Jul 2025 09:28:33 -0300
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
Subject: Re: [RFC PATCH v1 14/38] coco: host: arm64: Device communication
 support
Message-ID: <20250731122833.GT26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-15-aneesh.kumar@kernel.org>
 <20250730145248.000043be@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730145248.000043be@huawei.com>

On Wed, Jul 30, 2025 at 02:52:48PM +0100, Jonathan Cameron wrote:
> > +static int init_dev_communication_buffers(struct cca_host_comm_data *comm_data)
> > +{
> > +	int ret = -ENOMEM;
> > +
> > +	comm_data->io_params = (struct rmi_dev_comm_data *)get_zeroed_page(GFP_KERNEL);
> 
> Hmm. There isn't a DEFINE_FREE() yet for free_page().  Maybe time to add one.
> If we did then we'd use local variables until all allocations succeed then
> assign with no_free_ptr()

Maybe think carefully if you really need a "page".

What would prevent just using kzalloc(PAGE_SIZE)? Under the covers it
is almost the same thing.

Jason

