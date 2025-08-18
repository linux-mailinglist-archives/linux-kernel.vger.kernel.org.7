Return-Path: <linux-kernel+bounces-773418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD9AB29FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523BA5E6189
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA26D30FF38;
	Mon, 18 Aug 2025 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OF7IOqeb"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AE630FF1E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514521; cv=none; b=RnNXPjjvkbZ3mn7JVCUWen1zjZXhtwKpJssZUzsYW8ESpJQN5cpKUaJ1HTL+e59ATe5dIHOHjGMcme5ps4tb6+h66ObYVukWf898iwgFapjW5ynKUQa8YOxmCwr4cZ9JrefHRUXxGMQKMlUx9gq5sRKHEcwBbaOn6m5PCkxW3dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514521; c=relaxed/simple;
	bh=/gdGHTrneWQqmOYRuvh9CIob29j8iPfzhl61xeqmBF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AD8TkRXfRnB27xBNHYZc24fSqg9l+mGpfqRqBpGCy4wyGibwm6rvlxK7dmh4GS0NOyqK/gZHaELEinmnky7B/oibgZ8Rr7thCb83w1EuzBQVmZ4F2y4F12oW2RdQshYkJ5jH66IZR+JT7QLx6hSCT4FKlKqOFazXTOrvmfD6ClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OF7IOqeb; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71e816e7f09so8902197b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514519; x=1756119319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CIznuZ7T7PsTVuExPL1E/1VfmJgJv6V7rfdbbABcMss=;
        b=OF7IOqebzp4B/GdXZ7M1on4q3vS95oCZIPQyeP9vzsfKvOXXTQb6i/ZFf92kSP6pna
         DPAgDVa38F0n2TTyn1RfGhN/NlrSfKaBOludYR2Po4dGuXqlFjk21G/9hUsDogW0oSS3
         stFgmfEWo2omNgMv4oRuWZikMsBo0UVPlqsUvNsakSdbqiwtNJCwgEnR8j8vTiGhYVNy
         BRSWMCp/P2HArk3rKfH24DeuPvfW2nD/rKUai0jtBsW/aaVEt0SwnDIDLKIJtpKTO/mG
         cqbC50rIB4uTBGl0AmL/d0ESaFGZUhpn2p/HtdBvH6t0X2umtTadoOxnjKlYjtL1OiZ2
         h8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514519; x=1756119319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIznuZ7T7PsTVuExPL1E/1VfmJgJv6V7rfdbbABcMss=;
        b=DGUNVVAyrCAlVuF9pJS3jiS7ZbeNgq6Wu14c0L+oq9d+Z3lvDZAfVfcp+KtUr6AFvo
         TC56TY/uvso2NQsG8XCakq0HM9X3CjhiH4VPd9xOSFOR2/zhHJtLHGo2mtect+Xoq9jY
         IyqxdkO0ZfXcyUcFm8eXafc2uN80XbvvLd1B4YPikZFEdthOH80T+YVZGuR6wtrbfZ6m
         6+23I7srC5alu7w3QZK+1e0qguEPJpxfjIp8rShMlesx62EJXdnaRIY2/viiBEVOSMLQ
         q6W67hY5pE6DXPXJvEqhtnJ/Z8OxuL7rSdph4dNNmfRFqD7FbYaIG6teyjAxsfjffnv+
         x6DA==
X-Forwarded-Encrypted: i=1; AJvYcCXmkTqz6dqWetzY91zXTPL/Wqn3C28GOL1YHewFyEf/KMY46HoOUxmTLnQrMPbfXBeDvXnKix7kS8bxKQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj05WHrL/eFC4CvQUnMMmaQfB1pwQkVAxat/bU8NzEGSNyDDcn
	dCxwXzCWE4heaYhRTHO+2JqnZAc9BRNfppc7Y8geJKU7dbStmNlrSyCJf09u6tnop9z5+eC5wNd
	pQ/MaiALDaL9QB3oOlNHFpQef7HF80LqnyNRHpOchOw==
X-Gm-Gg: ASbGncudGLkwdqT+WCxS5752bBFD1IbRLErQh5qf5ArZB6ycyp8PHdmqSmxAtFKcC0p
	1zKTvVgwWkSOQWHif9Tu24Fy3BkH6qBRezA0DTKqSYa8uVTQJutQpLy1SIPInwsLwIZwmP6St3z
	x/ZYYibUrPKr7eexLK6waJV4rzOk5AupLawRCU0L82Oy6heVP8EN2xUob1M7QpuNZBv2klBq8es
	+kpIcWP
X-Google-Smtp-Source: AGHT+IH66Dj8WNKlffsTjeVMHpVPRufHU47TKI73ywlHa/Ok4uJvh4KyxWFO4feX4WNsCgPnN/DCJXQlKj8LP+ouHSM=
X-Received: by 2002:a05:690c:680b:b0:71b:6950:c6cc with SMTP id
 00721157ae682-71e6de26037mr157669637b3.35.1755514518726; Mon, 18 Aug 2025
 03:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725060152.262094-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20250725060152.262094-1-alexander.stein@ew.tq-group.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:54:42 +0200
X-Gm-Features: Ac12FXygjZDpxgBwolikr0do3iLHNX20_TzBAu8skyfNiyVUVQRmQ-7AdMiWBKk
Message-ID: <CAPDyKFoWF4G-T72Hhb4_VDvHzTWebpFwq7o5LDH421_VUQnkPA@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: mmc: fsl,esdhc: Add explicit reference
 to mmc-controller-common
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Jul 2025 at 08:02, Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Even though it is referenced by mmc/mmc-controller.yaml it still raises
> the warning:
>   esdhc@1560000 (fsl,ls1021a-esdhc): Unevaluated properties are not allowed ('bus-width' was unexpected)
>
> Adding an explicit reference fixes this.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> I don't know if this is a tooling problem or whatever. I would have
> expected that mmc-controller-common.yaml is added via
> mmc-controller.yaml. But apparently this is missing resulting in the
> given warning. Hence adding the reference
>
>  Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
> index 62087cf920df8..f45e592901e24 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
> @@ -90,6 +90,7 @@ required:
>
>  allOf:
>    - $ref: sdhci-common.yaml#
> +  - $ref: mmc-controller-common.yaml#
>
>  unevaluatedProperties: false
>
> --
> 2.43.0
>

