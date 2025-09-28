Return-Path: <linux-kernel+bounces-835588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E0BBA7859
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 23:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B851897B79
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6353284886;
	Sun, 28 Sep 2025 21:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mumLQ4Ly"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EBD225D6
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759094654; cv=none; b=nLeqgIyPmqnxRdrmfW/bTltTH9H8dfgQd9vdjwA7z8WAjjp37ODmet/ThS/oV2K9Y1xoWV54QIcPEJKP7XX7k+0p+Gf2jRUvG07sAsF9ENM2AmiONDAlLUppPaAxHkASi2gLffDYyFNunQcNlHjF43S4SuBaUIQOiwlm7ZJBFM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759094654; c=relaxed/simple;
	bh=cOs1jGf4tObphA/MyATHCw5E7vZEFM2EiP4B42o16HQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOyt4Nbtfa3SfJkLZDDZvP+zfW2WgVqG0TQTS7fx7kSsb6GMO79HQqLyZsm4H6Rt8njNzb4mPrd3A6ZXJQ1jTDpPgzbeEqG1dBJ1G9k6F9k75glXX9Kd2g+qMuxyJhIpsz03t6LxSwr3NIr1FJbollUDnflGVF48EfwiyD4/JTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=mumLQ4Ly; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b54dd647edcso3472074a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 14:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759094652; x=1759699452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/EfDBi2iuXg+iTflyjOQYQZOOuaeW3hYJUN8DQ5IUg=;
        b=mumLQ4Ly8DoUsfhydUAg7j33NFZNvBxPbHjDI8/zH5WbkV0Xq9P0sItAl67GPvXRxL
         jSZgv0Y9mZN55IBWnSmzr5DsJkkFkq0qiR1hnb+66hDxvGn9hf/faydXjZi+6PH/pkSp
         +GRr8nvtIgsEoG9934ZAyM5R49p+9CcM3RpQC/of7ipFAu4uT2we83HZjeDFnN3YTkVw
         I1qFJtIY3pyQ1cbAGT+U3OZMcHFrGqXpZOG+9gXiWwiAfjq3ldLQjY3JaUeJeGBLzL8z
         yHh6t5bnvhM+inPu7N/PC5FdaKrplucmG+7u9T4SEUkSW/WooK2haFX20l/+X16Hc1Mm
         560g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759094652; x=1759699452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/EfDBi2iuXg+iTflyjOQYQZOOuaeW3hYJUN8DQ5IUg=;
        b=i9X6TyF0nb0PFse2BeQoln35JoBjmswar+Sjzw3MLFvmSQy284wjbehpsmNAmqzePB
         cTFpiBnhNU3kM7BwvvcS6FK0nTVfLKiq6yqAjGpJicemFMStCwyOjUo8T3yj8yq6O3gc
         +nBFGEU6ZoztjsUFvruaVMwZDwrKpd/XQ0VbS0CG/LemWidERyKE7dAnI5zczJriUgqg
         HimY6gRd0yINC9Lr0AVczOxJxD5YfBULyfXe7/qrA28F7Me2HSE0dU4pj9qZZOjNuq2v
         lszhXe/fG44s+ePUQwdhDkiOUMuNlGvtWnxiBhmNU6A9w2taguzc0LQJX8s1RlOM0KPn
         lYDA==
X-Forwarded-Encrypted: i=1; AJvYcCWFvpZHLiahYCyFveoiXdbQmyFtJ8roipD++zSrSfBI6i8Jv5gUHZWv+sWlK2ed07sNUm6jPBRTzH2kF6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7FVOklkHNgNTwsBBn/SdCTlm1/KsV2epr181yd3Hy8B4uqzyc
	4dWmTDO93yUv+/tJL47/3d/DfBC96X+Tddpi+ddF9J9FsrMRscessOrqyu1rGLBl97ZKSUwFv4D
	dkpPiJeqzZ3x+ZT406XStnncWvkqSbsk=
X-Gm-Gg: ASbGnctIwKo/qgGXuR4kTOunCbalYdllWQvZW9OYSummVzEA7DvBj2wd2sDOI7hUk7v
	kaFy4Yl63AiKEFeJ2xZu9Iy4S+JOVZgXEV1q1Z5mzeLSAtAWbVIqp1ssz/3/uUHbd3MuZF2tc8M
	VaAUKiwx3qxSonnuU9S4n3BqcxsgL1QMnKBX1bRVB/E7hPlbtZEwgSMHldyDvBPYzLiGFJSf7Gp
	8jwTEL9EBFogjlAKiA6zElZxl15OzAhoC3x5Ejn
X-Google-Smtp-Source: AGHT+IGYeAH/2koMMwWRpMeTjHt3nx4vF27nPj6cQxfPYTjKMshJ5FnJQAOC0KdwVHl9l4KPM6h4tqlgjIdg+H3Sves=
X-Received: by 2002:a17:903:19ee:b0:269:b6c8:4a4b with SMTP id
 d9443c01a7336-27ed49c7798mr160858095ad.6.1759094652033; Sun, 28 Sep 2025
 14:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927130239.825060-1-christianshewitt@gmail.com>
In-Reply-To: <20250927130239.825060-1-christianshewitt@gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 28 Sep 2025 23:24:01 +0200
X-Gm-Features: AS18NWDzM6EO1Jvv--jbu1zBUk9kHyWLoS06NGipbYnYIhNafpGwzdVcGq2jayY
Message-ID: <CAFBinCCsTqsn06A5oVXGTW6PgmSQH0bHE+8PSftyWNRAbYUTcA@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: add support for 2560x1440 resolution output
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Dongjin Kim <tobetter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Sat, Sep 27, 2025 at 3:02=E2=80=AFPM Christian Hewitt
<christianshewitt@gmail.com> wrote:
[...]
> @@ -894,6 +908,10 @@ static void meson_vclk_set(struct meson_drm *priv,
>                         m =3D 0xf7;
>                         frac =3D vic_alternate_clock ? 0x8148 : 0x10000;
>                         break;
> +               case 4830000:
> +                       m =3D 0xc9;
> +                       frac =3D 0xd560;
> +                       break;
Initially I thought this was wrong because it's only added for the
G12A (which is also used on G12B and SM1) code-path, leaving out the
GX SoCs.

Was the 2560x1440 mode tested on a computer monitor or a TV?
I suspect it's the former, so I think it expected the code to take the
MESON_VCLK_TARGET_DMT path, which automatically calculates m and frac.

I'll give it a try on Friday as I do have a computer monitor with that
resolution - so any hints for testing are welcome!


Best regards,
Martin

