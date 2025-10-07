Return-Path: <linux-kernel+bounces-844454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95667BC1F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 615EB4EDC2A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B252E62B7;
	Tue,  7 Oct 2025 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xDm5i9zk"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62162E1EEE
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851548; cv=none; b=m02NvJqC0QyKtvnF5dxvPhmzuU9Wc1+HZPXoHmkYDdkhzHKAYVrx4BzxaW8OAi++sx4vkKwGVioAzaPotsSP6hTT4bgLRzeewFLseE9QAho6yB0YLqnexVbLe15vmlwJfzrXSZDCEryGNzmZa15tiVmdz48IkLYVhCxiS84YQu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851548; c=relaxed/simple;
	bh=ai4LGPuL3rEMggixLNvM6kWUprS+X4rTlrv1/oQ6sJ8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=IwUcfN2NJ6TTJVgB6MlQM7BU3wdfSuglTMfxjp0DTMRqQVxxUEHVLxnPcy6tRPpjAqnJ7GiKkibDr69vcGiV246QYlh4k/VQlHjmPhVnm3hwQbwSzuV6QMnvDWGioOYnKoiGycZzmpd5eyhes0rIRUi1sFVpScZYfyZnq5J2Lb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xDm5i9zk; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso10525f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759851543; x=1760456343; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8DX9q0w9bvA3uWv/K5h42L9FfWuzySG8u4E46pyKaU=;
        b=xDm5i9zkOCUoD7QiwqfKRCqDhRV5uv80wOLiF4mrKd8VDiuFsVyyMCO+vn5+LZRzcd
         kZbTmFYeUFD8QZQnnRR2bSSP4fksoQ3DUHdYtJhK/MZKwi/kqYkxS/Ave8QXSNpw8iHX
         HAOi4zLQzqhRloJUzGrNv8T5ps+yz2YQxm64syS1CDh9R2Nny8bDINY+RmC9OADWDX41
         mZOj2zI7U1CvyBrVJ4EWKHVZVVA11uH0rTS+aguSpqBedbYyZJ78pdx98v+C/ENxvexl
         eQJVX9U60k4ZnSRqxZdjSjtKXTOFwmtmDwOZHBRt3DStY3eVb/RPNaLAuidLZEa2cBR2
         lZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759851543; x=1760456343;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k8DX9q0w9bvA3uWv/K5h42L9FfWuzySG8u4E46pyKaU=;
        b=cxDtRU5+VgSIs1q9OVIyxNP50J2rgbrdC6f85Qtw/b+FCRPRAUka4zBf05xcd3O+1C
         er6Cj8jRKxm+bCZN0Ty5bckxJVqc4Y5Wi3IKLGj6ppenc/+15uvQNxPwwWXeCP6w3abd
         gtG36KJG0pdPT2vRmud9+Jg6etqCTwtOvQcb6Bdedq/sLzm40xaRBNMVoN+BQE9ZMoII
         TaZyad+DCR/qEbiGKMtv9xitPiwip0NXE/lJZGVnIuRC9WPVCmjn9EqSMvvMdZzKxcx5
         OfZKLxjiNFyBDBnl4SEzEcXbiD2ZOUVoCBZjecGnrsmmJs/l3914QkzQre8ZiPgSgC4C
         ohGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsURC/QdQwClnf50ZEh68A/FUagJ65qu4eHWF1Am46hxalUKD6cjQJNKRAPyi9OtB6smCO1MXR9o5+3X8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg4KYFQXQrfGwutH91l+8p9EQsvZRQhbB6PmMTiU5KPL2CLQgj
	PKkHd0licPqLKsx+m73zG3ZPur1CNFlsQxPLNQdTebeZhJYOrgtxDO8yn5ELNZTN8Ck=
X-Gm-Gg: ASbGncvZiMh0wxCLNPAV9Y+C0JYGW4JBr4+r6vkZwbvaKzJTXrOzThFLVrMkbR96L2d
	VKr5AUqgvrC1CebP27xiXmtPBCAJ3ePQrud0Rk+2mz6v3up85Mi/Gexmvkr0iJ4q9BnGOnmL6sD
	o/7/aTOq36DJCzUbqb1iPM78huvOg/AqABy63qpHFhFCblW3842EH7vD+3DCHZS/dltmVfhOROD
	K2mE3U892+jyoc82mOVUWuRJ0ev7aY3G79zjP74DhH/7PF1Q27FjLkhrSMywOiUvmMZvdEKvl3c
	XKpqt5PMmIFMap1Hnm3vzcvBTjtAnMc0gSaIUSF2e0pZ8pU8fKYaw4IlEdALNbU9/rZI2ZEOmuP
	I0Dw6c9rqmNwdcHfKSfayBMIJ7w+uvcn3FlL/F0tu6T65jd855a+Wq0onEYru8adqGw==
X-Google-Smtp-Source: AGHT+IGPYTEBM7rthUf88Ia5HZrtFvZ/rrQd5/6C2vMcuGkG3ki1p9x7pdGI+whXVL1GGpI4sFIxqg==
X-Received: by 2002:a05:6000:240b:b0:3eb:ad27:9802 with SMTP id ffacd0b85a97d-425829a5a91mr2835454f8f.2.1759851542939;
        Tue, 07 Oct 2025 08:39:02 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:22ae:baa0:7d1a:8c1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e97fbsm25787403f8f.34.2025.10.07.08.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 08:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Oct 2025 16:39:01 +0100
Message-Id: <DDC7B1BDTZCN.D7JXN4RVKYHM@linaro.org>
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Neil Armstrong" <neil.armstrong@linaro.org>
Cc: "Srinivas Kandagatla" <srini@kernel.org>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, "Jaroslav Kysela"
 <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, <linux-sound@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH RFC 4/6] sm8650-hdk: Enable I2S for HDMI
X-Mailer: aerc 0.20.0
References: <20251006-topic-sm8x50-next-hdk-i2s-v1-0-184b15a87e0a@linaro.org> <20251006-topic-sm8x50-next-hdk-i2s-v1-4-184b15a87e0a@linaro.org> <DDBPGIDN8SKS.2GF6TZC6KGXVI@linaro.org> <de955ab3-26de-43ed-a450-d58ffe0df7af@linaro.org>
In-Reply-To: <de955ab3-26de-43ed-a450-d58ffe0df7af@linaro.org>

On Tue Oct 7, 2025 at 8:04 AM BST, Neil Armstrong wrote:
> On 10/7/25 03:39, Alexey Klimov wrote:
>> On Mon Oct 6, 2025 at 7:37 PM BST, Neil Armstrong wrote:
>>> Add the necessary nodes to configure the right I2S interface
>>> to output audio via the DSI HDMI bridge.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sm8650-hdk.dts | 30 ++++++++++++++++++++++++=
+
>>>   arch/arm64/boot/dts/qcom/sm8650.dtsi    | 40 ++++++++++++++++++++++++=
+++++++++
>>>   2 files changed, 70 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/=
dts/qcom/sm8650-hdk.dts
>>> index 87d7190dc991b11f5d1162aabb693dcadd198c51..1286ce95235d5544322a187=
7292cbdd426298c11 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
>>> @@ -171,6 +171,19 @@ sound {
>>>   				"TX SWR_INPUT1", "ADC2_OUTPUT",
>>>   				"TX SWR_INPUT3", "ADC4_OUTPUT";
>>>  =20
>>> +		pinctrl-0 =3D <&i2s0_default_state>, <&audio_mclk0_default_state>;
>>> +		pinctrl-names =3D "default";
>>> +
>>> +		clocks =3D <&q6prmcc LPASS_CLK_ID_PRI_MI2S_IBIT LPASS_CLK_ATTRIBUTE_=
COUPLE_NO>,
>>> +			 <&q6prmcc LPASS_CLK_ID_MCLK_1 LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
>>> +		clock-names =3D "pri-mi2s",
>>> +			      "pri-mclk";
>>> +
>>> +		assigned-clocks =3D <&q6prmcc LPASS_CLK_ID_PRI_MI2S_IBIT LPASS_CLK_A=
TTRIBUTE_COUPLE_NO>,
>>> +				  <&q6prmcc LPASS_CLK_ID_MCLK_1 LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
>>> +		assigned-clock-rates =3D <1536000>,
>>> +				       <24576000>;
>>> +
>>>   		wcd-playback-dai-link {
>>>   			link-name =3D "WCD Playback";
>>>  =20
>>> @@ -218,6 +231,22 @@ platform {
>>>   				sound-dai =3D <&q6apm>;
>>>   			};
>>>   		};
>>> +
>>> +		pri-mi2s-dai-link {
>>> +			link-name =3D "Primary MI2S Playback";
>>=20
>> Is it HDMI only audio playback or does it have switches to playback it a=
s raw i2s
>> (when external DAC is needed)?
>
> The HDK has i2s lines of the secondary i2s on the LS connector, but witho=
ut any additional
> boards connected it has no on-board i2s dacs.

Ah, like on RB3 and RB5 boards.

In such case the suggestion is to add mention of HDMI here in the link name=
,
otherwise it might be not clear what this multi i2s playback is about.
Maybe "Primary MI2S/HDMI Playback" will do.

Thanks,
Alexey


