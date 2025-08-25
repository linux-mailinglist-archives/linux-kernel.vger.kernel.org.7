Return-Path: <linux-kernel+bounces-785254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C37B34830
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C073B2A92
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B604C301033;
	Mon, 25 Aug 2025 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AePNfPAi"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D821286D75
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141538; cv=none; b=BhZRUu6Hs5qaAMWwIg/HHDuXzp97FSJ0GoqLmWQEAv4x1CvVnaEpxqQKvnP5upbbSNOEOR+DLnDBFYvjyrfoMNSAg6qX5ixiajMTNlT/hVBo6yrH1bXfzB218Vw6EmVBumsOuCYXEJmmUUqG0mhqNPnCoDuWFx91M/SwJIh5p0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141538; c=relaxed/simple;
	bh=LRBN+7pVsfRX4HBnwza1vs2Vuv7PT4DxF6o0fSGauMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8FNsUn9pkjvJ6j+lByLM86VEILTDU06Dn9gAJNm4uM0VRA/R3ENaVlBf+i5UNlGLdNerQ3dBpKq9U2wcDz4RYgzq9EkPC1GDRXYPL/AixVYaM8wADMAhXZTTi7upqF72GnII/6nZP/YzgZLkZXY89GbAR3ZCMh2/AJJPpdahIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AePNfPAi; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70bb007a821so60140206d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1756141534; x=1756746334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z6KxvMDzVSOwTyVOOifum1zHj+Q1NMnnZSanrfOQhBQ=;
        b=AePNfPAiZHUrBQkdhVEYcZPjYCX34plUwDXEpYwcQm+IGYN10n5ggcIsJsK1Ct1mtI
         TGb3lEJQu1Sr0ctftFMrxT+jZbmD487PKLnWG9MzSmxiuknk5blGABSQo326Ek244IV4
         3ScUjs2cXw2o3zFXjcUBgeL0tJpxaJyanY2liURl1UXgkjdKMuZvoWDBDNacHHd74W7n
         8HrcP7nJNsov8jfC1Y4l4rfoSOAVwvglYWs+IOatQWdrxZJ85eadjOYtiyACNKg/mVvc
         JKqA3jW5mXIGcIfYbESJHAzGGamzGv92sNOqQXNDcVwdJ3evBdkK124CE0ZDw5bvZJWN
         biFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756141534; x=1756746334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6KxvMDzVSOwTyVOOifum1zHj+Q1NMnnZSanrfOQhBQ=;
        b=boLyhRL5+4JTVz1bV2Mmo0sa/mIyn19sqDWGNb+EWg6lHb8PqILRHLFodAuFA2lTJa
         wYSjIW/vdFqt6vyasUaLrrRFNT10xxopV3jirXCPpnT8PzgfZ55DM3RzCilHOvbZcQl/
         +OT8eJONyWHPuFlnVLmd/xOOEPG9ihxSDZxuROr6J84xdQye/OhmppmONbZezrXwML2P
         2EbHutWGml3z3KNHLjxN9pmblhrxZLGHTKa9c1V6TB/9ubufid8ZXnGr0EQbsKGUQHY2
         E++cLc+LNK3r8jdwcckGLAOrQ2+2xPAmHbxNmAWLd8mxh43z48h9SYHkqGruFLVCN/KE
         4qCw==
X-Forwarded-Encrypted: i=1; AJvYcCXNFoj4jvKPw5Rn7K0oXGWr+rpCsyUMDF0iCbp+pQsIr7KqSWRmtgtLXeibZedhCGmRyBBfiMG1DUud5wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSvGl0unz2fA46vz1lmIkZGFR27pciEWZTR2YrjnEj8Nidlu5x
	85wwhvl2otnPpexHDpzHgkPLBBOQzXRBXrguQfOjRcviOROLeDgkwUbsyKuYtSE684c=
X-Gm-Gg: ASbGnctHMFbAaj+D+p5N59MWvDuS80Tv8MDt7+MOsgW2bwB6F3qtOa3jO7Unp5FVFvi
	lnbVCXO75QyLDsJEXgofhnZqpV/4I4kIacM9x2VSc/oyr/TORmU+AZtofFlAVwEjeQvgi3/fZOE
	SRjKIPdMHfDoRSBD7HQjiR4v85NGO85jF94CNtAM5Fdj+PF3ISKbE2EodzNfwWKSy+If7AvlE+P
	t6qlXkFw7vN0QexWOKfbttr6XmvulnWr7ChHZF25GhjJ20laFhLoqV+38AbsLkLaMf/b/9Cf+DF
	omNvjXC1WBnNCpcOUvkiiLaRoX4P0W/T7lZNtCjzBObd1xVQwcCU5Ccxg7TiHg2j9BoXQop6q0h
	7eUuRfQbZf6S/AZkbgi5YbzkziqAYGr22G1GSUqvzoeGuYU5xU7/GwBIXBxB1bl8cpbHL
X-Google-Smtp-Source: AGHT+IH8RaHjAylVQJBbbz2fVViy55MQyOlXslCXu2TNEUhwTy4uudrftYMxMziT/A2NjRI6tuUcow==
X-Received: by 2002:a05:6214:2a83:b0:70d:be38:8ee8 with SMTP id 6a1803df08f44-70dbe3890e3mr56021826d6.63.1756141533729;
        Mon, 25 Aug 2025 10:05:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da714727csm48193006d6.13.2025.08.25.10.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:05:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uqadP-00000008iJN-3bFh;
	Mon, 25 Aug 2025 14:05:31 -0300
Date: Mon, 25 Aug 2025 14:05:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, p.zabel@pengutronix.de,
	mchehab@kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com,
	linux-media@vger.kernel.org
Subject: Re: [PATCH v7 4/6] media: verisilicon: AV1: Restore IOMMU context
 before decoding a frame
Message-ID: <20250825170531.GA1899851@ziepe.ca>
References: <20250825153450.150071-1-benjamin.gaignard@collabora.com>
 <20250825153450.150071-5-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825153450.150071-5-benjamin.gaignard@collabora.com>

On Mon, Aug 25, 2025 at 05:34:43PM +0200, Benjamin Gaignard wrote:
> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
> index 81328c63b796..a28a181013b9 100644
> --- a/drivers/media/platform/verisilicon/hantro.h
> +++ b/drivers/media/platform/verisilicon/hantro.h
> @@ -12,6 +12,9 @@
>  #ifndef HANTRO_H_
>  #define HANTRO_H_
>  
> +#include <linux/dma-map-ops.h>
> +#include <linux/iommu.h>
> +#include <linux/iommu-dma.h>

This is an internal header it should not be included in drivers.

> +static void rockchip_vpu981_av1_restore_iommu(struct hantro_ctx *ctx)
> +{
> +	if (ctx->iommu_domain) {
> +		iommu_attach_device(ctx->iommu_domain, ctx->dev->v4l2_dev.dev);
> +		iommu_detach_device(ctx->iommu_domain, ctx->dev->v4l2_dev.dev);
> +	}
> +}

What is this supposed to do? Put it back to the default domain? Who
changed it away from the default domain?

Did some other driver change the attached domain (if so that's wild
and wrong)? The commit message hints at that but it should be
explained alot more.

This just seems wrong and goofy. Driver shouldn't be changing their
iommu domains if they are using the default domain at all. We now have
APIs to allow you to allocate wide chunks of IOVA space and manage
them directly. Maybe these 'multiple stream's should be doing that
instead of mucking with iommu domains?

Jason

