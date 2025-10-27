Return-Path: <linux-kernel+bounces-872650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1CAC11AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6E019C8F96
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D333832C31B;
	Mon, 27 Oct 2025 22:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUNpyqXM"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B070A31A7F9
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761603768; cv=none; b=ZaQkOZ/ghA86JIckeGSIEY/Gq56tQ1w6Ae88LqmUJlpF+CWTjiSp6xfGv+N03+u+NjQzTjSXzZDj+Jl35XUIGiOb8S/e0zBxZoxu/BCv5kqK3M5pb5rJKfAE4xihlVJDwm2Uu+/eskhVuxtnrtRXNvxxR/8dmLI4W2dp2GTejYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761603768; c=relaxed/simple;
	bh=mXGvcp0mAGNWE9aZLpOmWkJL3jKzf6jiVNyhGirW+KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7snChfB9BId/O0ztO9Qb45CSioMEzRxAHOmXBJkGiYBUrBwa631B457nGwxuaV9x47h24RPLMaxND5rOhAY8v+7oJYcj5lWSAe75d1Bo+LoDUgI1f/JWobYM7P8ikmTMXu05v5/mXodbBUqJ7IySQaRArslntFwj9x5eGqqIGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iUNpyqXM; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-378e8d10494so40742601fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761603765; x=1762208565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXGvcp0mAGNWE9aZLpOmWkJL3jKzf6jiVNyhGirW+KQ=;
        b=iUNpyqXM02B6VYUDMj5GtUHR1Q87dnmmhxn+Y2geUKlYuwXG2XYAkJ/gvy9MSpShNh
         damJTtIhjW/K9XqssAu9JQ5x/UQ0ZKHAM8/31lWHLucugT4tVm+/Ls1j+efnsAwYtrKD
         Ex6fLyfWs1UfeLJ7mYK+FdH0Xy9OaDYbeBr+6xhhWbwXWO5kNwUue8BuoV2tGAMmfLGk
         RG84uY/YH4u3qkBfVAqx8jUEcwtTA0+Wpf8gxP6W/s9jb41F9mQPcL2NX6qkhJI5HqsE
         xDpyj/KagzyEZOlJBGJdsM5vxD7hwSzl+6/uqqqqiHRHktDeiAb9OZprzmAkoVuN8Vgz
         EJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761603765; x=1762208565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXGvcp0mAGNWE9aZLpOmWkJL3jKzf6jiVNyhGirW+KQ=;
        b=RI9pMUTKxLUDmtYd40ZwjJVJz/FlQCcHK+Xf6Knj/jjPvG+97/+szwGe+XwHPb4cue
         XNXPq+ArR5WuS+K1UdKYTgTHZSiCzi2cxn5VTo2q0vvfyKKUS6kdS+Kj+z4DzrbV0F1b
         iDkMbez4B8/tGJ69g2up7061l1AUfqzjHOab/06autvqknNgKFqpdVUtgXFOuuoouaJZ
         +F1EoRE509X7YmS5wpY8eDMY61a1xfcOMGuvH9wFTaT2GHcvMi0aOzqhmpRw1akfC2BT
         waTB9xmmLIPSbs/9xfWNEyUqslivQFbwJO1737A0TlxJ8JAIE2EMjKuH85eYrkmc51L9
         bw1w==
X-Forwarded-Encrypted: i=1; AJvYcCWZf6m8JnXnleQ64iSYABCi156LVOxRhWc4VBmNa7Z9U+NeIGIcoCaTwb0gnVTPC8mFKSB4B7YjDZs5/lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YybOG7uQTmVxxe4fGSp3pf/SYivzzBJcrp1fiTDApwWuwk+S2WQ
	ssr6BJnDlUklTHQxdANUWC7vafJP9W7J9yLATUT9wOLH5PnOAB4UE/W6tR1qD0GqOhOc/hjRoPG
	EcVcCIWeyvuKPtV8OlV77Kf4HXs12k7zmqr/6tDW15Q==
X-Gm-Gg: ASbGnctb5GEC2UzUFXLVc50SDP0cBH/CuYex8sibeWRZoA/yC342/R+GduI5WTNLZQU
	fDgPHiTv41IMlair6NlcWkIKa9iJujKtTnBVUYLDXFc92BjdDp8o4sp7Fi1eBPHObnk91U+1p0i
	kCTy6FrnuFHM9eTeCbCQkb9WlIet4SvTBLGTcfkdg0IVsaSefVvMNE27xu/up2sUPxfdV/FCUS1
	ofge33I1kkSrO3serdvDRo5osfF5tn6rmkyk7HxZOmZ8OZ25m+4zW2QgXO6fA3OR9K+kro=
X-Google-Smtp-Source: AGHT+IENAbbZLs2cyhX1NG2TDFVr4DwoM7AOuX8MbllL6Bct/y5S8yxPyMTw8+JJ+2TJ6jnQOkcpn7hnhHqJSRfElWE=
X-Received: by 2002:a2e:87d4:0:b0:376:4c71:75 with SMTP id 38308e7fff4ca-379077ddc2cmr2613171fa.46.1761603764869;
 Mon, 27 Oct 2025 15:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025162858.305236-1-yury.norov@gmail.com> <20251025163305.306787-3-yury.norov@gmail.com>
In-Reply-To: <20251025163305.306787-3-yury.norov@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 23:22:33 +0100
X-Gm-Features: AWmQ_bmkn6Wyph29A9p5imLlQFIsc9_UvxXx9DMK2tf4nubU3-p4iTlVFjOP3js
Message-ID: <CACRpkdZZdBL4ii-ZR5ATOx-GCw7Un8vEd8koqWK7cbgTXNPmBA@mail.gmail.com>
Subject: Re: [PATCH 10/21] i2c: nomadik: don't use GENMASK()
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>, 
	linux-i2c@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 6:33=E2=80=AFPM Yury Norov (NVIDIA)
<yury.norov@gmail.com> wrote:

> GENMASK(high, low) notation is confusing. Switch to BITS() or FIRST_BITS(=
)
> where appropriate.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/all/CAHk-=3DwhoOUsqPKb7OQwhQf9H_3=3D5sXGPJr=
DbfQfwLB3Bi13tcQ@mail.gmail.com/
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

