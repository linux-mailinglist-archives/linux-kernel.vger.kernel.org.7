Return-Path: <linux-kernel+bounces-873435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C141FC13EED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7944015FC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D378302149;
	Tue, 28 Oct 2025 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Boa0le8U"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4688E2EE617
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645015; cv=none; b=VQYFhcPbRMv6KPYN4b2jOInv/9wGrar7+3SFk3snNufRCP51JGaypWpBRzNd+di1am+DlxXF41yizKb0aawauEBLa+Krp/Fv/3nNPLGNYe/tOhFHHh/dJL0kTqskhJDuwvml4txj9+W+tUimfJaU+aPDlRCIBU/JAcz+xMsrVVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645015; c=relaxed/simple;
	bh=tmDSIyiMjLOS6FNqDMNTo7i77Y8KzxKQl8j6kjAwCZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUNqCaRLqn2D7/1bFfRnXNCCmWtj9T3wfg5CtDHQ6NCntZCb9ALOjQ70A46BgHladuZoorgOV0wyx/k0Ah/L8UzbwWSpxHMEh3sSMRSpGeRSiYyKRR6clKjkGoj9u8652hT8NBhuHRuIJydMyAPgJ7zIyBqqAXOMzgQ+o5jCB5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Boa0le8U; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59310014b8eso671154e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761645011; x=1762249811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmDSIyiMjLOS6FNqDMNTo7i77Y8KzxKQl8j6kjAwCZc=;
        b=Boa0le8UkZNqBDBjPXJKdWx/2/cJoVf1XBCA4PQ9QTG+xaY/mj1iJVVf70MZw4szCb
         4Yx4H9wPsY8wkJK3zOZskLCZ5uR7GQh9htSu5/4ktQS24RDeCkhYXnI3pVuEhTAlupnc
         4sVVMKfSnikM1u+UGhpiA0cWVkZhNrZVgfSVD6sBiZ6+dhObQP0zdF6XS+NvEeCSVJRM
         E9UXaooUkutkH+Wgbr+5WKjCjhtK65aqIPFkoYjMNIMRWpX0hVkPCGSbuL6NJ6tpmAnI
         fljB54KPycwuJd+t/9vz8FdKGWdhIfsDaseguPpbzfRXAz4EMTxDs0iyN+610pdFWbMP
         sCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761645011; x=1762249811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmDSIyiMjLOS6FNqDMNTo7i77Y8KzxKQl8j6kjAwCZc=;
        b=ZnMxie68x8bgIJTGHRyA5smbroX/+J99OUWTTNQRFRkrDbjBBHdATQOdd20KihHNnn
         4H8MVVS46/S3d2cq7P5tekF/vQMnRlJL9J34nhee8sV4Di5XOI/jOs5QXBZrEACkOP9e
         8jdodzW2zkuKqXRIC+wnKvhIXAa8R6rEIl6lrFnQN/GJVKOjIZu/mUYz6aJJXH5pWWre
         m8v/PjIct9YoAEunrGaHZGTCHF20HKP4fE23oOjFCDvz0Zol6wJShde9ZXRItfuTVI/R
         8MwpCdwbxsDFIcebFJZdwLKGx9yN4auQ+YKtMsV4CmfHgpXKajripGBGd414qY24UeTx
         qmyw==
X-Forwarded-Encrypted: i=1; AJvYcCX2YzqiswOHBM3ezJ5+XFVAlzy162jq3SqljBRcVV5T1E/Al1RtY08vd7I7lGbeilX2V916ypUGGnMHiwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNbT+eLQK9IMmwQwugKqqiycFfuuePcP54mPMKJHlF3DkTEiPd
	SYhXGcV4Dk8ZcejwaW2kX0Qabu8OJBk0xHb/QGcKuJwJ8eZ5+KB6+FkaNB6EUMfBmz8BDW6Ik1w
	4fapVX9MT2ItSCgT3SMdVAfkHiw4m9m0+zzCOssDeHQ==
X-Gm-Gg: ASbGnctutdsb/WIizWTD2rJgXzsaHYBwB/ooQQk3EH7RNDeN55iap7Dzo5m2QZ0rzbx
	j4WVJ2eKEKRgTsrHvIGaiqUlzHE1ssKRyObhxvcwGaZmjsTqo+xkTDkQNonkOq/wgR1WysAIMNl
	cH1Y/3/pX4l8SE6Bx+TvaiHWvq2IeDsU2QZIPGHHqBESHp4YMPuNx5SE4xiZCQsWwqv1t4Zud/y
	7h446vvXPLDC+mXTLKN6FVvC6fSnB5w2O0cbLD0RnFYcM0P41bgKqWXpiEMNl6Km+yh5HY=
X-Google-Smtp-Source: AGHT+IHu10ZcVMp1t6exa1PSxkHFxphXG1r4t9C5bsmjcMdzTg/t9I8b6zTS7ONgJ3VxrVunoD4N4GDJPwxaS7n75Xw=
X-Received: by 2002:a05:6512:3f15:b0:592:f521:2334 with SMTP id
 2adb3069b0e04-5930e993ec9mr1158884e87.8.1761645011316; Tue, 28 Oct 2025
 02:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022165509.3917655-2-robh@kernel.org> <CACRpkdYioyktQ5is6TJnkgX=MHk2-zf-XO-gx6sKcST2GABNiA@mail.gmail.com>
 <CAL_JsqJh=ccCR_TR2sgMJJ9ChkBC4zx0d0s_imGjHNt0Mbp=Bg@mail.gmail.com>
In-Reply-To: <CAL_JsqJh=ccCR_TR2sgMJJ9ChkBC4zx0d0s_imGjHNt0Mbp=Bg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 Oct 2025 10:49:59 +0100
X-Gm-Features: AWmQ_bk9HCEe5H9YQN8PNyspfsZbmH034UWjFM55zKwIU8N8qdRalyjCgv2QCTw
Message-ID: <CACRpkdY0+0UTkpXurB3E1Skce+Kcbti9-Z_2-d-f4yM-HuK_Dw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: arm: Convert Marvell CP110 System
 Controller to DT schema
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 12:26=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
> On Mon, Oct 27, 2025 at 4:58=E2=80=AFPM Linus Walleij <linus.walleij@lina=
ro.org> wrote:
> > On Wed, Oct 22, 2025 at 6:56=E2=80=AFPM Rob Herring (Arm) <robh@kernel.=
org> wrote:
> >
> > > Convert the Marvell CP110 System Controller binding to DT schema
> > > format.
> > >
> > > There's not any specific compatible for the whole block which is a
> > > separate problem, so just the child nodes are documented. Only the
> > > pinctrl and clock child nodes need to be converted as the GPIO node
> > > already has a schema.
> > >
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> >
> > Patch applied!
>
> I already applied as it is clock and pinctrl.

Yeah I saw, I dropped it now!

Yours,
Linus Walleij

