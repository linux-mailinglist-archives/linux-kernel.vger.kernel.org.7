Return-Path: <linux-kernel+bounces-723555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D372AFE86F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8139585759
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7119B2BD5BC;
	Wed,  9 Jul 2025 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Nk5LU/un"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7A32C2AA5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062173; cv=none; b=drBt8mTQT8PybzyP1A8HkFchg20FBGCj0ciwIfJX2PFgORoyKRM6wNyGLpm7n8rNRujp9/Ty59KrSEVdIH7kYQUnV4zpoAPovroRyCtxujonEjiztIHpBDK16y/fnVViNYq6+e4QOrQKJgNBhwHxdJNbnFrp5JHuHc5cZ5ZFW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062173; c=relaxed/simple;
	bh=vq5TdR2eOaZQq4wzgDb/MUODx9FACB9AhF7YRu/UXj8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dpMiIxPcvheGqYrxe9yLYmTEI0AlMrjgqqtXFJ5MqBzuBnt8bfcVtFKi4ZNHk801/RosR/dlowqzmqjxMVJhywxkJ5Y5yQ8I0RJlUb4qnzgr8dlPWqFfUSf/A+hW0Wuwew3DVA84ow6Y3ZFMWUnYywZEBaBkBgkWoCihNV4t3rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Nk5LU/un; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso1078294066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752062170; x=1752666970; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vq5TdR2eOaZQq4wzgDb/MUODx9FACB9AhF7YRu/UXj8=;
        b=Nk5LU/unA3B4/PoWsjaeQ0G84+QYetFfFXNnyM2xLEPwM5f44Ekf3SBvG97fEPruyw
         D+RMfYu3yYQf5yl1InGmEwWF86oEw96mDQaHWLPDCrt3GwThX64lC/hG9HX3ke/nRj4k
         JafEfprqmZRDsoRsQOD1orvsXmm85bKd/xZUHELyC9kjAMVsfx6SW1jYi89wiQO8ePp5
         BuJG0Zb6RGPSz0+b7jLlZ93sJ0oAOpel6SDgiRlApvgYII1KBqQh+zvwIqrRB19Uocs0
         2l6jMoFTI+wV/9XHm5PZW/mHKi6aDUFBMkk5Vh8xwfPPh0tDebuyjsnCvmakbZ++iWrJ
         4GiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752062170; x=1752666970;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vq5TdR2eOaZQq4wzgDb/MUODx9FACB9AhF7YRu/UXj8=;
        b=KctVRCRwRqnBnRLjsRW4vOsZiFSgifHyCuNbz4Weo30yn4LR7+ghxkR0i3Si8UUO7H
         jGUO9rjAvIqDxdKlEmsML3Oae7X1C/1DQPCOOve8d2Cmgv8rb0+Aj6vLPNy3k+WPMjDf
         Kr910KXUVQvFKhfdqTPYxfija7DRH9S06vlwsZkqxAsJE/j+wRL1wFKo50GlrpQ1P7wM
         Lw8CItlrGudLz4/+SoPdACIyZ+yG8zK577UNQPpuIdmKTEvSopEwerB5PUWoSRib9jtB
         HcJVg6eslCSMbsVZNZfk5t7v2b2ME2E4w7d3ovs5Ldh2vwPJ/NXXX7qVDZWM21zPg+3C
         8ocA==
X-Forwarded-Encrypted: i=1; AJvYcCXF6tEVY4iw7M2vl1ywALra4yY1CveiJGr07HWh0VQAweBSmT8GUqnbxON7UepGqJOQ5B1GmrrVerydps8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVsRFRGqzIA4m9UdRiCriEiYz1BeMPIT39yVGAZjqgKMkuP7hZ
	jeZnArvjNvKijJ/elb+CljEb0+Mj33Z8C1hN3Mczvm6sjMDCB3qJDGggUh7oM8815bU=
X-Gm-Gg: ASbGncvZ/T68qZ2EkXfsUOHzm/rkTWPr1qdctNSev4l/yXd4+tLCS1QvyA1JgNqlLFT
	i6+Kjt/vODHzzVigOn4b8RaQtEMTCnlCu+yioa+mXALIMVh6Nffnm4gbuTDS1M3kgrXiH2j/6kY
	ScEjFafCpdjOUmM50CaxM7TjO6A4iBtp0SlyrngZDLSfNJc6XyyywOvkJewbyvksvbiIxm4Mx82
	dULuurLplhMa6WfVG/YqM1OwzJ48lCGEqvpOTH6WBqv7zeC0g5cEVUBB9OnwMuur0UoaFXm7D3z
	IwF9W2ns8hRrzbMuglBe1wMaLixf5FscbOvo6L8etdZgIu3gQZiRIK93SNmbcO5DPbTdtQRmDpI
	5gFGeexwr/QfYbLey2C7rmtjnFLSPL8o=
X-Google-Smtp-Source: AGHT+IE2lZBOcPVAhbCa9Rpom0DV95oxei90z5HkhH9xsj7T1YUJ++qd0fI4HdkMjuB4B5bxAz52+A==
X-Received: by 2002:a17:906:c152:b0:adb:2e9f:5d11 with SMTP id a640c23a62f3a-ae6cfbe874bmr232648366b.37.1752062170333;
        Wed, 09 Jul 2025 04:56:10 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac460dsm1094703366b.106.2025.07.09.04.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 04:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 13:56:09 +0200
Message-Id: <DB7I7D3P01FF.3T5WRSTJIWLVK@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH 4/4] regulator: qcom-rpmh: add support for pm7550
 regulators
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250625-pm7550-pmr735b-rpmh-regs-v1-0-cab8ef2e5c92@fairphone.com> <20250625-pm7550-pmr735b-rpmh-regs-v1-4-cab8ef2e5c92@fairphone.com> <bc27209a-e0f8-40bf-979f-3d747c501ae8@oss.qualcomm.com> <23ae6ddb-682a-4c4a-bd63-f0a1adb6f4f8@oss.qualcomm.com>
In-Reply-To: <23ae6ddb-682a-4c4a-bd63-f0a1adb6f4f8@oss.qualcomm.com>

On Wed Jun 25, 2025 at 4:20 PM CEST, Konrad Dybcio wrote:
> On 6/25/25 4:10 PM, Konrad Dybcio wrote:
>> On 6/25/25 11:18 AM, Luca Weiss wrote:
>>> Add RPMH regulators exposed by Qualcomm Technologies, Inc. PM7550 PMIC.
>>> It has 6 FTS525 (FT-SMPS) and 23 LDOs with 3 different types.
>>> L1-L11 are LDO515 LV NMOS, L12-L13 are LDO515 MV PMOS, L14-L23 are
>>> LDO512 MV PMOS.
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>=20
>> FWIW everything you said in the commit message is correct, but I'm not
>> 100% sure how to map these LDO types to the existing definitions
>
> OK so found another page (also made sure that the supply maps are
> indeed OK)
>
> SMPS is OK
> L1-L11 is OK
> L14-23 is OK
>
> L12/13 -> pmic5_pldo515_mv

Based on what are you saying that?

Based on 80-62408-1 Rev. AG for the LDO515, the Output voltage range for
MV PMOS is "programmable range 1.504-3.544" which matches "pmic5_pldo".

But yes, in the table next to it, it's saying 1.8-3.3V, which matches
"pmic5_pldo515_mv".

If you're sure, I can update it but the datasheet is a bit confusing.
Let me know!

Regards
Luca

>
> so please update that and add:
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad


