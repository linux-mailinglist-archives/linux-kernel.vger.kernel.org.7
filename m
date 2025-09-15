Return-Path: <linux-kernel+bounces-816856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1A4B57970
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6666B205BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7A130147D;
	Mon, 15 Sep 2025 11:54:44 +0000 (UTC)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A0630101A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937284; cv=none; b=KoQie8MSp9jqNi5iy5mtdLsl4PkzA20pdnfEMUzSC7dLcqRrHyVaS/l7oAo5TJxjN/uStTkhpgznK/l30/z2pCP3Df0XdLy2g40I+Zamcon4TAz4a7qOjR4OIxMeVRq/3kyM4MZXu0PYTaKIjj9sKeQk0OaBDPyIHGpF2ePEMls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937284; c=relaxed/simple;
	bh=X1mJ891dQWSYdtfoPDMNxd56dDiE4l7XqS7hxKPA0zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkCea+g2LL2Rmd0ABx11fD1CusEbPUBnP3xzBOd07xg5gghoqAV0+NmGgkEl/5tgzS7PJC+CLr1rMujlwbprPFvWydLusF4md9X2BR9gzS6+D7nNRYW8wbODOmbwk1ANcg8yux+ZguHQTrchgKb2aD9swMWG2wgGhWz9KR5B1hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8dbe7c166a1so495499241.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757937281; x=1758542081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8j9g6khBudlWCULOd6eX9KmZnbNuYyJvR9k6Ybie28I=;
        b=Q5Yrqr5J+xOAHZdfI4DqoN+ZjNpUzL+boerbfQ96T5jOK/S/LxaOzJ+LehGIDJFp47
         m+4YIfdGX2mzrhEGt4cfdDP9CqNhGV80GmFJ3cAv+3ha4nPhDSe9GzQFdcpaBhArY+Ab
         mrFQKxt/h2ojrrKydbu38XHJaQJa50ACJyG/pgRGnBeeAPxsCoDPYBcOJ5Zby5NGWSAc
         IPO0+ZWfZYRLq/qQzsIJ6Il4l3H2NLjA1PdJXBzRwgg6V6fQR93bYIARRECzCQsuuaId
         Z2OcSt4LTWudCoImjck8zoD80snWyYzvIQu+i1KSzLGFWhJ53bh9CecjzhB2m2WMjlqo
         2crg==
X-Forwarded-Encrypted: i=1; AJvYcCUFHSJZA/NZ9JWMb7ztt+RjL2C9M4Q7rHfdYUAMWtt4y6ARI3N2hUywkMfKKapXW8z8Juj2SU5LOlfo/u8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuExhNFV4Ezyz1SD3IADqpJQdTuCe/USAZ2LEktcqWvEpsP2sA
	iIc922cJ1voceFH7BagBI2kyuMdcL+kncSGkr/RMGxQPgmV4KVi95H8rHLN1mMuw
X-Gm-Gg: ASbGncvtPfJ4P2NOS9t2i2vRYdJ8SgiL9Mn+p3L/KMrTkxhtAOhgHqfA4qhJ3xMn2nu
	6v4MYgVK/yzI5pNRCxOmupCdbVTlyQft3Xr5VxNIA3BZBv1mJD8DP0doizv7tvkd+3DTKiyMUbI
	1vtA4r5XZk/fwnB2BgLhzsldSVHeBsB1klYqbiKTTwg47K3utpIp5zMBYPvohynleL4okuG3C76
	kRYNRA9sv1IVBjPvMQaMGi/wbFl/QYzS5RddXMAoGI0GTs+zFm8pbOuyIYSRVBhqolJaLiBS3S7
	5Ug1o0+cwqC5rPqCNdABexh1gjoPWH/yRrn8AV7YmmHagQjpVTK/mxdKdHnXKN/tZn2HTuAdCtg
	sb60l6hWt537RR38Q8Lr8p+FzSyg3KpHHYUGyRonocuvhGFKW+ZueTzq9htlE
X-Google-Smtp-Source: AGHT+IHWYg5uucDnIR1SvAk/AYSR7t2r8rsy5wT3jsvAWNC1ZaWfIc6wP+xrGongwAUbNzWD4P2QLw==
X-Received: by 2002:a05:6102:549e:b0:4e9:8f71:bd6e with SMTP id ada2fe7eead31-55600b2aa3emr4181675137.0.1757937280383;
        Mon, 15 Sep 2025 04:54:40 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5598571bbc0sm1808173137.2.2025.09.15.04.54.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:54:40 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-52a73cc9f97so1321449137.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:54:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkdSAcADjuvtruTDm45CJENUvnsFoCk7tBnHcw5eaEr4SeEHFcoghSAxZskG1HS36Znbi3lY4E0z4U9Dg=@vger.kernel.org
X-Received: by 2002:a05:6102:8098:b0:527:4113:6ad6 with SMTP id
 ada2fe7eead31-5560a10e919mr3310852137.9.1757937280011; Mon, 15 Sep 2025
 04:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728071452.35171-1-jogidishank503@gmail.com>
In-Reply-To: <20250728071452.35171-1-jogidishank503@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Sep 2025 13:54:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXpn8VhFL3RF_NEEdK3-VuHuHHZ6PFBcJi+kYCgbnwL8Q@mail.gmail.com>
X-Gm-Features: AS18NWBDv-eagQpa9zzAr9IRsIYBMwlArzoXlxqRod7XiXKpYRxYZJ8lRHiHNyU
Message-ID: <CAMuHMdXpn8VhFL3RF_NEEdK3-VuHuHHZ6PFBcJi+kYCgbnwL8Q@mail.gmail.com>
Subject: Re: [PATCH] zorro: remove extra whitespace in macro definitions
To: Dishank Jogi <jogidishank503@gmail.com>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	darshanrathod475@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Dishank,

On Mon, 28 Jul 2025 at 09:15, Dishank Jogi <jogidishank503@gmail.com> wrote:
> Cleaned up the formatting of MANUF and PRODUCT macro
> definitions in 'drivers/zorro/names.c' by removing extra
> spaces between macro names and their parameters.
>
> No functional changes.
>
> Signed-off-by: Dishank Jogi <jogidishank503@gmail.com>

Thanks for your patch!

> --- a/drivers/zorro/names.c
> +++ b/drivers/zorro/names.c
> @@ -36,21 +36,21 @@ struct zorro_manuf_info {
>   * real memory.. Parse the same file multiple times
>   * to get all the info.
>   */
> -#define MANUF( manuf, name )           static char __manufstr_##manuf[] __initdata = name;
> +#define MANUF(manuf, name)             static char __manufstr_##manuf[] __initdata = name;
>  #define ENDMANUF()
> -#define PRODUCT( manuf, prod, name )   static char __prodstr_##manuf##prod[] __initdata = name;
> +#define PRODUCT(manuf, prod, name)     static char __prodstr_##manuf##prod[] __initdata = name;

You missed removing a bogus space.  I will fix that up while applying.

>  #include "devlist.h"
>
>
> -#define MANUF( manuf, name )           static struct zorro_prod_info __prods_##manuf[] __initdata = {
> +#define MANUF(manuf, name)             static struct zorro_prod_info __prods_##manuf[] __initdata = {
>  #define ENDMANUF()                     };
> -#define PRODUCT( manuf, prod, name )   { 0x##prod, 0, __prodstr_##manuf##prod },
> +#define PRODUCT(manuf, prod, name)     { 0x##prod, 0, __prodstr_##manuf##prod },
>  #include "devlist.h"
>
>  static struct zorro_manuf_info __initdata zorro_manuf_list[] = {
> -#define MANUF( manuf, name )           { 0x##manuf, ARRAY_SIZE(__prods_##manuf), __manufstr_##manuf, __prods_##manuf },
> +#define MANUF(manuf, name)             { 0x##manuf, ARRAY_SIZE(__prods_##manuf), __manufstr_##manuf, __prods_##manuf },
>  #define ENDMANUF()
> -#define PRODUCT( manuf, prod, name )
> +#define PRODUCT(manuf, prod, name)
>  #include "devlist.h"
>  };

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v6.18.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

