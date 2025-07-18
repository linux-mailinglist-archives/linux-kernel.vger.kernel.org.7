Return-Path: <linux-kernel+bounces-736439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E9BB09CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968761750A1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BF82698AF;
	Fri, 18 Jul 2025 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdXLjNuR"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC41F23C50B;
	Fri, 18 Jul 2025 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752824669; cv=none; b=bHP/fXCxAxGt47xRBkO0gcm7oXcN/oY60TRSeKV7h6lctqePBdUWlYuA7rH37RhLoVpnVR6FsN0y+QI/69Y9ikgJdYoIwsaocsewoN/3Z30G4IGJNpse9Kl7Zvx8dogmRetYxYRekXF5t3K2bRAZvKE5xaaouOAOAc9D6cV81Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752824669; c=relaxed/simple;
	bh=WDBDIUqsCnzltvgUWzAq0CeGp4GzUUJd8bx41+z9Kcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1zYBrPUMAmc7j1hY6gYC/gNR4YOVNeyD9QzGDoknbApT+nbHwaDoDReLjAi6nWx9xm8LO/95HYGu/c3WQXB1Bk9S4M8t2SNXB3pHyvqlPdhsYkrmAdnhOPWWovyxocJTS84OU8cTy5OpeLnPvfXn/priJqx4H8aZ1Sx6CdQu5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdXLjNuR; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e292dcc066so10783055ab.1;
        Fri, 18 Jul 2025 00:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752824667; x=1753429467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmlpmnVcGL0avS3PpdVEZ5nI3yJOcG/fmYBWhlTK0Do=;
        b=YdXLjNuRl+cTjksW/2mCUCPgLSgxSNZgP5wqgdDakwTluuqbh2rcSKIFTTSgX3gm8q
         qfTEt8/ixHEN5MsW8rH1gtm+tyIsEYILT2j/Rgwqyu6AZBajoGU11LxjLuaSQfquIxaB
         Zwhkw+PmtZkU73B4MfwNziTm3uzbZfS3jIBgsH35sEIHSKjtreDgm5eNa3gB1tLgAWj1
         UJ+SpJvXoZqfvyZ3PQvQSSmwerjZs2LKX08u2/rhssRSkEWtd+xFeyWow8SvsWpNQzMz
         Kx/k/GfuFuLSe1e1Y7Pkbbpey3xoNzDNaPeWpjR+fh1Hd3ar4YIZXGyerZH331r8ur7B
         Mygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752824667; x=1753429467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmlpmnVcGL0avS3PpdVEZ5nI3yJOcG/fmYBWhlTK0Do=;
        b=sbO7hYaLvS5qLi8mmjDZqxo7KWoyQikqAQFDuL8TsHlFTaJdWCPugmEfMcf3g4LbCe
         6Y0pRP2mMP5yNQsRyfkE/nKW4SkgJq/RBLlG/ZqQGXTwflTV9yTb4wIuhGhJrEfkfvli
         7SdQ07gIcOJUiRCg+DcU9w/wEF8jDLep9cxUdJQ5601KBL+tmzxSmYfe/w11TidnQBsD
         ippuqnI53FcFcXpvXh0KTWhfFyMJt4VUhok8V/Gp3ScmjsqYyCe5ncqG1503+/uahaTE
         KmOmyipSbh9GEDSl2gDxAdnSIvebCvXqwPcqNCrR+WozzH9GVc4DYbVnQA2rI0R99uyE
         HH5w==
X-Forwarded-Encrypted: i=1; AJvYcCV/KG5Yk/UNuGXsTee8tab+2w2tdUhTOao2RUmvR47gyxClex3hIY1AmFQeupJR0UqIZNRtc5RQy6w4@vger.kernel.org, AJvYcCWZWs4/9oAQtySwihc4L54OoTPEyXaNbP8F4RYtgT2Cq5Lvy2VK/sXnvcPkb8nVnnbRS+eYD5fwfWYOVjRL@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf9+bfNNW2PJoQZGQhQRtblUjPEWb6X0lWq+vT+7NtA/SFAIvU
	Gf65pEfQD46d620ix2jm9n2UfJVQkcUnp9Lt+xCfEGk2txdji+QSHNWcQCV9xErqbSEGl4xDcCN
	XjzuXv6GOocX/zusEgpik6Em907dc/Uo2Hg==
X-Gm-Gg: ASbGnct/5T67MXNuVEAHL5NOt+I0fnZdXvuxF6edw5FsV+J0AeuOKKfsYeFY2LP8AWc
	ghMtheEBHgtD+FkXppbEFmz6cCrkm9Epra43x7bQDpp22dLak677hq0povRnzJ6YSs69Q2HeioW
	e0vZUmElbUmoz101XtKbYg7Hsa+7gs+/G/0cn/r+JNpf9IiP5N0/8Jn37gNJ7Qhip/MhU9jazbH
	uygPmE=
X-Google-Smtp-Source: AGHT+IH/Caf1fGdiRCnZGzyv7uHAPCmM1WdkO9Z9jQd0Axtk4U1Tyu/Cj/IpUNTfhnOI1VU+WUcrVTv2SPAHM7ZXCgM=
X-Received: by 2002:a05:6e02:2188:b0:3de:14d4:a755 with SMTP id
 e9e14a558f8ab-3e282ed01dfmr112246985ab.21.1752824666722; Fri, 18 Jul 2025
 00:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716061114.2405272-1-shengjiu.wang@nxp.com> <CAEnQRZC=qApo9C0zBDQoxpV56atLeXpoxZdyBuQ=o2y59YJEqA@mail.gmail.com>
In-Reply-To: <CAEnQRZC=qApo9C0zBDQoxpV56atLeXpoxZdyBuQ=o2y59YJEqA@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 18 Jul 2025 15:44:14 +0800
X-Gm-Features: Ac12FXyAcDWebSNzkWDN6xJ8YvjSpNbbipIAuGrOnyFeWn6RtnLG3gfVuS2c34w
Message-ID: <CAA+D8ANSdiEqKwgyb8S18QcuZv58211nxn+cCnRcmovgtu8Yqw@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: dts: imx8m: support more sample rates
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 3:53=E2=80=AFPM Daniel Baluta <daniel.baluta@gmail.=
com> wrote:
>
> On Wed, Jul 16, 2025 at 9:11=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.=
com> wrote:
> >
> > The wm8524 codec is connected to the SAI interface. There are two audio
> > plls on i.MX8MQ, i.MX8MM, i.MX8MN, one pll can be the clock source of
> > 44kHz series rates, another pll can be clock source of 48kHz series rat=
es.
> >
> > Shengjiu Wang (3):
> >   arm64: dts: imx8mm-evk: support more sample rates for wm8524 card
> >   arm64: dts: imx8mq-evk: support more sample rates for wm8524 card
> >   arm64: dts: imx8mn-evk: support more sample rates for wm8524 card
>
> Hi Shengjiu,
>
> I think it would be useful to specify which are the current supported rat=
es
> and which will be the ones supported after your patch  (in the commit mes=
sages).
>
yes, will update the commit message to make it more clear.

best regards
Shengjiu Wang

> On NXP BSP you can run:
>
> ../../unit_tests/Audio/mxc_alsa_hw_params.out hw:X,Y p r
>
> to get the rates.

