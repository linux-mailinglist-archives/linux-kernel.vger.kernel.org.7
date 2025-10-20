Return-Path: <linux-kernel+bounces-861925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89DEBF406C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5063A6ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F5223909F;
	Mon, 20 Oct 2025 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zo6r6J4A"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA96191F92
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761003032; cv=none; b=sp90G6MuoOvY2eP6VphfDVjTb+3G6oUFxY5W4dp3du3mYTr9hQi57Us3kC7BHtYveI2IZDx4Yp3TnwkqwB4oyo9ebOHKcpPhb60I2RzlxnQszZZzTJo8zniNbFOIsdSjMyQ2gSaDQjcBerCKPZyXGLeGLsNYR/3YDd/S2RPlXgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761003032; c=relaxed/simple;
	bh=wBx5HU0NHsSDK23iXznXH3Oj8GG15Qr8iFROxkEtWPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6UiYPly6gJd/HNcMY+tbBM1322x6kExrcF7PV9GdTLfsA9OsBeo7ej7Y+QXNdFFZVeeoaraH+1/QQzqiBjz2ohLDZElLuai449YRXkf7yJS/OYINQYau5OzTTj1VGhWxdvJ34ueugqo6UOApZVN1d5Q0RuMV6PfpVdp5NAeGx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zo6r6J4A; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-290d48e9f1fso56805ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761003030; x=1761607830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2EojOJFcibgh1WcpC+qylb2gWt1s0H89duNTff3IMYc=;
        b=zo6r6J4AL4GIdCPnG7fdJSElKnv5fVxae3llaa3Z/Giwm6PznOJ28DnbcuUhb6bOPp
         3b5ZvLHz+R1mQtg2h0d6K+AF+nBje6kres9caqiHV15kuTJKkN6pfswEJ+TOUb6F+n3y
         Sm2zlj/uKfjxrCfyAmKQLlQPhvXEEWYZ7D+79YsPalj49vX9ERJ9gjo7s424ZlI/CAXN
         0HBzS0ynwrAgfb/9ZG2IwC5QYa2HHHZufcyh47u51lxmIizodz4pObTFsXQux5A3/2Wn
         ux8gKBvm3zZiZ6JW3yTmuR9xjqlVtF2tiMhyABvdgz4LIGymD3704/c42/D57M4+eEKo
         K3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761003030; x=1761607830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EojOJFcibgh1WcpC+qylb2gWt1s0H89duNTff3IMYc=;
        b=v1/vh8psJjEZUPtNd42jpvBkaMOpZcMNake5CV0r3IN+2AaqDmYRtVhnjfPqO9cE/L
         9LT/y7He850cf1O7WslkoyxaD7eeG8JMpGs/eUApaL2hit6nDLhdP7odq7FbsBfU8sKL
         wOZPvZ0NB5gm9mELyKo1d9YyUCes6yCoZTZ7hbKeQRPm0j+f+JW6iN9mWf8nWryRY8aW
         hOy//em3thYhjQQVBuL/4AVAyiTZvKFbaDN6V/yTivdIZhBvkewjUzom2mNs11Qb3t0n
         7pjI3jjXWbTJMUtRsTROkDRBEfHdGbd9obX12hN0AAnRjGBvNdkN/h8hbJvMT/vMjuoz
         k0jg==
X-Forwarded-Encrypted: i=1; AJvYcCU+rxBnyWYBbJ7D2zD1URpBz7fHH0wCgj9HMC+VR0/w/eBDstgUofFnx1TsyLfre6c0fuqj6Gu+TlesJWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTNKsaN6k8n4hGHlSR8kv0bRh3YLb8nzjkDurn2k9KHE7jz5uV
	MtFKVF/pR1kSu+/Oe73Lb/O0Gp4t3TRNEg0rXEUET+I/0HUu2Fphha2YJNW8z23upg==
X-Gm-Gg: ASbGncs8PXG43Jc7vrXXRkhyzd0tiY/tYD50ql6VbeDPMyyw30jgCHoPvnSAWe/rxQa
	iJQo0RbaBa1Etvyr1DBth+ERjiQb9GJPEJ2f/pZeXjdCugYvt4/eqXGKI5SI51lfFyIzA60iJeO
	qsRLqXgD04Rg5LUvRz2pJDRmMD5Vvh/Ry/eKpHOVQ5dE+l/IqXj6+Zf0HQ/3nFANlaBl27Cm0Gi
	rWcrZeYoWWsanLqOhLOfkAKiafdHUQ1wAWY9QtJRDtQZzINaV27sb8EmP1rsc6suGKkSwoksf3f
	iizoE8T4+JFWp9YpplKt56TZA6zyWaxdqIpzhGVbQG7lopz+HKZsPUYDT+oNrE9GLBE6mMJIXTR
	LofAflfdg2uu+rUYYXiMJhCqv+94QyMDopT5w19TgPdczzlBE+kUfJGEVHEpO0JQOlqcVkuy49T
	9wJOmek2fIZ2SSy7ELCuDsXFtc0DOtcK8Alw==
X-Google-Smtp-Source: AGHT+IGp67st8Wnp6/nSJ8EGcvRTlOdg+o3GxZOASU21XsdtW7vuEAf7PH3lMWQNe6ILam9RRnzuAA==
X-Received: by 2002:a17:903:9ce:b0:274:506d:7fea with SMTP id d9443c01a7336-292dc92664bmr869085ad.5.1761003029542;
        Mon, 20 Oct 2025 16:30:29 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2301108f8sm9508302b3a.66.2025.10.20.16.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 16:30:28 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:30:24 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <20251020233024.GA648579.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018172130.GQ3938986@ziepe.ca>
 <20251018225309.GF1034710.vipinsh@google.com>
 <20251018230641.GR3938986@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018230641.GR3938986@ziepe.ca>

On 2025-10-18 20:06:41, Jason Gunthorpe wrote:
> On Sat, Oct 18, 2025 at 03:53:09PM -0700, Vipin Sharma wrote:
> > 
> > This series has very minimal PCI support. For example, it is skipping
> > DMA disable on the VFIO PCI device during kexec reboot and saving initial PCI
> > state during first open (bind) of the device.
> > 
> > We do need proper PCI support, few examples:
> > 
> > - Not disabling DMA bit on bridges upstream of the leaf VFIO PCI device node.
> 
> So limited to topology without bridges
> 
> > - Not writing to PCI config during device enumeration.
> 
> I think this should be included here
> 
> > - Not autobinding devices to their default driver. My testing works on
> >   devices which don't have driver bulit in the kernel so there is no
> >   probing by other drivers.
> 
> Good enough for now, easy to not build in such drivers.
> 
> > - PCI enable and disable calls support.
> 
> ?? Shouldn't vfio restore skip calling pci enable? Seems like there
> should be some solution here.

I think PCI subsystem when restores/enumerates a preserved device after
kexec, should enable the device and VFIO can skip calling this. By
default enable mostly does:

1. Increments enable_cnt.
2. Enables to bus master of upstream bridges.
3. Reset INTx Disable bit in command register.
4. Enables IO and Memory space bit in command register.
5. Apply fixups.
6. Sets power state to D0.

On a preserved and restored device, I think only item 1 needs to happen,
2-6 should remain same if device config space is not written during
enumeration and state is recreated by reading values in config space.

I believe this should be part of PCI preservation and restoration
series. VFIO can assume that device is enabled and skip the call or check if it is not enabled
then fail the restoration.


