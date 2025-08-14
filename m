Return-Path: <linux-kernel+bounces-767893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF42B25A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452F92A3AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B621E1E00;
	Thu, 14 Aug 2025 03:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EKHSha6q"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146CC188A0C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755143874; cv=none; b=JyqGB6170hgwKFjpjMotNsufeVcrjkqjWifCes3tCz7nS/SEf6zjsfQS9+LO/g+ZUwoUz8NYldUAzUWMUm5qRh5EnC/TI3rQ0E9wNR7VXa0NS7y+IIoU1Fa1eln6OdP5e4EddDKo6MvzJPF87tiPEuRq3irap5Cqr187ryMZFCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755143874; c=relaxed/simple;
	bh=KuAzkdu+nBeW4XQJu6RSp1V8OBm3suYsUZfkIRqSD68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwTDzz/D7xSdSyhw+5W1sq1LhuA1l7JKTCdW8RMAN5kNgDoVq2dvARDkRu4Yq4EmCqvNhIvAKLncQO/TLFmdGUFjcmZWa4UOR3hrvmLo5R4Z3YnIqPy13HGf4hvDPa4NTNSAz5NWkwtZOJMWa77ffIQykCU3ftruWThS7tA1BGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EKHSha6q; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55ce528022eso505044e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755143871; x=1755748671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuAzkdu+nBeW4XQJu6RSp1V8OBm3suYsUZfkIRqSD68=;
        b=EKHSha6qdcBlsS3gXN4Cw+T6fWwdA1YCyfFc5q8C+8u6tYxjS3yl3WEbF+GocUde6a
         Yr4akzI6BV7tlc0LbiOXzgB/ACP7W21rMCxsdytPp7bq7N3Oot9ZRftp5aDUg4ZN4OKs
         loF7b7jyJYM9Acbf/YX0K99D2wwAo400Usa/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755143871; x=1755748671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuAzkdu+nBeW4XQJu6RSp1V8OBm3suYsUZfkIRqSD68=;
        b=tDAUwpotRu0X+T/DD6hnRz5YLg7e6cuUtzriTlD/j5xP3LiFcbSKMAKfw+QJ2DFGiM
         teQRH6u0iV7ZslWW8wzoos9b9Q16Zelg2k2P39Z0TIPRRPsBnnKNUUQ5G/Yp/xh6xI4l
         7gvE7YzcGBSKJj12BR1fmIFscHxmAWGi45amBzqr6cKQo3+g59j6amAE9vR6/Wy3nnpB
         F1fqf+Wu+wpeWum5/NkSmHQlg3JhQe+NSKFQUV9rMA526rAECha3VACFlYLAU+5TKRLl
         fPfoXOz+xtCOetzg1XltV6lEwdP6hMPonk33aYsKgQ7vv5yZQGMkcYNp+PqY+evjKuzf
         p5pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzoFxJWOUfJ0Z8yofcPtDdBW2GwbEF9jYBp0nl9c5S2vFZrD8fPBBqcBp1oUXYm/6/ioKZ5GCrveuiM2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhLEfqpmEBjIRXrM9sCGCbbXZoz3m8KKreuFtfbxPsIOnDZZ3a
	EDBdoeJObHm4Ec3thBJlaVQ6JWNnXkmx+u5qJuHl7sQ5DC3d0CEDnCBqrTnH1l5Y6S8aZDB1ene
	A1/bxNqF1lX+D7rAU8NqB3rhci7oSiVuf+z0pa5rt
X-Gm-Gg: ASbGncsbmejPPVE0i4lmHTMP9fK5Pc8TwHffRmJuK7tzwiWgzCAczwQAiWyhbti8nrX
	iMXDBaKBtHDfCs6fXE9kdoY8UDqUQE85MFXsPOgezA/MV+alfB94ZmfWpA278cIIsB0VyNetLt4
	M43BN4ojWAu1fOVJC+BqYl+peyxTFlrV6bg0k+abF0m+ROKIT3i+0zoqK9MpN3RRXSsPeU2znpI
	2G5PNj0ygqeX4bljLfzqUdEGk5oX5EDB3Tsdt3IsQgSTQ==
X-Google-Smtp-Source: AGHT+IF+5iKv8rMK9YHb6myK/q855kRCdUIsQfOlyE7uVil4m3zuwOKJ3gr0xAyECxLHg6Jl7SqsZkrMsfX9UPSHH2s=
X-Received: by 2002:a05:6512:b8a:b0:55b:8211:cc88 with SMTP id
 2adb3069b0e04-55ce508ddefmr488807e87.51.1755143871084; Wed, 13 Aug 2025
 20:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-pinctrl-gpio-pinfuncs-v4-0-bb3906c55e64@linaro.org> <20250812-pinctrl-gpio-pinfuncs-v4-4-bb3906c55e64@linaro.org>
In-Reply-To: <20250812-pinctrl-gpio-pinfuncs-v4-4-bb3906c55e64@linaro.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 14 Aug 2025 11:57:40 +0800
X-Gm-Features: Ac12FXwH4SzGC_raZvHd6w5DhOOOwcWIZ0DYC3dWkFgv22xak8lk2qDrshBunvY
Message-ID: <CAGXv+5EDj4JEKAFC-Sv8kyiBNy8SViEXaepdssG5QTu_HtYQHw@mail.gmail.com>
Subject: Re: [PATCH v4 04/15] pinctrl: mediatek: mt7988: use PINCTRL_PIN_FUNCTION()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Alexey Klimov <alexey.klimov@linaro.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Paul Cercueil <paul@crapouillou.net>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP S32 Linux Team <s32@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Tony Lindgren <tony@atomide.com>, 
	Haojian Zhuang <haojian.zhuang@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, imx@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 8:36=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We have a dedicated initializer macro for defining pin functions for
> mediatek drivers so use it here.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

