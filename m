Return-Path: <linux-kernel+bounces-843676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A0EBBFF8C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E65634E17F3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7EA1A314F;
	Tue,  7 Oct 2025 01:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffDmzFJZ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF11C183CA6
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 01:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759801197; cv=none; b=mzLKyA1OLNh2rjnshPu7df01e1XcFiwsGyF7e3fdAX2PM+x1ni5vv9ytu9h2750V9rbPYk4UOGGNTZKdN+8eLeViHARi+YhnZ/nPRHTpJ5ijzMm69ZzCUEuc5B36nSKHJZ3VzGK/6xu543R43lQaDoLam2yh9oYw8jo7pmM82sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759801197; c=relaxed/simple;
	bh=5lqV+ylLnxxR7eQ8mxijlK2NAS5BbPFc0/15e/s8/Ek=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=XVfrj+cOkjMMBtHEx7HWAOUOlOrotnrzEHgyLgXMkhwHujtLpgUBzN49yrMeSEdJn5AuCts9fewYFBkDwj5sASU6MUXaYPlGeFpNsgW6hh/pPUHFl3LlksQMk8Y/XD+4Si5s/l5YD10LYO8xDirsV46f4KanwtQ0FJ196BW5ft8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ffDmzFJZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so54098365e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 18:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759801193; x=1760405993; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWIdECDUUCC2Ce9mQHFr9kZj1FU8R9Q+u4LBmUETnoM=;
        b=ffDmzFJZpsqaunT/rSovqUptN3bRNy87l7BLJXXZ7FaaOkrr1oL3P5tdHane82QkjG
         FnXVf+lmNDSfr/md+TZMYgQ/hJ/UOk/b7a8xA5TF5BP4qbUmdMcnoYPpmTham/uGSZ6o
         P7FBZWmEAq0KZxCvDgAAamacmcWgJQrxpGDIFJpzlApFyc8qufy3cdvV2HWBx4gg+0ug
         GQnRMbNZua3d1Yn0/aL4L4iYykN0wRcPiuDDffXMobFQIb1AgJduZIIW7Mr4p4ST8Zdd
         CkHXBEjZ8+ruavk0m5/7UCemnyhsPS1w3/1VHJihIV1o+/3Jjdwqf4rd8f+XSKiavBvR
         ZEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759801193; x=1760405993;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oWIdECDUUCC2Ce9mQHFr9kZj1FU8R9Q+u4LBmUETnoM=;
        b=ootGSCOqjEJnaUAWTKdTReiqi5olWRf9+Q0zRB8UU/Za7QslFogBGxzxSLlP4D3+du
         vNDpOehEfRfCTF0/LYyqMx4HJ+Ot9FpI1AkClCfbrbjMO5utaEAmEPHTA/bd9FOXiUNl
         9KkJR3z68d6hFLS8K/IKsMegQoBwMTK3UFyd5SRdVtAS7L9puaHzj/jVzfATfuM/Huvl
         zyTSONNq6Ixujxu5QNq3tEDXjiu/5fLAdbjb4ceALvSB37VZyg9CMwKz9sBCn59UofDx
         wNnqMgdNSeMdRxZBmJOlYmYiY3ZAIBIn378JZtxkOHEBgSvyth3x+0EQiOn5DiXRzW7b
         gGeA==
X-Forwarded-Encrypted: i=1; AJvYcCVvRH7WNHonkfccI6NJVYXD2FVhbX0CuxmyPunc7BySCwlE5GaxtiC0sYPuPZyyvjHq13How4igc3ZkBPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0RrS4xxRKayLTwztH/rsGAwlKt8S46IvOgHO7AzpBwLvb082I
	iiYb/8OfhepxS8fiYyuQtJ+pcR8dwcAjscIfHXCQlJsxCJO/IIooQTbfh0oSrlaK1lg=
X-Gm-Gg: ASbGnctlGpuEoc/DjSMvoHgCMzjiyzTA9sHhrgLE3gBEv7+FT0ui2je2KY6wYAuNEaM
	uKoKR+isopTcq1SIIHF+dYL+/bI+whapjJjtZsgDSNTu12reMX7MjrNzgQUZlYo4Peolnpeyok8
	IKY3saK5vyPfqq5s0HS9uk8seWu9qzlwLa0mlHOPg7ZTBh6mpidDVau6e9jBw9B1M98hPZTZDtJ
	ydkYGvCV8rCQPZX8I1vKh+KXzk0xKL55vHC98jvuWzhBR6rUWjAAAruoel/olRnhWhaLS0qzdhM
	gX2iAV3TsJ4H5C+EU/KQGLmdmJnF6aNy05k7tHAQnA+8LHv9Bamsu6SGCZ0revlA601jjlnq3yV
	Z8o2eJx0EccWXTOU15eDk8EtBw8VkelOwwRPIx0BSsC3kuAhasm4BxJGInwyQtw1GSw==
X-Google-Smtp-Source: AGHT+IEP4ZfQ2qXfgkfT08+ifEGZ7mYl7sYutWniRewIAGlV7StrxebqvEk1ShWnLZfyKk8gXlG79w==
X-Received: by 2002:a05:600c:3d90:b0:45f:2bc5:41c3 with SMTP id 5b1f17b1804b1-46e714ac847mr89068835e9.8.1759801193186;
        Mon, 06 Oct 2025 18:39:53 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:22ae:baa0:7d1a:8c1f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a265f6sm277651965e9.20.2025.10.06.18.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 18:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Oct 2025 02:39:50 +0100
Message-Id: <DDBPGIDN8SKS.2GF6TZC6KGXVI@linaro.org>
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Neil Armstrong" <neil.armstrong@linaro.org>, "Srinivas Kandagatla"
 <srini@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown"
 <broonie@kernel.org>, "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai"
 <tiwai@suse.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>
Cc: <linux-sound@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH RFC 4/6] sm8650-hdk: Enable I2S for HDMI
X-Mailer: aerc 0.20.0
References: <20251006-topic-sm8x50-next-hdk-i2s-v1-0-184b15a87e0a@linaro.org> <20251006-topic-sm8x50-next-hdk-i2s-v1-4-184b15a87e0a@linaro.org>
In-Reply-To: <20251006-topic-sm8x50-next-hdk-i2s-v1-4-184b15a87e0a@linaro.org>

On Mon Oct 6, 2025 at 7:37 PM BST, Neil Armstrong wrote:
> Add the necessary nodes to configure the right I2S interface
> to output audio via the DSI HDMI bridge.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650-hdk.dts | 30 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8650.dtsi    | 40 +++++++++++++++++++++++++++=
++++++
>  2 files changed, 70 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dt=
s/qcom/sm8650-hdk.dts
> index 87d7190dc991b11f5d1162aabb693dcadd198c51..1286ce95235d5544322a18772=
92cbdd426298c11 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
> @@ -171,6 +171,19 @@ sound {
>  				"TX SWR_INPUT1", "ADC2_OUTPUT",
>  				"TX SWR_INPUT3", "ADC4_OUTPUT";
> =20
> +		pinctrl-0 =3D <&i2s0_default_state>, <&audio_mclk0_default_state>;
> +		pinctrl-names =3D "default";
> +
> +		clocks =3D <&q6prmcc LPASS_CLK_ID_PRI_MI2S_IBIT LPASS_CLK_ATTRIBUTE_CO=
UPLE_NO>,
> +			 <&q6prmcc LPASS_CLK_ID_MCLK_1 LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +		clock-names =3D "pri-mi2s",
> +			      "pri-mclk";
> +
> +		assigned-clocks =3D <&q6prmcc LPASS_CLK_ID_PRI_MI2S_IBIT LPASS_CLK_ATT=
RIBUTE_COUPLE_NO>,
> +				  <&q6prmcc LPASS_CLK_ID_MCLK_1 LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +		assigned-clock-rates =3D <1536000>,
> +				       <24576000>;
> +
>  		wcd-playback-dai-link {
>  			link-name =3D "WCD Playback";
> =20
> @@ -218,6 +231,22 @@ platform {
>  				sound-dai =3D <&q6apm>;
>  			};
>  		};
> +
> +		pri-mi2s-dai-link {
> +			link-name =3D "Primary MI2S Playback";

Is it HDMI only audio playback or does it have switches to playback it as r=
aw i2s
(when external DAC is needed)?


> +			cpu {
> +				sound-dai =3D <&q6apmbedai PRIMARY_MI2S_RX>;
> +			};
> +
> +			codec {
> +				sound-dai =3D <&lt9611_codec 0>;
> +			};
> +
> +			platform {
> +				sound-dai =3D <&q6apm>;
> +			};
> +		};
>  	};

[..]

Best regards,
Alexey

