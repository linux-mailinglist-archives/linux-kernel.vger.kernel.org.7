Return-Path: <linux-kernel+bounces-854689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C02DBDF1EC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B986719C8719
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A633B2D594F;
	Wed, 15 Oct 2025 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhWxF/m8"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8599D29B79B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539177; cv=none; b=USWX/SuljudKrpleFtccj7EtRyrNtJjsFvthmvjVej3eJ8ldFrf7LVNlRjxMJAzqzCL7/GdfiKMKBgonuAvx2VSwyphynzDq4r3sSQDKmrw5Al0ogtWsz09lKuUQFkcxNsjFUKE4aaGzZPA3NdeWJEUu1tEmbuEccLSZ3ysb0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539177; c=relaxed/simple;
	bh=jXUg/QtHqrfnHtRjLxbM98dfBLO/n/ot/03eZdO/L8Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8slV6N2F5ScUXj5yTeBp0BpFVYudVzwu1TqJYpQfX+kDSmN9EVHqwyTLGlBOL22MJ84uHy8w2hzCQr1V4FdRejrtPtvxOeJCuPTAun3NhbsVFuj83pmcvWL3oLO2jSdIsvlFtOlq052dA27FsiIVn1//Qi+A6GbFDuaP0pzQD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhWxF/m8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2909448641eso321015ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760539174; x=1761143974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZnPPw1yHb/kgpk5HVTCc5i/nPN6HTsBrippheu6Yfk=;
        b=RhWxF/m8joYE8uEJJGo7h0eDETjah6Yh1To69IBDabzv6Yjdl0m1bMh79fr5WB/Wpc
         cGas+oD71jM5OZA24T5ypNwpkURoXlNEHY5dv7vtdl8789wY6iHlKgYR1T8LaFI0G6aA
         7TAFnR/eIgBeib8c2D/gE4G2A3Oree+BDmRBqOWBU3ttT7gzkvLvHVj4MT5+reKOdqEM
         Z3R06CA5PTGnAtNjjrlesbzCbnD3YsxxY+K1VIjYtw+th8hKMOjIM8TlaSX5HpmT4k+p
         XnOkOavkGCnUvxw/5TpBJkOOXcfYV44cK8qoMk2jQCZocrm16EiLe+ITR65h8aqjB6Q1
         /wvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539174; x=1761143974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZnPPw1yHb/kgpk5HVTCc5i/nPN6HTsBrippheu6Yfk=;
        b=ipkPffqT5Axq+Kw5EyQih/mskGSDetNe3xwylt2TWoNT6el4YbEn8G1pIiuOgevTk2
         Mku5XHtY5LAB8rdASZPHJL48jSLsFpwvWq9IiAPY8Ow7LMtyjcnTgSdVeTbYoguacG8b
         C+IwcEDAwbb+mJ/wQ6XJsjCkw5g04mcT4fPD0o8/T475cSTXwmUhdFlT6czUtrdOZ+Ru
         b09QsC8+rjdPn87FIPF/WfrS3gxVC6Hamx0nZz+AaUmmTW5hneO3ngubEc3Z8gbZXiIQ
         3LJyYPg9XdmmFGgNDpdcmHq4ucxBL2uIVBYY4/l61hqLpkCu5oXHDqlPiMTfSN7JgYbX
         SU9A==
X-Forwarded-Encrypted: i=1; AJvYcCVScMq+9e9EhM9oxUm287mQZbmOtCWZEWAgKLrrc2HCeRwzH/w63tVdOTs4YTfTr9wPDZaPT7Ra0D7mgJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxexiwj1kHF2tcXEJgxCAXPNf3ubl3QwIczD2PW4MScMJvpr0/w
	1oLxDFSwZLo2Hfo/t0xKWo/e0Asp7e2ac5xIJf1TIfKuydh1m0ylpYgw
X-Gm-Gg: ASbGncsJeO1m5k7RKQFHyPglRKNaPMq7dJFedpGhiy6sxfHV7FzPKb9yg+l4vsyCEPE
	S6WF6x00FQUH/bRLfUhNgDKJJicUGcrSS98HzAg0L2Tiooo2Rxgr6YRoR3QPsRlcdEBNmxECoMv
	+LGi0zzk/CYaVJ+MA+WdPI30j8i8mx4AH5OHfD2XhfhyOrX+38uf3m7C+Ujg65t08wD36JWOedG
	md5qy/+PzrwEiYDAitslpCyrzG/tj0rPhHqjEG8STzJEAj1htq6hngv8XT2jz+9QRntMTDEqB2S
	KMcj4Y9p/ZxNpUYf+94ipaRJ3//VAU57GtPqIc0JJzXEDWotK87goeuQdtiTkDKhq3NdxCphvvN
	lFVm6rf+SnKDahBOXvmE1F1qgwvpO3SPk+JO33bPj4zvZ+aUQ5PX3F0XHBOmT2U0G73wbxUCdmc
	21S9Jo/fh5fkDBWBQMRjIKdyWP6eLpWw==
X-Google-Smtp-Source: AGHT+IEwVX/ElMrVL/1slVqgh0aEHLkum2PuLtXRVZK0Ha5cnSjmuPAFvQSxCr9PtIb+PIE7Zha0ow==
X-Received: by 2002:a17:902:c951:b0:25c:43f7:7e40 with SMTP id d9443c01a7336-29091ae4cdbmr4400655ad.10.1760539174469;
        Wed, 15 Oct 2025 07:39:34 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36738sm199853455ad.87.2025.10.15.07.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:39:34 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] ARM: dts: aspeed: santabarbara: Add bmc_ready_noled Led
Date: Wed, 15 Oct 2025 22:39:00 +0800
Message-ID: <20251015143916.1850450-5-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
References: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a 'bmc_ready_noled' LED on GPIOB3 with GPIO_TRANSITORY to ensure its
state resets on BMC reboot.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index b190ab344aa7..c0334abf9cda 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -104,6 +104,11 @@ led-2 {
 			default-state = "off";
 			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_HIGH>;
 		};
+
+		led-3 {
+			label = "bmc_ready_noled";
+			gpios = <&gpio0 ASPEED_GPIO(B, 3) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
+		};
 	};
 
 	memory@80000000 {
-- 
2.49.0


