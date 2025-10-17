Return-Path: <linux-kernel+bounces-858094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15650BE8DD2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68464040F2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4CF369985;
	Fri, 17 Oct 2025 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OW6YrPiI"
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBAA3570DF
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707868; cv=none; b=kZg+0Kv7whZt3FamPzHMUKO1LKUJYmYRbsfn7ASafvIQtlPNt7e1zX9jI+2mPbnSod+Jg5HqaUyMOLuzpxwYj4+cb13o+luC7K9jiKBGQWnkQ/c+uBYPAKbtTGFKJjfhULROY4ytRQu3OeO+0ddhZqTLMGZ4s/65abv+3AmPUJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707868; c=relaxed/simple;
	bh=dE9/ua2G+yDuGUrL76DK4p0HBiiblfdcYkaY/cxGS8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIjjFYZpmZ6/mPgnoQuFSNufT0KDzq1sq2oKWPMdbyehzxU+anXL7GKFg8XC6nYvy5VfhX7/dWYEXyxVandei+g1GpcHrc/JB++342ZMA2dBfhcbMHqByzwhlMR9vpVV1wmzkD8o0W6Q6YYQGqnUlX3PiLfJm+Hq6/r+IsCdwto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OW6YrPiI; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63bcfcb800aso2139440d50.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760707865; x=1761312665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f1HM0d52xL5++z1kGRjypoT65pMC3vnmCE9M/Z2HtkI=;
        b=OW6YrPiI8mXZzqqXJt3uJxufH6bnjTxOMFucnUji6RStU8NHoxAzwjcPK4FYI3IRo5
         5N71rh6FfaHLxLTteOMJpfQgVfoeaFoLigIVCYbrk9+89wooLtXjjAZkmW+T1/7z9gdQ
         JvKztkTF3sC5FN0wTfryrXCpoc42XClvMn1LtsmvqBIRVoZn6YJOHXiQW+LBTQAd53qv
         V/gPoY/0L9+tAnXZ8icBL1DRZ//5Gl7R5tXKCHCVACKNQ0p3Hj4sl/42XanyKYsi+duZ
         SRgvMwSf8tazfXfIeGWAlh+khPbu2wjRKyZc5qyyGEtu6YdQQvF/9jEubkgbjDNJxYiB
         FzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760707865; x=1761312665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1HM0d52xL5++z1kGRjypoT65pMC3vnmCE9M/Z2HtkI=;
        b=MOkvzId51T7o4VtRoLQN9rMnQKZ45o4rWWNxbUguY+iIPTO6qdQ3exolwc3Fqkz1HP
         lNo/gVrwz7U2NOQuBj3p1Q5Yxim0c6VkQdqazr+i4VT5vaBYxypWAniDmhoVzMRXjEyZ
         UK0fx79+vENo+NrlvGGhkSMFnXBBvkTBIKba81fCFxoVWPjzVBZsED5LVOcPdnJtcE20
         vW113UxhsXxde/TIzvk4+6vOeirIGKfHrNSqTRh6RFyt1GpOXbEeR9cOiaMdBbqrR/Rs
         G9b/g6DoJswilg2+ZK5Aq12I2e+zAajAJSQkWXJmKd3xglQykFhwXqisDqw4ooVLiHTE
         Li8w==
X-Forwarded-Encrypted: i=1; AJvYcCW+9Oejp3ZA4HcJg/DIrFfgw1P/w9xCV82hvXgiV9pp+/9JDP9mlEt602m2bctais1NA5e6Y+uXU/F6te4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBd109lwKEqt4ceA5Q+Qx36nsWYJAYifjtBxYS4uqqijvK6TcX
	syJfs+pFA99vZOIE79yzp6QvT2oqRfzY4bjaY5N7VaY+TuKUHSi4p4W96IXFkchxQOeMgxpTZxz
	GQMMYlA7H3FeADqLuQ16KaGHztLSrXLIY69KAhrVi2Q==
X-Gm-Gg: ASbGncv8WL5Y278gXg9Eqf9Qa7kOplDt9vYBJBVFL4hMQJG0QB1oqMvp6kGSdOQ8fej
	Eva0/USOqVte3YiefJhIw4kWaqE/hNbU8HCpBduapwnHNT+qYzdjPhWpK5qKol99fBBJw3niCR9
	dB30rFAOrd3e3uEK4qmWtlLQXrz4qzpevuLHistPyYNkd5jmQMsy2VGmyhpkTHA9VmSsUqxnA9t
	OPAyLSdnBA0z1Qflgvzxb1+8sKI/Phi8B/fI3kIBPJNCjHxLvYwgIAwAmizNQ==
X-Google-Smtp-Source: AGHT+IE/y08spNfC3C2r2brNPGUt04U9WD7A7XI9X/3WcTMgc7vwP8JOHw/hjXOaZRx6V9A4RKsRRr1cMaZ80YFieN4=
X-Received: by 2002:a53:acd8:0:10b0:633:ac51:9823 with SMTP id
 956f58d0204a3-63e160e3c31mr3275386d50.2.1760707864737; Fri, 17 Oct 2025
 06:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007054445.4096630-1-sarthak.garg@oss.qualcomm.com> <20251007054445.4096630-2-sarthak.garg@oss.qualcomm.com>
In-Reply-To: <20251007054445.4096630-2-sarthak.garg@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Oct 2025 15:30:29 +0200
X-Gm-Features: AS18NWAnMhRpcm4So5FqnrddWjLlUpGh3rZ6MGn4VSylaqx5Qy76TzuXLh5A2eU
Message-ID: <CAPDyKFpaza_wXUhkD44Jxh5MUGribDy6d=Wf+NNRO=B_cUBm1A@mail.gmail.com>
Subject: Re: [PATCH V1 1/3] dt-bindings: mmc: sdhci-msm: Add sm8750 compatible
To: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_nguyenb@quicinc.com, 
	quic_rampraka@quicinc.com, quic_pragalla@quicinc.com, 
	quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 07:45, Sarthak Garg <sarthak.garg@oss.qualcomm.com> wrote:
>
> Document the compatible string for the SDHCI controller on the
> sm8750 platform.
>
> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 594bd174ff21..027011223368 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -70,6 +70,7 @@ properties:
>                - qcom,sm8450-sdhci
>                - qcom,sm8550-sdhci
>                - qcom,sm8650-sdhci
> +              - qcom,sm8750-sdhci
>                - qcom,x1e80100-sdhci
>            - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
>
> --
> 2.34.1
>

