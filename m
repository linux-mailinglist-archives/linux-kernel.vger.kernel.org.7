Return-Path: <linux-kernel+bounces-872641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 871BBC11A51
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E18D94EBAD9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6D72F99BE;
	Mon, 27 Oct 2025 22:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t1aR8brj"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C734A2857CD
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761603344; cv=none; b=EhaAEKQego/jEzcwuOciDlseiVIeQg76PqYEsHDoRNwrZeUvm31JPPtoL/F3NLrez97OYMhZsWfkpDiejcSOIb7dg0iDPCzXz0kfw3SFPYPCAtc0m/YWMZM49w2a2XUrfpWRwCdouc91bYElMG+Q5zQEGriPG94pftasU+Pz0pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761603344; c=relaxed/simple;
	bh=dKH8vYMf6SqqIJ4Nr7m9tVSkocGsGWocEbO61fBw+IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H94lel55yIi0zCuxV0OxjEsmktj4j/26gPK+ElKQxAhukhS68s72ohmiQqE4JZJZl+lFq81bJRzq2D8VfDpdAC66vxkxqi/rVjFZqHv40f/1NpGcKKeLbHY7hnvT6ocnlrdhwa7Yid9AVoUZ+FEB+e1B3YDlzSIJL0vWilsIIlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t1aR8brj; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-375eff817a3so55290931fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761603341; x=1762208141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKH8vYMf6SqqIJ4Nr7m9tVSkocGsGWocEbO61fBw+IQ=;
        b=t1aR8brjJFRMEzXt53LT/pcO79CW60rL0z4xB7sFM2vCvDqDowTCoEx3PD+5w+mxjC
         Zy9WGy88PyWw+QvAXi4D/W7x92VYd2ZQhpdoy4gmGykzESBuyXHgici1IBgofw4wh278
         9vee/XI2BEz+P1QerWbnDniNks3hjRjiqnHD0x5KIrkjqhDkjovFTG8FRlsMZhJeC5sq
         E6FGZwfSDoDX4Zo0MWdBpYdUL70lvxB+Na0KspCgV6ZJCsaeGpsj1D1kzzt7VTCbzOwC
         aoxIiTWhf5etn49vvPD2gfxydQcA1hss6+6Plucl4aS06/tPVIMO70sm+O0W2Jcu+lbQ
         SQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761603341; x=1762208141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKH8vYMf6SqqIJ4Nr7m9tVSkocGsGWocEbO61fBw+IQ=;
        b=t9H6ZiJbOPKqkbJvXPadIVsDsOBV9FsNhAcE1OW9o1HH3irznKmn4rJPtyClu4fjnu
         0zGwEus4ByKyK3puoFLvlTAecpEw7BRWO4GRA/shQF2CXM8P6kXLAuGV4Fh7tgIDwW8D
         IW+FYSTERZhbAeklAGH8d3FmlI1FQsPq5YoyDgxUUY8uKdOtgG7/plsDA6vudtsxf0X+
         n7LwH+bCix8UYo5Cqv/l3HRDSndVxDLIL08b8jegO2hCIGUNHf1Ek0gPlithFk6oM2J2
         M9p32O+HPDmjm81qGO0FR2ghnNviZYPQQhi7bZZkqX44kJN31hwztZACnUVjCht2aEBr
         LZOg==
X-Forwarded-Encrypted: i=1; AJvYcCVN9G0iTVUxrLYWDVasIjKSUMuBJsf/BQn0pTLts+BFNDByTsv15KxSMOjmCV7fbu5ZZuaXBF9dnHzT88I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoj0COWCrSByYlYThSH491TSjMi8mEqXoF8P0ODS6hKzllEzIH
	VtwSf7KicpD0utb6OSp0+qA1uk27PBBYq55kttH7royRseMRbwBX+FUUUuUeo2svaPa4N9Lx2kz
	jLbNeMFFh27DDK/lIZHv+Hl7i34dbVjXMwcIygAikcQ==
X-Gm-Gg: ASbGncsU90NUOt2BfDRFRjblAFFhSAmG5pPSSvnONXD7A/xRwWk4XVJvAQ4dg/SBNs6
	twkIKcsyZV1LS3pyukRr0Bhp17V50Ss8oiE8Iyb7OlKxQimiXn+o22KIEZpqIFAYGnwjb1WUOaU
	hgfqrfT83ZtbVbey3MysFII0eaTnSCxWOtDBqDpBzU3pkQKW387sLFtLuEgIexrl2c6wGeNEPXa
	8a9c9VpEKR3N7c+HTe91eW1C/2j/t7PtBw2qtXePRzikCn7mpZ1i6N/n2tprLBiAmzemnE=
X-Google-Smtp-Source: AGHT+IH6m3DSKBdAo1TUZBBV1Cir681XUQKPd2M1XukvdECylY8ML9HXimk23Lw5yV+XpOoav6hKjxByUPzz5iNTOgg=
X-Received: by 2002:a05:651c:1107:20b0:378:cd74:a289 with SMTP id
 38308e7fff4ca-3790774e9edmr2648271fa.42.1761603340965; Mon, 27 Oct 2025
 15:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023132700.1199871-1-antonio.borneo@foss.st.com> <20251023132700.1199871-11-antonio.borneo@foss.st.com>
In-Reply-To: <20251023132700.1199871-11-antonio.borneo@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 23:15:28 +0100
X-Gm-Features: AWmQ_bmjdTr7EUx2uJYxfPf9xIolvT4VGvVXwZyfYUonTVISSkwT-eVliP6qaRY
Message-ID: <CACRpkdYzT3DaqiXTg2swEKxxh2UQbhw2=uF6Md=RON9rWz+6ZQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] dt-bindings: pinctrl: stm32: Use properties from pincfg-node.yaml
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

> Don't re-declare the standard pincfg properties; take them from
> the default schema.
>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>

Patch applied!

Yours,
Linus Walleij

