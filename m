Return-Path: <linux-kernel+bounces-805773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BC6B48D39
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806273BAA9C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CC52FB965;
	Mon,  8 Sep 2025 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BRW0BELY"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8EF2116E7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333889; cv=none; b=p/sywEEDGz/9ncvqM4vr2y7/xUr5mw8HcES48UWQdkSF632gNJMQQSTkMXrm9tiIHN7vfqdWB/20jCNzR9EsH9dpEl3RXh0BqyIVkLyf2XsqoKTIZ5orYnjJ/yZUQtsa0CiOSJ0Xd3YNSNPf+EqimklfXjehoC1e4UFsaWiKaUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333889; c=relaxed/simple;
	bh=9jDU/hSme0YnPS0TL1qoIP8QO+sem4TMosP6iSaKGBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/NOVEYJkoP7bfX14LfnwSrgVfbohSwmS4el2ayaYzwyQOXxOtUD8WaeSLgtuDRrWgdVj5L09J2IjUrMQ2pQ+fQxVIFXSBcVX9Zs1HV+so8wbNTNtc+8hPksg48MHN9ej3YmJwirCAUx5SliOR43XPWXV5/5EpnLDd+lNTllrWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BRW0BELY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24b28de798cso27899635ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757333887; x=1757938687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YavscbhBnLQerUXpQQXuMR+munlLpsXdMeTmkcH9XaY=;
        b=BRW0BELYp5075amt7un/yQ3H8CXNCs6Cf23454YQ2WqrKVvbMBmsdpzqkBgOFY1o1o
         Hg26N5AaozmIEY5k8o961nbEhnAWKSWihwHvioRUA//5l8DB4tkht/stXRxDktL6Wiv1
         Fkdz8bHl7w5OKcdaHDnITbmFmbsyQ4+Bm5XJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333887; x=1757938687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YavscbhBnLQerUXpQQXuMR+munlLpsXdMeTmkcH9XaY=;
        b=Av5WRF/iNUnbFVt1IL6x6B5tkIYAlyCqxGQ9MaOgoDFHct38aFlG+Le98HHfjRf1Qx
         J1vo8bRTyK1mK+rP4V7jhG+SkKlnFRMwVi44TmDA+CoCAqEVNJzgUZ6A6f54pRV6Lamo
         5L71dzWXakqm3hqTdAnnNpKvt9nOnrv+p/xsqryxYRaOShF3BJRdqwgdLaNFi6upOqOI
         AnXTh6QFEAID66zu7Z7iV6GeHdT2FKybzNi90G5f62LKkp6tXCXZB1cx2GkyMGYc6/+r
         c55Yt6jdco3HznaLWhWsuCabnfF/IpC+8mFX17SLaXbztBn4X24pYJp1eha8u6ibnD0v
         DfeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnvrLEH1B+trRl2/gERpjeN++GMe0VqVarFLqZF8ZnhgQybSuJ5RaegognYRgn5tkjdmv8Hzr1nNP/Wu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyW5DdJr4nY2/kaefhBEZ7c8Ee7peecM19TGMsricZ/Su9CHeC
	GRmzYQgVfqbsW3Yfpngxs7ljXSpa6sFFMNx/GRDIEQaB53JZHc48KwBOvv2wggv6tqVywIhcOwk
	FNl8=
X-Gm-Gg: ASbGncs3nxCNTxUa22wVcnDw9jL5d87B/SGavFeBYtJSzja95uop9lzlj8ZE5Eap3qk
	dxwTku3HCPqb9N6CTlXm6L+IB5aLGz+xMwUazN0DOeR6ONSiImK3H81iTkr2miUg3f6McteNrwt
	HCE0gRbSbgLzCMZRPRAJCbisIC1+aersSui8XWOW8KwC1l/nFyvRMyndFcZnKHfdJHQRbTjAQCV
	lVFCnqIkgJXRDjDmIjqNVWvBWzdb351GmSiQQ0T+fyNOu9PKEjBrHAKc3Sa3f/ixkre6hwH09X4
	mgIykmAl/FCLebiy3dsa0ZAh5Lx0aRA9c5Ca2k8s/EW5/4IhG8QpRkbrhL2zmsTWw/jztmzFaRY
	Db16dlwBa1ofAyDf2t+nkmE/bzDd2nwOP//k=
X-Google-Smtp-Source: AGHT+IGuc3KygF0Lp+FwgSMyfraRkRT9MUUiHa7qCu0NYd6Kla6Qfj9Pvg/sdd0O+HgGq1D/Lgo9vQ==
X-Received: by 2002:a17:902:ea0a:b0:246:80ef:87fc with SMTP id d9443c01a7336-25174c1a958mr113566295ad.45.1757333886695;
        Mon, 08 Sep 2025 05:18:06 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:b900:780:53bb:571c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c7bb4eb4asm155396755ad.140.2025.09.08.05.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:18:06 -0700 (PDT)
Date: Mon, 8 Sep 2025 21:18:01 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Vitaly Wool <vitaly.wool@konsulko.se>
Cc: Vlastimil Babka <vbabka@suse.cz>, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@infradead.org>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 0/3] mm: remove zpool
Message-ID: <tbvushbdn7nzitey3uy6humdndd6247r4544ngqkds3cr447e6@prnla4edwxmk>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
 <20250904093325.2768507-1-vitaly.wool@konsulko.se>
 <7b1ca42d-1b89-44f4-bffb-e6b09f86fdc5@suse.cz>
 <1d42c513-cc83-4f08-a10c-cbd6206070f4@konsulko.se>
 <girukcvvzgbtkxt4aftfz3lw3glvf2qsof4mx6wf5perolck5n@vaxlrtaeuzw7>
 <dh74mr7bjtpzk7frviv6iqqno2u2b27p7jiagp2dtnsz2wrfhr@wlb5vqg4majs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dh74mr7bjtpzk7frviv6iqqno2u2b27p7jiagp2dtnsz2wrfhr@wlb5vqg4majs>

On (25/09/06 14:25), Sergey Senozhatsky wrote:
> On (25/09/05 19:57), Yosry Ahmed wrote:
> > I think Android uses zram+zsmalloc with 16K pages. Perhaps Sergey could
> > confirm.
> 
> I'm not working on android directly,
> 
> I can confirm that android uses zram+zsmalloc.  As of 16K pages, there
> was a way to toggle 16k pages on android (via system settings), I don't
> know if this is the default now.

While I don't know what zsmalloc struggles Vitaly is referring to in
particular, off the top of my head, zsmalloc does memcpy()'s for objects
that span multiple pages, when zsmalloc kmap()'s both physical pages and
memcpy()'s chunks of the object into a provided buffer. With 16K pages
we can have rather larger compressed objects, so those memcpy() are likely
more visible.  Attacking this would be a good idea, I guess.

