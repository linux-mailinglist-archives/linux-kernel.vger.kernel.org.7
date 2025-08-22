Return-Path: <linux-kernel+bounces-781642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A72B3150C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13333B7E09
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E92285CBA;
	Fri, 22 Aug 2025 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M7JyqnPu"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE3122DF9E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857780; cv=none; b=O5iyMkl3CVcmkF89GOvLDm2/Wod9H3K3QLqMScI16ygkuOgDJjFitKk44WqQhQm2xC38h4WQMX07HxWbOVmg5CWh9lDhUJnNQAjlgIDs6nQMTA8XQQkg74KlIhxIlvQG7VDmnbuylCtSptLyGWVZusyp+dGq7e/0ACiM/N0vmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857780; c=relaxed/simple;
	bh=n+uuSrn8u6juOkuP9SvbxcjWBcwiQZYJvcqO5SL+OHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbF8PEDmPKBQ+6MI8THqawVQJUjdYVf52S+ZAKjRj/Jmjc9YnkNPlAC29L2xF3RbDHCuGzkK/uLV5AEyDnWTke/v7LEFVdCxqttOLZ/Uy67KUQgjoY7Uuwp16sLGSbAz0BjE8RspJiNy1Eout3hsGY93lE+vIo0UBOVBZJDrClk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M7JyqnPu; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d605c6501so17838437b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755857777; x=1756462577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDx2DLdAKNYscUVXgj1y9NZCkQ1KxqDufjQBp2yX34A=;
        b=M7JyqnPu+O8cZWILnOQMIvqe1HARXGpYOJpoDxtuxwaEjp4h3s6gRSjSwnxdPZru6L
         0iGsWQlVvRmuPVFzHFxEDxeiB3tL/7aIEbAPjsK1zYN/4h8ROgqVMCQtcZGa5t1EtbT3
         L4Royvs4vBPt//rrmBa/qGx1LXTtbqyX3p/dvm9DWaK0Absi+hkxSVHmVXOIy9cCDPdd
         IyweBJQ43gzMok5fgAyoCrc6gvkTOMLrMkKqACMcxbAmtEIowHgL6IiJbR0fzn2uw7DX
         kgOp7NoRTU2WSt3Akd7pZ0YBofJB2ZZKPlUkVcIknKZoUYWL3EKrzZ19r9N0pSU8948K
         1ZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755857777; x=1756462577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDx2DLdAKNYscUVXgj1y9NZCkQ1KxqDufjQBp2yX34A=;
        b=CZo2rsF+YLd/I15lfjOXlMNz5oONloUN4BIOIftt3/SVW12q+srFV1oJIFysq6TxIx
         5Avx/x2TMW7gdgkwE5SdLWEtq20czQAJoYHH16t+3ULkTXWyZMgBRIOtPp7Rtj1gM18O
         dae9ZKDS8frtzxtEy8tV29C1s0JFGAUomsu1PSOBk7XEWw/W2RPAoK1oVEL2ZleYIR1G
         e+fBgfO1oifAa3pUl1Hn/8WypMa+xcOr+pUeSwDeYzmCK3ENpnewpsFgGlc62QylnzX+
         K1iW1Z6loe3oYw8YfqGHjxZp0xcGRSJZ7wONVbIE1+pECrQF1ERNZklOXqjjiWGB7vBa
         Y6Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWiInr8i1b4wqUnf+KD7Miq8BwLN/3ijNQBM823UpMTuzQHpfD/ihZ+yknTnIE4mcWNUHDzH0BBZWcM/aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpbXvVCamYY7fSFpJCilCnNKU0v4vl9FmzugUd4ApCI0ghcHhT
	BwJ0ijx2/MLLljZGQzI69GpIhL0JhTG1DkjYzmOkeYgbEUVGxKmCRSssqAgh7InhAUKYdfizKg5
	z/LLOSqX8lrm5WICaWGT1pIUhODiDJV9r6Uj93+VJzA==
X-Gm-Gg: ASbGncug01rmjgx+KBdqk1BpxN0WAcwZEHi/+H8Xr9KA7+kvMGyUf2QMytZhgcgJFSS
	oi7EZrHHUENrzFZhCQ+Ryn4LOTm2/WUk7P63i8YrGRUHcSTMoHwiUtaUjyxV5cBHXVh7i7OAPDs
	TT4ShEeD5HsPXPkr5gCthRSFEvl8fvO96v/+ViFCDBrbOvbF89UHEzX+nugtLxchY3o+yO1/lyK
	DPCllPz
X-Google-Smtp-Source: AGHT+IGisCuaDpdsoUYA9pYgVpfMQpgdPrniDusu9dQcSD5V9YeojvAiAiIby9Q5FLmBXxfa6GuF5BNA8l3vdExQZ3w=
X-Received: by 2002:a05:690c:ec8:b0:71e:7ee9:839a with SMTP id
 00721157ae682-71fdc2f17e3mr24348107b3.2.1755857776818; Fri, 22 Aug 2025
 03:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821-pxav3-uhs-v4-0-bb588314f3c3@dujemihanovic.xyz>
In-Reply-To: <20250821-pxav3-uhs-v4-0-bb588314f3c3@dujemihanovic.xyz>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 22 Aug 2025 12:15:40 +0200
X-Gm-Features: Ac12FXyMkjhCU6n4TOiSQhHwXlqNLt3Ozl6PlHCodFGyP-HnVszxTjH0MYaKHjU
Message-ID: <CAPDyKFpGW58HSQkodWQqHaNU02OcaY2E7C1Kt=caLCdXkOvvuA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] mmc: sdhci-pxav3: pinctrl setting for fast bus clocks
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Aug 2025 at 13:20, Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz> =
wrote:
>
> Hello,
>
> This small series adds a pinctrl setting for fast MMC bus clocks to the
> pxav3 driver. On bus clocks above 100 MHz, driving the data pins at a
> higher current helps maintain signal quality.
>
> This series is related to Marvell PXA1908 SoC support merged into v6.17.
>
> Signed-off-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v4:
> - Address maintainer comments:
>   - Fix if-else braces
> - Rebase on v6.17-rc2
> - Update trailers
> - Link to v3: https://lore.kernel.org/r/20250806-pxav3-uhs-v3-0-2f03fee38=
0b0@dujemihanovic.xyz
>
> Changes in v3:
> - Address maintainer comments:
>   - Refactor driver patch
> - Remove RFC tag
> - Update trailers
> - Link to v2: https://lore.kernel.org/r/20250801-pxav3-uhs-v2-0-afc1c428c=
776@dujemihanovic.xyz
>
> Changes in v2:
> - Address maintainer comments:
>   - Newline between properties in if:
>   - Don't try to lookup pinstates if pinctrl is NULL
>   - Only change pinstates if both are valid
>   - Replace dev_warn() with dev_dbg()
> - Link to v1: https://lore.kernel.org/r/20250718-pxav3-uhs-v1-0-2e451256f=
1f6@dujemihanovic.xyz
>
> ---
> Duje Mihanovi=C4=87 (2):
>       dt-bindings: mmc: sdhci-pxa: add state_uhs pinctrl
>       mmc: sdhci-pxav3: add state_uhs pinctrl setting
>
>  .../devicetree/bindings/mmc/sdhci-pxa.yaml         | 29 +++++++++++++--
>  drivers/mmc/host/sdhci-pxav3.c                     | 41 ++++++++++++++++=
+++++-
>  2 files changed, 66 insertions(+), 4 deletions(-)
> ---
> base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> change-id: 20250718-pxav3-uhs-d956bfed13f0
>
> Best regards,
> --
> Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
>

