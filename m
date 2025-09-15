Return-Path: <linux-kernel+bounces-816572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7392EB57596
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2CD3BEF2D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E886C2FCC02;
	Mon, 15 Sep 2025 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WnZPJ9uO"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62862FB633
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930797; cv=none; b=flpXBCVbVMypxcG5ZOr7U+518u5GtkBRllGiWQIimMct8XDkn7UaE/111dGvDPFLz3W9vv6HAzyLK7KW9R+plHNtaIAOIA2hJClk6/+MJQv29rPOX8Mko/32Bh4T5sNKdawPUFyALbwWTSnMFfhADNXqdGmp0zzJ/oUEereZ8LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930797; c=relaxed/simple;
	bh=FVtDEyhzivEYDtBzLVu6OvECCEHWfcGcJe33uoqzARs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eIPXHFvaW8kI6m8KputNccGHqJ3ak0X0kWNTgQA9I9W+09Wiz5we0GFTnjjcSIZByiVqCjoAPet2ogomf85z4vAF3Bgt2KBkcStZigqjrsddm/CrrLpLUWxBKDMLlg7/4MzPY4N/BHLz6VsfxV6d/K7whOMGOeQEaJU4aP4s5uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WnZPJ9uO; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3e9c5faa858so1431411f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757930794; x=1758535594; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfRiNO2xJ79Pmhqk0PZHjgXYh/6g/9bHAaBBwhGvRmQ=;
        b=WnZPJ9uO0Dvtzv3vXbgLwdfbJDGAnqGpaP2kME+dM2r1ehaGba3Oky4HHDyVcVWsec
         LeEdgjsf7t7UD+O/3SbYwGB8yYRvEWUd9LoamBc1QAuw+8Z+ChQuDOO3KyUoahBIyZPt
         4n4dUulyyHw6W3lpYSQ4nMhJGTVOd+GJV+V7Unmuls0U83S+UOnNqTBopvqra9M1sa5C
         vR31uYUjgLNq5+3CNtlM4HbITW8DoD7F6qCKHcJZytuJXdGLO5Ud5rnyW77PIvQqVaSZ
         HjchyQ1Q/wE0MDuJeJv6HQYHGB3wPLo5anxVKblcP28dADgK3UyIP3K/ZzGJC2qz3/lq
         J/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757930794; x=1758535594;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfRiNO2xJ79Pmhqk0PZHjgXYh/6g/9bHAaBBwhGvRmQ=;
        b=ofs74yx3hvS2LPFJlgV7jpYEXHkz6eoyweV4WK4fEoXNN9F4nqJFfPlCUEJkIq3th+
         NuJnrjNDQFoTBq0kHjMVKjNazyVLAXbkpHmek8Ww+XZLxl5Qy0NLzMdNqd5tWBU7y6sK
         aipoVgsx2EKHNOLnF591nnJlxSon0+hvmLeeXwg3lyTL52Z7s+RKXaHOfeWtxRlZn1s6
         Zgm9aDUhgRqWDDZGdjcmTI73dzHxYSk+RL/bsNxH5Ys70NFeE9VrtPH71jz/Lk/NZqyy
         j72OLrEflvJKzDc+HvZT4fTe0b3U1rbOgB5WUtcHZlPv3fddL8N9I5vABeebRR2Q7JLD
         o7UA==
X-Forwarded-Encrypted: i=1; AJvYcCW4d1u8jVg8+ucA2tZ1KU5mGT5nAfIG94sbyX8+kWtdbs4IXI6dYlEluKUg7sCRhqej4awFOZ0R213k0Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXAWjY4KKYWOBh6E0VvwAnYpCmQclBWNlHht07BmolWZ/L8OEe
	OPMUCG8DCes3aBJegoKE7o04xoUKbgT1CnyfH1G7UPwO4nMbVVuPVwLLY6j9WZvRrdw=
X-Gm-Gg: ASbGncuj/Oev6NtbJLecRBGcStyBkMChrylNNgwL1lPHVW6x0zoNx6SXv47XVIfNZ2T
	3JAFY5WqUPZqjrH3EMSpbDRpAEHXncstO0XgrE3HAuZjagT+sMuTvMP4aHeyuEJtBwEcV52NGFE
	M/pooKSytWPTnhhjQWssGqL2yBqtErYY0Pq3QjsOb2HbpIgnt/IOOL806iWJ0eiIXk7MYUfk858
	Lit+BV5NIdpYrHNWAwzVMDuLkQbaSJpiL41YsHjwoltP/wuHitGbWfca3SqBgzaOa9YGPxUY43w
	Cbxw6XvG7svGvPQFgez4dYFwn2v1B2PkCHBrvo0mLalO5rnEhxbY7QxMSU5Du/O1BfZojSTnm2Z
	BOzmEOxFlAkQWPxuQuBhNLDicKXSe/tjmAGw=
X-Google-Smtp-Source: AGHT+IGnBbR22+yZ6wbT0d5fNLxs2hPWBuABHC61EZiUtaPF807vYAvhobY69/kXqUXh8/m2svgb3w==
X-Received: by 2002:a05:6000:144f:b0:3d8:1f1b:9c9f with SMTP id ffacd0b85a97d-3e765a160bfmr9984479f8f.55.1757930793955;
        Mon, 15 Sep 2025 03:06:33 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:41:eee1:5042:e713:2e9a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd4cdsm17209127f8f.37.2025.09.15.03.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:06:33 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 15 Sep 2025 12:06:18 +0200
Subject: [PATCH v2 7/9] arm64: dts: qcom:
 x1e80100-dell-inspiron-14-plus-7441: Enable IRIS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-x1e-iris-dt-v2-7-1f928de08fd4@linaro.org>
References: <20250915-x1e-iris-dt-v2-0-1f928de08fd4@linaro.org>
In-Reply-To: <20250915-x1e-iris-dt-v2-0-1f928de08fd4@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Anthony Ruhier <aruhier@mailbox.org>, 
 Stefan Schmidt <stefan.schmidt@linaro.org>
X-Mailer: b4 0.14.2

Enable IRIS to allow using the hardware-accelerated video codecs. The
firmware is not upstream in linux-firmware yet, so users need to copy it
from Windows to qcom/x1e80100/dell/inspiron-14-plus-7441/qcvss8380.mbn
(just like GPU/ADSP/CDSP firmware).

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts
index f728d298c72f4bf2ee151698e36108fdd7a8e5a5..cf2a7c2628881e44f093d73e6496462c22326d9a 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts
@@ -37,6 +37,11 @@ touchscreen@10 {
 	};
 };
 
+&iris {
+	firmware-name = "qcom/x1e80100/dell/inspiron-14-plus-7441/qcvss8380.mbn";
+	status = "okay";
+};
+
 &remoteproc_adsp {
 	firmware-name = "qcom/x1e80100/dell/inspiron-14-plus-7441/qcadsp8380.mbn",
 			"qcom/x1e80100/dell/inspiron-14-plus-7441/adsp_dtbs.elf";

-- 
2.50.1


