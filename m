Return-Path: <linux-kernel+bounces-894336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E36C49C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1EE24E68EA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3E82FFDF5;
	Mon, 10 Nov 2025 23:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nV128Xrt"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8C22EC09F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817699; cv=none; b=ltpVBCbNcY3ivNsKoPfxfBojAWgmwSsE3UmPnn6l9bUMtwpBAJcw81/vfK/EnylYHA1aL94npn61C/xs7ioU1xLHrx40rCiN8bl+EXRljkX0hZkb1j2g5DAr2NRHCjfrECe8fH0GxRYk89ycWRbZ0x8QCUCJMXVH9egrjdv5Ico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817699; c=relaxed/simple;
	bh=yhp78e/c+JzJpivrf0ZSW9REEjpcgf8Be2/rchU61Pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sL2hWTxCYwHNIeJiMt+s/CEOKD9PYhqd6iMGBZYWrhKDIz0GQNirhoatv4nxqFyag0mJV/7YIOxN2d4enN0I97Pfe3cJCv/x3gieEsA0kmRxThLkHM1nvEZx9GjSslpY0X6fJCfP5Gm3rRbw15rIML1yycA6fWf1KE0TxZsIIHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nV128Xrt; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-378e8d10494so47615971fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762817696; x=1763422496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhp78e/c+JzJpivrf0ZSW9REEjpcgf8Be2/rchU61Pc=;
        b=nV128XrtiQu3m+ZCh/Z1AscSVrL5nIRwaM/0020FbtxSV3q/nBNsCxpmVy11DBqrEI
         DpGCOnAYhVDbCOuxXWbbvU++f4pDYpW+GLDENxtgYlefX+cIvZ9sW2RTeANrj5jsSLFP
         ZVb0JYXQuZSz8FrLvuyb255n/QvrLVU7FcQ1zKzag0MOchYE5kJf/Stm91OAfdsmGiRh
         3p7P8+2++pq7r9QJ04PUT24KRCJg/pTP51UR8FUD7VYh6KHZBdycgaXrt8zAOmO5Yur9
         S3ja2s9p1Wa+elbWjxo4/8ExY+ffSKeM7YCocHSr6Tub/GPuiKbKVZvPbQd8crShZhNv
         vgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762817696; x=1763422496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yhp78e/c+JzJpivrf0ZSW9REEjpcgf8Be2/rchU61Pc=;
        b=Xh/IRN+Zt814+H2P6wcQZ3oN543F0Riic0UXIVXF0ZrrVgM9STwY7F4SJAj7Ce4nms
         gxzZtgUJQhMnoCBRRt2CigJsvfTmc1MDpcDWBaEAeMz62DMr0Oav8sI/wIqNgGAvkS31
         FsyVGs9f8BFT8p5JAjrji43i4+6VCXge2yGXfLgzwBSay0t8guSLadTC++1s33gkfbem
         42psj6uejvZZSJuAYj6ltag8MNPVBIqKEB+RMcvXbUxn/99YcUR1dkaEkbwdVLSWeDGn
         ie9Qz5q3/1Y66fU5GgXsByGFmjYWMOfn4XvOv5CnWSuIKZzt1Ot999d1UMqMfWZeG0RV
         E9Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUbU3lJ2Yt9OZD6j4vn4K809PGs0nvRmVxAb9EpqGrQ5BTSqqZeSSARDuK2AgOZzuW1z+5TPbYWuBAsb3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAHMV/swIBF5H2DI06LPuQ5uH3X0FJ0c5Ww13aOn68z0LSzkvU
	jOA0z/yogTNE1ox73JLEkL7Z1R4pPWhzvKqN/+x7jLtdf418PPo5DboEwQVlUzRB6MA3IDxDVSy
	kZJyjoUGMAVeJIf8CyGXH/e5DEfMT/D/EnvQzlQCX4w==
X-Gm-Gg: ASbGncv3V7jMGRENZKyqNASuyWEHBQBz+/Mav2IJtMFRvb71HrX0tRgBfXJ2a4YAAVj
	laXwAp1cGOp6dpFeRZJzfabBSlIxB0/aOMU6fVy4evYdPyG4iZJCr2nyf8pHjokIwauJti1ui2O
	tOFWudX2KPx8E8MUPVs0eq18Uz7Brx/bTvWi2iBlX6LJCqNIyKhzKN8lTaar1TB3fz0IYIYtH5H
	sQZR2MqdVJQC04/cbruoZmhIyS99fYSR76tFcJgc+wlmtmiWEnM4QX3JZH5QVvyqGZenMU=
X-Google-Smtp-Source: AGHT+IG82Mi1A98FfG7yJz0vIc3+2ARkilByhg2O+8Fl+qHjePdN/o/dGr8Q9VvGwKtcezeBk+2GUuqJSQeCVKslfy0=
X-Received: by 2002:a05:6512:130b:b0:594:29c8:9ae5 with SMTP id
 2adb3069b0e04-5945f1e54demr2482118e87.53.1762817695621; Mon, 10 Nov 2025
 15:34:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105195007.199229-1-linux@fw-web.de> <20251105195007.199229-2-linux@fw-web.de>
In-Reply-To: <20251105195007.199229-2-linux@fw-web.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2025 00:34:44 +0100
X-Gm-Features: AWmQ_blvjYyNcyzASnRUO_VL5niJ7bbXr0Fy6afKuC--gzCCa6ihk2uw5R5x_5g
Message-ID: <CACRpkdZ6wJGRhobbTxvm2ZstHA=P4gaUsqvdm3_n1tKqWJ=50Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: pinctrl: mt7988: allow gpio-hogs
To: Frank Wunderlich <linux@fw-web.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Frank Wunderlich <frank-w@public-files.de>, Sean Wang <sean.wang@mediatek.com>, 
	Daniel Golle <daniel@makrotopia.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	AngeloGioacchino Del Regno <angelogiocchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 8:50=E2=80=AFPM Frank Wunderlich <linux@fw-web.de> w=
rote:

> From: Frank Wunderlich <frank-w@public-files.de>
>
> Allow gpio-hogs in pinctrl node for switching pcie on Bananapi R4 Pro.
>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogiocchino.delregno@collabo=
ra.com>

I already applied an earlier version but it seems identical.
Tags were picked up.

Yours,
Linus Walleij

