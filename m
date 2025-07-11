Return-Path: <linux-kernel+bounces-728071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF70AB02367
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4130A621D5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DB42F271C;
	Fri, 11 Jul 2025 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YC28NgXK"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D5F2F1FEC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752257614; cv=none; b=BWUOZwYQF0HNvhQhpQoZ4UvUCxBTA/Hh6cuOo4u5t92mNlLw/3NXTvBR9nic7HebpYC4fMkhtwNCpBzgOxDHHyAXNd/+BEjlQnnVwJNcfiBB8kFOQQQNY2T6TCvmI9U4qjIiJ8ZWVk9FMIn+Hy8Yrh+UNrsODaMaCr+2ttc4SBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752257614; c=relaxed/simple;
	bh=z0FAINHMrT/mXWSwLLS5ITQiWYyUydXHEsbDIHwLkNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svFcpDhflPYYIJhSkLKDolcrY+x1PwMWMy33inrlWYI3L+JaWA0j6gOwoobSNL3RgTQaDknhufELgCV1uaPD0SWMgkOC43iK2TY5mJY/63s4eUiZ/tCwoKGG8rjCWegEACkAPAFLGYGIBpj87v8bTKjR1W8eOT3f7ARkuyp25vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YC28NgXK; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32b8134ef6aso21834521fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752257611; x=1752862411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0FAINHMrT/mXWSwLLS5ITQiWYyUydXHEsbDIHwLkNQ=;
        b=YC28NgXKQU4MfHLvCSx4TbwDnLLJcR2LnuM3/xqBffmNhSypes9jr+FEFrhYacYNnX
         ONMLcxbGH6zFMbUXq5QnB8IzjRG6EGPCvemyD3rpJEReBZLFTdGypsmMAWPICJEfk/qq
         Tw5jL3dwkKQ0rAl6FZ1h8APqPT1q8vo+gz1GeVz2kOoeV/6P2dty3DkAoygFIwtA6vi1
         O0GgWTRJyjl+ymyFczLMvrnh0BlKEjceif6EpqjTbYNUAkrSfo5mMx0hTlQ3EZxNcu7w
         lZT9j2DqOaoD3RI37EwH8OpmI1NvrSZMckDm0TyOmHiTKNu0tdaFpD3Rv+lwqULW6X9B
         MUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752257611; x=1752862411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0FAINHMrT/mXWSwLLS5ITQiWYyUydXHEsbDIHwLkNQ=;
        b=TCbahLlie5ELk212nwDlNmtW2VmyzWaHY8D1oRyV7s3YKmOOR1tpjYNWq/CbKIYfsO
         i6soUpbcOn5ziuAnHV17to955cx2NkyGNvAnS8/j7pmwkgwFrAh6cjk2R9jIl53NzEcQ
         9hhrxThlFUhbwarbLEArrTGr8Y+9OwXAz6mdTZMCWYx9QlQjrbN8qTIZpguLQ5I8p2DX
         FRT4wZ1BqaZbgJQMPf2qC+xZW4+oyFzJ1hTdwLcNUy6pxqBSbVHSCqp0a1EfraZ+C4g/
         UETt2CqzwMx1dF65cElQCR7+mxI/Y2PJfJQ4bdX539eT7KdPnIK6Di6LIvxOmwZqRZDB
         /qdw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ7KY53dVfr2ePXPSS9Y096XyJeacxp4dTnJfsTloMWw5YJejyrHHlw0jPsUwhT0S9sCUr+DcrkxOVod0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu38KBC/4TLoFmTlNbE/Jt2oJYIBISgXYaA79KKHQrBKcXB+yj
	yXtahENEz+PngejYltpd6V5wdeQIJBEzdNJB07acVo8T5W4r+oubwAFRT/kDj5d82ubwlsPTR+R
	POkiKCcz7P2DrkdSDwUoMX9A+0U26e6yDwwABRrqYgQ==
X-Gm-Gg: ASbGnctOck7hJugMG2vi5f8Jxl0BRI84S7+GLUYIHJSKbYgVGlDubqhtSKNnHL9xWG9
	eKlNJdDmqJWQ1c/+4ypPfrPSrurzLZHEAT1gH987IzmiS/xugvDXo+hMX3qUpv4Kgza4UESaxka
	SeTKSpgaVZCFbpniv7vhMKrbLTlr8G2QgWfS7G6rrAgjvOGKyZXuFie1VEhlPJT6hmIYBa+qUoo
	4ZxkyOR7egQPjjR3Q==
X-Google-Smtp-Source: AGHT+IFMuBYHoAN7PSAu45/CxJxrRKT9IAF0+U0X5QcMw4v0k+dSQgdIENHIG/kIkaAP4cg8rAILHrMXlK3Z+M3lDSE=
X-Received: by 2002:a2e:be83:0:b0:32a:85ad:2162 with SMTP id
 38308e7fff4ca-330532d0602mr13483321fa.7.1752257611064; Fri, 11 Jul 2025
 11:13:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626080923.632789-1-paulk@sys-base.io> <20250626080923.632789-2-paulk@sys-base.io>
 <20250704233535.4b026641@minigeek.lan> <20250705153825.2be2b333@minigeek.lan>
 <aGm8n_wJPiGk85E4@collins> <CAGb2v66s-nWA2dFRpgX6DbDET3dWOm1jPKWm1k9SmGSqhTWoWA@mail.gmail.com>
In-Reply-To: <CAGb2v66s-nWA2dFRpgX6DbDET3dWOm1jPKWm1k9SmGSqhTWoWA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jul 2025 20:13:19 +0200
X-Gm-Features: Ac12FXygNb9Ktxv1UdTrJbOKhH4l5d3j_PT8j5_pIzh_inLuA-iMK4HxDAsC-Wg
Message-ID: <CACRpkdZSXRxhNORJv5TTaf=B5dpUgXfL-PBW1qH7uKC24o=Heg@mail.gmail.com>
Subject: Re: [PATCH 1/5] pinctrl: sunxi: Fix a100 emac pin function name
To: wens@csie.org
Cc: Paul Kocialkowski <paulk@sys-base.io>, Andre Przywara <andre.przywara@arm.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 6, 2025 at 5:04=E2=80=AFPM Chen-Yu Tsai <wens@csie.org> wrote:
> On Sun, Jul 6, 2025 at 8:00=E2=80=AFAM Paul Kocialkowski <paulk@sys-base.=
io> wrote:

> > > So I would very much like to see this patch moved out. Is it just in
> > > LinusW's tree so far? I don't see it in -next yet.
> >
> > I don't think the patches were accepted for over a week so we can proba=
bly
> > still act. I will send reverts, unless maintainers want to manually rem=
ove
> > these commits?
>
> I can drop the dts patches from the sunxi tree. Linus might be able to
> drop the pinctrl patch.
>
> You definitely need to send a revert for the DT binding patch that is
> already in net-next.

I dropped the patch from the pinctrl tree, no problem.

Yours,
Linus Walleij

