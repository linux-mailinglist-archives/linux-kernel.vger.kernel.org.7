Return-Path: <linux-kernel+bounces-866850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C68AC00CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3330B1A61D31
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB6130EF62;
	Thu, 23 Oct 2025 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="jS9nCJ6A"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D5E30DED9
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219477; cv=none; b=TfqksvNwV+1oIrORpcPqFw7diJqn0Q3gsPhkiYsk1MjXe3Qksvn4oKFXfiCDa02WcIVlVak7GXiK//D1bMJfDHJWR0MFeptp3Ncq62GJP/xxTG5RP83tqkoEWpAxWZVbCGI/YcwkXHVzhWFvmYA3puDhR9D7EyKieQa/JA/dAIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219477; c=relaxed/simple;
	bh=g58KuzkktKQpB2ABG9JXwvSPtzU67rd18b8pTepHPhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fKwxlE3LEv+qAhA7sehYoZZQHQyL9dq77S50/WUp3XtDOMOLNquvFKKyEofbY5vDnI5aGs/wQWT059tmeQefwmASDImo1Ez3n03zYvETRbhmM3eKY0+6QQW+XoN/fByZJgGAfIeKw2sPWMwrHsQc+v7fnlybBBVu5dpyaq549FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=jS9nCJ6A; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3c2db014easo163552866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1761219473; x=1761824273; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjI2aJRLw2mG2p4ljVDPimKDlO2KaZ8by2HdaZyc1co=;
        b=jS9nCJ6AD0UffeUVIExSuwlPjWmLq/1fiLKYn4bfbi7MLoulYC8BTwk2kuO6Qshh27
         5aLOTDNapWPm/cqYAfM5DhNt9Qa0B2XyuHP9uxfA+Eb6BtA7nT2za/6mfyvt1MI0r9+6
         blixPAuU+tVh7aONnEdrvp5JjEv+1J2pkrlLzJr8Gdwlg49d6j4g9qtLE/KbKhAalEU8
         MmLDlmPc93wX71Co42U052nTQRmCq47CBtJHD0ruWqyXIrDB4iYnVo+hv8OeHZFyfUO7
         SlKrKy2xUDx0liGqCOb6q6oESGZJgbPgDi8kd0kkhN1lK4Nu1WCfEK0+/jFwraXh9MBw
         Z8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219473; x=1761824273;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjI2aJRLw2mG2p4ljVDPimKDlO2KaZ8by2HdaZyc1co=;
        b=i4Mk3yDXufbBwqKwfj1uMM1bh++ub6YB0qx64M3RZm+tRqZrEJ/QeBK9nK8UnTZor2
         zW47ZuXWaRuQvclFKFe2rplHIzdrWkqQ0zcTTHI+2FWlURV8SRhFidzakv0O2kdKDFK0
         p3Jbhb4vIIVMCGzWyqIYGXuN2G2ojAIGTpqUCsRQBVXbwqusKPnPBwH/g0zbFxEREr5Q
         gUbDHbyop/sn/52KwCNEQN5wnwbGq8zEI+v+i2H2QqAirp2czOd1hIPPTbHf9BLFoaxQ
         5fnwukgCVhABGuozHWjAGoMxNIjvPShUeYOLvt9DoM8Qtf1Wfap+IqRNMltF7KmZJXNE
         tCuA==
X-Forwarded-Encrypted: i=1; AJvYcCUMFj1xZds5guT76tFS5xof0S62379nIeH2IcWCMKhDFu4wtGzvPDPpOXlvLWRViFA4nYR3vqOCEx6O3Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0nC+v9e39qLbUmMTKfsagvkPUOHXhS2uWHlw+OcnSFh5KkcXG
	oU35d6azXyDqVCCSEKBhhNp36HYNYmsa6Ebx5C5yuY2R3QnPQd2u0De+dpU+PHGGn5k=
X-Gm-Gg: ASbGnctfgpZwvYhcXOwy1ah6NjQ/V0PJtmM61k1gHrm8KHUSPZBi/Fk62qUdLB4l7/s
	4kL96p4r5rAIXpwS808S1IUvK4uHVlM6mfuuJo4aUGNLzwCmJeOYl80Ug23XDPWm1hzxB7nw2lB
	FD0wYfy2o72VO/exGPH3f5m4xrZzu87oxduCbj7qYiTggTOkN7DdOUBBzoJt7t7bCbZ+ohHPyQW
	lBU1k1HYGUwqkEvrg4ziVV2Oxg40NNeaH5jLw92DC3FcvBKoZXWwKhT4TX8ZTXR2mWPERECHO4U
	1VPXEfVAoUlaW1uKgQ0wlSIWpLlS12VdPHdbgB6gL/e+OV99lGDDWzrHvsoc/+hFKxzV9VdumU3
	zy6yYojyhQ4komrz4fdAjS6Cge2YMHvP4DG9C+PXvHGTk5L51g4C1xDFXLZCJbCCQdJjGSOy+Vn
	WpAP+mmb12Pstj7QFz/cM8TgReQk4yOc4Ermnrc7vvuQOX9gJ+kzTmSRHb
X-Google-Smtp-Source: AGHT+IFB0A7MKls2kHsI5nX6WsoE/dx/at6LNgngrYv4dSUQbhkg+Or/JWcuw9BSWnZhYzFJWcxWXA==
X-Received: by 2002:a17:907:3f0d:b0:b49:5103:c0b4 with SMTP id a640c23a62f3a-b6d51c4bf45mr279214166b.56.1761219473297;
        Thu, 23 Oct 2025 04:37:53 -0700 (PDT)
Received: from [192.168.178.36] (046124199085.public.t-mobile.at. [46.124.199.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d511f8634sm194429666b.29.2025.10.23.04.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:37:52 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 23 Oct 2025 13:37:27 +0200
Subject: [PATCH v2 2/3] arm64: dts: qcom: sm6350: Add OPP table support to
 UFSHC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-sm6350-ufs-things-v2-2-799d59178713@fairphone.com>
References: <20251023-sm6350-ufs-things-v2-0-799d59178713@fairphone.com>
In-Reply-To: <20251023-sm6350-ufs-things-v2-0-799d59178713@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761219468; l=1930;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=g58KuzkktKQpB2ABG9JXwvSPtzU67rd18b8pTepHPhM=;
 b=GRRmF9C1XQ5OuP3yDDE7QI2w32CcMFfuWZHPb78W+IrWkSEJhyBLbS9EyNO0PXqFRB4qzp1CK
 QU60zmIGBtND65Rzz7wMMqLRVWNpGPhED0HprkdCWDdb8pmTrwgbP51
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

UFS host controller, when scaling gears, should choose appropriate
performance state of RPMh power domain controller along with clock
frequency. So let's add the OPP table support to specify both clock
frequency and RPMh performance states replacing the old "freq-table-hz"
property.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 42 +++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 19a7b9f9ea8b..30e77eca4c02 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1175,18 +1175,40 @@ ufs_mem_hc: ufshc@1d84000 {
 				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
 				 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
-			freq-table-hz =
-				<50000000 200000000>,
-				<0 0>,
-				<0 0>,
-				<37500000 150000000>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<75000000 300000000>;
+
+			operating-points-v2 = <&ufs_opp_table>;
 
 			status = "disabled";
+
+			ufs_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-50000000 {
+					opp-hz = /bits/ 64 <50000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <37500000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <75000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <150000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <300000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+			};
 		};
 
 		ufs_mem_phy: phy@1d87000 {

-- 
2.51.1


