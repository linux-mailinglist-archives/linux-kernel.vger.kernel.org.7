Return-Path: <linux-kernel+bounces-894239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB99C4993B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBCAD4F57D1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484D533B6C7;
	Mon, 10 Nov 2025 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGE+TXPc"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B532ED16D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813507; cv=none; b=uUj0VlGV3QHPziBpYgCRf4CJfEGRAjzCIizFzp+laKNcL2+Cw/ARviaW5aSvWMGMvPUVhTh1ruFUqtPNPBmyfMeO/zC/ootDsrV1kJxNTghElVQT+Xt0Sad1xyLBSTI+8BaUszizcUdxAj66ONRDaMJ2nJI0jBURIlPMsUBaoBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813507; c=relaxed/simple;
	bh=lbYOlnC3WJYLBwDfb+oYRZV/rKekA5V2jSftip3URFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUbuuhCTkSnBvK2Ur/miLbxlnPpb+8FDwAdLKIzq++43kZFdsgqXt0vvze1/5mBVKGJywf796NFA1XNuLjlk1HyFFUiKATdyF99AWEvDGqus5DFM0kRIeBx/wOg6x+GN3GFOdFLRV7OCuCOdGFkvDQb6Hf/5+2qhLr7kOExRtJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NGE+TXPc; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-594249d3732so243163e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762813504; x=1763418304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkykz3S1CyycQbNzf0lzIqKhpFUnZB571m9tUf64HTs=;
        b=NGE+TXPct30zyW7TAFUMXCRFW+JBU/5Nyd1usdotgrc/8g+kkFwv2wiOsh2VzadjtC
         IDDhl69dnhFVPXphMxO6/Tat1Rj4WeqmvZeGSI/uf7G+hC1+rvp2RxzupvSVwLpnUXvr
         xvqKv0ESYra6Unt5AzLLFRP7NHM/jJ49ko7VJSvn7x0+fONODNhOuxz8W57JpVLfxCpA
         CdPukyJyGqqDzyjowjqJG5d8Sk5wIN7RmVi/6nxBrHkbHd1wnWMEQG8EVrEZaJFAvW5U
         MrC2T4tVAoqU8DPGJqtaJ3O8NWIIJ0p8E91j6Unn8vLNRBWtrVQ5GZOfk6kEbDvKAUx/
         nQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762813504; x=1763418304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tkykz3S1CyycQbNzf0lzIqKhpFUnZB571m9tUf64HTs=;
        b=R3/32MkiRF4wPeQQk7E0IKoGSOuJ+DVeThxSKQ+/2ME5XwNaUUziQrd91JrRTxC8aM
         8qOmxTHq86kdC/G4bgTgZSOVgcY4H9L86hJ5Ur1Q5U4JDD/a84WTdp3fWVYKwtOlz5lL
         q5DWPfh9/Y8RsdZoi9qiR+F/Flu9OonXmfh/R/2syrNQYfuYMmJbhw1xCBFK3gYJMuqo
         kVuIHdQ1jSauwEbtM6lM54FfVzDJXZ2HLmIu76Zq38HRXwkawTpsg/R3TSAikWL+Ex28
         EQdw5hhpQIOW+QXT0ozgwa8Nxb+Y3g6nfnN/7oWBnKrAXOptkH5KCbk2vt4wxwvJeaBJ
         3mOw==
X-Forwarded-Encrypted: i=1; AJvYcCXkMcUhe9UUjciVYVtVGiwy2afn4/ZTU//AGYe4marwRvZxLje4yPaBb5WmQmwISd7Q+7grvNd4bydwnQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd4ihQLsBksn0X0TeJVTb08eCgd47xE5lGZWcIe42pBjojcI74
	89tGDUlkkIOeRDdDqzv8YCvad2BorYd4qA9lYVe5ccRvKJPKm6ZsGL2ZN/C7X2bSTiY3eyHpzZ0
	RIAN+Bw2XuY5pprD+yER4eq0bJ4Nhy86MA/tTdKbYlZ1rNZiDOc3B
X-Gm-Gg: ASbGncs2Oqd0G3t89WH3T+iMLjDvJYNJjEp92c0ypRRJYPa/kpSxk6qSWz5hemBUAGl
	ZfAJbfnq3OA54wZKOUSFvX2ydqe+IL5G0GzbAIi+v+1Pe/b/OTBoJyVpvb6QEifiVJEIpMlUsT0
	+zV/PZ7E5ke06FEfrdP4ywEW6NHgjGnq2g4ADSZqcAYRZp/BBxspoP5+KFDHCMGgidjVsxfio5V
	4N1zLeXjG9vnfj7yuQlIwoF02GAXkPOEkT/F8CNHdb9MjaOlRo9ZnefpAQa
X-Google-Smtp-Source: AGHT+IH/bobBHFWFdtH9zZZK7pDa53PdeYG6iIiYCN8HDJy4OkCpiUpXjuiD4ZHFmsvNrZImVkrpEn3cIhnyZOsajDU=
X-Received: by 2002:a05:6512:3408:b0:594:2c42:abd4 with SMTP id
 2adb3069b0e04-594745a4d40mr256456e87.5.1762813504005; Mon, 10 Nov 2025
 14:25:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104021223.2375116-1-ye.zhang@rock-chips.com>
In-Reply-To: <20251104021223.2375116-1-ye.zhang@rock-chips.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 10 Nov 2025 23:24:52 +0100
X-Gm-Features: AWmQ_bnqL4tp4-XtSfjpF2SJDcbcu-l1tzSoL6TKzmSJf79bXaH7H2zLWLM2NeI
Message-ID: <CACRpkdaR=_K-hewNne2fPN=RKu7iyOe0gLYhMEBfQVvemJJuoQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] pinctrl: rockchip: Add RK3506 pinctrl support
To: Ye Zhang <ye.zhang@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tao.huang@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:12=E2=80=AFAM Ye Zhang <ye.zhang@rock-chips.com> w=
rote:

> This series adds pinctrl support for the Rockchip RK3506 SoC.
>
> The series includes:
> - RK3506 pinctrl driver implementation
> - RMIO (Rockchip Matrix I/O) support for RK3506
>
> Ye Zhang (3):
>   dt-bindings: pinctrl: Add rk3506 pinctrl support
>   pinctrl: rockchip: Add rk3506 pinctrl support

Since we have consensus on these two patches I applied them!

>   pinctrl: rockchip: add rk3506 rmio support

Now you only need to discuss this with Heiko and iterate it.

Yours,
Linus Walleij

