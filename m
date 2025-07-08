Return-Path: <linux-kernel+bounces-720877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2B2AFC19C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB720423514
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9205023BD13;
	Tue,  8 Jul 2025 04:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BlTdrsQ0"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC4C1E4AB
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 04:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751947795; cv=none; b=r8joX64VH18jrAhY6Ysj/s5XGeUF+SG9Ij8AgU4HlzMJuGqQua0eXbC20YMye08z3Ydl6R6apzXe+UMIhewR3z1fR7jmadfJ/4iJZ/Y5yVpvlsNtYEcWj7zC7hGMNUkBhmlZsdzz6O8RzvAyuGAnMdkELoVrCrtih1jdxpIAGq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751947795; c=relaxed/simple;
	bh=ztvXHKmyWJi5j07UYL2TtAAwnohFLggOOe806CIpqmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXtfS0foyJ+8kMTLjMbZfwfevTrfbpevRxOXdh6vkQbFXG7aD3mQPOHlNDfK2QjOJK2SnrFdXigzGLIQ9nPI3i+OiHr1I2sz78RLanV0iInwihCNu3/Ws5pc6o2rchEweP3H3qqZZrQtutEes0vh7Hg3NW3j0k3PqV0Nakt1M8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BlTdrsQ0; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-557e20222c3so2495551e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 21:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751947791; x=1752552591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97PA7tnoUToVlQXPk0nMmVPATh2HU3vK09piMMjV8Cw=;
        b=BlTdrsQ0or1Wn7vIUOqtWF+lXDNIHovZe8X5Jn3KXjJGITFcoS0jvSdVA2kBpTIAQj
         LsG67uJriU42GRPWyK6hhlLy7IFhchP9WrpOfWG7Oojb9gflb+ILW4D+ABvlLrjrsF5i
         4QBPFQPuQiiMspiu68GtL6s11EEjexsHJNY2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751947791; x=1752552591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97PA7tnoUToVlQXPk0nMmVPATh2HU3vK09piMMjV8Cw=;
        b=KQMtwm6nw7tqi7GekZDYJPG0U6khc8GW25uYLtg2E1qnyVCLp4PXZwFybpC5656Wnc
         EnqRjqFnT4rSDs4VymD6H2QrwR+ff+7WnO56NuLuzm5ad39NpOgUpU7kXb9kqGnkZ4jW
         XtUIuh1Qswdl8W7IHW9xOBf3zDl1apltpj65VGAA+F/pZFYvC4mfbXtlsXzQRkhMRezv
         uMuOPsrAE47Zr1fO8QkR7OBjRZvkF+yrHVfZmEcGNjqxQ6rfZObqjJepsDWnMB2zuedF
         53EiQPqtv1m47M+9mNjpioyEHI88pz8nK8RDkJgyj4vkXpTArFfa6hVMA48VYhlQ7kAV
         sFLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYx4v1L4CUHhd6LERc9IxBQCOBmd2YEL6Zb/ob1+cL9t0tMbMszau1Doj482EvUbWpcyh75WY26JYvYE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY8i6EwVykf9RS9zhcGGcT0bBokRhktXjjkam0c24owpkR60ap
	SCSAAf9ACtCs8TuIQbKJHrcmJYuVd/u6RwVPu9L9bvXFK88s2Lg6OtdY3xyd0KO1j9gUAL3tYM+
	K52ioA7aOB4uxdXFcErcAey8EkJbsvuIGuOc6Lgwp
X-Gm-Gg: ASbGncsvjH8JMWwzU1m7eN5rzH0n4Blm6Qsfx/DTt7ccq4E+QxOT2TuG4HtLgoyG7Mf
	487wrtYH3g1/qCSgOBDBX8+RvAZfCyFu9jXhF8uEJ4T7f+Z6YsP/WkB7pocwgUm3PFY5g8oLQyu
	3JM8/PAaWHcc8XvpQmJBzljuxguaX+DldaZW0bppGgFhCyCxEDizMdrR+lIwcaGOdPU/tKQpQ=
X-Google-Smtp-Source: AGHT+IEVujyv6lAcDWE1bZGAyeEobtReCu0A+jIigUo7aBzy2SXT5pvaXtmoXS+q6pOlLoU2IHQ9/lFEOLFDtdD+mLU=
X-Received: by 2002:a05:6512:6c5:b0:553:ae47:6856 with SMTP id
 2adb3069b0e04-557f8310057mr327313e87.10.1751947790882; Mon, 07 Jul 2025
 21:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707134451.154346-1-angelogioacchino.delregno@collabora.com> <20250707134451.154346-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250707134451.154346-4-angelogioacchino.delregno@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 8 Jul 2025 12:09:39 +0800
X-Gm-Features: Ac12FXzG3Dao19qlz-A1KXKkJqrEyMGo4bcZkDP1swxYmwtOwf1D0Gwc3OVNmQY
Message-ID: <CAGXv+5FHA-Y1xyW=_UjGUDsqarXNTciGP7KnzoB2Jyj2Ft5rdQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: regulator: Document MediaTek MT6363
 PMIC Regulators
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, lee@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 7, 2025 at 10:27=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add bindings for the regulators found in the MediaTek MT6363 PMIC,
> usually found in board designs using the MT6991 Dimensity 9400 and
> on MT8196 Kompanio SoC for Chromebooks, along with the MT6316 and
> MT6373 PMICs.
>
> Link: https://lore.kernel.org/r/20250624073548.29732-4-angelogioacchino.d=
elregno@collabora.com
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  .../regulator/mediatek,mt6363-regulator.yaml  | 175 ++++++++++++++++++
>  1 file changed, 175 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,=
mt6363-regulator.yaml
>
> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6363-=
regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt636=
3-regulator.yaml
> new file mode 100644
> index 000000000000..9df57b803edb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulat=
or.yaml
> @@ -0,0 +1,175 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6363-regulator.y=
aml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6363 PMIC Regulators
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +
> +description:
> +  The MT6363 SPMI PMIC provides 13 BUCK and 25 LDO (Low Dropout) regulat=
ors
> +  and can optionally provide overcurrent warnings with one ocp interrupt
> +  for each voltage regulator.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6363-regulator
> +
> +  interrupts:
> +    description: Overcurrent warning interrupts
> +    minItems: 1
> +    maxItems: 38
> +
> +  interrupt-names:
> +    description:
> +      Names for the overcurrent interrupts are the same as the name
> +      of a regulator (hence the same as each regulator's node name).
> +      For example, the interrupt name for regulator ldo-vemc will
> +      be "ldo-vemc".
> +    minItems: 1
> +    maxItems: 38
> +    contains:
> +      enum:
> +        - buck-sshub1
> +        - buck-sshub2
> +        - buck-sshub4
> +        - buck-vb1
> +        - buck-vb2
> +        - buck-vb3
> +        - buck-vb4
> +        - buck-vb5
> +        - buck-vb6
> +        - buck-vb7
> +        - buck-vs1
> +        - buck-vs2
> +        - buck-vs3
> +        - ldo-va12-1
> +        - ldo-va12-2
> +        - ldo-va15
> +        - ldo-vaux18
> +        - ldo-vcn13
> +        - ldo-vcn15
> +        - ldo-vemc
> +        - ldo-vio0p75
> +        - ldo-vio18
> +        - ldo-vm18
> +        - ldo-vrf0p9
> +        - ldo-vrf12
> +        - ldo-vrf13
> +        - ldo-vrf18
> +        - ldo-vrf-io18
> +        - ldo-vsram-apu
> +        - ldo-vsram-cpub
> +        - ldo-vsram-cpum
> +        - ldo-vsram-cpul
> +        - ldo-vsram-digrf
> +        - ldo-vsram-mdfe
> +        - ldo-vsram-modem
> +        - ldo-vtref18
> +        - ldo-vufs12
> +        - ldo-vufs18

To summarize my replies to the previous iteration, I think this is
not a good representation, since a) the interrupts are internal
to the PMIC, and it does not need to be spelled out in the DT, and
b) this gives another meaning to the representation, it being to
enable overcurrent protection on the given regulators. Instead
the common regulator binding has the "regulator-over-current-protection"
property that can be set in each regulator. IMO this is much more
explicit.


> +  isink-load:
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false

Do we know what this is for? There's no actual output with this name.

> +  ldo-vemc:
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +
> +patternProperties:
> +  "^buck-(sshub[124]|vb[1-7]|vs[1-3])$":

According to the datasheets, vb[1-7] should be vbuck[1-7].

There are no real outputs with the name sshub*. These seem to be some
alternate setting / mode. I don't think they should be modeled as
separate regulators.

Also, could we drop the type from the names? There's no real need for them.
I managed to get them removed in the MT6366 binding, and I hope we can
continue that scheme.

> +    description: Buck regulators
> +    type: object
> +    $ref: regulator.yaml#
> +    properties:
> +      regulator-allowed-modes:
> +        description: |
> +          Allowed Buck regulator operating modes allowed. Valid values b=
elow.
> +            0 - Normal mode with automatic power saving, reducing the sw=
itching
> +                frequency when light load conditions are detected
> +            1 - Forced Continuous Conduction mode (FCCM) for improved vo=
ltage
> +                regulation accuracy with constant switching frequency bu=
t lower
> +                regulator efficiency
> +            2 - Forced Low Power mode for improved regulator efficiency,=
 used
> +                when no heavy load is expected, does not limit the maxim=
um out
> +                current but unless only a light load is applied, there w=
ill be
> +                regulation accuracy and efficiency losses.
> +            3 - Forced Ultra Low Power mode for ultra low load, this gre=
atly
> +                reduces the maximum output power, makes the regulator to=
 be
> +                efficient only for ultra light load, and greatly reduces=
 the
> +                quiescent current (Iq) of the buck.
> +        maxItems: 3
> +        items:
> +          enum: [ 0, 1, 2, 3 ]
> +    unevaluatedProperties: false
> +
> +  "^ldo-va(12-1|12-2|15)$":
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +
> +  "^ldo-v(aux|m|rf-io|tref)18$":
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +
> +  "^ldo-vcn(13|15)$":
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +
> +  "^ldo-vio(0p75|18)$":
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +
> +  "^ldo-vrf(0p9|12|13|18)$":
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +
> +  "^ldo-vsram-(apu|cpub|cpum|cpul|digrf|mdfe|modem)$":
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +
> +  "^ldo-vufs(12|18)$":
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false

Could we also describe supplies? There should be:

vsys-(buck[1-7]|vs[1-3]|ldo1)-supply


ChenYu

> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    pmic {
> +      interrupt-controller;
> +      #interrupt-cells =3D <3>;
> +
> +      regulators {
> +        compatible =3D "mediatek,mt6363-regulator";
> +        interrupts =3D <4 16 IRQ_TYPE_LEVEL_HIGH>, <4 17 IRQ_TYPE_LEVEL_=
HIGH>,
> +                     <4 18 IRQ_TYPE_LEVEL_HIGH>, <4 19 IRQ_TYPE_LEVEL_HI=
GH>;
> +        interrupt-names =3D "ldo-vcn15", "ldo-vcn13", "ldo-vrf0p9", "ldo=
-vrf12";
> +
> +        ldo-vio18 {
> +          regulator-name =3D "pp1800-vio18-s3";
> +          regulator-min-microvolt =3D <1800000>;
> +          regulator-max-microvolt =3D <1800000>;
> +          regulator-allowed-modes =3D <0 2>;
> +          regulator-allow-set-load;
> +        };
> +      };
> +    };
> +...
> --
> 2.49.0
>
>

