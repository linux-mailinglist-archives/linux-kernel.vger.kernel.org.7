Return-Path: <linux-kernel+bounces-854691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11A5BDF1F7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3243B0069
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342FF2D6623;
	Wed, 15 Oct 2025 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1TX1zMV"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4D72D5C68
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539183; cv=none; b=mCHalgfe6r3+FyAZuAWibFHHnREahuD+ZE2LwJwIOqJPqeIlcjt83ViET9tEFxLLyDfcUwBm0Rs2PnPcIxu2Gw/xqNmRuLPfzvg50xOcqnHnL7qJuGKq09f8Pa1ENEgf0QhJL3ByTAbeSW2EqIo3lYQEUAKLDJukWGomaSDry0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539183; c=relaxed/simple;
	bh=wBR80YGIbnwVSsJBvtap2PtEvmJWWWy+AXepLXrMiQg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bu18pJwBQBhfFzFZL2lwlAne6V40VOquxT1ck0LPe2cW9FbgM7juoWqu1bXRe1X5Hytsev21BVkqrrlcu1nDRVA3ZwOYQEF9Y10hJ7Q038X+xXEIVPOfOHtjZtr+tepEcPpIB05XoOAnvmhH/IJdPQ5PIXo9iwNy4dRwmD9BJQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1TX1zMV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27ee41e074dso76786205ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760539181; x=1761143981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kzk/r6qDbrjCsGLz+9BLRYG0Pw9EztKEkl/jY+qfPQI=;
        b=V1TX1zMVnKcYxDQqX1ZgB/PCo2FP0hzuunIHue/yYPYfYW/6Ck3+kXKtbSQH1iPiyR
         s4A5PJ+NScrxWHdDEvsg+VOfXePdK0b2reUCu+lZmdOwbo8hjheQ0UPbFCJYyISBucTq
         Dg3ZONtEWfbQzmRvBOcXAr3tnP2tMPCczNsJJonrYAIXUduSu5ozNsiTXFuDMJXGNy6+
         iSdHvcmJQ3YvACXyiBnWW4JBSs+jCKuJVVcipffGFUqLJ3Bp7TtdybQ1zCncW58eLLCV
         VKQYaExfwBJTKJP/o5zzOF+57YC0jMYhx2xjTT0kaGcPCDw6H5WwbCfz2PuzmUnZlKWp
         GZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539181; x=1761143981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kzk/r6qDbrjCsGLz+9BLRYG0Pw9EztKEkl/jY+qfPQI=;
        b=o8YOnJDWK0CIpbi5mD89ziDvm75Ht9RNBExvGI4ck/dV3H7RKZiE3MAvbY1mA1d1Mj
         lyfl5S7qF0ISFMU5b0JX3X8Q0fQu1dNmRn9hwLf3dt+GsZoi78P9ZVVuHJTqDmiEWQ3D
         pXITR0jllBlXUBn2zDIxNnHLgfD7I2OIuOD2SMwkouN+R+uTCAEK83SNUx1BRR7saMCJ
         nhRuz4s4XWw1bkKijPjYFi3ToIpD+o8a4No97tA/ekIvKKG1u6V+j4LSce1s9w+lZvu/
         feIiH3/cF6pdSn/quhNl5PrZHlJn9e+ZRCUjgrutxSe8NclFCeJq0iiS4K3zC2JZz0TD
         j5lA==
X-Forwarded-Encrypted: i=1; AJvYcCWHiuvrbfcvpK6sCtoiniZHGXY+7lTSHpaNsBYremn3mhm5IS3W3CTp0pSKH2zrhlQSTJ//dKioK0dzshQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhdpJK17hERDazXqZd0WL+J8ReXMU10qSk58+pJX3Wkh4geVKl
	NHg2VAt5+PFvrM9jeOuo+SH3k6v0boz27+7SVI3DD9nEmCNqqjNDJQPa
X-Gm-Gg: ASbGnctt+FJ4sDbuuVYGaLFCzjqOQ9w2JQYxSPscD98LDjFIvZUplG/aLP1aUJp63Yi
	hrdgGzVeh/ZyYdHAUV2idR5Ty7yOKHzloB1juNSjhf/HFX8HY5gOfIhhVN2jcMcocb5ser/8kLo
	ZhYizKVHkPsC7J3nGP2u7l9ERkypQMOAHyJYKItMlDp+xaNvvpPNwJPAibmIjBGdhBXJiGjCwye
	B5ZI+xEFA8VfoXaxXgy9YjVc/TLNMVIm98WoSdrMDX4keWf32gVd012KPMaryS8gkzsuM19VlWP
	VwQWBKI+jJYru+IoHumN/n2b7Gt3u6aZ4DlkHkrw8jCatSKf9qZ1p9hg5Bkadn6EjPO33muMN5R
	wrdSailxvLayfQPMK0DB1TdZsur6SO3WOSxrt3qC/3kMFRmxtXxzGm/kMQ9YV4utlbxsPKPS2Ze
	JpGQAUQ8bNBxWAjDyHUw7gZ1Xj6mNU8vC10fv3xfid
X-Google-Smtp-Source: AGHT+IEgWdXuvMnKWxO634nbjJzRkHVq3PW7xVSf2LL3eQamnskf+/AR2cdTFIKYZHqt7ErlAtLOOA==
X-Received: by 2002:a17:902:ef11:b0:251:5900:9803 with SMTP id d9443c01a7336-2902723b876mr366239335ad.21.1760539181325;
        Wed, 15 Oct 2025 07:39:41 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36738sm199853455ad.87.2025.10.15.07.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:39:41 -0700 (PDT)
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
Subject: [PATCH v4 6/7] ARM: dts: aspeed: santabarbara: Add AMD APML interface support
Date: Wed, 15 Oct 2025 22:39:02 +0800
Message-ID: <20251015143916.1850450-7-fredchen.openbmc@gmail.com>
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

Enable AMD APML related features
 - add amd sbrmi node for SoC power reading
 - add amd sbtsi node for SoC temperature reading
 - rename the P0_I3C_APML_ALERT_L GPIO to align with the naming
   convention expected by the AMD APML tool

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-santabarbara.dts  | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 3f36c8e03f48..3ca5109af19b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -329,6 +329,20 @@ gpio@26 {
 	};
 };
 
+&i2c3 {
+	status = "okay";
+
+	sbrmi@3c {
+		compatible = "amd,sbrmi";
+		reg = <0x3c>;
+	};
+
+	sbtsi@4c {
+		compatible = "amd,sbtsi";
+		reg = <0x4c>;
+	};
+};
+
 &i2c4 {
 	status = "okay";
 
@@ -1755,7 +1769,7 @@ &sgpiom0 {
 	"P12V_SCM_ADC_ALERT","",
 	"CPU0_REGS_I2C_ALERT_N","",
 	"FM_RTC_ALERT_N","",
-	"APML_CPU0_ALERT_R_N","",
+	"P0_I3C_APML_ALERT_L","",
 	/*J0-J3 line 144-151*/
 	"SMB_RJ45_FIO_TMP_ALERT","",
 	"FM_SMB_ALERT_MCIO_0A_N","",
-- 
2.49.0


