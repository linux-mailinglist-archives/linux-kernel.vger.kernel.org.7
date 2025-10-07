Return-Path: <linux-kernel+bounces-844226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26824BC1570
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5772F188A4F5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538EC2DECD3;
	Tue,  7 Oct 2025 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKU2aE3d"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0245C2DCC17
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839340; cv=none; b=pKFU3MstGvws4hVlXmmtTV8FupogX/oDVtypgozvOvsWBjU5qX+L3Fe0tz6UJTIPf70BQVec9W36zSJ9XcOCEI0vPwvUwtfi/YE+4U0Tt2V/SiUz/EbFEvVx0xsY5PoZslTqc5aIfoSBeK9/4p4fliiZ6LOIugHkQhjRHyZLCGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839340; c=relaxed/simple;
	bh=GSaWZ7aCzP8lqbL2VZ74ZgOa1jqGO2XeKUCr6ss+STw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIcFlIZ3iGZJRfBdpwm1eVfbvkc/kxQa4uATqYenwkTlyDtnsJXy7cNc5aZHpE9xya7jS9bui5G6uWQbV2pV+wk9INB21fdey+r6vbW6b7e2nRKdJYBQZnAgpSuKXaalFr3TmMIZehBL2/6rIA406LneOLPIVL/j7t25MbPR3CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKU2aE3d; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee130237a8so4286516f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839337; x=1760444137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Qit5d1ah8Bj1pDYRzOtk2F8SyNo0Gmdn1Mtvckqvbg=;
        b=bKU2aE3d6/DH/RS0x8y64ZeECv34cuDlK/yn40cwfGL47PLPpzhWFADX/0w4YtKHMW
         YI1J9d7pVvFHLrtwTDrB9HsI7Z7QG5mdzJ5t+Y6+2HY0OZSUmX3NYe8vBrpAwSrSqJsl
         c0tLAfPeqic/9fGkguj65rdbomi01xbjZzeOfmIJbAPCKEODNxpRwLRJtQT3y7WeJ+4N
         oShWb41FW8/jurDMz4JhJKEWWhxoWUrB7gRiBfgA9FKpRpcFDiRdmG8b+rShFGiBfEPU
         4lfKtI95PeIVFe2R/U3h7ngJ6Dcn0fW+jsv05luqDHkiNU560hXLIz0cw6YHIJPeU77J
         WI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839337; x=1760444137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Qit5d1ah8Bj1pDYRzOtk2F8SyNo0Gmdn1Mtvckqvbg=;
        b=hl44tEvjFhOXyohQVVV6iN5TyUW/ZPaJhALP9wzlDiW//elUyjIod411sHTnHwR/OY
         BvjGlzyffQeE5fUYn9o85CI2BWUtY58qgCQ+8nzITtvAZdXeGJkveL3l7BV/sHcRgPgE
         Xz1VFnWrZCuPHFX6XQVrc42WF6n4uNbKo/zvjskjCKp1AHtlzkNnioyNNWS03nuy+bib
         wd+lbCGA+l6A4qcjix90dbFith3POmG+A6Cp2iHJmgiRwQXXjlrsQ6rBFaMrwE3luzl+
         sxpkyFzorD5v5rTIkrKb0nktutEFvonk84Cu33MwxjMwRTML/s7uaYh0K6J2lpavVpM+
         JRZA==
X-Forwarded-Encrypted: i=1; AJvYcCWC+panCnyXVE6mwnUFPIUKIEdyLb3MgpAzzBgat6WAzjeY/NO1kebZtjrtc16uL1ik26Vc002UJm19PrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywG/VVOD91Cubx43IqxKK6kwWNhyiEwIsOB2+Vq7vnys5WMd3g
	Uc84YwRYah9/5QgiTleg4uSiQRDzca2jxJvBRZ4BGZEt1nONmgRkbcn3
X-Gm-Gg: ASbGncunxYOxUmWA9rNIuEWI/Z6lC3MmFLP2sHRVplSQY2bQQFMT5HmbP6s/kjIDbf+
	TX1tetywyMuo/jO+62iW77olPuS93fZ8xw+/0N0OZ5koI77bfhvIOoFNNBsPE1b6TcLYSGEFA9m
	dvwkjSRFpDhPzvQGw+oaV3ZJWPTYavjQrnY0rAS74RCF2+MSZaLztBKB06+3xHVd5+KUt68AV/y
	CcZzip82xi3iHa1F5ax2cSOqk3a540K4RU+ry3V60iv1fkBN9BgoPYH0Xm/D3Kgnd7cKISs+v4D
	uq2EpoABIiAfa6TYNmT9Bel1I6eUYvkXqFnWMZKfAHz7ZE64we/cTLWWziOHw/OGW0YHIkstrKz
	0CPVSbGHfHsNZtItpBxpwtGJODnKOu12IwH/1skZyXtRWRr43yeR8sx00VwepBc2RN1i0G6xHS4
	sUHR9WhWG11bSYryg=
X-Google-Smtp-Source: AGHT+IG1s8byHvdNKFydToVpb8hvJVpQJOzAscjoELRzm4iXjeOZk1vx64ybxodArTehvqGRIbNh2g==
X-Received: by 2002:a05:6000:2204:b0:408:5363:8266 with SMTP id ffacd0b85a97d-425671b07c1mr10822096f8f.44.1759839337311;
        Tue, 07 Oct 2025 05:15:37 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:9667:4f0f:586a:20c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6e1bsm25590167f8f.8.2025.10.07.05.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:15:36 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 4/4] arm64: dts: renesas: r9a09g087: Add Cortex-A55 PMU node
Date: Tue,  7 Oct 2025 13:15:08 +0100
Message-ID: <20251007121508.1595889-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007121508.1595889-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251007121508.1595889-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Enable the performance monitor unit for the Cortex-A55 cores on the
RZ/N2H (R9A09G087) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 8144d3781023..2d2db858f48f 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -65,6 +65,11 @@ extal_clk: extal {
 		clock-frequency = <0>;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
-- 
2.51.0


