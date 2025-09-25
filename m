Return-Path: <linux-kernel+bounces-833241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2929DBA181A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4911C80FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F3C2773C0;
	Thu, 25 Sep 2025 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT4uvAxO"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6172E25A322
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835005; cv=none; b=iKqbt4jLJGjjXBtiUClw+yktFqq1ad1TKzHP8rOhRFGBli1P43uIaguAj7bizWh3teQ3GJJfdBPp3dXq7LAgWWoB35cSJ50Xw6lYw1rH+r/M/+dO4jOkBzSsBz91FWKzLLDs14WGREvaZnwEsFURXL+Jhsj+VGuM7rk1XQmG4IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835005; c=relaxed/simple;
	bh=SEKTPGDsWg0VrkaRrZsVcoh0RsDKUEs5dmSe955jVFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvdJ2Os1i2ewe4ZMVyhcJ/WAlVM/oMZshBX8bcgRLp5ZyEQn/e2A7Jpqf9ioC8nY/vE+FRGx0buNC58FtdBmG+7MFDZ3NDlHFjJBM1kdJZySizzlT4kVpbpTnSVh14Awo5LELH+jlJ2ToEfAwHhMDtJZTX+oDRMje5FmXsCWDCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FT4uvAxO; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57e03279bfeso1929855e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758835001; x=1759439801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xp46yIJcbHRJcWjVDLrWyTZCidnv7xkJHZZNxJgNolE=;
        b=FT4uvAxOA2Wsg95yoZ8tSCNKdZgfzW/7ACgswFDw7PMDvX9ngEIk2xA2BrCwseSUG9
         ho8yffTv9HOXqP1sxYRcvEiiBmdrYtNesLW5gZ8Pb05g7sBz8u59uHXwcJjOYJQxfdxr
         s8jrwN15qfxyfYAqG1RV1O5V6D5rsVZM1i6M+IulAFgoCPrQ/42QrffMQJ4iUE1SmIaL
         jnu85rzJw07e+4UXuP/4WPQLUkz5w8f8h2oO/wLM8lTOl1HIUzRPBBPMG2BfZowKAuPo
         PBQDb6BHy0NqbWn88I2X8q2Akkrcz+LwUy9V8NpbWsb+Zj/8Nqr5GZLjbpqxUv5ZFiGp
         E0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758835001; x=1759439801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xp46yIJcbHRJcWjVDLrWyTZCidnv7xkJHZZNxJgNolE=;
        b=S372l3ESYoA8Hqmzv1PfnsIuUGDg1Ro48CJSZ7BfI/hiXYbu00VjRPlqxdHc03V/On
         7UmAo510JQwutpNUVjC8pP129tYrOdiVIfez4ewH8PMLB48hfoeyeV8OnjUUoRIehCZ3
         qofJB6wyIVe9Qf8TYYTsorkXO2mbTcdGsEbE/otlcVhIxXDQkM0RiooQKOO9v3+2Pbg2
         RFnaz9Y8d0BmbtRs8ylFArKnYIReA1xizKDGxtCgc/KHpH3WURHBebHxgtB6rS1Jc8qr
         UYJk28MQK3D0/TERWg6pF/gFVOZX8CaPDBhU050SZIEZMVLICO5KpJ9fP77U2KjQYtBB
         /BkA==
X-Forwarded-Encrypted: i=1; AJvYcCWZguPzvVBqW7+/+qq0So+z4Qh6bDs3IuWYH+ttU7Qp+uDKCJtgObBr/LAnDzGd8BRWlGSluI1TKJ1aG2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQfAQJumYq8gxrxDBozn6+ThhOpe6TQfOO6z9PyNyVdLJ3Jq7y
	XKIMVno2QigsjX4+J3TAqGr7PQJagUu0B7dHUJ6/HIv/LrzBFRdE/3M9VBfhZubnIlnvHr2aqAV
	j3T+4CXD9CVXUJZtYqeG8Y8gw0ISYkos=
X-Gm-Gg: ASbGncucTKMITlMsILSnAvVsoMCllIpWvnCerMi19dBzkqgIzn4XnU2m8+OiV367+Lf
	0vluDfi4i+kJyFJSiXNXsB1mMTLl+cKA23Z10iuRWMK/yWE+co9a/lxhepN7OpHn0DvI7Dkd2gX
	YUqc5lqdtusil8TqZLTKaJDLxItJzPxExr/Hl04P48yT7IRn8gkdWrMbWXDgHxsB/K1CzD/Wi9p
	JSJk16D6jt32e+juaSZ/KX5yrUBooR3uvtLpe4=
X-Google-Smtp-Source: AGHT+IF/R4h8pdyoRhIuFrnmhFqzj4YND2cqkoN6aHQ0ZxIGheJEKMprkxFrhvzl4kOccS6Aw2A/43bT62WxKEVS/6w=
X-Received: by 2002:a05:6512:2345:b0:55f:5c1d:6cd8 with SMTP id
 2adb3069b0e04-58304fa84d1mr1231774e87.2.1758835001303; Thu, 25 Sep 2025
 14:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com> <20250925-imx6_dts_cleanup-v1-5-748380dd0d22@nxp.com>
In-Reply-To: <20250925-imx6_dts_cleanup-v1-5-748380dd0d22@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 25 Sep 2025 18:16:30 -0300
X-Gm-Features: AS18NWCZCROPwL8d5eWS_txyBP3E590ZB-alom2X8buKGCuzjFOmQJoNNEiM6KQ
Message-ID: <CAOMZO5BNBp-sgeMvisvXjvrQpkznGkCY-8h_vwp46p0izwYqEw@mail.gmail.com>
Subject: Re: [PATCH 05/11] ARM: dts: imx6: remove gpio suffix for regulator
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 6:14=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:

> -       reg_pcie_power_on_gpio: regulator-pcie-power-on-gpio {
> +       reg_pcie_power_on_gpio: regulator-pcie-power-on {

What about removing _gpio from the label as well for consistency?

