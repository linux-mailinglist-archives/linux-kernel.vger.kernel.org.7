Return-Path: <linux-kernel+bounces-846357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BE5BC7A92
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBEE19E6F81
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CDF296BC5;
	Thu,  9 Oct 2025 07:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jkomd7Qa"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC4D1D5147
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759994383; cv=none; b=RQZdqxVN4Uoc5JJ34H25J/YwVj1mlVkFoWfwGv3uRgWeeXr6HE/71HuXgkWEEDqOcMw5GiNjPgad4fC31N8qEcl8uAhgYt0yX9oZQPra470FryrcifSBQyjxs7TtQbyNONRZpOadDys5ds2QNYaHtPsdNWH1iN8M+64/BpD7YN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759994383; c=relaxed/simple;
	bh=oSwSu7UxNbNkaNtKrVySKYicTsoE7H2TkVuZcXvnVcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujkoR1TJoikvYGA6FiwsQFQycJt34J/bp+i00KkZORoLiqVpUD8n2II7K317S2UwF7D7O7s+YT+YMiC6AvFmjHXIz3QiZVfKXg3MCvYNnkvXXnTS73nUBwvKj1wgU5svwzmxqExTDYGihmVP+EJaqoixBYfO8OQCNnXwyT0nEB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jkomd7Qa; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-578ecc56235so574351e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759994378; x=1760599178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5c5+mJ/UHP/9LbfelQ205BO5Ehj3e8KPSEEqoMsr+r0=;
        b=jkomd7QanJfQL+taGy8affio/Zf0CCSAeUZfKoNGNVLi9zNehO29/+8U9CHcC0x/2J
         NOzgoEf72XHoZVZ+PIFKq8IlW6Cz744RqexnvLtkWdxZXDjPCW3HRhEwBtiUxU6dZJYL
         Sol9Qedoun0z+zp3eegSOGa2Ybx1BnM47rRVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759994378; x=1760599178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5c5+mJ/UHP/9LbfelQ205BO5Ehj3e8KPSEEqoMsr+r0=;
        b=O8IQMXMg44xbNHcOPxCQ/Rc6ZcDqUHr2wUl3WY5NtE4KshTTb3NIe84Q0aPYBJTnc1
         K5Zby0NDui1zKjWDCq7XZ+auxkNe+v7w3G7zibJVp7Dfhhk30qwCcZp6d6QINYBM3a2N
         HcMlbDc9CeACL1aq6fJw+DTWNxItILPpDdL/Y9TbqvgBYVNDaMVBZnMDY+Bg5x/hDshY
         Yt0sdJfo2JnAJnab6YJz/kKj39SH09ymu95N0RfzEhUVRrc+bhGry2dniUw4R+qHa+vv
         80JDwGKxvuIVqF07V8fgPyQN2CuO78GCBfPZ9mhgClT1W1nZSR0eHJ01Wy2gb1qQ6S4W
         Vrzw==
X-Forwarded-Encrypted: i=1; AJvYcCXN7jnwP5B6nc4zz/MBAsHukDla9reFLvm7NZi+XUq7xqjD0DLwBfKURB/2PTC7yz3+qgi/HZ7fMzzQ9tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOb7pBAqM8DREU5bF2zwnmr+nMHCVJVT9kzovaGUQ60eyglyXl
	faAzPe8kEXdwRkzfl92i2AiIBUcjNAGo1mN1rPpYs3OlRofy0H31WUquG9+Dm8t73x6eh9C37jz
	Dp2wkFz0TkudD9zMPZXkRjyoyanCQBxy9PcwEq3j9
X-Gm-Gg: ASbGncvuO0R/WO9Rver10XDf9weoscDtsgkM8LDj/mlvIshw2E3miZUcj+eapWGkTiV
	j5SgqEyuOzHcGHi1hPdqzuYWlcl4iBwTkkOyTpT35LnusmbDJxs85UXnHGSuOgp6aYxTSJyJfSO
	7fpO1TF7DqvS6j0/bov2aZHQbxKIcWblkNgp4n2u7RYIxNbQE2Rp4jH5WkJIYdpZa+BWhjnXXsj
	a2wQ1aA+2a5ZKJHKi2E+1DRb0VsqnwXhZ1kidzgJO2WsT9DXQw0xYP8YDesLA==
X-Google-Smtp-Source: AGHT+IHSaW0g4YpO769xUwsa4iNj202mqOPzRJ46LGO1j2gm27+8xePTXEdB7gctFN8wB6vE1Rr8nunFbpgl3JoXAJg=
X-Received: by 2002:a05:6512:a90:b0:55f:6759:a792 with SMTP id
 2adb3069b0e04-5906d8ed836mr1731541e87.34.1759994378341; Thu, 09 Oct 2025
 00:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008-mtk-pll-rpm-v2-0-170ed0698560@collabora.com> <20251008-mtk-pll-rpm-v2-2-170ed0698560@collabora.com>
In-Reply-To: <20251008-mtk-pll-rpm-v2-2-170ed0698560@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 9 Oct 2025 15:19:27 +0800
X-Gm-Features: AS18NWDNV8mYg3wiP9Z1G6zwejV94_0pr6WyN1XzhbiCP9cR62AhpDcipKqCy2M
Message-ID: <CAGXv+5GGSKVwvQihGVJNch6qxv88t03BcBhN9tgB=K-5VvN+Cg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] clk: mediatek: Refactor pll registration to pass device
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Yassine Oudjana <y.oudjana@protonmail.com>, Laura Nao <laura.nao@collabora.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Chia-I Wu <olvaffe@gmail.com>, kernel@collabora.com, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 12:06=E2=80=AFAM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> As it stands, mtk_clk_register_plls takes a struct device_node pointer
> as its first argument. This is a tragic happenstance, as it's trivial to
> get the device_node from a struct device, but the opposite not so much.
> The struct device is a much more useful thing to have passed down.
>
> Refactor mtk_clk_register_plls to take a struct device pointer instead
> of a struct device_node pointer, and fix up all users of this function.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---

Actually,

> diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pl=
l.h
> index d71c150ce83e4bb2fe78290c2d5570a90084246d..0e2b94b9cd4b56adceee3b04e=
9ab24c2526471da 100644
> --- a/drivers/clk/mediatek/clk-pll.h
> +++ b/drivers/clk/mediatek/clk-pll.h
> @@ -78,9 +78,9 @@ struct mtk_clk_pll {
>         const struct mtk_pll_data *data;
>  };

Please replace the |struct device_node| forward declaration at the top
of this file with one for |struct device|.

> -int mtk_clk_register_plls(struct device_node *node,
> -                         const struct mtk_pll_data *plls, int num_plls,
> -                         struct clk_hw_onecell_data *clk_data);
> +int mtk_clk_register_plls(struct device *dev, const struct mtk_pll_data =
*plls,
> +                         int num_plls, struct clk_hw_onecell_data *clk_d=
ata);
> +
>  void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_pl=
ls,
>                              struct clk_hw_onecell_data *clk_data);
>
>
> --
> 2.51.0
>

