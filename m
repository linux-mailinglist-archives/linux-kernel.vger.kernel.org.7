Return-Path: <linux-kernel+bounces-742375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0727BB0F0DA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8192CAC28DF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676F52DA749;
	Wed, 23 Jul 2025 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="lH0nf79q"
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7682D9EC8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268979; cv=none; b=QGJ/sfGpMaJWi31lxro3Jx7R2LEXZwjPsB/i6geJE+3n8bHSP4ukr7mRfbjzdUCdM2h21ltu7LIV54BnGzu6Ha6e/vccVtVWyPelccZQyUeoI4RUJWwCVR+m5xvJEvRAcsn9ngfYJrm1wstnUPQVrDhxFt+xXPjsL2gnke4IBi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268979; c=relaxed/simple;
	bh=RI4f/Z3SE/X4N72vDIGv1owBAPo8cR1uNdwgSgPfEhU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=u8hA5okNQSorCfSEsDbMdhVZoNEHTuoyWp+0UjkYhvR5VoHsquTcTf052uAyqLMjb8jiwfncB+C2Edn+yk3zHTrKFr8ApjVy0uSfl3NRzcwh3LsD/YBZIYN0rng1oVyV6Cgl7EHuFB+O+VGkw6v4m6awl8iKVpzkDAuHB3rqARA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=lH0nf79q; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-60c4f796446so10119513a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1753268976; x=1753873776; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3R+RLDGTGe3/dGYkfQsVctb8blA4LBzgoSO+v6ujHY=;
        b=lH0nf79q/KYhIRIi45N+vnmNP3b96ibkAJBkFIgfXPJjsMaSODNwST0V/AG3aQxJ3e
         FeGVrhZ20jk1u3yWxc/27UenH7HjHSyulUvKEinc1xUWggHiwMO9bbaBDvddOq3F/VPx
         JGf3Q4ZFanq3VyjyT3kZDPJKjCp1kFiPzhtexs6eApuvqWSDofiiZqRcMx2EMaVJBLRB
         /OZnG/IEMv9Un14BPiREjjLhA9QJXw0ds5wbqA0JmFofDWyisSne5C4Az4ffNzDfJrKm
         xgomlw5+qF8Ea9887re6EVOp4BIrBlVwyjrtjoqKr8pvaCpfiBxzoaMJyx7Ko3LB/rEO
         0LuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753268976; x=1753873776;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g3R+RLDGTGe3/dGYkfQsVctb8blA4LBzgoSO+v6ujHY=;
        b=dIxJOGNQ8XWmS1s4QlSKeh9JqxurtPOaGcx8JZOYF7BlTQr3TfYoMCONXlR+dwtY94
         SzLAjM2Olv8KtjEOyQJLZ8lHMY470EQrW8uffegmoYPRJZKi44tjjoyWaCqeId+h8Y2N
         5FXsyOAiI/V1hkuCqJTp6cWyfKB1ldHVQpuuf5iboSyBfFw6+80bqpWzYHu76/N0XCrz
         7tOia3Z5r8Zl4oHDDnaFeAKE4FfAdcBJ9D3E3EsTs9jynyyEbU5Rn+TbXZBJQ/MRuJ4d
         GuDJnsqBIeVSSQugLlA6Bbu+OlJXyeD63F3wcS8lxi6b6p/Y++7rdgFEkZDg5afJCKvp
         KXiA==
X-Forwarded-Encrypted: i=1; AJvYcCWEr70QPXHxyzt3G5GESZyDIpvGiv6178gCkwh/vkdaJf24elOCAssths0hacT22sMZWmuWDYy2i/UY8wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuSk6Jb5rEomNVkOGJIUP7H2+TFte1z6gMwfS5bUbr/ruwWx7A
	IGHE2nfLpUxHG9robXo7K3wntoIjfVfYtAn/zBxqPD1/0cM7cbHtxc/Zrn33RsbST68=
X-Gm-Gg: ASbGncvflAd8IpbATarwCZBw4JdZs9HnI94NHvV+HlwBiP6Xk/GUucvlqfkmc7wM9CK
	KIKTwKRlOfINKVHD3U0wQslfd+3QYIO/PWatbdAFjgm+OxzLwbQC3a3XuXITdfPfXC3Ba5SY4fl
	dBbU7HcQxbz9qXo66VdFd5wfMn3K1fg7w7ZuFqKIPuAxRyqHBDyu4qgs6P8Vs6sDoy0W5AzMMVU
	6rLG8JM6YZWlwfBchcU/5yNiIgTku0CE/2eIUtnfzgUf5qdxBDK/uJwhVXw7MZa+Ge/ZUiqR8L6
	flaz432P/VbuEQpOmUuN41ernTwmEhJB0MUGGHT9ysuLJ/YXYi7bTmEknNuaK+zUIQ5e901siQ9
	+CmXNwnz8I9IumdEjYaieZARgML9P17NaL5YXf8DZSbO2moeddncVKEwm2pA0an8vSVc=
X-Google-Smtp-Source: AGHT+IEnlnbgewz5ArcfCq7ZHFS6Ryv2VXYRZKE9xkEMAwJ9/yNzgZ0lkdiJuTPpFfnJ3XOTmn+y8A==
X-Received: by 2002:a17:907:c26:b0:ae0:ca8e:5561 with SMTP id a640c23a62f3a-af2f6915e5amr241315066b.13.1753268976160;
        Wed, 23 Jul 2025 04:09:36 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca2eb90sm1033906466b.90.2025.07.23.04.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 04:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Jul 2025 13:09:35 +0200
Message-Id: <DBJDZBYHR94V.1QGVALCL60M1X@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Mark Brown" <broonie@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Felipe Balbi" <balbi@kernel.org>, "Srinivas
 Kandagatla" <srini@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Wesley Cheng" <quic_wcheng@quicinc.com>,
 "Stephan Gerhold" <stephan.gerhold@linaro.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-sound@vger.kernel.org>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/5] Enable USB audio offloading on Fairphone 4
 smartphone
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250501-fp4-usb-audio-offload-v2-0-30f4596281cd@fairphone.com>
 <DBDAPORDD5IM.1BHXPK225E2PP@fairphone.com>
 <DBHIM4SA3OIK.PXX6HMDE93B8@fairphone.com>
 <ac3f1eb2-5830-4bda-bc57-c4d29c22aba0@sirena.org.uk>
In-Reply-To: <ac3f1eb2-5830-4bda-bc57-c4d29c22aba0@sirena.org.uk>

Hi Mark,

On Wed Jul 23, 2025 at 12:57 PM CEST, Mark Brown wrote:
> On Mon, Jul 21, 2025 at 08:22:06AM +0200, Luca Weiss wrote:
>> On Wed Jul 16, 2025 at 9:19 AM CEST, Luca Weiss wrote:
>
>> > All dependencies for the patches have been applied already, so this
>> > series can land as well!
>
>> Is it still possible to pick up the sound patches (1-3) for 6.17? Dts
>> has been applied already.
>
> As previously discussed they won't apply until after the merge window.

Sorry about that, I thought the conflict was for the 6.16 merge window,
not 6.17?

The patches this depends on have been applied by you on 2025-06-09:
https://lore.kernel.org/linux-arm-msm/174950282564.277844.46348045130952041=
60.b4-ty@kernel.org/

So I'm not aware of another conflict, that's why I was asking in the
first place.

Regards
Luca

>
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so=20
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.
>
> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there are
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.


