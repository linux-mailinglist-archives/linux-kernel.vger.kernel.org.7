Return-Path: <linux-kernel+bounces-775525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2816B2C02E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F6A163903
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3977F27A121;
	Tue, 19 Aug 2025 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A+W+8ykB"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0761927876E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602486; cv=none; b=ubFox9MwGDmm70ovB//MWBDmWSZlitv4MgJtkgpVo2J1feZX4fgnrEj8F7GNQhdAMM6Gv2Hv8pPPQzDCkBb2c9dTGC5ej4Q5LEsvEKsY6Yek/vp5gVDQjkFfo6Q0FTw9sjmr//fNk1LrPS5d7jLoCuCHa+8DA0ke3KhBNSfl/FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602486; c=relaxed/simple;
	bh=ykjYNDzNtgnJKupD3/EWV+NrnYl1HExXSP5IMAiM4Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUBFENF+BSRe76yOaCguOllOjetNOLUxEIWiulXinpp2Q3cwPV/v5pCvGkhfCoD3rsVHml0CdrnrDUJ2Ll8KNSH/WMdY8+5MPUN7ef5pTpI9S4b4OBFmsUFm+MegLqMvOs9sibgsn2OcxOQFUrLFoB61S7s3cwDyAOYJX4KazHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A+W+8ykB; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55ce52b01caso5932196e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755602483; x=1756207283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykjYNDzNtgnJKupD3/EWV+NrnYl1HExXSP5IMAiM4Cc=;
        b=A+W+8ykB0FB/jDRAE5MfpjH0f6vK/hz0UsLSn32HeM307l8kLO/s8DrmBgIlx2kdnp
         pIgrDM+z19oimRitPTCn79x2aJp7mJUNnXy+xz+fjo4fo4kt3RJHn7rpKw+2Z4rCNZFl
         NJcIaS+8hTOB+alRPsJBbKX3ZDEHJ/hiYyTYDAO3z9EFhFjQSuZvVx5bQ/tmbQ/9FQcf
         Y2wlF3++iw2J+mLbqEnfuy1nNE/chVE4B9MY46tKSsD1NV0nkexEdaRiIUvdGZ5yqh/k
         48njEwzStB9D8NIf4q4Pu3EDYqZHloyQ2N0JCiea8cdIBHV+Qi3Oigk5b7zogICSqPPp
         gpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755602483; x=1756207283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykjYNDzNtgnJKupD3/EWV+NrnYl1HExXSP5IMAiM4Cc=;
        b=fMdJYLX42LhfV7lx9q30vcVbfv8hGSK3+mQU+fbfuHZiJz0VXpQJrfUxJ866U3XE9V
         x2JNxPq49g6XsDWxELvZiiGSue3z1jMuFCeNSiq8BVIhJu9QyE39jpkXSrLXbhtrSdqn
         K7Sgk3EXWIkFjLYtNMmZpL7RGm3l7t+TVjXaMr+8disYnhSRM9K7Q13Zhg0Bs9Pb0O2l
         Lf5nsGNyyizrefEuC8neIT6pwA0uz+DhBBZIyBI1pk3DCvyQEx2p7u92/CX4bV80yfkh
         EChS+an3UJl9kRKzUpSMr2Yf0MYHRGyb8oDe+sx7PRWdLibJX9U9tLyVbTAD28qaqG8S
         9Osg==
X-Forwarded-Encrypted: i=1; AJvYcCUC3kgR8bXnQVXO1CjxPd81wm/j7p92wfuyTuuwr5vuZYFPhb7cjrMFc+LMpn5OoxXvnO5cm0pPPNQ8Ato=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw64Be97ESe3iEaKshx677/sCvLp79iFw4M0BUEl1TlA8EgKpua
	yHyLVrfx3mHFkjNE/Nn6KN4GrF4VuelGgkMfE73umyD4gP0rXdrzdu5NxpQHBr7pB2mfFCPzYtQ
	Qwu+cxswzeLy6DRdLyoBVc9dAsButZ20HR3ADSAv/EQ==
X-Gm-Gg: ASbGncuf4VGDutmV5Ao20X+Z8em8PtD50qGMGFvVe/VVyDvVvVdbM/Top0T3UXrAbaF
	DJndDx72nJ4z1ZUTC1j13MH03q1m/MS1r1+5xFM+Js19p1VKCoQvw3MwN/pnEy9ukadDGNZ6AzR
	roPH2o/DBcKHIDBqwuRsrFXE89fm2iD8bCJpR8H2MHFdZ4j3RBViiywHwD+j8RHvBbIg90cRhiZ
	inJgLDgo5xOi7Dp21Bl3MM=
X-Google-Smtp-Source: AGHT+IExSkHu5Fq2TPJj7mig+2UITCL5Nuo8n3oMZX7n14jJ1Ur8U/ZDpryXYMDT0yEbKr7vKt4NOQD/r2E+HVIENcA=
X-Received: by 2002:a05:6512:33cf:b0:55c:c9d5:d347 with SMTP id
 2adb3069b0e04-55e0083157fmr656989e87.35.1755602482535; Tue, 19 Aug 2025
 04:21:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812203337.731648-1-robh@kernel.org>
In-Reply-To: <20250812203337.731648-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 13:21:11 +0200
X-Gm-Features: Ac12FXy0UOxQIJg9zQs_ZT_Mh0mUXIMqwTPHMZ2w4ECrF-44gBtOF9LLtv4UU10
Message-ID: <CACRpkdZGD6p_QDRHXQSHWPk0E4N37RQ6HQXzBAGHo393ee08-A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: Convert brcm,bcm2835-gpio to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:33=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org=
> wrote:

> Convert the Broadcom BCM2835 GPIO (and pinmux) controller binding to DT
> schema format.
>
> The structure of the child nodes wasn't well defined. The schema is
> based on the .dts users. The legacy binding is a single level of child
> nodes while the standard binding is 2 levels of child nodes.
>
> The "all banks" interrupt is treated as optional following actual users.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

