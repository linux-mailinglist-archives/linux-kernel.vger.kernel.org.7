Return-Path: <linux-kernel+bounces-736973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9FBB0A5F5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4CC566C36
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FB22D8388;
	Fri, 18 Jul 2025 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mcR5J18U"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F30199931
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848045; cv=none; b=s1dGGmqJ2kn8lc1im4GF9ALqNYNa/nOtJeDp7dVfwo3ai7hMmA5x3q0guN4/zyjoWBFnWopo3miCYGt9K63eSq1EqfA8/K4Z0XGFHUQ0Sr0cx3ChGwz/61LUDE96VNqr0CY7JSn0Fk8e8IIHlHS+43m7ne0nPI0vX4BA8sp+UVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848045; c=relaxed/simple;
	bh=X2kw8wKIFchN7U6f3WRj7akA9iZyWVrco2+eQsNCM5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=algV06uxxRVswsJUZHHq5gi01moR52zYn/3/CdJBLSW9E4w80hTnKADcIgo7DefJw09b11vkZeLFzQc/4zmywT2J27sd915jyM38X3s9etzFjGcH0kmRWTQvx1Wxc3JjztdE/IXia0xoDL/G8HRhxC8ozpQJunfn5AKIUbRNVLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mcR5J18U; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab6646476aso13974831cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752848043; x=1753452843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2kw8wKIFchN7U6f3WRj7akA9iZyWVrco2+eQsNCM5c=;
        b=mcR5J18UiXbFtZPsBh36vbt1p4TFaxBPZQHTdf1PtyUw6+c/o9e7VNwra7F0sOfXhX
         nWDXEEUbNHtgLL3BM/NEGfXu3RnC13L94JH1WBazj0ZQA9keGTXYu/CZai+wZAhDp2cG
         vvg22R/c4aM6JMqlxxAPzUfqjO+uUM4iKi+sdXToBwRNvvxwF3IpiDQuMQdO+P44k29A
         pnWvbExuMvqaRurdc4s4jLq5g9G9RhK4arfrTPwzeKlp9E/A5+yQgk1Hofbfp0j5Qtzz
         WG1Gr3CRjLKnwQ1sM2syCWX6miSuifccY/PYA7SDraA+w5huMwMXzb67FfHs7C08Xf+o
         GaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752848043; x=1753452843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2kw8wKIFchN7U6f3WRj7akA9iZyWVrco2+eQsNCM5c=;
        b=sZRipAMwE3TWBNyxx0uJj2SCiaDVQE+U3QegX36xCQLY/szzxueaOTKmUoVNdEJfhN
         iIbvYM5Kx6eYTD0xKEKTao2gasns9mCjrC1GUrnlRzQSNnXJ4RMU/8pxwOZIUJnvsKBq
         JKL1EK03aWsYAlzbQYRlnntiadO0YhjorsWp9iUs+8D1/XjH3bJsy3Us4LiJwf/hr+B4
         /bdLPL/20fC6Al/TrfV6Ns4sSlJYGuhK8yVxIjEryCKzCK2qq3W/sRj7nyJsnRpsbK3y
         LYz+v/sB3ppPaqMQxzbtHhvY1/85f9t+3csu/v9Y4pYy4lhF80A3t1HwSSk9g38mzYs6
         hDLA==
X-Forwarded-Encrypted: i=1; AJvYcCUv4KlMPLfR599LSOug5Vy6YsOmdiZaa/yBB9+if3F99l8q8Qsmf8LIKpZGcIuXUA1A3tL2ukB1r5bLe0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgpeddETBPkn+YBgxY+xITYLBmjSs3PXTimrCKgL+J2Wm1M19S
	4j6+CP3YqK8cSunUOeqbSIq5Ehn9YuhjyJS8ZImHCJ+Vm1arjMfHRwFZaCFqU/z27L0=
X-Gm-Gg: ASbGncu3hgq0pfs1ohT3XUshtd1uIAXK9To4yQoJ+MYx3gd+UjTM57yrPWTV22ygJOx
	9d6YsA81QH+CSC4U/chj6x0tbLi6cfuJiSTtKG3ka1YY5jhmPChd4KNA25JmIqyR7bOl+epYV4/
	5SfMk8BxTtVmVQPCk2UdiE/TRRCUOhWZRIr+pk75DsAcRquJynBZNmULPWbN8v0Lo30NT1J3RCG
	Mn+8vNSsujJq4os/Ya3LKLizLU6ItDisAOz/9d+p6BNNNdzwWTwu49QP0NflVhoIhwDQIvbaCsp
	aOXjgjqGoHvhZ4HIaOvqamyjaW/FIOQe24jdtzXMpql1PyUm7eEr/FHH/7AU5bSZ1WcRwo86IUW
	XKUHXL31o5iNcZAf/Dov6HjgSZymbTWpEheAPMSlMDcPyvJWSRVI48P5TRfph12XFA5DQnVITBA
	==
X-Google-Smtp-Source: AGHT+IFxlNjnByJpGTyiiwdZo9i9Kku+QZgJ0vVJieheNkgXzQ9j9lwkrn0QWQUloNoVgHfjwg2tvg==
X-Received: by 2002:a05:622a:1a10:b0:4ab:95a7:71d5 with SMTP id d75a77b69052e-4aba3e9064amr110581641cf.55.1752848042697;
        Fri, 18 Jul 2025 07:14:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb49a0046sm7659811cf.25.2025.07.18.07.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 07:14:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uclqb-00000009zAp-11e0;
	Fri, 18 Jul 2025 11:14:01 -0300
Date: Fri, 18 Jul 2025 11:14:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v6 3/5] iommu: Add verisilicon IOMMU driver
Message-ID: <20250718141401.GD2206214@ziepe.ca>
References: <20250710082450.125585-1-benjamin.gaignard@collabora.com>
 <20250710082450.125585-4-benjamin.gaignard@collabora.com>
 <aHTzPwTob8_5rtBS@willie-the-truck>
 <baa1fcde-f167-4a1b-afca-0a2957a688cc@collabora.com>
 <aHozv0NG1OBlAH6c@willie-the-truck>
 <b4169471-fcd0-4415-8281-c5bd722e5f2b@arm.com>
 <aHpQXy-bnwW56rCn@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHpQXy-bnwW56rCn@willie-the-truck>

On Fri, Jul 18, 2025 at 02:47:11PM +0100, Will Deacon wrote:

> Just because the existing drivers are a mess doesn't mean we should
> proliferate it!

If you want to insist on something here it should be for this driver
to use the new generic page table code I've written.

Otherwise I don't see the point in trying to improve this in some
lesser way.

If this had come in a years time I would probably insist on that, but
right now it isn't merged yet and it will still be a little bit before
people have time to review it.

Perhaps a compromise where Benjamin comes with an iommupt format
header that works for this and we can progress this series and be
ready to swap it out down the road?

Jason

