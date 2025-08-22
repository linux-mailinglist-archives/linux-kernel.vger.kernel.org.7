Return-Path: <linux-kernel+bounces-781551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F272AB313F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E05587F98
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8B5214232;
	Fri, 22 Aug 2025 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7nxXvcR"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA6F257448
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855565; cv=none; b=f5wZAnVmTLNpTTg233fTVoe1AlzVBDBEnXTZw/ttzNbQvKFJMZ9GH23ZMmTh3mV8mB/XDfyhl+stIuYFwHQsFJV0wrmPPf55GGwcttzdetdxYe+ADnCs+FpqYvTq771mGRqLGkVMUKfeT4eyAYjiUdGHHS2t2D/LHb0sYQigSzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855565; c=relaxed/simple;
	bh=TIqaNaL0gX7EiN8vDS4n9ZA4L0xlzt9xa/4X4cyRVQc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y82kloEemsI1bmnOFE/85pa+IEuk58gt1wQxbSD5N9z7/j3LIPL5mqKIaYdLkRAIkmo6cOLqx4zA215l+DD3iSzjnXDeQ/UlM9Q2uh0cAUis06owa7q7uOy06Ld+Baze9T7Tnp5v/+645ewi5LxzDejUaGUPeiJuxYLHlFfc00Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S7nxXvcR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c51f015a1cso827713f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755855562; x=1756460362; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Srvxyt7qia+o9DraeIvmf5P7b+TsFXGBXi5TRfM4NGY=;
        b=S7nxXvcRdzqGtOTyNRZt0nO5wQ/Q9lqeyLhbCBj2KNnYsX4No+V3yPryWKPIqAHuoE
         zRRqCDz8Nup7WNFLgx3yOn9MaVz6TXQzY/eHv2l1ZJoUbOedLrZ9iXmFNNU3rER6SLy7
         vCQWEFLszbCGJ7Xbv/5SICNz2KETr06hD7eB+nN2OY24KUL/AYvOToyla8XrV9xLsBII
         Er+siuVdyx2OuIAqKtiwOYMye1zUOZDmaPVUGQnAuY6M+tPuE403WrzGceP4pVk3jBrq
         39o8GY/BLovxwXsdGcus27xdFxuU8vF065hwabt5FGtB6WilYBTX4Hnpontv6DztZg+t
         9sYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855562; x=1756460362;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Srvxyt7qia+o9DraeIvmf5P7b+TsFXGBXi5TRfM4NGY=;
        b=t1gNM1k3XtD38xJBaQUK/Ha73ByVjId1bfKlZt6S5TEORL1jjkcEv2ENV4kcUqvK6B
         Unh4njwJBsFak1j/74+Hd5RjL4jMiLDB+R6svMQmEyHefcUT/lW+4ne1TGKJC/PPjTBN
         07BgxTAFWU82iENCJ+yi3gDNrZLJ9QdlY4/Ve/MZKgE7586+2+X+pqcWDNcMq2cTpxuk
         fe3fDDCPJPKNBIpRxA2mYOKYDSyWChxuQ5MfFP3zEeHpgJ0fbMPtOF9KldN0DV2IEqAe
         eXe0bRCzZZc5SGGZiyBpAUSTjja7127l/iu1zpW3sulMLHsM2F5t46pe2QNsedx6FP9o
         YamQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6zIWQAxM1fdaNO/0Qc3ABhxUfTqNJ5tAl4raprTsi81nP0fKiYhZrybFcs5Ro0ggraoLUjq1EuLcNi94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzprOWvjER//dVFGYRwabzOcA6nauf4xRw76DZ0TLVcFkHzK586
	LsmfEO9jU1MgUl2JLDwvBXkTOyqHsxAkcwRC8eIH7ZKvpuf4yPmrJFSV5vCK6ij3jXk=
X-Gm-Gg: ASbGnctLepV0Ap4oFA2I9D3qe76F97xBuurr/jxviO5fttb4jH1D4kmQQnLlVUmNxHU
	JNT3sL0xR/0pUsXF/+i/Za0KVFeDULzGcM17/4ILRjxU7nJETzuxbYVkfK6x/KcdS4lMKE/T/VZ
	THLbt3rejDLyywIlNkEElPR8UocjsbQfGrA+s7GdQkMKtx/Qcv2EkpeMrZ2iCOg8KmYXGId5VQ5
	iwx7MzBqhjiJwshhjeftYNjcOtcTzbE+gcuxk6E8cbqJKtjH89pr/gRcqVYBni/k5R7JCYwo1GU
	63IZuDZWNvSF781++pj8mh9COUh16dcMbuQBLA5MdjjF6Z6zb91R2Ebos9mWNxZcZWYsJPghlfx
	i7LJpxF6qNMrBvHu+oXDgkPn96McUieS6ZEYj1d05YSKzlOeiGcoZfw==
X-Google-Smtp-Source: AGHT+IHeFIBzV2r3sYOLFd7iddmZZKUTrFnHKzrIxe3IQQc3wPOkW2LDawTIdP4/CvycIRR/Cn5GxA==
X-Received: by 2002:a05:6000:3105:b0:3b4:9721:2b32 with SMTP id ffacd0b85a97d-3c5da83c440mr1673951f8f.10.1755855561507;
        Fri, 22 Aug 2025 02:39:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c684524163sm609890f8f.61.2025.08.22.02.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:39:21 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 00/16] arm64: dts: qcom: Set up 4-lane DP for sm8[56]50
 & x1e boards
Date: Fri, 22 Aug 2025 11:39:12 +0200
Message-Id: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMA6qGgC/4WNQQ6CMBBFr0Jm7ZiZKgquvIdhUekAk5CWtIRgC
 He3cgGX7yX//Q2SRJUEj2KDKIsmDT6DORXQDtb3guoygyFTUmUY5zBpiytLRUyE19F6SWgr5+4
 dt6681ZC3U5RO16P7ajIPmuYQP8fNwj/7r7gwEtKbLTmqLzn8HNXbGM4h9tDs+/4Fy5mKzrsAA
 AA=
X-Change-ID: 20250821-topic-x1e80100-4lanes-a8dd7f1cd569
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2878;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=TIqaNaL0gX7EiN8vDS4n9ZA4L0xlzt9xa/4X4cyRVQc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqDrBn5Knle7ab5jQ6tTSPSwa6mZx4CftwvSOA5d8
 j/ENNqaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKg6wQAKCRB33NvayMhJ0QzvEA
 CZH9RwnWiPy7u3Uxp6tHmhBwZHDrJpB1Wj5hxKCIllJz45WiTX6vvMTMI9WiuiBpvzQ2fFu+jqLohr
 MrgN1TWQ1SYnLZnWb2pObXkWEEnsNfcFKgxzX8aEjcf8s3qDv4B2IEouLC5/ZynkDRzHMns4aTkwLQ
 X9T1WC+XSsNN3VsW2Vg84WTBb9h6NwXqKxkpsayHu8XbOC6ycNKYqdyJlpP36uJsELzbkDWO2QnvVJ
 RSHXXtJtgPU7wEN4EE7DhV/BwDD3A1NRg4iLQvneNy7JqU53RAefkal96UX5p2YV9Go5yqQH4i/9U8
 hdoq68ykuHLwrIvHPK7mwXETyf59PxtACNM1MwGx3vPJMC3cX1cipy4evJEXepuDxUdkZLsf7BJ50o
 m6BjpjxejnK7dKkHOhygEH8jUafiRw+xWjh5rFV+Ri7bQBxd2XFaISKwbamAdeOuDGJ6+Pqz8Zyo8Y
 F/RIVklPI/ei9eYPTSYI9CAyFSASekWB+HvdE2m9iuTceZbBah6kWpbijdI+8xYNg/B0zAAPnxK0c0
 /lS+6OGbuuTK5ICCcDPukxCB2lrUvqgqwhm6NBikElPxoUvyBw9dmem/SCS3jkoRXVj6G0s6cTQGox
 g0uroU52ebe9m9DeV2OhQMXhVbf8ltwqlKAVXJ0L9m41RdvXB1+I3hxUI3LQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Now the 4lanes support in the QMP Combo PHY has been merged in [1],
add the required plumbing in DT.

[1] https://lore.kernel.org/all/20250807-topic-4ln_dp_respin-v4-0-43272d6eca92@oss.qualcomm.com/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Add missing x1-asus-zenbook-a14 & x1-crd
- Link to v1: https://lore.kernel.org/r/20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org

---
Neil Armstrong (16):
      arm64: dts: qcom: sm8550: allow mode-switch events to reach the QMP Combo PHY
      arm64: dts: qcom: sm8650: allow mode-switch events to reach the QMP Combo PHY
      arm64: dts: qcom: x1e80100: allow mode-switch events to reach the QMP Combo PHYs
      arm64: dts: qcom: sm8550-hdk: Set up 4-lane DP
      arm64: dts: qcom: sm8550-qrd: Set up 4-lane DP
      arm64: dts: qcom: sm8650-hdk: Set up 4-lane DP
      arm64: dts: qcom: sm8650-qrd: Set up 4-lane DP
      arm64: dts: qcom: x1e001de-devkit: Set up 4-lane DP
      arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: Set up 4-lane DP
      arm64: dts: qcom: x1e80100-dell-xps13-9345: Set up 4-lane DP
      arm64: dts: qcom: x1e80100-hp-omnibook-x14: Set up 4-lane DP
      arm64: dts: qcom: x1e80100-lenovo-yoga-slim7x: Set up 4-lane DP
      arm64: dts: qcom: x1e80100-microsoft-romulus: Set up 4-lane DP
      arm64: dts: qcom: x1e80100-qcp: Set up 4-lane DP
      arm64: dts: qcom: x1-crd: Set up 4-lane DP
      arm64: dts: qcom: x1-asus-zenbook-a14: Set up 4-lane DP

 arch/arm64/boot/dts/qcom/sm8550-hdk.dts                     | 2 +-
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts                     | 2 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi                        | 1 +
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts                     | 2 +-
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts                     | 2 +-
 arch/arm64/boot/dts/qcom/sm8650.dtsi                        | 1 +
 arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi           | 4 ++--
 arch/arm64/boot/dts/qcom/x1-crd.dtsi                        | 6 +++---
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts                | 6 +++---
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts       | 4 ++--
 arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts       | 4 ++--
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts    | 6 +++---
 arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi    | 4 ++--
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                   | 6 +++---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                      | 3 +++
 16 files changed, 31 insertions(+), 26 deletions(-)
---
base-commit: 7fa4d8dc380fbd81a9d702a855c50690c9c6442c
change-id: 20250821-topic-x1e80100-4lanes-a8dd7f1cd569

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


