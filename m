Return-Path: <linux-kernel+bounces-822973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E04DB8532A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FDF3BEE53
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6592A314D25;
	Thu, 18 Sep 2025 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lk7TGhlz"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E62308F1B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204908; cv=none; b=TsPLvpUfyhjt2ZnSrnnrprl0Srg9M8VydMoBBVksWaQKJud2fehn9B6ENpPXuTuaw5Sf4c7uMC9DSFJ0BcKjnMBGebzcdmXeutAxg9fo4KAIw63Y60hAKXjNeybKRCQZZVYq8pEMoS7DbLL6Xw9FGVAKvC9hQpupF9CLo/mK3Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204908; c=relaxed/simple;
	bh=0coe/QFA46JTNO8ZaDwBRkRFUpFZ853bhqXJwpYcdJU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NTYWWfrOiP2eWacPPLe1jed0koLP5t6FfITHahIeAU7K1etpm7MW0nrMAeq48lGkOUjTYyeYiBLHQMCXkW04O7wxjSVjpRhgyme1ZEIPYo4Ey5N7vvOWWPLua+0zQ6Qyad9++HOb5UF3qhC/RBBMqv61mRREPonyxzuGs47d318=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lk7TGhlz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45f29d2357aso6989275e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758204905; x=1758809705; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+c/huWZ2XQVoB94N5MFK08nC3wxU/KugANouKkKYms=;
        b=Lk7TGhlzYn6lyGn8+tHFCIin/wZclvaCNn1jUlAL5YNc3Y3YUN5A3jSRj095h//S09
         HQWdvLaugIm80UdoTqK9u0n/sN3EfK2q9t4EIiz3nmJR1uia9594eS+C99pxPj8mdR5Z
         2deea6jyfC4SRfJtlUXjOH7pX0cAxxxf9D/zVQpUFOJRFRpRf01aGs1MORhVe4DhJuMp
         Od7kkZIRngBJ0GUMSlORi+BAfOG2l/7Rb9AZ0JFlQJA8m+ss7U/GOPzMLzsA7dvdgxVz
         RSVbMab0NrCfmQM4AZXqsJioZjAMabqRlEJDee9qTOeU33++d6wNwJeMe7/FziBna6E9
         okmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204905; x=1758809705;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u+c/huWZ2XQVoB94N5MFK08nC3wxU/KugANouKkKYms=;
        b=FoW+4b37SfHGpOKgvGDLGuTRcaA5mLdYHwU0u8k34wyrFfJyAiFbw3L7gMRO7nt4nU
         8U6AFPgR202ZhSHO01j/KBjOXCcedU0fKBigJIm/alQYs04ouWgyuOm6UzZw+mLXL/lb
         jKJ7va2Agz5Ho7viS6xZsM+wl/igz/x7f/WKA58L6ON9TFuODIg+UCIc1lHqXEzR9jtV
         NiHUVXULOTYSW/1vWeaQGifkqDIz7mb4hcpZjO24P1CCzj/p/CmjF+F1ACP9lTl1C6B5
         1tuU3WlRhlnAeRPMNlbfV6OMMmcfsAsEHr+5hNLUAIg98mQ+9oZGogW5wjdaUxLcq3yt
         6v3g==
X-Forwarded-Encrypted: i=1; AJvYcCWsFdXUlhSq4qyDt+geXc054Wu7WsBzms3lgLHWSenV8J4Sa8+oF9Xrmg5AsowA+ToPUi95PjIEJJn4e6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKJ5BL265q8gzDWkXR4musiVOdd7aojJjr076hmqGu4yy7IyFg
	ydu8eaI/QdqTZJ1mRCaN4xLWn/+sBQ6JXlIQ00i2uT/FBPm/z9sibmRdpQZMLfX22Mg=
X-Gm-Gg: ASbGnct6FSRkJcwJQoYGzxWCoRUghEevaedWzwT6gUnhpmcxf2tHOw/CHVdKC2iWFRy
	AUvEchbGsWQAyILqKmzohzCptLwrzFkwchVtqaGj6tqA9jVqu8objkDKlZk4A/iI4IrYpkMGJrI
	7/f4uwRaATAsTDSuVuLkBBBFguSJFq9YoON6a1KA2HfPZu68a7vy+LFNRKhcW/fOvhTxm5IPup+
	pCIviDPW5J3roNY7loM6xHos3fjnC5+PG19b7q2Mce7NP7FYZsUmqE5slfGBQXJurQ8lkRrgGWa
	ASpki1zlPBcrDIy03wDgtJY79x0Rrlcpciod1YMvAFzpLPI9f1IBw6iRQ35HuFem6vdDJwjgWke
	TPvi9bgedxMCeK5KxzCWmXSdo1pHxCsTIE1moTZSRAjkRFao=
X-Google-Smtp-Source: AGHT+IEYvV21OOIrM80imACv5lq+0ZHSelW3dyd44ly0+BqTeDL00+tLVvxEUiu7IKEHLLcpukn1Bw==
X-Received: by 2002:a05:600c:1385:b0:45d:d944:e763 with SMTP id 5b1f17b1804b1-462070ed655mr54250015e9.33.1758204904949;
        Thu, 18 Sep 2025 07:15:04 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:6c39:59e6:b76d:825])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613e93dd85sm94618805e9.22.2025.09.18.07.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 07:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Sep 2025 15:15:01 +0100
Message-Id: <DCVZMD9HWPX0.LOKMJXTY1Y46@linaro.org>
Cc: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: qrb2210-rb1: add HDMI/I2S audio
 playback support
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Linus Walleij" <linus.walleij@linaro.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Srinivas Kandagatla"
 <srinivas.kandagatla@linaro.org>, "Liam Girdwood" <lgirdwood@gmail.com>,
 "Mark Brown" <broonie@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250302-rb1_hdmi_sound_first-v1-0-81a87ae1503c@linaro.org>
 <20250302-rb1_hdmi_sound_first-v1-5-81a87ae1503c@linaro.org>
 <58d32bd4-d854-4233-89c9-22c37bddfaa1@oss.qualcomm.com>
In-Reply-To: <58d32bd4-d854-4233-89c9-22c37bddfaa1@oss.qualcomm.com>

On Tue Mar 4, 2025 at 4:56 PM GMT, Konrad Dybcio wrote:
> On 2.03.2025 3:49 AM, Alexey Klimov wrote:
>> Add sound node and dsp-related pieces to enable HDMI+I2S audio playback
>> support on Qualcomm QR2210 RB1 board. That is the only sound output
>> supported for now.
>>=20
>> The audio playback is verified using the following commands:
>> amixer -c0 cset iface=3DMIXER,name=3D'SEC_MI2S_RX Audio Mixer MultiMedia=
1' 1
>> aplay -D hw:0,0 /usr/share/sounds/alsa/Front_Center.wav
>>=20
>> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 49 +++++++++++++++++++++++++=
+++++++
>>  1 file changed, 49 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/=
dts/qcom/qrb2210-rb1.dts
>> index 7a789b41c2f1887f0c41ae24da2e2fe8915ab13c..e547537cffdbc13cfd21b8b8=
b7210b62996ff431 100644
>> --- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
>> +++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
>> @@ -186,6 +186,47 @@ vph_pwr: regulator-vph-pwr {
>>  		regulator-always-on;
>>  		regulator-boot-on;
>>  	};
>> +
>> +	sound {
>> +		compatible =3D "qcom,qrb2210-rb1-sndcard", "qcom,qrb4210-rb2-sndcard"=
;
>> +		pinctrl-0 =3D <&lpi_i2s2_active>;
>> +		pinctrl-names =3D "default";
>> +		model =3D "Qualcomm-RB1-WSA8815-Speakers-DMIC0";
>> +		audio-routing =3D "MM_DL1", "MultiMedia1 Playback",
>> +				"MM_DL2", "MultiMedia2 Playback";
>> +
>> +		mm1-dai-link {
>> +			link-name =3D "MultiMedia1";
>> +
>> +			cpu {
>> +				sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
>> +			};
>> +		};
>> +
>> +		mm2-dai-link {
>> +			link-name =3D "MultiMedia2";
>> +
>> +			cpu {
>> +				sound-dai =3D <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA2>;
>> +			};
>> +		};
>> +
>> +		hdmi-i2s-dai-link {
>> +			link-name =3D "HDMI/I2S Playback";
>> +
>> +			cpu {
>> +				sound-dai =3D <&q6afedai SECONDARY_MI2S_RX>;
>> +			};
>> +
>> +			platform {
>> +				sound-dai =3D <&q6routing>;
>> +			};
>> +
>> +			codec {
>> +				sound-dai =3D <&lt9611_codec 0>;
>> +			};
>
> "codec" < "cpu" < "platform"
>
> with that:
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Yes, you're right. I need to sort it for the next version. Thanks.

Best regards,
Alexey

