Return-Path: <linux-kernel+bounces-735892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC18B094EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3996B1C80249
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45792FE390;
	Thu, 17 Jul 2025 19:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v4UUgj0M"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793DE2FE386
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752780133; cv=none; b=DqCuxgx+N3760PCZeV6Hy+EXKfonM3zua0dboaYaNx/h6jz59wg2w5OvS87mUpoQoXFUypD6XsI/9hVLAnZOInhZF5k6psCfjQG2CmGTjGeH62QtriUyeQDk88TCxQFv/v9S67NiDoTzMF7fcA5ChI6XQgZXK53NqcmVF3MWhmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752780133; c=relaxed/simple;
	bh=0YsTyPz5UOHT6XHrQ2xUgDri/iuC9dPsj5SoaknbEvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3Yrnr596OT0UlIyk2pj1Oy2ApnbDJ/V5OxiRRSeDYG9HA6ii/lt533txmIA+2j6fse/EzhOTmkw+1gtLurlmy48D8/wgOAQhXXLZqeSmJC/KiX1dOqJUuDSlcjgIZY/qtsyaRcob9dNecCOCjb65Fwr+nHqF8UFOipKLlOla6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v4UUgj0M; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-41b7d1240d8so449354b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752780130; x=1753384930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5p4qniICn4Er/KPRlGX7l4E+1dNZxarZk0M/pe+4XQ=;
        b=v4UUgj0MuBL9kgghYRvrYA3tenzrQ97gagY/xDG/L9S2D3aueVbegiZMqYjGWK1NLr
         6jdQY7Pc5g9J7vPEnLjncPsXS66GYLYVYcIxPY7fJXtA9GDQZrqN5qU+UJYiR4CVTn0u
         1tE4+dWnXOl/1NNszWVWMbULDMPPqh1UQ+ZZiRSZcve9OQV66elnZbZC6SScyZyusLof
         D0rGgWlZxnX8UZobwJ0U9Qp11j/JQJEdYVE6lsQlW0fPfQqA5RRIdEnotkhaFmyx8K8Y
         owt719ZbwA1BqVaKOuIaS/OnXd6RoywwqWO8yxJ1usNGbywnHOve9tU3GX76bXRWSUOp
         ry4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752780130; x=1753384930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5p4qniICn4Er/KPRlGX7l4E+1dNZxarZk0M/pe+4XQ=;
        b=TS4VpKEaf9hiC0HTQN1Waaf3i0rKRCmVTQ+vjEakXNWYCyz4pyv0ubMOmGKTp9y3Gn
         jDEo970leFKPhlThtJVwmrg9RArYbKcBxQUaHdVHrgjhwPhAF032mWEWkZO+IRBalMbp
         0+UqvM3HF1h2YZl/dlJ3PAnqEg998zESn0A1yRIv25fZ1tKdrWlg2PerlZGlMHZzMcRM
         Y520YVNYb05o2HVq4Hu0AvEvUtd7YgThsUXLBfL4x67ZwwYBYbQZVSwsr7bFOGy+FCTi
         U2025/49Dab0jvpxPh9Vz+bQuNUVQCdgNu5RRBJEfULlbK5wcPX8kQnFdwIeYglPdy4r
         GSmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1bYW4NGQq784CfAsexJuanNJUnnqJADi0/gLRt+lmfkjl4C515g5WsCwf4oKNoqNk5AKGbyUpWogdWac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEa9HAOWTSiy4/65BK4e8DoSik+ZqiWPSTrxplgIS4XLkjMjyJ
	56czNHjzZVfVgIQGD/23udKbJNfEHDviS/HzGx4SP729k1nZEcJx6WnjN+Hj/WBYBVA=
X-Gm-Gg: ASbGncuYtef5pmkdOCoq7ltrAkSgLDgH9aTSztDZbTnTaDnOdO1tPuhOpRJU+eOvFgg
	Q5207pH2BQY+jR8ykeOdfi5KZmbGY0QFqFPhnP1+OY3i4Nozv/ZlpmdNlM7v9LIoTKB4pq5wzfb
	9KSt1bNhPy0nmCfUgA/Sayi4D/V9EO9vSJ/8c1CLYcGnaKho2DkUHrlG8zWtzBa26dWEp9B3zvW
	ezM2JfMle2KZG1PLoa/Tk8HhtZ4pZ4CJjypybZvWb5g75kL+RJ8qOCAKBmACiPYqyPJffJEsvLU
	/oS18qvlB02Xu3tHTSVIITranUcr9P5EOEUgVujYRvXF4NxHUvKG0njrjHhyaODpzOw3+f9N3lT
	XymrysZWq1ZRw2S0RraO7ARORsPng
X-Google-Smtp-Source: AGHT+IHUJPSTCO0Lkc3tl0LM4MP0GRen9Aqi6X5Cr/nA9CehBZZHoOGzdbOunKzCFRwHAynemmebNA==
X-Received: by 2002:a05:6808:219c:b0:3fe:b1fd:527f with SMTP id 5614622812f47-41cedb8d873mr6716411b6e.1.1752780130414;
        Thu, 17 Jul 2025 12:22:10 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:2c38:70d4:43e:b901])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41c48678a3esm1773490b6e.26.2025.07.17.12.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 12:22:09 -0700 (PDT)
Date: Thu, 17 Jul 2025 22:22:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Antonio Quartulli <antonio@mandelbit.com>, linux-mm@kvack.org,
	Hugh Dickins <hughd@google.com>,
	Kirill Shutemov <k.shutemov@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: refactor after-split (page) cache code.
Message-ID: <57a80de0-c5f8-4fd9-9b4a-fea97fe6c533@suswa.mountain>
References: <20250716171112.3666150-1-ziy@nvidia.com>
 <a479057f-5401-44ea-b3a8-dfd82b826721@lucifer.local>
 <31D32C5B-6719-4E3D-880A-666044C4A48B@nvidia.com>
 <5464ABD7-C4C9-4BEF-9E5E-21F5A18C42D9@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5464ABD7-C4C9-4BEF-9E5E-21F5A18C42D9@nvidia.com>

On Thu, Jul 17, 2025 at 11:45:13AM -0400, Zi Yan wrote:
> 
> >>
> >> Since we no longer need to make new_folio->index >= end work for anon
> >> folios, can we drop the end = -1 in the if (is_anon) { ... } branch?
> >
> > Sure.
> 
> A second thought on this one. If I remove end = -1, can static analysis
> tools understand that end is not used when a folio is anonymous?
> Probably, I can initialize end to -1 and remove end = -1 in is_anon
> branch.

Smatch says that "if "mapping" is non-NULL then "end" is initialized"
and it doesn't trigger a warning.  I don't know how the other checkers
handle it.

Btw, the only thing you really have to pay attention to is Clang because
we treat build warnings as failure.  You're always free to ignore other
checkers.

regards,
dan carpenter


