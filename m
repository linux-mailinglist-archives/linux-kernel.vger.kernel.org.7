Return-Path: <linux-kernel+bounces-862957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E127BF6A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E386E19A4170
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765E833B97D;
	Tue, 21 Oct 2025 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2NdSUn0"
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA0A33C500
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051618; cv=none; b=WOOP9ouB/sES3fL3FExhY9I1V2Zp0qHTwCbc6ccwS+Hgpa/KPFza0u006vyCp1kQh3qMBt4bRTMt4hdvWW0TYdSNMpWetIi86jVWqO40aifDCZ1N+gHHOdZmJWQQ95VdfrpQQcTsDJRMAqeCNSwKs8Cm4ldNqBHEbPEKy3ZZ1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051618; c=relaxed/simple;
	bh=5CwFdvA3X29Kv1mhM21fPBuZSIHfzjJ7q9hLb6A09cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceEKQgQiYKcTPXj4qov5xbApuvqchTS44MnFcCSitiw3be3fBehkcPN9OEE2l2lXjqWezp/A+lBsVDOpI/PYgWrHc5O1+0o6Feb+EQkNRbSAzltZnEhRqhHlG9OthcqCMkJOUmqUAWJBMgIcA/rAtO8X7w1cDMduft49sRAyKRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c2NdSUn0; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63bc1aeb427so5787908d50.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761051615; x=1761656415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlEJkGo4jbFcLLHgPauAsvkvtRdewAA4g7rPzfOb2+8=;
        b=c2NdSUn0yplebnJZ75R6Fkskgf29aH6hwjhW3+d4F2fJQdm/ZCzrJKO8fnhpqjZLLF
         OGHQ7naJyKgqlfdPS7UOG0qdaX+Ud+iFqlLqFjncvPgt21vAOw9NZCJmwVcu7tfkD1DM
         Gn4ShpqDV/dDRYX+tM1hZSnwdqI6N3H/9VT2y/ZW1RMFlWODymVfpVvtngQ/v7jvwLJi
         5sbU1Ywmkah9oxwMu50UuDWgfxe5JZ9l9YULd43ScHOtynICOWaB1JB3DpvzEAe9FfI+
         0wkb3MI1QslQ+puDVgcvoXJS4o0HFkgaZ0yy7luqDTuEPN/1LUDKaldntaD8n/GR+8ck
         32xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051615; x=1761656415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlEJkGo4jbFcLLHgPauAsvkvtRdewAA4g7rPzfOb2+8=;
        b=maHdT+P309brNaC+LuhSWEL9AmPhtTehWgGV/ay20Q1mwyox1JK5YDg14T7bJyRBQY
         XYXaB06MY6UtSMZvroLuQnx6hwdALH+h1foBMYjAAcWkS5Uzjh+MPwR/4KCJPs/9shZS
         CHpM2WPpj83LYpi9DW4h6Js6Weu2GqAtOnXKVAlntnIhqDFlqzPU5E6gnBl/byC5JLgJ
         /MCwaR8u21Eyj5JMyNv6FF4UmD+Yg1GLqhy1BCJqcw9gTFyW2oTOb6x7wb4NsMzyAXhO
         EIuoJmzlf0OgLEc/wxR2y0YZoIFOIXxdVd8RoBU73786Xq9SzUDwWzbx7SsgfRbNGlB6
         XgKw==
X-Forwarded-Encrypted: i=1; AJvYcCWhiet+WkzV7Mv8XvpWvBFeTTpvn/ZZNsRtsexW7USoqiWx+yLRW6V0iwzsgFsBXYrSVL7JokcCS64373w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxUyFIh1vwRM4cx1144i/KDWRgqLzwvlDQcaX6SN0+XZ7zyaNA
	muy+K8sIWq23a+WmanDOaZHCwtmAxCrrKdqWI5y1NKm0PvMe7coHrtxtJENJ1Fp93+Rxya4EW3a
	Sr2fVZMxeLkeTxkuqUAX9DNdHXq4sFOOD/kXfTbWSdw==
X-Gm-Gg: ASbGncuzAg1zBkuSpNHX/qu8cUBh9Bj3jrT1p0nkbQzflEKfzj0FTrHTwmzG8po+PT8
	nh609nZpupzXtzTlTtJ/1PNuUHwVFJwtSGlR9lIq4hICShmplq61MoErKehH0iSBkQPxHTF9LRU
	UoTvlvWiD2+hdtIbUb5AHbhAIafFFcH7gAPpaGCun4T1IoFpBMcFDGQ/XXvOWUTgZZ6FUavVzG4
	dsWQOVsP07QX2nJV0DeS7cwTSDNEOJz7Zces/443HxY5srrp8a4MUUIEgwCKW3Zk9zAaD2x
X-Google-Smtp-Source: AGHT+IH3Bsal993llg86W2aSSM1eiZS3yAmHYuPkrL2KcynJ1XAI6y+Y0IumRaTcK/qZuaGYZjT8+fHPq/Xs9WCQQDY=
X-Received: by 2002:a05:690e:2049:b0:63c:f5a7:406 with SMTP id
 956f58d0204a3-63e161f865emr9077055d50.58.1761051614403; Tue, 21 Oct 2025
 06:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org> <20251016-gs101-pd-v3-3-7b30797396e7@linaro.org>
In-Reply-To: <20251016-gs101-pd-v3-3-7b30797396e7@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 21 Oct 2025 14:59:37 +0200
X-Gm-Features: AS18NWAWrX3EdOi49ik_edQ7hyw6I5dlqupwh8B2wvDucY-SMETDIx3Qc3I521g
Message-ID: <CAPDyKFqNEN_yfmGWZr=sC-W8-Drv7zn82WYa-y=v+Suk-JHvtQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] dt-bindings: soc: samsung: gs101-pmu: allow
 power domains as children
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Oct 2025 at 17:58, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> The power domains are a property of / implemented in the PMU. As such,
> they should be modelled as child nodes of the PMU.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
> ---
> Note: Ideally, the newly added properties (ranges, etc.) should only be
> 'required' if "^power-domain@[0-9a-f]+$" exists as a patternProperty,
> as they're needed only in that case. As-is, this patch now causes
> warnings for existing DTs as they don't specify the new properties (and
> they shouldn't need to). Only if DTs are updated to include
> power-domains, such an update should also add the new properties.
>
> I've not been able to come up with the correct schema syntax to achieve
> that. dependencies, dependentRequired, and dependentSchemas don't seem
> to support patterns. Similarly,
>   - if:
>       required:
>         - ...
>     then:
>       required:
>         - ...
>
> doesn't allow patterns in the 'if' block (or I didn't get the syntax
> right).
>
> Rob said in
> https://lore.kernel.org/all/20251010141357.GA219719-robh@kernel.org/
> that this is a known limitation in json-schema.
> ---
>  .../bindings/soc/google/google,gs101-pmu.yaml      | 40 ++++++++++++++++=
++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-pm=
u.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> index f7119e7a39a3fe0a0a23d1faa251d356f83ba501..a24390f6d2a54afe1aa84935e=
03f719a62f4fc8e 100644
> --- a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> +++ b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
> @@ -26,6 +26,14 @@ properties:
>    reg:
>      maxItems: 1
>
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges: true
> +
>    reboot-mode:
>      $ref: /schemas/power/reset/syscon-reboot-mode.yaml
>      type: object
> @@ -49,9 +57,23 @@ properties:
>      description:
>        Phandle to PMU interrupt generation interface.
>
> +patternProperties:
> +  "^power-domain@[0-9a-f]+$":
> +    type: object
> +    description: Child node describing one power domain within the PMU
> +

I think we should specify the power-domain-cells too, along the lines
of the below.

'#power-domain-cells'
 const: 0


> +    additionalProperties: true
> +
> +    properties:
> +      compatible:
> +        const: google,gs101-pd
> +
>  required:
>    - compatible
>    - reg
> +  - '#address-cells'
> +  - '#size-cells'
> +  - ranges
>    - google,pmu-intr-gen-syscon
>
>  additionalProperties: false
> @@ -61,6 +83,24 @@ examples:
>      system-controller@17460000 {
>          compatible =3D "google,gs101-pmu", "syscon";
>          reg =3D <0x17460000 0x10000>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;
> +        ranges;
>
>          google,pmu-intr-gen-syscon =3D <&pmu_intr_gen>;
> +
> +        pd_g3d: power-domain@1e00 {
> +            compatible =3D "google,gs101-pd";
> +            reg =3D <0x1e00 0x80>;
> +            #power-domain-cells =3D <0>;
> +            label =3D "g3d";
> +        };
> +
> +        power-domain@2000 {
> +            compatible =3D "google,gs101-pd";
> +            reg =3D <0x2000 0x80>;
> +            #power-domain-cells =3D <0>;
> +            power-domains =3D <&pd_g3d>;
> +            label =3D "embedded_g3d";
> +        };
>      };
>
> --
> 2.51.0.788.g6d19910ace-goog
>

Kind regards
Uffe

