Return-Path: <linux-kernel+bounces-873100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0845FC131AA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D29718986A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E46288522;
	Tue, 28 Oct 2025 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe0dxd4b"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E70778F29
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632205; cv=none; b=hfVTofK/2vWDNdT8R3Wsc5AoDfH1RvcXQ6riJdSzwEDkzf8xe17F1UG5YX0gTcVc4tcnu1sP5PGx8BjVX+UcPCQGrwlCIIk4kJqEiXe1UvE5/WOwDL+oThIW12CxLgAzvRB39OEarSsU+zU7jp+DK+0aFKGY33XWZjyFX2fY8+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632205; c=relaxed/simple;
	bh=3q7vgrsEYAl/mHjsczJ7QlOK8tqZttVCqjidcksmLTU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hf5t7eNiTeCy9s32yGLo0jYNrv8Cv91aPCT66W2HwmJwkZhFgZGMWl3BwIp/onIgG3bOHW8wFhcdjHOs/2LOSrbh+9bTaxM0JZ0GRDvQNQ4N85jnDpxhED0IQm4lBph/JScTAuX4JDtzvs4GTdTJZ1WLHDz8LnPNAa1boroSi8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qe0dxd4b; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29292eca5dbso73882265ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761632203; x=1762237003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M4Rb55I5lLUug6IGvr+iG2g0hErU8FZ4QrrA0bkbgrQ=;
        b=Qe0dxd4bOtGxFZr9We/nGpVAMSGj3aNIzuMpH5JSeZ1Ui8Rmy1Lzp+LnRm6T+lcppp
         ayRAdLl+TT/O460oUd0rJss8wXsCJj6T4OSmoWzxXZtxiW/P8WhkNoIJ4JBNxGcjGEXU
         b06H3iTNcrUZSCLXIGbkFpPjM311mRIzvonN6FuJJSCPN0IlFqMLfYfdRYmvNNW6yArA
         I19TEExAK+P2HrqCamUrDGK/yfm8wyqT8uHbh1LsubfTAi8NNV8s2a8YKfndbIniueih
         la0jiBzo4ovi72LM3mH7T5MBa+cmziYbmiPOMjuN9URehvfMiS3kIjmduuIBujPJiWt1
         yklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761632203; x=1762237003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4Rb55I5lLUug6IGvr+iG2g0hErU8FZ4QrrA0bkbgrQ=;
        b=gajQRzG/51iyNwe158OBAE0bpT8eduIhafAEWATSsHfCUbmw1l+FQmwEBlOqyhEbE7
         T3+GuRs31hc37EpUkfZY+EFZDFnG6gi+t12ZqvARSUCX9KgR/xc2hWNfqyaHmbV5b7B4
         il+NNZT1yd6wM47YqiVbGwLlV8LDk0wgDf5sqyEiMib7vDVcqaO2JhIQJlSKbkfsXAwC
         Qi/YkdpRgWaJ/pRpEVnid7TC5ceFoDodmkXgB0Rm0264M3h7r5jSsxzDJOXS4TZuVd8x
         rBBAKm+iEeBhvRPyj6kU0xxPpCYaX297NVk37632LlDs3coIyoPwEwUmscTYSK2f1WP1
         iIyA==
X-Forwarded-Encrypted: i=1; AJvYcCVadFvVF0ikBlMq6JpJySgX3Ka2ZSpxICrIM7gqYj6ikKAgBBPaLh3hmtAGSnm1O5sBQX/qO/zRW5Vs6/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnRLwaVndU9+8UEhnfEnFH+YbLMEeT8tS4Gy9gdLNnv7ug6mJv
	Al6oPC36HuvBshboal+RtdpVz0B10K0fFZHh1AWeOykFn26z/56urCEC
X-Gm-Gg: ASbGncsCg40K5pKVP7tJYqDaG0eKBMN/oWbNl4JuIZnsFrgGKfjBeE8BOqiNBCAqbGj
	IyXBDkuRkH99+M7fLFyZrhkHK1sI3JooeoAE86WbLlc0Sy9DgRzRmnYkPbt1t8vn00tRCC3QnA4
	m0H9zXe1D7xj1fqnXvMPCDGyfIzm84Z8FxQZVtIGfx6OSDiYqeMxe7IXC6+U6vx2jUVqCJ7pi1z
	tO32DDDONE+y7TFVTwq13P0DOeFzJfAyRcBwYnm94w4jxbP9xbc66o5Y3em7IdxzNl8xGopk76P
	8VH6kzzsHBVC+5DvNNN9xnVsUXmiccaS3UHYkASPLAPOQWwySVw6LT1xj+k+XYTvoTrRQ4jO3dJ
	OwFvBEbwcjvsCGaL6BDsKKKjuOSvH/ZTdb4H7FI6ENWBYQhsAaXNXAnIam/jyLBEJRdfyGHa1oF
	YG2EOokH6v6zmbDAxyi7iw7GoWuQ==
X-Google-Smtp-Source: AGHT+IHTIhRQHTr/xzwx+z1LhLuPWrR6wig8oy0fi1xGmqNWoAym+r1NmbbRsmQoQzQAu6/rb28qXg==
X-Received: by 2002:a17:903:186:b0:267:6754:8fd9 with SMTP id d9443c01a7336-294cb507c55mr38028255ad.39.1761632203414;
        Mon, 27 Oct 2025 23:16:43 -0700 (PDT)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e429d9sm102612935ad.100.2025.10.27.23.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 23:16:43 -0700 (PDT)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: andersson@kernel.org,
	konradybcio@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudarshan Shetty <tessolveupstream@gmail.com>
Subject: [PATCH v1 0/1] arm64: dts: qcom: Add dual-channel LVDS support on QCS615 Talos EVK 
Date: Tue, 28 Oct 2025 11:46:35 +0530
Message-Id: <20251028061636.724667-1-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch introduces a new device tree for the QCS615 Talos EVK platform
with dual-channel LVDS display support.

The new DTS file (`talos-evk-lvds.dts`) is based on the existing
`talos-evk.dts` and extends it to enable a dual-channel LVDS display
configuration using the TI SN65DSI84 DSI-to-LVDS bridge.

In this setup:
- LVDS Channel A carries odd pixels.
- LVDS Channel B carries even pixels.

This patch only adds the new DTS and corresponding Makefile entry.

Thanks,
Sudarshan

---

Sudarshan Shetty (1):
  arm64: dts: qcom: talos-evk: Add support for dual-channel LVDS panel

 arch/arm64/boot/dts/qcom/Makefile           |   1 +
 arch/arm64/boot/dts/qcom/talos-evk-lvds.dts | 128 ++++++++++++++++++++
 2 files changed, 129 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/talos-evk-lvds.dts

-- 
2.34.1


