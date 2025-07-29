Return-Path: <linux-kernel+bounces-749823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C3CB15348
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C43E18A51D0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36F324EAB2;
	Tue, 29 Jul 2025 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="S4TrubPv"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B430224728D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753816215; cv=none; b=IRTMlfFkq8HJU9EMTmkffOPfRMqySi6CjbOTmlcerOlIu5fJon4RZur7kDiLu2eV9gvCdJy5/odwltE9uZ9Hejb4ZaHmu7BxKStt+IWWDilFQNtSPjmVBNkx7YqIm/4M5IOs/4nV/p4euWnKUkYwo1BEUhzkYw0FPhX9Wtt+uak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753816215; c=relaxed/simple;
	bh=gZh8ljut1hGoGNyKv+aXd2MxvgIj9E5doRM7TfIUD0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ko8hamNDO7CRdtlok51rg5xm/cf0yAYhqNYWmBJFSJpbBIEWqMjZE9XQCdqYUOarVwpySWUOGaSTg8O2VU6UYlCNRseWd63fKaav3sr38hRzA4GeSFlbnH3lhFRSy07vjh3AwNEJDJnNgXpSQ9VtLR6x3Rlsc7xmAwnwY32/Ouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=S4TrubPv; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55622414cf4so5274960e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753816211; x=1754421011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZh8ljut1hGoGNyKv+aXd2MxvgIj9E5doRM7TfIUD0w=;
        b=S4TrubPvPkGrV53uupK3v+KnEv5JZEMwEGTQ47sO6+UUddXC1vvDWNh9fIuX3djH90
         kmRdan9QAZDUuZ2bIaQ+4bRXyDs975mtQ4N65BTfdBjrqtPCJ4JmE5tR2pxIh/EaA7r0
         zUcpYQtNi5MLA3R6HLzLKCSjj7vylcZsKY7+R84IXPPZUu8RhiMqd6fLrC0GVv4/wjZs
         TL190zqcW1Kn2/dyL7CZ8PgYELApQkfdyDbH1a8AGFLwuJrZtRi8WOJX4FIZE3s7MGc1
         AY7brdXaFmU1pmJtK6ZCle5Qr5rQMq0PHrMcfRk1srSQHEcm5YB7Gxj8XCF+wYpfu4fh
         gGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753816211; x=1754421011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZh8ljut1hGoGNyKv+aXd2MxvgIj9E5doRM7TfIUD0w=;
        b=MpKvi1wSiAI5n2T6fZEAA+AorlWfErevl73fAsvlKsDSv+bwav8O+U5+mCPwXKE+9D
         R7c2JdTbHI5AAaaFcwOGU8s9lTXNaM72p8iaqOtBQhBpJGA5BAwiWMdsfHsG0LPboLrI
         7GGTgAC0f075jWc/xKrp1VDp8wNre3p0vE9b0NuJW9BSRT1Q1LuCjkkE0vY0aeoFhAWS
         HJU+JMamlI4mIt0zDK7SGlI7r8Jtu6F5IUzSBkUOe1pEZhqqEWDqhJb96Jsi9BdZ1Ft0
         +lGA9kzVlk2wNTWXtQhdG5NyszSymbCXj1qQCx8gIAni6Kb+h0I8wzg5CVXQYm7Jw4C5
         LuMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxVJqIk39yWHMZ8aGpP49yEWn4pCci2lDcFy53XLtYCuvIokNQ6FzoFZTDdhuC42WNv+omj+t7yIDK5JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBy62tTxmW/NpNd9MX6ok3SXqetL/SFgR2NH9wLkc4b9SnCOoO
	Pq6zthe72vEPZXLG5zjtGcoIb/9U3BsULYEhOsj9RZ3UnPacrVjQMrcLt2dkX/qm7hMtUhczj3W
	8Fzs+ir4HjPeVBMnxMi3W1g+9gsTfbUOYKIo1QQE27g==
X-Gm-Gg: ASbGncuRX3uDHXgAHtqN550IbD+NN5wDrTODty7hooGsUJcCaLU22oRp0/88ztQl8Nx
	WznsWOrKVEpxN0+W/OcBVwGmrovjKdgU3ZI1q5xMCMwLpo22XGCRa83TyEy+4TDuphdTQC7wTtL
	LJQCWumyyeTsNKA3/RXBZU85+mFfuAvacI2cuG/6qlU8/GZsAMS3qoZjnC4hs8bK1+0aUmZViBf
	MSeCKJN9qVQjHw2kLjpjy8UehV7VuF7ebNjLEc=
X-Google-Smtp-Source: AGHT+IFjLccy85WmcIVxX8iXMCVZgbVynIqh/fxN/Cv8LDdpotCFZGp7YpefT04NgGb7HLgC5E0eAwYQX1WWl4vrQhA=
X-Received: by 2002:a05:6512:3daa:b0:55b:5a31:51da with SMTP id
 2adb3069b0e04-55b7c0620a6mr193225e87.40.1753816210554; Tue, 29 Jul 2025
 12:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3367665.aeNJFYEL58@radijator> <13840884.uLZWGnKmhe@radijator>
In-Reply-To: <13840884.uLZWGnKmhe@radijator>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 29 Jul 2025 21:09:58 +0200
X-Gm-Features: Ac12FXzJ4Le_pN4OWiJEdYoeOUJ9EgHbsU3XKmT-FF7OdQllnVTNnKf4Hb8Q6Pw
Message-ID: <CAMRc=McizcAXjr9VNOQnga0P8HJ9aR+X7njnSPMb4Bc9GU7GiA@mail.gmail.com>
Subject: Re: [REGRESSION] samsung,coreprimevelte oops and lockup while probing SM5504
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
	Peng Fan <peng.fan@nxp.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, Karel Balej <balejk@matfyz.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 4:48=E2=80=AFPM Duje Mihanovi=C4=87 <duje@dujemihan=
ovic.xyz> wrote:
>
> Hello,
>
> Friendly ping on this issue. The issue still occurs on v6.16 and is still
> fixed by reverting commit 20117cf426b6. I have found that the root cause =
seems
> to be a bad pointer in gpio_chip->gpio_device.owner, but was not able to
> figure out why this happens nor why this only happens when the IRQ chip i=
s
> immutable. Is there anything else I can do to try and get this resolved?
>

Peng: could you please look into this? I don't have a better idea at
this time than to revert this commit otherwise.

Bart

