Return-Path: <linux-kernel+bounces-768900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B876B2676D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E5C74E4EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CCC302CDF;
	Thu, 14 Aug 2025 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qtH4mgru"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0EE301019
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178244; cv=none; b=PhqSeKjMBEz2GLo258F/021Jpl5FMor3ekPJQj7DjXuDULRGcfOKX4nJffwcFRPv/lWtYROUqhcde7oidI2o75M4RFZ3sCpdvjwSapBYrN9jY5xcM8phw1TrkWzKnPJe0MNL7gWhSWiIiAu96bvcpReyDf93S0xyzPcr5jLKLqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178244; c=relaxed/simple;
	bh=1c9h4jSCfIJa9IllJoy3l19vjPB9EfbWt2TwOkJ64nw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NouweGAt/eytj97pwWt8LGFIEbWqlHnjz+cyalnkyiMzm5oDS/IWvEZeoa8ozNJh7nYqhPLhxRw4Xaja01QhDCyCuhavU9wojqzY0dchvH2Aikk/9mlABVBJkSMIu2O32i7GYT9cl/oXEQ2M3T/5BKzLChaGjre0LOJ08OeVNJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qtH4mgru; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b05ac1eso4171115e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755178240; x=1755783040; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+b06tuUFwG+aodZWJHCSKblkyc+YbMovEs13xFG5ai4=;
        b=qtH4mgru/6uElEUP0B0arAocrISPIlnMey65YGFxVLcUVKmXEx7lQrGlKoFGw5otdn
         uwMmkHqKMI8rpkTKNhqaSfYY0qsIzFD3KV8Dkqb+Fm6guTyYDDYHCPJFyxUu5lg5pYTF
         5qflSns9VR4m8irYjDWMMe87eZ1P+owYSh6Jm1Fl96984ck2FB0P1ezAuieq1vEAjQ0J
         x+iwocDGWxSBNrBoWel6w5OFCQzzB6CHrY5OqT0xD2+2yjZRiO3yxAUfjvdfuWtn18AD
         AGnOfjHYK/I61SuHIyuWNXzwseiGGjTX2TpDfuCojkPHlTwvpyi2PHUmkLHepm93oTOB
         sLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178240; x=1755783040;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+b06tuUFwG+aodZWJHCSKblkyc+YbMovEs13xFG5ai4=;
        b=nVipVzH5wnaOqb88fg6M0LJMLpMd45L6cOI5y0CllbnveZC+L4BGOty2rw+3g1/zzW
         +g62c1VpimW1TZAOdMMm7weVyY6b305lwrvgqgl4vNZqnzXGrIKjFDkwU59r9LuJVz2F
         vxyzgHH/YwD+ViM/0PZ7J80JAc0u6tcewAf6Icq/U2A44xfLx7H1uyfsD9rXWHwXZTuK
         dTfGGGOX8rgj0N0KnBMTuxLR/Y0EuEXaA+xE+mD2GVSK+dAVDZ2hIZXAoMLnHteeQ4lg
         uwW4lgDqEqe7mwt/nKz7eEWamzbDn7kQV+SLnZWdVYCyzZewFbRDcbuBB3h3kRGOinKW
         moZg==
X-Forwarded-Encrypted: i=1; AJvYcCWtaAsH4uOxqHe6IXKYGzvAZOrq5TDf2Jv4z0IJ1R7R/x6hsF6leoPn3pYRY0hyt0+jf5EP3i4/Kw73t1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEyzR2YHz8H8lxsqSsLTK2aFjc8GavS4FB/t2gg6p5xhi434iA
	HSf7INt+8bTw8xFRgf5xjgg5QHy3ANKOdMRT3I5iHZzSfZEKTwveudA8hlONC6yIM/U=
X-Gm-Gg: ASbGnctSmTg5juDYaYNL+pWWqUNnUwhpRNxTlx1QeRnlK3a23f7RaGUXKDvINIo1Tjl
	DFKofhMcgrQ7WRn3U0V9Rn/vOOoMVarvZA8vFu3uutOGujNA6/zmQ2nHfAIlFI8q4AS7ej/qMwi
	gcuFcKyD8rySnONsMLSskBbbWFBXt6C457HJ4WFYqEA5BmFBJFk6AqCc3bzO76/KCXmFNoWrYnR
	cRYMeJFAJxTeRoqzl85XFZu2PVlLcfuTnohuI0AE8wIEpsCGHy+TSRuLde62vND7j639Eyghr1Q
	F48GBoW0KPktWjWddL0oqUIJGroRF0Kp5Wp2QPK5jEEUP0+V/8YwBYC88f6MS+hFSclqT0rUDU9
	bnhah4aFqCHVc+QubtXbsW+0h9CJ7jKnXPddYAzxleMPFD9w=
X-Google-Smtp-Source: AGHT+IH4II5i5j5NzWBCbNzsvTmaupMtg+t9JB2fDAE5Tm6J2vqU0178FXZFpritPOrMtJFLWEfs7g==
X-Received: by 2002:a05:600c:1c15:b0:459:d494:faf9 with SMTP id 5b1f17b1804b1-45a1d1f530bmr21113245e9.10.1755178240015;
        Thu, 14 Aug 2025 06:30:40 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:9c1:e029:fc81:a800])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bc85csm21468385e9.5.2025.08.14.06.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:30:38 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH 0/9] arm64: dts: qcom: x1: Add missing pinctrl for eDP HPD
Date: Thu, 14 Aug 2025 15:30:27 +0200
Message-Id: <20250814-x1e80100-add-edp-hpd-v1-0-a52804db53f6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPPknWgC/x3MMQqAMAxA0atIZgNJRaxeRRyKiTaLlhZEEO9uc
 XzD/w8UzaYFpuaBrJcVO48KbhtYYzh2RZNqcOR68tzhzeqJiTCIoErCmARHdjSufaDBEdQ0Zd3
 s/rfz8r4f/nePQ2YAAAA=
X-Change-ID: 20250813-x1e80100-add-edp-hpd-91209c5a0720
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>, 
 Abel Vesa <abel.vesa@linaro.org>, Xilin Wu <wuxilin123@gmail.com>, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johan Hovold <johan@kernel.org>, 
 Christopher Obbard <christopher.obbard@linaro.org>
X-Mailer: b4 0.14.2

At the moment, we indirectly rely on the boot firmware to set up the
pinctrl for the eDP HPD line coming from the internal display. If the boot
firmware does not configure the display (e.g. because a different display
is selected for output in the UEFI settings), then the display fails to
come up and there are several errors in the kernel log:

 [drm:dpu_encoder_phys_vid_wait_for_commit_done:544] [dpu error]vblank timeout: 80020041
 [drm:dpu_kms_wait_for_commit_done:524] [dpu error]wait for commit done returned -110
 [drm:dpu_encoder_frame_done_timeout:2715] [dpu error]enc40 frame done timeout
 ...

Fix this by adding the missing pinctrl for gpio119 for all the boards
supported upstream.

I ran into this issue on the X1E CRD while testing some things and had this
fix in my local tree for a while. Chris made a similar patch for the T14s
[1], this series fixes up all of the boards upstream.

[1]: https://lore.kernel.org/linux-arm-msm/20250731-wip-obbardc-qcom-t14s-oled-panel-v6-1-4782074104d1@linaro.org/

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Stephan Gerhold (9):
      arm64: dts: qcom: x1-asus-zenbook-a14: Add missing pinctrl for eDP HPD
      arm64: dts: qcom: x1-crd: Add missing pinctrl for eDP HPD
      arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: Add missing pinctrl for eDP HPD
      arm64: dts: qcom: x1e80100-asus-vivobook-s15: Add missing pinctrl for eDP HPD
      arm64: dts: qcom: x1e80100-dell-xps13-9345: Add missing pinctrl for eDP HPD
      arm64: dts: qcom: x1e80100-hp-omnibook-x14: Add missing pinctrl for eDP HPD
      arm64: dts: qcom: x1e80100-lenovo-yoga-slim7x: Add missing pinctrl for eDP HPD
      arm64: dts: qcom: x1e80100-microsoft-romulus: Add missing pinctrl for eDP HPD
      arm64: dts: qcom: x1e80100-qcp: Add missing pinctrl for eDP HPD

 arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi           | 9 +++++++++
 arch/arm64/boot/dts/qcom/x1-crd.dtsi                        | 9 +++++++++
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi | 9 +++++++++
 arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts     | 9 +++++++++
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts       | 9 +++++++++
 arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts       | 9 +++++++++
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts    | 9 +++++++++
 arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi    | 9 +++++++++
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                   | 9 +++++++++
 9 files changed, 81 insertions(+)
---
base-commit: 33a21dab19b31540dfeb06dde02e55129a10aec4
change-id: 20250813-x1e80100-add-edp-hpd-91209c5a0720

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


