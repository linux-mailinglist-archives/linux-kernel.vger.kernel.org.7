Return-Path: <linux-kernel+bounces-850334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7327BD28AC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038EF3B6334
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97B32FF14D;
	Mon, 13 Oct 2025 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tn4AMXvL"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A81F1946AA
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350942; cv=none; b=Uwh/8uhVUeFJ7GzY2m3l8XvxFU4aOT2uD2uoM2+bi+Sm+19h9s4qrEb/opWAKHNpJ+2ARXxbushPI5x3/VQl/nOnomxYFd0/0pgq1SelkiCKT1fzquLpku1LMkzrcClRM3BM1jzMoyrmEzEShADJUGFx8BMhjeTmC9BbRHqNknQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350942; c=relaxed/simple;
	bh=J0YVa95Ez3fXkjsDuSjMGBX3HxLIWmcP2kzWtuxN1l4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQyz/JeqfWil5jCwaBganSxF60BeC5kcH1CtUUAKSgCc6Ld+gw6VGj90eko/TwqPkp+qcqQF7kQzM1u+CXWXCyKwTztvPTwzDbQJ3QWm93xKh18MGbmdytp8eyiiCd2gVVdWoaHV1otgRfW24tCVSTWEVcZXpBT1eLK1FcOF80c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tn4AMXvL; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-586883eb9fbso5410361e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760350938; x=1760955738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0YVa95Ez3fXkjsDuSjMGBX3HxLIWmcP2kzWtuxN1l4=;
        b=Tn4AMXvL+mZhvmxc/MctQS9zlQk6xCQhCqtvzpuxU/9ieJ2oa9yoMddqOT3mG908Ma
         Hc38u8FRja6QHwDUI6OA+wB3FoHVFKH1PEwGRGAGq2LSdIM1hqQSyQvrTEbqExaEtZy6
         L+9MYT0pvVq9xb35emWfBlRQYK2aAHUTmxYwc9xS1+Pxyize+A3IxNBueGshakQ8pJXj
         quoI7BTb+B1FFLm3tMndfFRy5zkmOlmhR5g7ZGJSwBOJVfcX/g8OeBCuX9wAraefquBt
         q3oF3BFW9fIBZkXgbyAuM4FckYBYPJHe2ByFQTgcXCbdX3t5emfftvESh9pvp6YnA3zX
         rc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760350938; x=1760955738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0YVa95Ez3fXkjsDuSjMGBX3HxLIWmcP2kzWtuxN1l4=;
        b=i+AjTfQH1FUjbwiUePfLH8IRKNqxGM7mMYSQbXuU6Au1JOZKHwkaQNV0aLqgVJHu6G
         ahV5Ge6QXDvUJ97DazcI4c3ji78k2lvOD94m7gXNuut73zyD+KvpDG7TlMSwoMlWPvr+
         WIWsewWK0WsuWNMzzal36joi9QEnxHj7UFcQlfx/gcZ1IY2jEkKy53XgnrR5AOSgxvVp
         h2BVY7K1IQR3Uy/OYnJFgFPELX0BraozJrgqnxTJWdhiNZGZrQZlAlz/B/v3qP2U9Oce
         GGO0ZHaG0MviEGPXTXWBlpnAo00Gw/S+XNB5J8rTpkkpwtp3gOMF1W25vWpw7o9VOwO/
         S6uA==
X-Forwarded-Encrypted: i=1; AJvYcCXIWnt+Z1cusGXmsqY6M2F6wwDwgV0ibV8ZXPWtee5dK65qnqDjxZnJvsDXRJpFjasE8dZymMav4H0JQ/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGpDWPTiXcPXtYYH0qRlYHG8FikQCdfc9qtb67NpvBXj7WRal0
	N/TneIi9eKpkCM4CL5JGtrEClsdLPCEIdXqIJCgSUmsHqr8Rzma7qTrXyNvtWf1A28p9b4nKq3G
	sHnvbNhUcB7ZDskU9kFdAJzq3RIdINfzk3Bi/zQ7/XhcdEIzv6ec0
X-Gm-Gg: ASbGncvKe9rW3FdOxZItLZfzXuVu79FkNLtUHAHJwVJIi7UTtBGoyFE2oTVuMQbj+hv
	er6zlZOVWGL/zMX0EkGsh0VnEnlCMODZoVfc3ig21BPP2VOPFhF/7TUWYM9hjKboCAhKkXKBaJb
	In14asWnlqUUlpOE/B3/jW/8pymPYkHAm5NcGasvAvSIA0Ugjd6pmKqzFYitK9ud0OecoKRNXdd
	PzohhckZT3U3YhzE3pG036mlg2PMjNkgq6eJHtM
X-Google-Smtp-Source: AGHT+IENaEcC3/wZaVUeeDsXpBkIr3KX7viprB/pcczwPYsh26J5YtWYqjYpftNdfDJE/OvtfEnuPnKWez6O/cJUrSU=
X-Received: by 2002:a05:651c:254c:10b0:376:4320:e34c with SMTP id
 38308e7fff4ca-3764320eb7bmr17947211fa.46.1760350938409; Mon, 13 Oct 2025
 03:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924223201.2952988-1-robh@kernel.org>
In-Reply-To: <20250924223201.2952988-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 12:22:07 +0200
X-Gm-Features: AS18NWBwORgIspwCI_5ukY34xV9cV74ksQiqXEWSRd7YtTs1Q41FvnzidRhvUj4
Message-ID: <CACRpkdashCu1Se0DofbtRbck54QE8nW666GvDitFT4LT4_2Q7Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: Convert Marvell Berlin pinctrl to
 DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Antoine Tenart <atenart@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 12:32=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org=
> wrote:

> Convert the Marvell/Synaptics Berlin pinctrl binding to DT schema
> format. The "reg" property was not documented for the newer SoCs.
> Otherwise, it's a straight-forward conversion.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> With this Berlin is warning free on arm64.

Patch applied, thanks for fixing this!

Yours,
Linus Walleij

