Return-Path: <linux-kernel+bounces-838601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BB8BAFB77
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35794A4E7F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00399278754;
	Wed,  1 Oct 2025 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DUkVxDJM"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F827470
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759308399; cv=none; b=T+ch5kwgC6UMwKQFJL7uE2HtHvfRiQFSm/u7ZlCcQf/VRJAgsEZihVn1Q63S7f8gxDZY/EFNzym9RWIJVhsN+3CVeghhPiNfVpFlSy33nDllTPlQ9QSprLkJTHZccvlA/olkzXCsj2pePg8nNWZ7xu2Jb63IG35xljEbwc8AnFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759308399; c=relaxed/simple;
	bh=8D0lPsjedL+kyXW7Dr+b8bXHNiYNOO4VOFO0oJ6yKL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJseDoqu6aqrPrq5LRhBMm1tDM4azilNL+1+6pNtWY49Wr9tvpJIUuhfsBwfBwTZ2oo48/qi2VDF3q0GHSWJt/JAZ459zzg2xniUUa+owvO2yHWHxkY0nbvdlWc9LLhX3mBMDMuY4MNLQF0+BcB8OMGS6X+37UAfo/D/D9+w5wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DUkVxDJM; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57a59124323so7134191e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759308396; x=1759913196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8D0lPsjedL+kyXW7Dr+b8bXHNiYNOO4VOFO0oJ6yKL8=;
        b=DUkVxDJMjtSd7JQTplxvjXnLL5GY+6orOou1AZZ0x9DtcMzEXZlDDUO5+eaD501CUS
         mWP3Q6Meo0Uj6Tm0E1RFkDgOph56cUABDKiKZp5Puu4pYuNRnEA6VhMZSPzA5BtD6xcu
         gRaulkg2Et3G9SRp+cvL3yvghxsJG2pzn60aqXgtyBLGv5sUvqvrGCicylQZzXRbDn8Q
         2UNv76kAcKAGkcDPbK3+CaMGeEfi6M70Ghen8FHS9PX8q3wyzSfrrzz2tOGSpIhATlQM
         2wVFLE+1pXs7exuilmjKhe6wQ68O4uZs8ShdL162BqVZ9AYXdCfKVxaI/NAtogJ9skVY
         qtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759308396; x=1759913196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8D0lPsjedL+kyXW7Dr+b8bXHNiYNOO4VOFO0oJ6yKL8=;
        b=rtiN+rw8b6wrNlwSrmNmN1cpiUCXIt+w9RGVgw9P6OUJLk0fPrU80GF6NIUNEBXIhu
         ugrnjXBMX0azQo2uxPPd5g6bnlKfHQrC686UUMRCpfY7R8gp+UIfp6n+xur4aCcCrujj
         wWvRc96vFRKQN4CATmp8XcVH3ImNiFwtQLUsRaHWlrls4P/caCPMwGN1P7KZ1srTg5wS
         WiOU3e+sER1xuMQHnYu1gm0TbxKt1C/7U/tEUA5rYNp1cCwUOvT6jkN2Lql9dr3GXSKd
         hXWQYfO5AmWM1KXwCH+6ve24C9t26NjCcoBMTRAvdsK6QMiPIFaU3/ry1XNDTNDeXVKa
         JZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5fQ397hanN4ymrVXk2pISRyJOEbzEoQlWiKKN6ULrRoJ2zH0jxem6S2BbkKa3gKbqWW52JsX1A7qGkec=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC9v8EaXesHmR/4ZEm1+BKNH84NYBlsvU7kCOHXfnpZ7H/LGzt
	H0noT9WRITJo403WFEGbp6toWxEX9+1XKIrUEj+RjU7O4xFjC2t4XxI/dEY2z4oBAFdXoLS91UG
	669YU5t347RxWLB/utcnDrQVqZ4Agag6gm13ZnEgYjA==
X-Gm-Gg: ASbGnctoNSBnCoEdZnztLfrA+ihjpaSSndRuX/ZxtB6l8++YmBbF33xtmaPylXGoSsu
	d9ty4Pl9QMz5bhDyQsEo0GBqcichXHKr2WzVAYgj3nXBrrWgPeefv/vEW2gPLghkyuXf9mzx3EV
	5UqkluRBdgAhL5OPb+Qq71uEaXogVTYNGExb4fB+60XbpxiCgfFDc0Yq6dGDYrCEO5IoCsiBizL
	7e7/SVe59VuXQxgqG45Exn92WicXQshRVPw4En/nABkomHFFzcpwivyhKRRFeY=
X-Google-Smtp-Source: AGHT+IFOdBqQ3obnIdTm7ru0JPzklPYFIUGqCI693FKE/9RlmuM5kKhUigWL4UNHwLKwqtrOVDs8F+QH4ORLFYFhoak=
X-Received: by 2002:a05:6512:ea7:b0:57a:6d7d:dd7b with SMTP id
 2adb3069b0e04-58af9eadd86mr760851e87.8.1759308395621; Wed, 01 Oct 2025
 01:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-make-compound-literals-normal-again-v1-0-076ee7738a0b@linaro.org>
 <20250910-make-compound-literals-normal-again-v1-2-076ee7738a0b@linaro.org>
 <CAMuHMdWoEXLTPyQL4kt1OPVbrDDcBdBigqUM7EbNZjZUsSmRHQ@mail.gmail.com>
 <CAMRc=Mej9fQk-1zYKhPK6aWdptXKvjq28TywRyP+iZExRuX9og@mail.gmail.com> <CACRpkdbo88o1g_VCp0+C9hfi1VQkP99x2Mnkw_DTctBEtVAa_g@mail.gmail.com>
In-Reply-To: <CACRpkdbo88o1g_VCp0+C9hfi1VQkP99x2Mnkw_DTctBEtVAa_g@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 1 Oct 2025 10:46:22 +0200
X-Gm-Features: AS18NWC0XlksXBppS2yCvWpBaDAShYUzQK0jJOB31RgrqudBkZ0MvZktkc5Xz8w
Message-ID: <CAMRc=Mf4kv03+cfB7up==PUJyxHH6U3hHF3q6iKYZWVOZamSTg@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: use more common syntax for compound literals
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Lee Jones <lee@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
	Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
	Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
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

On Wed, Oct 1, 2025 at 10:36=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Thu, Sep 25, 2025 at 9:52=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
>
> > This is a link to the discussion with Andy as per Linus Torvalds'
> > recent request to use the Link: tag to point to actually useful
> > information rather than just the patch's origin. Linus Walleij doesn't
> > use b4 so the origin link you'd normally expect to be added
> > automatically is not there at all. That's probably what caused the
> > confusion.
>
> What? I use b4 for everything, I don't know what gave you
> that impression....
>

Ah, sorry for this. I assumed the lack of Link is due to no b4. Should
have looked at git log first.

> I have however removed the automated Link: tags generated from magic
> gitconfig hooks as requested by Torvalds in v6.17-rc5:
> https://lwn.net/Articles/1037069/
>
> This is also mentioned in my pin control pull request from yesterday.
>

So it is a policy after all and not a "please"? Let me remove the hooks the=
n...

Bart

