Return-Path: <linux-kernel+bounces-780485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE14B30283
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8502178878
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A0A34F475;
	Thu, 21 Aug 2025 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mLgRJJrz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989BB3469E0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755802613; cv=none; b=Kvb22KxeYpEHmQblxh55GU0WuBFFuMk+DWGk//KMAAUbQnjrdsKVUEFFuWTKpa0KoUmiJpr247TkEwcqnr7Wsrig85I4/GVcKdaq4DgaswmpKRdZgdIbkC6NKy3Iy0or+nEeOGJRLo2JuusqViBhh72I5wI3W2jIgvSWyHc/lSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755802613; c=relaxed/simple;
	bh=EfCx1AnACdzORFWTq7a/mK0KpOzkdsdN9am6A77xvlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u5RycPNp3l5P2Lt9ofyghqlLRZkbTqg1i2jQUH/Y1rdUV/rDZ5mViXITOJlVWKnbYufa1/pkTpjGWhJy7xPv9pEtx8R5Rqf09nTPentjY6eKJzq9t83HGKmp4GtgQDXZJG136IRF7CFF6/GWzgfd9EM+/IOMRfV2RG9krFYd088=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mLgRJJrz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LI9tnF006096
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L+vnrfh5wkxvST6moGu8zFwo8y31WtRfprWTPNuMSjg=; b=mLgRJJrzeWOzkkBq
	xCdYQeB0PJkwP3l8K9NTongMTO0eSNXFlAhDK+wUFynDp81nQaIRKh7VfQtXOdiE
	xuNxQC9G5nLfpCnYQ5YrcmR8Tnw8E9nrUo2LxtYJH3kR25h+g4omYtf/tpgSpPMm
	3W2mzK6+YR1LZBLUFpCIEYUwfMMsnV73/pN4oRBoVwSh03Ewz28xC6dc9y3vLvDl
	lp3dk6Q/U9HBqsCJXymhGt/iUaVtzVa/xirDK9/vtjMtF7DBADWB99Ta6/53WWOh
	NmwRBcpWwHyBeEl4BBaZ1BQNgfHoI7YDF+DgnMr+dEZcZMQWXo5KUYCgMxluHUSe
	SfZafw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngtdmd6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:56:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4750376ca8so891142a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755802610; x=1756407410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+vnrfh5wkxvST6moGu8zFwo8y31WtRfprWTPNuMSjg=;
        b=kDuPRsf897yyMgo5qoPwApuotddzZc3qFi0Rl98tQOI8dmpft/yZKoIEhLKw42CmSz
         QqQ9YtJguh7X0/e8cnRL0KZt1cNiqwnXTi82nJaoHtiUxI4AHE5GSxdSXyO7WPKQu+QS
         b8LJKRA3PQ4xjN844lFvEAMjC83IWs34LjiXCaZxg4cnz/0NuGKQVe0hw+PaZcSJUrLc
         EsSa2kjI1ht2fBTcOXe0Nl79Z88yGtOTmPxWatZn4yDIjn1xKTeZNxxzGQ+0jm4q3cYI
         R0S4FxaqB70ojCLc7yWOXsVz1vTucCNKN2O+Crb9xtkH/Vrx5AanmYviK4eRDzrjiA3O
         3HUg==
X-Forwarded-Encrypted: i=1; AJvYcCXnB7zOnqHCmkhLVQRWx5C/sUCLv25yS3Z7XW2lZzat3T1Pw/lwQo8vVMJucAO2w7z1Q9AdIpco34//u1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1LGpCVClc9+NOe5VdbKo8YHCTlYYmgIUmu6xdRzV5jtAE0QA3
	KeDv0Mg5UozfZIeOMm9uGibV8Xu9MkTDVcsP/3ra5aBV2oqbmqyNYzQ8YN4CB3jheq4Eav/tG+b
	bez/Gwe7gDp5T9Sv1mdie5wCQlHr00pbffxg04JS2xj4RpFfAogyE8XmGTKf+jKTCeys=
X-Gm-Gg: ASbGncsjkLSrtWH9cn1nTwJCLn97vYg7VqfJIjEZL+wkPUTWVjYgyj1vS7kflTZ1QMT
	eqzqvV8VIJLTfinH+Ee0dvwIzYuT3iw0YguGS1A30iqIJHufqEfOS0Ma4wQa4YaOp9ZAX2SK1Ql
	ie+mXG233js725tdvvgYjs9mDvaybpJREgUjV1bcw11Y/w2r3tlbIeKgqnITK+xLSM+5m7KQvgW
	eKOEyTI8j6FuYBM3JIhSNPHD/VjmE8/frX8OjyiW1U5afJYtl1YRx4doOCmn9HDeHCwrA5i4hH3
	7JFAVpGD2gK/9tJSghwkvuqj+7ELO6u9iAdLgu+XEXgVPXRD7SluIgg5hHnQCxah
X-Received: by 2002:a05:6a20:72a2:b0:220:9e54:d5cc with SMTP id adf61e73a8af0-24340daf836mr290732637.31.1755802610063;
        Thu, 21 Aug 2025 11:56:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbkoS9Oleg0BMcUAm50PQQmuIuPc1U5sybFr6bqhLl0blAssfD7XkEWCeGVPUZNhzXoPJurw==
X-Received: by 2002:a05:6a20:72a2:b0:220:9e54:d5cc with SMTP id adf61e73a8af0-24340daf836mr290691637.31.1755802609615;
        Thu, 21 Aug 2025 11:56:49 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4764090b0esm2106977a12.37.2025.08.21.11.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 11:56:49 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 00:25:31 +0530
Subject: [PATCH v4 6/6] arm64: dts: qcom: qcs9100-ride: Enable Adreno 663
 GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-a663-gpu-support-v4-6-97d26bb2144e@oss.qualcomm.com>
References: <20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com>
In-Reply-To: <20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com>
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
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755802565; l=812;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=EfCx1AnACdzORFWTq7a/mK0KpOzkdsdN9am6A77xvlQ=;
 b=XGnXES9y4qk+wZkRRx2ofUbx6TA5EXdyY08i0sz/1HJLxVoi0TaTp4HQb61vD0riKc2tD5RrK
 1hNS0+25QZAB23PNN4ZH5Revq3TcNgTO+Zc4bv5OXYJfmLzq12ECf0c
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=LexlKjfi c=1 sm=1 tr=0 ts=68a76bf3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=jbU5qkt2-FsioPMlu34A:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: BNNLIxxsvnSk875ZC2A86Se0wtLe5hZP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNSBTYWx0ZWRfX3zD/hSAIPK3I
 sqSelrb/Z3ob8b8S6nJaW8RT5/wXH1TXI5YM9WleuLhKq7r/oFoQzYWfi/pBxbDvC7TSL3CwVhk
 eRIiOg1YiGWTH7P1crK7KO8Jb2Fo5j73jtz1dg649zexySJ7iIT5gGOcq+Q5dlS/Ig7Hl5O9RnO
 eIQ72uS/AtkY221F1GtgHlCC6MGVlcs87L5/8prUR51/IuF+c1jcMbAdPR6dl0xTuhvH4ASxBNt
 nadOj2jExoUPbbI2kC8vOLa3nj2+6VCB3e1ogbUVlTVyrwFUvZpZbYmKswgIZ6y4r04NCL7EVwD
 yoEKLW1DXvhZ4MqsidtkA4eEVwfZmMKXFQmzePNJSU/3xF7y44qVQv/azZ/OPKRj7wxbiZatksP
 bAZVuKaa0UmkPZrENU/OuwpqE9WdXA==
X-Proofpoint-ORIG-GUID: BNNLIxxsvnSk875ZC2A86Se0wtLe5hZP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200135

Enable GPU on both qcs9100-ride platforms and provide the path
for zap shader.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi b/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
index 25e756c141606fbe0876ed48a54809b372650903..e9540cbff78ee44d6d92de10464c660a05a68db9 100644
--- a/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
@@ -436,6 +436,14 @@ vreg_l8e: ldo8 {
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
 &i2c11 {
 	clock-frequency = <400000>;
 	status = "okay";

-- 
2.50.1


