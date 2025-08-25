Return-Path: <linux-kernel+bounces-785419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23221B34A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB04A17BCB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F329304BB5;
	Mon, 25 Aug 2025 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XUF30Yjb"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5849307ACF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756146686; cv=none; b=calHnF1cv8dsdLboyKgHesFtfrwl7+Pkrg5d/V/UEwUFRzm/onOt5G0qV+wuAnwBNQ4ApD1LHxq4pR1ubSMO3yY0qKnzRsrIB45jKYjiDBlJcxUel5x+c5nGjfIYQvSd70aMLgO2KkD5nM7qh1WjhPl3BheThJ4w1s74Izaytic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756146686; c=relaxed/simple;
	bh=NqoYACXOw8wDP1WvzCpUxeuUy2wpqRUkEhJcPRJdMis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCiB24HTWy9Fl6tRxtvMlPCt0z/rhzXH8Mb41+BmP9xR60FfnvMc0uzXAisuGRi2ML3EVqhvzFNfrlnoX3dNQh9WDjiLwtyiYKDzc6oOK8cM8wB+txS9zNgcGw24UP6fsV2c6QcvxIc1NZYF/8AoGGNo1puFCYFTKhapdel/1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XUF30Yjb; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7f04816589bso121923485a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1756146684; x=1756751484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zWiX+6VTPBW9oMyyTDAuGR0ExNJ3ZNdezl4Ijz6qJzY=;
        b=XUF30Yjbs/HTyJ5gzDd7LujSLObHx00FMxX5NX4tGUOhF8jWYy7BFy/eoGlqBY+IkI
         RXJS1Rb0HoNxv0lvhEFlnB+/rhG0WyEUHAEWHDVmtvtfpX8nxNEtZVI5fcRUe3sW83Zi
         hGZvTAboUs72FJfDsW1J/WIoRoJ3qrAY9u18H70zV2dhfif0oP4dblQPZPVd+hQChTQt
         r7GBSiKtmSz16g8PPf3B+A0QlCLa66xoc3Ry5Dc/MEoAwB3OmT4Cz/SNWiHth4pmHf+S
         eBVVAriL2vl0smgtEuibc/VELAoBf8HNB3/noex3u6GBdLEPqHqe2kHv+ZDMn4HIS3sB
         svbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756146684; x=1756751484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWiX+6VTPBW9oMyyTDAuGR0ExNJ3ZNdezl4Ijz6qJzY=;
        b=U1aKC3wIcwFUvVmKnHgBHUd/nURy/X0RmYjvjKxcdtHWwUT4GV+Vk3ZcTUQPIddJid
         Ldvo2TKDLCKyoP0Mu7416L6ZTPYS8C+QcnciL3dpdYHjzygimZ42Ufw3b7ogChJGsxCx
         hJGpVld/znIR9ZxTur86jWnhj6rODQp3HaCDK2Z9SV1cdhJwo7RTDnsUfcpoSIuZJxZe
         YjxGYOf9zyLUfKeTbygXICxZOqREGMsG4YTixyD4QtQp7T0+ThdPEigki6MBMgiaGulr
         W+eN/hU08WPD2ER3sFfLGsgi4C9Tp8gJTQ1eOyMwAPPe+0Bb8qXQGuF9paJ2vYkgrpSJ
         XVIA==
X-Forwarded-Encrypted: i=1; AJvYcCXDEyfZyQR8Z8jiiQq8RK8NsJZ5BFxuWgtiwMDSwjv0e49JK91j/6nW0UgJNULOiWZ3xeXiGIX1rAI1qI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YznSRfLmag5604Eimji9okCL42d+E7tiwqtUUBhqOdXgjUGglr3
	7jJuVABdUkB5/4n6Fh+y8p4xSGPd+gOJiix/53czCW4vPBtr4HSi9R+41yJGBEue/6Q=
X-Gm-Gg: ASbGncvSCwn/nRv/bAoObsuXZYO1fKLNNS1vYnr6A7M15zyYmX5znoPNOaqOTEp11LF
	PthR7q3BKl8vy80G4wrWoMFfoyhEqUSEm2JvEDABM+lVsLmrAGEDWwpgPuQLs3Umha8Vf2lBp9c
	XU5idV1eKes34Rvb76nP/yW1pM2nbMyf/qRxzuFTIgOqJ+GUU59RLUUfgbAAeqKvJIJBKYBKp7i
	y4m9yM8nEBJAQRBsER5UnPChoJFvpyZlDmvpsZrQZyJO/bGADJ2JFnbCphNluA8YQKeYuttQPDG
	Oqa/lvoVuOOfjou8xCReb/iTi4szx643Ma3pGFTDC7jq2hQeITWoNGi0SXGGAPL1IPx7w8Gyhoy
	HqGiZodOtot2jsbZ9jBbiICuKTU39CZKxTWxEGmyRyzxKzgR5c/PtERKa8GzGHcwx4s6A
X-Google-Smtp-Source: AGHT+IGrrqtb5FLiQ6yBv5bSbXionDmSOOeGsus0fmtyrIvrknH2Q5meU+RUaqrB7rQ0ZREIDsRXNA==
X-Received: by 2002:a05:620a:1726:b0:7e9:f820:2b95 with SMTP id af79cd13be357-7ea110baa0emr1337281385a.86.1756146683666;
        Mon, 25 Aug 2025 11:31:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8c631b8sm57949871cf.3.2025.08.25.11.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 11:31:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uqbyU-00000008lWr-2NRj;
	Mon, 25 Aug 2025 15:31:22 -0300
Date: Mon, 25 Aug 2025 15:31:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	p.zabel@pengutronix.de, mchehab@kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com,
	linux-media@vger.kernel.org
Subject: Re: [PATCH v7 4/6] media: verisilicon: AV1: Restore IOMMU context
 before decoding a frame
Message-ID: <20250825183122.GB1899851@ziepe.ca>
References: <20250825153450.150071-1-benjamin.gaignard@collabora.com>
 <20250825153450.150071-5-benjamin.gaignard@collabora.com>
 <20250825170531.GA1899851@ziepe.ca>
 <01c327e8353bb5b986ef6fb1e7311437659aea4a.camel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01c327e8353bb5b986ef6fb1e7311437659aea4a.camel@collabora.com>

On Mon, Aug 25, 2025 at 01:50:16PM -0400, Nicolas Dufresne wrote:

> Jason, the point is that the iommu and the VPU are not separate devices, which
> comes with side effects. On RKVDec side, the iommu configuration get resets
> whenever a decoding error leads to a VPU "self reset". I can't remember who from
> the iommu subsystem suggested that, but the empty domain method was agreed to be

IDK, that seems really goofy too me an defiantly needs to be
extensively documented this is restoring the default with some lore
link of the original suggestion.

> the least invasive way to workaround that issue. I believe Detlev tried multiple
> time to add APIs for that before the discussion lead to this path.

You mean this:

https://lore.kernel.org/linux-iommu/20250318152049.14781-1-detlev.casanova@collabora.com/

Which came back with the same remark I would give:

 Please have some kind of proper reset notifier mechanism - in fact
 with runtime PM could you not already invoke a suspend/resume cycle
 via the device links?

Or another reasonable option:

  Or at worst just export a public interface for the other driver to
  invoke rk_iommu_resume() directly.

Sigh.

> Benjamin, please improve the naming, comment and description, I agree with Jason
> its not completely clear. I'm also surprised that you do that every frame, seems
> excessive.

Indeed if it is just error recovery.

> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ff8c5622f9f7c644e995d013af320b59e4d61b93

This is already merged? And now you want two copies of this? I think
this is a very poor direction..

Jason

