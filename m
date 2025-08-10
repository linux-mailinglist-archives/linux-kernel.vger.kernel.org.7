Return-Path: <linux-kernel+bounces-761369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD17B1F8E2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 09:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47BE41899E60
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 07:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFE01EE7B9;
	Sun, 10 Aug 2025 07:34:06 +0000 (UTC)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880C44A21;
	Sun, 10 Aug 2025 07:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754811245; cv=none; b=Hsg67UhQRUOBJxLrXxEAk3dKYwEw8rzg9/FJVvdE0jFAeegpDIb9ZZa7re4C4QVjTevHdQc847HUNFlqD2PuZdePvwaThs3Vn9IJYNH/TN65isyqdRJXJxizlMRsASjasC4O/FUILZ+53204cKD4tqT3reYVoyntWkvr0cob8QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754811245; c=relaxed/simple;
	bh=xwDCfS4A04WfjmLFHkrpS0QrCC1isG9MZNjnxI1Os4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+mkVj3+lFKNmdvT6gKRZ55Z3JXFP1ABxF42iwa0n0NOrc212tLgzDvE4C4cDkq/oNuab8ROmB+mJMVPjKEZN7c/gKVISmI8Pwnnh6FQmZzL2kSjjWGBhmfbtCoSzMqOljlm0j/HQuYVuADmu76HaWy9yFwV7nQNgnPdewwSqZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4febcc4c93dso2780646137.0;
        Sun, 10 Aug 2025 00:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754811242; x=1755416042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1x2PhzoBNX+uaq88L79zI+BIBgIzC4qRXmSyVMDstI=;
        b=Q3Bd52wsPVIcQV3LHDUc9tjr4Cier7107SBQNddwqLcHrUWpQZLQfx1GQFCZFWQL63
         3uTnZ1bDiKoJ027KwXsXq4QduxJQTxMuo09IgUACB0n/ez+dEU6MBf57sIIyY/qe8NTD
         y+1TbIcchAhjobWVIX5/iLoRexu5O9l5WuVru3/iVY40sLIH/xcH4R+s7AnXnsk7A6JP
         +i4EmHjiPrI+jTQBM/+kHN/953BxdoRtpBIXiDyWXxknbgfjre9AgFNjT+5sAwKFUcWi
         o9ErHBEo7e3yBGWVX8n6zqmks1sp6AHov41KMTKdyGtOiW+jBieR7Qpk038NhdHCTFhY
         Xadg==
X-Forwarded-Encrypted: i=1; AJvYcCUzFX1njcGW9pkJTmwUMztnZBy/DgTJstJwETaAZQKundjYVC/NYokKGpeK3UJTRlX3y+jj7gmIDn7QrGmv@vger.kernel.org, AJvYcCW7JuCPcm7wyEY1yNqs5QjpW/jaezJ5rsmN4IW0Z+/PSqRumxvLXaoMLoTo97POsXPGqNA4Pv3cDPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1DpCLlQHS0fdPrVrW5ObzBigTHTOYpD65Ue6Qdz/QDLv/sWbY
	cpRBxT7/8gTW2sq8n3w9Db6Qd/6HJSL7dnRvc8ruzeGBS0sbLQsGHLlf95JgPtK+
X-Gm-Gg: ASbGncv8OPo3/PeNkLkyRQ4pB4vEibEmoKoeL+bfzEiePcC7hWMmzTiSvHeQIax9k6l
	UiGHaP5mGWT8Nw3JtYKarLQ6SMzgleLpSrMHSJSLSX5Iae0odVN8QJOuvO9TEhcedqfSc+sKoZR
	PbV53CrsJ0njCkGeNAeDxVFArPrNaAOZdJT3kAe3KKP27SuWhHOyU+LXrLM5ZD3V8bxF6NvmZOu
	R/7vY+W8cYoQ/TTVC2I5AcaMczlaKCAWzhS6BJ+NtcvJx+n82No46DQApnZ90n+BNOZfYW2YBq+
	IDvI4FAxchbz7fLwXD8wdlC96D4D+/wVN82J9k2WR1LCcd/CoA4pBuhXqmwR+xVP3Mq83Y0M6JF
	hdog4atuxxTEauHP/FoBIuD0+RWGTFZ3XAk+C7N6aNJGowuApaP6c2ezRp9Dx
X-Google-Smtp-Source: AGHT+IFJKcC7TJNECi1PnF9doH43N5z0NpORDnFziQlF8AFJ5pEnhFTJCnDIn33YwsSZkbg2nEsZNQ==
X-Received: by 2002:a05:6102:330d:b0:4e5:5c14:5937 with SMTP id ada2fe7eead31-506231f1ee7mr2927014137.1.1754811242050;
        Sun, 10 Aug 2025 00:34:02 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5062bc4f1f2sm1213286137.15.2025.08.10.00.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 00:34:01 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4febcc4c93dso2780639137.0;
        Sun, 10 Aug 2025 00:34:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVL7p0JGed6X0yZkgmnysxh3CTGDuc0U8db58JE/peuCcYLs+E7WrP5ExTQYtxGgVjtNzMkJSzHifjyxe4h@vger.kernel.org, AJvYcCWKRT8OctbZV+KdSsDyqlerMAMxFCaP1CZj4Qv6/aaXNO7AirmRmQL6MkHaZTTEZ/ktCXjZ8dAzH30=@vger.kernel.org
X-Received: by 2002:a05:6102:4b09:b0:504:d7fc:d970 with SMTP id
 ada2fe7eead31-504d7fce8ccmr5111272137.12.1754811241147; Sun, 10 Aug 2025
 00:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <07262c55e82fc4a3e3dbe7c45713b14955271e7f.1754552156.git.geert+renesas@glider.be>
 <aJcbbb4OVK_q2VkU@smile.fi.intel.com>
In-Reply-To: <aJcbbb4OVK_q2VkU@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 10 Aug 2025 09:33:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXF_Dto3EVBKxr9+M=rmcwNcZy66aUqbb5OiRb75vSfnA@mail.gmail.com>
X-Gm-Features: Ac12FXwGgzS1R8tErAwY2YGYM2qaGffulr1FlL4YL6iDAqzTGK-BqExfdLaEPI0
Message-ID: <CAMuHMdXF_Dto3EVBKxr9+M=rmcwNcZy66aUqbb5OiRb75vSfnA@mail.gmail.com>
Subject: Re: [PATCH] Documentation/printf: Use literal fwnode_handle
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

CC Sakari

On Sat, 9 Aug 2025 at 11:57, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Thu, Aug 07, 2025 at 09:36:01AM +0200, Geert Uytterhoeven wrote:
> > When looking for fwnode_handle in the printk format documentation, it i=
s
> > only found in the Chinese translation:
> >
> >     $ git grep fwnode_handle -- Documentation/*printk-formats.rst
> >     Documentation/translations/zh_CN/core-api/printk-formats.rst:=E7=94=
=A8=E4=BA=8E=E6=89=93=E5=8D=B0fwnode_handles=E7=9A=84=E6=B6=88=E6=81=AF=E3=
=80=82=E9=BB=98=E8=AE=A4=E6=83=85=E5=86=B5=E4=B8=8B=E6=98=AF=E6=89=93=E5=8D=
=B0=E5=AE=8C=E6=95=B4=E7=9A=84=E8=8A=82=E7=82=B9=E5=90=8D=E7=A7=B0=EF=BC=8C=
=E5=8C=85=E6=8B=AC=E8=B7=AF=E5=BE=84=E3=80=82
> >
> > This happens because the original documentation talks about "fwnode
> > handles", without mentioning the actual type name.
>
> Fixes?

If you insist...

Fixes: 3bd32d6a2ee62db3 ("lib/vsprintf: Add %pfw conversion specifier
for printing fwnode names")

> Anyway, LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

