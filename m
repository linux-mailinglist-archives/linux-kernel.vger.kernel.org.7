Return-Path: <linux-kernel+bounces-735026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9A1B089A3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2334A256B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3128B23B600;
	Thu, 17 Jul 2025 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="lpcGqe8b"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C516C1D7E42
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745579; cv=none; b=nmaCFEUkIyOabBeePl5oG1gLlbpdA85kQGG4/mrWRkuqLjZifql+2t3Wuq+X2Atn/FEH+t+yWRQR9wc1xaZ6pNEXMa6MZWtS50qHL7NQpN3NqxVKTowX2Sw2Q3QCYou8pVhFuPp4sefD5sm0wA2jMrVHZrWgoGiD87L/tg8UN0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745579; c=relaxed/simple;
	bh=SNKCNuS07yOhNClyun4AtdBr5+gzFNw6Inn1wst24b0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Tj92oZJdeU0qbA7iWPF0fTpQeYvFcUInnKsGXU3dBeUov7UXkgu+mlsKl4ZNzkk/ncbNU48j3us2evAAhK1jq1c/Ux6TYiS+9A/z31OigRO582y5oTGCoxuts6ywtwg3qSq9ptYn637tUNmEzZ9PeAsG5/PwwWYPx0CuHyPXNkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=lpcGqe8b; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0df6f5758so130183766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752745576; x=1753350376; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ru/mu5vOTULTD4H+wkh3KmAvhPvotp/lHqkpBJrbBE=;
        b=lpcGqe8bgzQXCJRH9llp8Wup0wahZZ63GZPfBMKuG5xnp5YCX9DgnGmM99AkY0Xiau
         EelPRHsz9UXd4sdm+3caaj8q5YSYNJbEHVXpAoEhMSXhHeCOatKCgK+1P7VNccezQNOR
         idb0Y6pN6yRPvprw/fyvhIivt7bRpNQKXLj85ncRd59+JvsVv/sI7jbcQpXlrNnwnKsx
         /vv61S6PR2F/l/gNOEUXp6lerExDqD/v1LtJzhLIPmUhyE3oKwn5RzWxppp7vNsk2q0n
         ImL/G8IFhPWV0SOX5e5t9Q5MP81EamOv8NuaL21bDHyArTjzwwPj5OvTME0Z2tv2gMlQ
         WN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752745576; x=1753350376;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Ru/mu5vOTULTD4H+wkh3KmAvhPvotp/lHqkpBJrbBE=;
        b=AQQ8uu+SohvQizT/JEwZboe4zV4818UPAHbQps10eJKKmr1r94BDOEgrG8rsOszK0D
         GE0XykQKwCaShtLGw0p9/hcYV1ALhQXtWFilCU38tY41nKE4tXzM67EDgskr74VsxlxD
         sq8PYdi2zxhgpnYhgbGiGFFAyCJ/257cRb6JwjLjyYJD4X03hai9aQPDM/00Fl4YO6Ry
         L7PjkrLnTt78FxDcOSlQ3kZExulDsDAZmJ55XU74Sv8K6DLYBsB0C4cz8uSHHGc/8nF3
         oH8Dr46ABRaH8JMnylUjF2hzxNT0+wDWSvBCgV/Z6c5kIBmk9r7FbWetygkzLukNZ0uR
         SnjA==
X-Forwarded-Encrypted: i=1; AJvYcCXprdB0lh2K8ACxmDCkRU3eTYpavoOvOTAnDaZqrnLfEQbaGoLDEmYAsmQRo7NocG9Z+nywEKHLQLqDEGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJGcgo2Yxl6znw2mATSXb/I6gzqOtvj0UiPPzn07OSI9EVz5WR
	Or1lSXDXTj9mVZa9eBaAMbFyZ0h7/mpBnEUC8WaL81phFbxSU6T2VSGciliw5wQg2GY=
X-Gm-Gg: ASbGncs89t5PhA1jyJyyphTWLn5PZRsKmft1cHLIak/EAKlDuMek91GLWHFING636uF
	Ahn4UebjZrrzDVoy+CuvweCwqhx8cSg/2I9q068luwFjMeFAo/yatLrtnD6JwH9ZnH3SQgX3tBZ
	B0zo3TAdFoYTLoHk8HriAd0fCWBRqkpLsWm7b+FZ/tOa+uq+dopHmBymFtNbOT1RYVS4O08dwIW
	mShaehG9IYOpOhrTxIG0DNxVNin2yF5H3RftssETdi37YzuX58gtSt4+jlAqRCIgjxIfmticd+q
	AzJvwZfp7FJuYEux0hLl0CyayT43DWZCfFgESgJdeFrrbPKjYqjLTEUdh+y3hO3K2G43YLrOCba
	HJZu7oN/8RFXjaNz7QERTo2AzcARBpNDKVYOyQAlSkS4qVz+6HtCxuVZJ
X-Google-Smtp-Source: AGHT+IFFJ+Gwq77Z/PIy0XMlE+NNaiR8R9S0OSFVxrU0iuecWvqgNe/XZ2Nw4b7IKr3qQanK/C4caw==
X-Received: by 2002:a17:906:af16:b0:ad8:87ae:3f66 with SMTP id a640c23a62f3a-ae9ce1d8ba4mr400610566b.60.1752745576031;
        Thu, 17 Jul 2025 02:46:16 -0700 (PDT)
Received: from localhost (212095005146.public.telering.at. [212.95.5.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294bb2sm1333325866b.114.2025.07.17.02.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 02:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Jul 2025 11:46:12 +0200
Message-Id: <DBE8G88CIQ53.2N51CABIBJOOO@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Konrad Dybcio"
 <konrad.dybcio@oss.qualcomm.com>, "Will Deacon" <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, "Joerg Roedel" <joro@8bytes.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Manivannan
 Sadhasivam" <mani@kernel.org>, "Herbert Xu" <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, "Vinod Koul" <vkoul@kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Robert Marko" <robimarko@gmail.com>, "Das
 Srinagesh" <quic_gurus@quicinc.com>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Jassi Brar" <jassisinghbrar@gmail.com>, "Amit
 Kucheria" <amitk@kernel.org>, "Thara Gopinath" <thara.gopinath@gmail.com>,
 "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Zhang Rui"
 <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>, "Ulf Hansson"
 <ulf.hansson@linaro.org>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v2 14/15] arm64: dts: qcom: Add initial Milos dtsi
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-14-e8f9a789505b@fairphone.com>
 <3e0299ad-766a-4876-912e-438fe2cc856d@oss.qualcomm.com>
 <DBE6TK1KDOTP.IIT72I1LUN5M@fairphone.com>
In-Reply-To: <DBE6TK1KDOTP.IIT72I1LUN5M@fairphone.com>

Hi Konrad,

On Thu Jul 17, 2025 at 10:29 AM CEST, Luca Weiss wrote:
> On Mon Jul 14, 2025 at 1:06 PM CEST, Konrad Dybcio wrote:
>> On 7/13/25 10:05 AM, Luca Weiss wrote:
>>> Add a devicetree description for the Milos SoC, which is for example
>>> Snapdragon 7s Gen 3 (SM7635).
>>>=20
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>
>> [...]
>>> +
>>> +		spmi_bus: spmi@c400000 {
>>> +			compatible =3D "qcom,spmi-pmic-arb";
>>
>> There's two bus instances on this platform, check out the x1e binding
>
> Will do

One problem: If we make the labels spmi_bus0 and spmi_bus1 then we can't
reuse the existing PMIC dtsi files since they all reference &spmi_bus.

On FP6 everything's connected to PMIC_SPMI0_*, and PMIC_SPMI1_* is not
connected to anything so just adding the label spmi_bus on spmi_bus0
would be fine.

Can I add this to the device dts? Not going to be pretty though...

diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/=
boot/dts/qcom/milos-fairphone-fp6.dts
index d12eaa585b31..69605c9ed344 100644
--- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
+++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
@@ -11,6 +11,9 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "milos.dtsi"
+
+spmi_bus: &spmi_bus0 {};
+
 #include "pm7550.dtsi"
 #include "pm8550vs.dtsi"
 #include "pmiv0104.dtsi" /* PMIV0108 */

Or I can add a second label for the spmi_bus0 as 'spmi_bus'. Not sure
other designs than SM7635 recommend using spmi_bus1 for some stuff.

But I guess longer term we'd need to figure out a solution to this, how
to place a PMIC on a given SPMI bus, if reference designs start to
recommend putting different PMIC on the separate busses.

Regards
Luca

