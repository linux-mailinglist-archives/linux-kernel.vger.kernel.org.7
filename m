Return-Path: <linux-kernel+bounces-831946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CE0B9DF5E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7F04C1DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD02326AA94;
	Thu, 25 Sep 2025 08:02:20 +0000 (UTC)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451002343BE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758787340; cv=none; b=T46mVDEfo82OTBof0Owa0Y2qxS4O9xkGW0QBcpD2smEp7c4a3Af4P0xWLgfRypm6T7H1Is7yC2f7WhB5uNOsasDfYbjo7iFmKLMCYvfNE2HwhjaqmDlrNgfyZzOXIfMBW3Y45dzyEahFc83TwkYLG00L0S49BMYzOkl0/Myb3I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758787340; c=relaxed/simple;
	bh=NdLPCWYGKs4Nnl4f/TPtkkAAU2xiHmYr81MGuS2MbZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9EuZrBxnGU8a5nfkFlt+9K7lVL22YUY354LuACLF8hl5ncrJOBVBn0TlZs2Omnv7gg2h1H9fld8lLSBCX3b2jHcdJS7GmLlbhqlFw4REhK1M5SQEhpkEWw0T6YcwbY/elnC1nm44GkuDMrtKnGviK2hWjAPlRx1kOFp6kpGs5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5997f407c85so237584137.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758787335; x=1759392135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUcMlfE8b4AOAO2p/aFN45tB3uALYO0TSoBHD4chZzo=;
        b=ivIHRrGvUktTNwVuzCoGwso1H5oQZMCLW8ijmGjh0JCyge8RBfQG2YyN079Qj3l4U6
         E55F9FG1AXy6JzdVQfSr1EidNBPVdIz0moQ9sY8PPGsIEtschWz58kn5izyQohGBDa4q
         WQyVbuilCZJAigF1mIeXG8Ytyt+Pj8Hg+rZAUhXivlUwmSjBYWQXOJCAZwocKNZDK4kW
         QOjUh7WTI1Mp2tltERgd5Z5b41gR6jtzMm7p7xC7P9vG9ARjpV2VdcY10SW7tSYxe8Nw
         bb+kK68pXHWx1Csipgy52HUwRMACjTGrD7pK1tt0iz6Q3047beFR0+Gzj0NO8EZdnsto
         lrTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhR4oNqxvyMpAFYBOWBDJhPidp0H+OjO29j9AKcZFEn5FnJT306fHzgYz2I5wGaxs8LY0BOS3Socf8PNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQlKR2ml0xfJU+pTn8cwC39fL9b8KJRPYCy1mypXHY+oUEey9v
	ntGU8QU1g5KV7OtVt4mCQdzezRWUBHT2OjqiEW1vVL26xi0UE7XSa0uDUptvGvG9
X-Gm-Gg: ASbGnct4G8BeT096MWQXD08BnMHY2xeWUCtZNJsAGDlaQjYuLJlqOtktoHok/f/Oyrh
	PI9dXr+NPfewj7ykBgra94Un+6e51xqKVLn6aV7GTMYGCdMLIjY/ZNlY86JWqJp+Cbybrq0QcnG
	GSFWUfm7VkJeRDT/7arEw1k6W7YLiOfq6vXtCEeiWfnKFKbqFTruA2XaOZqLMDfKwXJaCboOrb6
	kB7Lmb4udu8DQ2nLEVn4bJNo4e04vuO6uw4Zs7WcfuHv/ZmLGIxSP/eMBquI/5n++DrAWuZ+hL/
	NWEtjgoTQYQ2eJkzV3PQ64GmEn2Y1So/K4UpfVw7eG3X6SLdevCIEFgEqQe/k4VHzEAx5zNDF+9
	0m+NNPiul/URjLHsgAEtwH4fdtMINWLrhkJTPIzGw/3mkOcVWhs/6GlYkFB1az/d9
X-Google-Smtp-Source: AGHT+IFN6jAtsJVphyY4WoNIbz+IdQoe795OWL3z0Pucfc1/VcMinON7rprp35IYMeD5z+xrwlER/w==
X-Received: by 2002:a05:6102:3591:b0:520:4054:6b9 with SMTP id ada2fe7eead31-5acc604a9fbmr1136523137.9.1758787334736;
        Thu, 25 Sep 2025 01:02:14 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ae389da765sm361826137.11.2025.09.25.01.02.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:02:13 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-54aa4b86b09so411351e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:02:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwzbnGVEIL7cwwnzszxHhdn661utynxoCVd/vLQIf5oBDdBi9yv127X2z7oJteGLbLNhzcSoMbImTBlzo=@vger.kernel.org
X-Received: by 2002:a05:6122:90f:b0:542:2912:664f with SMTP id
 71dfb90a1353d-54bea2f2d56mr980779e0c.10.1758787332548; Thu, 25 Sep 2025
 01:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-make-compound-literals-normal-again-v1-0-076ee7738a0b@linaro.org>
 <20250910-make-compound-literals-normal-again-v1-2-076ee7738a0b@linaro.org>
 <CAMuHMdWoEXLTPyQL4kt1OPVbrDDcBdBigqUM7EbNZjZUsSmRHQ@mail.gmail.com> <CAMRc=Mej9fQk-1zYKhPK6aWdptXKvjq28TywRyP+iZExRuX9og@mail.gmail.com>
In-Reply-To: <CAMRc=Mej9fQk-1zYKhPK6aWdptXKvjq28TywRyP+iZExRuX9og@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 25 Sep 2025 10:02:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXgoj+XuKhruEmMpjZignuM9fJLp8NJ0=ZLw8KdFKohsA@mail.gmail.com>
X-Gm-Features: AS18NWCyYwXSHgwWU9cjWnhwFzyaiaKh315kbRG5kwTsoewxQN_WDT2npG3qPmE
Message-ID: <CAMuHMdXgoj+XuKhruEmMpjZignuM9fJLp8NJ0=ZLw8KdFKohsA@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: use more common syntax for compound literals
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Lee Jones <lee@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Avi Fishman <avifishman70@gmail.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, 
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, 
	Benjamin Fair <benjaminfair@google.com>, Linus Walleij <linus.walleij@linaro.org>, 
	=?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	James Cowgill <james.cowgill@blaize.com>, Matt Redfearn <matt.redfearn@blaize.com>, 
	Neil Jones <neil.jones@blaize.com>, 
	Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>, Hoan Tran <hoan@os.amperecomputing.com>, 
	Yang Shen <shenyang39@huawei.com>, Imre Kaloz <kaloz@openwrt.org>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, imx@lists.linux.dev, 
	linux-unisoc@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

On Thu, 25 Sept 2025 at 09:52, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Thu, Sep 25, 2025 at 9:48=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Thu, 11 Sept 2025 at 12:02, Bartosz Golaszewski <brgl@bgdev.pl> wrot=
e:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > The (typeof(foo)) construct is unusual in the kernel, use a more typi=
cal
> > > syntax by explicitly spelling out the type.
> >
> > Thanks for your patch, which is now commit da3a88e9656c17a3 ("pinctrl:
> > use more common syntax for compound literals") in pinctrl/for-next
> >
> > > Link: https://lore.kernel.org/all/20250909-gpio-mmio-gpio-conv-part4-=
v1-13-9f723dc3524a@linaro.org/

This is the origin link to the patch (by you) that started the discussion.

> >
> > Looks like you (slightly) missed your target. The correct link is:
> >
> >     Link: https://lore.kernel.org/aMAP9hAWars0T83r@smile.fi.intel.com

This is the link to the comment (by Andy) that questioned the construct.

> >
> > > Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This is a link to the discussion with Andy as per Linus Torvalds'
> recent request to use the Link: tag to point to actually useful
> information rather than just the patch's origin. Linus Walleij doesn't
> use b4 so the origin link you'd normally expect to be added
> automatically is not there at all. That's probably what caused the
> confusion.

I know ;-)

Given the "Suggested-by: Andy", shouldn't the link point to the email
with the actual suggestion?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

