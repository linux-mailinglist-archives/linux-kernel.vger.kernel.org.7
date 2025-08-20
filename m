Return-Path: <linux-kernel+bounces-777071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C4FB2D4C0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888C91677C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8150F2D3EC2;
	Wed, 20 Aug 2025 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLL8HIzX"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5A04315F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755674464; cv=none; b=Edk9ihLEPlxMYL6r+s/i/Hu86rEMIERL6bCuXAfYep37MRRN9+/Ynt3f7R5Z1hhiS6ACvpz5jGruZBUJX0QHP5GRT2UmMDCN2bx6fERbdRUV0Q+3JtCNQ2kybZ78ts+eXc0UAcXBjxeQZShcBgyTmJeldhq/Jm2zwkMCZE7xMO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755674464; c=relaxed/simple;
	bh=ktoR6uVr+iqN83IhJ5uhhx0UJXCbOVpaCx9WSC2wCOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISAzhAFzt9FXPvERotMOk701O5KP0pyfItoscQYABzb7ihwWR2cXgqEhuyKJIxTvv4fZX3wmf5VNBy23WSxAlN5d4c1nC9QbipRq99WURuBx936Aad0Gw5kSGmV6fTBbialxbIZFIPE631eiz4cvbDZwnh1owC/3YaaKzRGgWJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vLL8HIzX; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-333f8f22292so44843721fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755674460; x=1756279260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktoR6uVr+iqN83IhJ5uhhx0UJXCbOVpaCx9WSC2wCOs=;
        b=vLL8HIzX0IbolcB0LP120fsumz8k5r5HIZpnewyRQI5bdxhm3GPBdh6F9k6UwlETMi
         VWihylKcCJnTXNxuc6HzCUZ9wR+6Uv0QNYvcMst/GDr8q4XlKl75y7lhlmnT5Ss20E/0
         j/jWW6+Z/58ISvdy0Uf4W0Ekc6mTz6c/L4kqVPnKlvZ4eabu8un06rEWKCkmKp5ZbgAj
         w3hAziL9sns5CqJ0qd0vPEM2QP2Yvw/zmXg0WA8C15YA7E5isp13diL6lIiby/75ztIu
         Vr/8IFXBY1h6cDb6K/ahDxyWKnH7SJC6/qeKyzlJcb4Y9z/T162AwRwt1w+SHOaO4235
         4+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755674460; x=1756279260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktoR6uVr+iqN83IhJ5uhhx0UJXCbOVpaCx9WSC2wCOs=;
        b=xCN+o/Fsb6AxiK60nyJyZlb6GioXQyHkBzEZUrrtiOjLy1BcOEOVcQC2W4V5WOwyVB
         tAOcpxKNagajK6vjieuwkPBPxKtGxPG8h/bl8g1G7lA6i2mCNibewnJXzax7Lbfr6Xg4
         0MLqB93MBcn8/d8g69oDfEMbGEnSQdAp4CBZ5u4mjakwNBScwYmKNsM/KMN9CxjceBVa
         I8dkBNe7GTZNz48X5yV2rDBmZ1KoosSSdnPiHEB1WesQMHQWQRxuqwANWeZ+301WdaTh
         4g2vec5l3qOfNzv6jd4OnXNNwSnZBTCUC32XJFbkqR0k4I1csXO7O6eBICO42laWHi3T
         BTCA==
X-Forwarded-Encrypted: i=1; AJvYcCXgD1zG8Ki3q8Um9ewctjJs1+c571GX4tTOe4lrUchralr/drJIQK/x7g1bgBvDdGOUuJEHc4eEsH0fpRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6uriKX5bSxOb3LDnyraf0qc/g6vP2H/nRRbGoYJQCXdaYwuAS
	LMF3AbR/MNysTFDpgWdbfxmmO/DrWFVk7kL+hLaCUNv8Z9iyAdxQPwh6V2ak5CsbmuBOi1xfUpn
	u5ETk7f6QR7ua5iWw7gn5IoFr8ThYzDIU2O0QdQRxYQ==
X-Gm-Gg: ASbGnctyAEYvduxo0QITUZFL/bhCf5WKRuPUj1vl0hCKvCkqfubQkdsnca+1xA0wn9D
	Bz7/5GM7MQH3L0cvsx3WllQ5xDyLeXjam10Lw9yZ7fw7fW9rRhllGift2eJOQF4tncM28x+1oMy
	sB75ojMP16s3m3vl1rsLreuW9BVbwiSb1raPz7WxfrN2GHBFDwx+scOGkAGlB+iU4N0GeBcBXRP
	X+IeRs=
X-Google-Smtp-Source: AGHT+IEhSxjZCfw4a8mb40d3FzcM6vUrSgKvHtgC3xcWemUkmbdkdCwfNVxjfPSijs9xEWS2bBLeXc6JSAQOzBY5S3c=
X-Received: by 2002:a05:651c:4104:10b0:333:ad65:c524 with SMTP id
 38308e7fff4ca-3353bc145a5mr4014551fa.1.1755674460071; Wed, 20 Aug 2025
 00:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818103931.1100084-1-richard@nod.at>
In-Reply-To: <20250818103931.1100084-1-richard@nod.at>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Aug 2025 09:20:48 +0200
X-Gm-Features: Ac12FXwVe2yaYSWObSiIPH5gEnk6wo-BPXw1jBAn3u10wAfLmNVzja2ouijgdDo
Message-ID: <CACRpkdYYTe0YArbheo3msd6r+CNrt9oSZWNjkiwb=ZNWfJ1dkQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: ftrace: Implement HAVE_FUNCTION_GRAPH_FREGS
To: Richard Weinberger <richard@nod.at>
Cc: linux@armlinux.org.uk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mark.rutland@arm.com, ardb@kernel.org, ebiggers@kernel.org, nathan@kernel.org, 
	dave@vasilevsky.ca, ruanjinjie@huawei.com, liuyuntao12@huawei.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Donglin Peng <pengdonglin@sangfor.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 12:40=E2=80=AFPM Richard Weinberger <richard@nod.at=
> wrote:

> Enable support for ftrace's funcgraph-retval feature by capturing r0-r3
> and fp.
> Since ARM does not provide its own __arch_ftrace_regs structure,
> we instead populate pt_regs with the registers required by ftrace.
>
> Cc: Donglin Peng <pengdonglin@sangfor.com.cn>
> Signed-off-by: Richard Weinberger <richard@nod.at>

LGTM
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Can you put this patch into Russell's patch tracker?
https://www.armlinux.org.uk/developer/patches/

Yours,
Linus Walleij

