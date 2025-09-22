Return-Path: <linux-kernel+bounces-827308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A198DB91671
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E8C3A3C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3304B309EED;
	Mon, 22 Sep 2025 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Cd/yvRvR"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C3830CB21
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547815; cv=none; b=sErNdTukhG1e3d5P2DPI1Z+qKgRddxs5sLjf9+5yVoanBib8A6Gpq/FIjns0TjrL6DpctoxHyM4p6vbCDTvE4G5gJ8P8RpevTrMbk9/xNdI4p/3AjnBdY0CRIEOm/rZ2wiAPBEJco8M1/cWiKQ+h4Iv9tR7rgO6otRG4k/fKxSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547815; c=relaxed/simple;
	bh=y2+sNh8F7BJ4b0OtGqFkua6WrDm4Bnv4O9Hd644lllQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyxWY69aoEihbXxRK6vIhLCeurxcMWXVOcZAvAaJriqw9DfHBXIM0GTS8/CokWZjigMpBnoCc2ovvaEmJHMdEZoMBEWp61kuhhPGfhrEJVhcSCOvr4K7W5uYXymbRjFS7cOPqsqoM8bTr/4yMM0ym8AfndeQQVPu1aYwVI/FB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Cd/yvRvR; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b5eee40cc0so43407481cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758547812; x=1759152612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y03k4DFLRprDfdbyLDspwlWtQehDogFzjJI6AMgeKrM=;
        b=Cd/yvRvRV9CTfffsuVdEgSOBpPACXgOhedeTq+PYioKsM8v9HKEKaUnkSSbma00NNF
         23e0hROfJf1v/51xTQ7OvHPCv+ORtmvnTC6wnnAw6rzlVqbABWUeJZRzOCQFlXRw0ySl
         eEqq2OTpAB/Vb7jSUnlnKtdSyYFGoIgHZAj1aUwGT/25hEZq8vcYlQ6/ygHYDxDNT/2J
         dCogoD3l2eRAZLwPaS1BylkjCwMuDiuaFGnuyObDcMo2i8BJu/jviQtwW/LZKqP7Yypu
         ou39GbOR4GBftFeQJsRjK1ndyukQ1G4Q54+h3YOXAoQZPtpJTxmiCVJuyL5tehKmJZOX
         e6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758547812; x=1759152612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y03k4DFLRprDfdbyLDspwlWtQehDogFzjJI6AMgeKrM=;
        b=YoJovnSD2TJWmofIdZM2YrdZ4ArPfr4+S9wtjkJDR/ZwCE4jnxEHXEOf4VpVnHi/3n
         FoIDIsHVeb8xt4gBCN4udGkVK+5jkIdmVCcmsaG3zFxxpIZnY/MSk92+HxEM6D46qGVX
         c6LYBmXk2BReMvuHHQBQLyXnmJDwRCYJCOgDN2v7Syz/Bk5EwEa6JOjNCBh2Usi8NHlV
         PZp5H8IlOwIdBMrRj+/kxn5owTKJxgE97E/t7nC2+P8lm8uH4QXvthMUCFa/sD3jGmO2
         qN6JrwiW0Zp27Qq0PvxcwcZRYStf+aV8x0h+Sbnrf2EqrAjePWNoOIzMZv0VzVOAaHgT
         TT4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7F7yjwZ4VNSbRmiwWojic0oKR5R0TUauB4A5vI2l8flF2hECqhCEUI/gfcATLBiVQz8mbME27MPsuPuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHBZTJ3lJ2qfP74A8cZaZpYKiys6alSh6LPGJ58/5peYdb4acz
	lBh07k5FhwlTw/g4or0UEIYroqBoxk5LrCeIH2BvZFxCKSQaK5JezJPIGqpy8mdNri4=
X-Gm-Gg: ASbGnctXs0zFipd0GYx7iKsyapwKuLblJt8EqojooTZmEbaKLmfBwWHtbcu4kOCUvrE
	SMo4Gnd63GWidAvtZLlNbQWttbGi3wi7XNZL08PPgVK2HZwlC/bTYf63BRKUCXZgnHtliLZncXj
	ps3dT6N04F0L9YdcWo7QXfdkYJ+p60/hyz2E4rQyfoC6yhghxpQOBnWdk7vwQqPKaZ57y3JtI1b
	mgVwvkMvfqYe2kcGmqhQAk5og5anuKXv/dwL27+U9rt2a6orBx1wsO93SrhtG4j2woaLhx+SzCR
	R7idjNGdD6t5waH3OMpVZfsjZGkC8QBs8XX5RCnYrud99wCsrH3kWYqqLfsfWTEe8JvHcMIj
X-Google-Smtp-Source: AGHT+IH4XwIxdKdRzW2o+GACM5iQvve0syctd1r00LPQSbC18rDTaAU9S+ss/ne+khceFU/HXjRUbA==
X-Received: by 2002:a05:622a:488:b0:4cc:6d84:8199 with SMTP id d75a77b69052e-4cc6d8484e1mr38598321cf.13.1758547811879;
        Mon, 22 Sep 2025 06:30:11 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83d1352f390sm566847185a.15.2025.09.22.06.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:30:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v0gcL-0000000ALyP-3XIB;
	Mon, 22 Sep 2025 10:30:09 -0300
Date: Mon, 22 Sep 2025 10:30:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v4 1/4] iommu/io-pgtable-arm: Simplify error prints for
 selftests
Message-ID: <20250922133009.GY1326709@ziepe.ca>
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

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

