Return-Path: <linux-kernel+bounces-753424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC4EB182C5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC37018973F3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11DE263F38;
	Fri,  1 Aug 2025 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="O+zI18Zu"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7213135977
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754056280; cv=none; b=Qhn6H56mQYEtQcLPq656PHI2X8/9U8mVi/gmIe91AbUWfzjrxWOvfW2miAljwSaKC1Qob4tWxnBSnenqCoIwGMIu1w/kqd6vQQgQB7uRyaga+J51OxNx6wTdArT59mzvTMlhgAtR3QKzbkvHhXIohqSdLLkjNKtNmGLneUTk81o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754056280; c=relaxed/simple;
	bh=f7DBa8aIM87H/wznrMRy91TdwWbPJ2VA27y904OF4cw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mx77MHwGjLyPAUTAkTLGEqPWOW9OiPnMkEKy0oCz1vGeHAJSVAaybECPzi+FD7zNLZ8OAJb9yk8J1vkD9BaY5V6qPo1xVgkytBT27PhXzFqllrlsgnO3O8U3s0wkLJ5XZNlAMKgoneFlJyYJlZmYLNPexohtR26rFAfTAejCzdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=O+zI18Zu; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-615d1865b2dso994421a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 06:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1754056276; x=1754661076; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0spx5wifJ5o/D9V5nFeVJSpM5aEaHKsTuID1NTIGBPw=;
        b=O+zI18Zu5YXEZfqwfqjUGp4R9L9ONgtpB/53e3kluxKibmNwNHKfwUuFiS3BOjVM0c
         2zWGGdRw8CInmtFHAaLj0lQ43IisbM2461R4bw+b/FTc9O9R4T+UdHzrDxSIipWgel2I
         fjctY0ZPI4dI8x1mOfwvzrrCSvn4xJ4/HlBxiyInct9hPoM1+zOmgApMDv47TK/nGIVf
         FAhpD2gHSAW8g1YDhY3D/fvCgTo6xQmBrR3AiSjcAkqQEgT3wyZ17nJ2dqyfUwR/aTr/
         vHAMkpY+UAlLYWb0kZISbelb5Z3+3jl8t8fdqSGoupppFfOqTfVcKTTnZhhPAl+zMD9g
         oqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754056276; x=1754661076;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0spx5wifJ5o/D9V5nFeVJSpM5aEaHKsTuID1NTIGBPw=;
        b=FA4jn1l3lt7wCznWC5zlLa1qsiplxrUKjgREWExJqvdmvjk6n4mEllfnMenoxpJfsC
         rb/qN7na29YS0+I+OyoF6CQS1rMjRAOtlzKuec2rfAuyOGeNI3lAY5Kmgs6dMPd2TCKL
         kmapC2PwrLy+J6XaqIa/J2hBZGaqzUiPZT2W3tZ/GRcKqwNaUNRLnyGvYPSdARzDUdpU
         aswjXdFSwKuRPpMQNoHouM8KYp8+cyTWNpIGJNwVctwwbpDIdCM8jH84fMYcz5cf11lX
         1SVCH7v5QDfife+GI15KLxZEAhVantTWE+xJxheFz7KlDi+SrYNt86XH2hwOUEXIhkbj
         9GiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0IQvm8IRrDE4X86f0K/kADAB3RosDXgMPSiInaSqSiTk32dru7vptr5NO1a1vPeIQFbJKuUpgYMjkEH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVwBALqEl82eRkMxJpBSRcFkzMPBfqJhrElhmzlXiBSWPYHRpV
	VSO2/dlYY4Bek/qhk6Qiiq9fRY8+p7j2o7PRAIPeNCFcWzlHl1FKiE3RZad+Uz1u0VH+v3+E1mM
	oGfKfI3A=
X-Gm-Gg: ASbGnctbZBSXN9PBi4VnW/w2hcfLbNOQuYLZVgBg1zIY/wc+35w0xOw9UmcuvwLAfSS
	MK1w3Sif8xkpwH6JOzpKXVFlYyOWvqVpZ+F+bfyA6HRnDS6KRUSU/EBx3klvI67KOxZOOgXpPBE
	NZk4vF8X9ShxRqyfVjXcFK5RbJyVbe/Lb32VAN7BFYSFbuiDP0Uxx9nf6UJUEX99VY/TMllDXVO
	u+9emc3juXj2PjZeesT+1VGKIaMzQG2mlwSccBWwUpqo5s0E8Z7lz4Qq7qTEWHF33mKvEh4oLgn
	SsL6HnJsJpErZqXTQyy0V1D1g7owq8ee8Zz26pr2XvGRpINEZRQcYoceMuWpHu3yz5Wf3KV1h14
	7NJ6mYdx4op6R8MJKcfOOT0+ghZhqVY+SvQeROyBHJbBokjci1j3BgbFUUVMH5StVQuYG
X-Google-Smtp-Source: AGHT+IFBFj6qvGzUA5TiTKTtAxzZl8bkRsQ3p0gCkbRYNJdt2Y5ggC5CNo/vrRAuqRiyHKdxaZpFig==
X-Received: by 2002:a17:906:f59c:b0:ae9:8cb4:2fe8 with SMTP id a640c23a62f3a-af8fd97327fmr1229928766b.37.1754056275571;
        Fri, 01 Aug 2025 06:51:15 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af92a2ec9cbsm180542266b.79.2025.08.01.06.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:51:15 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/2] Enable USB audio offloading on Fairphone 5
Date: Fri, 01 Aug 2025 15:51:04 +0200
Message-Id: <20250801-fp5-usb-audio-offload-v1-0-240fc213d3d3@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEjGjGgC/x3MQQqAIBBA0avErBtQQaiuEi0sxxoIFcUIxLsnL
 d/i/wqZElOGZaiQ6OHMwXfIcYDjMv4kZNsNSigtJiHRRY0l72iK5YDBuTsYi8rMQk8kZ5IWehs
 TOX7/77q19gE9UTaxZwAAAA==
X-Change-ID: 20250801-fp5-usb-audio-offload-2a9058e19e1d
To: cros-qcom-dts-watchers@chromium.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754056275; l=799;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=f7DBa8aIM87H/wznrMRy91TdwWbPJ2VA27y904OF4cw=;
 b=wBSDVtEogu9N25o2CPepXLGCoT6+KbcgLLShjuNNC0VyjNyRpb7ur/7QnVvb9rce8bRg3WrjI
 kOReUgGS88xCXUk4kCg4hK/jJqMNY4bRN0hc6nmU0Pu0sfGqzRW6qOM
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Similar to Fairphone 4, we can enable USB audio offloading quite easily
on the QCM6490-based Fairphone 5 smartphone.

This allows to play audio via a USB-C headset with lower power
consumption and enabling some other features.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (2):
      arm64: dts: qcom: sc7280: Add q6usbdai node
      arm64: dts: qcom: qcm6490-fairphone-fp5: Enable USB audio offload support

 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 16 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  8 ++++++++
 2 files changed, 24 insertions(+)
---
base-commit: 0b90c3b6d76ea512dc3dac8fb30215e175b0019a
change-id: 20250801-fp5-usb-audio-offload-2a9058e19e1d

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


