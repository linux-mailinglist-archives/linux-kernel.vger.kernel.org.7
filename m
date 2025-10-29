Return-Path: <linux-kernel+bounces-875438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D64EC19019
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E8B1C873B2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167B7313E21;
	Wed, 29 Oct 2025 08:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q/MSmyNE"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353B2F7454
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725677; cv=none; b=BwwaKvZcGRMj2uXzsJGBNem/MMaQllRlO3InlXCsATZFl6EaV6ZLQzMSfZZjAYNoezqGTrI+AXGUkzOX8Jh2pD+YL47KS+xx8ApubRghswhvB1RUzSf7UlrlqeFwr19luZw7AMdXMUz0ZRpAZG/x4HXLxwpsVo4g0j64Hf8A3Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725677; c=relaxed/simple;
	bh=N8+rq+xZPmi2I8g0y9aIjmTjbWxMyaupeqzQVgZxcEI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=udAQ/1nvLX7Z9hXjy/vRTPMr3fD655tPpvRN9co7kb0y8zgEGcqIBWeF3PaIWAbqpaCPtG6M5WVxxJXlN8inffQxejTSAUVgE0XcT7io+vPcWl4N6iKpyYM1Dt3JESolALIHN4mio5SAZCq+hWwGjcpvNM0Z5QCmVX8udDgDiJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=q/MSmyNE; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4270a3464bcso5344332f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761725673; x=1762330473; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N8+rq+xZPmi2I8g0y9aIjmTjbWxMyaupeqzQVgZxcEI=;
        b=q/MSmyNErSG3WrJuo8/S4qizy8/Mkzrlj/B7AzKZIy7NEkcpvM/f4ISfNOTyUnyQzT
         i+4TIwCi68sSruMXfSTxunglgueGWKTOgmsajVc5L37vhEj3h5UR6CzIJHDrV147VZDm
         +PPAm/jSQZNCOjFA4AGlkzHU0kq5sduBUe6brCmjZWQ1K4+tkvKYmB13b0YgdRnCk3lN
         gc5KZcE5Tn+DC7Ve0toGHwd3eAFKzq20ZLwc2OxJ8reXsbhjiXJkKQk1FR+WJg1XNWTk
         yTThh1FpCY2GoexZYjIm3umvwGarOwVk7B6AnhpHreWwy7vho0ShK+5Y5eegCOAGyIM7
         NsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725673; x=1762330473;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8+rq+xZPmi2I8g0y9aIjmTjbWxMyaupeqzQVgZxcEI=;
        b=enwKmJRmBQfQsIgyMNB41Itxzf7CtzM1d5waxJHrAoNkUrb7zOzbJo59M7zrB0Mvjm
         Nh3nI44kHUKU6wa10ovmkZ2qlFgRiZkGl2AWyQig17oGUR39JXNDCkcWbAF2y33KFz3k
         ZMm7mWqx+yvWCyKsfSz2dWn/wToXDpOvN84Zq+RYHqnbRtD73LIiV+h2e/bvuEWl8KPK
         MjA5GfvHs+V6LY34vCZOsLg2mnCx29eVYP9Fxm8r8HU+BVUOWBOkX23+J47G1y1rgy7D
         35VKwtXGbM4lfzE1awlSVn5Nzavf2Y/aJuv9DhnpHEcBMWHi382D5oKkkIGHoAiELlQc
         ZHaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMk5kT5zMnm/OG2hj+UEHCJWt/5qM/EwekmSrWJ/PlW6TyrYh1uTI6ZbpLrxvQXHjWvdDb+MgNjTKf3Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNei/G4aC0TGmxMRnmtPbwIriuyGkAkPo3mb0yY+SIu5DxYi3f
	yuF7iLuDRXDjnaH+m5Bh6ixlaVLSzKZtjbj2mFVExXI3Wmx62BoQjbUhcDgF/kaWe70=
X-Gm-Gg: ASbGncvHSOD+1MMAzDqIgGm8QNffQbpiPR6SJTC31BiAebEgJxJ1TiCNphUBJFVGxF6
	Y6bvHYih71L8k6q620XJaAmdAuAFABLHp+qlOboD4aLM5U15bkoholHFvDXrD+pvoa7Sgq91+nn
	eoIHscXLvfI5D0DZ9s1fPJyaUl92OtCoZyNIPcPASW9amVTt9PkBvNl1Yv+eA79Zc224WZ5Nbep
	6KwQpdf8QoYV9BLkEvLC6mDN6BnN+u//rX/qKHFx9uUIcZO6zr1Y+1fFsJUhc7aLKJbrPKo0fMj
	MMzblGEWmD45DJHHJWt2KR/YyWnkSkovRls85JBBoxrr9rW4JgpY5klbwWE3u+O7+ItKst4uSDb
	hacCRQCwN8Qv8nkz9wJThr7xFLQtyBZ6NFtze4heRDm/i78kdqYVqGI0ysDN8Wm6PbmHG6UsIjo
	HQE80=
X-Google-Smtp-Source: AGHT+IEwzzvxzDwy2hXfDTMyKk2u3q3b4WDeoC3Cd1r42aF64N8QkWqyq5rTqATRPlQPagJ+AbKIrw==
X-Received: by 2002:a05:6000:240f:b0:428:52d1:73ab with SMTP id ffacd0b85a97d-429aefcd0f0mr1311537f8f.58.1761725672718;
        Wed, 29 Oct 2025 01:14:32 -0700 (PDT)
Received: from localhost ([195.52.63.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df6b9sm25774340f8f.44.2025.10.29.01.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=47d5f61bca1ab14c9eafcd8930ddd77eb5a3992e8bb0bd44140ee03f8bb9;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 29 Oct 2025 09:14:23 +0100
Message-Id: <DDUNMKXD4HRX.DXUT67S354TJ@baylibre.com>
To: "Miaoqian Lin" <linmq006@gmail.com>, "Chun-Kuang Hu"
 <chunkuang.hu@kernel.org>, "Philipp Zabel" <p.zabel@pengutronix.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>, "CK Hu" <ck.hu@mediatek.com>, "Dmitry Osipenko"
 <dmitry.osipenko@collabora.com>, "Guillaume Ranquet"
 <granquet@baylibre.com>, <dri-devel@lists.freedesktop.org>,
 <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Cc: <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/mediatek: Fix device node reference leak in
 mtk_dp_dt_parse()
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251029072307.10955-1-linmq006@gmail.com>
In-Reply-To: <20251029072307.10955-1-linmq006@gmail.com>

--47d5f61bca1ab14c9eafcd8930ddd77eb5a3992e8bb0bd44140ee03f8bb9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Oct 29, 2025 at 8:23 AM CET, Miaoqian Lin wrote:
> The function mtk_dp_dt_parse() calls of_graph_get_endpoint_by_regs()
> to get the endpoint device node, but fails to call of_node_put() to relea=
se
> the reference when the function returns. This results in a device node
> reference leak.
>
> Fix this by adding the missing of_node_put() call before returning from
> the function.
>
> Found via static analysis and code review.
>
> Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort drive=
r")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best
Markus

--47d5f61bca1ab14c9eafcd8930ddd77eb5a3992e8bb0bd44140ee03f8bb9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaQHM3xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMY
BQEAuHoHmQztjd0qDVochaQgMwU/UDAYYFg9Pt2qLtKUZoIA/RVh2U8TuEbNs/4U
K3J+cqEkOl1LVK9aUjFYUv90UyQJ
=nF+A
-----END PGP SIGNATURE-----

--47d5f61bca1ab14c9eafcd8930ddd77eb5a3992e8bb0bd44140ee03f8bb9--

