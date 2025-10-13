Return-Path: <linux-kernel+bounces-850491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDFCBD2F80
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B68044F146F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7284E2737E6;
	Mon, 13 Oct 2025 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WuHyV48c"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9CB261581
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358603; cv=none; b=gHOh8OQEBEH8k63KYHrY4XYpESNPIL7Bodfop/SDO2/SLnAV3ZTnG+wT8Hq622t9w4lA1mTHQjaHS2ULmCVYiQ5X4OskOG9UHrE/lG5cizacZxKC12CgGBL5WOU9UGsOHuN5owZ53HkFRUUlVaDoSNg4TUP2OPICdhA9SawH0tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358603; c=relaxed/simple;
	bh=1MOmeyqog4OM7BYJL2ULZOdWEH0/3arI6omm4yBQqNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWk+4oc7BBih+vfW/skYgi/tHLeMA0M5UqDR1dwCR6hceMlg2OOXNVxNRSAaZiGia7a9QS9Xfp5F4OhznD5ZwX0iMWMXDjzFiTrFUS3XosZqEhB22C8xIpgLW9UY/aFZI9gv0Hcq69n+S6uvkC28BZNUB+LbPD+Sgbtp+JTOOyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WuHyV48c; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-36295d53a10so33012201fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760358600; x=1760963400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MOmeyqog4OM7BYJL2ULZOdWEH0/3arI6omm4yBQqNE=;
        b=WuHyV48cutS3BFuIeIUDZMPcLa6tMnyBbtcxK3rif3mfMAQ8/KPy23tjOczWdZwsOA
         pM7W7HYN7Is3DwRnSLIdWGYpbyL6yYwOoSTyHH4ty5cMcpkR4O3R1fFSfhY6ProapXL0
         c0YnntQczYeTnH6jS3oG4RUimeMHmcLW2HbYOmM9HXqNY5fSv+DmH12+vmzJ62E+/4uJ
         QPPGCDpNAZ2BHfBnyyqq4XppsF6skzr0cUoZzM2Nh0iQGnu0TVH5rhnO3S9kT9E+gKw/
         NExo/fyCqnnOezgrh+c0EREEKaZtYThXFgCuHGwnx6DciKiin7I7JfuFwJpXjUOGxFuU
         ZKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760358600; x=1760963400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MOmeyqog4OM7BYJL2ULZOdWEH0/3arI6omm4yBQqNE=;
        b=nhy8DH7T4MyOn65G1y0tJ0ZweRrTlJphrSPGB3Tq6kEAssytdxoD7vuu+B+VnIlv1S
         0El7NzA8RjpAleM6zP1mfNSrZHyCHms5maGkQUnk0IK8bbWje2J6Q/shI+6v7GEaRzSW
         yHrWU576oqq3RP5na0jukfq/4CBdJyS2gAtpu3yyS9x2peGXDlQ29keHkN6P5yNxoFIa
         H1y/HutapSuzoNbnPQ9L/OWjtM/XpZMDnINwjCGHB17lQb3WXZHO1a42c3FBbp3Guxkp
         PkP8ITT+xYTO2r14jA3DShPlqindT2eoU9KS7iIcPT5+b9S9mzrNVI3lQ6fmKfgULGrb
         cIkA==
X-Forwarded-Encrypted: i=1; AJvYcCXUu8YGze1P7JwpYvBdJCAzJsbReyarMANSP5uz4qLUsJHFoXpJ9g433t0DZ5afoK4CywqmWRS5zq5qCfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjRP5dfT0nKfip6Yx8omaVliGIGRSOm0DDhKqFP4NwJ5Qr3HX5
	7wEVop/AL8vIlbegQ1aVQA0MxDqJqqyk3B5UO2hUGvUfwyfYnHjxcA9KA80FycWtX3m5fuhp8LY
	JoE7yZUxCquTCVJxUHX04Wcr2uEwY/ZvIB0Upo//+bw==
X-Gm-Gg: ASbGncsTgdpHNMNCYbPxmmsTs4ss2tMGI0mQ5EVGZgV4OeTIYgDAiidFhqL/OBF5xJa
	49+ESg0HZWRu9jeNGkrkrhQPAFMKeSqamcviMBLBsVCw5H78p/dO7eUW7yay2EsrbXVi35hJ4lo
	exMgjC5BtBh4tVjGN9OeMadF0gcykFfwiLHTvPD/L5dOVPCho2GiAMHkEl6qzR91YEyA23OEOr8
	ALUl3wAGAgi8ZPfoeFYsYUcYm+IbKYsfZf3dPv4
X-Google-Smtp-Source: AGHT+IHDziq/3pEjSE34Vb9xc10xnYDJuQK7aFT0KnwS0eJY8GRc+vGU1CYOsUeevL8U5VlYG6e//6jV5rAnbmRrIB8=
X-Received: by 2002:a2e:bd0d:0:b0:336:5d33:c394 with SMTP id
 38308e7fff4ca-37609ea5185mr56779601fa.33.1760358599989; Mon, 13 Oct 2025
 05:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-rb1_hdmi_audio-v2-0-821b6a705e4c@linaro.org> <20251007-rb1_hdmi_audio-v2-1-821b6a705e4c@linaro.org>
In-Reply-To: <20251007-rb1_hdmi_audio-v2-1-821b6a705e4c@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 14:29:48 +0200
X-Gm-Features: AS18NWAyQHOstCpKlOfzZTMdQhypcq3gyuY9Qq5Lmp_pCYAjRMed25BVKMqEClM
Message-ID: <CACRpkdapDastXAED4YhKAXQ9byvMH6SHqt3zHHniGRJzuXhDRQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: pinctrl: qcom,sm6115-lpass-lpi: add
 QCM2290 compatible
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 4:03=E2=80=AFAM Alexey Klimov <alexey.klimov@linaro.=
org> wrote:

> Add a compatible for the LPASS LPI pin controller on QCM2290. It seems
> to be compatible with sm6115 LPASS pinctrl.
>
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Cc: Srinivas Kandagatla <srini@kernel.org>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>

This patch 1/4 applied to the pinctrl tree,
please funnel the rest through the SoC tree.

Yours,
Linus Walleij

