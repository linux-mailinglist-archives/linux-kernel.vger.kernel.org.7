Return-Path: <linux-kernel+bounces-857032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D87BE5B21
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBDED4F61FD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A482D9EF8;
	Thu, 16 Oct 2025 22:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GbCxO3Jz"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F8D3BB5A
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760654075; cv=none; b=hhXrIMgo//FmzGQh5+JR/wsJJGzfZS8ICVfzDy7//sCja7VwghqGVSnvgRNdlCFcDLLiREgm7tVx8Lce9y1iF/brAMCXOpy50xbPaQVqDXhVcWWhWfl7DClsqZ3DqX8FG6oq5WVqEVKJCHpz8d7+j7T8/hogDEkw6bDFxmocfJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760654075; c=relaxed/simple;
	bh=iX+5unsZ/nIc8zTlOk5LEx289kMidILELWKfCtaDFTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnqI54UZYrJ8yPv1j/QUqGNl4QDjy4Zsa9f1/3uRD1VzjiI7ZvAznkgYYHU91zQPFlmW9XIxWkwSc50WcqyyaQds+B54xtJgCTjyeICGW3KPKKJ5H+VD8RoZrKgE8vTTeTeYdlf/j0GehD3TU3MDdiQ6cQ6itRaqmHK6iGtQNFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GbCxO3Jz; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-363f137bbf8so10774961fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760654072; x=1761258872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iX+5unsZ/nIc8zTlOk5LEx289kMidILELWKfCtaDFTo=;
        b=GbCxO3JzFZOtdCZdB6AL0d6h42NLdhHHSvZ25WZcN6gnzWh3cwKf7u9Qb9FJ+sqCCg
         N+JFVDB32qjYnkbL+p/AbXxNI5Eus5I3VEEr5iKt9xj3lKcrnStB6dgP2UGYui3fUYh5
         dJwPDloaJjPv0Gyl2+b9ETXJBGpzwmMn5uPewW0kc7Td5fuZKsiK8TseoAUpVoTNAsW0
         NXRlO1zYcl3S2tJTdYjoq2jPap9KqiSvC4KzxbsR0NZfJdpHASRL50Eype7fyPqXbBKg
         68WvT1AiodzN0sLQ0Q69DZ6u3ZTGgS6RFsyJwaBpQXUnNE11y9OMKuvWv5iWhlbe0rU4
         eIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760654072; x=1761258872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iX+5unsZ/nIc8zTlOk5LEx289kMidILELWKfCtaDFTo=;
        b=L4ck/hRRzS/i706alHek+fv33RTKQQdEQcJTwfzbuy1/nHt5/kQyyKqAoMKos3RE+q
         0IGJNXQgVLrgR1fSichnzpTlZR3BvY4BWrXsWwtFHrVVn+wBJEM8Ux1GFPujEB/D6dTF
         5Tgwy5jK+Qev8o1yqTeoh9e4HFVBxCvCs+zU28vB0lQoOpA60IufNXKeG9e+Fr7kSDY8
         ljqnySv6LPMReVo1yz5PnV3LSCWzhD/8YKW+wpScbod77pgDerVYUikBR1xQaRhGrqco
         HS93RzsOyVh1oJaQGnbiRzYCUO40uX93C7eayHuiKm4Ni7iaXeVb5yd4532e2p6TAfUe
         FFsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtefPdzqLQj5O6eqjG41kzueOdJncJTuce4m66PPwSiLM5q84TewZTUse/z8HclliLHDjTTCAPA5x9IB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3s3ZZVexvytW2L41lY9Ant849U87lKnJ75IpGqnetUGc46lHy
	+uXcVY1ykmUF+hfhF5RsF+GzaS+s1pVMoPxH9n17FLmZZOvQVrnPCKojVRWRV3EHzj2YV8VsR9H
	HCq+ANX4T8Zx5YEM019Crer/UD8d6a/dO9N8brqj5ww==
X-Gm-Gg: ASbGncvaOF9FcAjqUVAs8B6GnHEje8JMj1hc+mvVur36prQrr+0KwEwiM0Ba452Ln8k
	XICvSlzE4gj5HpkeFb7ZeDa+3FMPP3Vr3jy6Ip91AHga8o/uVzN9tNJ2ExgYnO6zhkubHTnw0gm
	hGwVHP8/DqKh0IDF8a0ph/h4MBLCD8coa0ZQl7ckx+zHrqF6XHYG65du4In2M1TQ4uH7YvrZz/E
	x6LbbgiJc3tPT9XSEhbTMAxYAnrwcvk0sLVn2M0MfPU2XNRJSlRGzEpPgQY
X-Google-Smtp-Source: AGHT+IFA4cyVMFygunIvR6Sb+S9YIRIcOrQFSwrOM7TfF/g+giPJ+nTPjzhR5YZOyLHNwAaJZrRx7sKEMrauQ98ImcA=
X-Received: by 2002:a05:651c:1b12:b0:376:4320:e362 with SMTP id
 38308e7fff4ca-37797ad8130mr5292681fa.48.1760654071781; Thu, 16 Oct 2025
 15:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014140451.1009969-1-antonio.borneo@foss.st.com>
 <20251014140451.1009969-3-antonio.borneo@foss.st.com> <20251014-barbecue-crewman-717fe614daa6@spud>
 <CACRpkdZT20cdH+G6Gjw8PopAkir+gGgMtRR4pkjnXFrmDkdfog@mail.gmail.com>
 <20251014-water-gown-11558c4eabe7@spud> <7ba7c2f2a6dcfac30f05b35a4f41ef0af2dab575.camel@foss.st.com>
In-Reply-To: <7ba7c2f2a6dcfac30f05b35a4f41ef0af2dab575.camel@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 17 Oct 2025 00:34:20 +0200
X-Gm-Features: AS18NWC4woaW4Og4j92NIZzv9C3mFxPWXkXZf-tyb-63Pv9rPBLJcNATzKQalio
Message-ID: <CACRpkdahbDfu+ffZC50hPrZRRo85_A3WUr8za-D7_tRJA6shrg@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] dt-bindings: pincfg-node: Add properties 'skew-delay-{in,out}put'
To: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Christophe Roullier <christophe.roullier@foss.st.com>, 
	Fabien Dessenne <fabien.dessenne@foss.st.com>, Valentin Caron <valentin.caron@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 2:52=E2=80=AFPM Antonio Borneo
<antonio.borneo@foss.st.com> wrote:

> What about the existing 'skew-delay'? Should it become deprecated in
> favor of a new 'skew-delay-ps' ?

Maybe it should be deprecated I didn't think of that.

I think there is no need for a new property to replace it,
your new properties can be used, just with input and output
skews set to the same value, so hardware that can only
control one skew knob should complain if the values
are different.

Yours,
Linus Walleij

