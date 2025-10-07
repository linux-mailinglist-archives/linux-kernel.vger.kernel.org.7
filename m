Return-Path: <linux-kernel+bounces-844657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5546FBC2706
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4B019A1A91
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C38F2E9EA6;
	Tue,  7 Oct 2025 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qF6tLWKa"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC111E521B
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863005; cv=none; b=HB4bmQABqNOaEtf9vKYOPl7ENtw9X9dM1+e+isT7QTp2iXQHJkHbTSAtgcWNowzqtuYZaov6Hn9yN6MfGjy/UT1xV3nCDCeYR1bllbg6gbWW+TBytHdzAtpzaLQ+N5NIx/7Ca3rdNu04fqTHGAfTxOiFIBicYTECfTRYYp2qBoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863005; c=relaxed/simple;
	bh=CjaCQl6yVB4wEbVAM7cWUmIAOOgx45oYuyglLl2ufaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HR5G8CO0sJ6bLoo+yKv46M+JxCHx9TiMHonnHGoQtgFanxoK23GlWkQGXzIOAjNEYlppfWP4obqeySZWZyfRo8c1xloWVxgIvZGh/KLjZieJGSyYPoOHQdQXlNRxYgTNNwztPM9HZVyw+GQ/zsOfTmxPJJJtvJ6TRw1UJARgx+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qF6tLWKa; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-87a092251eeso2139236d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759863002; x=1760467802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aNYGyYwV4vw7l+4kbvJWnzel0gTCPuhPYenonekONo=;
        b=qF6tLWKajbHA/gNtsVQspJfpVRTIsqLgQzxlmfN0M57gEKtFDJuks161QhUJGMuMDU
         H9xHPW+t005SkW1qGN4XPVIGR2satEKPWVQKqXm0BIzzDLz4FjquMKb4eP42gVqlSGuF
         plEetkP8Op2Q9R/766+Jw7FAfG3AFIdFa6ogEg9y755skM28I3bWD4brqP7jVeHVRvkv
         gw+XXnt1Dy3Ddzdi4DsM7NCNJCZ5rJZhRcqqoiu+yf3ldnLCfH4ORtEbJs1X4M3wy0CA
         RIs39RSXXZArXIfmm0D9Zlbv54rUwgQlajDprILN+VFTfYk44KuIYRUsKgqRW8CBitWF
         oF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863002; x=1760467802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aNYGyYwV4vw7l+4kbvJWnzel0gTCPuhPYenonekONo=;
        b=Rym6odchIydI5YtKjZsyFm8Kx9yXfpBltFl6oFPIBmKPSvHTBcLsq3fJv6ZPwRGjSq
         r8DvYS8JywKPWaM0tBj7Ux3tuuniJqhNG/4d01k66otVe3cgFqSGhh2PZ1cKu+zH9QJG
         Fzk4gxhAkleWkCe2o+7AjSu2gI3i5rOb7kvkeKMctIay3tHIYgJABACz5kEoz9KfkwAv
         db7DdOaaWROzH4cb5qOas6X5nRXPGzPh6IpCiUdJzmUwQr/EOwXcVrlP5j2L14sTXk45
         Q7eQ/awe2D3LFfHhQ6biEOAT6OKV1HlSz3pA9AiAJ8PQixshumkLrGW8wcDuDrUZyKpm
         7o3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfYs4f4IXU0V0l9autE7mr0ntr2RdBO2HZVQSeDiGB4JDRMqzeuHwANlTmqN+mFWLv0+U4E92QsFO3C/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt6CAeVpGO74dpxpJKCLxec2pFdzCXkuCY+exhJGOG9qhAGzTW
	8Kyx92m9xPDbhx+bhRvduNpavx1fMJVwnvTi1t+0BZm12HCz7TM8+XRMLPM/IYaUKajSU2HpIti
	ePJJA7nY7IK01DT4LkojC7tWCRFIkI8jNC4nVrY/n
X-Gm-Gg: ASbGncuziLUwgVfjyfxTg9aBvbHCuZuM5VFDemeaI6Df8gB4+cbBbSVXt74/cEYtcjh
	6yN93ufJ/8czD51YeEhDwiCfZZuI42hzSRplcOtsGuYSLb0iOmUMs3ir+CIx2l2sjy2ifOWXIyr
	JGYOuSUQMhQXCgiQ28Bnrvh9RBQ5qCJtsoIx9AmJVYmxWSxw0AsR1WkbWHa4h3jEjA2A8UgFRYD
	RXY+1SplDBSb4qyLyu4cVuWordxJex1URlDVYNEZ4+O6A9M8nIUrK84jwbAaDKWt74mrCNn9Ejp
	pK8=
X-Google-Smtp-Source: AGHT+IGo6iqnWrqDrtRo1an3vJuKouV5RjS5DRtWGy3IQp7nt9esDi9MQIuwsCqJ8H6093glYV4xzd90Bb/yR8LhGEE=
X-Received: by 2002:a05:6214:1ccf:b0:86c:a297:9c97 with SMTP id
 6a1803df08f44-87a052877b1mr67912886d6.18.1759863001273; Tue, 07 Oct 2025
 11:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006232125.1833979-1-royluo@google.com> <20251006232125.1833979-3-royluo@google.com>
 <8ca61364-df47-41f2-b0d1-f2a8a74ec728@kernel.org> <CADrjBPr7Jp_ZyGv2Krv6iLG0avgFWpcWJEO-Z=cEkhwEY-+z5Q@mail.gmail.com>
 <d592eb91-84e9-4bdc-8363-1d0bfd47c17c@kernel.org>
In-Reply-To: <d592eb91-84e9-4bdc-8363-1d0bfd47c17c@kernel.org>
From: Roy Luo <royluo@google.com>
Date: Tue, 7 Oct 2025 11:49:24 -0700
X-Gm-Features: AS18NWB1W-NkF9ZGaROK3BKRMdthcWV6kVzDTDNtLUYtC_DV2IHX4qZyOhy-2Gs
Message-ID: <CA+zupgyQGpQEoqCm9rbnw2Aum4j3mu-dqvDVN=RUEVY9E7q7Hg@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] dt-bindings: usb: dwc3: Add Google SoC DWC3 USB
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Joy Chakraborty <joychakr@google.com>, 
	Naveen Kumar <mnkumar@google.com>, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 7:18=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 07/10/2025 18:09, Peter Griffin wrote:
> > Hi Krzysztof & Roy,
> >
> > Firstly thanks Roy for your patches, it's great to see more Tensor
> > support being posted upstream!
> >
> > On Tue, 7 Oct 2025 at 01:44, Krzysztof Kozlowski <krzk@kernel.org> wrot=
e:
> >>
> >> On 07/10/2025 08:21, Roy Luo wrote:
> >>> Document the DWC3 USB bindings for Google Tensor SoCs.
> >>>
> >>> Signed-off-by: Roy Luo <royluo@google.com>
> >>> ---
> >>>  .../bindings/usb/google,snps-dwc3.yaml        | 144 ++++++++++++++++=
++
> >>>  1 file changed, 144 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/usb/google,snps=
-dwc3.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/usb/google,snps-dwc3.y=
aml b/Documentation/devicetree/bindings/usb/google,snps-dwc3.yaml
> >>> new file mode 100644
> >>> index 000000000000..3e8bcc0c2cef
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/usb/google,snps-dwc3.yaml
> >>> @@ -0,0 +1,144 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>> +# Copyright (c) 2025, Google LLC
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/usb/google,snps-dwc3.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Google DWC3 USB SoC Controller
> >>> +
> >>> +maintainers:
> >>> +  - Roy Luo <royluo@google.com>
> >>> +
> >>> +description:
> >>> +  Describes the Google DWC3 USB block, based on Synopsys DWC3 IP.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    items:
> >>> +      - enum:
> >>> +          - google,lga-dwc3
> >>> +      - const: google,snps-dwc3
> >>
> >>
> >> There is no such soc as snps, so you grossly misuse other company name
> >> as name of SoC. Neither lga. Otherwise please point me to the top-leve=
l
> >> bindings describing that SoC.
> >>
> >> You need to better describe the hardware here - why this is something
> >> completely different than GS which. Or switch to existing bindings and
> >> existing drivers. Did you align this with Peter Griffin?
> >
> > I think (from what I've seen at least) this is the first submission
> > for drivers in the Tensor G5 SoC used in Pixel 10 devices (which as I
> > understand it isn't based on any Samsung IP). Hence the new drivers,
> > bindings etc.
>
>
> That could explain a lot. I would be happy to see background of hardware
> in the bindings commit msg and the cover letter.
>
> >
> > However the issue is that none of the other base SoC drivers on which
> > this driver depends currently exist upstream (like clocks, reset
> > driver, power domains, pinctrl etc). So it's very hard to reason about
> > the correctness or otherwise of this submission. It is also likely
> > that when those drivers are upstreamed things could change in the
> > review process, to how it looks today in the downstream kernel.
>
>
> Bindings and drivers can be contributed without core SoC support, but
> then please describe the hardware (SoC) here. Having core support posted
> earlier is of course preferred, but I think not a requirement.
>
> Anyway, compatibles and all commit messages in this patchset are too
> generic and need to reflect this actual SoC, not "Tensor" because we
> already have a Tensor with USB. So basically based on existing support
> all this patchset would be redundant, right? :)
>
> Best regards,
> Krzysztof

Hi Krzysztof and Peter,

My apologies for not providing the full context on the SoC supported in thi=
s
series. Thanks to Peter for clarifying; yes, the Tensor G5 SoC is a new
generation of Google silicon that is significantly different from previous
generations which are based on Samsung/Exynos IP. This necessitates
new bindings and drivers for the G5 and future generations, and I will
ensure this is clearly detailed in the next patch set's cover letter and
commit message.

I acknowledge that the core SoC support (clocks, reset, etc.) for G5 is sti=
ll
missing from upstream. We do have plans to push this forward, but I don't
have a firm timeline yet. Thanks for confirming that this won't be a show
stopper for this patchset.

Thanks,
Roy Luo

