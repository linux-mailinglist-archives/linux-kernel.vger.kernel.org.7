Return-Path: <linux-kernel+bounces-857492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D507EBE6F32
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1B5BD3563AD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7A82116E9;
	Fri, 17 Oct 2025 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjZtG3ou"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE891FE45D
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686511; cv=none; b=l62orw7ImeDio1+nBC/a5cqMHLbsLXrmHr9bQt0qG0A4sQ+k9td3LUuL7lxz+92N7//EGxOPAILZA6+7QPwr4jYT2ikXT5cUJHUuT/aRiRBKtnu9SN0xQ7TGKiNa5f0poDAtRWLvb9x9JsbO8f6Lgg9ecoIg7CFgVPgGMT8lq+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686511; c=relaxed/simple;
	bh=wwXPEjxkzFj/Qc25TrA1OsYoG1fARgWnybGKe4by4PA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UIRAwMJ/z3g4tq5M+UzDUb3hyMMMujBI82uPLwSn6C1xr2FPet0GZ4nvcboS9mEZaruZwgFkmjMPSkIwFtYLJKdxMbgkA+RsEKh4n9u1y9hNZGdeCjmjS6G/YGDmXNb5dpD5nWTDTRw6OpaI7djupf+wF4j4GRa9wv68A7KRY7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CjZtG3ou; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-471131d6121so12021335e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760686508; x=1761291308; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRAHrLtzX4FkJ70tgmGH4RjNErNZIaozOeFYjpDWaqY=;
        b=CjZtG3ouCuB8Wvp5bfaPs0AGlGfYroPnWR7rBlBg7vZeXWETXxN1bDnY1jKUzRoW+f
         4rUybwL2QgHASaIygdRzo0A+lkpjb3MXiqwiOGaF9gJOF/TrFO1rfQ/KXESG6CSLkefP
         le1mynWCtuKlX79OGDuEFeklx5d4rCj1mtqYoxXwY6K7mbn86yff7ZqrAMkv1HLXhFEg
         drD3kIen6GDlJe9170ByCszlr0uKi8h33msxbtYP/W1VierchbChkuPv3coDfJmShB2v
         trXXptP2erx/UpklJtsTvLy6cpHKGdBGnTjqlq8o8W8rTs/s1/MsvKwF3sOt4m0Rvakc
         BZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760686508; x=1761291308;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RRAHrLtzX4FkJ70tgmGH4RjNErNZIaozOeFYjpDWaqY=;
        b=CeFcdvJ1jua8Ib1zDe/4+ixKrHXU5vwZCQm5k5WNM3dtmjPNGDjQ4nbLi+hGiebQTw
         gHUra6UG9yBa28ZECToFixBKsYTKZBqXlXo6WGvgTgOUyyNql84I1A2a3tbtULD8Yp3m
         cZyIcw2i22GwxkPuTJpZcsr5IK3QMUenhwJcaTDZYhFR5LKUwQVnyDpnoJlEUY4aB4jT
         OEik+lgj3aXlRjAk2N1IL/bdChQBWatfA0yVRrgXQN7N80Xo0Kp9WrM1DJow/LE82TvH
         8KlGqDxO8H8fb41bIazkvhNIpBZVqLLVE1qFywzk4lN7WIm2iObw3GHc2WVfbAypSMnA
         5tLA==
X-Forwarded-Encrypted: i=1; AJvYcCXWfgNrHe6ZYMIYpXRsZWEpRHpaF83fVku9jvwhF4wO1fk/SR7F41DgaFl57uqBubCIPBLNbwny011fE9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLT6IMFjV68OqMJTMiCkGGRQMDd3IDJ5Q79A4jENPZMFNCPyK7
	e97vRM1/WYAyU6hsD0Tf+bhs/sEof+ASSWsz8S8zGIkPN/YGzlqhyb+xVrJjWsAZG44=
X-Gm-Gg: ASbGncvxL5GSfuMz01Py2+8PxiV1W9NT/t3F1yVrG5kcm+GzdxYBrwM8lw1y4XwcrCJ
	OQ8brCKQQnfkAFlixXqnPsvVf3YQ7W0tfV4Se88MPsWGGJbPjV6Lk12JEkBpspEODwHd9an0jB7
	0GVZSO6DXcLCxItU+BBTLb9KZCaBZGjDKTcHB17bGga12DdkBQaqhQzCV+vDSw4QMqur7uhbXz/
	UW2z2dl9qwhW/O5+IjbvVf13irUNPU7g3sKt1k7poMM2bbTpep81xDMU63rgZBmJ/FI5GpIlsHf
	7ydEnO5DBLDskoer/FA5846/1dOk7j2lQYuRg60cwSwBVRaBmDrNimpVjn7wlwY+Xyuz8pyT2/k
	P1h3WPfH4b+XId6r65yKqMIChvhAn7z8SyYl7xnQdZUJyrqFsjGJlqIs9pg+5+7ATy+7pwIPdjB
	cS0kAmCpIubev0NfA=
X-Google-Smtp-Source: AGHT+IEUpUn6oZgPv3BnmLbbizrB7eXAza/I+SZs20+aiPmae2iUnXG9lb3ZTVSYw/dt3XQUlczMAw==
X-Received: by 2002:a05:600c:800f:b0:471:700:f281 with SMTP id 5b1f17b1804b1-471179041b6mr18279085e9.25.1760686507898;
        Fri, 17 Oct 2025 00:35:07 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:6426:9b9b:6d3d:1da8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144239bdsm92273405e9.3.2025.10.17.00.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 00:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 08:35:06 +0100
Message-Id: <DDKF9YV37ETZ.3DXIDZA4ZU6I3@linaro.org>
Cc: "Srinivas Kandagatla" <srini@kernel.org>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Jaroslav Kysela" <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>, <linux-sound@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: sound: qcom,sm8250: add QRB2210 and
 RB1 soundcards
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Srinivas
 Kandagatla" <srinivas.kandagatla@oss.qualcomm.com>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>
X-Mailer: aerc 0.20.0
References: <20251007-qrb2210-qcm2290-sndcard-v1-0-8222141bca79@linaro.org>
 <20251007-qrb2210-qcm2290-sndcard-v1-1-8222141bca79@linaro.org>
 <b0d9cec5-1162-476b-8438-8239e1458927@oss.qualcomm.com>
 <CAO9ioeVcqT_Yhvz-RMCucLtcpa4xCLrA+srM8Vy_ZZ-650ZQnw@mail.gmail.com>
In-Reply-To: <CAO9ioeVcqT_Yhvz-RMCucLtcpa4xCLrA+srM8Vy_ZZ-650ZQnw@mail.gmail.com>

On Thu Oct 16, 2025 at 8:46 PM BST, Dmitry Baryshkov wrote:
> On Thu, 16 Oct 2025 at 18:08, Srinivas Kandagatla
> <srinivas.kandagatla@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 10/7/25 2:26 AM, Alexey Klimov wrote:
>> > Add soundcard compatible for QRB2210 (QCM2290) platforms.
>> > While at this, also add QRB2210 RB1 entry which is set to be
>> > compatible with QRB2210 soundcard.
>> >
>> > Cc: Srinivas Kandagatla <srini@kernel.org>
>> > Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
>> > ---
>> >  Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 5 +++++
>> >  1 file changed, 5 insertions(+)
>> >
>> > diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml =
b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>> > index 8ac91625dce5ccba5c5f31748c36296b12fac1a6..c29e59d0e8043fe2617b96=
9be216525b493458c4 100644
>> > --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>> > +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>> > @@ -21,6 +21,10 @@ properties:
>> >                - lenovo,yoga-c630-sndcard
>> >                - qcom,db845c-sndcard
>> >            - const: qcom,sdm845-sndcard
>> > +      - items:
>> > +          - enum:
>> > +              - qcom,qrb2210-rb1-sndcard
>> I don't think you need rb1 specific compatible here, unless there this
>> is totally different to what the base compatible can provide.
>
> Why do we need to deviate from other platforms which declare
> board-specific compat too?

There seems to be now a few incompatible suggestions for rb1 sndcard:
- make it compatible/fallback to qcom,sm8250-sndcard (1);
- make it compatible/fallback to qcom,qrb4210-rb2-sndcard (2);
- add separate compatible/enum for rb1 sndcard as qcom,qrb2210-rb1-sndcard =
(3);
- add base compatible as qcom,qrb2210-sndcard and fallback
rb1 sndcard compatible to it.

The latter one is ruled out because base compatible should be used and
it is not going to.

As far as I can see the last addition went simply with (3).
Which one finally you all want?

Best regards,
Alexey


