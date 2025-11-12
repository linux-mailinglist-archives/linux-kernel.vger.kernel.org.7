Return-Path: <linux-kernel+bounces-897209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B71C52479
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89E8A4E7CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA41732C921;
	Wed, 12 Nov 2025 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuudwzXb"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A40A31352C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762950787; cv=none; b=nUEO2D4bHvgUSe4RTayWyKgpFpqjnDK1b9C5nWeY598mB2grVk5VNvRALRHM8NHKdH5aszrmPttk78FeEZa0C8rxDYD8EELDpQlQbEzQuv4QIKhWqDxJXMJE9013NF62t8Vw5TP0ZRjmmHsflLCRSqztGOEYBWnyH289l7YszmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762950787; c=relaxed/simple;
	bh=GoygDqYWw5QnBxpPn+aUvq/6hrUvKX40S6nIeuv1rgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvvE/eV2NuDP3osm2Clq9EgnI2/Nig6JMvAOcwA9lLYOiI/DUUKx8NJZ9QvdNz7kMbPXLMgUuA28qKmPgitK/OSWOTnj88vf1Go8FlAsAufRhRRK8etXHUeFTiq6JuWSoHlvCvb7iFjfTH+XpbqT05YZvq/ghBp5eibVeFiuOBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuudwzXb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-298456bb53aso8454245ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762950783; x=1763555583; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IuUTav2xUOTbkma3ItG1F52J0EZPCIhhyycd80cfuj8=;
        b=SuudwzXbB0v6JSx67ng2dfbXzE+xY+c5cdHloekkTD8ctv3xkCMmMq8Jucanbjkz/8
         mUEKlWwQecKxw9BYXzXwBI44Z4RUeR55NZD4czVOLyLYrE4brI46ReJlN3iqPyNUvWky
         nrxD9H924m7Uu1a+pySD6/IaAOp6RNZJUcV9XmwOt5nPeOZM0//AAq3RLP6gotkJ62n3
         xmlmDV8Y8tPQbY4esp6I8RwkDHyunKHl3G7xcBlzNrDuqPnqwi6t61Mu+G/cgq2cdL/x
         txXVvnUFp+oO0FglpFHoXhaWFjRh0gqvsCsAo+meofQxrszNyszo/bjNNgvAZqsWpsXi
         +RTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762950783; x=1763555583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuUTav2xUOTbkma3ItG1F52J0EZPCIhhyycd80cfuj8=;
        b=X9AXhJGCUMzZbqE0OOMFDiN/7KA84b9c5u+IJGrht1iQle2lx0HIel3EFLCaY2moFJ
         Humovhx9M7BogLce8pmE6SEUTk7EiJ/qe8EDWRWduV57bbd7jyFGpJlM8q2Y4QA7Ch07
         GdyJl8nmy0UWwtPHEf4TQAqHnSemFHaPasS7xxu9JPbpd1Vmw2o7dH49evVEycEW83z9
         +gqPDO2HSDhvB9ZWnSZIdpb3R11d14VgeK5iXriDSAM74UF0vEnvWZeDwLMtaAO88LRM
         cCj68OfVDpM09nCjCUC0FJTgaVOMIS5W0ekgf2P13IiC7hSy+Firhjp7iT7aidprmbHr
         V/Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXYIPO4H4zFJ5MRtUY2JzqmaqRZxzk+NZO0CwFSK5llfTCagqISOyfKdbWfMqO87bigfe87dkt2YnWaoRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1qC+ALpREKqmw/1hZ6MbqD2CRUBiFze1w8uD4r4ROvHMlUjns
	4NAVcsZtqDTdJPkDEAd9it6ixcPs4QPA9IofCcifUO1LmwjlaI9R4pDANhRqYcytH58qMgWQ6If
	IoWizJLgRl/R4zcLvYeisyqVZA9AHWl8=
X-Gm-Gg: ASbGncuJ58HJw4S64X8hhX5y/DQ0lRhMXl9G9hNVUz4RioYGxko3wuwWAkLnl5nCfdE
	DcTPuCPRd+RDpgQiqJR3379gIBDjzc7mbFqkp6VSNnXt6d+ZptONV8p3WmWlzyuqNnmjD58d9Wk
	nFUIP8MGMpgRghzLlWyoP7m7sdFkbhA0iBHyASBwkq2DkeAxJedG1X2c2/1qanb+qIV2Huzee4p
	wK0++Nf+cdkx6m1/I7fA6bkiH56Ay6vAnM2ghnhXjh92lMMUzBXJ2O62w==
X-Google-Smtp-Source: AGHT+IFabhPWRSsuZsSo5sbgc0lLZtsJguRmqpiSDLmiPKtI899emQH3LjICEzz3+Agz/sH6qEDUHd1ILnm2Zjkbos0=
X-Received: by 2002:a17:902:ccd1:b0:258:9d26:1860 with SMTP id
 d9443c01a7336-2984eddd8e8mr38233045ad.40.1762950783418; Wed, 12 Nov 2025
 04:33:03 -0800 (PST)
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
 <CAEnQRZDg0yAjR-a-4J2ZKAjh3mm8NeQCA=o2kyNJtXMAFCMLAA@mail.gmail.com> <56530f64-6ddf-4d2a-a079-0578db260449@kernel.org>
In-Reply-To: <56530f64-6ddf-4d2a-a079-0578db260449@kernel.org>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 12 Nov 2025 14:35:26 +0200
X-Gm-Features: AWmQ_bl_E_pJAreACwvdhcI2KJRqNKpXEYmnMwMcnpAuTrSvxvSsy1R2nTa94KY
Message-ID: <CAEnQRZD=h5qOC445U3_+HPh7aCE8TohSpZmg9hgkRE7mg5HUpA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: add support for NXP i.MX8MP FRDM board
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, Rogerio Pimentel <rpimentel.silva@gmail.com>, robh@kernel.org, 
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

<snip>

> > We (NXP) immensely  appreciate individual contributions from everyone.
> >
> > We need to be fair, the v1 of this patchset was taken from NXP
> > downstream without
> > respecting the Developer Certificate of Origin.
>
> No, it wasn't. Please read carefully DCO. The chain here was not
> correct, but that's the only thing.
>

Indeed carefully reading the DCO Clause b) you are right.

> >
> > E.g there were commits pulled in from our internal tree without
> > keeping the S-o-B tags.
>
> Read DCO, please. It is not mandatory to keep 3rd party SoB. It is
> perfectly fine to skip it, if needed according to (b) of DCO certifying.
>

True. In my understanding though if one bases their work on others work
they should at least keep the S-o-b tag as a common courtesy.

Commit messages explicitly says that the work is based on NXP internal
tree patches.

At this point I leave to Rogerio's appreciation on which S-o-B flags
to pull and how much
of his work is based on NXP tree.

Thanks a lot Rogerio and Krzysztof for helping move this forward.

