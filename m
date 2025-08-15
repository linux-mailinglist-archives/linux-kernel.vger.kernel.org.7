Return-Path: <linux-kernel+bounces-770099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B8AB276B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B0E5C053C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8610D29D28A;
	Fri, 15 Aug 2025 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UTy90Jwe"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425281E8322
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755228353; cv=none; b=faE5y2OK2yvx+70WjjYOiruVz4fBnqQegYKOOhctve+kgLbZsNhWNF+dzHcf0D98zvqPBbOQBDsgSX6JnrOxXTvpVvNbdokfx/Ro1WS+RlARUkv6/W1wFC+z/EY6YbSJagJSjaLPsHEi4F3oSQUUDQPunZR0gP5eKvaoMl11Yig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755228353; c=relaxed/simple;
	bh=PJdg2qnj0enHiTuyutu3+3woV8+hTcgzDCVgV816pbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqLpMN70Oy84D/Dnme1ulI6UjXhXnWj+KUhRq6TxNV/BgFo09Vk/AJdF7Z+iv2VAkXDwy4kC90V60U0ONA5ckXrpThTO93nUEHStS3sjl3qAOLNzxCSh48uan5J6NFb1uYXiuPS9hsvviEq9HKymih15EFceowTTtv7elDTDyCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UTy90Jwe; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55ce508d4d6so1246203e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 20:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755228349; x=1755833149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJdg2qnj0enHiTuyutu3+3woV8+hTcgzDCVgV816pbw=;
        b=UTy90JweiHk+QihDlHIv3C9zyQDP2jNFuoORTcldb3m/DzIXDysredFO4TFamtPMXs
         g/DSVFGgouORpZzJBb/m/OyXK1gYWwOB9dImTzBJWx5CIfavyV7vW3yUUyPoBgRRcbnF
         IVwy9Nz4E4vr2IReImGxIECqKcIG31yKvw1IM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755228349; x=1755833149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJdg2qnj0enHiTuyutu3+3woV8+hTcgzDCVgV816pbw=;
        b=WfGuf1ijZIad03QwSSwOtU2BmWekk4IPsZOxQuShiPrwtY5ez+8RdyAtNkVbHN+a5h
         E2g2Y20N39Yq6HyCsHZwoZxbU+BFBg/qj0FhehsH77dkldo8zJSnqyT/UJkjWZAQTYHa
         WxGd+PbdwoOQ2L6mtA/4QDItleyJnYgjAM2rSJBSLHSuB7PoAn1sEKufG+RVHHD8Nzwz
         Ivtx+9hZbAfl/3UVWFpqEjaFQfSv657UeVjrf7PdjFXeqG0yYm/697uIKVNKkraktJQB
         OqDfHmHW/0luxRDz/48qRdi/rJLpD/jHBW9V0AsjRQG3EZstAaPQf27YYUOHhyc3oTkE
         QJ4A==
X-Forwarded-Encrypted: i=1; AJvYcCVIZdZXxipq/u7dW+pLk0G9M3EV0EWvbHK6zHIj8OKEPZjQ87DnTGrvpmmkTid97HNEgZiUkhzJb0hxGy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHabbwNizOhaOoAigWdIZUw7TdaH4bfnnnlOrQQPUruwTvGwtz
	oRGU/vHC0i9cST98PZ+IcbZFaaqsJCVy158SOGUlZs04iYUJFJr9uChPHE0eNIwoYGBLI/RoVFM
	OhyE9oxUe6G1Rxsbbq1VZhtL0RyacxIWfzEvKcvs5
X-Gm-Gg: ASbGncvivYrW30PIWTqMbnx6qn4IKYWzH/medm6bWHUwWpU2GF5669hz0GjKVjH/CFo
	K/373KUsMd8rMNh5LOJTeLAaDu0pnzX/jveeew0VHFyws59S4JIC9+qQ/fFX+dfk4Ia27Z5AJQB
	vdZsBgx9NcxsraKevzL3V8+mRPlhnjJd69Xi4Y9EEGJH6X3TCONkRDzc8ViZ+E5aTmYcoSQk+Hq
	0HdDQveumbfiGS1cEHhe1KofGXQ71a4GpkPTfriTqkCYpVE
X-Google-Smtp-Source: AGHT+IHML+FnX/LTF4Glnv3hTMjadeJlzca/Pry92PrR9MSNtfqTK7+3shW4DsnQEIw8uD+VwPOVAyVIaNye6SvIV90=
X-Received: by 2002:a05:6512:250d:b0:553:3a0a:1892 with SMTP id
 2adb3069b0e04-55ceea26136mr167317e87.15.1755228349428; Thu, 14 Aug 2025
 20:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805135447.149231-1-laura.nao@collabora.com> <20250805135447.149231-5-laura.nao@collabora.com>
In-Reply-To: <20250805135447.149231-5-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 15 Aug 2025 12:25:38 +0900
X-Gm-Features: Ac12FXyNFrgNnv9v_gZ4B-DIdoLeQQJfDCsM2y3l0UccKVx-_zcaQDAz8pYASzA
Message-ID: <CAGXv+5F4r+tN4vFVFcL5U=o2WrNZHUQN_VNTy=qLo4MKTrjmcQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/27] clk: mediatek: clk-mtk: Introduce mtk_clk_get_hwv_regmap()
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com, =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 10:55=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> On MT8196, some clock controllers use a separate regmap for hardware
> voting via set/clear/status registers. Add=E2=80=AFmtk_clk_get_hwv_regmap=
() to
> retrieve this optional regmap, avoiding duplicated lookup code in
> mtk_clk_register_muxes() and=E2=80=AFmtk_clk_register_gate().
>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

