Return-Path: <linux-kernel+bounces-897350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A39DC52B46
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 272754EF6DF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A9226E706;
	Wed, 12 Nov 2025 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+xPixGs"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501181ADC83
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956322; cv=none; b=Vlv5fVLAEnf+SCSP0EhtWQHOkUFCbi/zhWj6gXbQy0TSyGeGpZIbK1Z7jS4pzTP9JfDHJnEjkBKhty3UXPItxn038VHQ1odIb1bwtnddKW9CO2SEIUiCgxWt++1AjBx+Y0qWKHQvGIWyA0Oc4celhyql6qdL9CMkc1E12HrDCeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956322; c=relaxed/simple;
	bh=h+naC3WP5Hca5p6GdNfPWAs3ASYye9OHxLz/qrFbh3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYJf01ftK4CHfNPIcs74emQ6asrST0oTFoPaRxs7mHnHopUL2puYst6L12nkuOOBCbxwHEC/FtwYoNpygnH+KPrwpz8gmtRDVTQG7Db6AExEPZz28BuWcDoFzw0bLeI2FTynlUb+WsVHJef78D4uz6sQp7YpnghKdHRat8ILM4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+xPixGs; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34361025290so830111a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762956321; x=1763561121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IgqMB/v3xeO5BgQjIq0XWQN2JeRWzsu5Px5Hi7zIAE=;
        b=a+xPixGsrNtHQ3HpCDXmeCI5F9CWxk1JxIuJtQTjQgbtXs8OUSjpr6AzdrHfz/3LMw
         8WzTxgwgzxMb050YKouW5Y9s+gSTuKuVlFUuLq39VLdbT+bF7QnHFLbWEQMS5VzSo0yS
         aeGp5WPVgZ86PNL6PLbsPd5u+1uHQ8p4GD5SHla5cOgAnTp3KGi6XApwJgoK99esj542
         9Asf1Vv5dDTQBYBPGtkt4mZqMkeb3NSu1mbKMqqASDaM22XEm03/sGx/zN40OjcM5j9r
         FjO6EM1sO4vpVklmf43HDp0Tv9hw0IFjHnsFfcCDuqYc0eMdH4X5WdNJwdKcaGjzF4Yl
         1O/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956321; x=1763561121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5IgqMB/v3xeO5BgQjIq0XWQN2JeRWzsu5Px5Hi7zIAE=;
        b=rvBmTt98Jp7/nhJOfIj1gHb0bJyn+jJmsNTKWIiCjDOxQ4gR9FKqEqDdmiGpvqJrkk
         IS+iGZgAocjqZAonbYC/K1dVrRZYesb5T1vQabYg8UhG0aTIr4FhALZYR2SWDjfpS1bn
         mLhkBnA9rpjHFu4jNqe62wNvJocgMSiMY6+jKpwad9h+p2ZeaQN77FpTA0tNqsn22mqY
         YQJZQueH2YikBb7MX81ht633evk4ZzhyoV/qj5magPJ+3vfp+mndPHc8YSyQVfkjv6In
         JzivqsXJuQfr2ljbshrWUJgq1OaX4bL2/iHCin3+JF7x5fVGHmYX68XRIDsAVVy7smzn
         eg6g==
X-Forwarded-Encrypted: i=1; AJvYcCW8uGZRWIwlAcU1Bstx4qos7tLbXBq66RnWiuTLc6zEL3QAPCLnu/88xoIVqwnPTn0hqI5RraHlhnzYw8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCOwjzTMG58Hm1OSQWLvAkLwTB+4l76Ckexwzbk6Szv3kTPKnw
	zE8eiPcoh5esTINf1x2fSLrgPyAOXCn69InBlcJCZJQZfNGlQhjleyZ6+hOAIi/xVLwkcEzt52B
	AJ5ExduX96jxLG5o11T1Vz5XLZLGkwLk=
X-Gm-Gg: ASbGncunZeWjF4Z0ruMktny0UYqCeF9nYTYCmx/Th2WY+MledJZfXI8oQZQrQltxGuL
	2D4ixtZxKU8P2meZHr0g5IYfQOv9aPYUJb/69cYiZPSLYMq0ryPntInXp6ZUpnha1QY1xEScBqE
	85iHnPZkz98yajFZv3qEuGPLa5bo9VZhE+ZLK6kjr+Ne1fDxyWql2ckuNcRRvAI9/IcgURcXt7L
	9XaI9M912hZLfgw0iodgRWcjm+IaRUyHOAE5Wt1c0EYFs8riuHPZlKxkdfi
X-Google-Smtp-Source: AGHT+IGGE4/VL1DEyxNrJ9gXhy58i37XginUx1Z79nbxZV1zaeXJiHFTS6UKxC5C1DeQKZdokBPv7izFiH2R6Na0d44=
X-Received: by 2002:a17:90b:3f88:b0:33e:2934:6e11 with SMTP id
 98e67ed59e1d1-343dde1328emr4083273a91.11.1762956320459; Wed, 12 Nov 2025
 06:05:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109214515.121742-1-rpimentel.silva@gmail.com>
 <20251109214515.121742-2-rpimentel.silva@gmail.com> <9d48a54c-0585-4524-b9d5-30696f5ecc8b@kernel.org>
 <CAEnQRZCvpXzGt=7NGv7-s+y0gvOg7Jx4OqbfbW3uv8jDp-jroQ@mail.gmail.com>
 <CAOMZO5CU09fcBB8oUOO=qC=Du3Q9gnJOQacK=6v+pnSQViex3g@mail.gmail.com>
 <CAEnQRZCHKemw2YVT=WVJvUMr9CCWoZ3MORt_mU1V-62C53n-3w@mail.gmail.com>
 <CAEnQRZBBJ4PGDOk7hBP_qsk7bBiec8pHb0DYKs2mhOAahNyKww@mail.gmail.com>
 <baafb460-fb65-4cd2-9911-89d828199d9b@kernel.org> <2e160fe1-bcb2-41cf-817e-ac2a36959b16@kernel.org>
 <CAEnQRZDg0yAjR-a-4J2ZKAjh3mm8NeQCA=o2kyNJtXMAFCMLAA@mail.gmail.com>
 <56530f64-6ddf-4d2a-a079-0578db260449@kernel.org> <CAEnQRZD=h5qOC445U3_+HPh7aCE8TohSpZmg9hgkRE7mg5HUpA@mail.gmail.com>
In-Reply-To: <CAEnQRZD=h5qOC445U3_+HPh7aCE8TohSpZmg9hgkRE7mg5HUpA@mail.gmail.com>
From: Rogerio Pimentel <rpimentel.silva@gmail.com>
Date: Wed, 12 Nov 2025 09:04:26 -0500
X-Gm-Features: AWmQ_bkE3E5kBt-au_w0tdPJgXF5KUKjHFMKLDQ12VqLfiSClucWeakQI7DwekA
Message-ID: <CAOkaPuX7YeUJJj15dY0vD8mngg5MS5uBwU_UfrFRFjrghR7NDw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: add support for NXP i.MX8MP FRDM board
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Fabio Estevam <festevam@gmail.com>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, 
	alexander.stein@ew.tq-group.com, dario.binacchi@amarulasolutions.com, 
	marex@denx.de, Markus.Niebel@tq-group.com, y.moog@phytec.de, 
	joao.goncalves@toradex.com, frieder.schrempf@kontron.de, josua@solid-run.com, 
	francesco.dolcini@toradex.com, primoz.fiser@norik.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiaofeng Wei <xiaofeng.wei@nxp.com>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Joseph Guo <qijian.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 7:33=E2=80=AFAM Daniel Baluta <daniel.baluta@gmail.=
com> wrote:
>
> <snip>
>
> > > We (NXP) immensely  appreciate individual contributions from everyone=
.
> > >
> > > We need to be fair, the v1 of this patchset was taken from NXP
> > > downstream without
> > > respecting the Developer Certificate of Origin.
> >
> > No, it wasn't. Please read carefully DCO. The chain here was not
> > correct, but that's the only thing.
> >
>
> Indeed carefully reading the DCO Clause b) you are right.
>
> > >
> > > E.g there were commits pulled in from our internal tree without
> > > keeping the S-o-B tags.
> >
> > Read DCO, please. It is not mandatory to keep 3rd party SoB. It is
> > perfectly fine to skip it, if needed according to (b) of DCO certifying=
.
> >
>
> True. In my understanding though if one bases their work on others work
> they should at least keep the S-o-b tag as a common courtesy.
>
> Commit messages explicitly says that the work is based on NXP internal
> tree patches.
>
> At this point I leave to Rogerio's appreciation on which S-o-B flags
> to pull and how much
> of his work is based on NXP tree.
>
> Thanks a lot Rogerio and Krzysztof for helping move this forward.

Thanks Daniel, Krzysztof and Fabio for the review and discussion.
I understand and agree with Krzysztof's point, but if there are no problems=
,
I would like to keep all the names suggested by Daniel:

Author: Xiaofeng Wei <xiaofeng.wei@nxp.com>

Signed-off-by: Xiaofeng Wei <xiaofeng.wei@nxp.com>

Co-developed-by: Joseph Guo <qijian.guo@nxp.com>
Signed-off-by: Joseph Guo <qijian.guo@nxp.com>

Co-developed-by: Steven Yang <steven.yang@nxp.com>
Signed-off-by: Steven Yang <steven.yang@nxp.com>

Co-developed-by: Lei Xu <lei.xu@nxp.com>
Signed-off-by: Lei Xu <lei.xu@nxp.com>

Co-developed-by: Rogerio Pimentel <rpimentel.silva@gmail.com>
Signed-off-by: Rogerio Pimentel <rpimentel.silva@gmail.com>

