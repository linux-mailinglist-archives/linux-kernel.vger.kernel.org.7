Return-Path: <linux-kernel+bounces-620133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761F0A9C620
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 12:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6364C11F9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 10:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24CE242D75;
	Fri, 25 Apr 2025 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="sbHpT1Ik"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FFB241CB0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745577983; cv=none; b=E09YDiC4mEstv5IIAQoe+PxMgWvO8vCfQsgAIR1ncjPu02BHfd9y+y/83Ew3oFJNmBWhO2cAqhBUDhcmJc9YYEkVT2XJO5RI94f0q3+ZYSO9cWrMw+HP/4Tni5nRM1wHgbeSLJEQ/Zo/mqFKNQwe49aNNf/GkWthwWUma1kZZDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745577983; c=relaxed/simple;
	bh=iR2QT+Zg01hyvLuC1uGIBDhap77AcvqLegcbTN6o5ao=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MROHyElD1xxZvATXGjXZHLrOjeH5MGgcnzIPBFuiYNtTexI8BQUUu7zHoauEI1+0mIkoDJICsNgmIS9cvGVYciJLLLloeyslYFjAbZ+WhgWJiCAbOZ0YekVwNhASw93SybdhlTykqUnaALydrr6yB8t6n2h0MZigUnK9POmcV+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=sbHpT1Ik; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso458247666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 03:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1745577980; x=1746182780; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F5pdq7YWG26uzjKtEY1JA4Z5bXu9DJnS7vVzc1STMdQ=;
        b=sbHpT1IkOzmeeSzCxZ9PoimUQvV+x7lwe/9PY2GvZXCaX6Y7zKRh/OYkf2Y13eAS0S
         7JGSoNe6qdCp5d4I3Wnx8jBNN/AhVOEjnLG3Tl4KYJIfvQ0TTcWJYCEZBL/QWCEOsPn5
         ATZft6tJ/78xTiaU6G3ChAUQQuAL9MK/YV1wOC5B3dUr8kt/mgz0dIHM/nOlfeWPylQX
         aJQQt1BmbM1IlCcTIYuck0pdVxIi2POoy6uKwxHvBFKIkx84hkY3ePvIR+LBhI+ayKUZ
         Qft7RaC+76ewe4Fpx5Ezh4f6MPf9WNVf1sVS98uPThh5NNcCVHLxJodBYgp6zsIWD0X1
         hB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745577980; x=1746182780;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5pdq7YWG26uzjKtEY1JA4Z5bXu9DJnS7vVzc1STMdQ=;
        b=OBcJ64mBOK3OFVeyywIh3tfnMVZJO75pcLm8JTCqPd9IXL56wf6hLrepuVPSpAE1Vl
         YXN/z6bI8euCvqnSrCsMCAA4mQ101ExD7En3MzNDdWWCcjbWB/GRhr4ld5SYZ6aiu5mz
         uxQf3DmvkieaPLRGZy5nyXhXRQSoLBFOWejK/1aqBxcqGFY28I5PK+j50VzXY4HTuac2
         +5+bURxB1iy6VOmUbaLvefpk3EArDemBF+TSMKVn0Ifnu+B/jv/ImHG4HULW2VYQCDCg
         JmExEBLOmhvHjfDjDYgUZtbHEitaVg3CrmzhWXBSxLL7JSqaKLeknomjr/FK6O2GAj2w
         Pemg==
X-Forwarded-Encrypted: i=1; AJvYcCWEV0W5Ivu3tz50uSmgVrGYizv1GIOjhDKqINTm+pnVlgue22M+06Je04yO2owmYUS+l8Q+mMgpq3hPO6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA2aLqD4ttfPJ2c66KC+YG+qZTqasZHsI1984924nM0AX0xsxf
	eJkyqHOQcTyDfBm1kUovzfzc/W6Kao3eH46IQViykf5qIGlszwRO/1ai6vkmmkY=
X-Gm-Gg: ASbGncv+JmH5PIft6ybKwKSk6hvG6hMSwkJaiK8t5POBBmyjPhC1Hj5GhV9tEQQ17Ht
	g9S0F40gnu5oU0GVKeGl8j25Bzf2NGQKLDl2s7ElN2M6LZPLJNgZHwFn7H1qSUDY5bAeDGkU6jo
	04IHmeLNn7izFnxTD/ufgrd+j13PT0ddtdEptRG+Oj6td28rvpb4AjkM6L/Q6kjnmuhJuKjleDJ
	ogAnq0skxOEwl+wlnb+1ePEomZ/J8e6mugzKLNIMrFjB4nvb2XLRo5m5Fsdkequs1XwTQFdXraH
	MUk9RCcUrwU8D1LJB2DULD9vCbMC2V4pXpt6Lvc0HH99TzS9jQo7hqV9q1cGzEB2FsoO47uwlIx
	7pcjye0kekWZlcqncwaDANUfrBbal7u/l9OKFMM/56yNDJjfay8UuoGf8
X-Google-Smtp-Source: AGHT+IHSxX/4jjLy6bJkSV6P+U4/wAbIHKbnuTnzx0/zGfV2LeBwe4KdUt0aEmPPO4N6P5r4/cis2A==
X-Received: by 2002:a17:907:9349:b0:aca:d6bc:c6d4 with SMTP id a640c23a62f3a-ace7133c372mr148895266b.37.1745577980079;
        Fri, 25 Apr 2025 03:46:20 -0700 (PDT)
Received: from [100.64.0.4] (2a02-8388-6584-6400-d322-7350-96d2-429d.cable.dynamic.v6.surfer.at. [2a02:8388:6584:6400:d322:7350:96d2:429d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e4e7b98sm118765066b.66.2025.04.25.03.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 03:46:19 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/6] Enable USB audio offloading on Fairphone 4 smartphone
Date: Fri, 25 Apr 2025 12:44:50 +0200
Message-Id: <20250425-fp4-usb-audio-offload-v1-0-f90f571636e4@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKJnC2gC/02Oy2rDMBBFf8Vo3QFJo4kfv1KykDSjVlBbrhWbQ
 si/VziLZHkO3MO9qypblqqm7q42OXLNZWlgPjoVv/3yJZC5sbLaknaWIK0O9hrA75wLlJR+imc
 Q4j4FIrYDqrZdN0n57+x+Xp+8ye/e8renfNWn7myjNVDnC5IGv25gKKH04oSinw6j3v+cC6cHP
 bY3BLxCLfvCELC/DAm1GQNPx/kj+CoQyzzn29ThiKwjuegFDZqexftRO0TbbOLRkWsqRHV9PP4
 B8hLCHBkBAAA=
X-Change-ID: 20250425-fp4-usb-audio-offload-e5d7fb55d283
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Wesley Cheng <quic_wcheng@quicinc.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

Since the series for the USB sound offloading driver was finally merged,
we can add the sm6350 dts and enable it on Fairphone 4.

A few devicetree binding bits have also been missing in that series, so
there's some extra patches for the basics in this series.

Depends on:
- For qcom,sm8250.yaml & sm8250.c:
  https://lore.kernel.org/linux-arm-msm/20250425-fp5-dp-sound-v3-0-7cb45180091b@fairphone.com/T/
- For dts:
  https://lore.kernel.org/linux-arm-msm/20250321-sm6350-apr-v1-1-7805ce7b4dcf@fairphone.com/

Devicetree patches go through qcom

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (6):
      dt-bindings: usb: dwc3: Document usb-soc-be property
      ASoC: dt-bindings: qcom,q6afe: Document q6usb subnode
      ASoC: dt-bindings: qcom,sm8250: Add Fairphone 4 sound card
      ASoC: qcom: sm8250: Add Fairphone 4 soundcard compatible
      arm64: dts: qcom: sm6350: Add q6usbdai node
      arm64: dts: qcom: sm7225-fairphone-fp4: Enable USB audio offload support

 .../devicetree/bindings/sound/qcom,q6afe.yaml      | 13 ++++++++
 .../devicetree/bindings/sound/qcom,sm8250.yaml     |  1 +
 .../devicetree/bindings/usb/snps,dwc3-common.yaml  |  4 +++
 arch/arm64/boot/dts/qcom/sm6350.dtsi               | 11 +++++++
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  | 37 ++++++++++++++++++++++
 sound/soc/qcom/sm8250.c                            |  1 +
 6 files changed, 67 insertions(+)
---
base-commit: 393d0c54cae31317deaa9043320c5fd9454deabc
change-id: 20250425-fp4-usb-audio-offload-e5d7fb55d283
prerequisite-change-id: 20250321-sm6350-apr-15f3e7e4e5ca:v1
prerequisite-patch-id: 69859554c94de52068406dab0d2869ca26072c78
prerequisite-change-id: 20240809-fp5-dp-sound-b3768f3019bd:v3
prerequisite-patch-id: 2d8997a2be02cfddf3a054c79e7eb308a6d06710
prerequisite-patch-id: 1b7c8f00ab50ae71c0221868578b9c1dfe939e4d
prerequisite-patch-id: 4fd0673c4d35c1fefce63ec5785ff5ea67cc3d3a
prerequisite-patch-id: f5ec3a893de19900f62dc691d83986f1104914b0
prerequisite-patch-id: fce7573c39e768f7a09c002064b6159b8e91161a

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


