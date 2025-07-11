Return-Path: <linux-kernel+bounces-728171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48D6B02423
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB963B2458
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7DA1DE3B7;
	Fri, 11 Jul 2025 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYUoaaE7"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCE742A9D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259933; cv=none; b=k43fMJ1cGoOZXJoqsH4n/HefIrHaohOaOyGQwURhsw572SiUvCO3RUxEwfEQgxzcMLAqQ12J2bE+skHfbVHxTlmqL8MK3wYp8i0R7rsc+9n/IV0qSZiCJz1UamVA7pHQhW7PhctMVi/QPO2fKtX8JC5STBLB/zOeliuETLXDVHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259933; c=relaxed/simple;
	bh=GQ5fC4S1mkqPz2zMh5GTicpftwvZuHxi2EaAug21viY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAzRXUne7WaxJMyiIbk4bgDfdsbTHFm+ef3vnQ9eTBom75/6q6sQTquQx4pm0WG1uTsWp4J4Dyf8A8W8Y71klK83wvU9m9rG1impDSEtqa292WB/mGhiXHxto+kmrdkgq9kdz1yJ9FNFGjEeasUk1smj30OohjX8FtkstC26eH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pYUoaaE7; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70e302191a3so23590927b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752259930; x=1752864730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0H6HqwurK8du4Yig7CnNYD3RLplnogpWij/DKV6wnM=;
        b=pYUoaaE7s5OynAQAH/ehRj8upc1P3MrELvCeLvTeWe9LmthIRYlGVNU2240rJ+FGIb
         qQZzxQCXRirLxEEztEvv0Liopvr0r/wSzJuzJDvbIJY0DXauYnEX3KQgwrkDHqrrzpz8
         Z/6I5dXfJsKhYpkIGUn7lPNXjF9VHUfLwvuYGGVa2MciYZKMRyk5tWhk3o/xfqxzW2/w
         Ps6DwPi7dzioSOVPKUjJkmL9gf8HcMLvFcSvE/dOAjgjl2h3bkEq573qDLpoLqqQragI
         2GlQKVAC1ddvcgp9ET5GJBIMXJLMS1YrcViEjI7AH7iwZJBainQI8eclCO4clelcKLeJ
         QYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752259930; x=1752864730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0H6HqwurK8du4Yig7CnNYD3RLplnogpWij/DKV6wnM=;
        b=HriKGOvhUXH9qlFXDoXHac0UxRygWC06f3jcSDr7jYY9m6AhodSHKwSNm1AUHQWBRy
         3SLIcsYU46k7BHnlWSfhuNmMiO1Pk4QDnVBWMQ7qDrmMUDax8au+X1wqWl+pmvZrwjUQ
         45Ip6R1A4VVXW5JK36ClHlUE4doHpKU/H82afz2bzqDqdEmAA03x/e2qBJwm9ph2eoVI
         ChwW0oIKamJpAvG6mLIpP24jD7bIqsJro8oe/GRQpjPQI2aZuiS0bHN0H17Y+g51P3mq
         hhuegE4mpneJ5wyK6O+dtvlFibgviU0UZk1s8wAL0gIUq0inLlL8cdP+FsUgfF9PqrbN
         ICHg==
X-Forwarded-Encrypted: i=1; AJvYcCW5mftKFdBgYbgZRqsgkngkHPAj+Citj6ovgFAVKSAW6iWCK+T2E+AX5c1YN8VHoLdv631/4UZih9I737Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9fJHRuWxlY0/CThrvNi458KZXu81/rDs01LS5oS34xQJtfVP9
	8DkJCR268dAHE6dWVN3iPFgymXA/ZvRttzhjEIqs5OTegDLqf5nQQjCJ9zK0Q06qMrpVeubj+dA
	i0NlypQtAA8HwmpaOTns0k7flJRqNXbDA9Vpmidnx8g==
X-Gm-Gg: ASbGncv0TsREEZxq3hAYy8SkXxm8UWQ0rJIGd0eFyk8LJKg61ZrfHLfWHqjW9qnlinF
	eFu6v+HyTvIw+Cnu5imoB6/tyjSDG2MXbOmV0Ka0dhPGRMLGTYnL41aDCe98RUp64HSOp28Oyj3
	HckZYVybNI4WuiVy5VIlzehTU7laRtsU4RhzzBvDSNK8B6m2ETSPATdUrsoi0H6G+j7tl4Cg3rK
	JtbzD4=
X-Google-Smtp-Source: AGHT+IFufbqtAPFq7ox05U9WlMb90rIorTP+4zmeOZAsbdsvZ9oDhtS+8uVsO137m7BSFuFbQhKQyBmLxkmw/Jfm0ww=
X-Received: by 2002:a05:690c:6ac2:b0:70e:73ce:80de with SMTP id
 00721157ae682-717daeb302dmr49577697b3.25.1752259929914; Fri, 11 Jul 2025
 11:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711-hdp-upstream-v7-0-faeecf7aaee1@foss.st.com>
 <20250711-hdp-upstream-v7-1-faeecf7aaee1@foss.st.com> <11a49801-d187-479b-865b-810ca5adbf00@foss.st.com>
In-Reply-To: <11a49801-d187-479b-865b-810ca5adbf00@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jul 2025 20:51:56 +0200
X-Gm-Features: Ac12FXxNxgzgzDBEHJS_Xpef7MtqDivB9Et0gKV7kxfFrSfbv0PvRNxLHxkuJiA
Message-ID: <CACRpkdYXQRGO7BrF9+08StWyOkDoqLhNQdgk=bhoccg1BogpqQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] dt-bindings: pinctrl: stm32: Introduce HDP
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Antonio Borneo <antonio.borneo@foss.st.com>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 10:04=E2=80=AFAM Clement LE GOFFIC
<clement.legoffic@foss.st.com> wrote:

> > +maintainers:
> > +  - Cl=C3=A9ment LE GOFFIC <clement.legoffic@foss.st.com>
>
> Oops, need to change the mail address here too.

Don't worry I fixed it while applying the patch.

Yours,
Linus Walleij

