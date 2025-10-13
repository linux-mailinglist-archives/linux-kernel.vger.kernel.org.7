Return-Path: <linux-kernel+bounces-850951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47108BD54A9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 799744FD2E1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F2830E825;
	Mon, 13 Oct 2025 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kmc+EicW"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D284C307AEE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370474; cv=none; b=gCrut5xDXJhlynR+UCf8ADh8rd6zgwrteLXeIk8fX7dZ9RL8jZDctDCiSVZmnBD0Kj9p4RrBnfAYDlrLOWkQPcXoOyotcC8jDs/GHbaL0VhRHqYwuNyH+AUFhUqWZcNnfM06L4Y3kQDGXXpx1+mbbJoTY6p7hmcuEYP9zNeswrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370474; c=relaxed/simple;
	bh=g6TFFFPGjr50jQR7xQx4h+CFBPxdsLdChbbFuSFu0bM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lADH9VqKHsZfhSKBdvKawZlV0mehC29Dyuut6cWdB0xKIHBP/1PQLY0+4BTYYDJdgN6Xeh7pMFNRn1gUq4618xmGcrpjtlhWELpiNNt4NpHkRz9G/eZt33sZk+NAncSrO/xUOmLnCd9m9iL53Ko5j8eGJRGDF/O5ZI1C8XGdtMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Kmc+EicW; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-371e4858f74so51775151fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760370470; x=1760975270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YBeBnLojRUp+3BGjW9hqqMrpXMlk2wEyeaFT1Bjf2RU=;
        b=Kmc+EicWOnGGJv7h3XU37uIanIetzI2Y0gIysTNKa/jbxzrsW/u18lpFhrh7ojoUdp
         DyUguXAGeDupQIpwgNmb7DO+NhXzZSZpVeqy/rRHSeolzqlsVu/AjK4bxGImmJk55QD3
         io9iZfQTNBWNUciKMpgtbWdrYXU1Awjdihq7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760370470; x=1760975270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBeBnLojRUp+3BGjW9hqqMrpXMlk2wEyeaFT1Bjf2RU=;
        b=XeNY1zYdtfGhAGJKd26LpWs8oyAWe+BniuyVRfC4YZk5+cAt1uMr6pX+WGmO/yKNbA
         hr/KH5lO+KA4QJAE/gTQH2O8caVaTSBrXUSBkm37Bdujl5Cv/c/Z/Zofg4y3aJHwywSg
         eJV/hM5s4RT2L7XcY7E9F0DWzpLwJltnvoz/RFe9l44y+Kf1L1uGaIx2AlUU+2z/5qpy
         5H/RkMxWByNavjzPLyGZycirUdRgtRrKeeBOzfLt2DGtpn8yx/PWb4dQ8T6Qzo7ulZHv
         LSKla8tvI94psiqzuEtexdlOxIZAdWLHK0sjhMVphKqy1KPXzcZrTiIZNT+GGBgg/KjV
         +ejQ==
X-Forwarded-Encrypted: i=1; AJvYcCUstZWWCgJqLGe2X+PbD4MZqDNZTMMdaWjJ9jS3b5jKIXz7XmoSHBVvMHmuyblTbQ/OfQVi/hOFfpyLACU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQcPMx+I5QukODZyGO6UEc2PBuznqzeY2I+QGYAZDPtYPvHgPg
	xXiaXAyrz8XowNooYWDOtrYwWMa+6EpKeLQzMaqMiVqGL+s5Xj3WAnVFw8NAjBIvo4XRXmLCOYh
	yGAsp8A==
X-Gm-Gg: ASbGncuy6U2CLLJbvKje8g8bGoFEo5sjJQi2l7AuVgFVUVQHLqvVThJslxh0PsvsKSo
	8G9S6Uq/ebqzsfey5eoDA6gNYphWNTU1sYVXWC7oH+djmxItQOGqGfaySREajDzKIlUx5A6qpFn
	1cA6ZskfsuocP/Umum42b8rij+ofT+BhGyVIxN00JtCKxQqs1BrAIzoozjDmZDKvNqVV4Nkuy0I
	GgD63p+Om8msr5U3HxOZiCDeO/iLErJRMZUHc4OW8sXf3MgAl3DzPqrfd3pGwO6DTOOzW+Amq+A
	kUf0KZY+GYZlUyWsAYzGtc7dGjMt4a0wHebfUofB8GpTWLV5Lm3hFwGqYtgDIaRSGadVV4AM0Pl
	1LFt8qwWVegEsAl/UWPQ8/QjzWMO38LHD8eltsvOSatR9NB5/IS2M/V0O+JiUcDhLIucDVfPt9Q
	0xBwXOzMmnWhF6hQ==
X-Google-Smtp-Source: AGHT+IGr2Zl7MKZN0kXSrfJFr6fD4bp4H39qej15iSs7eSK8o/ccIIPfVn1J/Z4Tc/22I/BEMtIS/Q==
X-Received: by 2002:a2e:858d:0:b0:337:e0d9:69a0 with SMTP id 38308e7fff4ca-3760a58a767mr56356421fa.20.1760370469677;
        Mon, 13 Oct 2025 08:47:49 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37647d7e854sm26418671fa.15.2025.10.13.08.47.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:47:48 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57e03279bfeso5434944e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:47:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXohHhLBLktNKMaOcpXZzOtF4cOFzyeHjURIV2ZdTaCGHJWxcRhy2jJIIO/8G+udjAVhPlbH8aWFXcV/YE=@vger.kernel.org
X-Received: by 2002:a05:6512:1329:b0:581:bdb8:6df9 with SMTP id
 2adb3069b0e04-5905e1ffebamr6390861e87.10.1760370468172; Mon, 13 Oct 2025
 08:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-dts-v1-1-5731ed92684a@chromium.org> <aO0eLbLCGLKf6sF+@lizhi-Precision-Tower-5810>
In-Reply-To: <aO0eLbLCGLKf6sF+@lizhi-Precision-Tower-5810>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 13 Oct 2025 17:47:35 +0200
X-Gmail-Original-Message-ID: <CANiDSCu2hdaO5r8v_GcCksepy58AJFsuLb-xxz3WYOUknvKLwg@mail.gmail.com>
X-Gm-Features: AS18NWCpy9_8RtaLxButea2qoJBXTdgqbhebqmgYPmIE7BU8dSEVQ_qnVy1gyYw
Message-ID: <CANiDSCu2hdaO5r8v_GcCksepy58AJFsuLb-xxz3WYOUknvKLwg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: media: fsl,imx6q-vdoa: Remove redundant quote
To: Frank Li <Frank.li@nxp.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Frank

On Mon, 13 Oct 2025 at 17:43, Frank Li <Frank.li@nxp.com> wrote:
>
> On Mon, Oct 13, 2025 at 02:52:20PM +0000, Ricardo Ribalda wrote:
> > Latest dts-ci complains about this:
> > ./Documentation/devicetree/bindings/media/fsl,imx6q-vdoa.yaml:19:12: [error] string value is redundantly quoted with any quotes (quoted-strings)
> >
> > Fix it to make our CI happy.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
>
> Thank you fix it. I have posted at
>
> https://lore.kernel.org/imx/20250925193546.305036-1-Frank.Li@nxp.com/

Sorry, I missed that one :)



>
> Frank
>
> >  Documentation/devicetree/bindings/media/fsl,imx6q-vdoa.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/media/fsl,imx6q-vdoa.yaml b/Documentation/devicetree/bindings/media/fsl,imx6q-vdoa.yaml
> > index 511ac0d67a7f2360afe22b81d76644575081089b..988a5b3a62bdebeda6b922a986b9ac93d0933e51 100644
> > --- a/Documentation/devicetree/bindings/media/fsl,imx6q-vdoa.yaml
> > +++ b/Documentation/devicetree/bindings/media/fsl,imx6q-vdoa.yaml
> > @@ -16,7 +16,7 @@ maintainers:
> >
> >  properties:
> >    compatible:
> > -    const: "fsl,imx6q-vdoa"
> > +    const: fsl,imx6q-vdoa
> >
> >    reg:
> >      maxItems: 1
> >
> > ---
> > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> > change-id: 20251013-dts-83ce7f7b9e54
> >
> > Best regards,
> > --
> > Ricardo Ribalda <ribalda@chromium.org>
> >



-- 
Ricardo Ribalda

