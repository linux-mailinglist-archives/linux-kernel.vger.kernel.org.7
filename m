Return-Path: <linux-kernel+bounces-746144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E3DB123A2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275883B4E39
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D352EE99D;
	Fri, 25 Jul 2025 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZytguFe"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C43F1A23A4
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467135; cv=none; b=K2DKnFGCG+tLu7qnCdsXXEOHSrL1SKhusEtFFBelPOZiRfI4/ygfIXWCeOenZmx1UuiobhGr6vKD+sj4NOO9isUD2Rc620ppU2pHZEbumE+58vnwXus73gbXSnEXvaBDL3BRPU9ai5fQaa25duWB5VoKalAQK3lff+YO5zDKCJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467135; c=relaxed/simple;
	bh=9YaUMw2uo4BIlLWMKZ+PThCgBBHtaJO7cpthxwOFSoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyQJ6L/YRgzoJ2pNdtFA2r4cQS+QfCOglj7xCwXxVuY5AreB4CAnVOpFqLVhRLSAoABYudHLDPbiAD/01o5C8LNBYW4zBJ0iXuPR23WymNGMhsPLCkTttox/yUOyRgGLQRdZGk56It9EBBVTaRTn9Io+Fpwc1/IGvA7EbgpysTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZytguFe; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4562b2d98bcso4885e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753467132; x=1754071932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9lqZ8GbVGbsyusC/rotoXs+VvnR4ndEH+/csO6rB//g=;
        b=QZytguFeukCmj0YInwqamgrRYpPBE50oZGxwvLlDOJrGMiqrn2yz1QGnQZYj3aToSP
         iQSB+ANhejsbPfSONRFlJsicwoj9Gr03CbbzMEt/s1Z1+TVm58xnGxdEbP4l5vOas/C2
         h9Y+j/jycidLsdEUuiqdz0jZJ9nhE7pZ7mPcQ9HpFoCLdWACfc4aIeQamc/MrBtQD4TZ
         2uGBV6NjphqS0VsUmqpNWIqerdUIAonQT0Ix/cdTTHtfx4fx98t7zl+QjkHHFuiwsgKW
         zkZkwnz8AH36YAcpc355Y3nAf2YykqsrDX9MQsIzsgQ/Da6cblpYyS5iYJgxDIT+Jx17
         HcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753467132; x=1754071932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lqZ8GbVGbsyusC/rotoXs+VvnR4ndEH+/csO6rB//g=;
        b=jcC7kdmzIrGwJdO9EF71EPbxna4QBLt6vRQtfT3XxnFDBh2iw6Dl+YxvXDvvywmkUa
         YDLTjwOt0QYLsW1EVx4rcoEynbdiFkwDYkwivssLqnLBExUdfAVY8ed8+o5j3InmTaWX
         3NquxYHGTso4tuaxSRssj7/h+EKFEaWIX4+virPL5LD7bDJq5m2wpqN/0WpLciAG2jc/
         aNKvG4Ktd8oogw0Vcu74iJDbPfA9KmbEzPjsdOwpmFtbxJPuW1eUxu3RgcYwlbLCX/ku
         YwEACdDxjq2IuQqxruAS+YSZ944cZ/nXuMuYM1YIlW1GsImCVC1/8KLZjqXcNPK0ELWb
         bGTg==
X-Forwarded-Encrypted: i=1; AJvYcCVg1Psydhkw/1YvV5ythTfUPySgyrt7D/0qulzbbE9H93JE1Tg5+ZPVr2oQOYaQj1muGkAw382AEU21VYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7HiZ2kxLvy5RTT1Uuyb6mI9dosGwTFhI7NczciiFRBqG3/gc4
	SWR6Xh1yK8b1N1QL3YYCln+jgaE/y7LzJLhPgEpOs32uXYTn63nMWNmqERL1LojXMQ==
X-Gm-Gg: ASbGncs5TrrQIuYrIJjBBqh5d51EmcGSAq3q4J4P4VoLBTJSwKttla6hvaep46BEFcM
	wQoVlQXE2nnTdARa24/Hbkl8E2ExsV1xN6aPhM1vcxnwjn1xGD+Ckxtg/p/FSsjNseKFcT3YqqI
	m1iD8jCCO5zu1jgh5uQsJWBXtKUN88tEW9rZnq8CT+2zqGbsFSjhBp12Aq7kRC0m/ocJfemPXeE
	2Gb4EEZr6kK2uZ28Dv/LKFKCWwsx4C0FKXpdDWGaDTZO2CNEl/NYihZGAJNiHZJddRosKRw0EEC
	dqBum3xESJAbDwNQKiSa0wPpQ2m+KaU+oqLhprOGUkgOjuIHj3IDa1uLHYjJpPh7vTUbhyFXw9I
	BEjzPnWdoAGPoBkNlrycHnKUIi+dxoZN9zQFppQHP5g8VEnrbqA606gIfaA==
X-Google-Smtp-Source: AGHT+IE7dLSNdxnS09UIaiZLtGTzBKRWFvjjxpSelV/vNcmga84rxmjNvK3BLMJqQyO32AXbSKfYAg==
X-Received: by 2002:a05:600c:5289:b0:455:fb2e:95e9 with SMTP id 5b1f17b1804b1-4587c1f7c41mr47125e9.6.1753467131632;
        Fri, 25 Jul 2025 11:12:11 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705377e5sm61620255e9.7.2025.07.25.11.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:12:11 -0700 (PDT)
Date: Fri, 25 Jul 2025 18:12:07 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, jgg@nvidia.com, will@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with
 get_viommu_size
Message-ID: <aIPI9xv-HxTPWMUp@google.com>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
 <20250721200444.1740461-3-nicolinc@nvidia.com>
 <aIDlsUvF2Xbdelvx@google.com>
 <aIEkZoTOSlQ0nMKd@Asurada-Nvidia>
 <aIEwzM7mKUI8-h9U@google.com>
 <aIKd1owebUNQeN1-@google.com>
 <aIKqaGMMpsIuAVab@Asurada-Nvidia>
 <aINL66r_1NO3Nx-f@google.com>
 <aIOvt+atxTQp57R/@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIOvt+atxTQp57R/@Asurada-Nvidia>

On Fri, Jul 25, 2025 at 09:24:23AM -0700, Nicolin Chen wrote:
> On Fri, Jul 25, 2025 at 09:18:35AM +0000, Mostafa Saleh wrote:
> > > > > > On Wed, Jul 23, 2025 at 01:37:53PM +0000, Pranjal Shrivastava wrote:
> > > > > > > On Mon, Jul 21, 2025 at 01:04:44PM -0700, Nicolin Chen wrote:
> > > > Had the
> > > > vintf_size rejected it, we wouldn't be calling the init op.
> > > 
> > > A data corruption could happen any time, not related to the
> > > init op. A concurrent buggy thread can overwrite the vIOMMU
> > > object when a write access to its adjacent memory overflows.
> > 
> > Can you please elaborate on that, as memory corruption can happen
> > any time event after the next check and there is no way to defend
> > against that?
> 
> That narrative is under a condition (in the context) "when there
> is a kernel bug corrupting data" :)
> 
> E.g. some new lines of code allocates a wrong size of memory and
> writes above the size. If that memory is near this vIOMMU object
> it might overwrite to this vIOMMU object that this function gets.
> 
> This certainly won't happen if everything is sane.

I see, but I don't think we should do anything about that, there are
100s of structs in the kernel, we can't add checks everywhere, and I
don't see anything special about this path to add an assertion, this
kind of defensive programming isn't really helpful. We just need to
review any new code properly :)

Thanks,
Mostafa

> 
> Nicolin

