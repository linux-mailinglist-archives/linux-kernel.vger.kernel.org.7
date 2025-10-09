Return-Path: <linux-kernel+bounces-846503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEA5BC8307
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2BD10345A88
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363FB2DAFC1;
	Thu,  9 Oct 2025 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="mHY5HSxo"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C252D7DEB
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000811; cv=none; b=k4WA9vmLWCaHEClG08K/s965qWsQ41bGdmTO+6spHFcFfX32MwG0C1SfJiPPc8kmcEI3bC3RUueIw8rc81u1zBi4lteOI51g3gPpzwnlVOhrsJ+EZ8Dd3N5FSmI1ljapdjhUvuaTJ1iGL7iNnVB1zkGDHjt+rAPlIUlN3sU32ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000811; c=relaxed/simple;
	bh=KxhWShlkMtnpgvA9wjVU6mG7t9GuRy+dxnd6ohchwik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rEpvzYVJT9jUUtsdIhwJE2kPCe5jHj6YtdVUkp+itk3KoQUEB5jqnXU7mhCa5AzaLQJ/YH+SWN1c/Qd1x3Gqi+SL8OLvClH6GpevNzFKtvCEgbnnnFSBojx9RleLuNQ5zn1MqK8hz1KWea3PdSopLTxuulwO86CQmLu0D6YsM8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=mHY5HSxo; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-636de696e18so1420041a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760000808; x=1760605608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOPGlZMdi9oRl632ND1QurYAdEQ/NjrqBwEHEKFq9ks=;
        b=mHY5HSxoMIr/iJDPAmDaWHY6hlykl1nXb2pepwMYNNCLH/5mbUP1dEvoP5U5E4oCWf
         WP/OAtMPueR6zvZr50kBGNy61e0K7+milgJgoSS3IhYnN0wOPbhXlHnNBVSYaYVUYfmP
         LTKm+jlRlQFGiL+eOp3I++mlOdogI27qCNHgj4bFkt3NHGFbyN3qAsfF7/u09un0CStT
         xeMgpapEtyV9Lc8lNd4s7j+2pSg6ZS2BdLMlUlDBsrYG9t6OlGJJEcQ4RbXoej1J4dCw
         CfFk2aOfXhuEhjnjWNC6WmnOHwOKWmbeqQN/Y65Wv4ucz297gWDVT/Hu62D6LP3Uh6lQ
         uydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760000808; x=1760605608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOPGlZMdi9oRl632ND1QurYAdEQ/NjrqBwEHEKFq9ks=;
        b=qGUbz/EfSezXVX3zTHO99J5tl+NRXtTWoXNcbgre6IBDooaUZY+xenqAAAYbTNExod
         UN5luRAu7A9ZYhTfn4/yM8H6R5V1ZcmdEEN5Wlq/7Z+7SLn9JhwcOKiwcE/6PSvB2R8R
         QVTIIb2N4pKkU610X2l9H23OsHJKdVPyDzqIpDaXINhOAhK1VqmRhXtMOYZPCWAtQFOa
         lkYQ+iqJF/nTP4Q55CROX4VjLmVZpNAAAmTIYe9A5Jj+BLbUZ8NQH1EFG9LL+jhazjon
         9DsqVk7PCf0kbPYtYQUDCXsGyNdXeZ8eQHcAaTwFR/NzN56sekF5lCs5WzKLGLYp8NCS
         NfIg==
X-Forwarded-Encrypted: i=1; AJvYcCVZpriiIK8C0NU2YYJAaggoNV68C1GdqOIxDv8W2z9283eMCFc/PWVEIT7bMjK5I1G4pc3e5zYXQ1XyU24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+S/QVFoyOBFS91/pACAk6kjQvH7UGw/HpBIWBWd7F+54Xjk5r
	Cp9tARHsyisledT+Nm+atyH8v1RoC89Q0WT8is9Y5RZdaVLpinBm1LHP5vV8i3I32wY=
X-Gm-Gg: ASbGncux19h2DM3pvmNH571nTJpFAOERjaINQsfYactCD16RtPxVblGF6lsabrytuNs
	k7mvOMR+I28OsFcwiPIb1n4ijAliPVm3qbBOX/NUMIJNLOpoOTxxGfFJz4ogkBg8ok2dPGsOdtt
	6ruBI5w/g4e8FD3dJdLshjGQep6LlvuLAkeig3OfESGRskD/T1DvEQhIOK6HyBFlTBZKKH/k+gk
	2wo+JNw5eBuy/UHkcm521M0y6aJFELc+/TbooYAbyb7mH2AGS6WpN266mieXZ0DxLI6+uchxfrt
	+hC0jkp59GnJT6R1HgL0AgBZRiWi/ogxT99dQN1aOPtuyCvNyy+J+JliPCqmr8Rafm8eQcvK/zc
	TZHJTjXUTo6JD6JTg4C0m/T5NkM0t12hvh6H/nPIMnWvO5tDK2/LnkesU39O32KTn5QNEO2I4xw
	8n7QmZPXnX+DT6rVmciA==
X-Google-Smtp-Source: AGHT+IFHCm/dEaK50EAVOzvdljY5VuiyPEN2smCFmrRrLPkfy8suvXNEKkRcoKJAFNBkFgvYS+lgbw==
X-Received: by 2002:a05:6402:d0e:b0:634:5381:530b with SMTP id 4fb4d7f45d1cf-639d5b8956cmr6102646a12.13.1760000807576;
        Thu, 09 Oct 2025 02:06:47 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639f4109046sm1905755a12.44.2025.10.09.02.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 02:06:46 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 09 Oct 2025 11:06:33 +0200
Subject: [PATCH v2 3/6] arm64: dts: qcom: qcm6490-shift-otter: Add missing
 reserved-memory
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-otter-further-bringup-v2-3-5bb2f4a02cea@fairphone.com>
References: <20251009-otter-further-bringup-v2-0-5bb2f4a02cea@fairphone.com>
In-Reply-To: <20251009-otter-further-bringup-v2-0-5bb2f4a02cea@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Alexander Martinz <amartinz@shiftphones.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760000803; l=1053;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=OCp7Rwq6dXcutSgzEgmD5mLRNx5n5slwM/FWE/OfkjA=;
 b=+5zFyGY2k72voxYJC+mcK4IdqLYco3K+BRC/ZE5ickeG58QeQ3Czn8qg7S+adNv9qW3LhsW5C
 BRUAMAhdeKFCVqPOtfPKebyKMjChhjY2c7/OgilVR875VwiNVkhi27T
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

From: Alexander Martinz <amartinz@shiftphones.com>

It seems we also need to reserve a region of 81 MiB called "removed_mem"
otherwise we can easily hit memory errors with higher RAM usage.

Fixes: 249666e34c24 ("arm64: dts: qcom: add QCM6490 SHIFTphone 8")
Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
index 0d331bda4a82..31650c29b1ca 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
@@ -118,6 +118,11 @@ cdsp_mem: cdsp@88f00000 {
 			no-map;
 		};
 
+		removed_mem: removed@c0000000 {
+			reg = <0x0 0xc0000000 0x0 0x5100000>;
+			no-map;
+		};
+
 		rmtfs_mem: rmtfs@f8500000 {
 			compatible = "qcom,rmtfs-mem";
 			reg = <0x0 0xf8500000 0x0 0x600000>;

-- 
2.51.0


