Return-Path: <linux-kernel+bounces-893990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EF6C4901A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3039734B01C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B6E3328E9;
	Mon, 10 Nov 2025 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3ScSHHj"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8D0330B15
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802811; cv=none; b=A2kgT1ouj5cGWCphOATumxZsVjMAJBEKsL+q44uSaWS17O2b18gOmZj/IBe+W56ajtWMeMQMX2kpGaw4kOz81Pax4bTbdj7Kkexbp1S9vYPwvKVztQB8IpnMVJsTsOJTsKHPQ5xlNe4pRdQcFKlGEc+PQ6bdYkHVT1jEh0aURJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802811; c=relaxed/simple;
	bh=g9bEAE/YGJuTa8tU+8eyGnc74pewsjnI08OQO2NlOwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiFo2r3h37E1cnRdQWz2eTxyETvqGOjWQsElt+1XBReFPm8FmjQPICbBA3Swt/bA5X7lPH4B1Q9EOslND+xJkooxCaryuF1SbzHaPXca4/VRhigyxg4X35AP6vsT4YnPixxKcE7OAIiHhyUmkwBzrt4l1nJtbyYfttUTalkXnjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3ScSHHj; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5942a631c2dso3033988e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762802806; x=1763407606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGP8QREMcd/AaPsprMdpu0BolksBxlVcRR5B0xb1iVQ=;
        b=e3ScSHHjL7mWpgKQgVhSixR+EXqOwb50+oatf4tuFs8/13Msp09y/jjl95IN4tuyHl
         PLrY9Y1ywINDX5ttul4aZ6pk1/9I2wJK0uRG10IT65VLhHsKmw3JLX1J9t/DlVY5lXat
         MEkDSVXGw+KiTXpa6UJXncvrxDrq4WhF+xI2QVGQLrE/h4DmuVAoFwnXFFEaIxKkWg65
         oK748ppPGQsVXS73O7wy2bEOX7CdD14wpCu5G1nxoGHTb3FtA54hpXrosESTd902T7ad
         7DyYjwtm6AH6ob/OfgytUlKQyML/eyQsPGIFxeWG/uNsKqFbiglaM2No27A6ZH+nbMKh
         TUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762802806; x=1763407606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QGP8QREMcd/AaPsprMdpu0BolksBxlVcRR5B0xb1iVQ=;
        b=ZyvZelPOb/9iE6fjaHkg1ZkXFEOTpjleSN4yUR7PotikiJsos/lfwgbMsCYJ5MZliG
         eMGuR7TSaiZYzn97hh+ogczJWH7VBW8JDhR0EtrWbjWJYqXxKqiO0MKg1eyPLrjEKiu7
         KuLZAjOuH5KbsjhFxGyQ9JyGqa9sgNs2cBpPkd93lHxAAhaxVWchZnGxqP6CCII4LhzU
         H7lxOvVQO6Xb/z8NRrZNo7K1gDGxGdXzjps3ZlUdlrKYeGRm8DTDJ7e02Icltg6m7TG5
         peRGitJxAGrpB6Ll9dXaI8B1pmOeBMsiiCaUCuDSPcos7qnFusx1oPbfRGBkA/GvyGhp
         bfug==
X-Forwarded-Encrypted: i=1; AJvYcCU0SE4z+fPzyFaOlDBQ3E+2Ora92QGSQ/N/6wCgMg0Fz+ECKyLi9qK0cyVdmSiegKq370lLB/30SQopBWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4l6anJ6XabAMJEp/xuNik1YdfBGgmFxL05/AflK/oFgZlf6Xb
	qXwtvClMGi9OYfTQlXLV/ux/yp9toeWA9kxgClqnGWSL3qz0gp0AvAa+NFuZ46muuAEOpKc7m10
	foEzQtgIbWrQNA6XH/gptqaS3gO5hzcU=
X-Gm-Gg: ASbGnctrQQ5nG+2F3ZfTsuwDbk0fgu7c8deHxzCogs7JpagoJ7tFVaq6RK+V555Cch9
	Vch4q+IWD4HIo1PMSrhCfbl4C1w7XC8gAkUvId9tmDlMB3iI6z1NL4uUbQznLkzx+46E+apWCKY
	Mj6XV0wuLlaCrYUZu/wzgDWZkcqRKFil4YDXQPrBGIWuxBYx7srNZompA7ceKKUPpFmjK/1UcJ6
	lm5yTIPbfvi7D4hPZ7bP13FwN5zQ7XmyB2Nqp0Nq2ErM2ZdhWNgsXZ+L13HLLxQfFOPfXxWYoA/
	R8b6pJPUWq4NQJHS
X-Google-Smtp-Source: AGHT+IE2w++hbFBecmu0ldyA3GzUU/nItyyDdlyoL3af2e2XPwUQ48QHaBgbQkhDEsXF284tkIFknJ3Bm82utQZyrag=
X-Received: by 2002:a05:6512:3d9f:b0:592:f3ef:19ad with SMTP id
 2adb3069b0e04-5945f1c0a0cmr2748942e87.34.1762802806159; Mon, 10 Nov 2025
 11:26:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109214515.121742-1-rpimentel.silva@gmail.com>
 <20251109214515.121742-2-rpimentel.silva@gmail.com> <aRF0++cUigbETuPs@lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com>
In-Reply-To: <aRF0++cUigbETuPs@lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 10 Nov 2025 16:26:34 -0300
X-Gm-Features: AWmQ_bmb7MnvX9j071Ug1e9S416TAObVP1qyQuyove0FFDmd8l7EUQKS7aibrU8
Message-ID: <CAOMZO5AdcR_fT_RV5-NWu7j51_TA_=Mzzi-Y3Y=HpH+pu=mrvQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: add support for NXP i.MX8MP FRDM board
To: Joseph Guo <qijian.guo@nxp.com>
Cc: Rogerio Pimentel <rpimentel.silva@gmail.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, alexander.stein@ew.tq-group.com, 
	dario.binacchi@amarulasolutions.com, marex@denx.de, 
	Markus.Niebel@tq-group.com, y.moog@phytec.de, joao.goncalves@toradex.com, 
	frieder.schrempf@kontron.de, josua@solid-run.com, 
	francesco.dolcini@toradex.com, primoz.fiser@norik.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiaofeng Wei <xiaofeng.wei@nxp.com>, 
	Justin Jiang <justin.jiang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joseph,

On Mon, Nov 10, 2025 at 2:15=E2=80=AFAM Joseph Guo <qijian.guo@nxp.com> wro=
te:

> > +/ {
> > +     model =3D "NXP i.MX8MPlus FRDM board";
> > +     compatible =3D "fsl,imx8mp-frdm", "fsl,imx8mp";
>         model =3D "NXP FRDM-IMX8MPLUS";
>         compatible =3D "fsl,frdm-imx8mp", "fsl,imx8mp";

Why do you suggest changing the compatible string?

"fsl,imx8mp-frdm", "fsl,imx8mp"; is correct.

