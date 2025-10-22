Return-Path: <linux-kernel+bounces-864662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BED3BFB4A1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06156425514
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7D13161AF;
	Wed, 22 Oct 2025 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kfiHY1Pj"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC98F31A54C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127423; cv=none; b=COq/PbCY5NSZ6hwv/9I7yCA27pmgy1PyP81IFCDOTQ+5B7Y+FXXz8kM0AHaCfke3aOeMOOjaa3Y0118z7W6TKDaMpVzJCsrFpMSNcSj9HosRBaurd35RnDSzJ7U8/c20Z4B7ydL031nJ4+sjZ2Vfro2fj2CjZLNUm+ej256yYYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127423; c=relaxed/simple;
	bh=Qbbi4MZBKkecaJJl494H7QcMGXGjmq/zovJ9I9dUy7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjH/O5V1SzFqTuSTo9vpg5dK8aQt2JhzExrbUz6BTpSA5ynNCPIxfTiHOQA5ck4n5muO+8kN0lEw22N0pgNIOmvX19BJYP3Eum5e/hrY/K6MGoHsOUYI/Q5baxPd3H05i1BlPCiQVqc4Eb11M6M9Z4fkTFa2Yn0mV8ZYJzN2xGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kfiHY1Pj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c1a0d6315so12056849a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761127420; x=1761732220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j80svTpQNDT2HO9SwazgBXuB8uzAZlJDHoPKa+K5IjE=;
        b=kfiHY1PjMsOHPsR9jJ4muQi0D4utfRZmNvVBKUphDChSMB4OMatKjPgL5IYiowKZdB
         CeKI/koN/f70ZsSePFBdOpXpLA2IF11aF9wlwZSOVB5zX52YoGyWv9zVbJHrCvoOsKA+
         Npw0aT8CMUyVDUPT2mAPbaakxM/fNGLgUxUDCMJK1Go83CBQmqBLWd4tO0lcoF9P9XyD
         ELvNRnNhg1P2MnqDEBtdRFaydl3AoXxkjPtN4HGgMQExa85rHUR2EIo4GERo1UuOUlAl
         lY7EJt6NSsN6Zq0eiGn8gF2bYkUBer7gysstSe4ZaD9YXtb5Yk9/+iGkV7FaforxveBf
         MP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761127420; x=1761732220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j80svTpQNDT2HO9SwazgBXuB8uzAZlJDHoPKa+K5IjE=;
        b=Rf2FcArQqDcD9STeQh8uuLhzUF7AYvdrLk4wW1oJIQkxnB/Y3OhOfVi9Queslfh3t2
         D7He+UpqMxtaYEo7P2pZgVAUKCQnN140OLIvkRQG32/ovl9Qwuui2STpRa5wSoPgqR0c
         0MjIby4nyiDs3rF8hBmtxAiZG+yX8xAzHnDJJ4IHC2oLrxP7uGDX1kLyXyWDg4W9NsbC
         PePdhIjXX2LXyihs8k+GMAnYbyun4KNYTqW662VsAX7fOAMcCNhUUY+FWhDCdtANONH0
         YFpYDsUIVS5tEd7GI7FcXM6YAayHKHG/OFktEVDZ8kWrVqu5fxjjT7Rc4BeLOReMdXQa
         44zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhWKWzBQSwtw39fRcetdlY05YbK+Pz8XyzHesBcNwGCo5Eiqhq+Bl976i52uNDqO4sJbuS3br75y1SZGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJY2PLI+aukcrPtAfSvdKDipDXE+e31Bmys3EiTFhgaC54nB7e
	1gWglCNpkHrBKpUr2QNG8dTp6Q3ecNNWbk9lPBh03NECM4y5gxrUyDRSoxVOwOxnPQQ3snwOXvt
	0kpJX0lse+D2AL0w4evfQFakBBD079HvO40c9LVUNrw==
X-Gm-Gg: ASbGncuzCr5kSPcvUqfWeukbIY0OwAgkGoWXyY6OxaushaNeFYmzDmPkcQo1J3kzx20
	dcwgBro4IaA63+JgHBNUKkrYy3T5ITH32zbkH/uywNrMsfNoNLmWdfdNexC0j3atx9UhrOqfkK7
	wqif9DMcW6HP+Uw7QpPCNzxOVQPQBX/wRwjBO/Tcb/u6AAUw7/3AAd6sAIfYk5tmOA7gRwfAfUb
	wNEm9iOteJy5d9yUttJue2is7XGGKW8P82hschcFnjrp+SQ8knyIL0lJP9t8o6kpFDEqcWO5zgi
	Slcmy9A=
X-Google-Smtp-Source: AGHT+IFRHS9fCtNlfozcKqfiZ/HU21GMsDA3YriXsWw67Ybr2fSHm2R56fU3GCdtVA2wLt6A2hgJEfeDgzt+vSey8O0=
X-Received: by 2002:a05:6402:40ca:b0:63e:17ef:a62d with SMTP id
 4fb4d7f45d1cf-63e17efa78dmr3015030a12.15.1761127420175; Wed, 22 Oct 2025
 03:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
 <20251016-gs101-pd-v3-3-7b30797396e7@linaro.org> <CAPDyKFqNEN_yfmGWZr=sC-W8-Drv7zn82WYa-y=v+Suk-JHvtQ@mail.gmail.com>
 <838a2a9f-9d4f-4c04-bab3-c6a7d52b60b3@kernel.org>
In-Reply-To: <838a2a9f-9d4f-4c04-bab3-c6a7d52b60b3@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 22 Oct 2025 12:03:02 +0200
X-Gm-Features: AS18NWDgqWuAfrcT_6PqRDb-GaFHTXtI7dspjwKLQKVO9xQrFqh11FPqeF5ceCc
Message-ID: <CAPDyKFr4G5m_tnC20w-K7Nh2m-ut77rbeHvWgDTgHLA0hkALNQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] dt-bindings: soc: samsung: gs101-pmu: allow
 power domains as children
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 18:18, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 21/10/2025 14:59, Ulf Hansson wrote:
> >> +  "^power-domain@[0-9a-f]+$":
> >> +    type: object
> >> +    description: Child node describing one power domain within the PMU
> >> +
> >
> > I think we should specify the power-domain-cells too, along the lines
> > of the below.
> >
> > '#power-domain-cells'
> >  const: 0
>
> That's not needed. The child (this child device node) schema will
> enforce it. Parent (so the PMU) is supposed only to list compatible.

Ah, I see. Thanks for clarifying!

Kind regards
Uffe

