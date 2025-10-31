Return-Path: <linux-kernel+bounces-880125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3D4C24EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C7D426E36
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D87734B18C;
	Fri, 31 Oct 2025 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FEd7prre";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LG8c45lq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FB034A3AD
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912468; cv=none; b=RG0biez/kYexgJHRHs2bNh0khTWDiR3Ul9hNrMtXnzJ9k8e+oIZ/VV0IlkBUyEyf5CP/JYh6a4+hmNfMgnMXQ7+8Ls02oGC9Sw2fBxPm+O82gbBUhz3JYXH9RYuzYjSdD2kBF4FKFJuuAtUrREx8/n1o05qU5m+kDrgyabWyvIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912468; c=relaxed/simple;
	bh=6qhZ2V7jPWMlO09vJWcPidbXDMoiF5TkOHsCoJUNPBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcV8f492irtZHlR0aO09++TO1n19fcfhwEgSPe7H9VCWL4GIQ/uZ6AurzturWNaADE08rxDMjPen63QwQoyQgZaku2Fd+9nSRy//FmKZFnneWJ+OMDfPSTgBZAoLMet294demAJ00MapdyduORmzTHj9daKyZ9Y5uLAw19aR3Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FEd7prre; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LG8c45lq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V3IZBd102826
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=j3qsn+XRU24
	M9cd/quCxFZxsbCcNEdloWtUmT5MmDVU=; b=FEd7prrestWyoKETHQBoerJc837
	SIWTZf41NK7n0JLuilnqqyhde9T2dgRnxQN11rk/GHucwnAvWxXkokIy2T9FlX//
	ttevhlR0MyBS5px6ojw8Gz7l+S/Gee/aNpep9DqDuFZFyCIHF630x1Y4sjnOFgjL
	vtsXq+Pe1wHgBr9CB+pMgtrvA3pwxgjP0Vh7IDfofmP6L5pct2XyT2d/SqPlJQHf
	CZdT3bvnyQXpdsPx8xgQ5U1FNHGaY/JCN7s+arDl7Ay28bRlvmr9GlJ7A1vBdeyS
	PDipplnPvKIFlCWCERinjqq1z/I1vHJYE9VJAS7YNMuGMUdU3oZpFMFd50g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ahdk2xw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:07:46 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8916e8d4aso97224031cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761912465; x=1762517265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3qsn+XRU24M9cd/quCxFZxsbCcNEdloWtUmT5MmDVU=;
        b=LG8c45lqnz8qX0p52rX703EjrBUqIFhlcn0IiU/kxbPO6lvL+bRkzHQx2QG08r5yfj
         rDglBx158GTpCjPStHwJ8wo740iZtI2PW1I7K+1fkfHYT2xLw7fl1Gpzz7dHHWGxBo5Y
         siMovyKowc7jjy6X8PHrVm30RfqI7YlBZpNziTyoelh07Y4GTjg+rMwes8mKv1ORVB8B
         npYQLLU35fV8uuzumOkiZOg3nVn9mD8J6s2o0Mil77qSNZ+Sz1EshJAVBgffZVTI+SZb
         X7VmLOjdg7BuU58BrpMzWFK6r14HLprj9qfqAu3gVdD2gIpkETYrHxl4ziDqyKJfIc42
         40aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761912465; x=1762517265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3qsn+XRU24M9cd/quCxFZxsbCcNEdloWtUmT5MmDVU=;
        b=izNU45BqIehUbKZDGony4h6g9Nx9x4dmVLuyK1yhOJH5mrOV+Zki+cA6Cpw0u60Uun
         rvpIbGRRvIBGx7WZ8eDE7DQQgh/OJRNouoHcEY0TZSm5luogyQjgskQE8pLCWGtGTr7i
         3S6IkvAiGnywKg7Hip86Q5P4dXUnSGDI47voVWco3tQrwrNKwAuRQs46b1wwFgIqVbKg
         WnnidCOyO4J1401rEQ2EJXAHQ5waD4GZqc0A0gMLqnAzoQKDlKbu3LeVnoeBCGeL1yeQ
         1I7bUa1UuwaYsxxEn5b/1Lp4Aatym2ywvICgKTQ6kvm5mROtT3IHoUNf2XID/X8x0WyM
         cy/g==
X-Forwarded-Encrypted: i=1; AJvYcCWXdWvr5zwoMpw4xUpmzbhFI96zL7YY/hrFv4/yR/b4HtgPq5TqVhxw0WQfXPJJUlUshheqh8eBoYltyaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/2awJ7bdaC3ohjW9s2a1AnPZNVFL9Ed5oLdgEDeZxIN9BO/+X
	Eno4hrHXumgqFD0LncwF85PeDsGbRTFVvSho9iPEnkO3YYVaddPXUG+2OoQLT7bT58m3xh0OUHe
	RkyvpL2zRBYCu07pF1AFcMg7D7BNTRmwHzOsXJE2R6JqnqmncQw6S4jzILFfnJmfYOnY=
X-Gm-Gg: ASbGncuGhNHtM0PxJDfgT98/Yyeivh6Q1elBU5/Xga/0Q9UjhNbic1atCnpN48sZLWV
	cr0Vzj3jibIeidrdMOMTMbtxi3xdTl3tfLiE8Op72BuQ4AyQOAFTuuimC+wmZUuwhomTKolTPjg
	kRCqXx7A513jy3trrvShsOURFO4A9HJ7RYVUvO3O17IlJcoiyDC0GaoO2ETvy+jjW9tjjfObh9+
	gmvC9PMEjShAIt63q9QKvnua3ilqVmwQBjqguD4qbcgHK7hgRY/THDIpPOhbLocwDCno5dDhp77
	aXpDPGD5OUY2hh+rvHO9YQ+aeURlpLzfwkqeDxbL2qYvFZT102jjv/Qh9O7R4sXmRoZUhDoiSH/
	xAWjnSLS0D6nH
X-Received: by 2002:a05:622a:180b:b0:4e7:216e:1fcd with SMTP id d75a77b69052e-4ed30fb9efbmr34589881cf.54.1761912465233;
        Fri, 31 Oct 2025 05:07:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJClcu9eyN2QYo/qOUiQu7qbIyULvLlv12XdHaf3aRKwPnIwV9Hf8bBaGrhHr/S2hRkb5EXg==
X-Received: by 2002:a05:622a:180b:b0:4e7:216e:1fcd with SMTP id d75a77b69052e-4ed30fb9efbmr34589321cf.54.1761912464767;
        Fri, 31 Oct 2025 05:07:44 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fd280fbsm21273995e9.5.2025.10.31.05.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:07:44 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        konradybcio@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v3 6/6] ASoC: codecs: lpass-rx-macro: add SM6115 compatible
Date: Fri, 31 Oct 2025 12:07:03 +0000
Message-ID: <20251031120703.590201-7-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031120703.590201-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251031120703.590201-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwOCBTYWx0ZWRfX5SZ9yIIjNs0e
 fYeMK83R7eLe14FyXYE5/PDXxs4NY680hsOGsW+KmEDWzWoXVyg4m2ULgypZY7mFsDVcRZfJ04N
 vYdkSVZwml98C+5X5/+I0l6viGgIzxtidp+OrdEclwDvq6bielVktVau/LXdScc9Zq0v0aom3gl
 3q3NA31wui+4p7KqGS1V7Ns2CgX+fJc41qpSzOcBsBZBawpjw1bb3IJQOSlgiuIv7eQZLvRaYPO
 MuS7NX/0DCqhmzwAo9USIVtqDebi3UrYLhvX8xoNbyOlO41aPcynBV1jhrzhZc7Zknn2b9Vg96z
 aN25o8DBPPdzFk6jR3tQkxe/8pCqSuQqJjT7sCxqvulPo04ptKhyxJcEhZRPOXJS1+UHFGR7UOb
 HRmdCmXYoQu2jOx4GRlXFz6tow9GsA==
X-Proofpoint-GUID: ewZFdPMIKGHXoceCRT-kZ5nGTHxf2AZe
X-Authority-Analysis: v=2.4 cv=TsnrRTXh c=1 sm=1 tr=0 ts=6904a692 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=MaTAXlxkpdZwQv4a-28A:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: ewZFdPMIKGHXoceCRT-kZ5nGTHxf2AZe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510310108

SM6115 does not have "macro" clock, so its bindings differ with existing
SoC support in rx-macro. So add dedicated compatible in both driver and
dt-bindings to be able to address that difference.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/lpass-rx-macro.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 9053c93bd44c..f889fd17f166 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3951,6 +3951,9 @@ static const struct of_device_id rx_macro_dt_match[] = {
 		.compatible = "qcom,sc7280-lpass-rx-macro",
 		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
 
+	}, {
+		.compatible = "qcom,sm6115-lpass-rx-macro",
+		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
 	}, {
 		.compatible = "qcom,sm8250-lpass-rx-macro",
 		.data = (void *)LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
-- 
2.51.0


