Return-Path: <linux-kernel+bounces-775551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD3DB2C085
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B12723D51
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A427232A3F8;
	Tue, 19 Aug 2025 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z5NNZKBS"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6332132A3FA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603011; cv=none; b=UM5u9xFhdp1eHgMytV85nQQJkCmDdCap9U+KmtxI8TtY9abtmgMgPVJgm0ibKidxkFhtT3S4hqGT2fKZ6y4p7Gplb0mCpIPHOgAxcWqTIzpV+V0qyuIftfaVlKLEOiIwxR2cQSZGOUP1MQxLTKM4QaK4wdQuS0AMU6jwhnEL+zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603011; c=relaxed/simple;
	bh=lMubVHIOYZHjuIy4jzyQtspupuCgz8Yv3TMEP2lh7GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9F61mHmkSFoDvEA4BPoRG/nnGv5pOr0RzvU/6gxcRpDNwfcv4mh2w732kw2aQEcxCzHC4OkkhjNs+V89NzdzkQ1xys4kqwFXqEI2vZV7u2Hqk+Imt6viFy+kB7M1a2Rc7V/5ww9SJiPpz6RTDg8MnOm29AbAoFxANoKD/i1QZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z5NNZKBS; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55ce52ab898so6208590e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755603007; x=1756207807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8Zt8RWp0BgkL/argy/j/Sx1Y0JjzJHgLTbPSG2Iyz4=;
        b=Z5NNZKBSSh4otR1Jge/1ROUAWFsBfwWVaD9qPmacpgOb5ZO//S+Uz9uQ4viMMAWFf9
         YGTi6/Hw96RChy+2MA8q+Oow9fBuLUu1lWJh6yqDNP1Qk6U3mtjoB/ia4IVYAg6VDGtI
         tBZd4WiOknuv7ZyQ627c/KXO5CywOgF2CP0lE0hMHi239W9i6+lrmVtiCCWpyFu9D3sv
         FCRSn17nHEQKkVnENzYFyzu/Yb5OiWms933FV8UD9pWcAPoNf7DmIJizSzyjtHIGcNS2
         HOrtPhfOLCh5OcBGUFswsx0NembOxLaTOFt7FCyobj2JwkJOZj4zLOgVooysdXPcDBxe
         aK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755603007; x=1756207807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8Zt8RWp0BgkL/argy/j/Sx1Y0JjzJHgLTbPSG2Iyz4=;
        b=tVOCTaxl0INmpwk9oPWMhqFytKJ99zWHar6t/Z8G/nAKKPkxPDP/H7IT9AiC4btrQS
         ShknlEB1Mtsx1l3m0dqIpCZIlSOyoh9E6AycjoUmKnG4GpWAdHO98Vq7p/HszfzDlpO9
         L0O1uGZcBX6hjM/amdNGQjTvVcUxYsG3OiyfNcPGQ/pRh+uIhhCyKcfNDlD/h+EhKwUE
         YKXzUuFab/qUxW8rgauLn+6A3MXxtSG7ebeqQ4mmcyCeVv5Qbl0sOHhFnRS7U3KAblp9
         bk/bPGwkswucgrGsbRT/417QBmPCmcwm6x9wTnaQTHLc2M+wB1AILS8Vso6TB4jcTOOI
         Gqeg==
X-Forwarded-Encrypted: i=1; AJvYcCUVFE1aM4b8hhAaoOhry1FyTxzG67F/LDEJH3y/uDBQ2fbLPav0lsw5+x/PnslY2eXNGqKykTj/3ctKwds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1lYdLgOUwOfnnQpEvL8kt/SWUaQRkf/j0jBQ2c9Tscg9xMOC1
	WbJTX76/Clac+5JMbeN4pMIs+DLiEw5DEQeB5pDWq3eOzFRknUJ+5qpshHzSt4UPbgRU62MuIzH
	sOnbH4XIKqVwHRbz8oZKzWV4t5lOiDaIVw0U6K82lgQ==
X-Gm-Gg: ASbGncuN9UKk7Espc+EeLcvZPFte8wIcsRSH+UjiWdDMvSUhQcWwJocMemBg2eL/1IB
	e6hYDnDzQTN0R4SsGly3dQivcmcJronDPYhlwO8Ab+rghRr/YPJT3YrmrP3hCVUpxI25JAy+cx3
	8YNpJ5Z+/FKNvHmRJ2OzIijlZbYf+RRBuGhOuHzdgNvik7hRU75MX4dhqxHqEcygpRjiQJIIoXk
	59fVGa19Ls/bmm9TQ==
X-Google-Smtp-Source: AGHT+IGIQkeqWSXk6UW50B0lvRJ9yh6Ui0meCyjjUOq/i3AdK3dvZnjrLz811wrbO084+jFl2Soan4QZclj+LnmGujI=
X-Received: by 2002:a05:6512:318d:b0:55b:9460:2a30 with SMTP id
 2adb3069b0e04-55e007959edmr704413e87.11.1755603007489; Tue, 19 Aug 2025
 04:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-tegra186-pinctrl-v3-0-115714eeecb1@gmail.com>
In-Reply-To: <20250812-tegra186-pinctrl-v3-0-115714eeecb1@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 13:29:55 +0200
X-Gm-Features: Ac12FXyJeMR015VuulCaDAkb5ecQnwsNmUlrUKxO75YDJ_lmXPNInWa--QpmnnU
Message-ID: <CACRpkdb=U=h5OguMuy9G6avCCN6Aem=2_60C+_uBsrY+UvD5ng@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] pinctrl: tegra: Add Tegra186 pinmux driver
To: webgeek1234@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 11:24=E2=80=AFPM Aaron Kling via B4 Relay
<devnull+webgeek1234.gmail.com@kernel.org> wrote:

> This series adds support for Tegra186 pin control, based on a downstream
> driver, updated to match the existing Tegra194 driver.
>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
(...)
> Aaron Kling (3):
>       dt-bindings: pinctrl: Document Tegra186 pin controllers
>       pinctrl: tegra: Add Tegra186 pinmux driver

These two applied to the pin control git tree.

>       arm64: tegra: Add Tegra186 pin controllers

Please funnel this one through the Tegra SoC tree!
(I don't know who managed that, probably Thierry.)

Yours,
Linus Walleij

