Return-Path: <linux-kernel+bounces-829530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333B7B9746B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B75B3B0AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A521F302174;
	Tue, 23 Sep 2025 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2s6vlHBD"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB172D7812
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654322; cv=none; b=rZHXOhR5VcAQtxwzdprgnrUsbphewS37vUfOi9x9JSn2rPYPIDf8wgYotnrprDV5mxuLpS38UJOG1/QSaFcEBQVemGsS2rwaLvExtqUIvJ7eICZNx8OoOVIE56WYIeMwiqLMyqVpp12c0c7yKszRi3byObZcRBULlJQuzOMe444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654322; c=relaxed/simple;
	bh=6iqS6pI/nww2nERtNHBGKjrRyseW6VXKyAN/ovur7J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqB79l2Zr+UzewV4A5QibCaqtjcd/gETqEsrn1h9zkFEtWvD7xYcWtyQ28mz6QVEMdOgYUxHxTSgpSwy2Me6DHcvdrkO2qV4NSgYCLEBvizAYGesBY+pKjUfMjLkxGMB/VHDIWhyOZebEQB3JCR8rlCevBAb2Fd27JKPnD0bW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2s6vlHBD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2731ff54949so34695ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758654320; x=1759259120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=shQ9F/S9E+ezjDmWjFc88/0zLU6nZIORFrqFjPoe6W4=;
        b=2s6vlHBD9zpZECNe9qGty+jpdY6aMul+Mgsr9s3OKTPQoQCswKSptetLaNu7o99wFZ
         yK1YyuegBjD3SFcBVdf1es+MLQxC2AkhblMiw30iUhce2MpM94j3XepBo3qVQygtvbjK
         TNOceOkoB+S14Drxk1nL+Ukr1ogKgICtV09YiZYw2Yh2aHtMRVCmChOooTheTrIHrped
         wvAUuXfoORsVViH2zShAB9e7mqfkFiaMXHAjkr2Xk935KXMf2j42M+EWJ/VoBSh059Mf
         5Y9m18lq82/Gav6QHAVIrwk8EY/F5/GMseNJKVyolLrPKaZt/MMiPnYny3N4Y7/Fef4j
         L6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758654320; x=1759259120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shQ9F/S9E+ezjDmWjFc88/0zLU6nZIORFrqFjPoe6W4=;
        b=Bf5ZN6+33jhfig8bvs4vFBM+4gxUIweYgv9NSksIB13qqaRul00OVp4CfYevhP7jht
         4+v+scQssH6dddvzvXj6nrqLeQDhGRUaHgDJHcy1jk6c1Rms5LqsO/zALV8pD2V9h2fc
         y87R4zOaZvbq6iD/htTQib4qVuVUTFrvmoILFCs0t6AgUg0dHXRmpqRPp/tKRDc3k0Nw
         YaA80/n5bEjdJUNnW8XUQs0KRMC+eOaLHmraBn60nUYbrjspJrPSZ2o0AjHi03QrCzOk
         Ht9tOyLNOR553OM4EXc8mt42+3C+IjAwy1+mjW0mku/RFq8KFBxmHPHXSL6OV2gCyEPw
         VC3w==
X-Forwarded-Encrypted: i=1; AJvYcCU5Z7f3HBEHkb9/j1QCzGcJm1FqqadvRyuTtzNvnPJt4SukwiuhD+H3+f8eEznoFFk1sDCUr1EFwR0kACE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1aw+f21wVOkrrtdr/95fnV2pOqusn588S47qocYjmFCds/Zt4
	Ikp2kYoi/4sFlF97Gaaw1seihkn8wt1gO+K088V/UcyjHaC8q8OtfAlFdj4TZZLiiA==
X-Gm-Gg: ASbGnctRvv8TkmwukLs/PPm7Tm4vJZQziSTru2bPowuv8QqIYwjBUF7EGXp786MPG/6
	JCo6s92ewCLOcaP9RBZjQ1/U6J13RYTHOB0ABPZsQNgpf8ICH4uHvB69Bf3B0k/9nvZvlTH4AtB
	Dp3+3VoJqwasft9riAd4Kh9qVr1TSLqF2NbQ95k00JX2TzmboUkZmz2nxdx5G/nV2e4ch3BrlY0
	NJMuGp5lRnSOyPGC5Awri/p4rStCFE6vlfvor093YP96xqYnOW+LxrSheKee4YXLoxCQLqknC66
	2O/H08n+MWjveAqD/R3D7/SnA7p0hcHzz8NVLGF0I8oGjMj+61o4O9pAIh++UcvANiT0mEn2OHx
	4P7UTirSuNbw7sfAkQr60AndYx2xsg6J5JPpwDOL3BClcj8gRxASFIwcl6y1YQmo=
X-Google-Smtp-Source: AGHT+IHVaOaeuEz2XAlC49A/lUlZuiYJ4YEiwzji5f5sfrXloiYMH7AkD2MYjlrCozMP/2Heq38dGw==
X-Received: by 2002:a17:903:11c7:b0:267:912b:2b4d with SMTP id d9443c01a7336-27ebf1b61a4mr578145ad.7.1758654319543;
        Tue, 23 Sep 2025 12:05:19 -0700 (PDT)
Received: from google.com (23.178.142.34.bc.googleusercontent.com. [34.142.178.23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b553d5b35b4sm8345090a12.2.2025.09.23.12.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:05:18 -0700 (PDT)
Date: Tue, 23 Sep 2025 19:05:13 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 3/4] iommu/io-pgtable-arm-selftests: Modularize the
 test
Message-ID: <aNLvaVHgOh-uS2JS@google.com>
References: <20250922090003.686704-1-smostafa@google.com>
 <20250922090003.686704-4-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922090003.686704-4-smostafa@google.com>

On Mon, Sep 22, 2025 at 08:59:27AM +0000, Mostafa Saleh wrote:
> Remove the __init constraint, as the test will be converted to KUnit,
> it can run on-demand after later.
> 
> Also, as KUnit can be a module, make this test modular.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/Kconfig                    |  2 +-
>  drivers/iommu/io-pgtable-arm-selftests.c | 36 +++++++++++++++---------
>  2 files changed, 23 insertions(+), 15 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

