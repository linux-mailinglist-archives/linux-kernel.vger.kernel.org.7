Return-Path: <linux-kernel+bounces-829190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDE5B967DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3016F174712
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B082561AB;
	Tue, 23 Sep 2025 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZmfPz7/"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492591F5846
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639817; cv=none; b=sPSp0cwiBMUfASLbCagiivT6FoDL6s04B+ZcITU5VIMTTEM3juSnexLylW8fefsRghiKBVpiQ4OnlJJMeUVOdYYgcOij9Id3CG/HRnpIzs7pL1lR0YeMeM4iE02VXteLJGZxOlvrHRtar0sqJcRA4vHzGxNp0pSu3gHBEh+3+pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639817; c=relaxed/simple;
	bh=zQWTB2d0cJCKk/rrYKC1U8EECVIHzoagaVY6jLMFFHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+y8gjlx5LDvM5vLzCpivgeBfgdyhUpO22OkUzKKbyAntnV70o7OfsqdBNPeI9Pe000ewCBx7CCu4YEEW8WR/3/m5zO+VgY4C/w3o87MNb2NDC0Bk/PrgGwAIIxGed1rmtJo2Z4+trv9guNF+ipNkjXvZLwzWEb67ifAhPveOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kZmfPz7/; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d6051aeafso41954537b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758639814; x=1759244614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YcYie2cAKkOnUbqZ9iZ6V6CL9Gzada5AicC5iMnOBfQ=;
        b=kZmfPz7/HQXut4TJzw4U3NWVWbx1fM6XXw+IJJ8ctWBwE3XuHgZtHAkC8msht1tc9m
         Bd3kjcm07VwstT4oVs/f0wS+TxTwv16a7UGwRLTGQaCNMyI2l2bm6Q34mtSSiCGFIO6s
         ft6/YfVwiymdv/AeB3JSZ6MsFbvgv7JFzx5jHjR/sMRL0jigA22H2ICVXUcR1nx/y7Fd
         u8WFX47mfiix1j833Jhawu2LVBBiWsch+nJq7ljasSYjpb/iEurRc551YM07VWbVT/Lj
         Y1dFqSvyKtEnM/QhEModt8dlvxXtcJcYr4MdmKW1CRagKvHZ34MlkHCc1We8nHj+mASO
         2Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758639814; x=1759244614;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcYie2cAKkOnUbqZ9iZ6V6CL9Gzada5AicC5iMnOBfQ=;
        b=BAmavIneKRzfPlW+g1QVDJx8jRyIzTiE1sJ56HU3kMzQ5eBcuLkcU2aZjIDf5O1cja
         KKbL33e74zCRRJI8xYKMEXAWDnoNDlywm1SOwtVLrsJmtqcFwPc+Nz4iatrOtGyZTDs6
         QZjPUO7enM4BHIXhpU57WQgE+rVhGI6itSPo13jaRmH9AsrZFrPBi7YOEGauIpysPKGk
         qgD490ObUDF0I7wzowl1IFE3K+1cEL8ESM6sBecOgHNJ9e7BLxj2inu8JcNW1icszg/2
         ST6YLW+gBciQ1pm5m+KU2KUgktXrz04FZMwL1XN9a2jsVI6CwdgAYI/RuKoYFmMPsj94
         SA1g==
X-Forwarded-Encrypted: i=1; AJvYcCX2QTU+PXRDKC2TL3zkqWdEje3OFsWOHFWRzn/8AqUnXsCIM+5qaddTe9JvI5JmIfF23V2CbQCp6LVIlKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO0db5bBCx5qloxhJ7mU5vcL+86ZvyLfQauhahMwantchTBWOw
	hto9EnCfJqw/h7+rPgCEOSFXmS+J3Z+vb7bBYuokiHH6pD+CdYrrX6rCMROEnX5zDQPNfDpA8is
	o1mmZWEEdvQ1nE79dwirBnBY38EecoQOEU7SmXf/ltw==
X-Gm-Gg: ASbGncuPnnA+EsiaY5PSlT4fFvZFWtEbW3/+vcLb9PkMHKzFRMmK988bpuHOwTMUlr7
	TfJ2PUYAsJ0H7a3ZDaAgFNPSwm4WlaVS3X+6UkLSKeubwViOVJNOJMElzOitJbBozwhd9IkDB5H
	0MYFwSkxG6/ziW6x5BTj7SKTjaiogl8QtFJkH6CwTCXEeElxGe9CU31EpkHUY4czegMWNG2bCAS
	TrKyO4RCuJ/gmGmge1lw/hi6dU=
X-Google-Smtp-Source: AGHT+IFHn90x28JHbA7vjSDiwfdoTTPXMbOARP3I17KAJBJ/rJ5XITQcCBtsYmuIRAiIfgX1fgiiGgjUyy0jEa80iZ4=
X-Received: by 2002:a05:690c:6c91:b0:725:1bc6:7cae with SMTP id
 00721157ae682-758a43264a8mr27454997b3.41.1758639813938; Tue, 23 Sep 2025
 08:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914131848.2622817-1-ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20250914131848.2622817-1-ivo.ivanov.ivanov1@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 23 Sep 2025 17:02:58 +0200
X-Gm-Features: AS18NWARyvKgXOeXvo9XZeI4u88VSQ5LHm-6zhc4kVML80ebLhJCorioq3hgWH0
Message-ID: <CAPDyKFq9F6u5+aT_CkRG7rcOLrRWv-9wfw8tcT+w72kB8QVwAw@mail.gmail.com>
Subject: Re: [PATCH v1] dt-bindings: mmc: samsung,exynos-dw-mshc: add specific
 compatible for exynos8890
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Conor Dooley <conor+dt@kernel.org>, 
	Jaehoon Chung <jh80.chung@samsung.com>, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Sept 2025 at 15:18, Ivaylo Ivanov
<ivo.ivanov.ivanov1@gmail.com> wrote:
>
> Add samsung,exynos8890-dw-mshc-smu specific compatible to the bindings
> documentation. Since Samsung, as usual, likes reusing devices from older
> designs, use the samsung,exynos7-dw-mshc-smu compatible.
>
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml          | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> index e8bd49d46..27c4060f2 100644
> --- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> @@ -31,6 +31,7 @@ properties:
>                - samsung,exynos5433-dw-mshc-smu
>                - samsung,exynos7885-dw-mshc-smu
>                - samsung,exynos850-dw-mshc-smu
> +              - samsung,exynos8890-dw-mshc-smu
>                - samsung,exynos8895-dw-mshc-smu
>            - const: samsung,exynos7-dw-mshc-smu
>
> --
> 2.43.0
>

