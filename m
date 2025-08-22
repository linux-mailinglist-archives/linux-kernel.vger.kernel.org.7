Return-Path: <linux-kernel+bounces-781158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF77B30E43
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9FEEA08568
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8B92E267A;
	Fri, 22 Aug 2025 05:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N6KSbXwh"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4091D284B39
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755841414; cv=none; b=d3J8g6lKun2xoKP9/IOwD0wZ2Zi5nJ6lvmIUvpuYkjID/6bfYc2V8JM6JQtjWzXJHO7PJPpvxHO00+S5eM2zbfpswTYM/QXAZc+0l/1GMzoUBwcvCjNGaLN+1/v583Jav6QWpfp9SRCvYeVZXVhrnddPf9D/4sPi+nNbCkIaMd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755841414; c=relaxed/simple;
	bh=nO2U9VG3vDM0Ed6fA8bpfu9wUGd9SkPGGleuZgl0xxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLuzBLRk0s6RX4cGlH7VdqS3oTdKx884cAPUZbKWizVhg5YKK0lc6GjuWF/F4YiCpSZqLhswd1IvV17tDZqXVMrprAzCsZDP6J/lX4nMgc/XsQvtJqGj5msG7woR6tEOYoAU90UuxGvyxwEPPPYe4V3yQaPK9b63uHQeEUjcza8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N6KSbXwh; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55ce528022eso1684584e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 22:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755841410; x=1756446210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GPy/kVr5xy7hBpohKijiQplg8+R4/OMAuZ4Oz2BeiQ=;
        b=N6KSbXwhNOtbLJ2vzqOZ8Ky0Kpx9aabVC87pxDBN83XJITWLz4IEs0JFTXkjTptX9P
         ynTNWrD+HL4kLlrTyo0wTzxFFm8AEAs1+e095SCxHTBgigplc35wTDYoYJOtdCArFxlT
         oGFBTBsGPABUuYvAy0ZxadDTZHjrS1FiBuRzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755841410; x=1756446210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GPy/kVr5xy7hBpohKijiQplg8+R4/OMAuZ4Oz2BeiQ=;
        b=q8TkXDh9frDhTxMhbG2hUIMJvgTJgWtB2eYf1cBFUidb/b7j0Q4He9ybmYdYnvsDOJ
         NM0xt7pelX6vlKPweP/3ozbyQ9ZBTglK0mkpJZ6RnL3yqrFAzSQTWg7ZxDmanhpvYvjA
         JV7x8vLP2Eq5Yd/Lk/+BqOxSpX5UUGBHyODHK1ce3fK3VLU5hlwJDHxvIrvBWF7RdGFQ
         s9Yc8W2CTJ+zIHQMXH/QwJUduE1B9NiYLq3+b9uV4lstnffdlwmL1+8ZKVtJ8S+6h1sw
         /FvEzR4C3F6CeS2nVl1vRNQo+v4/5opIvnf0c8rN6gojMzMs5nS/EwFjLcyRCYNN1Hlh
         ZtMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlJWbkz6MC9rJDLe/MuGP2oU4L/SN8C6ZPFkAyacmc+OzlLyKlXrzNy+GAAIRAN40wzV+btI0nwDtih74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYfgpCY3TPZVClrBeABefEfOaA9Tj2aT1ljCP61DiMl+/HKaXZ
	Yi7arzug2ZhEIanQtBwBegqTIaG6HWPUQwJm8urdgNhGXePPs56KJPE3qpVemauTZeHfzMSHfo5
	oCbr7oqMHdu6+8g0kL8pHcm+0RGFPNmm5wBhKjYW0
X-Gm-Gg: ASbGnctopVFLrouXfu/nE7bKN12jv9kzo6mAwmdW3Q74S94YcZCnceFKvFLSUvvzpfn
	tZ3DFolP6GrPS9PVntFd1YSRzQiqMmIdHFmlpPc+NGYzGVHNlNUxorAQqBVbsyL/E51x+QFaCjK
	jxIyGbHOPJrcSLwFCgveSRjyhj6nPeIRqoIkzEdpREW/kBxO1N4o6/GcZX+nZPFuHQit3Ai5iKI
	kLBjHyMjtfS0Du9rwMf8ail7MhLq7I8obvNrm9Osb51Qg==
X-Google-Smtp-Source: AGHT+IFh5F3sidBrknoS9iUxLce5fNJWzSFlFRbwYLI9hnCBtdEdWgKvCBxO6tc3R2KJHkeILhOZP6kccNtfJIF4ra4=
X-Received: by 2002:a05:6512:2399:b0:55b:7683:110e with SMTP id
 2adb3069b0e04-55f0d38200cmr562995e87.46.1755841410309; Thu, 21 Aug 2025
 22:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822021217.1598-1-jjian.zhou@mediatek.com> <20250822021217.1598-2-jjian.zhou@mediatek.com>
In-Reply-To: <20250822021217.1598-2-jjian.zhou@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 22 Aug 2025 13:43:18 +0800
X-Gm-Features: Ac12FXzfrL5PN_m3940D8QUKJ9xD917EzZ80ftFHhvgwSSGeG17u4a187tR07YY
Message-ID: <CAGXv+5GaJdWPFigVs-XyDZms_0Yvo+58p7N5e+-jwnyAhsO7bQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: mediatek,mt8196-vcp-mbox:
 add mtk vcp-mbox document
To: Jjian Zhou <jjian.zhou@mediatek.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 10:12=E2=80=AFAM Jjian Zhou <jjian.zhou@mediatek.co=
m> wrote:
>
> The MTK VCP mailbox enables the SoC to communicate with the VCP by passin=
g
> messages through 64 32-bit wide registers. It has 32 interrupt vectors in
> either direction for signalling purposes.
>
> This adds a binding for Mediatek VCP mailbox.
>
> Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  .../mailbox/mediatek,mt8196-vcp-mbox.yaml     | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,mt=
8196-vcp-mbox.yaml
>
> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,mt8196-vc=
p-mbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,mt8196-vcp=
-mbox.yaml
> new file mode 100644
> index 000000000000..7b1c5165e64e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,mt8196-vcp-mbox.=
yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/mediatek,mt8196-vcp-mbox.yaml=
#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Video Companion Processor (VCP) mailbox
> +
> +maintainers:
> +  - Jjian Zhou <Jjian.Zhou@mediatek.com>
> +
> +description:
> +  The MTK VCP mailbox enables the SoC to communicate with the VCP by pas=
sing
> +  messages through 64 32-bit wide registers. It has 32 interrupt vectors=
 in
> +  either direction for signalling purposes.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8196-vcp-mbox
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#mbox-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#mbox-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    mailbox@31b80000 {
> +        compatible =3D "mediatek,mt8196-vcp-mbox";
> +        reg =3D <0x31b80000 0x1000>;
> +        interrupts =3D <GIC_SPI 789 IRQ_TYPE_LEVEL_HIGH 0>;
> +        #mbox-cells =3D <0>;
> +    };
> --
> 2.46.0
>

