Return-Path: <linux-kernel+bounces-895138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC643C4D041
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DC354FBE8E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB2E34846A;
	Tue, 11 Nov 2025 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKPhZGHI"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D12347BC1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856427; cv=none; b=mETjY/47tHotkaMHTL9niShJlRxuy9Anni7V7dxCcOZCoO4qUJ9rXce7J4NGPmX7OsnoavSvCelK6LO0Eq6RouD2D2g4zkCQcOs4GA5bUPhT81SMmQTK01lzJJxyyO+wBxbreoYDIXVqKOs//UpfNjcAMHBv1dfYcpRuQn2AWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856427; c=relaxed/simple;
	bh=vFQCQTjKO8TNTzEmtlk+LvI6FcO3v/ubcdimd89KqZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQFOF8D5g+ntDBEiT4x7MAL+LMUoTPyDTCVReFEPDGxoYRlvxI5quhio1FlnvKlXs6WdOvsKsKnm3MxnlxI1rOTQ8my3vCf3ytXFcRQ3aYLxuYnBvwMBnY6F61943y1Xz80foCOCJ7gFBLupHzJRZkCRKqap5JrUDrK7NydnxPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKPhZGHI; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ba599137cf7so3137598a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762856425; x=1763461225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2BNnZMONHx8/CvKkJxYxrwMB72hoWbxX7RGGc1E2Ds=;
        b=NKPhZGHIRjBhb1KY7CHkJjdqggn/IOyIPdkU2nSG+qI3rMrsXb15grksl4teM0FnnY
         O79Fx2kxGuEWmoYtfaQLG08dQa/p/xWnhbDOIWoEQ0EhtXLPRo57aTooALVN30O7GvXg
         AojZyz2Cx6Q1A75fa4d5dfqii/qmQC4PnHiQ4e7XhSlCDGyh9qt289MZNQZmFxj83Tvz
         HnVh7lMu8p+tLZJGqeZBaXIX8aCuJjl2eV7Ap6xYR2gLgAf8rEWUq/sitgLPJ5+aVAPT
         CE2cblK2tyXKVZrH0rNKd/dwhz+g2O2Gy8ObXa4U2gk4dNjyne4zPUGwJ+o+0MHKRnAB
         XVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762856425; x=1763461225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g2BNnZMONHx8/CvKkJxYxrwMB72hoWbxX7RGGc1E2Ds=;
        b=qmjAKXfC18EkVWhYz9pFpJZTRpfNqSu/DA2oTCni5BErxJYWHDmtxeOomZ9OYt6YVP
         QunTTf1wkc38jqykfETSJBgqCDhfOdgR0Pq1sv5/LuRiyEObHgSOtarNm17Lyy/Ccm8c
         CwM2YH1BQYsukxoDzImR13SEuEv9wC2DTsrWpKCMNa+ppRWn39b+vtYptU0S/e8FnTOB
         fO19iMOF4bnxwFCYQEymly8gp7+Ty206R27xznyDZ38mUiYIaePtshNmn5YdlZ0W/cra
         fLKuKvtTMd38SPZsr5xqKrgLI9M5pHnkW15TfMHzG9PpyfdecrCKvAXVW2kWJsIWfgAl
         MOyA==
X-Forwarded-Encrypted: i=1; AJvYcCXsOr1mOyhdq+cqWMSZ9lbodpimnKT0wCeY2bXog/0Wse2iuYH0urokT1hN8RotUqqjCEfp0AwZFSYcy2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH0O457gWu3QZZ6321BP4QW9iKKdjomP2sf61OdR4Mkszc+j60
	fMbn2ciu/uV8d7BfJYK9PfDgh6CLkutyUAoZb6bdy8Xqo8whlz+Q/lWQVEM8gct+dfL/oPNwAuc
	7L3162CtYhlsUacIsrMl3uWnNdEIdRyA=
X-Gm-Gg: ASbGnctcR5zbIedeKgqHe87Ro/anNVSByq0fga1bCvnQUuRtHfZoJXQ88jiHkzCfzuA
	eeV0jG1zkk/sde52qE6+ZfXMgQ7NNl3bvPc0apxhSvubv8gtVgIbU5tOD6gVBqpoMNMu09KvJGl
	plOWXDRGhEWI08gI55W/fH+YmpB/3anUStleW09ePcntw0pzTgbWjbv5Xtj4WPQROk7VVqOJEPb
	06TN+5kTKtGTU6ad9+3S3f60pdgVlNUiXgCWFmp+aRvHfv0fX82c0EMuQ==
X-Google-Smtp-Source: AGHT+IGHeEc0tdcwN2CitYeC9X138lPaLhDv7imL1UBIrrtgzyaJrxx+3S5nCZWKtBm7wpPk+C2oztDUFMFw3MuqU3k=
X-Received: by 2002:a17:903:a8b:b0:298:68e:405e with SMTP id
 d9443c01a7336-298068e42acmr127289735ad.59.1762856425272; Tue, 11 Nov 2025
 02:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109214515.121742-1-rpimentel.silva@gmail.com>
 <20251109214515.121742-2-rpimentel.silva@gmail.com> <aRF0++cUigbETuPs@lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com>
 <CAOMZO5AdcR_fT_RV5-NWu7j51_TA_=Mzzi-Y3Y=HpH+pu=mrvQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AdcR_fT_RV5-NWu7j51_TA_=Mzzi-Y3Y=HpH+pu=mrvQ@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 11 Nov 2025 12:22:49 +0200
X-Gm-Features: AWmQ_blb19ig8nToRgjFSZoxZIb7WUT84e0ePG6rGqwjB44zvP8kQIVu2iX87yU
Message-ID: <CAEnQRZBdqUQUahHcFO2W6yezonXdpFVT-G52rnda941+M=T93g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: add support for NXP i.MX8MP FRDM board
To: Fabio Estevam <festevam@gmail.com>
Cc: Joseph Guo <qijian.guo@nxp.com>, Rogerio Pimentel <rpimentel.silva@gmail.com>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, 
	alexander.stein@ew.tq-group.com, dario.binacchi@amarulasolutions.com, 
	marex@denx.de, Markus.Niebel@tq-group.com, y.moog@phytec.de, 
	joao.goncalves@toradex.com, frieder.schrempf@kontron.de, josua@solid-run.com, 
	francesco.dolcini@toradex.com, primoz.fiser@norik.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiaofeng Wei <xiaofeng.wei@nxp.com>, 
	Justin Jiang <justin.jiang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Fabio, Rogerio,

> On Mon, Nov 10, 2025 at 2:15=E2=80=AFAM Joseph Guo <qijian.guo@nxp.com> w=
rote:
>
> > > +/ {
> > > +     model =3D "NXP i.MX8MPlus FRDM board";
> > > +     compatible =3D "fsl,imx8mp-frdm", "fsl,imx8mp";
> >         model =3D "NXP FRDM-IMX8MPLUS";
> >         compatible =3D "fsl,frdm-imx8mp", "fsl,imx8mp";
>
> Why do you suggest changing the compatible string?
>
> "fsl,imx8mp-frdm", "fsl,imx8mp"; is correct.
>

All NXP documentation refers to this as FRDM-IMX8MPLUS.

But compatible strings have a certain pattern to be followed so
we should really go with: "fsl,imx8mp-frdm",

But for model and all references in text and commit message
we should follow the documentation and use  FRDM-IMX8MPLUS.

So, model should be  model =3D "NXP FRDM-IMX8MPLUS";

Thanks,
Daniel.

