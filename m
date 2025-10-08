Return-Path: <linux-kernel+bounces-846013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D55EDBC6BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 00:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28D664E5C51
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 22:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9F8274668;
	Wed,  8 Oct 2025 22:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOfyTyAB"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C80189
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759960983; cv=none; b=ijvQp0nv+bTIQovmtzg9b034TcWBbrLL/MzV14REgC0Mm+VjClaoVVtLr3ULInFgWdn127mDDzN4RzlyFdwGtiwAP1/4OONip3fMqPR4fvw1JHgc35UzhG+ZML768HIkHERcxPz//YZYhK4NpbZoylBkSuvDAX2NGjrRVIRa0lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759960983; c=relaxed/simple;
	bh=O1GDeGSc6ZTNrKVZWt6KJp0ny8NdchXosakly7giLF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulaXZVJD7GarCBC6XiGuInXPtcrzDI9PF3tJoBYZHLAy7j1lzz/dFtcxIldU8wLstvDrmpDBtS6QwSfRHsTknBx8/rERhOdFkQHr4WPiQicmqq6luzA2IBc80y4iaJDSfiCGNeGaRSzaXrxve/nrZ5eFmgXaa205wdxNK50E4MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOfyTyAB; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7ae21804971so112673a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 15:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759960981; x=1760565781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1GDeGSc6ZTNrKVZWt6KJp0ny8NdchXosakly7giLF4=;
        b=lOfyTyAB/peOyJvYwcqSc4P/mqtT+l1975J+JHIBl3akQJJ8q/YHFSE2FKr5pMdhxT
         hFQakXeUFAfYTsH34+3igyLU0WG9oFt8OBCr1bQuycyDR1QemMcpaxLu7jWBveM2jxi0
         2RNWPZkUVKCBl9UI9gmPJXiq0m60Hh1tZJ2gyFx2pH+SBPc2ZjBmPpZL+8SSh72pgsl8
         xgim6tCcPIu52+LgsIfFQUNQmH0m9kEzpgR5F97TLhHpFbqmPQx7jyhDpRNSVN8UOaSl
         40Etk3yAmG6qLsI7qgFQpOpZ9K5ekwexhxDUjEaxoRb9SKKpHtWetrsvsIUJZly4Hp0h
         F1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759960981; x=1760565781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1GDeGSc6ZTNrKVZWt6KJp0ny8NdchXosakly7giLF4=;
        b=knNGdlpWWJdizZpa/UfDntV7YPiqg0Z+L8xP0Ix8tG3g1gA88okJz/nttFDvSTEnNy
         W18zp3Mo2ls0q573NhjDzMpVdAGSJ4/1aiKGDZ7gRrsElyvGxlBMb+OAOeRRfvX/FP/T
         XwJ/Ya1wb75RpBd3VCpDLr0YyFFaKtuR9feoJoWCNo30s4qXF6m8r0is9rbMXWCfv2Hu
         uGKPWXo31BdZF9nmOOtNp8gunZosMYlaeZ5DEFz7kNWd+rL0BZtWI7tx71pPuMGai4Eu
         LUiNLXluJ8jVK6hH/fXtsYqvQNkYCPXdTTrRreQOpxZw827+9mAAfWg247G2py90MSPZ
         JBbA==
X-Forwarded-Encrypted: i=1; AJvYcCUxsO9tZGzhnpyblVpLkSYzctEi9uzR6YwlG9haaHO2VTlLoWcLCdXsDhpHZm4/cCPqDesoilIf8PzZK1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUgv/oI76i4FMMJtSYtlDxxD5jswnKe/9+aZRuuB2P5i7TO2qJ
	QxBPopNKeurBQcmt7KSJrBt2CEJ7M+1+iwTU6zO3sz6i1we6EA4d/ua0iUZHb7S5QDdEJoK709/
	ny6OPtmHI4wAybmDgyJ8bZzmCVeYFDTc=
X-Gm-Gg: ASbGncv7Cwv3f+YK3r1Y/1uEMt1EoEaBJwpRCU7PMaQrv0VeYVqJm85/Cb72vJbFIV5
	b22AJZE26F33frs9asiJif8P7m46rc3NTaIk4IAlhCD9Iz/rw8N80AqJ3in2mWxINtjMvaCv6y6
	DXVlpHZQVgD/85sp9+3BbvC2PnNZeBHa7jb3Rv3C+qDkMWAo6/TCGGDtF2LfIQJAIkhaCUgPChd
	B0iEdPRk3ONfCgVbs7hMUHU7lgJfaI=
X-Google-Smtp-Source: AGHT+IFKGjDTTszYug16ZPYD2fS73v5RLZVoHCDQ/VCXp+JbDRhT3dUGLbtnnb2kD4j2CIS4Ru5L7fbGwoFhlycncnw=
X-Received: by 2002:a05:6830:61c7:b0:759:55bd:9597 with SMTP id
 46e09a7af769-7c0df7ff940mr3223928a34.26.1759960980686; Wed, 08 Oct 2025
 15:03:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008162719.1829-1-briansune@gmail.com> <aOacZAiWxG9XfWLS@opensource.cirrus.com>
 <CAN7C2SCDNz5TB3deVziuNNYFnPV_hmrsPL1k-j5Dsj58wvC2rw@mail.gmail.com>
 <aObHCq6JAHbtTJZ8@opensource.cirrus.com> <200b17e5-9655-49c7-a4af-7adaf2838168@sirena.org.uk>
 <CAN7C2SApVuEBTpq-E=bT=1yS+hQVv4J6FSe4ACa5_1a7pSprkg@mail.gmail.com> <72ca91be-e953-428b-8314-d32de3478bc0@sirena.org.uk>
In-Reply-To: <72ca91be-e953-428b-8314-d32de3478bc0@sirena.org.uk>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 9 Oct 2025 06:02:49 +0800
X-Gm-Features: AS18NWDPvGnctgHlB4NkFOQpRqEY5XdelmKfL0jJ27WCBR6DTwWGQdC2pK--CV0
Message-ID: <CAN7C2SAbzM7mbmZjnKVQ9MiFgodUWdpJG1BZhiG66RVNBs+Naw@mail.gmail.com>
Subject: Re: [PATCH v5] ASoC: wm8978: add missing BCLK divider setup
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mark Brown <broonie@kernel.org> =E6=96=BC 2025=E5=B9=B410=E6=9C=889=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=885:44=E5=AF=AB=E9=81=93=EF=BC=9A

> This is often partly a pinmuxing/routing question - if the CODEC is the
> clock provider (and perhaps you're using a CODEC PLL so the clock isn't
> visible without being output by the CODEC) then using a fast BCLK can
> either be needed due to a lack of other places to output the MCLK or
> just seem convenient to the board designer due to where the available
> pins are.

Then why this codec need to support this uncongenial design from first plac=
e?
Are this is general kernel driver trunk?
As such, this is just trying to argue and make
BCLK LRCLK noncorrelated reasonable.

If a HW designer choice to use a codec as clock generator rather than audio
bases. Why this driver got to support on that.
As such all these discussion just want to argue and make thing reasonable
w/o practical application ground.

From all these discussions only this specific codec I cannot see reasonable
application field that you run lrclk on audio S.R. but bclk on same as mclk=
.
While using such configuration still generate auditable sound?

