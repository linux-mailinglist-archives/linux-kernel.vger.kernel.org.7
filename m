Return-Path: <linux-kernel+bounces-806672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AD6B49A3D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951BA3ACE4D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89882D3755;
	Mon,  8 Sep 2025 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lgqyV29G"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABD92BE7AF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757360442; cv=none; b=udKHeJBlNMfT9GqL3fRIJAJlzdAQR04/U9LNtrTQI6YQbNIn4SohSGhVsmDwNnF97TvEPcOyMsGkrnhHSxp7RUa3dOumvOy3cEiiJ4aQVHw91UOeAqBDH4q0+kceRZ3iq9VLJPSO9G5cdeV8vVORxpLWa2oBJqCbGarh6PXcX4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757360442; c=relaxed/simple;
	bh=lvtizlHL6MS7eo9olZSEO8tIpxGFiSCKBoj2b3IlTA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YN6Lu71do7PoNlzoZxVbqaNm31xxTjfErw6LrNFDu4JfUyK0CJwVXMPGk+uqYt0jXVtL0ohOMKuOfnH3PV2A3z5t/l58N5m8wUjaNzSC9dVaPNYqn8HzZMHhibnxWyEQXVWs391wyPqx1v5lNo3NBxkzldMGX279svHheccgSHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lgqyV29G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588HDmfs024097
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 19:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uTuT+xoD9CIqTmF+XCt73ZauYNq2xf3D0o4LX/E4JG4=; b=lgqyV29GjHtaOz98
	j31pX7LQOhqqQdK99hk8E+D3dUQ17/bU4U7DBBkykSmXIw0G717diPeebyFLTNUJ
	2Ees1UDXmGjwxpOJtGAWiznZmo0tel3Q7IJtSm8sGVi8eIfVet+rCH4o0bIgMlTo
	QqJaRYlL9vXSAdpRRCUIC1a/HE2e6QOze40i+lLfuxpMf3haMnRxKf2iPLf+fo5A
	kCy+DaMGf1HG+U+ZbGm3XAgcqxsflSH3XzRX5+yrpgw8gQjBvwgvdAInzq88wsp+
	4D17U+CPc6f4K0FGktx3sdGIveuEvn+KrRFSz5cD4RInW1udeKZdWbmyKRbeDaip
	uQbwXA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8a5nuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 19:40:40 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b47174bdce2so3747457a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 12:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757360440; x=1757965240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTuT+xoD9CIqTmF+XCt73ZauYNq2xf3D0o4LX/E4JG4=;
        b=S3zVUs9lNtleAb7iUqJo2Yw09gEL2cEvh/GoZHdHQyGgZVFaF0Bw7XswMeSw85A/8Q
         /c6KVeIBm2WPPcoyuD3izVP1z0t8+DnRNDSYrrU07K9EhGo6vixyjYrtZV4ZwekHUeVA
         KCXtXlWGSx8Z2joWkwddhyRMdSXJzVQqrBQCYcAQ5Wii3cn4jlOHjkdHZtmyaouQMPxh
         eB9rnGaOs6nj0Fa8aEGkNVyShVAOFqTa6/qymLWg3lvODMU01S0GK0TMjThEPVbH88J+
         7MH/s28f45mzbVfMzTYBeKhPedzrnRvBpvit9RFa6oQf1TT4tDNo8qLhl9WoEN5XSBsD
         HCqg==
X-Forwarded-Encrypted: i=1; AJvYcCXvqDRnQhPgXuvSkwrZKowBJRQ0OByA8wdRPHJwcE7BY/gn8WU0cPVR4XTJX3cb99LEdbXGABsEVVJNanA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyevs5GVjfKOu4hYkJg2+kuqrfxWpW9birSuwtNYpf8/8qpkgA
	Se7v34I1tNVi4jH5el72439LfwTb6B+VHX6OfNKk9lv8UMDsdPsxZkVcib95nsDRhu5r84VxM9p
	x89JxFri3MRkL/hAY20oPyw70n+gyrSfRLGSqBsUpUUYFH5+jtMDAo+tSslXAk8jKOApmcTyh42
	Y=
X-Gm-Gg: ASbGncsg4FNQD9zdalpbKFmGbGqSeO8+AYk8pM/QQom6pEY7Km9SwJwF1RIpTByU5D4
	C++fQHrMUN1Q8NwVC890/zPVJHI1tgcJ72cAOVZHVnuI24g2CjOgfPUysOcEuXs69Lcu0+7aeaE
	lvNeoeM1j4LrqyGyPqYXCYm//yFoR3AWndzDDXD3xugeeyh3FdtwI2g2MliFCLN+x5uz7F9PSKY
	9oMLlLOfGziBC7K83sgw1jFWWXrYRRiSR0oJxZhSIwo5hbJjjA28TyNG+ocgTCBiAftdtBn+Ffc
	Ca6FZJFQNOXv7F1fM+5Ay0g+/TxA8e2u9Xc5XFkbGyXyzXMgJBC6JBt44RsUaJ0p
X-Received: by 2002:a17:903:2ac5:b0:24e:3cf2:2450 with SMTP id d9443c01a7336-2516c895cc2mr111481615ad.2.1757360439754;
        Mon, 08 Sep 2025 12:40:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7MS/PGj46/9DijhTLrv8zPpQ7yn0ZAGwHCLanL16Jyq5ouQQYBZXugxHzfIk1x6pg9d969w==
X-Received: by 2002:a17:903:2ac5:b0:24e:3cf2:2450 with SMTP id d9443c01a7336-2516c895cc2mr111481185ad.2.1757360439166;
        Mon, 08 Sep 2025 12:40:39 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ced7ea5e8sm104008475ad.104.2025.09.08.12.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 12:40:38 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 01:09:40 +0530
Subject: [PATCH v5 5/6] arm64: dts: qcom: lemans-evk: Enable Adreno 663 GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-a663-gpu-support-v5-5-761fa0a876bf@oss.qualcomm.com>
References: <20250909-a663-gpu-support-v5-0-761fa0a876bf@oss.qualcomm.com>
In-Reply-To: <20250909-a663-gpu-support-v5-0-761fa0a876bf@oss.qualcomm.com>
To: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757360399; l=802;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=lvtizlHL6MS7eo9olZSEO8tIpxGFiSCKBoj2b3IlTA0=;
 b=z27gs7lVGN1/JHmpToK7GI94Hpg3Rn7lWyfFRiOlLXXusxcWd+QIBI1E1Jw96DmemJ6yUs8id
 ewGQDr/ctEYBnUuG7WfVeLnHEXtf5X+Ajb+uW1zDO4nwuX68ThPjkkS
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68bf3138 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: I7RhIrGIL_9JwdyeXvLvSPr0Dwk6rqiE
X-Proofpoint-ORIG-GUID: I7RhIrGIL_9JwdyeXvLvSPr0Dwk6rqiE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX/Mt2940W6VMi
 Pd50ee0bHeKqxrRDvEikxkrSnKuDKaNSJRrXGuTCniWeGo8Z6jPrwaoLVeIQ2/U683XbGUP4ikv
 F07Vn7X6nS8J5URIy7u2ylhNGicV392OK46+f5aaEXqC6cuxuyrsmMpxJ104ISegiHTGwjdEDDW
 lumTpYiuuFFQJRdidplvl0vq6R5t218L0NyuE1JPU7vWo5LU/Gn9MRjQ+/VNRAWnlxI3GllOLCC
 0idh54Xb9/ejfhdZ2CMu+QssugtvYhMUFTj+5utQscrlpxw+VF+rApZJ8bGR4Mx1bxd03P912jf
 ZqYkt3iPvNnNQVuUEP6YYi++U4tdds347w6mr3AxFaDBgkLl8AbjEyfInROIvhKvuzePBfjzgAt
 cfap+IBM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

Enable GPU for lemans-evk platform and provide path for zap
shader.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 669ac52f4cf6aece72141416068268531fd9f79a..876f43d761870b968e43ea1ecc360b4403f19fef 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -253,6 +253,14 @@ vreg_l8e: ldo8 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/sa8775p/a663_zap.mbn";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };

-- 
2.50.1


