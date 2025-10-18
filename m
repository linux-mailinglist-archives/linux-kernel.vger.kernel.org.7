Return-Path: <linux-kernel+bounces-859479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F1FBEDC63
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 00:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 141E34E219F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 22:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F1C2877E9;
	Sat, 18 Oct 2025 22:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XqAhIbmV"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B242566E9
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760825958; cv=none; b=HUzUgdnv1m5pkgT2BwE3B+x0QrCNkIqHf1voGIseoN6o6uHsffyXcvycPCA6EX/XU15ljmF25HoDMgpWClE7AebF0DV/uUtzD/dj/UJoE4KN6zFs/GFExC3U2RkxOm18YhgH3jyv4me3SqVQAWqHUqE5+o/wt4+h5uU+aJe4SO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760825958; c=relaxed/simple;
	bh=JlKaawplRif18Nf9EUoPulaOPmERcSHsfxRqy+XDXJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEkorYlR/2fLKUfzgyuuEb9wSpbT+VLadFUi+WKcvgbaKpx1P+gcBqRo4mAw/I3wPWNcE+k97eCc8l4zEnhmV+t7jFcmgY+RfISMyQeWgWN7QKcjYTldOSFJGJwG1KXp2N5KCOeMFB5En7IT3U8Nonp/pAPTD9seO0i4kHQ5LLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XqAhIbmV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27d67abd215so153545ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 15:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760825957; x=1761430757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xqo7yNFtggFSEzPqHQOFVfXHu2D1vZdxkr8I2A3MgfE=;
        b=XqAhIbmVkmact6RhjHTVufMtBw159dsQ9wR52u5a98jegnlGl3YffITbI8ci6c14z0
         UqPbAslyZyREHMwFzfqil3Kbz+ilz0PxoKBCzttIJtkMB1DnsVQN1fP7TsqrUwi2A5XR
         uMNFVWy08UJ2ncZ9kjuXaaa2JnHfFhBJ8/W0Nd3NtDCY83gEhLEypQR693NbDhtyVlYV
         txDJn3lXVC+4x9xhEcOCyaiQuqGiz4U203QIvp5KMZNMESyIbGUWkx8cnbilkb20Omdr
         vDeD9adGAPs57AsvRIHJOISSNr2sdNTxgbAPdZ+/zqnUrr46kmEaeSzLrnY7pyVtxP6F
         LL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760825957; x=1761430757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xqo7yNFtggFSEzPqHQOFVfXHu2D1vZdxkr8I2A3MgfE=;
        b=gASpl3d1HWZUTQVUye3VZQfmGZhHBrL1NoUWZ18NxIdKIcJPZ8fX54C4S6ZVrOkaYH
         igocBJRAVlk6YCa97X+rp8QFOM4gKbCUn1e0dT5Vz9Hlznx1ulaVhITN3F3mIGAHT35w
         dPrkztHVYvqQFoRFudp0ZaCLYeikApilGxRJ5rqodOK+H1HqaLVqfQ5pGzVqmb+AUk89
         rL2nLF1EjSYal5o0zVtHF33ec2YFZCNguz3MwguZ1KcqZwmnb6eP5qzLs8gLYYxJBq0m
         g/+WPLjkXI0HnnXzeJz4whnTPbFlzbXiiY8eP8feEPaywNcAnuWoXfSxBZ/HE02MmLKJ
         ND2w==
X-Forwarded-Encrypted: i=1; AJvYcCVGkWzRIdwSLTu4/gAzU7xfT2QGbMHszvXXq0xpTbJHm8aNAJRMpZUr8DyGG/EM1sh7VQLhJdIfYIK5nQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQIWhp1MilGyC7Ttzw+zX14jHoJgrTCbisUfdobdwuXrzkyVUC
	pleZkvb3z42yZoRA9lKq4Vx5UJsPxDQ+lFK4PztRqxX6qfSwf3GWpX1hk0iB/Fka1A==
X-Gm-Gg: ASbGnctcr4hN6QMCo/XwARshqGg65u9o0bD2ces7ribCDsyBmwP0tkraaV31kTBf3OG
	W5rjbEZ/toS4ArMzuUevE+pXu4tpk5tyoIU1EVec1IrjD+V9TPZXHiGOBeFoBNsEqN4oxVKjfYU
	d8DIGiaZfGJatmH5I8XxfpO9MNwKUsiy66y9VdoDxPqlbj4yNkZ/YAuvJNvjHW3zl4WghHA2+v0
	vhYkodEAiUWheg3QdF0I2Vt7rkrBVllLnWEFrrSP67qCs4zQqMTyTD5D4Q6y8e5IPlf1RUTRV/k
	+g+vawq9ZHvNreRh6Ew27f4cmqUNjQLdXPzeSwIIHS9spWSa2YViPqqZcIdnwMt8Fno7Y5Fg3GN
	6UFY7d9kkcdpAWfWfgPnOy9zx30F1APHWvhh9unTraUo/y2xgb+4MFLev0Sh9Kd+QmvqD7cU/RD
	B/aVOiM+j/nA4QHj8gp02gZ+Hjt0TQupwMccsw
X-Google-Smtp-Source: AGHT+IHNOSRoOYuo0/rydKUY7NRTeMMzgSZT/HjwIBsuJ//tdfpp1kxrb6bUECWA8HoYT4POGrda/w==
X-Received: by 2002:a17:902:ce0a:b0:292:64ec:e0f with SMTP id d9443c01a7336-29264ec0f7emr836085ad.6.1760825956380;
        Sat, 18 Oct 2025 15:19:16 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29247223a3csm35204555ad.112.2025.10.18.15.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 15:19:15 -0700 (PDT)
Date: Sat, 18 Oct 2025 15:19:11 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, dmatlack@google.com, jgg@ziepe.ca,
	graf@amazon.com, pratyush@kernel.org, gregkh@linuxfoundation.org,
	chrisl@kernel.org, rppt@kernel.org, skhawaja@google.com,
	parav@nvidia.com, saeedm@nvidia.com, kevin.tian@intel.com,
	jrhilke@google.com, david@redhat.com, jgowans@amazon.com,
	dwmw2@infradead.org, epetron@amazon.de, junaids@google.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 11/21] vfio/pci: Skip clearing bus master on live
 update device during kexec
Message-ID: <20251018221911.GC1034710.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-12-vipinsh@google.com>
 <aPM9Eie71YsJKdak@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPM9Eie71YsJKdak@wunner.de>

On 2025-10-18 09:09:06, Lukas Wunner wrote:
> On Fri, Oct 17, 2025 at 05:07:03PM -0700, Vipin Sharma wrote:
> > Set skip_kexec_clear_master on live update prepare() so that the device
> > participating in live update can continue to perform DMA during kexec
> > phase.
> 
> Instead of introducing the skip_kexec_clear_master flag,
> could you introduce a function to check whether a device
> participates in live update and call that in pci_device_shutdown()?
> 
> I think that would be cleaner.  Otherwise someone reading
> the code has to chase down the meaning of skip_kexec_clear_master,
> i.e. search for places where the bit is set.

That is one way to do it. In our internal implementation we have an API
which checks for the device participation in the live update, similar to
what you have suggested.

The PCI series posted by Chris [1] is providing a different way to know
the live update particpation of device. There pci_dev has a new struct
which contains particpation information.

In this VFIO series, my intention is to make minimal changes to PCI or
any other subsystem. I opted for a simple variable to check what device
should do during kexec reboot.

My hunch is that we will end up needing some state information in the
struct pci_dev{} which denotes device participation and whatever that
ends up being, we can use that here.

[1] https://lore.kernel.org/linux-pci/20250916-luo-pci-v2-0-c494053c3c08@kernel.org/
>
> When the device is unbound from vfio-pci, don't you have to
> clear the skip_kexec_clear_master flag?  I'm not seeing this
> in your patches but maybe I'm missing something.  That problem
> would solve itself if you follow the suggestion above.

VFIO subsystem blocks removal from vfio-pci if there is still a
reference to device (references are increased/decreased when device is
opened/closed, check vfio_unregister_group_dev()). LUO also do fget on
the VFIO FD which means we will not get closed callback on the VFIO FD
until that reference is dropped besides the opened file in userspace.

So, prior to kexec, luo will drop reference only if live update cancel
happens and that is the time we are resetting this flag in this patch
series. 

