Return-Path: <linux-kernel+bounces-861796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EEBBF3AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89F694EEB28
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9DE314A6A;
	Mon, 20 Oct 2025 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TwCZ2gOh"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E82F90C5
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994891; cv=none; b=pmu9EOVbfjZklE7RcJGBbb4hJ5xlKZ8RsdMIRpMoFfaN4fKNWsTV1eX6jpf/RQGcEsGvU34+PJSTomsxzlp5tMY8j9J4XrwZfaRB5AirdZ2TfHg95h9L+z1N02G3zDwZKiA3wT7TdJJPdawZ6OdoJYVxQiN0lMyzKbZ/pdVu8Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994891; c=relaxed/simple;
	bh=Anov0QvRPQfn4K2J8uUtp5viSlmFSR3/aNvGLqYjUXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLvGBGEkIkSLw6rOY8xe6PDSB+zTSfEpAqbF0NUMhK1Y4xxBmd6i6rCpWG6cOyaxymU2sMiaSMo86NzTPXJAgPby6IC1SgJxvmVgFQEtc4LFUoLAKbyQwYEGBSgOPAm1ackujnzMiAziTG0zyJfWZ+XIUJo9GSYFDHUKdXpW0Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TwCZ2gOh; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7849f01e56eso18078897b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760994888; x=1761599688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Anov0QvRPQfn4K2J8uUtp5viSlmFSR3/aNvGLqYjUXo=;
        b=TwCZ2gOh0m7uPiFE9a9eaPZPNHWNRarxal5P3dIOIeX4831Lv0jAnaW+xN41mQ9hqH
         EUPXeOKV6tLbh3NGiSD11heLJTaRI1GLE41KbjfayuV7zlO32JMH3UW0RuvOIQJcVNd3
         vmNH2MPSoKmJCktHe/g/SUdWCSFfgxXNxMEVySqTBxzQY95xxrAFRZ/iXU0otWldX72h
         kL9UAAexV2OHV2B4i15RKd/JRk/ISrWHseRJ5PpdpHGoDAPhoj9d7ILgYXA/04we1p1v
         uybwQtTEVlmcgQ3OyKYW/QjKD5e7O3cM4K4iwahF/GiJTCPqjYad69qotaaEpRPStYlK
         VeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760994888; x=1761599688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Anov0QvRPQfn4K2J8uUtp5viSlmFSR3/aNvGLqYjUXo=;
        b=nk/bGIBvHfYjwEs+nRZK13UUIrP3vr3O6AvETLwbeqNEyk/YwaJaCblHJDumL236AL
         Dq6ZP7ge4iOU8UXLCYfgdUtui4rC63OsJuLbJ07nDd6T9jbnDtvcdUaS9GBLvybMFI4B
         uox1HxL0xDyf/73TK55RVXtIXq9eKPxR2WrsHEzvuvVa0fvJWcHc5X8+mIMgdggNCE0V
         oFbYHtnu8pHxHBoN9lr9tDAPBGTb/743rxrrGbmLK0pQo+A/FAR/d/TCFCwAzEIaQPDb
         2WrskIqJdyB5GG6k5IV/xyOr1LvEQUA0/HZuaTF/BWT9S2h8sKclAN9rhl8SDIVrJ1kO
         c19Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOSe1ibUqpgra5NDnC4/LQNw6FnjrNzzzGqPfvn3CPJXe9HX9riEha5+aAcj3NMxkpPYNXTMoq6x/NShI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydrspseN28NZjuzC6dCAMBQQtJeXgqYUuFbZaV5lfoyV9vc1qo
	8FOvgOmlHz1rKHrg/NomqWN3g7xEzL99S1s9fph8DAVFSH7TwHceiDdZWT4cQI43eCLxtz3Toyk
	waeVJ4L6KDcVOWg9Amn1Luz9Ej5fY1c7RVeWkh2Z+sCTI4F7MfeItt+E=
X-Gm-Gg: ASbGncuL3qo3Aa8zhuamkOMPYcdXQ480UEnN0FPn1zRNFIymGxBBSXiqtIgdANRe1SA
	opOqH/p1thNwYZTpY0jt52e2XHuoyit+O2VpMh/Uafp57cGBm5i5vKBWv3uEnxTinn7Da6c3bFa
	4zFOK86A+HbubifJb1EvF2WU8PN/MAASYXGrfSphDWxVW0mOwTc6wS8qOD7J9fkmA7wmBvJqAVJ
	nVLDea32L/YFWSjKpsv5e52VNYuRod1yp2xrNrOHTeWH4Z7/rk5EAPBCjTs
X-Google-Smtp-Source: AGHT+IHhrp7Mn9zG8R+s34GGCarO9Dn8P7XKckYmdVwHQpsn3aJyInOYeKKns+cAzGFVWkgEGpTwoLHL2z6emdmu3u4=
X-Received: by 2002:a05:690e:12cb:b0:63e:2f48:2bcb with SMTP id
 956f58d0204a3-63e2f482c43mr6596645d50.62.1760994887673; Mon, 20 Oct 2025
 14:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017143302.1776953-1-arnd@kernel.org>
In-Reply-To: <20251017143302.1776953-1-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 20 Oct 2025 23:14:33 +0200
X-Gm-Features: AS18NWDHiKNwFnALX7AQT5km93TFZcU8T80jIGuWJpNTNbsxPXZ2-GQ-sa1_jQk
Message-ID: <CACRpkdav6Q8Sv_JC3g86YttdGiPsvmSs+5OBxOX-EL5-S4LJhA@mail.gmail.com>
Subject: Re: [PATCH] soc: officially expand maintainership team
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 4:33=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Since Olof moved on from the soc tree maintenance, Arnd has mainly taken
> care of the day-to-day activities around the SoC tree by himself, which
> is generally not a good setup.
>
> Krzysztof, Linus and Alexandre have volunteered to become co-maintainers
> of the SoC tree, with the plan of taking turns to do merges and reviews
> to spread the workload. In addition, Drew joins as another reviewer.
>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Drew Fustini <fustini@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

