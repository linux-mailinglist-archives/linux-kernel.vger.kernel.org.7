Return-Path: <linux-kernel+bounces-860528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2A5BF0547
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676703A37E4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC1F2F5306;
	Mon, 20 Oct 2025 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="GPnV7rh/"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712AE2EBBAF
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954123; cv=none; b=qoYWnrbNFN9Aw5e0+Q4OcmsyodEXuo/eFnLZXnHDopM7ILrJHwSznWuMHmYfl9Nd1PuRUJDujWq+U0ojTuHyWnKIURx3c7M24fXR1fgWKdKSyUe7/EsQoBceI2/b4bO5qKOq+Aw/Yxj8X9en7x8wUl98nvDUYEfuKUWmGxcN3n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954123; c=relaxed/simple;
	bh=ltNi0MhEYk2msw3rWtEl8refNJjhQym3ZLbABQDdz8o=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lg3nUoyBDGfd15pJgTx0y5X6FHA8AljMAOk0X5PasmC/CdUOwuCGQX0kfN9nFJJcVmswDb2BI60lEvg2Ps3b4swoJYWV6nXG3DH0PQlOJf81xExMD0pwIzoFBIjBBAZwsHuR3a7dWr15fqgkzDfbVMbvxCv40FTjOUELoNbl3bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=GPnV7rh/; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 31E153F4A6
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1760954112;
	bh=mEBranLPBa0mzFLmxRJ9fx9ZSptWmlBhnJV3QiXyr/c=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=GPnV7rh/dePfS0J50Fc0Z4tT3PWiNoALYZOmqlmwpsE7kTC7+JLZdGnlRkHZACdmK
	 gPGvl777plLiTKZleZrukEfx2LMdbjkhWsxVxqXvgmgOJLA3THwM8wt7e5u7yMrFdg
	 AiDa1JS6RCymOFQSdhXtCqgM5Atula4LZDEhnZT9gFG6xyxusaO8Pr+Xv1tSxGdKDa
	 rvBYqBIdRRt0sX/U8MvQxARw5oXcUTTAFVji3y9Rbrsp7kFnlXIMUjPkKGnX9lhWMQ
	 ITV+R6TgoCnAQft3waRpfeCOZPZybMU000c73ebmCb+qlLf6g1DZ/HMQ530V6IGydD
	 lfC6qmiT6ICf4JWduJ579SqqbN7wJ2MpOgG1uwLzEzjsz3AOc2vgLkAmeh/TZRmQgS
	 +4CIe/U1WXsNKSapdVn7bzf87OR+5U4WJzPLHpNey0Ru2X/J+6a2vbtbbBYkVzmFW5
	 bzujJYBx5FiuUlXhCJjioHPOv94xjjpeT7lH/6+OxC5tGWl9by8lCS58CfTpIIRcjH
	 Ktn2RvRzUcuCB8wH82WeINzACHjb5jp7iNtv4sHUrO2sqan1N/bMeluOBhFGhlzexL
	 +dshKWXCQ6emtdot8ttdXM+4jfMIml2qcvsP/gAWxmWDWulQCgN5XUjPOAGLcgg58R
	 urERqNaGd+IPIODJsSHkIGMs=
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-932e3a8a82dso433748241.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954110; x=1761558910;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEBranLPBa0mzFLmxRJ9fx9ZSptWmlBhnJV3QiXyr/c=;
        b=kZwVFJo5JuTYszFG7qIk9awIp8rQEQeqeE0xu5qXJKW60+kvusEh/k25nNpSBhzMrB
         WQCW02ooYVGy4CnbSRShDsyAojsySAx9Q0KLJZY5AZw087Ai6vfli89NnoLreYcotxTB
         0dBRjYW0nEYw5UuA+5tvkYrBP2ZycM1olS34Wnt0h8Leu8Mwc+2SRc3pHTpyF3gRl9AN
         hLzHRAxlOBPON39ATRzxQBwq77BZ6ds4lat3WtY5MeI3oWAHW/luEMn8RhYPge949lv1
         iDgQw2tb9RLLiFAcM15MUEcpoW1nrL2MUUWTKwu/huLvB/AOEhCXUz+cJW/Vkx1VZMaE
         QhQg==
X-Gm-Message-State: AOJu0YyixuldGTa6NFX3JCBZ01PsOFWoC+jSENtqSvV/IrscVlfb6QQB
	iGJKdIp3HZe0UyALbqeKE/BZNF32l5OwLV1gK2ULxC2M7+/PHJ+55p9c9Tv6jDv5W3vcIrhBtQQ
	YyLHe2g5jC1BdKpXmwVZ5BxYuJl7PLC6FJ5bsMXBqCN/shMQO1c/fcoVuk1ys+K7QvQMhnCNF4P
	b+zbcmxkdESPawb3iuuO5VZhVfUBF7ionv19VRqgyp8IKwjtVsTAaPAFko
X-Gm-Gg: ASbGncuWb7Zo3mVG6/hsx3qRUkiMLCb683FZku3tl4MmDtxLsDe+QGT4RChiIz6UIJ+
	he+J39Usl0+FX58UhXeOZN2tmHsWpK6WILj58i2BzhUuhIUuR3tC31HykF5cVYO6rRHK7lhkZk0
	IffjyaUD8S9ED63dykvjkIprII8mKCAVAXMuRwl2vpVnXWquEtUeUqFUMDvQcfLvCwr9LKo3RoW
	iUUu0m0lB+VnlfW
X-Received: by 2002:a05:6102:2c8a:b0:5ca:714b:2dcd with SMTP id ada2fe7eead31-5d7ce77b197mr5090703137.10.1760954110376;
        Mon, 20 Oct 2025 02:55:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8U9dwM6qULSdCBv1qTum4Bp6zRtcLVxnBY4adzvxZNg4OxsHj3q1MDPNwZUFy1CWdBXERfTMV4CjpVWjcmns=
X-Received: by 2002:a05:6102:2c8a:b0:5ca:714b:2dcd with SMTP id
 ada2fe7eead31-5d7ce77b197mr5090696137.10.1760954110055; Mon, 20 Oct 2025
 02:55:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Oct 2025 04:55:09 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Oct 2025 04:55:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aPXAyeDC7YXAketm@aurel32.net>
References: <20251019191519.3898095-1-aurelien@aurel32.net>
 <20251019191519.3898095-2-aurelien@aurel32.net> <CANBLGczi3GeaC4aWECV8NS-zqSHgRa-5onynz9fGsZeN8qgysg@mail.gmail.com>
 <aPXAyeDC7YXAketm@aurel32.net>
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
User-Agent: alot/0.0.0
Date: Mon, 20 Oct 2025 04:55:09 -0500
X-Gm-Features: AS18NWArKI2YauisXr79VuYk9B-KtJdQQBJvjv4Xg4AX0iHaDUW4DU_PmGIO6p4
Message-ID: <CAJM55Z_BzfRo5aKf2VrneTymSizwDQq6OfMK_LNgyoGjp43K8Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Aurelien Jarno (2025-10-20 06:55:37)
> Hi Emil,
>
> On 2025-10-19 22:53, Emil Renner Berthing wrote:
> > On Sun, 19 Oct 2025 at 22:34, Aurelien Jarno <aurelien@aurel32.net> wrote:
> > > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > > index 8248895ca9038..063202923d95d 100644
> > > --- a/drivers/power/reset/Kconfig
> > > +++ b/drivers/power/reset/Kconfig
> > > @@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
> > >         help
> > >           Reboot support for the KEYSTONE SoCs.
> > >
> > > +config POWER_RESET_SPACEMIT_P1
> > > +       bool "SpacemiT P1 poweroff and reset driver"
> >
> > The driver code looks to be written to work as a module, but here it
> > says "bool" not "tristate".
>
> I have just tested to build it as a module, and it indeed works that
> way. I'll change that to tristate in the next version.
>
> > > +       depends on ARCH_SPACEMIT || COMPILE_TEST
> > > +       select MFD_SPACEMIT_P1
> > > +       default ARCH_SPACEMIT
> >
> > If it does work as a module I'd prefer "default m" here.
>
> Do you mean "default m" or "default m if ARCH_SPACEMIT"?

Just "default m" should be fine since the driver already depends on
ARCH_SPACEMIT, but the 2nd version is more explicit.

A quick grep doesn't show an overwhelming majority of one over the other, so I
guess it's up to the maintainers.

/Emil

