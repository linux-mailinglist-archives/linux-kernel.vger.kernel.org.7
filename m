Return-Path: <linux-kernel+bounces-844964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA70DBC3294
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 04:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089BA189129E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 02:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2C829B237;
	Wed,  8 Oct 2025 02:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ahaQ+NAg"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6680729B789
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 02:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759889933; cv=none; b=HGLc0Mdkyo9Oep0zicT69+svA+8NBCHb3JaOSqPxCTw8gJ3OVxHpQ7bpUqO2KXcEgTGmAr2BLjV4blz7EYD+PJkufOkD79WVq1yO95s3hCHKAtg2z4ZtO5dlY3dBvxL2YBm6idZQ4tYLqJ/9yjX+I4RhPXepZgQjxluvSkCYyvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759889933; c=relaxed/simple;
	bh=eLUKCid2mCzEr3f2IULaa6Mi8dzk04iOMQ1Cu+awDD0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IQVTycfxv6JYg5dDkHuhASnE4u2S3n5qXLVyGKqSM6YRux4kht99d4P0wzfECW8Bifg1YtJFicCfvGrfM8t5KYipL7NktB7UVMy6TValRNdeQ1IYbfnp1K8hg1dXCRQR7lgtSv0TTHn47kotMBMB/4WjrBCG1G5PuZKuxzoPcFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ahaQ+NAg; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so1458291f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 19:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759889929; x=1760494729; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=micbjQhFRi56rmBZKMQCddkVTulgFVdWxWszGqRTF54=;
        b=ahaQ+NAgrWEPQIWuYqcDIOvUoZ3mn+pgDminfwb0D23x9JG3hjU5U92zv2E3HqJMO6
         gNawUbzwU2KVurUIPikMg9FOl2X/zB+5JZ0Qm+pQTMzwia3+/qHPF+/sJYrxsMj9KqHg
         GoiozcubMSwutgCST7fk3Fgh46HutkmdyGafcQJL76KUMdnL2bIzwpprswGJp1Bj7NAu
         AMIis8KZLI4JdFV6TBfdsfK+MuDnA0/wI6omoHxCAKvg9/t7Jnp2XCSBUx4AdDbCYeKf
         LXok8IgB0KIRL1Jr6znbw2hpYMT643pXKwmSLOn6d1VFMzZIHvJekxYTtk8bW8p+fG1m
         fK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759889929; x=1760494729;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=micbjQhFRi56rmBZKMQCddkVTulgFVdWxWszGqRTF54=;
        b=LslPyM074vlEKVoQc4hyahzsPRK/A94RwSQmw+5NJEAumF9iLwGXhVlsASqSvtuy8U
         HvWB8b79mDja3oDJoTjKIkJN7GLDw+5hGFCVSx/evjflm0qGdE50+6oVj7l/Qn9bhMq+
         btpur2oc6GXJy3axdhT3HqZpC2YoSZc/3GPv3aZjjKpjorih3CLaCNn9QbPeBxncZUVf
         mq4IdjPg7axlmOErKiJjM34o8AlEU5tuUoPrrJmmHcaUZ7//alJUHDdjFocvQrJ8EYqs
         lpo5KAFgLA9u/Dkdj/EdPwhdG4F79iAJd3KbjCW6hAWiCQqQzYH/fYXDmmbvFrKbyBnp
         dQHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9Gt4aGlkwYAiAR1yGLOyBdV53aHdq4/JCiCbj2pZ9lXYQI6AhXZA01YFEMjryofGdo3ZbwwufPjAQcKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxayGLkKw+3YuRB82o5OTfOBBZeUF3zP18rr1gSGmX8HNv+YWbK
	sIzX424JdXD8XGg7QrxH8x/jC7gmTwkNneDhngGF8m6G+DrAg2BviMjhPKQShyqiMew=
X-Gm-Gg: ASbGnct/wzZEw0YjVYm8kLKcQhqGN5DM8CiOb1xAC7I4NikapPflyxAmtztbljERIor
	GkgPiMrqyEd304ppVAh4uyj3vGL2TFOZw25qiPButXegamh1qXNJUZeGzHxzP6+TXD/a7gj238B
	d7RBQZ1fkgI5XKtSoHJiFGB0xNxQ009Qj6R2ndXKzKQQHrTEKWHjr23spqm98CLCO/qddUkFIlq
	31rI4Rl3v9mrWe3MT/UG0VLVydZWLe8uOwP0o5wZEsAUwppDofokAEC7pY6Fvdcvv4rQyHccnfo
	vPZsCubPsX4UTIYfWTfcI9MCh6OOHfdDyekK2yJqDGGlwdz/qDb6EQHvu8FOsCimFQ0v+w6MPin
	28cCboWGF2m0uWk9q6CCz7e1kYCw8u1z5vXb6I3H7qLl5EXlqHmSgvko=
X-Google-Smtp-Source: AGHT+IFPMFJByHAQ3JW76Qjmt7UP+fMZMpkYgj4Y9V9tn3CZdsWTV3HC+ojk6qaBDfa1ihXXI4WNNA==
X-Received: by 2002:a05:6000:3105:b0:3fc:54ff:edb6 with SMTP id ffacd0b85a97d-4266e7dfdb3mr815912f8f.35.1759889928751;
        Tue, 07 Oct 2025 19:18:48 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:8c32:dd4d:57f2:8be7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c16990sm15668705e9.10.2025.10.07.19.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 19:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Oct 2025 03:18:47 +0100
Message-Id: <DDCKWVH8ORLM.357D9IKQK9YN8@linaro.org>
Cc: "Srinivas Kandagatla" <srini@kernel.org>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Stephen Boyd" <sboyd@kernel.org>, "Lee
 Jones" <lee@kernel.org>, "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai"
 <tiwai@suse.com>, <linux-arm-msm@vger.kernel.org>,
 <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Srinivas Kandagatla"
 <srinivas.kandagatla@oss.qualcomm.com>, <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v4 2/4] dt-bindings: mfd: qcom,spmi-pmic: add
 qcom,pm4125-codec compatible
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
X-Mailer: aerc 0.20.0
References: <20250915-pm4125_audio_codec_v1-v4-0-b247b64eec52@linaro.org>
 <20250915-pm4125_audio_codec_v1-v4-2-b247b64eec52@linaro.org>
 <20250918-wonderful-deft-jackal-7d3bbc@kuoka>
In-Reply-To: <20250918-wonderful-deft-jackal-7d3bbc@kuoka>

On Thu Sep 18, 2025 at 3:03 AM BST, Krzysztof Kozlowski wrote:
> On Mon, Sep 15, 2025 at 05:27:49PM +0100, Alexey Klimov wrote:
>> Add qcom,pm4125-codec compatible to pattern properties in mfd
>> qcom,spmi-pmic schema so the devicetree for this audio block of PMIC
>> can be validated properly.
>>=20
>> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b=
/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
>> index 078a6886f8b1e9ceb2187e988ce7c9514ff6dc2c..776c51a66f6e7260b7e3e183=
d693e3508cbc531e 100644
>> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
>> @@ -137,6 +137,12 @@ patternProperties:
>> =20
>>    "^audio-codec@[0-9a-f]+$":
>>      type: object
>> +    oneOf:
>> +      - $ref: /schemas/sound/qcom,pm8916-wcd-analog-codec.yaml#
>> +      - properties:
>> +          compatible:
>> +            const: qcom,pm4125-codec
>
>
> Not much improved. Same feedback applies.

Around the time of sending this I thought to set separate follow-up patch
that fixes the other part here -- pm8916-wcd-analog-codec.

At this point, is it fine to send follow-up patch that does smth like
this:

+    oneOf:
+      - $ref: /schemas/sound/qcom,pm8916-wcd-analog-codec.yaml#
+      - properties:
+          compatible:
+              - enaum:
+                - qcom,pm4125-codec
+                - qcom,pm8916-wcd-analog-codec

?

(I didn't check how if it will compile or pass checks)

Hope this is okay.

Best regards,
Alexey

