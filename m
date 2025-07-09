Return-Path: <linux-kernel+bounces-722567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA0EAFDC54
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CF93B1E53
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866081F948;
	Wed,  9 Jul 2025 00:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GY6W+B+Z"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E6111A8
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 00:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752020782; cv=none; b=pKDHSE3R1KoY++UQYHJtbqRctCdwmM4crfCV9IYVsstc3uCtsC1E0f+D78cIlN/xHxSCg2lTkGFvihXqOCLaXDHLqLbi9pZjkXJC+wy0z7pvGe98w/E1XGdNocMpxmGxpD/O7yoB4LZzbOHw20NdWVt8JY0BJVpQpxN/PY+IxBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752020782; c=relaxed/simple;
	bh=xbbei7U6p6rKAO0csoP3ETOXHvHtulZ3jMXriqErwDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/YTT4CYN6pRiYW1SZ6XKY35+RUUBVFuqb63F9XMdHyOLDCvABghvv6yGG02eBuUvXNDHCZzPSmvPewRowvGxevyWF/0FuPtZkqm04bQBZIzZEkgD1LyYYWjYWt5MwNjKfXEuGmqA6Qc1WV7qsO65NUFaGVDvO506KxNXEyuc6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GY6W+B+Z; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a9b08740e3so35258181cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 17:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752020780; x=1752625580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4dAC1p+EwdmBHwbIWbaFVBlz5nVRbD9VkK1roJ2KD4g=;
        b=GY6W+B+Zv/W6ge0QsM4i9L+oARaYP4DcsT6BUVJOdxNn0iNfafaKIDvlP/xydDbgph
         c36GqXkQNMx8ISjVlrJbgGGTmtfKYIC4xxc2hAUya9ZPv6V4NCXXxjrMPrEVr5DEAXm+
         TvYd0IA5ueGhvnT2enqm29naP6AmChoyu3zBdji+XwvArjb+3Mwxh/QPzKwpNqEhV+uF
         xi502esaSHcS9jytxwTkVN73PEqEl578oWQqtYjwYvqDXpJ0BcnrVknZTeJrD2qlNVaz
         HvOOJxR2uANKcQ/YDaLs+kGeNb8+T0Dmbm6bzveXlXlhmrrqpPtrdrLnJb5D3LK/l50a
         JjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752020780; x=1752625580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dAC1p+EwdmBHwbIWbaFVBlz5nVRbD9VkK1roJ2KD4g=;
        b=oIooPTZFOrw3Ru5R6DkIUUWob0rdpgB1sJMVt1LVg6OU5+mAQ4ui1BL9gjzSA8FABn
         V+LB+EVpYwKkA/A3Hfbaly3WA2SQqzhl+VUvYO2h5jOsUFrkB7ms3E/MF6ar71Cbham8
         A3n8xsDAEn1aL5/bNGMekpOpaN+hfC2znUr2/QovsO9nqJylyo8bvmHtwF/RSuyrOSZE
         k0Q6g8VO9G91mOviv+jXvTZFtOj5Q/86n/ncvEnvVEyjXZy9/w8g9NWMnNF4wmqCXFu9
         LKfhwYGUt89hBiB2iJ/pg43gewBJKflTEEqA1kGZ+PZpogAxSneX/nNnO0BIa0PJj5II
         zGGA==
X-Forwarded-Encrypted: i=1; AJvYcCUi6mSt4j6T5lA9d5y6Pb5ICRPT88ElPrcOqL8fYYJVlAlQ6KvesG0t8Uh0A2CcrG2JdF2c9ITgMKO77N8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/H9NBFa+XTpqPoxrF5V4BYO1Asf/dR/e9b3aCxwp9W+TFSpjq
	QrUa4Z+QZf66MVxUhtchAN0NeC7iTmVegAjoX7rBOygne5W4mxLuFALHG7XdDAHggw8=
X-Gm-Gg: ASbGnctV/vApfIOM+zdZ4L+uLCO87MqqE3THp0NM88yiIhvSXdnt73GfTiMVLW+vtC+
	SGOB9UHsvUX0t2T1U8Kdh3GYjOLR2RARpQ1vKWWCVyBMnyVU7JjLfdj8UqLEOjhxvlz18n0kpjQ
	fX4yVT+R59EiWlKH27x+qeKebSkKq02ngqa67UI2Ty5pF4qXx5kmaxsWBiS821Orne/1jyvmWxO
	diSg91DEFbuFEXGtU8CnCNFAQTPTQDAHZDiJs2c7wZ/0ABXCBzL3YaW90SEoZRd6jrQ32wvD3zA
	FGKP+/GsbJ8hQhkdvHzFAEFokO3EPtXv1aDQ
X-Google-Smtp-Source: AGHT+IFSaVO7q7bu+dYOf1GVeKqZs7GLoxtb1NdzR9hlmeu1FRZsqxH2hLA4RP5hCtbSDnx4/dkebQ==
X-Received: by 2002:ac8:578c:0:b0:4a9:c2e1:8844 with SMTP id d75a77b69052e-4a9dec1f0bfmr6312041cf.10.1752020779702;
        Tue, 08 Jul 2025 17:26:19 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a8e083sm89289331cf.65.2025.07.08.17.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 17:26:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uZIde-00000006x1B-1jAi;
	Tue, 08 Jul 2025 21:26:18 -0300
Date: Tue, 8 Jul 2025 21:26:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Remove unused macro iopte_prot
Message-ID: <20250709002618.GA1599899@ziepe.ca>
References: <20250708211705.1567787-1-danielmentz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708211705.1567787-1-danielmentz@google.com>

On Tue, Jul 08, 2025 at 09:17:05PM +0000, Daniel Mentz wrote:
> Commit 33729a5fc0ca ("iommu/io-pgtable-arm: Remove split on unmap
> behavior") removed the last user of the macro iopte_prot. Remove the
> macro definition of iopte_prot as well as three other related
> definitions.
> 
> Fixes: 33729a5fc0ca ("iommu/io-pgtable-arm: Remove split on unmap behavior")
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 7 -------
>  1 file changed, 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

