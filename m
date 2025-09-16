Return-Path: <linux-kernel+bounces-818827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C768B596D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327CA189F5CA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DD52DC32C;
	Tue, 16 Sep 2025 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hodTZTSJ"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98091A5B8F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027765; cv=none; b=OzZkUr0Fzl6hfjVAgj1OW6wrWPN65FLbZAUzoza8mj18PStXyoFV8WsomEVNk4zlW4ahdrIkd75a+VrDVt2bs4dzVyjGFNhLkL8WRDD/Ays5V2jtsaSYSFUFCjBize6Txp8AcMkfJBIh0XaTZDeqKtmrMrGdE+OG4JfJ4Jbilfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027765; c=relaxed/simple;
	bh=IHIAB69PsK7W4sFK9/F4t7y6OBjeQP7F71nwjhXw+0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEPk94s70+H3Ma492dXwbOkWUgW+zKhJ8xFa68hFQsuAiYBxGpqHML4iXtr09x3vmdwITCgZ+AVo2rua4cf1aMBmX92Yoz1Mi6QrDK6cGHjThwWbw0LNWwOj8dj2SmsCxemjnpJMtAEWDlTx7ztyscWB42BC0B+1nd9LdOKkURs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hodTZTSJ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-829243c1164so241712285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758027763; x=1758632563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U7XVbefYP1T9aC1YC53q5bs8AZBmUU9WkTWwN/oYv1o=;
        b=hodTZTSJs8Lw87itDVipky6dEuVVSyrKLE+TY8vq+Hkc07NqoFFOw1cysd1SNKWdpj
         94NulaugHB2ne52+iiKvfmksKCix8MkyoBGc7jFmFHEJJgZaQwAOD5HiwW9oObzXKHm+
         oiAgkGrN/O2dCcinzQqsgtuIBV77UuzDERTD9nhODL4ix17V34zmMxEPe4UC5TKtQ8dK
         leHWl5Kg0o2QdCTxftQxqB/wsE3c7+A9aKp5Li6ZKz3PGp8LMjXIEgM8tKgXj8J+OLHb
         ugRI/j3pd7YbkV17QMU77zHQV18Fb+fnVXkDpbY/gUboJ8P0AKCeZJ6+cCXo+FkRqKC5
         mDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758027763; x=1758632563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7XVbefYP1T9aC1YC53q5bs8AZBmUU9WkTWwN/oYv1o=;
        b=ozEGV9eyqXEpLwtYNIHy6Kbfr56Qc+C8pUylQtLosNSL6pgKs9aEGDKtsCOoWoJRYK
         vK2PF5G0zxUzO7Ly/uR/r+5zXsocpqd+XVTDUsr07HxVnM64cm+tj2ApXOTmrhf6hth+
         z1N3fuqJEUh64IXKtOD29D1/rL3jXbKlgdOsm4pHAURkKAn3upYmQR96fi/n1NReGpPR
         Gg12gdN8TpsLQnLQPN7d0iSDAvNUEvqUCgPwJTjqcjeGaK9dR7LHC+nbIi+AaiFtT3ZO
         rmLvhngzMipnq00PfopVWzXF9oP7w+koa2I2y7C2scd3P+DXJgeNfoCGk5iWzSt8rDhU
         Bizw==
X-Forwarded-Encrypted: i=1; AJvYcCV8+nUR0ZcwopOxcZLw7nqikQt9qCYBD6yCf6FsOhGVyn1Qvay4+A/sgRLSs5hCaNSs2klzFEqRUZuV4Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvQpBA5kXM/lzoZ5PzeQw+ATzOv+RT4KlxnKv29qKm8y5Qj6HJ
	/RpOvEOsOYWzQI3OKVVtarGD9MwP5EGUJPC1z61mdfI5lJeZEqpClEHZ6DTyMvs8E1E=
X-Gm-Gg: ASbGncvs8zPPJbnL3iiRchGCDvdJcYLAfxwuzdPMFgSPz8TiyLBDVC+sx1q5Dms4jOQ
	vNvY196UbvnZTS8Z2VoahBLsyz0rRTGB+CXReSP8wUqZMhqA4a4nzTI8XDMVpDpZatGsm3u0UsJ
	kGubBUjAMilJvUxE951OUpy7Ar6mWDgXh80+LO6ygNyKgXPYzIZCJlrlFU7d4wrAD3xT3t3VIJ9
	1BqlE6oWmN6lrNStMAaHp0MibpXRv7X4HYxDZm9GAIAj7oKrcI6WokJWAaAiD+aRuMyl2UjESQ3
	bkGhiQKK7AQWOKA4DMN5EAoa/2fLXVxrSTCO/uEDUzcuQRSLiBRQX1oHaubqSBAuH+SbXzrF
X-Google-Smtp-Source: AGHT+IGgSNjoagg9mR50jyVvqVknWt7pO/h98DmCtfm4l0bnsXbM49f7ZWlU8/4EiRAMYAi5HACKDw==
X-Received: by 2002:a05:620a:a483:b0:813:4da8:8653 with SMTP id af79cd13be357-823fc1d4cb3mr1861079585a.25.1758027762539;
        Tue, 16 Sep 2025 06:02:42 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820ce19d151sm932484485a.50.2025.09.16.06.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:02:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyVKS-00000004ePY-3X0g;
	Tue, 16 Sep 2025 10:02:40 -0300
Date: Tue, 16 Sep 2025 10:02:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	robin.murphy@arm.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, heiko@sntech.de, p.zabel@pengutronix.de,
	mchehab@kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com,
	linux-media@vger.kernel.org
Subject: Re: [PATCH v9 3/7] iommu: Add verisilicon IOMMU driver
Message-ID: <20250916130240.GO882933@ziepe.ca>
References: <20250911155720.180465-1-benjamin.gaignard@collabora.com>
 <20250911155720.180465-4-benjamin.gaignard@collabora.com>
 <vrngq76nnms3jyl5hnxqnkimjc6kil66o6fdyqn5vm3fpovmja@cfynipjw7ktp>
 <694b9ba15cd67f41a38f4a65a3811f035cf8e99d.camel@collabora.com>
 <rt6nvgazcl6mvyy4iuut3n7irf72t7rex2iwabbkuxp7cdvez5@2nanenqgxjdy>
 <20250915225806.GM882933@ziepe.ca>
 <aMkkYU-p2ouknnAc@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMkkYU-p2ouknnAc@willie-the-truck>

On Tue, Sep 16, 2025 at 09:48:33AM +0100, Will Deacon wrote:
> > I would strongly object to trying to share map_pages, unmap_pages,
> > iova_to_phys, free and other iommu pt related functions in some
> > limited way instead of helping on the much more complete iommu pt
> > work. Which is what I said to Will, but for some reason he suggested
> > it anyhow.
> 
> If the answer is to convert this to iommu pt, then so be it. My
> understanding was that was still premature at this stage but you know
> better than me.

We are waiting for reviews, hopefull when people return from
vacation. You know how hard it is to wrangle people to review it. But
the code is all done, it has all been tested by multiple vendors now,
many people have projects blocked on it.

If this duplication is really important to you then you are welcome to
help review it and merge it. As is Benjamin

> When I bothered to look at this driver side-by-side with the rockchip
> driver which, despite apparently being totally different IP (honest!),
> is *remarkably* similar, I summarised the similarity in the default
> domain ops:

Presumably there are more HW control bits in the PTE than just valid
that we don't know about..

> I don't think it needs to be one or the other. afaict, these drivers
> should share the default domain ops and if the page-table code is using
> iommu-pt then that's even better.

Refactoring rockchip into an iopgtbl, and making it work with this
driver is quite alot of throw away work in my view. I would not ask
Benjamin to do this.

This is why I offered the compromise that if he writes and tests the
iommu pt version I will carry it and he can merge the driver
as-is. Hopefully in a few months it can all be sorted.

We can then attempt to convert rockchip as part of the followup
activity to try to move drivers to iommupt.

Jason

