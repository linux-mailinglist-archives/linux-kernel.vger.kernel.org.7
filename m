Return-Path: <linux-kernel+bounces-866851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AF443C00CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5BF6834F25E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2507C30EF94;
	Thu, 23 Oct 2025 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="NExAtWFr"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691AE1C3F36
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219478; cv=none; b=MQFv4y7BLt1qJN8wQvd1BnLE43PaOaboek7V7478/EwYzROIJ8xlTDaFACI7p4caPCyBIQlQoAWL3H/B7XiAmPuxhwJ2OHQb6jmfGRHHvg0JpSig3BkV2gddOVYnSeBLus7PENG27mcDeZGmY9nNhh+01y73Tdncx1X3EkXUvzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219478; c=relaxed/simple;
	bh=GJgR0piJewspDPvTjgPSZy1PlRFXkZDs+X+4UGYsrvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fG7HCECNiJlDVeWWmmWnpx/fUHqkPP0gphc8HJsUi4ezBND+ht7DkYrVDMvX0FJ7/Z6XTIKLC40uzu2G2Y6VbVlJr+3MIDcM8ZRf8+ODU5yvXK6h0R1mTYu/3MDt02x0/H8b+Cr9NctV3m9P2YWqDEf7EyfYY3uTezRAxhf0Y5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=NExAtWFr; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63bf76fc9faso1339201a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1761219475; x=1761824275; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZG8pDAyRGU4j+CYjezXb+fmm/GWjAFggZfHcmsgAGk=;
        b=NExAtWFrMAX8VvYr6RC5bFs6/oZSbvo6U0hzm0KTF6kvLYF1lPA3fGp64DotLJkJ9I
         v+b5T8yJr6hZ7ohxiJtDOO73LcciB3BOkwFmBlw9rAHSFx25GBUvNJBfSkUrP2RxBN+3
         Lu9x6uUq8BafoTH/xnfOPV6c/2vfeDwRqbWDeZ/OlXZoZqxxVlrUoQjTj6c8hcUPEeqy
         KWqUZkoSqa6kVMiVT88jOiVqvAQbf2AEL6mdrP35XPevF6Ej1c4l8f1zysPjGxzSd0y7
         TfpFYUHMCuyljF8QkF6bVfF82+FxGs51TqjhnSiKm80C7P5vaho+MtGHGyaIt4xm+yxG
         5rKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219475; x=1761824275;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZG8pDAyRGU4j+CYjezXb+fmm/GWjAFggZfHcmsgAGk=;
        b=v/ysrTuhTYVQjlVoqtsFUfof7nl3a7zErSOGpVb7E0vAO1T1A1bOBOBwHVVGeFSoCc
         YIJ8bF2l3QDrk3Zw9CCP5qdGDg2JzeCx2ldZLT7uJPThjgaLxcBNRAnowK28ejqADJbg
         qVzI2o51aVh4rhr+o8UhxLkC2FY8TO253vhbbjEPOA0IL6Nf1Vxkut8fFckBLF++pLyP
         fuSY34RpNpyey1XFuge1R94DPXTn68jfsRNe/Aaq9CRZBl41bnDcuzfSmc7npiRWTwgw
         XGQYkmMdVzUZu+ttt/LHSXiaxN9DAoP5m8ENtkg+284ooRVPSdHVhsaVKXRNkLuVzV9u
         /UIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKLLHia2nbHVpA3YJWpyRzgvkaEwIjHzltVw6YnBYUD9W4VIEhjGyxiHCTqhB3fdNVdxE0CIPKfktSa1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvZiBJaonU/O6PPxTXO91wloQ6+NBps2TIiF3du+0kvAGxo/9U
	/Occ0a/JljtHU4vy9Lwij2mp0pyJqmy+Yt8qYCW85UaWxaLuCkmzfIfXEPNgk0WfhQk=
X-Gm-Gg: ASbGncv7e+XCdkU+aZQy4XP8Rn25iaZCdFCckzLdFoutserBa6KLdYzJC+UqBekKgmN
	C+W73vryeaNBHoTf3PFNajMtI1djW1A0KCLhQWzgIQBO4OfH5+5+67Vfsf2l3HBpylrPwqWChgD
	/2ki8L8F89BaQiZjfyefF13eEJ+OpNOr8h6BsY/yvboa2maqN/68DIH+8L3l6mTBpCSvb6SUzjL
	TGWw9wmNbi8JGABShR2Fng0Ifv6zheXvfWB4N21JONBuTh2EaVWKv/rQD55u5y3tF+wtdI9z5Ke
	iygYHSI7JNKgzoKow2x7J0LgztCG2HEVAz/i/vrJbDJRkbjbAJij7w2fjIduTQo3OM7luevOobi
	QzuOgbWJR+7bPpamcH3ERexWstXsJZ6DjpXtsfSMU6k+Ye9j9qrIgNNrXeqH4A+aGoust1s0Xd2
	y6EL627Kq84oW73urGecOZMvWr/p2LqLvFcegeB4LAxDTCPA==
X-Google-Smtp-Source: AGHT+IGgEGXohmOqHS9yGuQlCdd8uGwSygJIKko98Cg7yAhq0Px2UU4LFUF4u16ehnOrRNdCND3Ckw==
X-Received: by 2002:a17:907:3e21:b0:b3e:c7d5:4cc2 with SMTP id a640c23a62f3a-b647494100fmr2970425866b.38.1761219474748;
        Thu, 23 Oct 2025 04:37:54 -0700 (PDT)
Received: from [192.168.178.36] (046124199085.public.t-mobile.at. [46.124.199.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d511f8634sm194429666b.29.2025.10.23.04.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:37:54 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 23 Oct 2025 13:37:28 +0200
Subject: [PATCH v2 3/3] arm64: dts: qcom: sm6350: Add interconnect support
 to UFS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-sm6350-ufs-things-v2-3-799d59178713@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761219468; l=915;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=GJgR0piJewspDPvTjgPSZy1PlRFXkZDs+X+4UGYsrvk=;
 b=Sb0k448v9TsxGsSuOooenXHa5OGDK73tnPnG+dkbLyEQRJVGxxhHhLFd5mNEMwlJuKhDpqLjZ
 QKLiP3a21LMBP2DaNmmelxIZgs6pamR25iKz8EwpqEFJ5ZCwIJkVne3
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Define the two NoC paths used by UFS: ufs-ddr and cpu-ufs.

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


