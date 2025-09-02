Return-Path: <linux-kernel+bounces-795679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF059B3F652
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B963BAA23
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C44B2E6CA1;
	Tue,  2 Sep 2025 07:13:40 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A692E62C4;
	Tue,  2 Sep 2025 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797219; cv=none; b=OhmE51Hr0UoDzQb5JBOOMDlb5UF2NHvs6hugLOo28bOdxHPnYHG5kxkOX/rgV8HWL8omgaPHfsUVJW0wYLufXjLUhDTemTKYaUVA5x63bfPKgI51qlUkTepY5ztfXGns9Ru4ekYe/PxrB2U+UGNw3dOtiW1qLbOOFbfXbZLaCj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797219; c=relaxed/simple;
	bh=XXNkXfSWHAMsZsRMbnieS8yzgBPKQfuddCQqDFlJ3kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nn+tT+YI0u0vqt6KeOrq55QzlDysWHLkDxMtWpOAS0o0j0erINNpQwqPVK0pfsSzjzIuaD5RQfov5KwlcSUfrTa8Qa+QPRbKfGEvhY9mA+no2e/wwnWZRlCCdjdmY3YAUjAcYHJkIPo2EoJF05r8A5b7QxXyUNEcfiIZtZi41RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-89018ec3597so3468205241.0;
        Tue, 02 Sep 2025 00:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756797216; x=1757402016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mE32I1yHiQZXPGTS+YnBz6VXurSVbO+KUPDupa6KMmI=;
        b=Zcda6Dj3PMGesiNWsa9DF0GXzU3yxScc8auIz0PCMRI4BMweYB9ac+g81xLAfXzNON
         QjimMJDoGoTrWY3hOhEUy71qh8l9JoFk45P5NmANAbzaKCK58z5nCXCWUGkFIP+dyr5y
         WQilA0cLBPK+umfeX6VYcY4uvXybFZMLf5yfsFGjRM2FEzQGUFbOdnFS25NsmPyN6qNQ
         4qXBS0z32GoxY7gGeaNI0sOgTO+McfjGEvTeS79s7z3oW2XL1/mpHU8XM6aiH3wXVVdc
         MdBamvSiCAg1+8XYwR3MEG2qa0V/I7VzpwhD/0jNXbx/y+qJ4aLsiEpOfmWv5uaE0izl
         te9w==
X-Forwarded-Encrypted: i=1; AJvYcCUPw736m6mSPccMTcZ91QUrsT6i9KYcHHNyf5ar+8DJ5Sj0U2HezhrXXi2WcxCrq2gO4/oZu2KG7ks=@vger.kernel.org, AJvYcCV0I7lhdaY3LhyyB/Eby6kvIZHb6UQAbVQCqJ2mPQOzFtC4oI2fkl6cssUVV4dfeutirAsFFsxLdRWTNJmV@vger.kernel.org, AJvYcCVxVlmr7tq3MTzrEHr0mi0mjs9Fbf612AM6NrUYT+NV3Tj+YeK9O3yUCg1TTV6KKciDQ0tlnLH9aApp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+mVBvu0kYiOOKOGyF3gU926bXmCKauDIGTD+bwUsh0sMVMTYG
	ITc11MPizUnRjpl18ftDiT5sVWzfN0qcTVdlj+rS8qso5clGJLgw9yOSNRJnFMel024=
X-Gm-Gg: ASbGnct4U4OfgOq9sEVWBwfFY4kunwIX3cXciwHMsBgixVg5ZEEISAcMZWtMdyrOCUQ
	lVdkHiJT1LUeUrNqBCB+nmBNDsLlkH21p5fQ3wqrdMv4CxWEGaCIHUFGk8vWP2QRsXWdAAaryqu
	V3zSj3XSa8IfeaFnMhd/A9a0XuM+u4vHQ2u3Fh1+alrJpsIxq7nLj0n8xkcTzrUMHxyCFVBNixp
	4yfwAoOYxnkO6TPptGrOSK/s2RrwiDV8iY5yrrr3mzvpGSjC8FI113kKHv7oez+lCQu+1eMqsXo
	BUjere7P3fHwEWkfZEVHAYPtoLU73t+usGxxqLO5+KQXuq9JQnA3l3uAfrPPGUqXH6lBqXPC0ec
	EZ+jwZctlcVv5F79Z1eFUyOYVdAz4bTMuzGXRU1udyPN+nCYgPZtE+dArbMDO
X-Google-Smtp-Source: AGHT+IFfhsj1vxTPkvP2hXaz0AUZ3iAkz96+THWLZtOMlwkaw0ZfilBXt9tvQQkfkQl2Q9srO6ZLjQ==
X-Received: by 2002:a05:6102:5cc2:b0:520:ec03:32e9 with SMTP id ada2fe7eead31-52b19333ff7mr3383174137.3.1756797216166;
        Tue, 02 Sep 2025 00:13:36 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-52aef78805fsm4103437137.6.2025.09.02.00.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 00:13:35 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-50f8bf5c518so3161293137.3;
        Tue, 02 Sep 2025 00:13:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVeDZPDZ6FQt19PZ27v3Qz9liUIx/QMCr13N2eKxNNcykadfULzjXXWJaubf7vY9vcHuNrDELv/ImY=@vger.kernel.org, AJvYcCXpOPtg8EXOFqHVki6K9LExFCs/QpbijNLH7Aakca0Yi9G18+bolWLIynf8T9TgrLRJNpaRP4mHMEJv@vger.kernel.org, AJvYcCXyj6fQvH1fLe//ikScWlmX4a1cR+NnX6OiNoX2adTKYQhC5aiI5YtCEtxA7h6/RBPbI9cF1fJzZBPaF9WO@vger.kernel.org
X-Received: by 2002:a05:6102:4447:b0:52f:12b3:4505 with SMTP id
 ada2fe7eead31-52f12b34fcamr1502462137.23.1756797215603; Tue, 02 Sep 2025
 00:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831150710.1274546-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20250831150710.1274546-1-harshit.m.mogalapalli@oracle.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Sep 2025 09:13:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXSNoXjxAbALr7O_dD_btJDGR58XaDa5=bd8NmL50wcaQ@mail.gmail.com>
X-Gm-Features: Ac12FXyho3YVyxnf7k4Y7VGNuFMgz1R7B9ouB6HMvFtprPxHFCuwjVRd51bItRM
Message-ID: <CAMuHMdXSNoXjxAbALr7O_dD_btJDGR58XaDa5=bd8NmL50wcaQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: dev-tools: Fix a typo in autofdo documentation
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Harshit,

On Mon, 1 Sept 2025 at 17:57, Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
> Use cat /proc/cpuinfo as opposed cat proc/cpuinfo.
>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks for your patch!

> --- a/Documentation/dev-tools/autofdo.rst
> +++ b/Documentation/dev-tools/autofdo.rst
> @@ -131,11 +131,11 @@ Here is an example workflow for AutoFDO kernel:
>
>       For Zen3::
>
> -      $ cat proc/cpuinfo | grep " brs"
> +      $ cat /proc/cpuinfo | grep " brs"
>
>       For Zen4::
>
> -      $ cat proc/cpuinfo | grep amd_lbr_v2
> +      $ cat /proc/cpuinfo | grep amd_lbr_v2
>
>       The following command generated the perf data file::
>

One might say the path depends on where the proc filesystem is mounted ;-)
However, all other documentation (except for two occurrences in
Documentation/networking/proc_net_tcp.rst, which you may want to fix,
too) assumes /proc, so it is better to be consistent.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

