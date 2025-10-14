Return-Path: <linux-kernel+bounces-852374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC42BD8CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B963E423B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3D12F9DA1;
	Tue, 14 Oct 2025 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lhv2rd2W"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728BA2D24A6
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760438673; cv=none; b=agWnO4sUL29LfiHaHiK9GDgEH6VX48bz2Guz4fK5FbFyt2yhsCbs+Qurpo38I4EXXIth4VbOlNmUbLJgex8YoEonRJ+KDCMovr2Xfj73rryz4jtpxo1mGC+jRB6z/C5uJacK1vPZlsUGqNNplhieQdPPmTV05aksB5TIV6cDsQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760438673; c=relaxed/simple;
	bh=s3P3SxQQQdWjgG+0wxnCeO4S365wlkK1npK4z7KMX4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuAdhSugrBuUUp+FOpFtDFNfo35/AKbpydciBmXzYjWH78eOV2ok1rT9WOrrFwckhfto2mbUibUKiP4uWX6mj7rU58STV08D3yUaRTm0POMoKLGh5v7h5/8V+GH2fbS+Qd+dUMRDiBqn5q9jSjkSFcyoqBFF6TEXvUF8VdTRzOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lhv2rd2W; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7815092cd2fso3619547b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760438670; x=1761043470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THAYM86a8lGfJC89oRqulnlUSAmMtqdsc6KSglKPv6Q=;
        b=lhv2rd2WH9CZuFONezi4NEyOx2PohReRg+WuXsteVAy3mTZnfIBBL0yKNW6pshaf+c
         L1uouiMZwnO0gI2ActMrSsqF5O5g3GTH8FyddAYuOPjB/ZnegPG6gf4V+cfPKztQme66
         Y1/TbVe+Nxje5DEYZ9rRCEx7L6qFh+BKONDI6IxppbCCcDXmsqeovfq/f7CnFZo9bMwF
         XWvSPpYpWsxexsIIH26rE9POCgGKjvhKNOtEkIFxYYueUl9CgF+xh6hRf6cURJufu1L/
         YATa3cFJOo4HKE/Qg1vnoj3wIGpU9/gR77YBAi6FSIqWe3wbKZVM9JzapJCqH0yS1fr/
         nFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760438670; x=1761043470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THAYM86a8lGfJC89oRqulnlUSAmMtqdsc6KSglKPv6Q=;
        b=GiyiNNOGAcsCilm5OH3JzYWzNcbTv13NPB7EE6zvm+w1tQZG0ryLslvl6V5zclvASg
         hK3jan1SZ89J6wqoR8l3r13lOLHbDF3+GI8A3qK3cen8i95duJYswl4joOnKLOOayJih
         7/RFIbu3ejHITpO1s+IvtQkR50/HdY2dDuOpzDKT9QckzGxXZiizawFhO+U8hkPtdhJt
         vAHVY9al5tkYFdxjbVqd1ERcG+UVVe3kT+iZ06PvJsj8Ri54H0UlcbqYvLAkHxdGhqLp
         ie8MU/7kBBwwCLs4m18hIICpM7psnJHLQ8eBJz0XlhRboipfuwohV68lw0yjn/gz2fmH
         u39g==
X-Forwarded-Encrypted: i=1; AJvYcCVYISf58RGri5jPgUxt7qlY4YWwMcqFDzRIoNhgb2gJLD84cBf8NepYHcqePM81wNQewbqDA+y3MzKEOG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIFV9Ps0Fq+CuOPFrpRPWq+80GK6PbU9OaQRHFHU/UMUTll3aK
	CGztafg0i6+qjknHejaySdXM/79PVXuMaARvkS6wEBsiNV6vifgGeyg+59DPa4LhwBlk3GlVRNV
	qffcR2CzF7UOoWS10FgBSXnvX2+NDIJJNdDwczMqt/A==
X-Gm-Gg: ASbGncuFpw94hW4c6vRy4ow23vq9Ua3PuKeBf7ONgK/1FlfRxJt84c1KlMGMEg8NWD2
	W9+x6d2dxHZoSNx6FRuXnjY+MlZahLZvJY81gW3vy0znH4AE0ei6HarQmge+74Dl1MUlcEg7uAL
	/j/9SdZmy0Wl/XPfI2JGTCoI4iKGwFryogUFENn3Ds/Q182VyX/X1QBqp3eS2/S65NZb+iT22NB
	tpOLUBxYS0uR1m2t/DHFi2N5UR2Pg==
X-Google-Smtp-Source: AGHT+IFp4+6M8ipAZ5PvzMBFmhPMOi8dNCbnfx7iCHUB+I0mJ3szARsJfZuBKpYg4FajfdIRV8gYXT4SlaoN9/M/6LQ=
X-Received: by 2002:a05:690e:182:b0:63c:f5a7:400 with SMTP id
 956f58d0204a3-63cf5a70a44mr7374154d50.68.1760438670439; Tue, 14 Oct 2025
 03:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014015712.2922237-1-gary.yang@cixtech.com> <20251014015712.2922237-2-gary.yang@cixtech.com>
In-Reply-To: <20251014015712.2922237-2-gary.yang@cixtech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Oct 2025 12:44:15 +0200
X-Gm-Features: AS18NWAu8xsDVfGUGNQZd3TKgpRR7nZFuc-hAgCzcqzNK32irDscIbUpkUaITw8
Message-ID: <CACRpkda-2BNj+Pt2kS9u_bbr41bsWGRGDqNd3EXVnys-xSqg0g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: pinctrl: Add cix,sky1-pinctrl
To: Gary Yang <gary.yang@cixtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	cix-kernel-upstream@cixtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gary,

thanks for your patch!

On Tue, Oct 14, 2025 at 3:57=E2=80=AFAM Gary Yang <gary.yang@cixtech.com> w=
rote:


> +# Client device subnode's properties
> +patternProperties:
> +  'pins$':
> +    type: object
> +    additionalProperties: false
> +    patternProperties:
> +      '(^pins|pins?$)':
> +        type: object
> +        additionalProperties: false
> +        description:
> +          A pinctrl node should contain at least one subnodes representi=
ng the
> +          pinctrl groups available on the machine. Each subnode will lis=
t the
> +          pins it needs, and how they should be configured, with regard =
to muxer
> +          configuration, pullups, and drive strength.
> +
> +        properties:
> +          pinmux:
> +            description:
> +              Values are constructed from pin number and mux setting and=
 are
> +              defined as macros in arch/arm64/boot/dts/cix/sky1-pinfunc.=
h directly.
> +
> +          bias-disable: true
> +
> +          bias-pull-up: true
> +
> +          bias-pull-down: true
> +
> +          drive-strength:
> +            description:
> +              Can support 15 levels, from DS_LEVEL1 to DS_LEVEL15.
> +              defined as macros in arch/arm64/boot/dts/cix/sky1-pinfunc.=
h.
> +
> +        required:
> +          - pinmux

Can't you just include both pinmux-node.yaml and pincfg-node.yaml
to get validation from the generic schemas?

'pins$':
  type: object
  additionalProperties: false
  patternProperties:
    '(^pins|pins?$)':
      type: object
      $ref: /schemas/pinctrl/pinmux-node.yaml
      $ref: /schemas/pinctrl/pincfg-node.yaml
      additionalProperties: false

Something like this, I never get this right before actually testcompiling..=
.

Yours,
Linus Walleij

