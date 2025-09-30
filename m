Return-Path: <linux-kernel+bounces-837033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4C3BAB20D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311E3189A052
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A2F2144C9;
	Tue, 30 Sep 2025 03:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T2V0n94Z"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285A721B9E2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759201644; cv=none; b=E2UqtemKyiZDaryE919fLOfs4GCLPtvREC9NSsqz2auWheBxG9aYt+jJPdKNTxMs2C+yL0Ns4VxWqXT97q5x9MImKj4c3bZEOXCG4O2yp5+xv145bf6Whn6JNjMmxL5UiGpI3qf7Tp4H7Ma2DMamVPMGbHy/qrlluH1cQ+MXVug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759201644; c=relaxed/simple;
	bh=6CYu0yjjLffWbYyT1iuvFnA3aqfZ7582Muoa6RB5CIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DU80W+cdWD06/nrLkWWD5nSdCwfq//pwy7C5Kb4RRzafuT3Ap5J49lgtq0528b62yP2t85rXVITNcq+8jOBJhFvVk3vxJ3EaSAXfoAYtjwOF/yf36TZty9xL6IMLk9uTDwOkXWOQw1y+ypOUERR71LG+ImB+jnAZDh2zoUAI1lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T2V0n94Z; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27d2c35c459so43422625ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759201637; x=1759806437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKvNIqyQStmqM1bZBXJ3keviMu+G7jno5fFKkr2O1vg=;
        b=T2V0n94Z72PkWrgoKPn3wti0SMXyWgXWITYhsxs0BBwPeONdbMihl5p06hVfcRJMBY
         KBGFaC1Cl/EQFG2FKQ7kwLs5TvXf2JcP+UWJkXVNd7zRSXfjS+qD8GFpm0jNLu7wGpxq
         KLevcRL5ZSVYkRBP/E2Nk8He+p4GgXNRlEF5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759201637; x=1759806437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKvNIqyQStmqM1bZBXJ3keviMu+G7jno5fFKkr2O1vg=;
        b=kqtl6RNAkan1mLIHFXIF6vOAEIGprhmeM3fKM7i+UPgV3eBUm6j60UbBFLticpeqgO
         6vocT99YyL/NbitJ5Dd6R0CJjeV+v993GfKXzlquKhXLCA9rNcTJXQ3RVt8mIgB+wfL6
         oVfdeE+1nWmmWDavlsYFBtIlTN5in3PvAagAcWt9Ql4K2THvRCIsFywlk+An32XluqOL
         0eq6NKUu2bQesn+qM3Zi4kNnPK63J9yyoxRUc5mL29FIMtq7TW5S6/3tW93JNUyMtO3E
         0sCTm7hEw3EK/y4btHYOs6svOuqQw/B+Iiwqd0rvbm6R1M96hSLRgvRLCXbBW3HcxAKw
         6+DA==
X-Forwarded-Encrypted: i=1; AJvYcCVB+npTLRsXNtLYedFU0oSUuY6WXCG0P705YeLBjqGSS+fEwxdtP7rXBmN3ZNxNgFozxMRs0NZWL67uc08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+/BRM7SYLvzpjUThCweKHNgxBOijTPHyrKPluHB8R+iadLcQ
	OgeBuxZxsPvx2TqW8tmEq2taR7fyQZ9jBA4vI/8jgXZL63rQigZVBu1OIaZOhhq5Cu627IkeExy
	2lf4=
X-Gm-Gg: ASbGncu6n56NVeWaL0tNumTkBrwRDiZ0XLyGNxCcGPVCUGSJmDkUR/g60rktlmEAF8n
	oHY/2e4p68YPifalHp7D3ur8596tm5n+6hnRpNk9guNdTx2Q6FGNVQXaYSuInBOcsIpaB262vCJ
	6hyGVpl9r+ylpDfQvVpIb+3IICjREV0Wo6TGV1MgZ6bMsAYjHmwhRYKJD3GnB5BVUipnHMsytIK
	3Yx98DCr2hmGrKnGIRG5efPFVUIp6BikFDlgjM2K6GZHsIGkHEOo9uw8RvtMn9M8fhO+BARCGIo
	XTqngvzB8cwGd0GfmaBOhKdMr9tk27PYnIv4YGBHhmvC20lWtPIN2jbSQatvJAs7MmMmYWBcn7t
	0vzubEHxrKgNqzR7Jw93Rs+gwhncpoWwN0GnWB5LqGGWecVIu8jO0uFSU/lOelihHZXl42UzkBJ
	LVw3ThS7CwRM8Njw==
X-Google-Smtp-Source: AGHT+IGz+L49ayRNiEj3wfL/SeoCo/PM75jRGL4G2Yjz+uYAGL4CprTZphrdDjaxtp9UH4WJID7sGw==
X-Received: by 2002:a17:902:ec89:b0:27e:f06b:ae31 with SMTP id d9443c01a7336-27ef06bb0b8mr153238025ad.61.1759201637137;
        Mon, 29 Sep 2025 20:07:17 -0700 (PDT)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com. [209.85.214.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821ebsm145203645ad.84.2025.09.29.20.07.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 20:07:16 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-26a0a694ea8so45034965ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:07:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVavonKQuWBnphPRAyG+oRCgZbiTUlj6D7vRjNFLuwz+bpmklWrgl5r39CYtuogLKoSpQfVtSWTTxzJUp8=@vger.kernel.org
X-Received: by 2002:a17:902:f64b:b0:275:f932:8636 with SMTP id
 d9443c01a7336-27ed4a2d54fmr206796235ad.38.1759201634408; Mon, 29 Sep 2025
 20:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929142455.24883-1-clamor95@gmail.com> <20250929142455.24883-2-clamor95@gmail.com>
In-Reply-To: <20250929142455.24883-2-clamor95@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 29 Sep 2025 20:07:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vd=muLeMJYszC2SqRBThN=Srm_bKXBEmjjqND7bqHo2g@mail.gmail.com>
X-Gm-Features: AS18NWCupJdoWovR_kE0x_uWeV-e4Q15rTRpmAHzxBq1v_8sPWAFlU2cXRm8lAs
Message-ID: <CAD=FV=Vd=muLeMJYszC2SqRBThN=Srm_bKXBEmjjqND7bqHo2g@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] dt-bindings: display: panel: properly document LG
 LD070WX3 panel
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 29, 2025 at 7:25=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:
>
> LG LD070WX3-SL01 was mistakenly documented as a simple DSI panel, which i=
t
> clearly is not. Address this by adding the proper schema for this panel.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/display/panel/lg,ld070wx3.yaml   | 60 +++++++++++++++++++
>  .../display/panel/panel-simple-dsi.yaml       |  2 -
>  2 files changed, 60 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/lg,ld=
070wx3.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/panel/lg,ld070wx3.=
yaml b/Documentation/devicetree/bindings/display/panel/lg,ld070wx3.yaml
> new file mode 100644
> index 000000000000..0a82cf311452
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/lg,ld070wx3.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/lg,ld070wx3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LG Corporation 7" WXGA TFT LCD panel
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: lg,ld070wx3-sl01
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +  vcc-supply: true
> +
> +  backlight: true
> +  port: true
> +
> +required:
> +  - compatible
> +  - vdd-supply
> +  - vcc-supply

I suspect you'll get a NAK here because you're not preserving backward
compatibility for existing device trees. While there can sometimes be
reasons to do that, you'd need to provide a very strong justification.


It seems like instead of breaking compatibility you could just have
two supplies:

* power-supply - The name for the "dvdd" supply.
* avdd-supply - The name for the "avdd" supply.

...and then you make both of them not "required". Maybe you'd add some
documentation saying that things might not work 100% correctly if they
weren't provided but that old device trees didn't specify them?

