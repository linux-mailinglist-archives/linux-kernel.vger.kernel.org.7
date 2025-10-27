Return-Path: <linux-kernel+bounces-872636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 284F2C11A24
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01C1F4E4384
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A25329C64;
	Mon, 27 Oct 2025 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OcOFMDw5"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0622D94A3
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761603174; cv=none; b=X4ebNhKq2hzt/phEagcDylD5vEx5aIpOREyQDMkJifUx36rD/zZLqdZZpvY0/t3k0f+Qsp6nxlFVl8mZE0QKRxkFXVSY0Gb0Gnst+x4AwenTuDgaPRpMevRtkQAf7T8qfpkw85Gv8LcXI97/okgS6zSXtSqo/bFqBZQv5rKzGRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761603174; c=relaxed/simple;
	bh=p0VYuTzD+pw6O+ffSIwOFLJ+utPOn6Ed1+UK3H7oZ0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fs6nmeTFBoKaB19WKnu592/frrerVQwpzIHydkmQBMuLnDFfBJ9VtbOaoOl3Xm6Xq3jPR8/8ylXQ0t6pUl4mBar2C5B2dC4g5TeDSdHgn66Ga2gF0DNAQC8Aa91eDcdE+fdKxi6PsaI9YgGznm9dp+NOAng3CzNRlt52FaZMdjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OcOFMDw5; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3737d09d123so73583081fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761603171; x=1762207971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0VYuTzD+pw6O+ffSIwOFLJ+utPOn6Ed1+UK3H7oZ0A=;
        b=OcOFMDw5WE1VvjjLIvOIMrhOr8poXBK1twid9BTAVaxS0GykGPg3DDgQiZKPovawj2
         3ler2GJ3PHtwNzxKNYmraXmuEQWGq7eMqgfg2tNpl4/oYIrX/QdVllqsFEUptunEx4uL
         bpYPn343NQjsZqSNBIGQVNYLDsjVeFHlk7hPXVi3ceK2H0OFSIUZqf/FvR96jXYQUfGC
         zpp+M7u2+ThyBMTdlW0uSMEnDVXNpdEiNL9m76SZ4jihOACza8ojFuyyUshb4QZUShu5
         4zKYfYG2VPxmWQNS7Q+/Ca1BCL0XmiSK889PtjuTzyEu2okOYu/ln+0AgB4a2kGT81n/
         gBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761603171; x=1762207971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0VYuTzD+pw6O+ffSIwOFLJ+utPOn6Ed1+UK3H7oZ0A=;
        b=Y980cBWs222ivrIb6h7qMphseQZXIsBg7uM41PDAH0pNN6OwZCpI9lge/wGgqmIprC
         3vwhTG8r6H4kF3s7WYw3IsSheAGY8iCsYxwYWZRuv2Gye98yA2zTfdi9zjHJKfjijRtH
         6xeT7Mt2LEVqw3Z/Eg117Isgj1YDCxwULqqwrXpruqsb06cinVRaRG+N0TFI0qIVfBBT
         IQlWccXw4as+EmlfilLXsolK0ASrGJEP8ywyayyyLmn98EkIuO2IZzx31F2hDGTtVpB7
         rj8apJgBblKSxGxBppfpTK4Ne42Gh9PI6CCteLj42pvrS7j1BJAcsc4EmTJImsMuofih
         7YtA==
X-Forwarded-Encrypted: i=1; AJvYcCUDaR5atSMxjkuxob1d8DBgeoouoD166zmPcCwWwagsN+GrsgXJck4H6irIMfzMsFE0eo2THQH2tnusgJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4BWU7qvXKHjbX91Gtm3L8r3mqlA3FGXn8vXhuVu9P+M/EhtrT
	hArASx86fWyZyuu0KO2rY+3dzdQMy1yUOSLZE0/lgrD4fRYovOMB1Wtv/t9MzO4ywRu4QEATcG8
	zDRsm6qQPvQ8fK0R1Ncy9bq098bfYHuVxJhRtG+kACw==
X-Gm-Gg: ASbGncssoXAJjrW/WK54h030bNPPsABU2MIkfvstkbuLROjR3qUQS1jpFjuoc96nG25
	YvZ2c63c6onkIfM4GVLDa/XOkyXdV36clImHhejVQcCZL5prgIVnRT+R7QA1kbRqTqFJEamUT9w
	KGqCKx46dvOCcz/NArlP3MDcso70CLlUaOh10BYJlODFIMn0qbrWOthW6x9WlXmu4+l0ltQjY8P
	AzPam8Bqpvm0VO+McH/mBkm55QvQAH/avMlFkOSjCH36klXuNKJnfioUMNi
X-Google-Smtp-Source: AGHT+IEO4OBX6LOPY6n+Kwj2RHxhOjz2+JIoc8GL2mJCp5ePHLtyDD4AZKAQpVBpjKroBtS/M17W9y9jzhmN3enwix8=
X-Received: by 2002:a05:651c:4406:20b0:378:e437:904f with SMTP id
 38308e7fff4ca-3790774c7cdmr3152661fa.40.1761603171396; Mon, 27 Oct 2025
 15:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023132700.1199871-1-antonio.borneo@foss.st.com> <20251023132700.1199871-7-antonio.borneo@foss.st.com>
In-Reply-To: <20251023132700.1199871-7-antonio.borneo@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 23:12:40 +0100
X-Gm-Features: AWmQ_bmFZYqcGNF8COoxdkJmlFz45N7cHtmhxRN-kPjjoyKz6dQA3AfG9pT2B40
Message-ID: <CACRpkdaSvKiGaOMbp5cmH=cCCzmi=cbUf+=4GvMZ-e-NbJT=+w@mail.gmail.com>
Subject: Re: [PATCH v4 06/12] pinctrl: stm32: Simplify handling of backup pin status
To: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Christophe Roullier <christophe.roullier@foss.st.com>, 
	Fabien Dessenne <fabien.dessenne@foss.st.com>, Valentin Caron <valentin.caron@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:27=E2=80=AFPM Antonio Borneo
<antonio.borneo@foss.st.com> wrote:

> Use C bit-field to keep the backup of the pin status, instead of
> explicitly handling the bit-field through shift and mask of a u32
> container.
>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>

Patch applied!

Yours,
Linus Walleij

