Return-Path: <linux-kernel+bounces-775497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E200B2BFD9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077E51BA8354
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ADC322DC1;
	Tue, 19 Aug 2025 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGUxFZCL"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9532C31A042
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601704; cv=none; b=d/7gAZuhueAaugxH1Tt12IxcE2KKauVceqfg7iX0do2sXjB242WNsFAeECj6xnLG/fKp2LqJ+rX1Ll/+C7ohmTOUlLkZsPKcR/s0LYktgMEA35g4OpwCy/8Blc5fxm0TeEhc9aiWth1MgILYKts2o4vleqoS/c9t8y8Q3mWLC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601704; c=relaxed/simple;
	bh=8kLogn+zROvMNiYZTIrHFCqLRK5ZGsChFJjCJtBpXXQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DG2MP8mfLyYd8imXofrU3JRLmYZxnC6UP7kK0gH2H/XIIexXDmNtu0i1HwL4igyplQ/YK/xxNX/WQc3MOYtRmxH1b6pcunVs642PJIghvnMX3Px3klMRLpGKAhO1O0HGrxH3G6d8TDttsV4z/rsM3JSUcEY3GR7HVdmI6Rcf4zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AGUxFZCL; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b6f7f15so6795553a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755601701; x=1756206501; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zpYVbUYUqcDwuuSlMJD7l7rhKZ+sIG5CmBcL7Jvhb3w=;
        b=AGUxFZCLvSJcmZ3Ru/CX8HeOwXl96Dl+v+Lfvq0Te5Yz1rQRQ7QKPPmbaHzDnb4c5p
         IxGD9WpP0F3fZUuoud8cpKcexrYOydgsKJVE1rqGEbfJocDMB/4R98S7gKETMaxq2nJB
         f366eiYRTYay+Vz1uP3oV0K8+Q+QZIhqbZRXVGiovdC0bGnmKjjea1ZAccCVTzt8WvRr
         drZgaQR0cMrZRrnXaU1w5nq3SmxLAOMDa9SGc0gpfmID+pt9kBPv1Wwhit7lJeyeTbtp
         ZaVYUWA1ikZC/PYcwov9nMSMWb7dfe670Q+B/2ClRpCwcceKTJdOfKyuob7XRNU7F5+U
         8ksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755601701; x=1756206501;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpYVbUYUqcDwuuSlMJD7l7rhKZ+sIG5CmBcL7Jvhb3w=;
        b=EUHREZ6jTzm+I18XOy5sM3IQBg8IkRcq9Ppma2gHRSWGij4ATvkT0epKd5OVs8Nq9h
         ETyzyg1yA76sZAAgd1zX/xdXlRdOLvrHBw16LdtrtD95wMS+vwL16tFjqdc0FCfKRkIv
         5ygakI3IN+xUhdysFR2WBdmHoPTOfHwlKHLCs5N0q//Rx6jYiwrwyqG9bLVB+D8NCvUj
         tN/DIfr3kxOjqMO1IJVbf0leE2N+dw6cIYSNt40oidIavMFYqzAcYwMaNY+Nn738d3gz
         XPIUbz1W3RMjVsWUfmlITXtciAELIUyXALgs+9sJFmarADbRRzpsQ0hg3jAWnygd8jtm
         yMtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0D6tM6rTe07SE7E+NzIR7d0yX8gS3VFSLxY0smNIMtPhL0cryBEip5XIEAnEduiObdWZ22ltR11tvMHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YznAYYy9bpbYq9/L/sv+OS19FoANAGAfkISCRjM0rR+eRoRyUAQ
	tSDBa+Z2mNj/6QR7JY9/u6J4ObLMQz0JBK+rVG5a/OHhxF0+kuGFz+/gsU+u+6UDcbv2BuwwHWa
	E93Uh
X-Gm-Gg: ASbGncvgi1EkMewKQZgh5iycKFDBLehYkcfha7z0jD9Zn6NdQG23GaGEWZhCMG1/6TO
	aGL6SG4XVOM02Q3ZDuyv9Q3sTZj1RoRc3Gc0h42pshqWaFvSXsaaZJFramf55YWkjkm30zENE5Q
	ig9PKKotjJhh1sp3H7qeIWR65jfqlQ2/n2Qros9EHzCG3U3VnAt4vs5QB1d8EsUlcYMJNivDWVk
	HLVgddvinzzG3+w49mN5Gvp5SzLfJjTlYrymAOJs2hCxdGgEG61tvsq/75sD3SwRFNu2gB6wP8y
	gUji3sO4TJthiHaRaea/QlQNc3a1JmHax+lPBlYEAaW9uJlv8AMrzGbyLyCvz7sjLJlzOSq7BA6
	FV931Gk1rOMs/rlpZsydcmhwsDCgIna6gUOCSPPDjTd7Rpim1
X-Google-Smtp-Source: AGHT+IHuAC+MgtHl12YlBZLIPfcn6x8+4lFFpvTHdB+kHzp1vEXmZlY+oQp1EWwCza75NIX5i6Z6gQ==
X-Received: by 2002:a17:907:2d94:b0:af6:2f1d:a73f with SMTP id a640c23a62f3a-afddd243cf6mr200366066b.53.1755601700814;
        Tue, 19 Aug 2025 04:08:20 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:db5f:8096:4609:9b24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd01096csm974845466b.88.2025.08.19.04.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:08:20 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH 0/3] remoteproc: qcom_q6v5: Misc fixes to prepare for
 reusing the "lite" ADSP FW
Date: Tue, 19 Aug 2025 13:08:01 +0200
Message-Id: <20250819-rproc-qcom-q6v5-fixes-v1-0-de92198f23c7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABFbpGgC/x3LQQqAIBBA0avErBtQybSuEi3CpppFWiNEEN09a
 fn4/AcyCVOGvnpA6OLMKRbouoKwTXEl5LkYjDJWed2gHJICniHteLaXxYVvyth5b6bZOq06B+U
 9hP5Q1mF83w8c8LnAZwAAAA==
X-Change-ID: 20250814-rproc-qcom-q6v5-fixes-9882ad571097
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.2

On X1E, the boot firmware already loads a "lite" ADSP firmware that
provides essential functionality such as charging, battery status and USB-C
detection. Only the audio functionality is missing. Since the full ADSP
firmware is device-specific and needs to be manually copied by the user, it
would be useful if we could provide the basic functionality even without
having the full firmware present.

I have a working prototype for this that I will post soon. To keep that
series smaller, this series contains some misc fixes for minor issues
I noticed while working on this feature. The issues are present even
without my additional patches, so the fixes can be picked up independently.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Stephan Gerhold (3):
      remoteproc: qcom_q6v5: Avoid disabling handover IRQ twice
      remoteproc: qcom_q6v5: Avoid handling handover twice
      remoteproc: qcom_q6v5_pas: Shutdown lite ADSP DTB on X1E

 drivers/remoteproc/qcom_q6v5.c     | 8 +++++---
 drivers/remoteproc/qcom_q6v5_pas.c | 8 +++++++-
 2 files changed, 12 insertions(+), 4 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250814-rproc-qcom-q6v5-fixes-9882ad571097

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


