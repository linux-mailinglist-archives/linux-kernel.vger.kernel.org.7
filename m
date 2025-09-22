Return-Path: <linux-kernel+bounces-827310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ABBB9167D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB0E1898A20
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A58309EE0;
	Mon, 22 Sep 2025 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RKXVOPxb"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35CE309EFB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547839; cv=none; b=P6sYMtHmsQTNkZauRCjc8vtaqmuPlPLEvda9OW3nSzmQ1MIzHKxRheOZZodSEv3DmPtDQuSXMUUhCDXPOEDNN22JwoT9zbgxnyurtbo9KwLqjzdbcMKQceJnOU1xLuAvfeNoOfpzU0Z+Gexhos/im3nYrSvp9yg5bqC0+iinzik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547839; c=relaxed/simple;
	bh=cz+EppApwySK07uus2Zumno8Nob1vgha5YKDQXFkMI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jE4TLFJ8f2gyhljt2lfLcbJ65Rpo6BlKNmpy4e0f06sQq2Z1mRLXzMiqtPCTIQD+bKxBEk35tzQv6X1960Znv/eZE5Z9BLnD/JUDKw8g7c2QcurodRTCs4cdJd5aAVA6Q5BcXwb3l/lOQN7JTkIZ8355qiwoJSuhxMPFF3iUgeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RKXVOPxb; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4d10f772416so3381531cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758547836; x=1759152636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=soQDxbku75wcKlRQCmyQHwxlcohTMFfAqg+ZHNumi64=;
        b=RKXVOPxbV64a7WhmtZ2EJFLDVvX3ZQT6bClL+vNETYssUy6U8Ye63KWdGbIUx8/wFu
         VDdawWs0SElv4G9WJkWb0JBNuLY+nt+x969UXLoV7TQCxBh1g9EOzi7zC1CoqgbQhKbm
         umjRSxJuYDjEn22dKxgoFrOCPSUB5rNGFGOslh4dYj6uaRFTwq6Q4Fkm9FRRHQ1W+Xd0
         XhSSc9ZrYWImj17Qi85oJoi247N3+CfaKThnlS2M8cPcW8emS8Qk7oeZWgSrusb9R+5H
         QArVd/mNOZ5Sa7KHFwb4ar1X9uCus4PdKjJl7SyZzCcYGkwh+5Xil4SlC7m4+rugQxvG
         0MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758547836; x=1759152636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soQDxbku75wcKlRQCmyQHwxlcohTMFfAqg+ZHNumi64=;
        b=A8fHzZZzSO6pHzJB9t8a1QIhhSudnzqGbhpgQVtfxCQR+wUDiknASrkBz9YOJC5TJr
         G7NDtMl21r9vlGBmxEo+E++HSKLkW8GCG8WypEzKXuXR7LAtsacpqobi2ckGmasIiwMv
         pmjJrDYHoq3GQ5FtcUsE1+rWH3y6tGlucUA2qwUMO4ReA38IMiWwyQWjjgmrTmwEmI3W
         JffEsKEkKq0dw9O++TL0iMDIwuniDvenN5+6XRHCoTwIH8sZEiXzp3m2AP04YphBq89F
         iNQRbnHs+8Bas8IxebipcYaUsGem0rcihMlZdukDORVQzFmELm4ifw1YVyBoxKAK+cGW
         LCSw==
X-Forwarded-Encrypted: i=1; AJvYcCVguYj6QwTThN8u4RRQTNkeQnPWhpi2oI8CSmxmVFld1qQ3zzRPQ1uBX5Qgf/JNTrPJIVw/JpNC4idGZjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVON8I8NIlvf2znjgb1PIhvZW0t/hPuLySHTqnNBaacn4jtwo5
	xUBYx7q1coJDKb9QdVKMmTrVRLDL0yCQ87gR+0fZFfd0TP8dmb2NXGyfrbymhHOPRW8=
X-Gm-Gg: ASbGncugztjc9K1vPUJ981p+IXmGuQ6aBAKxQokbX8RseeHKTa+AM4dB9VvdfVtX69e
	+9oGl3NckJ6qeyx/DQ13tRt5ulIu0kj3/1LAgPsv3bobQmzctPbUN4bRD/TFVWR3OkpxuXYyaeq
	TUkP/9kr/iqTZ6dOR5N1IIi0TCf3NvIgLStO/ZsuQy84d9HCln+t18c23NBdY3OFF1B2GX9kT9u
	t7OLXcjMt3L20zVhngR4zmvpyQ2gpPf3POF8/GvSKF31laKwK33S1vm7u0LyJ+/lgLbBTaBEhAR
	RhdOw8Ap7Z9+gfUbpFFOZ/xVRM8WDaj2mSRvc21jYuANDdufQjzsbgznXmjSkS91pbg8c55f
X-Google-Smtp-Source: AGHT+IHe9wJVlHUhgN8DEQ7hhP4hzex9JskPCNLwwhsPxRlegpEsHbuCwvoIfwhhlPGANj3noJQUlA==
X-Received: by 2002:a05:622a:a956:10b0:4c4:40dd:2855 with SMTP id d75a77b69052e-4c440dd2b41mr79485051cf.29.1758547835584;
        Mon, 22 Sep 2025 06:30:35 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda25aa5fesm70078611cf.18.2025.09.22.06.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:30:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v0gcj-0000000ALyq-2nW5;
	Mon, 22 Sep 2025 10:30:33 -0300
Date: Mon, 22 Sep 2025 10:30:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v4 2/4] iommu/io-pgtable-arm: Move selftests to a
 separate file
Message-ID: <20250922133033.GZ1326709@ziepe.ca>
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
>  create mode 100644 drivers/iommu/io-pgtable-arm-selftests.c

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

