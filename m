Return-Path: <linux-kernel+bounces-796374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C0DB3FFD8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700B45E2310
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B532F0664;
	Tue,  2 Sep 2025 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FtH6qTQm"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8AA283138
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814791; cv=none; b=OQOuaBPr6kD8YY1O+av99GcirYOq8T2ql/GmHEputIbmTEzwe4g/ReHy+zqezUAccr0CddqDolQAIWO8VdmAAYMRAjUUFI6Y5IheV4XpWel62DYOCvX9fyRyEFho1f98++BedQYJAOKYGpSe8tKywYhP6knd6joyIepgpeS8/bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814791; c=relaxed/simple;
	bh=N5fr3W5WmfopIvnLueh68C8SXPvEFYcBmY8He5xkrOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqzIMuMEizOZ7zoFcsHN7evLW0oaPC/eXD7n8hHAjrxLnKA9d0zU1aSAG8ww10eTtdV3kCBhIurMa6OwESI4hiqOmex9AUho/B8jCY6PTknmlr14JS4deO428Q/E0hp/gVWtiLVD7N6PBUPDPvuBWC2/6fdbqdm5WdcVC9Nzjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FtH6qTQm; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b320c1353dso33795971cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1756814788; x=1757419588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ae26jb7eMgKo9jPZq9aVW5MuaO6TSCdU+50Vy/SJX5k=;
        b=FtH6qTQmnc/VFJwvWX6DH2DlWt7wz1YwBbibW3A5Hu4KRJJqwJtio24qRR76P6DwqV
         HJD+afzx9iuyO+0aSPXabPYxyrJvr7HEiNuRaZ9CNMx4SK13vR4F3YyJitYiwOxsCVIn
         cIknhVhVrDgRzXO2mBiqIyw1S/dXl+pDErLOCQueDmBAKG8wq9I14woDa8fvDJ09BmUy
         EuWi1lvP37Vb46RRk7pqTkqgve+pJT4UjIOeLbt3hritxS70MHHvF/CGD4lIGASCr16X
         wjDazNmp7ynAD6aOy6NOQQJp5bJMm0ylO/J6CHe8kh6YXwRqTeKDRx22tWJ8kIBq/TS4
         GE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814788; x=1757419588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ae26jb7eMgKo9jPZq9aVW5MuaO6TSCdU+50Vy/SJX5k=;
        b=IBkZqWKdknjPpUYztdngKT0sa0hcvIPIa7CU3zWo0cBIlroegOkeK8B1ZQqd32vgQj
         gBiwWofeKrZ2eWp66OmRTbpTYTPrvqfcPHLUBl2jsXE4cLqnMI18VuZPTI5jwvfzEDcX
         5kiRacj/MfQGwudBA8WC+6jqH3ANNV3LNQeSCzfJIeosz1tq7oORuDHDEV2APnISaA8V
         Z1hl2whYnMM7yGfZ9xBqnW3ghQXpJHRalc1bSXQTxyR2qcDAsFmvZLFT3wdij1XTZe9T
         KUnxA7sDvwI6qGJO9znqO+wEMhWfvw6JZm0Coeyz+Y50JNfPJ1iF2C9h2fPeWabgO67o
         IXeA==
X-Forwarded-Encrypted: i=1; AJvYcCWYCYSWfr8pRrKR/vMLaIbt55F1bGtmBXvCQ9o5uXsXKn8uhhpkNIf5wZMmI+MsHZJecbRYAHuQQc11Dok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7TpRUdEZFonFWo/7mTzJE7n+c6odk/eJ+/VlnZcPrg+wh6dM
	6bLTtKTynI0QMqAR24rWFNU2Hg66aurqXJuANYXtmOenH39+2BCCnsgdGuL9O3yz0Tg=
X-Gm-Gg: ASbGncudrUPnhkPnfR5//OVPQn7zxoUzzCgiHcbLmMZcLn8//PuEZ7YeisXdPgUK+al
	p0WNWdWNpp8P3PZCRrzidOhaax/FgklgTYDZXUVzu1/S8scr+gr2z4n1oOU6tRA9FrB9Vfxki5k
	oz3bNGJHX+8Yrr29f9IwncELf5ZhUQB1J9fLnkomkC3OgpuxA77kH9C9GnAhoZz6jbjEoEMe8i8
	I798Mo+ZQiE9iRwSVSoRllYOqkutv7x3rOWI3JGgyaXtfthqKgKuey3ntU3nlnl8njyFLW1aSHp
	Qm/RD9MhNGENpeta8Ye8cR/Gg8cHH7mytRM2EijFND2MIc7ldueOcFg8hYrgpOxczHnKul+SLHA
	Z1S9THsr605mIb85WYJEuhQVeSqy6jzjuG8H0PWtg2Hco4J9r9FpbD8fPnmOiSqLYWTQb+1xm0G
	PD2Ww=
X-Google-Smtp-Source: AGHT+IGq+b8MukhXiFM3oGQJBiAc7TI3DsYh7Y+rH0+wkWrBkgjU/7jW1I73b1PVVaTQ6nJ+pi8pJA==
X-Received: by 2002:a05:622a:5b91:b0:4b2:8ac5:27bc with SMTP id d75a77b69052e-4b31dd55c80mr136582951cf.71.1756814788218;
        Tue, 02 Sep 2025 05:06:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b3462ca49fsm11168561cf.31.2025.09.02.05.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:06:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1utPmM-00000000saf-2PL1;
	Tue, 02 Sep 2025 09:06:26 -0300
Date: Tue, 2 Sep 2025 09:06:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
	osalvador@suse.de, jhubbard@nvidia.com, peterx@redhat.com,
	linux-kernel@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH 1/2] mm/gup: Remove dead pgmap refcounting code
Message-ID: <20250902120626.GA184112@ziepe.ca>
References: <20250902051421.162498-1-apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902051421.162498-1-apopple@nvidia.com>

On Tue, Sep 02, 2025 at 03:14:20PM +1000, Alistair Popple wrote:
> Prior to aed877c2b425 ("device/dax: properly refcount device dax pages
> when mapping") ZONE_DEVICE pages were not fully reference counted when
> mapped into user page tables. Instead GUP would take a reference on the
> associated pgmap to ensure the results of pfn_to_page() remained valid.
> 
> This is no longer required and most of the code was removed by
> fd2825b0760a ("mm/gup: remove pXX_devmap usage from get_user_pages()").
> Finish cleaning this up by removing the dead calls to put_dev_pagemap()
> and the temporary context struct.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  mm/gup.c | 67 ++++++++++++++++++++++----------------------------------
>  1 file changed, 26 insertions(+), 41 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Yay! This never made alot of sense :\

Jason

