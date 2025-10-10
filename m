Return-Path: <linux-kernel+bounces-848212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08451BCCE67
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B61F54F5AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DCF2EFDB6;
	Fri, 10 Oct 2025 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DRZMrdRV"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399702EF665
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760099383; cv=none; b=AfhiOargUpIC+pHM2o5q31PQj/Ppic8eXyp8x7r2E3RPqjG6y8EPYyN38vzAWT/EQgK7aDWY4thkrNqNl+B/qvtHefU4ZadiY/RrUTG/Mg3brtMVQo0qwQz1KhDDRBlVfr9UMTpsJArpCh6VSWLiD39eSunNdAqXD4ympoJ+ROk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760099383; c=relaxed/simple;
	bh=m1wtM/Q36F3ke3zT/mN2EGUWRd5HFQIpRI6HpOMa2zE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=rwjGuR5E/BcudpXDDZJwwHP3UzPYTuoyYissec4HMG+fU9I0Xh002IC0FbJLDZ8GVRecff9fxdWOCQBofprqXpM99BuKWcV11Pxtme5AiW8J2tM93srqJa/I1F53qP0fqeRAkpxe0ZbjMXUE++f4134P4ibKEY7LGeqUuxfPxck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DRZMrdRV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e5980471eso11163595e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760099379; x=1760704179; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYMGQwZbrkqXXfmRn4FZdpSz5oqSucZM1pi40huO1ec=;
        b=DRZMrdRV+Z7AOt2j3NT/pgUP4UzEXdxIMgHs7HJiAigBN8Yr//Fyi5ghKZLVI0KMr3
         vhCnf9VSuH+vryIkrv2rC77HULFvgki0QuED2mD4cExxEc4h6sOCOlofOLHEWg46sCRp
         TGl5nPoI67IHz+TmR/v4ARQo5MlUbtD+aWLjOHCWE9BfM5aht7ia+Cg9j819ea6TVC1o
         czF5uB7FK2+9iFgyoVe+MsvdILYnaANCXdbrKZXzaAgXtUAO9QWymKObPF1Mk/xLsMRB
         wI9JFgvUOf5z3i0PDsOlgmoyFA+o00csP/DY6IYojpg99CeZ0QjSoJtdDu3+vZ5UT+GK
         Rwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760099379; x=1760704179;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vYMGQwZbrkqXXfmRn4FZdpSz5oqSucZM1pi40huO1ec=;
        b=NWlCa9Buic3te/PZntGWnGNQrIPeD7EjHWJQFsQ/Iy9O58qJvfqBPZU5vnhOY7H1qk
         HCqgwzEVdU9GBs9i+o3pwLV0yfqTtkXQkDWnyxubuX2ItZbKuoS+QbkO8/LBxhw9fYnZ
         Iae/YbDJAHe0D7e1T0/IDmF1mkMkMUA10LDiCtygYvyCjiTul9fD+u13WdNcaRTVndTj
         7ns22Rd6Nuk0IyLfapWizPKbiRtp7fCFrp7Y+X07ZCMcg7/43rSKBWq4p3Ph5m8Xbqkz
         e9l3hYe4iZWHcgngpmXLAyNfMtAEXA3EbfsN9v+L1Yx8iJvpCyzcZd9o+rtCuxvLHlP5
         nYUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpFeJHgjo/jQTy6pz6gn/vHFdOx5CZeT6VkUUZYlHqB7tM054HQSviWEVxSp5s93bX4RFCheFghnFZlgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyux5Cm7rbguLMrMKY2KXc8fSz6IgxL5kZFUlcLUk7hVFGbohpR
	1GYMuN+Sh7c13i+7LBrRMqRKlxmSJo8x8oMLngjExR8r52VjhjJgu4FalP57ZByvNok=
X-Gm-Gg: ASbGncvYcFq2jmdt6aG3ebh0y8hVr6/PuzsW4xJzxOPPU6XmnUjXDA0qaSocJfgi0mO
	04XrqY7jFeeXfZnZSVEHs7F7L/d6CqAYOgLihvq0FpCnvmjwxyCmDGWp/JaYakecRjollU385De
	PuPyFC5Qj/D6TDo0kCxX+D6mBoYh1MyyFfv1sBOF2fbJd10lKcSoJZTbdfwQePcHrcJ70oscCLu
	NtHPliN0bklcQqGQJr5JwEbXl++RTBhjrJX4TTPpSAWr1rgcMeyOTef/0/Bmu48bEisiYSxVGZu
	ju8rNnTkoBsjBs5JwaClzmuDtKKQ58yIQXdWdkZ25n9wLKNFe3Y3jtorDLlczvwVdG1poCOIkh0
	MuWpDTtCFP/xcgZfxmHZR1FVLufJObYZb8bFzztXFyAgboHb7CEb+0AofuQPnbdAR5wuiO8M=
X-Google-Smtp-Source: AGHT+IGoFKx9FL3rwMgBVIjzsX+nvkrUpEkSRitHHR0xBr1fRpbwIRCWVFTLZ13CTdC6I1m0m5CVFw==
X-Received: by 2002:a05:600c:34c2:b0:46e:21c8:ad37 with SMTP id 5b1f17b1804b1-46fa9b06d3dmr72900375e9.25.1760099379460;
        Fri, 10 Oct 2025 05:29:39 -0700 (PDT)
Received: from localhost (054722ac.skybroadband.com. [5.71.34.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3e3520sm62462795e9.2.2025.10.10.05.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 05:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Oct 2025 13:29:38 +0100
Message-Id: <DDEN5NSLDIHD.C1IELQW0VOG3@linaro.org>
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Linus Walleij" <linus.walleij@linaro.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Srinivas Kandagatla" <srini@kernel.org>
Cc: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-sound@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: qcm2290: add LPASS LPI pin
 controller
X-Mailer: aerc 0.20.1
References: <20251007-rb1_hdmi_audio-v2-0-821b6a705e4c@linaro.org>
 <20251007-rb1_hdmi_audio-v2-3-821b6a705e4c@linaro.org>
 <b6223af9-2d9e-4ccd-b297-79f63167242b@oss.qualcomm.com>
In-Reply-To: <b6223af9-2d9e-4ccd-b297-79f63167242b@oss.qualcomm.com>

On Tue Oct 7, 2025 at 1:39 PM BST, Konrad Dybcio wrote:
> On 10/7/25 4:03 AM, Alexey Klimov wrote:
>> Add the Low Power Audio SubSystem Low Power Island (LPASS LPI) pin
>> controller device node required for audio subsystem on Qualcomm
>> QRB2210 RB1. QRB2210 is based on qcm2290 which is based on sm6115.
>>=20
>> While at this, also add description of lpi_i2s2 pins (active state)
>> required for audio playback via HDMI/I2S.
>>=20
>> Cc: Srinivas Kandagatla <srini@kernel.org>
>> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
>> ---
>
> [...]
>
>> +			lpi_i2s2_active: lpi-i2s2-active-state {
>> +				data-pins {
>> +					pins =3D "gpio12";
>> +					function =3D "i2s2_data";
>> +					bias-disable;
>> +					drive-strength =3D <8>;
>> +					output-high;
>
> I.. doubt output-high is what you want?

Why? Or is it because of some in-kernel gpiod?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/arm64/boot/dts/qcom/sm4250.dtsi#n66

>> +				};
>> +
>> +				sck-pins {
>> +					pins =3D "gpio10";
>> +					function =3D "i2s2_clk";
>> +					bias-disable;
>> +					drive-strength =3D <8>;
>> +					output-high;
>> +				};
>> +
>> +				ws-pins {
>> +					pins =3D "gpio11";
>
> Please re-sort pin entries by the gpio index
>
> https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-o=
f-nodes

Ok.

Thanks,
Alexey.


