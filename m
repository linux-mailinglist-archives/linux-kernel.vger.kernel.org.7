Return-Path: <linux-kernel+bounces-732063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6D8B061BB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DB65C18E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4B01F91C7;
	Tue, 15 Jul 2025 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W2v2bzED"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1767B21858A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589821; cv=none; b=U4rOMVcHWGpUd+mYpjvhesHL+0OhOHD9h2hvilDaBmzVgl7FHroIuA4/TU6n1NcVwiNye+AxLfCBc4ON/LjIsNqQh6TjqN256wYOsmcGOGXQKK3WvOLR/2PkJvSQZZrqd4CTA6cfCzi66alnqHKN7NfKqWWnnf75IiX/GqOHO5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589821; c=relaxed/simple;
	bh=FdL1/HKNTpO4kdE7n4NKm5VaVSkDlbNs48yc+1QgZas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J75fJzw7qV6AJsUeo3NqY4cmH9jshKGsfqftZwp3zrHbaxcxstpUItpBoz+WaLg+VU9noTnE1yn9FteCyh0IfgHUn8eDB9YjWVI7qmBQEIfLec08JkeX//YVBTUKUVsKRX+F0VlKHG8DXAb22cRZn+Za6q9F4UqRDwN0T61ksiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W2v2bzED; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e64b430daso57026147b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752589817; x=1753194617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4+7Su+tXNXtNlViREf/FpByOQe19DRJ2WhD/byKGrG8=;
        b=W2v2bzED3A9ejC4TfbgBBjzjno/K1PhLK2E7O3e0SPUbLWqTR9Evxz9A+K/rXmm1Gp
         Et22K0hwMJdya3IKeHHsXW3hPwxvGaAhOYHBmyAS8ncFcpUbQerWd0RUW9AbdeTrB6sG
         QOUikyYzPsid/y34PVziDdUyKm1BoNauuudY42lVMegWroSPQOo3Qkr6ygEYUTk7hnPm
         kY02nYoNhhonMX9fIknHS1fRHnqETyvy/jv6p/jTCFbethMcmYb0L5oWZWuzyDkW6sow
         OmLBsjvk6glkP806VpmbDr5DbkxrIKVAvgata5YVlC/7rRECoPR3Rnlb3ulchSSzVxCG
         mZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752589817; x=1753194617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+7Su+tXNXtNlViREf/FpByOQe19DRJ2WhD/byKGrG8=;
        b=W7rpjupxBugGXnsW3MdEbJdXw/F2Rlf3IozDEb1ItuEprXf/1EFm/6Wbg7d1e8TJEx
         t0pFrUJPpGtiYYvsB4ofYSt80ve5bL5HtK3zoZo9iMeieXvoHvULS2GwVTi6nhGVSY9w
         eO2BTbrzWDLIBqYYrC0/sB4FJ4EuWTEFBZ+9CKOqekVD3fGPLZncSReZ+ZAd7fQn+r0d
         bsF5w+o5viLzbDG++Kyk2w+5ciBPA8I4Lfi5PbiXvuKaAdPz5yDC7E+XMz4JytUIdfce
         nTaSfffZ12aoGJCI+yCa/P5BcDpCgrBeTUZOx/xCGFGhoUp3Vw3Os6JoBeSUmKl3BEe6
         FqZw==
X-Forwarded-Encrypted: i=1; AJvYcCWKhLgxqUZGJKGH8TZqOmFNVCPGS/wxLYmEaCGpPEBOcUROVtObT1kaTMaQGyYkEh2WTnWfx98lvwuuGhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXgTgCFa69H9QRf1+iEmz/sdgwKDexAQ/pP/U4lWvj0FSROPc
	Up8PM5RfUbmIWGIF+LeWLvt4a9K3fed7uWbQLvAauEG7kFi2YGejMQDlQ9W6rQ4Q6MuKfBboJGY
	DPNPMJXBtH2GWg6xUHAvSpPoVLxjESxu8h7qB74USQQ==
X-Gm-Gg: ASbGnct2zrVxSOQqC1OSL2yLEHUTycWcyeAtt7TeaFo9iu1WIDNfxbhYKHAqE6nHRQJ
	w+o0wu8+KWwUmjZrI4wNcqVJG1Q/T4pvJDaGUivtbHDAA9feaoR73JwV53v4NkO1asAb/duMZNJ
	Rpfj90yUfzCzGn6GB8fZGcd+wre36EsDuqNd+kXRA68s2w3PLc+KPCiqhAS/tHF11MserXiqRWi
	44tnlWV
X-Google-Smtp-Source: AGHT+IGBzBhoCXe5OGunO7xvl2ZbN7LRPwWWQsLELIyQWERT2XuyowSM7Ti1rVh+eETJFMAPU2ltq9fvUbOvfY7jIrI=
X-Received: by 2002:a05:690c:9:b0:718:2387:4544 with SMTP id
 00721157ae682-71823874737mr49946387b3.12.1752589816638; Tue, 15 Jul 2025
 07:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com> <20250713-sm7635-fp6-initial-v2-10-e8f9a789505b@fairphone.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-10-e8f9a789505b@fairphone.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 15 Jul 2025 16:29:40 +0200
X-Gm-Features: Ac12FXwmHbA2nWRNuYQwrZTMO008mwPCFYz6i2upkNA2qncGOOVsk9AzGvxKlLM
Message-ID: <CAPDyKFo77_0n0SefZ0N3osbSM=0tXW_rsjd9P4WaqoZAwyaTGg@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] dt-bindings: mmc: sdhci-msm: document the Milos
 SDHCI Controller
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 13 Jul 2025 at 10:07, Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> Document the SDHCI Controller on the Milos SoC.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 2b2cbce2458b70b96b98c042109b10ead26e2291..6f3fee4929ea827fd75e59f31527f96b79b2cca8 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -42,6 +42,7 @@ properties:
>                - qcom,ipq5424-sdhci
>                - qcom,ipq6018-sdhci
>                - qcom,ipq9574-sdhci
> +              - qcom,milos-sdhci
>                - qcom,qcm2290-sdhci
>                - qcom,qcs404-sdhci
>                - qcom,qcs615-sdhci
>
> --
> 2.50.1
>

