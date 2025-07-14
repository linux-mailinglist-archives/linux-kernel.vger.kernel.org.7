Return-Path: <linux-kernel+bounces-730143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 591BDB040B1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DADA11890502
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AA22561B9;
	Mon, 14 Jul 2025 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQVM943a"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5FD25522B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501324; cv=none; b=V1cBW/oQMKhk0nbzT+XpMiEoxWwvxWzdeub3hSs/+iTeqmuWoFpqgQePbsdfn6P8LmmjO7pvV4ksRPc9H6RGZ9S9nrexgOAAJGqEWSjMgOdOb8QEzAjoN7xWd7cMVTIoMM8nvMYgvmn7kAYlIJ2KOkVgrPLZizuu8jcj4PyQhdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501324; c=relaxed/simple;
	bh=DYPaM1sSsYolxg2BQv5NXOXylFsZZtxEsSUpo/VrO5Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Mx1LyODixIk4h+sIxaOi249u5NmJ1LSJ4xgQm//LQL9pRU0kOQIJgnnEPVnbZaD5lqUGC1SHT8B5KWLdH8DRRsyi5HeTzQWbCuTXi9rTVQPdkbd+9A67tbmu0SuPSn5RxtF3dqpHhOWL4yI7Mrxo9jmCONO90Ssj8IQ5RO+0Z48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XQVM943a; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-456065d60a8so958705e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752501320; x=1753106120; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uMsS4p/8HnnLMPJhpx5xJwxdy+uDVUjnjy3BTfjqkVg=;
        b=XQVM943aRn0Yiw+k3zUGX2YK4n1D5g5zWSPg0jpvxet1lJuuWn/COxyNG+zmYyD6qt
         0PIZ5OQkCjptLdB252aueHdFBgid7q3MYbyJR/DmOSoL6LBMq+/nla6kXzYA2+q6lBTD
         oU08y3lVLcVuIVJQS8fGU2b1Y0NbjgdPNzJnnoL8L0LH4z9NgLrJ4m+VmFv+hCD4n+eI
         7mGhU/oxM7NQgsEZ3coGEiDNYy05kLtstbpd9C9d8IfhzkLD09pH0E4X4shvME5BISmM
         RlL1enh7NpqOWvKy/6pS5lF/D26SB4ZBhPv+c/Qa4wQ3GRxRRJ8puHRX2IAx523oQw3J
         4Qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752501320; x=1753106120;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMsS4p/8HnnLMPJhpx5xJwxdy+uDVUjnjy3BTfjqkVg=;
        b=CXxZRK8zF30Ow83+QiB98QBola8obtYTPlIiBolAnOyn5l8GvqTdU6N065H0nhCAdO
         TkfnygRHKglo5yK7d4WOPYDV8QisEiC+RkrXBxPy/delUVIgzAIoyfU/vqOgzQBkhneh
         7Fs8591K5kTflv4O72utprSYCiL4uFhnrh9kJqdFfsUQN0N+ggk9sZ2I2V7RG6cAcjyS
         MLbKDh5avd5umVHUvNxHfp79+fp6reGWJtsNAYW3qh33Q3TpHNSTCQdHEiu2g67CSKor
         lmABmGnFI42ligUg7OdCoqQcxcuPNhsZAVM7/g/nOm9BU4MY7T0bbGJIYPF99x1fqMpO
         UOTg==
X-Forwarded-Encrypted: i=1; AJvYcCWLzW93F3g8rDoZ6X88mVUdDsG/x6qV7Xu+75VyOKBTh+yVNRqyCjwQKamfEYZAvmZk1fFByp50nsvqbBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXGFaYDdD0zFwYcYOS/C3Kpx+KqqAxbTZMsq8kffDOPCOhZb4E
	5SQgdlw1ZRxuy+AezZcCklD+QBvRe+g76iGHhnhMdq3Ox/fZTZLVS3V+8czilxg/wXc=
X-Gm-Gg: ASbGncti6ZSKAuG1xGxpjLfwDEHqw0nIWsGrYAYUxTABnh7V1PkTUY0Pr8l+PIqjWpt
	Pn2+ggH2qa923FlOo8qoTUB3TA5HOJbeA45ycZTwIjfy8CfKFdL3bG1+2BkGmxEQrFVYYTA5E1U
	Fs7ZzTUhQwX+Rrvd0DL+2BBQUGwMl0eGUBR6wVOyHwc0wH34jwqT3IE5j5PUY9e/7HWE4GIZJ2+
	8VosCDDLYbFDDdIEz4xsA2bRZfxV13ErnBoIaP8j8wcYoY7mq0w0XuIfOtq0btTyWohyLZ4zlMT
	kC83EnpWWPhx13fuxf+hxvFczj+X7Pb50OQrBrKGnB74/URnkINwhBX8lQb0r0snSB0yPeJhRT8
	CVZheRM6OmJrOJdsbVpapvPVccRZvZ6NRsSJ3
X-Google-Smtp-Source: AGHT+IGZPTqIQD5sX61NlRQSDM47b7vxHr29b8saJcEcopmHzDGD0h8EFE/XajLMupMDvfX0Jj+PNA==
X-Received: by 2002:a05:600c:8b21:b0:453:9b3:5b70 with SMTP id 5b1f17b1804b1-454f427c67emr46100375e9.8.1752501320166;
        Mon, 14 Jul 2025 06:55:20 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5037fa0sm172291575e9.7.2025.07.14.06.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:55:19 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RFC 0/3] arm64: dts: qcom: sm8750: Add Iris VPU v3.5
Date: Mon, 14 Jul 2025 15:55:13 +0200
Message-Id: <20250714-b4-sm8750-iris-dts-v1-0-93629b246d2e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEEMdWgC/zWNSwrCQBBErxJ6bctkyEeyEgQP4FaCzKfVXmSi0
 zEIIXd3jHFZVdR7EwhFJoEmmyDSyMJ9SCHfZODuJtwI2acMWulS1XmBtkDpdnWpkCML+kGQrLe
 ldwWRriEdH5Gu/F6gZzgdD9D+ykjPVxIM62KNELq+63hoskDvAf+SL6QjEbPomyz1Ra5VtZovI
 3vqncMxR4WlNxXVREZbv08Cx8FtExbaef4Ag0OcWN8AAAA=
X-Change-ID: 20250714-b4-sm8750-iris-dts-ebdb5dc4ee27
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=DYPaM1sSsYolxg2BQv5NXOXylFsZZtxEsSUpo/VrO5Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBodQxDJMbfqyOTL2rUgfqBXT1ZADL5bttGFGXzN
 MSyvm6JjAKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHUMQwAKCRDBN2bmhouD
 16adD/92KbMBSwYI5EFpS1hyc8GukKBBb9GrVAVXSJN3pB+4/QuHAeTb6xodp2yvn0y8HNB8V0+
 rEkhRBVLtMoM8WfpB7M4fDydse07F4E+bBQ76ljle/a0eoAxhCC3JZqox/v+EeNnesw4QZCwMDG
 zUyeudGVfi2EXKH7SBnbU1D8Lny6FXWw7JQS1hRateOV+obxJRb/WDl8kqRzwcob6ISHpiJQYbG
 Ua3MG4atwySvw7blV1Ogp1ZE7dFolZsjhvA8j6PP0mRa+jTls3kQ+ujOUvk5LyfgXs0PiAaR9xr
 m7K2/RkgmALLOwBI511rFmNNmH/EM1xUK06FX7Pfvcn9Fz3JGNtzLjCKpw9NQNuzlA8fBpNJDJT
 /NvQTI6FSk6izcr8FEntnMmt0i1FYg9e1xR71m8w5pFLCkB2U/Gc7wXWvqwBpZoI28xfBIlGNI3
 GELnY8CbAZAtEIdQArwBO+A19WQQurPDbUhTCkabRB9m6fjxokQd7spy3oheFWClmUPnblTeY1m
 kVYq4LtEVW2/MEjwZKtKUdix4Hs9REQyaOv6MKVLJYs2htOrjj8dHatw/yt0afv+CJ0Kc58+X5y
 klw0hkcYKYNrRTkJbtsMAaZsCyuX2zOBYKGqFzH2YsKXKB2YeL0u0Qk6M7VUFHsSJHBM7E2nbD8
 Hf9Qz1at8TdY35g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

RFC because depends on old series (6 months old!) which received
feedback and nothing happened since that time.  I assume author
abandoned that series, but unfortunately unmerged bindings for
qcom,sm8750-videocc block this patchset:
https://lore.kernel.org/all/20241206-sm8750_videocc-v1-0-5da6e7eea2bd@quicinc.com/

The bindings for new compatible qcom,sm8750-iris:
https://lore.kernel.org/r/20250714-sm8750-iris-v1-0-3006293a5bc7@linaro.org

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      arm64: dts: qcom: sm8750: Add Iris VPU v3.5
      [DO NOT MERGE] arm64: dts: qcom: sm8750-mtp: Enable Iris codec
      [DO NOT MERGE] arm64: dts: qcom: sm8750-qrd: Enable Iris codec

 arch/arm64/boot/dts/qcom/sm8750-mtp.dts |   4 ++
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts |   4 ++
 arch/arm64/boot/dts/qcom/sm8750.dtsi    | 112 ++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)
---
base-commit: 709a73d51f11d75ee2aee4f690e4ecd8bc8e9bf3
change-id: 20250714-b4-sm8750-iris-dts-ebdb5dc4ee27
prerequisite-message-id: 20241206-sm8750_videocc-v1-0-5da6e7eea2bd@quicinc.com
prerequisite-patch-id: ada17af875101625f7754335fabc909c8ab9cd20
prerequisite-patch-id: 3cb47a7c47cd96e02b5a4a05490088541f97c629
prerequisite-patch-id: 8c77b8e0c611b5e28086a456157940d773b323ab

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


