Return-Path: <linux-kernel+bounces-824318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 667EDB88A56
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305D3162E98
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFAC1A5BBC;
	Fri, 19 Sep 2025 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="xE2vwJN9"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CB572634
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275365; cv=none; b=HPCgL6p4eNE7Ha12kGF7RBKorMQsHZLR4tBISd/RSNb2UCvDd4kehmNVPGxhQOdgCvzyBbEBYm46F+86zDZCOg0XkH5EXDK0/UsN689wmwIjAvB+NpIhKargwF+AwcLP5weWskiiOwseOMF1NqdvpkqfHvYHGMQgVUpWwaDrQic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275365; c=relaxed/simple;
	bh=Tz2BYFvF/M11ZKfSqaimmGgmE3eUTJYVaFA8dA+tDN4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uQNw7JEpZNvaZhte3WZ05CwS3znz1aYtDPHPLUlobc7vmhPmVuwaA8FRpIYo9PUht4GyDT6J51msnNNiIsS0igwspoEhAfHY8LUGYxgn8bQVyjovcVpPRMK1sPN4a8t6vPu6SewK4k4dVMZlj6dyZNwf5l5gPO6Y7ULq4VTlrDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=xE2vwJN9; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b042cc3954fso351085666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1758275362; x=1758880162; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF+fr97ZY8gnHTqJgWFCrdHRcSxw9tzCQyJHijmyQXA=;
        b=xE2vwJN95mzyOnC4ZTWV9laCOyOgDXALTW4Ju5t4ko0uYUIb+zqCaiTtOgB1K6qHB8
         IEMj5rHwV9JWQPg3FjvudGXjmU3qLOVgvx4TStrLDAUabmdYW0Z0THb9idND5yR3xGm/
         YvMxXgKgDXpF02D8n+avVYJ60nyi48ZK5+kKb9JYQtTMtDNrWBMG4nk0gY26gLNUxnZX
         UCE9MqU4MNaiNkHVXsiSVQI8z1FNK6TskgFVIwdhqUSZB/y1LBKGoWfo8AgQeRwFPAKX
         iU/Ay8ydvAm3WRR1hI4vPizEXX5b+Sj1hxv2ex99uAySEApJHvXMS2kRh8PSuD1ugjKR
         Auqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275362; x=1758880162;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bF+fr97ZY8gnHTqJgWFCrdHRcSxw9tzCQyJHijmyQXA=;
        b=rmkTUB6WlFfVmnZqVtie3X2AUNgf66PdYC5pxJh9muX0+Aujw1BkKf1njhw0mL0TsC
         4XK/uOesW0gUnAJvWtssEkUm2hEOnOyGO3bZ/tomTrWUp47p9/qTkXFgXeyaBU9gvm2z
         0ISr0+3rTl49pS94qLkZ+wby0dKL6iReZfVEV55zMztUdGykcAHBOmIj3TJOLzYqZ+yQ
         u+jrAfu7yoi0Rghg48xgSvcyN0gbZPf1n1Oqg7Oe0HYmCyfQro1Voz0si0yxQE/GT8g2
         EVpW2tB2IMlncyT72eJXtXfDS0mfPEMku80MP6dEz/fEqHSmUkJ5R8wJkPeIwSC22zXt
         W2wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvWPfnjOgJt+EtsgOyKk0pr6OKduJRCKISwLDcjYIF0FTycgsGV4l6dhy5BDJwjCGblYZJzplMsdF27ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9aXjmstuSf8/aildBDFFG80SHdK/Rfqi26MCELulQB963naXH
	BHneuj7MUP7cRJdkduK76nZPBRb75xyxOM4UGiX6HqAPcyN0cf0/Wn/lL4ZLm1CF8Ak=
X-Gm-Gg: ASbGncu1OBQaaB88jNrymuZ/bMpOvS+0e4nqmqE/ZRhmm8Z5n/f/v2YcXEXE5SqxscU
	K8EYUrOjhzT6OH9MaFzLtyW2v6VvXS3JpIs4RcWVVANDFoWXRM++t5aDrc0D3txAk0Tqduevgn3
	S144am1pNiyR+2XIyMwHAX9UpFdctPfAbnDVpONSyvJzVRMVIuCaW/YCc8k9vC0wrLxXf3EAJkh
	AfqTUQn7nwQepxAPosWa1uGRjv3lcwhdTWzZ4oDZ4q060vd+4tbprnwAYaJKmCzf7O/1ICt4fmJ
	c2WYdLksNFzwWml81/TR0nyNxRF7gjnuW6QR8n188h9eC1NAczIjAjIS8irJFc2WPYC7C4V43iD
	wSKK2dL/g24B701CkViEPM0jyno3XmRzM/QTFibrTZsxJl0wsBy5/4B+s1A24jaVvPaet
X-Google-Smtp-Source: AGHT+IEFBu6jYd3DaMItgC8kjB1GxQEyOVsDZz2UShssNFNRiR0gE56ikyqcHlsjZ4qckWKtQlZbDg==
X-Received: by 2002:a17:907:7292:b0:b0c:4ff9:5c77 with SMTP id a640c23a62f3a-b24f6f91688mr289081966b.54.1758275361898;
        Fri, 19 Sep 2025 02:49:21 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b26e36ae75dsm15882366b.8.2025.09.19.02.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 02:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Sep 2025 11:49:20 +0200
Message-Id: <DCWOLHPCYG3X.32KTGBE4SYMDV@fairphone.com>
Cc: "Vincent Knecht" <vincent.knecht@mailoo.org>, "Bryan O'Donoghue"
 <bryan.odonoghue@linaro.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: msm8916: Add missing MDSS reset
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Stephan Gerhold" <stephan.gerhold@linaro.org>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250915-msm8916-resets-v1-0-a5c705df0c45@linaro.org>
 <20250915-msm8916-resets-v1-1-a5c705df0c45@linaro.org>
In-Reply-To: <20250915-msm8916-resets-v1-1-a5c705df0c45@linaro.org>

Hi Stephan,

On Mon Sep 15, 2025 at 3:28 PM CEST, Stephan Gerhold wrote:
> On most MSM8916 devices (aside from the DragonBoard 410c), the bootloader
> already initializes the display to show the boot splash screen. In this
> situation, MDSS is already configured and left running when starting Linu=
x.
> To avoid side effects from the bootloader configuration, the MDSS reset c=
an
> be specified in the device tree to start again with a clean hardware stat=
e.
>
> The reset for MDSS is currently missing in msm8916.dtsi, which causes
> errors when the MDSS driver tries to re-initialize the registers:
>
>  dsi_err_worker: status=3D6
>  dsi_err_worker: status=3D6
>  dsi_err_worker: status=3D6
>  ...
>
> It turns out that we have always indirectly worked around this by buildin=
g
> the MDSS driver as a module. Before v6.17, the power domain was temporari=
ly
> turned off until the module was loaded, long enough to clear the register
> contents. In v6.17, power domains are not turned off during boot until
> sync_state() happens, so this is no longer working. Even before v6.17 thi=
s
> resulted in broken behavior, but notably only when the MDSS driver was
> built-in instead of a module.

Do you have a link to the patch that causes this behavior? I've tried
looking through the git log for drivers/gpu/drm/msm/ but couldn't find
anything that looks relevant.

FWIW a similar change to this was also necessary for sc7280 (as done by
Bjorn) and for sm6350 (will send the patches very soon).

And happily enough for me, with v6.17 and that reset, a long-standing
issue on sm7225-fairphone-fp4 has been resolved that the display init
seems to somehow fail the first time after bootup, with the screen
needing to be turned off once and back on to work. I traced this back
to some power domain behavior as well back then.

> "mdss_gdsc needs to be off before mdss/dpu probe, this can happen with
> genpd_power_off_unused but not guaranteed"

Anyways, I'm hoping this is not just a coincidence it works now but
will stay working on my device. Just the reset in the past didn't seem
to affect anything.

Regards
Luca

>
> Cc: stable@vger.kernel.org
> Fixes: 305410ffd1b2 ("arm64: dts: msm8916: Add display support")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/=
qcom/msm8916.dtsi
> index b50c7e6e0bfcd35ab4f8b84aeabe214fd60e8d7c..de0c10b54c86c7795b7a0d1ec=
d80652e60e117b6 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -1562,6 +1562,8 @@ mdss: display-subsystem@1a00000 {
> =20
>  			interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> =20
> +			resets =3D <&gcc GCC_MDSS_BCR>;
> +
>  			interrupt-controller;
>  			#interrupt-cells =3D <1>;
> =20


