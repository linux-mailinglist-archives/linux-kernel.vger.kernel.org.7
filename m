Return-Path: <linux-kernel+bounces-829529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766CDB97468
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6EF321694
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B7E302754;
	Tue, 23 Sep 2025 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XK6Et3VK"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E022DECBA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654260; cv=none; b=Us3857QSSHUNJAVQhDlpkH0QXE96Ac7I1NhUBiFE4bk5yiq5+Yy+WH2iSmIhCxkp/ItWApeovjfTrvy/+V9T3zQKAcCJw76PXYFvf5ES16LYEDG8oDi6s0VEERYLuIJ2YVp7TaFTTFJihpcHmnFgzFNoPb3ujvRqE6VFSqfzfGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654260; c=relaxed/simple;
	bh=y5XKP/EZOwx3lugnWlSKex8y0sj0d381WUjpO2U3VuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdT8pBhHk4TuCmwegxM6DXCsEUoPosbTJLjZ431+tzXv33GEijEXVEDau5NQi9rGMVkGJRnX3ddz7bir/zQAzUOVFKyNc75ARp6ll9CVx/Dm2EOzqKx2AS7K8CBHZIU0hUeUvEMbEaHVjzDvJW2RnT10ITG3tLUOlGYXU62EfX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XK6Et3VK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27d67abd215so38315ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758654258; x=1759259058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BVuSRD80cb05xRP8eCjDZvMC/JNrybFBLhN6uiPb/HE=;
        b=XK6Et3VK7XQ+8HzvDDdRExT65m8rmL2qwnDvQ1OXCIVqgAmgeczF6DnmRz3AzeQ1P7
         scmCNgf1t5woei6XQHmMJLQVISLdMJ9srfvf9LljWB8WnoQNNDjxyP1UShWjrwKU8S9E
         iBPL15kZr95l9bHeniPf5WOOvLpgzUv69zozMHNokShKavzqI97By8RxkYSOKH3t4lFR
         mgHREobfqVlbTy4kEEpmzifsO4taJPQL0PJiOj1iiv3VQDBg7w9n6Xw6tNBGB3yZ1nzq
         4cPlCIPeNq5fmsa76x5poUEVzoxZmEKkyutxiItrzrpmqmiRafjSUyP/VU0VENRM2Aht
         ggQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758654258; x=1759259058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVuSRD80cb05xRP8eCjDZvMC/JNrybFBLhN6uiPb/HE=;
        b=mM1lnTDbsfe1gu4jfVrKSeZXaLq/OkTrZHNj3/AUupgSgORQOGIxODXtC+95ogJxtP
         7FOTSUalRUP1opdPg8EtV6xyrFBbJctPLv+5yd/FhSbYQS4LIteiVE9tz+9oxTw8P/jY
         3xKJT2TYM8OTz81YEQCi/1Iac31JjlO7JkNq8zTtzPEEMFrVHrfMrV4qsC6jHf1PZp58
         HLTTVOPkoBmOq49X9wmJ0oM91j2CW34GFeUBgGNLo7SQZpFXZQnWnmByezor8ZVvyTd1
         Wg3ywCN0CM1TK9AxCUQayAigM6BLTQcK8waNO0LcRRp2ViTG2iXgWRamrHD/1xtxyl60
         Foxw==
X-Forwarded-Encrypted: i=1; AJvYcCVYRQ6UUYMpBMf7uQ48c3TwIcv1oXGYc1DE7CxF39CIjG9wQ1W543Ij4MooSCiObkmJ7fwWD45NG+rnaVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmAp3H3tw9iDRvKf7UKNXM5+VJUaXAzoiH3JeKKzVBAneXCsKE
	ayhk1lHWwywGpuuqXha6k4Gumt55SwpQerebNNL+jgk9+iXfBuHsDRfhL3lE2iTt7Q==
X-Gm-Gg: ASbGnctocoCM9Rj08ONP3JS5KepoAURX2Kr/chs2R9H3FGM9isAn8keZpvKxKrI20/Y
	vtj8Ej6aSHamGef+Ih9oamZ45UjVO3EYV1MEDmeTfMia8SjtkNv4IY7w/Ejaxxwpmn4PC25p2+4
	bsfcFGunWXD79CEIHZP6HuS7FaJrFl1wMTPtRyMMKTswcJdPBCqeDIqhDil6n9EI/zHYHbMtfRF
	beJZ86EKpP/qqzOZ31pg4TuOpO1P8sdV5y0XFyzg409sAVX1lGqHs4oVUXC1w+pYyN36Sc07bfn
	nXWlEuq6hryi989ow8LBagBJ3uzhtK8+oJjNjyw9xgcqr13GJuPuFwzCGmLyRVUhYHniKOq3Q2r
	BfYgeqeOfdmhjrlpqDE8l1Uaja6ItURrvgNP0/U54p6tvYyJMnELvEWhmKzRcedM=
X-Google-Smtp-Source: AGHT+IGlm3sxbw3MtGkL7PIjJGczzrrl/P0p5+02K7dTiPLCrVjzmQQzziPhIyR/5DAW3Upq3GMMIg==
X-Received: by 2002:a17:902:e809:b0:26e:ac44:3b44 with SMTP id d9443c01a7336-27ebe858bf7mr777395ad.10.1758654257284;
        Tue, 23 Sep 2025 12:04:17 -0700 (PDT)
Received: from google.com (23.178.142.34.bc.googleusercontent.com. [34.142.178.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306085e6e7sm16766873a91.28.2025.09.23.12.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:04:16 -0700 (PDT)
Date: Tue, 23 Sep 2025 19:04:11 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, jgg@ziepe.ca
Subject: Re: [PATCH v4 2/4] iommu/io-pgtable-arm: Move selftests to a
 separate file
Message-ID: <aNLvK2xW7f5ZNYt0@google.com>
References: <20250922090003.686704-1-smostafa@google.com>
 <20250922090003.686704-3-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922090003.686704-3-smostafa@google.com>

On Mon, Sep 22, 2025 at 08:59:26AM +0000, Mostafa Saleh wrote:
> Clean up the io-pgtable-arm library by moving the selftests out.
> Next the tests will be registered with kunit.
> 
> This is useful also to factor out kernel specific code out, so
> it can compiled as part of the hypervisor object.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/Makefile                   |   1 +
>  drivers/iommu/io-pgtable-arm-selftests.c | 208 +++++++++++++++++++++++
>  drivers/iommu/io-pgtable-arm.c           | 200 ----------------------
>  3 files changed, 209 insertions(+), 200 deletions(-)

Reviewed-by: Pranjal Shrivastava <praan@google.com>

