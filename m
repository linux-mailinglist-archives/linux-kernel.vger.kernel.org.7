Return-Path: <linux-kernel+bounces-837891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A36EBADFCD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C994C21B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F246303CBF;
	Tue, 30 Sep 2025 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HTj2ldqH"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DB42F998D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759247991; cv=none; b=hzPq/U3GcdvCJK9X564LivW1cA1gdb8Rl0JSEYD66Ze8r0lbDQmvWnSvCWIG+QD5lEoDQOyjZIKV7MnuLNlquPkhJha9VsMtC9BBwMkMaN4oy3b44zzbGBw1ArtjINUiwU5zsszvCHdaEdeQiVkD8Ltco49z27PeHzoQcKlTkEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759247991; c=relaxed/simple;
	bh=AVM+f6993GG3pPTGXpDB9FNg13zb0loTdcuhSe/D63Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PrEH7yGopWMInRywW/NH55nkEodVDwGZPX/P82jaXcfYY0l7K1UbgFww2GkQxH71eEhFWlrczRqXbLf9LNG4kHVfTehcIyyssh4Z7oAXLEkGUg4bv3vzrxdYW8uwxufWQcLSRPGiW+SR9lvpK1sEh/NU3mODZUWuwfxzXlv+hwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HTj2ldqH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e52279279so18938675e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759247988; x=1759852788; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jewn4YU/vUIZPW/z42z8IyS83UgUexK9MRMwSa8wuVM=;
        b=HTj2ldqHqECeS++YJjG3LkVp9U62Kk2sFTKiNwdeaMizJxBXTU5LmE7bHHHj4WS9pg
         GxVlQJJBYrDCD8Q6kGJzgNodFvLWVxlF7IlrVnp9BlVd0fil4tp2S5zuNMgZ2b87IAOW
         zBCxNKKQ6u4fIcLXUkY10beovm5Zu/Ge7BdXnqYBCN53o8UULCqtqg1stn3Wz3EuapjL
         1vvvDLa6ZuU8VwjmQoXf4tRGWBNp7asa9UoN1lRSWrSEpce3AamM9u6oSKpBsGQiz5su
         sC4JQflC1AeLF4iWOKi8ybFXb/F9QS6Ek5WS1FsgSBhyNDk1Gixqse1hvkqhLqZ4u1hG
         mJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759247988; x=1759852788;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jewn4YU/vUIZPW/z42z8IyS83UgUexK9MRMwSa8wuVM=;
        b=TbKPg+nqGfSUnH1SH0ABa9amGoyvQFfScEo9eyNMWhsax9in5AFIMQQZTaqDFnWToN
         7ug/GMkuapi7lAcCZszcD5bm5YC2XnXX8Ng9ClAnCMIayUMiy5yWY51j3l66ajFqdZcv
         bTdglFIYyWiKYzoA/65ezwcHywGPjXu36W6aMuOHiQsswaRNU0l41D4nEdzhO9zUVuwu
         i/5is8liOJiG5htEjBsC0uwjuFJme5dNymeRWKvd3rHJb/yg8SdGvoiq6bwlo4Re2IQS
         BNNe8HtlqBQieFjk4pqsgPly1UIKLOk6CTwFgrNWK8oWmqQYzr4h3qW/khUoGLolX1fC
         K9vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyV10MMz6az791KyUiZLbXuVIMGVxgi5/XVNsSxm3xtdGw+BPLaKScABrbC0PilzEmNaBO6mqKxTi/3Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YylPpPW8TzPp0ZEOLvchICiAV/mCDNpFRwa5OKfVDf0ZhYAm9M3
	EQWo7MKA24e8I6MY2VSYbERXjBIN00gNBaoF3rssfpENXLxT7EuTcuytUDDI4UqqKIU=
X-Gm-Gg: ASbGncthtaHRJDfK8ry/ODqrLjl1OxDqxaG1gcyLGieFC7XwmJzCyadSBV26pbnXk5Y
	evRyIIsPOKH9+N9w78MCcli8ZD0t2ArTLBKeAKBrv7jVpk9sKJIP6Hz0Am3XIkumjHlPyR78gLU
	hlFVsOhH8pfhWAqDCAHH/ut5jMsxhmOPtqe71SdC9Au5u1yQ616/Qu5+zTIvrHXiyps/+yZ9tJC
	JJCLjnb/RhnQX8iXSJtpDG64n6sxt5vP8UF8XaSJkHhdrSBYiv4e94C+HucXEg7aECNUzLWOea3
	i44l0JC8bU5r4UafhWyLB/NPvurVUoK8A9KlE1QKM3Ono/CI0rrAeTxggzAFZ4DsYHYapEdhbR3
	+2gKcanrsvzrWKQlzmI0Uj2Nb+ZgsacHqe1pSpOeeL010xre/LpyT9zpVuc0=
X-Google-Smtp-Source: AGHT+IGgWhUKC4p7LLQ65Y2Poqvj3Z/K2NZk/M2fzSl7pknsxh6YoTUT2JS4bAKz8Cg2Bjs6T9NXkQ==
X-Received: by 2002:a05:600c:4e48:b0:46e:59f8:8546 with SMTP id 5b1f17b1804b1-46e612674afmr3283495e9.17.1759247988059;
        Tue, 30 Sep 2025 08:59:48 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:248:54ff:fe20:c34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f53802sm61255805e9.9.2025.09.30.08.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 08:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Sep 2025 16:59:46 +0100
Message-Id: <DD69D3NF9QWG.3NJDD1L5EQFMF@linaro.org>
Cc: "Bjorn Andersson" <andersson@kernel.org>, "Linus Walleij"
 <linus.walleij@linaro.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
 <srini@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: sound: qcom,sm8250: add RB1 (QCM2290)
 soundcard
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: aerc 0.20.0
References: <20250302-rb1_hdmi_sound_first-v1-0-81a87ae1503c@linaro.org>
 <20250302-rb1_hdmi_sound_first-v1-2-81a87ae1503c@linaro.org>
 <l6itr3k7taiyiokaahcg2mwtaa5lynia4bimxridpsyymk5ml4@loii4h7lhjhz>
In-Reply-To: <l6itr3k7taiyiokaahcg2mwtaa5lynia4bimxridpsyymk5ml4@loii4h7lhjhz>

(update emails, drop old ones)

On Sun Mar 2, 2025 at 8:20 AM GMT, Dmitry Baryshkov wrote:
> On Sun, Mar 02, 2025 at 02:49:52AM +0000, Alexey Klimov wrote:
>> Add soundcard compatible for the soundcard on QRB2210 RB1 platform,
>> which at this point seems to be compatible with soundcard on
>> QRB4210 RB2 platform.
>
> Is it? The RB1 uses PM4125 for audio output, while RB2 uses WCD codec.

That's correct. I also managed to enable hdmi audio, vamacro dmic and
pm4125 line out output keeping it all compatible with qrb4210-rb2-sndcard.

Things are mostly the same between RB1 and RB2 apart from last stage
in the output and analog inputs (non-HDMI and not dmics). The diff can
be described in board-specific device tree, amixer's control commands
and model property.

Is it still need new separate compatible "qcom,qrb2210-rb1-sndcard"?

Thanks,
Alexey

>> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 4 ++++
>>  1 file changed, 4 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/=
Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>> index b9e33a7429b0c063dc5f5b806925cd541e546cf6..2493ed99268bf2ff83430201=
50c2c9aca4262514 100644
>> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>> @@ -21,6 +21,10 @@ properties:
>>                - lenovo,yoga-c630-sndcard
>>                - qcom,db845c-sndcard
>>            - const: qcom,sdm845-sndcard
>> +      - items:
>> +          - enum:
>> +              - qcom,qrb2210-rb1-sndcard
>> +          - const: qcom,qrb4210-rb2-sndcard
>>        - items:
>>            - enum:
>>                - qcom,sm8550-sndcard
>>=20
>> --=20
>> 2.47.2
>>=20


