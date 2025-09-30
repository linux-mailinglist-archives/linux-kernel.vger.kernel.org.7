Return-Path: <linux-kernel+bounces-837759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303ABBAD1FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302724A539F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B878306D5E;
	Tue, 30 Sep 2025 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="rXvPUwYH"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FEF30498D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240644; cv=none; b=ML9jF9rRQH5GefQkr+ZaeZX7r0MJ+eYCgxVGLWsXAdaJ7KpgVN6gyRDqpYLgUjl0X12Th8B/UKIAQdmXqKNs4F8Jc5VjaeXP2X9wyqRogZOPvvJaJn1L9vpir9SB+kjezbnq+zuoxO2z7Wvph+bIB0+/+n2sL9B5CMxfieZ50wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240644; c=relaxed/simple;
	bh=Qe0f2DSIOI6REPXvZsw6mfNG/f7zF2Kc4oN276oEtsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c1bxLQ6yIIOmVd/roUONb35qfkyQGAOLnN560LkPrmZfunDftCD4wdFq685lfZv/2BHaKpmczbPXkH8U2sIgb5y3chwuPhhC+/XqqeDXsfGCHG+eu9N86Wz4XvzN4LV7by9FXawm6fKbHPTzUO8i/Vc8L98QT9tcIY0JnB9TTFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=rXvPUwYH; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3e9d633b78so550375466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1759240640; x=1759845440; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwEwaOkD7UmGdIyIsYNJIdPeNIJYu5qlxwHSoyboRho=;
        b=rXvPUwYH4aCKhfbpz10HjbPxrKZxEU1ILAlElKLVzULtot1BBF1FaPhS6it64jbQHX
         c9becfh5Xej7rslZBnlbG6Vufu0oHKYU0gz6UySDdC6WgXUw4Nnzj+AqpDPXjmykY2rl
         WctxkycmiUamKZJ8POVjJVmLP2PxZEKz2r6NNkiRpn4/xx11doj9tPR43lpeIXFxlJJr
         Ym13spEAgPWkSoFR4vnVHLxRRAi7yZyrVMOHIVQXP7kBcCbwf6PtE25fs6yhnfR4ZeRN
         xuwtJq625e5dKzCN4kye5JS1o2DWF/SMLPfu3WAAScFIAQgcvy3bi3Ee/PubcaJRfWMv
         ab7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759240640; x=1759845440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwEwaOkD7UmGdIyIsYNJIdPeNIJYu5qlxwHSoyboRho=;
        b=vplj8J7Vu3l3j6edpmVyfiOiya0g7ILLo0W4K/7QMX1xx+F7XcVyOPnsTMeoo5yHuE
         4/IIqusR2/By4NXkQlzR917gsjM7wte+zrhO4Wp/2MixVph1zC0rUx1rUhXuysWdwYF/
         fmX4uxS1M+505Gu0Abb2bwwLHQnj9rD7tSb3/pfCti+aFlveKKap2YddhWk5IMw1echb
         9C4Nallyp5+XU4PwFfc95q82hkiSqrYJv29hqOXm89VRJHTFFeDl4FnOVH1Cp7nKmW7u
         FxZG09jFJY3i49DQDtKu2tUhrVrX4vwCCH5esq+Db7GkSkIXVgMFfZiGehF8MSGWOX12
         y3TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpd7a38EYXo/3qSHuR4tT6FETrEA3lc/lvPkFzoBmWh1GaBlJiFFeUA8Sx1TTf62g7NjxAF2jI1KNxi+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyjus4A4VeaL9VH7NhPMqjL6dMk0qeEjNUvvYQs6C3RFivBZk7
	h/MDKaOlRrJIc/d1EEKe+5/ZyUT8F+l6O6NVyDgZ/X2v5WIqXkWYBPKzhuLKgVY2oog=
X-Gm-Gg: ASbGncvJ+z7meTl8BPU4P5p8i0xbqdrMQFX77/3VEiQeyn9s3jwlrup/+GQ1N2E7tCL
	dd/ViUyzVlxL6eT1/C5fItaM0aaBpVr/UT1bucKz2LpIkjG5MHjsYQ/ox1/ruSbIcwxZfN6728T
	pp9HZ58/8v+pyRydp2UusvRLcbTnLhOdPTxnbCKFsmNFABdTueX6EF60sLCUAZOzDWeS0k0NMZ0
	+phY1H/toIp2+maQI1xQPhDMHIkqCM7YI1rv7yZUM8U3ZobLSu8pJQTj+AKCe8tEp0TvblBXHYq
	AucWG+NImVz5rHeDWL382PSC0Os6SAERrbGM61nKLBjljd/hK9ZwxOZRXGVMEo20XdW6zqIN4q4
	YMozrc8tgWyV+3tL0fEzp06yqS231yrixXGwTowApvIsvOPNsEVFONut59RSb7u75NOeXG/gprN
	UCu7cjzCt9ofhqyCMTvWgbC/tbFEe4
X-Google-Smtp-Source: AGHT+IFJQpq+WDwMaA7FjW347FsSVxwD9q92/cNDpC/Ji3gT0PuUoKthgOuYOi1dG6lyZEmWekcLtg==
X-Received: by 2002:a17:906:c155:b0:b07:e258:4629 with SMTP id a640c23a62f3a-b4138d53c0cmr550146166b.16.1759240640482;
        Tue, 30 Sep 2025 06:57:20 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3fb818fb90sm370234866b.63.2025.09.30.06.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 06:57:20 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 30 Sep 2025 15:57:05 +0200
Subject: [PATCH 5/5] arm64: dts: qcom: sm7325-nothing-spacewar: Use correct
 compatible for audiocc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-sc7280-dts-misc-v1-5-5a45923ef705@fairphone.com>
References: <20250930-sc7280-dts-misc-v1-0-5a45923ef705@fairphone.com>
In-Reply-To: <20250930-sc7280-dts-misc-v1-0-5a45923ef705@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759240635; l=855;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=Qe0f2DSIOI6REPXvZsw6mfNG/f7zF2Kc4oN276oEtsk=;
 b=B3B1V2m8I4ILfMLAP07WhFgzpb2Btd7IyCQvlV/gHJlnHz60/uC241UAB6TGvRLCLOrn77iYl
 7ounVtZZsn7DlxLzS3U09xKD2dn2MFQAYcB/DJJ9J6TcEM26TGv6ZJp
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Use the correct compatible for this phone with standard Qualcomm
firmware and remove references to power-domains from a 'reserved' node.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts b/arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts
index f16b47b6a74c5f16657be1cb1e1dc03afedb1167..cb59c122f6f6adc8aee127944dd1ec2d967f3c2e 100644
--- a/arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts
+++ b/arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts
@@ -978,6 +978,11 @@ &ipa {
 	status = "okay";
 };
 
+&lpass_audiocc {
+	compatible = "qcom,qcm6490-lpassaudiocc";
+	/delete-property/ power-domains;
+};
+
 &mdss {
 	status = "okay";
 };

-- 
2.51.0


