Return-Path: <linux-kernel+bounces-821575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9880B81A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA6346294B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D1C30B50F;
	Wed, 17 Sep 2025 19:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="L4IYsLRz"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A318D656
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137981; cv=none; b=VjLJpqVDFvW3+UallYkTecyoEKIhoPcNuyqFfc4i7aV6B5271alKtAZy2cm3KdBCKzAFyLhN2AgzuJsWg4SnYuY3FpsFsFH0700Y9gta4Pq/OgKQD1RMhG3LJE7t7S61ztH79vq9vhTyD4ICD2bbfGGcP994IO4HalHb7YczyOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137981; c=relaxed/simple;
	bh=+QnggltKchDLGLemYARPWxsrB/q6KzZjJCOBzPmSvqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EopDntjSHsbbwc4LvVQlAQXD+D+9VcFdYXWgZqSm7SVmrZf+g5CEgz4+aMIBpUS6JP1NN7FSjDmYhYZM9QxRX+rV0D6rtI72Vq9a+bhNOs9c9lQk8QS4t6dWoegSGSfIcRvvcbGZL5Z0XOB+ye8HANIpVD4z07TC5chpdey92/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=L4IYsLRz; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b61161dd37so1321421cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758137978; x=1758742778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=loCR1eKtWPQr2AOCV7oFDbaaSxP/4srZDyqT1RiPxjU=;
        b=L4IYsLRzVhDUPxlEZAd3uaUTqyb51mW3hSSFrLGcEHjNZxkEGsYCcPj2Ly5P61+v5f
         GQuwpVNGaJpznMf2VXx3D/JqUk2KqZWX2yVJJplljjvBLX1wjRG7u+64q7eYUWfEEkTD
         FNuSlvu7hw8IAJkAGtsn8OjLl7nfxGi7ltMlHew0JXheW7e4qJE11wMruO8C4m/V1taI
         ddkn+i7Ly4K7VxG7iaOVFl957p3ey/Uc5iNA4rtNfW9m+qRBGNIi97cIP8z4xg6CJZiC
         BVE4hqdxhbvWQZii+bbGHIJkTJYkpjAEjg2Q/ilAcE6h5bpwRvu7lqCdSfeFTvNevAOs
         fQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758137978; x=1758742778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loCR1eKtWPQr2AOCV7oFDbaaSxP/4srZDyqT1RiPxjU=;
        b=HIR4ldm784n9gYEO9C6gBzu/I7Dp36PGCPheiRfoQ4vrg9UyNvPe/UA0iIPasUptB9
         jyuPqc+Tdz3UeXf1dqw3me8hrzwBrnEObnoiqxKKfKRn65oCIDj4Os/IY3mdk4ujUYpC
         L+ZKtOccEeotAdJTujpd7o+brsLM2vEDLqnLpQTXQZlML3Jm4a18nJPmNlPLBeHhifmF
         vx6TNl8CR16aRpYY57au5MOcqEv+unmfaQ0R2MaPguEmtYiS39y4H6HRFQvGoOVv0sv1
         z/5JKr1hbM9jnMLlJB7gU+nvLrgKKWU7VA/yNfKI+q4T8/pT2mq1VTOXCIJtPOZNQ0w5
         yKsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVltS05cM4D5E01FpK2HgdpJCT+w+kc2qSYmV2ROFuC+uPX/szq9XDO0/VreXhLQTkjI4904nuIwiGceHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3r9pKyr5JJyXoZuAKbDEtD6oGPDMI68aBh+xQqz1DQ2+dM4Nc
	Q6jC2qnyURYXLhSSuS+qeR22ldKgf6Y7IAYDPUWpkQBFdsSGAH0N7/cZ7iYq2xYZf8M=
X-Gm-Gg: ASbGncvMy5NUshWF3DjIvbNm7TE9okXdJm4NSdRyhcOYY3Tr3+Wpg3lnjD2WhfFeRLj
	IXJ3N69VKBDiAGobPkDjz9cR4DQJkMwObc1vvS+3DatY8E0S4R2iYLZ3B5dE9ZzAIQayq/dn5fz
	RmOfEZ1lkkhWj1svCfmliLmQPIitzX4ZdMXhQ7VBHG3HdeC1RLzXarAM2LLlttqRBSruv9O71ve
	svS8Q8dGM3eYgkAXWnSvu988D/IRW6cNkBleOAQ9j47Tk7Ft5KtXuErB4U3oodXko/b7qGdAOUZ
	TgNQPJ9t5V9Ik5qeqOcGKXhw5R2aO8QaO5VYqlpwXvx1XYRVEFoA3ZUNeM1iHt9dC071gVKbdb+
	qW2B0dquaNKwZhstmLfUru3JDASjQHjXwlBzW7Sf4G3s197KA1VeGPKmCKLjfL+hwq2dAailNsl
	EdLAdwBTlpaEc=
X-Google-Smtp-Source: AGHT+IH8rddOOuj2183qpUVyyVFif6dJ3P2j8BhXdLVsUERS6zel3c3yU22dws8RNYbBXoaWy5oC5A==
X-Received: by 2002:a05:622a:5e85:b0:4b4:eace:d0b4 with SMTP id d75a77b69052e-4ba655fa244mr47322681cf.16.1758137977567;
        Wed, 17 Sep 2025 12:39:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda86b3cf7sm2702201cf.29.2025.09.17.12.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 12:39:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyy08-00000008n9B-2ccZ;
	Wed, 17 Sep 2025 16:39:36 -0300
Date: Wed, 17 Sep 2025 16:39:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v2 2/3] iommu/io-pgtable-arm-selftests: Modularize the
 test
Message-ID: <20250917193936.GL1326709@ziepe.ca>
References: <20250917191143.3847487-1-smostafa@google.com>
 <20250917191143.3847487-3-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917191143.3847487-3-smostafa@google.com>

On Wed, Sep 17, 2025 at 07:11:39PM +0000, Mostafa Saleh wrote:
> Remove the __init constraint, as the test will be converted to KUnit,
> it can run on-demand after later.
> 
> Also, as KUnit can be a module, make this test modular.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/Kconfig                    |  2 +-
>  drivers/iommu/io-pgtable-arm-selftests.c | 36 +++++++++++++++---------
>  2 files changed, 23 insertions(+), 15 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

