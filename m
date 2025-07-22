Return-Path: <linux-kernel+bounces-740455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC3BB0D456
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121C816369A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53762C159F;
	Tue, 22 Jul 2025 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cB8E2P28"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C016828934D;
	Tue, 22 Jul 2025 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172369; cv=none; b=Omm6GRXQx5YKAnBoakt5vYi0/FjbkJsWxD1GJ9MWKdspxlPlPVmOy0oTesEhcLg/7KmobG77XyzEpKEIVRSUmZv+Jp3sVdnQJFdVTwRouMvlQMJpPs9fOlw1PVdP5aTqaDhPPHn+VFDZ9KIHhFDfGTfOIxC2Xv3LZXUKjQHgKkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172369; c=relaxed/simple;
	bh=hz7FergAHV6pttxgeU3I5vc21ARJkFL1XfZptkTbRKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIcgDy/MNuIxmFGGswdyXh5E/WwgDkENNVKYqLIO4yPnT3G2Fr76O8Urk1CnAQLqUxJr/EurCbbZscc4CxS7vUG4bg/bpIVpJ/DcEEKVZfSOVj8LF1HeyU8CTl1mT8T3D5/gzcJ+hOAK3oyRGDtArQ33Rf8VKRz2Jd53zflnKvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cB8E2P28; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4e9a7b4a412so802856137.0;
        Tue, 22 Jul 2025 01:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753172366; x=1753777166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5uEarl3m6/o+HHucS3g1DD8Uh1kLqoLVobls2sEucE=;
        b=cB8E2P28HyOSqBaA6fJ0pESDp5VxD9W/HJFJcBvj4/iP6qUGElJAr/vn2QQOD+TKue
         TEsWlRY+sqGR8Uu6uE31WRxGQAx2UyQiZlYLw77sg54X6hH1Bim+G//KhfXe72ksEb+X
         4VnfuW/a6W/iOFWnBdQxtCJpe9fpNrWoBW+il3gsSugtF1ReC/wZH++l9MY82oQ1oifu
         X/yHqtoY/eZqjAqDAOsTiSCgRVqUoUt1wtNw/+u9dr7hnK0XoPu5ti/xawxpd3Nu0VVk
         aYFWuEr6GUvNq43ZLBUsFhXCl2rL2aiwI35jDVQBrY2Hqkvj9+wq4fDjzJxRN1e7SDNk
         NEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753172366; x=1753777166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5uEarl3m6/o+HHucS3g1DD8Uh1kLqoLVobls2sEucE=;
        b=dMhUY/7ZXiiOmcHhA7n66clq+F+sFZTHO+OMB0CiKZsP6EX3jU2wb8fR7BENOourkN
         qbNhaL7C9XHsR2URyn1RXqZ83b4vuCoUxg6Z7UJf2Gn91phacQO/Pm2bqxHgHZ5+PTe3
         5bvix5TUkFUWYCjkeXGzL7+U1YVPyaA5I/BnvDSD19Z9YZBCupsiW6rS1UACUHhbh7X1
         2S9pwHNYEWdfUpDj1JwV7Q09J9/KDtUhEEDJBZhlGQdfn92Oo5BZD1uU2Cwv49EesFJR
         GpKuue1XiY6PE4DrYJjXjLZ4p5IvCXfDpzI190xsnvaEl6rhdjUfBrgiXmnfs31mapD+
         HTHw==
X-Forwarded-Encrypted: i=1; AJvYcCVodeuhCexi87aOZ2phcxYb7CBqHX3BErjVUWVM0T9TqdLlK2/7rbQymPRR5TJi9CW47UWJ3xWUqy8JPoVs@vger.kernel.org, AJvYcCWiibW4xVzaAdAPKyzf6VKQVTJp+cPI67TGxAkYPQjwcgpA3tT8JV8WTQXba1Ylpw+2mra63voCbIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/dj+Jz5VT8XXcV8h4JTG0u15quWM9gNLBKUZQvN5USASF+oQ
	+3l/gRw5BETQYQWg0JNBnyjfTc4tJcmGA4wfh5wzAQZUzwy4OCMVEs9rZvhO1cD/CWFF6SqaLXD
	/j8r+yy80GVM8e8N2606e5gwqzPwmv28=
X-Gm-Gg: ASbGncsQ3uR7JPDFS0PojCRWgRbUJ91/xAXlSyObEAvlmXNDSaa5QpaPwhEE3lhoxtp
	yyrdKsxPBnTK+tcmXqnuk1MEeS4IBttlat/d24cFEtTl2QjM7zOLCZLRPRlSi1VbkzVGifjfYGE
	TQ67wLuWtRFJpYSmb0RfLFQZjl5uthJ+wOyBpertxhWchlmgU+vTeMe5dLbu5rc8A8hHs1d/c9t
	Wljt0I=
X-Google-Smtp-Source: AGHT+IEnf6eJQ74gAkSS8lZskiicRVKUaqFZPHtdp91Qi7KcUaT1i48pIDIZaagumwQ9M+juK5jzXPuLAJ1O7NmJyHs=
X-Received: by 2002:a05:6102:e14:b0:4e9:a2bd:b455 with SMTP id
 ada2fe7eead31-4f95f3c4676mr10913265137.14.1753172366543; Tue, 22 Jul 2025
 01:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721155530.75944-1-lorenzo.stoakes@oracle.com> <d54d1dfb-f06d-4979-983b-73998f05867e@lucifer.local>
In-Reply-To: <d54d1dfb-f06d-4979-983b-73998f05867e@lucifer.local>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 22 Jul 2025 16:19:15 +0800
X-Gm-Features: Ac12FXxom8CXi55J31hHCqL2RSaeqJyDgE4F3wONdD9d_5GA7Yp3rbkesesv0eg
Message-ID: <CAGsJ_4y9rRC54E4sma8fhZSd3aWDY2ubR+o5Et=cAeK9+gmOgA@mail.gmail.com>
Subject: Re: [PATCH] docs: update THP documentation to clarify sysfs "never" setting
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 1:34=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Hi Andrew,
>
> Could you apply this fix-patch? It adds the caveat regarding MADV_COLLAPS=
E in a
> couple other places whwere the sysfs 'never' mode is mentioned.
>
> Thanks, Lorenzo
>
> ----8<----
> From 7c0bdda6a633bc38e7d5a3b0acf2cef7bdc961af Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Tue, 22 Jul 2025 06:32:18 +0100
> Subject: [PATCH] docs: update admin guide transhuge page to mention
>  MADV_COLLAPSE everywhere
>
> We previously missed a couple places where the 'never' mode was described=
,
> put the caveat regarding MADV_COLLAPSE in these locations also.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

LGTM, thanks!

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  Documentation/admin-guide/mm/transhuge.rst | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index 182519197ef7..370fba113460 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -385,7 +385,9 @@ always
>      Attempt to allocate huge pages every time we need a new page;
>
>  never
> -    Do not allocate huge pages;
> +    Do not allocate huge pages. Note that ``madvise(..., MADV_COLLAPSE)`=
`
> +    can still cause transparent huge pages to be obtained even if this m=
ode
> +    is specified everywhere;
>
>  within_size
>      Only allocate huge page if it will be fully within i_size.
> @@ -441,7 +443,9 @@ inherit
>      have enabled=3D"inherit" and all other hugepage sizes have enabled=
=3D"never";
>
>  never
> -    Do not allocate <size> huge pages;
> +    Do not allocate <size> huge pages. Note that ``madvise(...,
> +    MADV_COLLAPSE)`` can still cause transparent huge pages to be obtain=
ed
> +    even if this mode is specified everywhere;
>
>  within_size
>      Only allocate <size> huge page if it will be fully within i_size.
> --
> 2.50.1

