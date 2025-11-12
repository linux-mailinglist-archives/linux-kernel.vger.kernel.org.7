Return-Path: <linux-kernel+bounces-898268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309D6C54B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A02C3B453F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012EA2EA498;
	Wed, 12 Nov 2025 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PY6Ab4sz"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743182DD5E2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762986884; cv=none; b=ge3kP1sZPlPVn7dN2Bm6pLj2wKgz2YB8YAdTAC9GFb9R4OGy5SwsbwyFgZIlAqv0wK+zXGH7/0nX0F9K05ZEXxoL/PrnNXHrENiyIq0aapgpe6q9w6ZmeudwgnBhPvoadABwuN2Gbkfc5GdTNt/1hNcYYDWcymrRMHoyA2L2Boo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762986884; c=relaxed/simple;
	bh=rNIf3bi2IMoCRnWEY1hQj0XxWY58P6mSYvKdF2Iay6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=achBiGkkhWlShEKrqEW5w3VmMxUpqx24hKxLu5W5PduPOc06yYt51vge3G4I34jWJWDcBrbVO3j+N17ixj6i4wUkC3bwilsJur7/2Z6n4HyItQu9modMpAyrsr7PAQxxJaGGXP1fPkbsLbykrHpj23V3m2hBbMKYbE3/9AoTkZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PY6Ab4sz; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5dfb5fcf063so45012137.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762986881; x=1763591681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iDBZhCwNxVXaARp2KU6VbEkAStKufeq/r52aZqJipig=;
        b=PY6Ab4sz9XkSJeMG4bgoA+TO6PsuUOIT8apPdWlZjUL12EmPrRIW/7mP+2aSKmgHMS
         rHV+xT/HtDfivuWGc2IfY+rORcI1DCwHVQIkt2P7E7VXqgLO/cUpm6Z06dEstg6n6Gw1
         cUPwo2GAnoYntQZeCvgsplIjAGbZy3ouu3zlTf01OP5xyyG/+VsdLgEaTLfF8t3Cf0VJ
         sHNG60lUKbMwxAPUf66p15quYbnDBJpNVL9GoQMABSVc2tYFydRcYtjcM6Q88uAhtyZb
         JBRasIxW94L94UuZBo0Rt0zQ5RK48kR5EaCu8fKAkqMJ42KFr8CtUwG1Nx0KCAZf5Fb7
         6W7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762986881; x=1763591681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDBZhCwNxVXaARp2KU6VbEkAStKufeq/r52aZqJipig=;
        b=cYG7PgZt1ojNAKjTOTvg67BQ15zyfdHgZrmiHXjWeG10vBvm0tX+DQ5OrkOtKu0Jxh
         /wonYl6fLPGL1M6eC0YQ28k/Z5/IqewsBPar8jZ8DZXjeGYqFQFuIRULn9RZsg0osQoZ
         gHFBgV6Mkr13TLCil89sS456qX+RSATN1kmsxMn0du1zVpA3zifMBKY3Awi4XS2EXZWo
         jsAkIeJwqMDF7cG8sSfJTo9HQYHbtakjUApWyVYsIt1Af1vLMB89EvNMaW56shIaDsln
         86JzXJi8zVlUQ59PivnAmpq/3cs4I9TdhXkgL0k+zpE6QbqLmIRF8Oexia2IZbXizDFa
         /iBA==
X-Forwarded-Encrypted: i=1; AJvYcCXxZoqK1tjDUnhfdQmJo84LdTiVrjh544TkE29LpY6LBG5bn3p5TXBSMHHwP0rz6o/hflPGOCl47DcGYY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7KdU1u4WFkXTc1IDCzync4651IAq1ZSI9uQPnY45uKBwRSv4Y
	PlTXghIbmx0DllI/F+Ok0QF6A2R+17YhXd89LXGTqsDLxzWDLU6lh9pSpAw6+kk6cdyKlIxelIb
	HCSdG
X-Gm-Gg: ASbGnctwGcFksfNJop0qZSU35GY/qts+aGYQQa4qJxLtFPXvpZ8slrkr6gSRx78m0eg
	5p5qFPfGAivkBIqgpGi3w67c9ryjxMk9MTQmBzRwTXNZDeKaOYgWVK7cK5L3l8mH2geiaPLfJbG
	wxRho9t70rlZVBG+Uj/J7NgjSUFosI0dgtXsCi3U43vX3mBjXnbhtycOBz/7R03UOAnlQ19KRwS
	vTEuHs5TpbIPiAg76rn81PaW+pDy9J0UcHirBVdYh6nGd4zXUaCCkb/6e9A4uUv3/1m/PxtbnY5
	0YJR2fxTvHkWh/Nhvmmamk1qFZeNkySx7T191+Ey2hnm416Xa1ZiZlttRM7JtZzfBfcCa2oXBgW
	dvBV2PXpgPF0t4GH0RC2/HFIzs0m4LoKVrkYpEJCtDAxY9bFENtfR/JOZXkHLxCTF
X-Google-Smtp-Source: AGHT+IGPfWBm38H3nRt+xzXpPbjxePsYgXweesLX/CiW1OacEQJsPx7V8b0B096XC3jH0cYT28BRPw==
X-Received: by 2002:a05:6102:54a9:b0:5dd:c569:a797 with SMTP id ada2fe7eead31-5de07e05c9amr1609473137.23.1762986881328;
        Wed, 12 Nov 2025 14:34:41 -0800 (PST)
Received: from ziepe.ca ([168.228.234.210])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-937610ce6f5sm118250241.1.2025.11.12.14.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:34:40 -0800 (PST)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1vJJQF-0001NR-Po;
	Wed, 12 Nov 2025 18:34:39 -0400
Date: Wed, 12 Nov 2025 18:34:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genpt: Make GENERIC_PT invisible
Message-ID: <aRULf65eNaRIVEHN@ziepe.ca>
References: <48381c47930d98380871458ca471ea5a7a89aafc.1762956447.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48381c47930d98380871458ca471ea5a7a89aafc.1762956447.git.geert+renesas@glider.be>

On Wed, Nov 12, 2025 at 03:08:05PM +0100, Geert Uytterhoeven wrote:
> There is no point in asking the user about the Generic Radix Page
> Table API:
>   - All IOMMU drivers that use this API already select GENERIC_PT when
>     needed,
>   - Most users probably do not know what to answer anyway.
> 
> Fixes: 7c5b184db7145fd4 ("genpt: Generic Page Table base API")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/iommu/generic_pt/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I can't check this right now but I do recall trying to do this from
the start and it was not working out, it ended up not being
automatically turned on?

Did you test something like menuconfig and the IOMMU drivers are still
presented starting from an allnoconfig?

Thanks,
Jason

