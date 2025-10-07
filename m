Return-Path: <linux-kernel+bounces-844660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 370ACBC271C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3BC63C7201
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968D5205E25;
	Tue,  7 Oct 2025 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFtCGwrh"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFC120E31C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863229; cv=none; b=QYEo0XDZAg7mQk0w+nrZGAJxc28cvdep+uApGYBrqCcsKEHPEBByxRTUeRKihFrwacc9kgsPW8VoMg8b+wBLOF0xA8oR7xhwZe5X4jMWE929bVC5WxF8VKQuXC6PrFefQ5aEWRjiGIcRfoS03U8bGDtEW+FmKpGh4dwKxLvClCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863229; c=relaxed/simple;
	bh=Op+QTRcfwfbsxIix4ouiAegGQuvQEcmggnJefJxWt30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gLf9z1j/a7D4cy14HYWFdDZE8/y/y/pmD2Gfg2MO/OXCesnWUd0eFGYGJ9gJ5suM4ViqOtET/iCLCM1tHdZjcfnqbFm3uFs2p2K7o7fvrq8BbiIJDjV8oaqFZbAwD/b22o5pFRP5/Q4mYUhGNSaNYLdjgg+S1hYEdYplmOvYuk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GFtCGwrh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso57310495e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759863226; x=1760468026; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1B8FMEvRCjdBduWbBN4BHAuWdLmc7inqVvHYEcRSHj8=;
        b=GFtCGwrhkdsYQssycM8owoQtcjBxYxvPimzMEppIZXwkGysbaUiKbz4o9P7whVkDpP
         CEt9by12pLtniK+RV7vOonDINzTZtmzZKuY+pwKxcZ/TwAlZzF4ZzjHf2flZoCSTknvL
         yQ1N4KLPoTJXhuXiB9BLefeBKEh3YWRERUt+bfKPxneY3ERs/ma2e7Tw4VYCmda65fxJ
         GWQaHbRO4NYcdaRSRV7btDjVw1NfEKCY+o1KCuRyaC5BokHeWVzUUGRhHM2FvrrKLaT2
         z4WNlDo1lKoREAjzWGMuOmzgRnzFx1TJ0jzyfw7+c1yltXDdTVEnjqgvtHl9xEb4YJvR
         Bc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863226; x=1760468026;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1B8FMEvRCjdBduWbBN4BHAuWdLmc7inqVvHYEcRSHj8=;
        b=k410dNMa/t80IMyEQt/Yhd6lvKYpExr9kiMuDjl5QV5UYbC/cNxxcNTR+KMJHbU05t
         mb1+rAhqsuKWvDuY7b6obCID63LQlqOPuPjtw7RHUwNCulE8Oi7999zEVwehVPo69hFW
         wWpuBtN0jJuy7UgKNgsQXz+N/SRuO7eDv9iSmHHThZHdY0J8FAp3eQbN9+BNFSNzp8lX
         DaDO8+wCh4GJAHAKV2bU/wm+LvraNRBxP6JFlMhWq8j5ZVSdeR2shupURRDdLD3eB+Yd
         /ddTDay3ZfBtgTc4KQYYOG2HIOewpmwn3BkbJpEkc57RgT+wVqEMbCTcCNzbZHZl/8eF
         8jIw==
X-Forwarded-Encrypted: i=1; AJvYcCV0bGeTJqkr4YBT7cFCLp3uiNwI5Mr+X7umW2GsF+eFu05HIlYBbkv9oYdTrd4nEFkHsRXiZTHh6YQIn+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPTweo3r6hdbnq9RYrqG1/6/1fmCf8q03jXthBpeFnC0sz9Kz4
	hQd35I/iVQa5kU/571i6UAWWWxdDertE+HnPl702n3GfL9iNRf3J3fFcWpi5vmarT08=
X-Gm-Gg: ASbGncth38ou6qyc26IgDyL+9l6EdioiRm8dsA991ng7/lNSOHezcV4WYHurQB2BwzN
	D4hy9223Bh/nS82X1fB5CX3OzSzdoKMZrRfBsLR7fJ+CmoDjSPOJAqkBJcEZSjPELynDx3Cm8pl
	ZA7wlr9k/rRM9gLWedVJmT+3GOYKJsHyggIRzt/plupzD2jayIC/H9H18XrFQeiFV3f9tim9ros
	/BIm5z/PKK3MOr8yeXce7PlwK/f3rEtFhtrsRMky83I0AV2Fin7XGv0Abr2+AWcxqeC2oZMUzOo
	xFH/im1zYGhayyNJc+DNL8+qIxDlbF7gXQHre0aGhVp4ZtmWAANisPCX09JDGrZC+0rq7IN1HQj
	53gm4nON1Fw2GwJAD392hK3LEddxkRVG8KhAnlNsMsRmKPmWvsSuB3bbfQmlP27piI8V2l/k=
X-Google-Smtp-Source: AGHT+IH5zHVLrizZeH0JOY25vGwDqk7lqwvYB2VQUuAGyhwLO96qot3/7SYhbnr39uYNrtvz3cFCdw==
X-Received: by 2002:a05:600c:4745:b0:46d:cfc9:1d0f with SMTP id 5b1f17b1804b1-46fa9af30e5mr5064635e9.19.1759863226080;
        Tue, 07 Oct 2025 11:53:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f01absm26399548f8f.44.2025.10.07.11.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:53:45 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 07 Oct 2025 20:53:44 +0200
Subject: [PATCH] arm64: dts: qcom: sm8650: set ufs as dma coherent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-topic-sm8650-upstream-ufs-dma-coherent-v1-1-f3cfeaee04ce@linaro.org>
X-B4-Tracking: v=1; b=H4sIALdh5WgC/x3NTQoCMQxA4asMWRtoB1rFq4iL2qZOFv0h6Ygwz
 N0tLr/NewcoCZPCfTlA6MPKrU7YywJxC/VNyGkaVrM6a8wVR+scUcvNO4N71yEUCu5ZMZWAsW0
 kVAf6aFJwmV5kPcxYF8r8/Y8ez/P8AbXTiht4AAAA
X-Change-ID: 20251007-topic-sm8650-upstream-ufs-dma-coherent-6c0da5febe16
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1376;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Op+QTRcfwfbsxIix4ouiAegGQuvQEcmggnJefJxWt30=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo5WG5oSqx1X3ytDB+hQonl1G38RphNXIieR2OJJ/J
 QgykVcqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOVhuQAKCRB33NvayMhJ0RdoEA
 DQdY3TtihKd6kF3vihFn8DFB4XXmIepTKeJbn5X+wHti6bMmXrMtOmqtClmF/y4xetCM46ktSNh2eE
 AGoWxAh0+0dhaTrNUfOhZHGkeUB2SiwGOpiaiMZIT16w2rFz8pBQHbNMTELtja6E7e/zkQ6aHMSoo+
 3vDJgllxAZa7bV8NaopaMKGHUeoUi1Y76kdn8BbcMM2+Hh0XQ/1kt5+oETiAOmJ4WJNdSHQzqXo6Ls
 0tDUVNqokvRigiIT0uz7/8vfBKqzm9s0WJdm2vlykhZkC4sr+oUj16T7OK9vyIGV7xp9ENub1KACX3
 DBaNLRU333kT5/yworEhF8ziXWjFhIMLTDA6eS9RCC54mLCMOSsKco+T8L3aXa/RPSx/DkLXQGr+vf
 pSoD8P6qRadJCtoMHML6egLtYmWb6mTE6CosbyFZsp6vfbYNiX41KADZPyF1wgiclloUPiR+B2xu5f
 MdJee3v1ZGGncxNUJ3kColvabHJYAzT0sFU3h8VvvHG/eDqHB/DKKTzmi6hn+FzxwwJ4ypShF+4xhU
 US1WEg7rdcVV5an1Ea030YXXbrqitgNOAN2N037WZwENcAZI8HoGrBJ0wtqOq7Lmcx84o9KO6ez7pd
 Y2G810bN8csB0kuz/MWhBGYSGbOciCA3sF/VfDDutdpjDMd4+MZXIjEDnTBQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The UFS device is ovbiously dma coherent like the other IOMMU devices
like usb, mmc, ... let's fix this by adding the flag.

To be sure an extensive test has been performed to be sure it's
safe, as downstream uses this flag for UFS as well.

As an experiment, I checked how the dma-coherent could impact
the UFS bandwidth, and it happens the max bandwidth on cached
write is slighly highter (up to 10%) while using less cpu time
since cache sync/flush is skipped.

Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index e14d3d778b71bbbd0c8fcc851eebc9df9ac09c31..d7ed45027ff453a2d7988678c9e9568837a1c086 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4020,6 +4020,8 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 
 			iommus = <&apps_smmu 0x60 0>;
 
+			dma-coherent;
+
 			lanes-per-direction = <2>;
 			qcom,ice = <&ice>;
 

---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20251007-topic-sm8650-upstream-ufs-dma-coherent-6c0da5febe16

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


