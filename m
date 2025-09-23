Return-Path: <linux-kernel+bounces-829525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 018EEB97450
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA16D3BA4DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBBC3019C6;
	Tue, 23 Sep 2025 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yYjU2iPg"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B8E2D7812
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654186; cv=none; b=aHFlZ+OQCRvPk09lhxsb1c1Mih++925g3GaHp72lq9PEM5Q0ID/HiOLcRRM8GVen1iCI9cqB27M4bPv1p6/aKecocm7QOZVIv0ltc22Llh3Zz5imqlTKmJWBGzV+M0Cm1L18TTKJJRvWRJvCgXEqU6G3OCtfG0k/LYcMVG7JRTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654186; c=relaxed/simple;
	bh=ES8bny/uFKCqecBlbpF5uVtDNo2HFYQ/5ff0CMkFSbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z02Z1RSW2uYTZNfYs9mFAyVB0Kpd0kQCPKYLzpXyAtggOHORoWuUkKhBCHBVVOKzpxyEDoDJeRZ/+GrR0M5G5Hvl72pgJa/UkhKgxg4TxP0ugJDPLyudFHR7ZWzc5PG1dNsHMIG4UMwSLw7R77KwnwUBXi4O2UQQE1hvfYzULpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yYjU2iPg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2699ed6d473so38165ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758654184; x=1759258984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UOuC3zAW8kbxrBTL2TNiZ4NT6BGzG/ERW1AmxrJRhXE=;
        b=yYjU2iPgm84qXqgJQh9vqBgTDkd5yhyB71H31S3nN2zP6d5Q6FZT3OlQ6nlDWEkkZX
         r0MnqqvNVKYJxaavOF2xCDHLN34uv9fUImsrNY/l4QK4dZIxLJQaLxo7oQBsMvVNr84F
         aSROxr4WpY33VcAAhPcfe1KtnpNsSAKVK2Dytf6VtEbECXPyS9hH/n9LM+ItieNkfw2z
         4R6Is6CRsV/WxXRjIMzGlGArnopjSneX0FAqyyDR0q5l7ucEWGFuh/jTOoCKYjd4piVF
         ZEKRNKB/eJRd0MW1TrivqIwgSfHNruWGw2ZZW/+bW1Dr8KLx2TyQe+k/34AWafRT4WT0
         ZWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758654184; x=1759258984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOuC3zAW8kbxrBTL2TNiZ4NT6BGzG/ERW1AmxrJRhXE=;
        b=hF88gcByTCALw/O2+f9XXx8dIcAcuSn6pB9gJO2gYPYP2qjCaGiTxvOUy9iA+yptP4
         04CC7r4AIDLOLTgsRhrOMajcA3h6JXZOkUGmosAcjorfJmoSbqthf3Yf/BsfenfFA0p5
         bm1x3aD3eRSqkZcM41izs9Tif5PNqMfJg2/iI4VOIgxlP0qCj/EwBoagv/3FTiWakuAe
         tYiaB89P9PQoI8CLjm1veMbBQQAS94ebE1zovSUv0n8ADFuMYR2bM8GfvIVMO71dxlQP
         wbXfZToHBIEJ9NB5D03fiCswiqCt4hkBvTD+aaUe4EGGrjKrHGw1joEhcrTDAeFBJilx
         jjQw==
X-Forwarded-Encrypted: i=1; AJvYcCXppAbGeRkuB9lkJoEDa8K5e9ikLZTnHPqe4Ji6sZ4J/yt4HJiL+3NLLUuMBxB/e/MnDXnnY+0DsLxUOkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2yuaAtXhHq3J0Rl023udZiwO7S9ly+2YM6Fyzcf0IDyb+uz6A
	u577VlEzve8C6YLaFuu7jSgAYEJhoxXKIESfaox6tR0gZMq/NqB1ueXhxdL/Hfq8oQ==
X-Gm-Gg: ASbGncuuIFWLV7Zblu6PbD9sN1692JV2c4iqBvemWEtpsT0ldLx65Jypwz+YFsoU2vk
	1Ixq9nwmxlKC16Hx8Y8oUsJfqCOKWfBPGCsEyAMHR00xBSZ/dop9R35wQ2BH2QMKKL9bm0y2Wka
	K/xU3jRfoRRDkZujRLOAqS9VbtM/vj9TlPTq7FkgPpD0Lg5+lBfqDM/pTtblEXz5yD4AhGf4kCp
	XSVNrOGek+JAINN4jNRg7M7dYI8GRvUFkOBoW+vo1tA2UDGTBXjx47zgTYbfr52ZpL+bDa+Jt1g
	jA52b+fIZ9t8j1gOYFI8PRW7S7XhDgVet8eixwJGVyNavyQ3Smp9kzgWgihaldbMaerjnRlwAhd
	87vAut60tjpc2yjzWVJOfiFv+4u7Foc+F0NHIlNz1vtzZOK1iw8T19xva/VPZxCI=
X-Google-Smtp-Source: AGHT+IFRAqJuhYAhCis6IihkC0Dv0zYrlzWqXDH65c5umCcHF3NmW4wRGvNj5ih/do0Kdj3XI6rCjg==
X-Received: by 2002:a17:902:da90:b0:26d:72f8:8cfa with SMTP id d9443c01a7336-27ebf19022amr553925ad.13.1758654183589;
        Tue, 23 Sep 2025 12:03:03 -0700 (PDT)
Received: from google.com (23.178.142.34.bc.googleusercontent.com. [34.142.178.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed273e8fasm19914155a91.18.2025.09.23.12.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:03:02 -0700 (PDT)
Date: Tue, 23 Sep 2025 19:02:57 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, jgg@ziepe.ca
Subject: Re: [PATCH v4 1/4] iommu/io-pgtable-arm: Simplify error prints for
 selftests
Message-ID: <aNLu4R7VKkWNmvxs@google.com>
References: <20250922090003.686704-1-smostafa@google.com>
 <20250922090003.686704-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922090003.686704-2-smostafa@google.com>

On Mon, Sep 22, 2025 at 08:59:25AM +0000, Mostafa Saleh wrote:
> At the moment, if the self test fails it prints a lot of information
> about the page table (size, levels...) this requires access to many
> internals, which has to be exposed in the next patch moving the
> tests out.
> 
> Instead, we can simplify the print, using ias, oas, pgsize_bitmap
> and fmt is enough to identify the failed case, and the rest can
> be deduced from the code.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

