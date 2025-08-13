Return-Path: <linux-kernel+bounces-767089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C927B24F59
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0555C1FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E909D302CCC;
	Wed, 13 Aug 2025 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kgQZrjBm"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF332280A2C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100801; cv=none; b=HwG0Omxn3M9YHm4wndMcG7Ra0KPP3OQcAO7SdamBFo33fkkkgcTJUZIYzvPY7FLYnLxvMoEnb0C6c0cmrsl06SUaFgZf9X8uMDCK1zeJbeWPGJ/2vGd2UsuEHmd6ehx/jMtw2uENlpf8hbl7Fool4Uys4w15x3s4H5ayD5hqNAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100801; c=relaxed/simple;
	bh=OgMk5j+Co8fWzhu7wYx+EI0ZaqZ67Cwt5Pi9dhdbSdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ecyr7J0bDy19Y04r0u8xi8wcgR1pfzeKy9wrRbIk7HaoCwwHYUbe8jg2xBKuuwQy2PSeDffOyOW7n5t50RtZAoS8wSO1SUReaWJWA5zMfxALxvVSznq6HpZYTZBDVpGgiK5xefySS3g2M0WZhSeKSHXr7EvCtpuqk3K2tDdYVp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kgQZrjBm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a12b3f4b3so15599435e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755100796; x=1755705596; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLGRK3y3xDP2UgJq++RG3r+bB3WSDGMIrhAQaV+dVpE=;
        b=kgQZrjBml0Q+5agHM39D+YsFc8d7o8Cozb9LYMhvApmYB1O6GT11jNa6MDA39hwlg0
         yZvFZvnWciKzBhEN03UzwJYFasUuF1QCAegactD/gO9rJQ67lsU+EPBm5Zsl/RKoJ3kR
         P3ova8/IZQByCnxkrobChyMbrd/2cXhFjLDHg5tp77S/finEOOXabNBl5PcSjhzRTtzS
         dEzQ6WVWehG69JA7QfPMtfsOkbhE3qDGm3F/iz2Mh6ixP4MnZe9FYTzRrCK8yYi2FB0D
         gjfP5rCsTR6vZKsVb5mCZsIcE4X85BA2I8r+vq6ZL7IgJNF6y/DzBJ2J9mPCip7uZghi
         5OFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100796; x=1755705596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLGRK3y3xDP2UgJq++RG3r+bB3WSDGMIrhAQaV+dVpE=;
        b=grXbuIYx0hMno8Fwam4kj05sKdBxH9toN+nzFLJZ7KQx8HLqYuIGprFjeEEMryDaAB
         QR9f3unubP6bOVuXP50ZGhnj7DVMdLMJvWj523J3yDoa6YD/ZPNhuodQUWPtSHXEH98U
         VChkkFdrEuONScRAFloMfE97FDrI8zS/VMYSF9Zf67hJaUjCTREqEuSgQB0zbnkTPfIl
         hK2aNtKdxbxnEwp3H3PjHM+1Pa9bzlLsujyHNFt3/bTvf65SjjNV5vhhGooM4g0frI/t
         ou08KyDnfqsGZrhjoSFUhduxsRKkxEAKC4/XXabKV6xhrG1fpqXMancxSr+hbz09pFTg
         w2IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBahE3rcX9z4vkQtJAwT800jGK6v1oueWU5TwV8kO+pfoQQg3HbVb5d+68ScYfITsYYyNHFdcszQfL5lc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyts54jOLhgGbWKPR/golVpltjcgDIIB8uAPZiG9omX0n1P7lNZ
	Aet7oRQHCGgrP3LrKwNkeKn538zxiwfn8QGDvlgzbDDJwFxMXAukmui1PiBlnTsaUcQ=
X-Gm-Gg: ASbGnctywQn9+C1f1k/2vcehSKyxEstzeebGhlWPDWNsqLBivY9rJdzSpuTQqDKd/ul
	luaMgP+JhAxselQHGRcFa173ISqiY2umaevD8QuZjzy5R1a+Haj1Hkqs7q5LYHTW+dSM0SJ0ZWw
	JXvR/Dgo8IGlPRrnVzo3ea10SrQ9cZn3fsadZGLHPz+hracz3qvVK2SWogC7F5N3BiemRqGu+Yk
	PpMnjoNyvE2kDBtAWAzN98Aif2quJ1nKR0BcXJNMp8mQiCOO/dpeYpkXds4fIebnLYlE6D3OqxQ
	eXcFpvxYj6zcrInakTa9HwGetU6aeGiLyhrGgYugR/9JMBrIXVLaiNQN+ILDyZAk9csX5jZcs77
	DnP5DvAR86iNjBr/vAiteiW2YQZxQF+JBhIRUOQ==
X-Google-Smtp-Source: AGHT+IF+mTd29GafsqklT6SCsgn+jqtFYZEv/RqV/gBRdY7DrlXQAky4D9Zbx9eLOt3qutOLKgK02Q==
X-Received: by 2002:a05:600c:3b13:b0:459:d821:a45b with SMTP id 5b1f17b1804b1-45a1660b4f4mr33427115e9.9.1755100795933;
        Wed, 13 Aug 2025 08:59:55 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:4537:5d58:c08d:204b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a517c26sm7087755e9.7.2025.08.13.08.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:59:55 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 13 Aug 2025 17:59:05 +0200
Subject: [PATCH 8/9] arm64: dts: qcom: x1e80100-qcp: Explicitly enable used
 audio codecs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-x1e80100-disable-audio-codecs-v1-8-af82d9576f80@linaro.org>
References: <20250813-x1e80100-disable-audio-codecs-v1-0-af82d9576f80@linaro.org>
In-Reply-To: <20250813-x1e80100-disable-audio-codecs-v1-0-af82d9576f80@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.14.2

Currently, the macro audio codecs are enabled by default in x1e80100.dtsi.
However, they do not probe without the ADSP remoteproc, which is disabled
by default. Also, not all boards make use of all the audio codecs, e.g.
there are several boards with just two speakers. In this case, the
&lpass_wsa2macro is not used.

In preparation of disabling the audio codecs by default in x1e80100.dtsi,
add the missing status lines to explicitly enable the used audio codecs.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index 9369b76c668b5c008fefd85d5ca18e87ab9ce93f..8deb07197ffd7c0da74436d8562f540abe4c4713 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -871,7 +871,13 @@ eusb6_repeater: redriver@4f {
 	};
 };
 
+&lpass_rxmacro {
+	status = "okay";
+};
+
 &lpass_tlmm {
+	status = "okay";
+
 	spkr_01_sd_n_active: spkr-01-sd-n-active-state {
 		pins = "gpio12";
 		function = "gpio";
@@ -881,6 +887,19 @@ spkr_01_sd_n_active: spkr-01-sd-n-active-state {
 	};
 };
 
+&lpass_txmacro {
+	status = "okay";
+};
+
+&lpass_vamacro {
+	/* Not directly used, but needed for fsgen by all other macros */
+	status = "okay";
+};
+
+&lpass_wsamacro {
+	status = "okay";
+};
+
 &mdss {
 	status = "okay";
 };

-- 
2.50.1


