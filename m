Return-Path: <linux-kernel+bounces-837670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 569DEBACE0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E053D7A1664
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402AA2FC86F;
	Tue, 30 Sep 2025 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BsXsrdui"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4872DFA39
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235924; cv=none; b=Iu0jUitamOvNHSlD/Z5clxLHmkh9ByebsD/Ta/ThdNhSDfqnslr5n3tu5Ouf9pQDVCahYCOb87LvmYPw1XaA/K+zJgOTKr9rO7i5QdoMZguzk8RB+cw1gghjcR8/pNsiDPaFpwhUijDNUq0+xCXUYV53iFbE9a9s8L6f7dj1pIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235924; c=relaxed/simple;
	bh=xV29DIU2TbOmuryVDQ1P7PnHetrjWHc87hnpdn8mfxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjZeANbDmRNIa0H2nT+vRDL96Xhs0C0YPaAA/90XaOA9vpooex9THaggG6a5TDkvqiQ63Z+hszLrww3znPf1Ymx/uQcMkz3Ni08atlUrLoQaJxNthYmVpKzLXHMvIz7PxlorzGR8PjGrGhkO+JinPUVkKLWmjw8XtJ6sHdsNLjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BsXsrdui; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4dfbab4fb0dso15889601cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759235921; x=1759840721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VBYh4sqVRv985C07Huopg2HBOyHMdBgVTsPZLDQuV38=;
        b=BsXsrdui1Erd035CTl2bigbsgtDrMwUEQuPs0uETgc7w8/XlwBM8SquvNuUwlXETVR
         EPZYC/nuZvCaWuMCpB2wqPt6K/1o5VQYf/zZMztcalUoGrb7a7AY0+NeGF3MTyHN/2Cq
         6CNRIYp3UiKZ0KwLJ8pqmYU3XBsvQFez1Y6bLcrVspz3L1ef9EytCrrSCaQhYRa8H/rd
         vS0KZ/UIJQNLhTuTfM5yus85JYJIq5gjONShTqyGMkLzG6/YV1YqPSqglHbnAG3K+dAK
         ofWwxSTbWWf/EOAnz/8+7m4KfCCfeY8mXCNBbHsKElaCa2FiYubr+i/JQ5tWdqLfZw41
         ySKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235921; x=1759840721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBYh4sqVRv985C07Huopg2HBOyHMdBgVTsPZLDQuV38=;
        b=xOo8Srr7npV4i9dqBF2UyhMy2LPyB2bNvEY9Wz13/bZ0jtrvYQdcoj+F4hVhdAk/aW
         cFqehC7MPaVCfAxUUwtlFF+HBWZiE/H6o0oBAQCs5oKx4w7prStiTuyKsEvlBhNTyKjo
         4zj/NXPedOEgLdwINBDwfI/0VxnJD1Gv4qhKgcjjyMOQ35YPF7fzLZkFudrxKKIwHD4p
         y0b8GzmVOLl2EhMS5A2CoBM9MGbQZt/iLqnyQo8KH+iLEpjsJl8tGaopdqmBGRzJzvIJ
         MyqNo7Hp1S+JZy4RizjMHD4I8fKDrYH2J5fkcpp2Pb/GDsCRj0hT9oQq0UgIEcuqXgA3
         LhqA==
X-Forwarded-Encrypted: i=1; AJvYcCWjPLlibY6SJe/g8YsWeGS/Akg6BmIIrx/CisnPgAcxUHMWVHgWCxMPxVI1m/XochKVoxXKWfMTqQAnYnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAYqvq+7yR+i9E3M5xvulLm9dLiveiSIq+bZqZmYyQfvZ7WZ47
	SeTV3T0l1OeonOjD14mbq5wzOlsvgEho7eGKvBnsKbVinzMiq9IObMV/JGllQJXXhR4=
X-Gm-Gg: ASbGnctW7SXqwTEqddyp9VDP7NR3QmeT4QwfmgKttNOTxv1h3+WHyP5HgP20kDfXMMr
	L+BrtXb4rGRbI/ob9rnfGLrmfhllmD8w1bt0xM7G7LZGCEIaNgPCaqJL5Gfe7vp/18fXeZERTv0
	DzTNyCiO8dvqcg+oicotkxkFUk071Uw5ixOD9lb55HEiLjDu5QucjNKUqee17ypIEES7Gn+wON1
	InClf8SET8kRXmZ2S1Z78HWCbJBnN0kHqphEA/EP2pu7lv+YKsRgK5QBW3kAEfmUFBaG3j3hPqQ
	r8C0CcQrKhHS7YqRfBhm+barwPKrFoWbfjZpVOvjRtTV/RYq26sYSna0T+GDsd4jYpMnv8qOh5N
	/g09/UMR8wztO6fXefB1NhykB5kBvfoCaZtLQEzkrvA==
X-Google-Smtp-Source: AGHT+IHgKpbQVt29fnjPpYGRGvSeW5uUhJfqcsuhp73OzWARyNjA6lxGY/bFMFic1Y10TeqPQbcyEw==
X-Received: by 2002:ac8:5c88:0:b0:4b1:247f:4e0f with SMTP id d75a77b69052e-4da4cd41ec5mr281429761cf.57.1759235921370;
        Tue, 30 Sep 2025 05:38:41 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e34ef75712sm8696611cf.7.2025.09.30.05.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:38:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3Zct-0000000CWSm-3Tg2;
	Tue, 30 Sep 2025 09:38:39 -0300
Date: Tue, 30 Sep 2025 09:38:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 10/28] KVM: arm64: iommu: Shadow host stage-2 page
 table
Message-ID: <20250930123839.GL2695987@ziepe.ca>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-11-smostafa@google.com>
 <aMA8vz0v0Vn-02QP@willie-the-truck>
 <aMlzLsj5slPQhWEr@google.com>
 <aNamXlTErXDs1K8Z@willie-the-truck>
 <aNpm9odmzv__2RyA@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNpm9odmzv__2RyA@google.com>

On Mon, Sep 29, 2025 at 11:01:10AM +0000, Mostafa Saleh wrote:

> > If the SMMU is in stage-1 bypass, we still have the incoming memory
> > attributes from the transaction (modulo MTCFG which we shouldn't be
> > setting) and they should combine with the stage-2 attributes in roughly
> > the same way as the CPU, no?
> 
> Makes sense, we can remove that for now and map all stage-2 with
> IOMMU_CACHE. 

Robin was saying in another thread that the DMA API has to use
IOMMU_MMIO properly or it won't work.. I think what happens depends on
the SOC design.

Yes, the incoming attribute combines, but unlike the CPU which will
have per-page memory attributes in the S1, the DMA initiator will
almost always use the same memory attributes.

In other words, we cannot rely on the DMA initiator to indicate if the
underlying memory should be MMIO or CACHE like the CPU can.

I think you have to set CACHE/MMIO correctly here.

Jason

