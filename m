Return-Path: <linux-kernel+bounces-866858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6C1C00CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D5DC4FFFE1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E19330EF91;
	Thu, 23 Oct 2025 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="P1jE2uct"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C0B30E0F9
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219619; cv=none; b=ZagrPBYUsrnOcjCpsuvx6TmYwD5GxwY/T9/kittH2Wu1doe8h61QGnweP6AMo0mX4CBeCc78P+b+S5IC9pWxvaBR8eqhHhmx+1ySCGvfQrViZYU2TFdqMynw+bnh7ht0jPqO1NbDTPzTsb3gryJ1ZibZXWEgX5U3jUiJKI//lQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219619; c=relaxed/simple;
	bh=p95Yod17aguDEQvaEd9jFzyjpv3eP0LhnfZGpsw/x/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bK05JjKwuOpNBWzzl6wqzEhIwJ4mS6dmtlTmwMiPVgt1C/cphYEX6GCCRoJyaCWzy78jl/soWF2LDJo/dEiYVdxk2HB/L64CM6O1XhBzFuvdAbx3Zk3UMClMZy//3ZGRTUhvm24ChLN4XLOE4Cd3kITLqCm26/Zp4l5OEUYABBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=P1jE2uct; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3ee18913c0so154730766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1761219616; x=1761824416; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+b9aFICfN/XZyY8AY2ox+ovxPQcHAuzzYqvvmhyVWUw=;
        b=P1jE2uctxGdO+kePUc/sjbLYT+tCK7n0+p+K8mTdBxutivs7zkU+ZmgCnHuV8NofQQ
         Dk/VVd/uCtHDATVwRgQlsDPdYcQWMETAJl2UJi3XJTfDNDOXB9y8oqo4kWtaUL042X1E
         YNPPWnnxHllHhA4McpymzyaZ9TKRd6kMyjOLIwHgL84uWkrUdx3/m4X0uyXGoCF6kuxl
         AsE3midRPo2JOsU/SV38sjyAuzZlje19lUcdsDb3xzO8d9SEIcPReJSdQMauAcYqvlid
         RXysQgXG4P/usLZuB8GnvOf0LEESc/CJ7o6Slt6SFYlBABU3Ds6ifJ+4e7rIYRrTJpiu
         N34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219616; x=1761824416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+b9aFICfN/XZyY8AY2ox+ovxPQcHAuzzYqvvmhyVWUw=;
        b=XeUrodwG6EHaxH+dguIZtE636+4p7/2Qy70DbU0Afgxb40r2r7MUg0qimBpmGnTQLB
         OulDXzHLpeivHtNh+x340gTFOaYEGaEeeuXkWFJRNICGESidoQtY7bu5majbNPb0wqRr
         EaLVqs7fUs//h1plSStbEfo7yv30yUAEKtpMgqYI7tov3Rnq8nHO5B2PU/aG89VbXhd3
         fHAS4QS74XZZUSanaNh1ggaol//3WqiRh1QKN6MHeZIfookmPUQgj8Cze5TVWeMFMFF/
         t1MT0qbnDJas0gkjuhQ3A7mWa7eYt6OrQermwTHTg/EsSNbiUjrEwtJn4EMeEZFOALw4
         +J5g==
X-Forwarded-Encrypted: i=1; AJvYcCV3oAC/oVXd8OD+w36baPV2WcABZB7fhJ1RQXl09yBU5dDTGLP7YsA8Lsk22bKI5XE7zexw6WEpJNTkEHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4tmDZiKZt6Jqt8hETMIQfz7o/7/j0KmGwgOO4mllsDDCHQUiq
	ll0uZVYgioossVVjwF/UWLhD/ZekV5CTJnJoM4iygo+uJJrFORVZTqYzHCD6j6fJhdI=
X-Gm-Gg: ASbGncsByThckPf5F/4oy6y57rG1NONbanXaoi9I6d9kWd2jA/hBh2Qk9yRvXk/w+ZO
	2szKwiWC/yii3+6NjuEaqLefxftMi8laSBssLb1tzd49aZ3wk0RTjOOALTDoCI1cfC/mhXVBuHj
	c/Fz3wiM2xxI3GQHV6CDVqM7isPyUf598BpAlQNEAdnQ1dC1YQMpzFrA0NqbxuO5VCtjEKbqHUj
	SnepzSLGgNAj7gwuI5LAVrgQKfje+ZYLAV156nTIsBZzU76/FoU7NubuXasl0v0aOfA0GT0Rznr
	MnkJ29WX5Im6TMyvF+ab+H5INUR/rfCxWa65cFcOSVOnUL63A0qejSAqzz4t0n79+KNoqrXBize
	IPOl1nhUwBMnwCzCppHRp2qyPCTxZnrFapD6c3DguENIzAG8RMRv93lwOaY2o32SO8sZc0eX9td
	V3LZBZVG+a+KalQX3ku6ZAEJ2c2yOspQ7UMJlayBeC37XLPw==
X-Google-Smtp-Source: AGHT+IHvDD9XJ1vRSH3cXt3DI3SdXcHBMF1NFxrmnD8Bb/1OzLxNUSC4bWEuB+gxH+suooNl8D/8cQ==
X-Received: by 2002:a17:907:1b15:b0:b48:4966:91a5 with SMTP id a640c23a62f3a-b6474439497mr3315552766b.30.1761219615642;
        Thu, 23 Oct 2025 04:40:15 -0700 (PDT)
Received: from [192.168.178.36] (046124199085.public.t-mobile.at. [46.124.199.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5144cfbcsm192518066b.56.2025.10.23.04.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:40:15 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 23 Oct 2025 13:39:28 +0200
Subject: [PATCH v3 3/3] arm64: dts: qcom: sm6350: Add interconnect support
 to UFS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-sm6350-ufs-things-v3-3-b68b74e29d35@fairphone.com>
References: <20251023-sm6350-ufs-things-v3-0-b68b74e29d35@fairphone.com>
In-Reply-To: <20251023-sm6350-ufs-things-v3-0-b68b74e29d35@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761219609; l=1043;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=p95Yod17aguDEQvaEd9jFzyjpv3eP0LhnfZGpsw/x/I=;
 b=287cSFqIZpBinFoMzW/Pd2lFwLD4usbtB6bd6jWXziSDY0JCm4sfCEqMwGA3nCItJX7zjP7Ef
 J91UNtGS+N8CHwYp4HrQfTP5sIo5AzXnJ+P/BwWvV/ljlpPM7o9ijaR
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Define the two NoC paths used by UFS: ufs-ddr and cpu-ufs.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 30e77eca4c02..01977d692755 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1178,6 +1178,13 @@ ufs_mem_hc: ufshc@1d84000 {
 
 			operating-points-v2 = <&ufs_opp_table>;
 
+			interconnects = <&aggre1_noc MASTER_UFS_MEM QCOM_ICC_TAG_ALWAYS
+					 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_UFS_MEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "ufs-ddr",
+					     "cpu-ufs";
+
 			status = "disabled";
 
 			ufs_opp_table: opp-table {

-- 
2.51.1


