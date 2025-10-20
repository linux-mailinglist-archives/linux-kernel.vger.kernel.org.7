Return-Path: <linux-kernel+bounces-861762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E478BF3A00
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512FA3B228B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43492E6114;
	Mon, 20 Oct 2025 20:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qRHOXQiz"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC652E9EC9
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993925; cv=none; b=cYuQtCX80mIPqjSS70+BYzSaDQvapvyCTFPTxfHPwai6P5avstTfrb9UxkgNhZzzFJwEIZCDFOzt0QM2IaoWCOXjfbpW/MkwG7KgSMaqxoVzXlALAZGStOiQOHdSFSD/a9NtOe7EsJM4DGU8VuJArWn3FXH+a2cKBIsKVpuIbi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993925; c=relaxed/simple;
	bh=l3lZxJ8LZRt7zokp4kQuaYa7ZIlO7H8mMjodLLMpmAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9Bbl3vV2UvRHGfII2fzwptDlI+5UWoE9WhkRcOFgxdoPd03+1t6LBw0MT0wK2DYYFtZ9TPchhMlcVYg3EIvbzOYBM4AOn/jye7BBwLW97PBn6KOlM76wBctfJYrptG4r34eesoY4OeRHwMi/lB8D/5FcpsfhTf/Huamxf9x7lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qRHOXQiz; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-36527ac0750so50126021fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760993921; x=1761598721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3lZxJ8LZRt7zokp4kQuaYa7ZIlO7H8mMjodLLMpmAE=;
        b=qRHOXQiz/dgOBV+n/rotG0kapKJfJH8faNvql73M51+mB15OOIgiWa2VjTq9PjuXGf
         ClAcn6bvkEchpBAO5o7yT23QfyvaSkCQ9nodm8sWChS/nsTFsN6Yyg2hFhU6PuozOUPz
         ptD2ybjuZS7jz8+x2e7K35c4cNPHC1Ij/Nptjhvo1vtquOHFwHr9bdYtkcAkcd8DBo3/
         R4QKT84VwLiZiZOChBkcg8uBb3qYZr56eSadbFPm+kgfegTqHo9CJos7oX/zFdt95cS1
         b2K4HIggWP3eFnYogZNRtqt94uXDtSAKeP6eHoYLskl3kWHL08j0gz+qLwAFUOwp5k3Y
         R+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760993921; x=1761598721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3lZxJ8LZRt7zokp4kQuaYa7ZIlO7H8mMjodLLMpmAE=;
        b=kEgw6AfYiEmaSmgyxFWroICOx+fIAoY6gqdrz+/F9jRTEUjC1/BIDZ0v1vrVEuEbVM
         3UHsVOOimm/S2EB3raXEoYS5uIP8wsKpTm/KXQUq+HGgGN/Yca/hIf/BvdijRWYFSn7b
         FBd9txf7Bf03/0qhHymhPEUjd6JXRbxT1LtL2gtdeKGs38fwRPZnE2vfFqVMKDz+ubBb
         oIIolvKFZfkql9Ryz9cnx+FyQwIDLHmcSQjN6cEsUTVV2Lb5XrVUe8jQFEZLso9NLQBA
         rLuz29B1YK2QWi8Tx4W5x2jdPJ9TDTmMctECk6zOJsA08o9svPcNYSiUaHb2Rd5OVwhA
         jZ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWL0n96uyeUfUNcbqQV+AmeexGBZtiujn6E/gy7ks5oXO8s/zc7yhy+1j14vicpqLkjvK9/cdNYME/foBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5StCoS+H1BD5SxlQcOcv1OZfpYnkh0htI+wOYTCecUWxWXjsP
	mvlAuDVg835kkeifmss46pXgEJmRFXQzsd1JLVkO+Ywr59l0OVRDXJfKYyTw/GzxTGmGy+bAGud
	QIXyTlHdW90tYsHOCZF4YpKBNU8Cqw8vTPgkRw4tNJA==
X-Gm-Gg: ASbGncvhhnqgIp8ht/vdJq3+UqAdtU9Y/crTM7NaVkQ+SvioDPLawuC0tmM689gLLLe
	2X/WsQV59KUMaqAW28WLO+J8R8pmOsojIb/dHIxJI7rb9tDTjdsQYKQ9CZq9nn1OKjw8II1ni97
	RO9zaA1x6QdpKvz4Z5/KlFz3doL1f8ul/uIKTcfokanwDFqFUnmVEq9OWgsG/wcNwFK3AlEqGVS
	Ewhwj5ZisvOq6LE44QPboWMuUVSbWJHpDCqk3ZDXEVb3ZrTpMm0ayi9Sia1
X-Google-Smtp-Source: AGHT+IESlrrK+D5XHA5lrAtuF3QlfvYzPMpNJcOzLYtG5TeUOwa/oJlyZIePwgIJZ8sArPfbw2eN7GwsiOCsU5SJLuQ=
X-Received: by 2002:a2e:bccd:0:b0:36e:21a0:f212 with SMTP id
 38308e7fff4ca-37797a3b30amr47334921fa.29.1760993921578; Mon, 20 Oct 2025
 13:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013191235.4139259-1-robh@kernel.org>
In-Reply-To: <20251013191235.4139259-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 20 Oct 2025 22:58:30 +0200
X-Gm-Features: AS18NWCPfd1MN2_FI_xXjIXan8SG6Tbr5kEprX67_1-EY5u7nUJdishDZNpf4qI
Message-ID: <CACRpkdbduyWoJ7ob55btTwkCSQWDB9_ZObL3osLVYgiuB5Lk4Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: Convert bitmain,bm1880-pinctrl to
 DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 9:12=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> Convert the bitmain,bm1880-pinctrl binding to DT schema format. It's a
> straight-forward conversion.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

No comments for a week so patch applied.

Yours,
Linus Walleij

