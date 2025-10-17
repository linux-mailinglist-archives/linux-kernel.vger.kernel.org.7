Return-Path: <linux-kernel+bounces-858091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01525BE8DA0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F018C3B12D9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E680A3570B0;
	Fri, 17 Oct 2025 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCcbaEbt"
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C493533033E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707856; cv=none; b=n4ARo6aUu5wHxc42WpfyDelPIIsrofqn5YJpl0oZBPjxvAgW4Rrh8NU9ssRX6kab2ymkVT9zQFAF3XJ6RQpxVdItDM/q5cgLoqBb3lU1jPypgu3pTrDougvfwa+tYQQTn5zLeT3/I3Gr18R9JaBQ1YQ2ifEsjlf43qbGZl4d69M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707856; c=relaxed/simple;
	bh=8h4MyfofRRgMJU0FH6oAiG30tlFhnJzpo3CvUEr0yL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFZu4xx1QCPkihg44MFVht6J0E/vz51oLqRv3sXLDfhfa/dwWRmHVjbJZxZUvFp750/UimaG0Sldo47e8A0/Pr1ITJ9DD/vvlR2dQbidspUKO/IpYTvFAsd7Z4hM7HSpgEhSOWrQVBEyJSDnaCUsGLt18l0/+FaUHRwu+LvD9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sCcbaEbt; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63d97bcb898so2557198d50.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760707854; x=1761312654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5X7BQeA3rXzmBQbgRKoHIxB7KAjrjMKVEn539LLi6sA=;
        b=sCcbaEbt1EaYifDeeqmx8bRhf4wd2X+XbTj9yzsoLq90Hd23tHHw0ja/Rb23OTTD8w
         epkAXbw48CQU+V7LVOZ0ii3v0uQ9dLoC6IQXX0gJcC8nNqy2DpUEDIESo1291S0KlcGd
         OsBVpK0J5xX4J77q6MUH5FE6zHA/nFHcFwwQZBsoINgy5ifeNW78FJFlEsD6xEmejVkH
         G3hCzpF+zlAHtzjgdiNB8dCumx50NB7b1LLbCuvHFM0TbKl2jwCuv1ZulTcKnuVoP7gH
         C9mSSZPZPs9zsYrTkhL4eYiyhBykY6gilBOWJhKlbMsgYlzoxU877JjlUSQszcCNf92R
         2MXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760707854; x=1761312654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5X7BQeA3rXzmBQbgRKoHIxB7KAjrjMKVEn539LLi6sA=;
        b=i8ln9mdnitwaRKVaeurVWv90myRJXGmutISj70VvuYGp/pcJ+D7VeMUzQYMN1jwyJY
         Oxo0tBoc9kLuKwz+9wj5i6ZmrXHCBscltiL2/6NaNlsydKFIGbhWSiU9nzjtbGtyeABO
         szEjveaQya6VAa+fSPTK19cpOGBw+SuRBLyNV9Hk8IuuL1zj16TqZkVNyvCjb2sEpW76
         ndPmGly5DEejSheqwFVw4LCM+QIHv0NYYH9JJMFKnXHxfzDhzeG+FsOhxcKdwmzVcDC7
         SSkHIQpixI1AtOaEJ7ijzJGxZlJtLatoLPd3tmrzv8WQMU3d00U/4PIPHw6kPTPoEsYB
         g0YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjlq8GrrAeGRzS3DQoIepCN6wB1/+3P4KMeFwCKuHJpLsgA0nIvhkRdM/iBg68XUoHJwav04ErvWvfPkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw04dWUGAlDGgOwMJoPGYqNV+aEXG/bX/3XZzT381tmeRcU9DlT
	nJfR66P4lUXHvs18vrpDUorCcDNpDlFmml+ZYUmFdV2UizVm6ja9btTHKHM55xBjqs+VQo2X+xI
	IcEkLd49xsitprSowbd2ls2R7mmAHJC7yqY2rzU8jyw==
X-Gm-Gg: ASbGncslcKhe3kZjtKP3EX8lQb3HOFrYATUKTUnFMrEhuCwgUWluhaj9/quKqXEpkMn
	leT+DONJcHZfX/FlIq17OPeBti4RMJAGW7828yuQFk+JBrxW+oePG6L0cWpz0c1cd81KPEmi1xz
	milN1K5GCf3cmsX4vK67q9W+d/4jilIlLBlrW5O2rPiOzte3AULLAjXg1GnYdjViT3Uie8pcV5n
	Kqm28baLyocSwXYFS3TEgKBSR7guf109OwF6mKY4XWdfpJ7qtJqwwjWo6qDJHEtpVzgjfkZ
X-Google-Smtp-Source: AGHT+IFuJjjPUeond6ve2TsWvJpxprVjAj4k4yWkaW70iusJk/wVdKJ5/E78uqC6hlFI+4D6JFSKhgGZ3fDtx8Pb1ws=
X-Received: by 2002:a05:690e:4182:b0:633:a6fa:386b with SMTP id
 956f58d0204a3-63e1617888amr2411139d50.9.1760707853775; Fri, 17 Oct 2025
 06:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-knp-sdcard-v1-1-fc54940066f1@oss.qualcomm.com>
In-Reply-To: <20250924-knp-sdcard-v1-1-fc54940066f1@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Oct 2025 15:30:16 +0200
X-Gm-Features: AS18NWDaJ0stRMP0tjdx1D-OEVihvanFSmIUNXsykH9atcloWEZNEl8Qe24908I
Message-ID: <CAPDyKFqMYyo5i2ZVU8SBrD=gbGZMZiwYuOC+MWD0r34UMeNizw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-msm: Add Kaanapali compatible
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com, 
	trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com, 
	Manish Pandey <manish.pandey@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 01:34, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:
>
> From: Manish Pandey <manish.pandey@oss.qualcomm.com>
>
> Document the compatible string for the SDHCI controller on the
> Kaanapali platform.
>
> Signed-off-by: Manish Pandey <manish.pandey@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 594bd174ff21..474afc98c8f6 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -42,6 +42,7 @@ properties:
>                - qcom,ipq5424-sdhci
>                - qcom,ipq6018-sdhci
>                - qcom,ipq9574-sdhci
> +              - qcom,kaanapali-sdhci
>                - qcom,milos-sdhci
>                - qcom,qcm2290-sdhci
>                - qcom,qcs404-sdhci
>
> ---
> base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
> change-id: 20250917-knp-sdcard-772e77cae9d2
>
> Best regards,
> --
> Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>

