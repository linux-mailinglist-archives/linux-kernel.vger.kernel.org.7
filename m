Return-Path: <linux-kernel+bounces-727074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98273B014B1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7137E1C2172C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088131F873B;
	Fri, 11 Jul 2025 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="GD/yEVur"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58C81F1301
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218936; cv=none; b=LAjid7C1qxRYIqsvsVPd6wH4rb+nwcduWElsJuUWH6rspBruSbL2WvgLUWpWjEs1YrJT1xAZPM0/ilLBFQ1bSpshUGpOgwJtdmNQQtqVZs7LnphxZDkBSGjSVHdwFX6gde4UKYmecWutSJxBDRCoaQ+AvmwO1CtTfO2qu0c0En4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218936; c=relaxed/simple;
	bh=1rJyX78ZGZNYEFbjBykjf7Y9bN2ogdhB/90ownhMlsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mhvh85lbejigHb1MfYIie3vpCoueYQbOS4ndjwEsh9c5btPyvqAEaqC1MtYCQAsPoN0ggBVFdcdE+v5U9djnTEhxJS9XNRhvmPSbJJnBUIxGauwY/BgIHcCooS2cBhndtXvzirzHkMw2/77z2lZ8Pf6chv/VANoQuZ6yIWxXHEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=GD/yEVur; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c60f7eeaaso2695912a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752218932; x=1752823732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IAeKnBk7AeBEPpI+kPwcWaQqh4WHWcSI3BNxX24MIUs=;
        b=GD/yEVurJzfZ/yiN8rIEqeVZspmiz3WxuEIzdpQrh+CopR7lHDb+MYfEbysAYytaAG
         onP2xqMOZKJDpMdpowDm3FiWXXb41WX3UdmRGy+7XrJyz7yaIh1iKAQoJJL8GYb7pOas
         AD0mKeZWsEoLtGgPdUeaPOlzyPgtCeCbPM0fOTFWuPaht34BBq4EalwH16AkaXt9dxgL
         8prsynI0+deiOkKFTn+J+te7/meVdMFSCD8FKJKR8glxn+hNpSccQ+OHZxwxot82lzjW
         NgtCO4ezLUFyqTkhYn1cW5AyrlTsI7MMXkK7NDIoekfe+Q1mCz64wBmPGsHn89sJoVMq
         XG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752218932; x=1752823732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAeKnBk7AeBEPpI+kPwcWaQqh4WHWcSI3BNxX24MIUs=;
        b=PkpEUxQ61edwfD/vYnFvuImtBsppu1ngzmel4E9DH9rUohE66BbsLgrFkt0YxxpBfH
         Xfo4bUYnIv1lbawKQDuPDe1Dm7ePJ4VoxLP0zVlPJG7eJD9aRyTkxnMVLfb7J+fTEeF3
         bjoACN7Pt430LmC87mtZTs92KNn4UG61pQc6GkHRh8Gq6FtW3daZb3W8qGaXxpKF1OaW
         FzZ4988AzXsRR6Y+yNomQzzWUsGR+uZAYU70iNBeW7rX9NPEqbYw2cVJvPBTQTXqVUdO
         C94zWBCpqXXEr6Cf+/j7MZPcvQZtNZ6uug7yZZg3I+NQm4ofB/uiHkYOYS3kRAG9zSDp
         SGEw==
X-Forwarded-Encrypted: i=1; AJvYcCXfaDpUIG+m/uaKifwHKWvvPo7slO4LJQrlTZI1w7hcestVSAyLaH0WW7yUw9o2HMWMWNeh2oQ7LpX/Fqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4P6Hcaj3erxh4B/m9vdNEDbTFjTSocenMNMOaKiNX6nxRo+Zf
	G0aH5SWzKmtpyzx9Vgrg+8D9nis/1cB5yXEE8vEIGMZxTXVs3Ia7KYsZSpccXvOkjWA=
X-Gm-Gg: ASbGncuMkxVbOqyiGEt2fb43UyKt3X8EzYMNXyvkBDuvzk02JY0hQ1aeeRpMROY5yu2
	G4UC4TrxIBo7rudng/asuBckCT4tbcVLJSxEfuoOL9IH+NaUR9V3n62vxt46Jv9uR3HPVLImMvE
	mIQ8ToUMjW4n2PMmc2mXzlN7R8HdVv0ISJsGk3XA3Y6HXosUX0ykhD5i1AR8IADQNpxQcAulcQE
	Ws0XYAKSQyCxQq+cs+nux0eSSNPIkRyEILZHgIXVZQ9IhpoufB7cqlJx+w9nZOKrUZAei2///P4
	FIYwQ2nmjHIHfyxjlYVfrqXF1aWbeDU5W662FAg3cMpOTccP8GjZASEHg8HE+DsiBAIxARhAp9y
	nAA9oYeimHXUVMwKCiF2C4Zta5b+uRPm05v7xJB8q03YBnJ4LOoOaUr5FEd5WGrlDm89cUv845U
	nxB9E=
X-Google-Smtp-Source: AGHT+IFMz6lKDA77UqprQucHiOvgihe+lQo5kZdgp32pGRNygzhqPXUAgko0NrRmtmc0fYzqQaAMlg==
X-Received: by 2002:a17:906:478d:b0:ade:43e8:8fa4 with SMTP id a640c23a62f3a-ae6fbda1ademr243305766b.18.1752218931807;
        Fri, 11 Jul 2025 00:28:51 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90c1dsm252600966b.4.2025.07.11.00.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 00:28:51 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 11 Jul 2025 09:28:41 +0200
Subject: [PATCH v2 3/4] regulator: qcom-rpmh: add support for pmr735b
 regulators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-pm7550-pmr735b-rpmh-regs-v2-3-bca8cc15c199@fairphone.com>
References: <20250711-pm7550-pmr735b-rpmh-regs-v2-0-bca8cc15c199@fairphone.com>
In-Reply-To: <20250711-pm7550-pmr735b-rpmh-regs-v2-0-bca8cc15c199@fairphone.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752218928; l=2223;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=1rJyX78ZGZNYEFbjBykjf7Y9bN2ogdhB/90ownhMlsU=;
 b=o89fvwotA24xkZ1qUTNLnRXtkS/1oY5KZKFFyOlZK/WD1Rw2mC806RlRdPrPzWZuOOu1bTym7
 Ou2dFqfSv8HDk4q8cEmWP6eL1aXUZDcopmEZAp7Dhlf4Ml68o+mGtZu
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add RPMH regulators exposed by Qualcomm Technologies, Inc. PMR735B PMIC.
It has 12 LDOs with 2 different types, L4 & L10 are LDO512 LV PMOS
and the rest are LDO512 NMOS.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/regulator/qcom-rpmh-regulator.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 7870722b6ee21ce487c2cf911760fb4a385fc44b..7b1743d51fd145a44f98dd8e605b4ca410046654 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -1476,6 +1476,22 @@ static const struct rpmh_vreg_init_data pmr735a_vreg_data[] = {
 	{}
 };
 
+static const struct rpmh_vreg_init_data pmr735b_vreg_data[] = {
+	RPMH_VREG("ldo1",   "ldo%s1",   &pmic5_nldo,      "vdd-l1-l2"),
+	RPMH_VREG("ldo2",   "ldo%s2",   &pmic5_nldo,      "vdd-l1-l2"),
+	RPMH_VREG("ldo3",   "ldo%s3",   &pmic5_nldo,      "vdd-l3"),
+	RPMH_VREG("ldo4",   "ldo%s4",   &pmic5_pldo_lv,   "vdd-l4"),
+	RPMH_VREG("ldo5",   "ldo%s5",   &pmic5_nldo,      "vdd-l5"),
+	RPMH_VREG("ldo6",   "ldo%s6",   &pmic5_nldo,      "vdd-l6"),
+	RPMH_VREG("ldo7",   "ldo%s7",   &pmic5_nldo,      "vdd-l7-l8"),
+	RPMH_VREG("ldo8",   "ldo%s8",   &pmic5_nldo,      "vdd-l7-l8"),
+	RPMH_VREG("ldo9",   "ldo%s9",   &pmic5_nldo,      "vdd-l9"),
+	RPMH_VREG("ldo10",  "ldo%s10",  &pmic5_pldo_lv,   "vdd-l10"),
+	RPMH_VREG("ldo11",  "ldo%s11",  &pmic5_nldo,      "vdd-l11"),
+	RPMH_VREG("ldo12",  "ldo%s12",  &pmic5_nldo,      "vdd-l12"),
+	{}
+};
+
 static const struct rpmh_vreg_init_data pm660_vreg_data[] = {
 	RPMH_VREG("smps1",  "smp%s1",  &pmic4_ftsmps426, "vdd-s1"),
 	RPMH_VREG("smps2",  "smp%s2",  &pmic4_ftsmps426, "vdd-s2"),
@@ -1667,6 +1683,10 @@ static const struct of_device_id __maybe_unused rpmh_regulator_match_table[] = {
 		.compatible = "qcom,pmr735a-rpmh-regulators",
 		.data = pmr735a_vreg_data,
 	},
+	{
+		.compatible = "qcom,pmr735b-rpmh-regulators",
+		.data = pmr735b_vreg_data,
+	},
 	{
 		.compatible = "qcom,pm660-rpmh-regulators",
 		.data = pm660_vreg_data,

-- 
2.50.1


