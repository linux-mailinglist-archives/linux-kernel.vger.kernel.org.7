Return-Path: <linux-kernel+bounces-852927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B06BDA41A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F7E65051CB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B739B302769;
	Tue, 14 Oct 2025 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhVMdPJd"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65647302171
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454321; cv=none; b=YXCNtasDixq7PbJ8sac6FsLrFvcFf8eULZnXJoiSyRLEQr0Cp+MZXacyVPHi026GekJthxSP3eSHkT50ASywSh/z3qcGojB2gD82obZFGXUZ6hctZ6pA1wV2JSLyD24MUfp0nZGa6gY0Os71acjkKyW2gflxQM9hCfaEi7aIw2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454321; c=relaxed/simple;
	bh=q41LAG04mQN+h/yjsDMGUnk4+iW5c6zrOTH+jcEbjrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kx/crIe8jY37xSsbDDtP4d3b+FSWY/acp1oHzN+7/g4A9zOZikBsQ8za4aTAf0H7KVPtF3OFNa1Tnw6Po6Nd6Dyn96bPqfWNWIGHN/TamxnBYWCtNqXkR/GKPg7KIF1cxOpXHLDzk8T2JTzIXrSn3nIuxQ1R+HzOp6GBQyvIOrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhVMdPJd; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so4903131a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454320; x=1761059120; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1i7iqUxmgg/DXwXQpNr1KmCqr3Rj4mhCflPyxgc9Us=;
        b=mhVMdPJdHU5DbG+0OJqXtyGs0xJFGfwe64C8SfAVEi1WTHRblGvIYlIzup4eTLfk1E
         j+VNVXRyFuvcsJCTzxV1LCxT40vaGUUdFp4iY1MQpEvMMfqn/WnN1D7QMWMfAhBfMa3w
         S3rHp9EKyRXlcaTyfItHAAsCTWUX9xQeq29J0pEE3oNswsCtRo0kU/W4srlJKHHdjNch
         QZHug+S3FIsD1R3/yeNq3mwIJGnifq8ffd5vqg8D4RFWtGWsYJE9x3NiD5cevsWohCpm
         RFz+RBVYbCisf6kkk7IZ/DQThoyyRh2z2CThS/B4VSu10+MaGzKlGP1/yrveELe+Zawv
         uyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454320; x=1761059120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1i7iqUxmgg/DXwXQpNr1KmCqr3Rj4mhCflPyxgc9Us=;
        b=Ah7UduoJWanytNkP4rboJxb2Io5Gm+ynCtYLzAusqdjqT02h/3wLQDhmwceswFsOGa
         qz5UJsxh5BeeUlebN0yDCnMsZScVTjf9841dRUg/Qm5OJIzK+M52hqp5TnOvnzoKbQ+9
         s35Dtqtg/oU7ipWoeElY0hy6W1Oz0nxNe6uWexYkpREMNyddq/zRXDOF+eAD3LAz53sS
         b0+NCg91+jjy2Wi71OiXHlXu+PZWd64pQzNchiA8RnmP3lGvMpJQAMxVpHonCDpDzWIL
         UuCoIFp7t3UsrlE/37kAUU7IidKqFUcqobUFJdVrPkDxIzKV96BFu4ErvhvD/5IEAQps
         9ygA==
X-Forwarded-Encrypted: i=1; AJvYcCUkng4B2ryZG5w5o9xXjUkssgy3MuLbOZMEEMhZl0f0m+L1OUmjz6UjwIhcsk341UG+dqDe9b8eiDS/A5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvUBdAYNts6wW4+UVhLrRe3kI8/Wa9jdlcp6WYUkWj+QnTYpXV
	NkurIArGeXAaREVLkih16KvWupzaywbc4VMWFDsdjq1oNuCgaibBm/x6
X-Gm-Gg: ASbGncujrv5Boc4DuJo4kT4IOqQ3gGRcWCQerlAsR/7SC9lDyTaU0hh1ypm/gaf8lKj
	+Gipz49EJGdsY/c5SZo1JUFx2lz7JouholfEZuIB3wdBEpxEblg7mPcpMxZs+A/TvTceW5f2ryw
	IQf0Hqt46OGFkHb8kBrWhE6hpwIQBxjk5ukrZ6NbrOUc3rJQ/2Wbr5ILo8ewFYEEGyUZd6POgXE
	v0sCAyvF3uHKpGFEmhHtN1lwvS6q+XU5XEODN2golDiHAtzte12zxLDANbWFP/W/rLObHakzaIi
	o7eKO+IJFwsus5kWXDkWZ38jO1Gcd0KWvlBCmphEMOScJXd6RroRK9g9uH9uU0+WaJBgQA6JUU6
	5wM/YcvUcdqRkKzowD/iseni8FVff6y31m/pH84dsZwaNKyNDy/KcHA==
X-Google-Smtp-Source: AGHT+IGxU1aUYANixpQW6+RfJwrDQsy0lpaNBp+StZI5SmcT71Y9IkZbC/eBjms/hpV0Ia1TiVCOIQ==
X-Received: by 2002:a17:90b:1c81:b0:330:7a11:f111 with SMTP id 98e67ed59e1d1-33b513be2c9mr33511721a91.35.1760454319490;
        Tue, 14 Oct 2025 08:05:19 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3cfsm16258161a91.2.2025.10.14.08.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:05:19 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 14 Oct 2025 23:02:50 +0800
Subject: [PATCH RESEND v8 17/21] arm64: dts: apple: s8001: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-apple-cpmu-v8-17-3f94d4a2a285@gmail.com>
References: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
In-Reply-To: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=895; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=q41LAG04mQN+h/yjsDMGUnk4+iW5c6zrOTH+jcEbjrs=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBo7mZuq26ljD+z+Y6MIqkOiTRV6L4Hn+JOROQ9G
 KHaTtZDhTiJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaO5mbgAKCRABygi3psUI
 JAyjD/wPsIPDTqdU23/DJv1noYw4bjYDPRNP+6mTAR6BfTFdSrVMb87GTXJiFVLJA/BdtCdKYUE
 G7yhhrNCrXaschGxzuQ8ryViFpkYgEEZvKlUWMpqBfhaoK0OO66J+qne8ZNvAShnVwoXXLZauBx
 rajcv0TGz6krDyTimriCyB4cbKzvB4Q7pgyz0MdtaH0JTRWxODkrZh//gPjVdYy4TNPmnlSGsEf
 WVYVHhLdKOQZAXRDXqRwIJWugYgYKodtn7P+0aEYAUBv8sTQ8MqprSnglNZBfnNHhxp2hTE5id2
 PeuQQ+nV2v05y5J3A20srKU1MBsNZzXCq3zKuSUzlPQADPsNJXSdLOmfBF7qhDKJjaDRMpu7VMc
 cHZJnplzhOz4tRc3u39wPE4Uby3q8ks/mDy4s1HzaGwkFt0IQeXIdWe/pwuK3s0gnEtFkkGZboI
 ZPRpXp3D27UByUNRylPxQ6mcnqFIKExaekyf+oL30EpcEruYJif8e0jpYzxWVg5kg4je0eMs/Ms
 EcMDV2RTzujgVfyFjFZkL8uFEEdwNaLEFB7semPfrdcEUKE71Un8A+qjevZfDxfV3Xpw/XVQL9S
 IJRRkb1FohBVPqW0Hz0odA6o7Owk8RluXHygcYYAr3Wnxq3Z7dlrHRP/vBjweGnxtwBWToOGDm9
 R0So6USZLiD2QLQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A9X SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s8001.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s8001.dtsi b/arch/arm64/boot/dts/apple/s8001.dtsi
index fee3507658948a9b4db6a185665fdff9f5acc446..ee2702fc807b678023915f72b5276cc5a31e1222 100644
--- a/arch/arm64/boot/dts/apple/s8001.dtsi
+++ b/arch/arm64/boot/dts/apple/s8001.dtsi
@@ -222,6 +222,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,twister-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 83 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 86 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "s8001-pmgr.dtsi"

-- 
2.51.0


