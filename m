Return-Path: <linux-kernel+bounces-810181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25452B516FB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF71F167DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBA031AF27;
	Wed, 10 Sep 2025 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xZY4BowY"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBC831A55A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507635; cv=none; b=GMs4nE1+zSda4R7UdyYqVHwNua/fnTBOp8JwIP5vR0szwGkWb4cdSStC7cRAlc6xT5h3a6HoiaAIaz4ZKvqn1OOMVS2cjuM2A8Y6fksdIDgT4kA3GyDEMstns8z72Gl6ucGsqFmRSreoXiiSTc9GfHNa/Vi6X2fDV7R8ARSeVYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507635; c=relaxed/simple;
	bh=skI9T+/xeLD/m7s7Qla7tjWVpYf4bhBPCpCvExBgah8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8YMIhmUwUsNBomonkpiGJr3SdqOoxmOfJ9LfL9HPxUZM9Z82OKEhnNNfx7dNU5G4gc4g6yK3Q4Z58bLo/GIIF7WfJmIdipCV62ZbkT49puk/VR0/dg+Tt3XriZslkdvueNC08SfbCDuOGC2VC51/bZue1j0qOZAsYCsI2GImU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xZY4BowY; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-33ca74c62acso31589801fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 05:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757507632; x=1758112432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skI9T+/xeLD/m7s7Qla7tjWVpYf4bhBPCpCvExBgah8=;
        b=xZY4BowYbBv3pEOqzg/YrSiHhN36VIBp+14Bpsr7ogk1Tnp1faa5fVpzy3NvQp5ugu
         pFiybdU0L8OnK3ItpR9vffwXOK3qx70nItLO1kMGgdPaVzg9xGB+hd5xjSNatoSF58ZT
         71YaTiL6dsNz3+0X1UaddkVXzhkOodCTFKSlwNyATMDMZgMe1xJqWbWa2SKvBn7Zq9gY
         LV22bhh0w4GU2mJfSusx2fJgao9yRMKoy/h35EXXm3tzh2p1em3c6UuRE0AmDLoYfiQ3
         nFk+gECbj7BqxN2ECd3is4fB5IVscDmgsdtQvjxDJwUk2E+yl9ng09p1PevJ6zf+plpy
         D+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757507632; x=1758112432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skI9T+/xeLD/m7s7Qla7tjWVpYf4bhBPCpCvExBgah8=;
        b=V9So74PCgFYRbOaXRYIkiEPYgSF9ELTbLNx2r+XdeXLQCURNy3mw7iu1fgLYbqMZOC
         f+Z2DqsN4iV1tKOdf2mbht8+h7owqKK2BQEQr0TCNn46Z2Va/4soCYZAzgWCW7PPbTuA
         H2ZahKDsza9M2/12QsubxS0IA7BaDM862tZI2zS+ktbbgYHIPLD0karzcoiBoUnmDB0s
         UIWDsYxrs4hC4RC5+1wBUEFi+0Daod5gZVdHfNmXUf+MkqywDXnTlFnugMm4/LPVgzZw
         SOm1hH++IM/ai4w0PcbGhCajHGkFY6fyGUdKloHT2UK+AVAU2eABSHnbH+1P9yhLGsu+
         y8Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXRlzQlsE4QuGz8GD64nLmBzT31d7pPREfPLPsnKtyTCbXSH58UQX4LhK5PbDgz+FHmx+LmWDB3uGj95cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC34rTLCzr7wiOc85j9L6QgIudKE4civKdQQpTZV3tJY6BHbzZ
	SERHXa2fXdjsU8/VXiLvaotD56GAVPamU1fMNzsas9fAeUkEtZdvzBRw5CTiY7rsyQyvPhfSF2r
	qtOxrO7FoTRxEng7k20tCe5C58Vd/WMRYWAsSx5trDAeZYf3rVb1YVpA=
X-Gm-Gg: ASbGncu7Fdxv1HLd18FlF3B63koIqcOQak2zFp1LLvyDE0+raAR3MbqEYmdbN4uN5vl
	cPHcl3Uzb3t4osbSIZxYUnSBKevmaHkl7gECelOFKVdupJmEs0mUH6T2mL9I/Y+86tDMnUfiEjB
	7NSeejBvkMKN+KEX8o9QJBS8Ey5YIOy6/3T5m6lWnkKSsYyHr5JlJKlV/9F0ug/IKl6jGnuu1L7
	fC6fX21RqAxB2j7Kw==
X-Google-Smtp-Source: AGHT+IEYoTvKtT/H8Cg1gC/hS69lPe2ANltBJh4zGTiR26j0Tk12U4lmcbqE8e5TQVcLgLIs14eG8gIT+xqllMez8WM=
X-Received: by 2002:a05:651c:235a:20b0:337:e190:67e8 with SMTP id
 38308e7fff4ca-33b526a8672mr46134901fa.23.1757507631985; Wed, 10 Sep 2025
 05:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-arm-remove-high-pte-v1-1-d0899882815f@linaro.org>
 <7dfbb373-fb44-48d1-9880-747faa47e079@app.fastmail.com> <CACRpkdZ=4n=_yeWY1MSDRuQ=H-P=QiTcQkJF_YDHMfRM2RgDZw@mail.gmail.com>
In-Reply-To: <CACRpkdZ=4n=_yeWY1MSDRuQ=H-P=QiTcQkJF_YDHMfRM2RgDZw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 10 Sep 2025 14:33:40 +0200
X-Gm-Features: Ac12FXyBaauWVqgGPolMGErAfsIOEC-HKcvur8Pwkz1xYkC_NW_HSeKYtjS3I8A
Message-ID: <CACRpkdYVUGuS5fJuC0gXxz_AUi=rgKQ8FDoVpCrE0V224xF7Vw@mail.gmail.com>
Subject: Re: [PATCH] RFC: ARM: drop support for HIGHPTE
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 2:25=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:

> Ah, I was blissfully unaware of that patch, sorry.

Actually that is a weird thing of me to say about a patch that
I even replied to.

I had *blatantly forgot* about that patch would be a more
accurate statement...

Yours,
Linus Walleij

