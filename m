Return-Path: <linux-kernel+bounces-777059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5896B2D498
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62661C405F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81752D3229;
	Wed, 20 Aug 2025 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+nFfGdZ"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74072D47F9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755673986; cv=none; b=WuSkC/FsWZULk3TPlfFXagrTk33EeQ+GXyeYlRWDxrc9bLsMHpdMgS0d6+2a4BAGU9X3eP4Cmf8wpBaWWp85rhqkJAt9K/e+8sg0+4gdqsektEEZUGbU/t4c7um23eSLAqUhCOuZejEXvHTH+DgknD0GdzKog8pn994MACFhY0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755673986; c=relaxed/simple;
	bh=c5+S/1Gf7ZsoEnmy+5rJrXdwibFww9JCyR0LQDM420Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bussq9GBnoSBk959cuBNTbBybSy1HzYKVgYWAI6LTvK9zWwuov9ytZ7RTM2vZ80GN4/SdwucOiiqbS94Dou5YnYcr1F3zvCgNXFxQUx8u+IpazTKUMRcr3ZjLLW5rZf25iBOMmqYBIt0ZZq1GUjLFW8v1j3PsPWFaMKj9DVYwpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u+nFfGdZ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-333f9160c21so44973071fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755673982; x=1756278782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2fgjYTxYjXy8UMOqphDGxwyeF/52vWVWRMlWTcUmd0=;
        b=u+nFfGdZWm2upyZ8H8Q/1YeiqrdWui+lZFdVlGkny+R3i65205+6S5Ibzk6sevqvgV
         4rb8JHRMYClP/cJ23SQUKqMuTE29Uqb1DX8u21fcy4o4x6snD6BxvMzhrPIVGK2Lm+Nc
         oXDYLXx+/51/qtJWoWAYJQCrNgWTHAB1PtK30KrDJzVxEQR7WZQQ/ydXZjYow5wdFRWp
         mblnL7SnWhAFef3QbfiNmMhy0IEK1RwIbimvt3zNOyKoTyJdEeKH4EzOt7/YYLBa66U0
         yqRbk7ufFn9mj2IrpOKCtgpBmd8+eF1uo1icxjl3Ft8G34HtRw1e2DLievg2aGr6EY6i
         zhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755673982; x=1756278782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2fgjYTxYjXy8UMOqphDGxwyeF/52vWVWRMlWTcUmd0=;
        b=NTP+XLTtWL2J38vjRqesZNYO5l2WYVGeyQ5TVuiDuX4aDTjTQ/R0rdSuLxwBPu5Vwf
         q634mo+cL55xbtVjKefhJz9F4OMClB2L7FgfNAtZMjCLtpYZbq7B8L5N5cJMGPdnQ+C0
         fwlbC0LOd/McRCJNSbqpznD3y+o0omeuTvFjQfU8eZk469bcy4S86CibWqahK8v3nVyA
         lXprXObDiyImSBnAwmQC/Bmx/CQibOzSHN4ykFehAZf/V/DLCL9ZHnoENtA6feCvKfrm
         TZeGeIbIlPtQxo+hmYOdmD3LHDa8UJvFCfmhBKq66Kth/WocLZku6AVfvbZpRuz9P8kK
         h6nw==
X-Forwarded-Encrypted: i=1; AJvYcCUCrSP7voBQXlvgxj560j1tQIrJjTUi9i/77MXCcaUGl/UVERDSrBFW9+dSaKhjqh1O0c5160T+JZeGfkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwbeWzVrYCbVfZaNq7TahxvanP4lZkT7m+P5IW4TUtGesg7EId
	EBOlEBm5ZDKltLKPueSJJdKVQ9eav4E7pLemgWXJgpc2bvem7bwC1dS1Cq2RBjE97fGdjWR5SYf
	T2yM/OCKd+pjqn8rzDyLV3qKpa2aa75q7J90K1Jlhiw==
X-Gm-Gg: ASbGncuNY8pVO7rXjXeIEhKR50DuQ7TsR6S+M8NT4Axvhk0mQjWvRHTBegGNOgN9RHu
	VWxabj9GM6rvrp4YUazHj9TwxGs6OXs8oyGKQv3PRRbS/6xBt+x5cNpONlvpluESgzCkuXgRN4i
	gym+335qX5SIW4Pwm8/mwZ1NbJ3Olc5D0iTn5Y70yM+0NgsZvKGvrYm8QbVKlEFQeIvlmocI5OG
	mOlckw/bp0b
X-Google-Smtp-Source: AGHT+IF6EyOC5NaF9ylfzmvC/lF+XZ8ruNEnYsDF5O1GCCUBAqJgipnFljpMN/OqbECQRkpVCXWcXHbvMHeyWEs8R7M=
X-Received: by 2002:a05:651c:41d4:b0:332:45e8:3aca with SMTP id
 38308e7fff4ca-3353be058demr4837631fa.19.1755673981615; Wed, 20 Aug 2025
 00:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815-pinctrl-gpio-pinfuncs-v5-0-955de9fd91db@linaro.org>
 <CACRpkdaDGmdhaik+1saRv7Ts4myQ+tg1aQqGU3xQyT7ma8dJFw@mail.gmail.com> <CAHp75VephepLq61HrVy=PX2oKUQd5NK2qS-vOC5h_NR65td3Uw@mail.gmail.com>
In-Reply-To: <CAHp75VephepLq61HrVy=PX2oKUQd5NK2qS-vOC5h_NR65td3Uw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Aug 2025 09:12:49 +0200
X-Gm-Features: Ac12FXx_mHZvAEY3OP5MA3Uo1ED7cgPY59m1esPAFUlhfqgk9BLjcKH2xKwqp3I
Message-ID: <CACRpkda4soRCLF5=W=6R4wnwT3pjk743j022XfJxjTTQzuarAA@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] pinctrl: introduce the concept of a GPIO pin
 function category
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Andersson <andersson@kernel.org>, 
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
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Chen-Yu Tsai <wenst@chromium.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 8:31=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Aug 19, 2025 at 4:02=E2=80=AFPM Linus Walleij <linus.walleij@lina=
ro.org> wrote:
> > On Fri, Aug 15, 2025 at 11:09=E2=80=AFAM Bartosz Golaszewski <brgl@bgde=
v.pl> wrote:

> > >       devres: provide devm_kmemdup_const()
> > >       pinctrl: ingenic: use struct pinfunction instead of struct func=
tion_desc
> > >       pinctrl: airoha: replace struct function_desc with struct pinfu=
nction
> > >       pinctrl: mediatek: mt7988: use PINCTRL_PIN_FUNCTION()
> > >       pinctrl: mediatek: moore: replace struct function_desc with str=
uct pinfunction
> > >       pinctrl: imx: don't access the pin function radix tree directly
> > >       pinctrl: keembay: release allocated memory in detach path
> > >       pinctrl: keembay: use a dedicated structure for the pinfunction=
 description
> > >       pinctrl: constify pinmux_generic_get_function()
> > >       pinctrl: make struct pinfunction a pointer in struct function_d=
esc
> > >       pinctrl: qcom: use generic pin function helpers
> > >       pinctrl: allow to mark pin functions as requestable GPIOs
> >
> > I applied these 12 patches as a starter so they can
> > stabilize in linux-next.
>
> Hmm... I'm still sure that we don't need to have a separate flags
> field, but since I am on vacation and will be able to look at this
> closer next week, I can't look closer to it.

The qualcomm 32bit platforms fail in next anyway so I dropped the patches
for now.

Both you and Bartosz are on vacation so let's let it rest for a week or two=
.

Yours,
Linus Walleij

