Return-Path: <linux-kernel+bounces-855530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA94BE18CB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D173480688
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E2023A9B0;
	Thu, 16 Oct 2025 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lZrCmrZv"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7954623958C
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760593486; cv=none; b=hLC5LM39Sim5mlocBJCXfMMZ4RF6NefP2yvVZ4dBIT6eGHSO2gjjM7pL+/ZLcBdDklCNWDLOaNZU4wqTJUAX+HYZJZ5HmLJKMO+s6qLeGZNopRUtVVFAr+hFmGAeS4d1ffRFEKRT6arRzvQYxbs8BeM0V6dqhUQ/NVr75wHhbDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760593486; c=relaxed/simple;
	bh=p9TBkTZ5r+V3Vqzg3Erf9DxM3Aqb0ebyWyF6uv/8DBk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NWN0q1QP/fUjrPXgtcF/A2WZQCqRxyajCaAJFXcCB1eiQmExVDiodAUrk4ye3xzekUTVQ8W7y5n4jznz9ysI0yeF1kY42mrQ2GppQZqF7El1rH9uJTrhct9h8RY5ZppIqpujE7suqHPyo2TVcAFf7Yd5xnwslXxeG++t8mC+GcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lZrCmrZv; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-639102bba31so523685a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 22:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760593482; x=1761198282; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p9TBkTZ5r+V3Vqzg3Erf9DxM3Aqb0ebyWyF6uv/8DBk=;
        b=lZrCmrZvNfSUQPPoKBfDSDSm6QKmirBXZlL0AmcrljEtiLekyKw7MB0fhCclDrkobV
         /HgV4JM4VFTKiDq2mC2AqT6MiRxk1C8npSBVUE3DHxpRX/5g5quqPPxxWSUMU2KmL/Lm
         dPO0m0R4s946uOZog5gTUCeKS2KdIYh+JzJhhdS5lXd1vnKM0fVanRlDGBWMrKoXSjd2
         kX4c829jhQX0IXoGNWD4sugQS5BtJbgDhJYXVC2/NYA52vTUo+lN3HShwHXi75fj3Fu3
         ZFMlaNKd3uquDsKX5VHU2jGrZyX4h1b2Kg+cz3snwdLz+0qkzZIEQtjzJjcShTZWG+QB
         K6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760593482; x=1761198282;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p9TBkTZ5r+V3Vqzg3Erf9DxM3Aqb0ebyWyF6uv/8DBk=;
        b=rDdTwjgsQiL0MWcguL8KI/udKjnyub5zEJgm/cxySssjZUdDIrZEBbdEPAVPVDFOcW
         1J80Cj/QbhUywoEJJCQWJ6K5z6gOdeSLM73oo3BwWIEm2BPHxCMA+esXoQH3XsXMx+tc
         4XuMUqAYTmQkKo/jjgV/n/oeQHoZ7KlTnhuappr+1HNdZiVGWmcZaVLdgqbj/p1sWco2
         GwU26TgQKVQVBPkO0unO90jgLH5SA0CaywaNNEeTvE+VQYnxjLJTeVaKRUwMgmTO+00D
         mx2fQ9IObZM07TZet7Lsx3zMFZzE9qXa+62PgpnDai2Eg1kcrnsYahzr4DrcNce5tBH0
         pAkA==
X-Forwarded-Encrypted: i=1; AJvYcCWDYw1KkltqWlPyG32fJmjkIC62nGWETTBJ5lZvkO6XUPxNK3zXqXkhRrJwUMw/ihTLiHwFJG0c38xeZBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlZPK+d88oHYvTL2opNdJ2QBSX42j9eIFnzysDu8+OFnnzzPb3
	4KCFGf3Yg23zbeF6rqgYcfm3Nz7ohdTjg8EftBzVXjLRTnSgkcsVtTcYy/jlWjawiOY=
X-Gm-Gg: ASbGncvZtS0UsokI9VlsfaH8KF3nWnMZAQtXLkfCRnfR4Y3wFi/k0LAM5IjOHTIPlWC
	3ZC/yXellzfpwVJyP7urbykGe0GhtCdp1dqFm4MAsfIREmf6jgxAwNjbFMbplxZmcSclOgoED2j
	xlRFl8ayzX5T2wCGQh1EujOsnZaRdaf8bEHencO7Va+RcbScdoGmfQTGH373vu3pt3aT4DN/xzd
	HjOUuJoUTQgopmnsL+iM68cRCVxo2o8UPOF+wuOGBE9zBWNBETBdYyKB1YHbu/XC+Gx7hxrLUm3
	Xg6SO7jHnbEfVTreL84uDJ7g1wstwM9zIUCGOzsbqEaPQM0y9jXtSk7lmmFsZ59ljUiItuXBEIT
	xxMRBX5LwAgqliMSdxkxyWkm3TA3licrXGPRI8qVY4DtGpv/8/rNhUoWY2HwjbNSFq/zqopSrWN
	sc+EvzKQTbxvBOknfmqQ==
X-Google-Smtp-Source: AGHT+IGTAzXneDlTJJthrwyFh1A2mpMs+brYmC8fjkaobeSG7qIGMGjBpTwlt/OHwTYQt+NY+Zh2QA==
X-Received: by 2002:a05:6402:d0e:b0:634:5381:530b with SMTP id 4fb4d7f45d1cf-639d5b8956cmr28820056a12.13.1760593481782;
        Wed, 15 Oct 2025 22:44:41 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c133412sm15055961a12.32.2025.10.15.22.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 22:44:41 -0700 (PDT)
Message-ID: <a8dc26e96c6ea0bbb2b9f02ddf3360cf0fad8331.camel@linaro.org>
Subject: Re: [PATCH 1/9] dt-bindings: soc: samsung: exynos-sysreg: add gs101
 hsi0 and misc compatibles
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar	 <alim.akhtar@samsung.com>, Tudor
 Ambarus <tudor.ambarus@linaro.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Sam Protsenko	
 <semen.protsenko@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>, Krzysztof Kozlowski	
 <krzk@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Krzysztof
 Kozlowski	 <krzysztof.kozlowski@linaro.org>, kernel-team@android.com
Date: Thu, 16 Oct 2025 06:44:39 +0100
In-Reply-To: <20251013-automatic-clocks-v1-1-72851ee00300@linaro.org>
References: <20251013-automatic-clocks-v1-0-72851ee00300@linaro.org>
	 <20251013-automatic-clocks-v1-1-72851ee00300@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-13 at 21:51 +0100, Peter Griffin wrote:
> Add dedicated compatibles for gs101 hsi0 and misc sysreg controllers to t=
he
> documentation.
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
> =C2=A0.../devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++++
> =C2=A01 file changed, 4 insertions(+)

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

