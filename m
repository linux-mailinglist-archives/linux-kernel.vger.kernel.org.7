Return-Path: <linux-kernel+bounces-899195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AFFC5710F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D873A559E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9CA334396;
	Thu, 13 Nov 2025 10:55:32 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA70333740
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031332; cv=none; b=PwFqgK3B7rhIqBeC4oK+Wgle7im47ipciNcT2Ki0CO1lUc5ExjiPc++m3tiQfs1lxf4itO4M8jQH0JBwNxhKq+ecfW9Jd+zZ27uSx8xnLoh7GLj3nvVYueYEZflu2klbR4hDq9VA0k7kCUkP2cqL/RHHdLobDeGzKpFwPwZDe+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031332; c=relaxed/simple;
	bh=oYLy6f12Q2Jboam6/0ZuloRUuDWcgvKk36LE2LNyfbo=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWk5ErMnQwrIstTUUKzOZ29Usu5JRO2+Ikp6+YskLr1xgTHEF/B7mkPX7gEgcEGJvJ6vNdkGZTX8MA5RoZdwxm0EtW7GeyEIkkxFG6bakYMMJFW1clyx2PxWrYQIGigFRwNe7KWGkowZ13emk7QDvy5zHor7IPoj5LOIQrh1iWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=esmil.dk; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=esmil.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7277324054so85158966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:55:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763031328; x=1763636128;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYLy6f12Q2Jboam6/0ZuloRUuDWcgvKk36LE2LNyfbo=;
        b=qS+EiwvQxcaWFYvGoN00q9R+MiqbbiQOJH4xbfm7S9cfhTpFUBSOJZaDsZznRnrV56
         ZajLYPy65E3aZwYlLcbvI09fuuUcvKa0vrU7YbORxxXYFNZXuYIzapGklf6UheUMiwoN
         gRtCpRNjoaMtMvXD8TwiV2thZtwQWDEpoWCoLs5JsE6Q/KGe4NAJm/Tdfc1A18Jfn+u0
         Q697DZ7jgVzeW4mUxrxX+No4nY8CtuLUNdCMvz4jJj/nR3ch/EV1FHBZ8BqT/Opx/ZKH
         1hsJPn8EU29D4tyih8JrFRSnzzKWJhB08HUp/ou0LTTrQbA2C/oOi4pP7Sy5yptKGDyq
         Ct0A==
X-Forwarded-Encrypted: i=1; AJvYcCVynUq+s6+RTby/bfskwiZT1T9Ebu6d2FVkL1w7T6Qp4msMv05jhO+9DQ/p0FgHWlQXkmvuZJgF3cfXaIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDwG//ukLvbn0MJv/E69tR+PYSFgopeNuvEJkjZxDdnuO8adAG
	k2YTrDMe9ZIfYlA7w87gAlfQZVt0XLm93i5gIduEjVAKbi7k7fzBVjHP0N5x9nqlTmA9NLA9COU
	thZowaatS5rgFgg/2O/BjfoOztyyD55yD7A==
X-Gm-Gg: ASbGncvMlq0GOVImp7MI/capCmDV4ZtNdPvQmbTPGrXSQJVoU05G1zI6uE/ExMnSgPo
	ZJ5rYDveDxJEGZE7zO4UzwBWDk58cy+V2YV5wL2DBRrvj2HHD5UnnSyj2QCELyXpBeD06Hb9afM
	syuA0hNGu+dhuHE9QU3QKJJewEQlRX7lliMcmytvNoLWO56J6TmCEJSpBZ/WpTDYe3272r5Q7Rl
	copetDw55l5MskvoMAbTGj78jLEA5gNjvUnUkeJLaRjJaw4BmDO62r2GxI=
X-Google-Smtp-Source: AGHT+IFCyVqsw2+mgz8mfuCEPNfXp0t+5XcyTI715hdb63+s/UhCXEFupENodKnAqz5ba3myi1+u0of84SAgLVZPwRQ=
X-Received: by 2002:a17:906:dc8c:b0:b72:a899:168d with SMTP id
 a640c23a62f3a-b7331a048efmr738157166b.13.1763031327797; Thu, 13 Nov 2025
 02:55:27 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Nov 2025 02:55:27 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Nov 2025 02:55:27 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250930100318.2131968-1-uwu@icenowy.me>
References: <20250930100318.2131968-1-uwu@icenowy.me>
From: Emil Renner Berthing <kernel@esmil.dk>
User-Agent: alot/0.0.0
Date: Thu, 13 Nov 2025 02:55:27 -0800
X-Gm-Features: AWmQ_bkFwDX5GCFZoiVVhocVq5p5vwtP3bOMdOUIgJzbGU6s45NPbnBPHC3DIsQ
Message-ID: <CANBLGcxoD5w7ApN9mNHWym2oo5XscV7B0rrU5MF68wiS52Eecw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: starfive: add Orange Pi RV
 board compatible
To: Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Conor Dooley <conor+dt@kernel.org>, Drew Fustini <drew@beagleboard.org>, E Shattow <e@freeshell.de>, 
	Icenowy Zheng <uwu@icenowy.me>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Michael Zhu <michael.zhu@starfivetech.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>, Yao Zi <ziyao@disroot.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Icenowy Zheng (2025-09-30 12:03:17)
> Orange Pi RV is a newly released JH7110 board by Xunlong.
>
> Add a compatible string to the starfive platform DT binding.
>
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>

Hi Icenowy,

Thanks for the patches! Now that E's patch is in Conor's
riscv-dt-for-next branch
will you be sending a v3? Also please add a cover letter when you do.

/Emil

