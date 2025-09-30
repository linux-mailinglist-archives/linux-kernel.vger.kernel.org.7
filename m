Return-Path: <linux-kernel+bounces-837758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 506AEBAD1F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C2A4A43B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC21306B05;
	Tue, 30 Sep 2025 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="YnmsVLG1"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B7A3043BD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240643; cv=none; b=YrcW/QFIdayqeEa1UHh76l2M7L7yvk+Zs6r5NPB0qMONElEIOCCxEentDaesmKRBSUvpnIIIwdI+uTPv/9+ibXyQ/GwP3l+kWYtPoPt8q8vBoKv/uufQd387gj6zbxSCH6eimxkUido5WgSprTsC4/4SHEKprs5f2SWfGC++k+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240643; c=relaxed/simple;
	bh=VdrjHbZY8p6JBS2yBxBjZF8UPgGBrsrohOZQSKM2ILY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TZZY3hrPJKzvs5+kTQtYCL+DsQC0cChY9XF/arjIRQsWkn6RxEUEUEDDxRB65CjukawWeU5SxuDF3x9KpfobF2d1weOR2C/ZECAmGy5yMypDyPvDRqvYEeQ83LMk36r4MKz1WLucmtIdhrDlz5pFEd1Et2fBJ/PaG9gLe4J00iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=YnmsVLG1; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b40f11a1027so323538066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1759240639; x=1759845439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IhQc/KxHi+cDc2kNGR6DJ1hzrVsKnRbRYRWEuK1eFg=;
        b=YnmsVLG1GKEDlBWH3NHQeJz+1pBjCRM3cISRPIOJSAjbF6pNP+JuNQSoL+qXt2cQtU
         18vGO3YJDMeaWQDNsm5TkW2J7InP4yPF3RVyRWvFP90rlbxm+ZbW64opvTS+s9cKeL8d
         vOEVv2TtQ9whNkXzM940UHyIRJTO2bVzb/yolDtBRs9SF2vo8DFbcYKFpgmEkCnDoVvR
         eVAbzVCOD7arZ0pIB0QM/63Vx9PK6mYNxtf9BRXoYLP5nVQqR3b30OrRAjL7Km0VbpZv
         bX4h1Zuht6UOdNZG2pZMC40x6DksXizwIJp0QGUXFLZ958cmgqG+ZEa31n/4n1fURCzp
         wjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759240639; x=1759845439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IhQc/KxHi+cDc2kNGR6DJ1hzrVsKnRbRYRWEuK1eFg=;
        b=R0qhXmT1jlpoTVJy3O/aVqpCYbE/2oG+CljEI3j9D8J26fgFkX4vmLRPXcOGRD13aV
         FkfGdDhj6dnQMfr7Pwn93SEAKKTVarx13wxK8WdO/lGvU3sLJi1jM8on1FM4nldLvmat
         iyzATNC30HSOhDtvxnaJfbONGlgKrqLbCzp2oThUVlMF70MrRic9gChW1EsL1NXKX/Ls
         lH/s6P3NHOs8BNojZIyHxAv7keVlr1P5x9aC+gzFBZLrYQBe78WD/byoOKDx86Z/tDDc
         ELO6AL+l1aVX8Le2Xz8ve/VHKuTqOfuF7jeCgNTXdsnTqtIqa5Oy/FLb39PjbFV6pw9k
         1Zbg==
X-Forwarded-Encrypted: i=1; AJvYcCWj3LFE/pgqdXqzLH/8CQrtf3Urk5NC2FC2p0IODMmkY4GFIqFXuAMXU+rUe32ri9zieRCk16I1JOXMV5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7TMD3SKkDlSRj3LUGKSwQ+MyOOV9IX4eWveFkIJQCphFn/3zJ
	mjHvgEKIfpEJDsMjhqbGE/Bbeegj/U99OGnyjDYAOym/U4cM2xrp2VO3h77kWYAFrKs=
X-Gm-Gg: ASbGncsZX9fGw/0PPNbJKHF8DlDAFEQj6uySpDWVDHWJgvSeaPbi3vKN0E76sft0PoY
	kK6XeGzdMM4RFTA2gqauAfl88T8SK3f/OalKB3HuCS1cn6qMmTTbbOu1aUpH0sqxSE5HvK7hJBo
	v6bbHrFn0Bt3VvclxufBQWoWW86hfchs3TZ8sFGgTAcvyEl9EZivgheVQ8izfmQEJCVyUeBb451
	vH7yg8utKXm4rtB3gX+DpXfxt/hNEOlXp07cmeNnVstCDvqRlAZCIeeJW8MrkN7OhOPij//mUCW
	piX3bkT+7EiJ8t9pHDF2mPlFdGE9VNReCcAppY6vQF3Zo4i5DoX0/2QHLwyxPBMNa+sp/WFYxsL
	MSkUnxqEkM7Vbd3op5eJt1elgcQdiD2RcPB6VHqHa13uwgO0oWbE69i8LyKJHdsSQhnyA6cuX7T
	5XPMHe3xQo4VgH++krIg==
X-Google-Smtp-Source: AGHT+IFTx+BUtdYFfL6HuTb1lAb8kQTNr6zB4Xa+33+fIcOgSz29G8fLSpBMc7T/d9jfJ56OBR2HxQ==
X-Received: by 2002:a17:906:6a1b:b0:b3d:73e1:d809 with SMTP id a640c23a62f3a-b3d73e1ef65mr951599166b.48.1759240639542;
        Tue, 30 Sep 2025 06:57:19 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3fb818fb90sm370234866b.63.2025.09.30.06.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 06:57:18 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 30 Sep 2025 15:57:04 +0200
Subject: [PATCH 4/5] arm64: dts: qcom: qcm6490-shift-otter: Use correct
 compatible for audiocc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-sc7280-dts-misc-v1-4-5a45923ef705@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759240635; l=869;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=VdrjHbZY8p6JBS2yBxBjZF8UPgGBrsrohOZQSKM2ILY=;
 b=o0gnni3kPdNO8veSF1wAx3y60Q78M2zZesq5qeidQB8NNxrF5O/6nLJWVHRu7ouKyWaZEAPrV
 ory0fpzeVztCEIjjhL/6QuRUTbzUT9onXoQyRzZnEeVi2/Wb7hk6jyw
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Use the correct compatible for this phone with standard Qualcomm
firmware and remove references to power-domains from a 'reserved' node.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
index eb8efba1b9dda422dd0295db2a52420a1a23d070..6be2ebb2958f5535666ddc3866d2eca9272abe59 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
@@ -568,6 +568,11 @@ &ipa {
 	status = "okay";
 };
 
+&lpass_audiocc {
+	compatible = "qcom,qcm6490-lpassaudiocc";
+	/delete-property/ power-domains;
+};
+
 &pm7250b_adc {
 	channel@4d {
 		reg = <ADC5_AMUX_THM1_100K_PU>;

-- 
2.51.0


