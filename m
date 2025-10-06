Return-Path: <linux-kernel+bounces-843558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D69BBFB97
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 00:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACAE189DD63
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 22:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636331A314D;
	Mon,  6 Oct 2025 22:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BDZ4EHSg"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22220146D45
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759791044; cv=none; b=QeCRrPGD9Sv6y3fYXwFNUR6JEmd+px/biY44kmXhuyQXxQe2k2AUr4Zx0XH5sxxSx/jPsXpR2WvXj4/mzJeWwio1lJYJLz1dOKIQnJErmg54V4O2VUNsLJytCIJ8NE+e5fINlZq7ZP4yo+P7vvKIndkS5jf1DfdL2lU3u+gSzE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759791044; c=relaxed/simple;
	bh=j8RVgIHcecZ6vNuLBZhQD8XDmrwSGnwngJoxF/6sqdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJahZEeRbTwmCZi+OplCAJbhsUPrxhz0XxVbkbT23WiK6LwZ9HyvYjPC+tThd7L5zxW5tg3w06zTihtxChh7cLv3aedza94srCDg3yP8CZRVYKMEokFn4DgavNf8yjo8ygXp8bYKLDVDGUYtHHVLc6I0NEBtybKAtwiCqF/kF+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BDZ4EHSg; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-7f7835f4478so37546636d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 15:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759791042; x=1760395842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t1+dP9kjoBak9iuGOU/j3R1WyEWlKUJiQn+oDzUnB/s=;
        b=BDZ4EHSg5GzH1tetl7kQ3cZaQ9mXyBtsvsfVggmMC/04tf4tc/XZJERblzAqc78Pne
         DWmmdgmk1FnkYJfO1YUeva8PSaIANVvDo70lXc0kmw68k9Qrb48kBasy93mRY+8Mn+JC
         Cyu7R94047P4d6/2v3WKNNRFFNjEEqvJcRk0KKFjtLMwcvhSvtjEwhuIgcV/6qHXtJb6
         BLoAP0hFAoa1FFtk/BOUfPy6T3JXGA0kdbPBpiJ/OxYvUu38HXb+0tj0PWcvEdVtoMb+
         RPV27txRDPJGu6qvaxjCnSLu5bjZaFQjtnGPlRMfYTj5k5hSE6ZxZsQCDxF8efP/7T3b
         iM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759791042; x=1760395842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1+dP9kjoBak9iuGOU/j3R1WyEWlKUJiQn+oDzUnB/s=;
        b=V2VOy3ZADWKB/yLenKjFrtpy2dqITEpu2fDM7ApfevrHhiad89bGJcStItMAzRTik7
         l7UJN8yudnB4erFhpX2hIp8cTVuYZRjcvqv0Nd0fK0KmGjR/t9C0R7WuKVEH9cTb6CCU
         jVOFoJTQbvqC8znXUE6RV8kdTab0U8AwIITJpRBT1kCzcBNnfa2WKts2QVrR+0WIdgac
         Ug/dDY/jpdAmiIHgwaA1E34Yb0iXMHYD9mG/aOIGnXFZ3qm7N+ELFkV9XiAXrXGxpE6w
         I/ghYA/RRnMt7PO5BH3XV8L0X5hU4EsQmwb3hNZ5ad01M4rxX2pFCzst08BmbpBH2mE0
         LOqA==
X-Forwarded-Encrypted: i=1; AJvYcCWEU4gU4RdC2qM8tHaAYBo5s1A6iKACkAArmBFIwV1c31lj8k3B5qY/5SAYfruMYh0RifDnYzW05dF2BD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvPrllrbjn4+hNag6YJ09KbYn5lkl3055AndvUaCl72RHt4FGN
	q/FcDO/wtH+7RNaDj8vB9iKef0du5CKKiPmLfmjOm2jTbdgZs4yo0kDPhdvXf9CpVGQ=
X-Gm-Gg: ASbGncsDlO6L5YiWTQYmOSYdRG3+qrYf6FI+fj9YAYtzVollKJ+g1IdgZVOakIsDlE4
	Yy2cMsUuYEzI0JILK+7YCm4uDfXxbb1eJkmKwy0PpcaEgMHigGkpQhbO1E2G62V+9Mqf0h+IZhS
	ScXPLd9fjYlq/UnPeGbfqZo/osuuVFndcTAcU3kd7vhyzj+LdyZT5GhUq7hHlv3/zPURmA5B2ni
	ZODAQWg3d10Gkje7hAQXg/+H5EkBxFyrnUpwMTZ9VwWtOpGJi4zTmRzBQLjsh07wyhxT1iq/Rch
	i10KZWrgtkJyBLlnzl7HelByYoSin3hbPgqm3y9onOyStweabQ0LUKQaUXvk7p9do+tz03tq8X3
	6DjZoswsgwqJ1snZC3Z1y
X-Google-Smtp-Source: AGHT+IHzlobXG0MjkPJh2nGePMJSByfyR0QwUZj8yqsAUFGxRY2aOWeCzXWMnbZWCqE5GDBOCCvduQ==
X-Received: by 2002:ad4:4ee4:0:b0:863:5c7a:728a with SMTP id 6a1803df08f44-879dc869b21mr181258646d6.37.1759791041935;
        Mon, 06 Oct 2025 15:50:41 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878be61f6bcsm130119516d6.65.2025.10.06.15.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 15:50:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v5u2R-0000000EUgB-3p8Y;
	Mon, 06 Oct 2025 19:50:39 -0300
Date: Mon, 6 Oct 2025 19:50:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio: fix VFIO_IOMMU_UNMAP_DMA when end of range would
 overflow u64
Message-ID: <20251006225039.GA3441843@ziepe.ca>
References: <20251005-fix-unmap-v1-1-6687732ed44e@fb.com>
 <20251006121618.GA3365647@ziepe.ca>
 <aOPuU0O6PlOjd/Xs@devgpu015.cco6.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOPuU0O6PlOjd/Xs@devgpu015.cco6.facebook.com>

On Mon, Oct 06, 2025 at 09:29:07AM -0700, Alex Mastro wrote:
> On Mon, Oct 06, 2025 at 09:16:18AM -0300, Jason Gunthorpe wrote:
> > This doesn't seem complete though, if the range ends at the ULONG_MAX
> > then these are not working either:
> > 
> > 		if (start < dma->iova + dma->size) {
> > 
> > ?
> > 
> > And I see a few more instances like that eg in
> > vfio_iova_dirty_bitmap(), vfio_dma_do_unmap(), vfio_iommu_replay()
> 
> You are right. There are several places which would need to be fixed to handle
> mappings which lie against the end of the addressable range. At least these
> would need to be vetted:

Could we block right at the ioctl inputs that end at ULONG_MAX? Maybe
that is a good enough fix?

Jason

