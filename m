Return-Path: <linux-kernel+bounces-866585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E96EC00294
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2E48359199
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2992FCBE3;
	Thu, 23 Oct 2025 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DACa/Lxq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1272FB630
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210886; cv=none; b=qUF4I7ihVENzfPGlUr9Jc2dOnIrx+tVJ/LhSaP+HKq8Gx/lBqPM2sb/0NojqXoLAQnbCJQmkPAlavGTIuIpmXbEcdJoAw9ik301Vli35CfJZf/DUirLiHmpyTSIIaOwpSBh90y6O7Ys+mOAU6K3Aen6OzXmsgNHP5A6NhWXo6UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210886; c=relaxed/simple;
	bh=bZnoqdyFY3pu65TwtNZzfCsh30CpB8ikyYZgkjinaCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GWIU3VzLh7Yme2jB7nQm7QFDby7n6n0X/ghHqQFRFs19VJ1jfZ/HL6B43A9w4tE3nOXNH6EEdV6CjPWAXVsb0xMnEWpSqoH5Pgex5s3zfRXPT6FhDUB5tkHf+MS2V1+ygrkSF85hkeHgD7Iz++ibZ02MebOw0qghWvs9k5Kfvnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DACa/Lxq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6qMxI029135
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LipVLE24QMA8YmFHCyk8Jk9meuXazMzb1E+JswV0knE=; b=DACa/LxqwO1AqH/t
	QSNav0XT4TSeye+cCNML5mkfwoQsEle+YVt3y4SOmzqDmlg3NjcjEfeXPnpia4Eg
	VFkaUKQ9hdGRv3gLol2LTGCCMg2GnxVhqlZpJaT9KmnNrIBG2ghw5rhdx0jncWNm
	WKp/FooBw7Skiz7KahL5Fn/FtkEZfynNojn3mOXU8vC9K7jpBlZvpTeGPtOmTNvS
	WxYBeQoaEXvu2nOSHDelT8OX4i8yyiQ7r8Iu+scFMdlBTrY5LOjuC3sSbVZQodfY
	ez+4XlP2e8cEoB8GR1h0/lCbeYciAgrUZKaSlnc7gLCYPN29PjBjpulUnJ6aKupv
	SeDfnQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08wdeuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:14:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33826e101ecso2234192a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761210883; x=1761815683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LipVLE24QMA8YmFHCyk8Jk9meuXazMzb1E+JswV0knE=;
        b=GME0mWyZxybuVMHmXqfS6S+Mbk/UWj53Ou2ldVmj+tXYzsibnHt/LRy2vmsRmIcdD9
         CKC1URn3DgkJ6fIoM9ucCovS+ZNKAZLCQJjq4amA2SHEPB03QCY6L+48Eq3MqvyAn7xZ
         misd55zM1+PzSdbjaVLzFc5bT0HBQWaRTnajEXKBg0HWo4crD660gl7xiYiizV1i6lJg
         67yFFkfmhrAhxtXshM+fi0F7FFtU588iB1m8UseQobPzXkXdfowZ3NB+IX8lF3zh1MzO
         lZgJBfUyp65UHoi6zbsWASAo4R8vB1eRxQ5FDKB6932Wi7A60pETgKJjyPILnSx95cVI
         /EHw==
X-Forwarded-Encrypted: i=1; AJvYcCX+0Qgyt795U5JZatcQMr0jPIi/MWs0tmGdCEB7a9Ed+XoEzWg+5Vb3CcAyGedo/pFF/uJVk7AlzIqldjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQUioKwRSm68l21pVJAhJskXTFsDZcV26PFRvTHWxo0hwPiDlL
	myo66QthqeeXaWxN90CyhaJZVs2+qvnHL1dsN7+vKBVg2RmGY9chN5LB5wTC5GqCc7A8/86Asdp
	rUzubjvcBS1q4/BtFfSAEmjymoNbFWHEEYRNJYws/N9rHVdd5jZxw+ATlyH4htcDKBms=
X-Gm-Gg: ASbGnctJEXThadtRc06fOg4AiuylVijqiqKjnTxDVY1UmrideUgm0V2/bvyIkzR141y
	qNFszdfDpzwPUDReM99eTJ58z1UojKLwk2U8UKiXr8QrfltDMC0nk1V8ZFsGI5E4NLrRBsM3saK
	wrfMqcUuSwUDzzNe3fhw0fi8AMyaa5Hu5qy8HjkPKpuqGXZsbHqLVvTNfP+bPyxyTYLubB27hFQ
	tMy9SCvDyySXRKAnYDlzKhS6jKTtSAJfvYJDnDBxGTfZLFU+XwpDWcfNvfMo8XznL6yT3kI7RbL
	IYwfp3NEY380HMsy226sxjzZ+/2+jLrgKkh0MZemXk9V0+wuz3SMk99RwrMOqc3O9Q6dwacYHQi
	LELDRGwuksMcoiCXjKOLP/Qbor7MeT58DtVvVyZRIenV+SWkCR7rVZA==
X-Received: by 2002:a17:90b:17c6:b0:335:2d25:7a7a with SMTP id 98e67ed59e1d1-33e911e59d1mr5778285a91.10.1761210882784;
        Thu, 23 Oct 2025 02:14:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQeKi3ZL9DiqlL7KKJDUNZULNgbje2o0tA0G5GvOl1jWpfNwjwyRN6avI0kYnUb1hUXIrAXw==
X-Received: by 2002:a17:90b:17c6:b0:335:2d25:7a7a with SMTP id 98e67ed59e1d1-33e911e59d1mr5778238a91.10.1761210882354;
        Thu, 23 Oct 2025 02:14:42 -0700 (PDT)
Received: from hu-hangxian-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4e318a2sm1490081a12.33.2025.10.23.02.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 02:14:41 -0700 (PDT)
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 02:14:33 -0700
Subject: [PATCH v3 1/6] dt-bindings: i2c: qcom-cci: Document Kaanapali
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-add-support-for-camss-on-kaanapali-v3-1-02abc9a107bf@oss.qualcomm.com>
References: <20251023-add-support-for-camss-on-kaanapali-v3-0-02abc9a107bf@oss.qualcomm.com>
In-Reply-To: <20251023-add-support-for-camss-on-kaanapali-v3-0-02abc9a107bf@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 6KeiJXdOsfj7KBA07phCPVOcetyUVWGT
X-Proofpoint-GUID: 6KeiJXdOsfj7KBA07phCPVOcetyUVWGT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX4j+AFQqXmAlJ
 /TR9Cpp42LmiyE3mpjT8TFgybwKiuTZ1OKNpBjb0c1z+8zDiFGO5cBx2wpZldmYRzKPwWcJrwbg
 JZLG/yXhgMHC8kyaE0OMEGOw0eHjz+Rt3wXbl5ziT22xc6ArW2t6toGMljb56G+26kMbtffrqKx
 IwuldKKI701cdKKTCZikL1ddtyGOeKfsBRh3xbEISD858p5f4cRvW/ScTWuW36xBIIkWuLjr2T9
 88nxSTKCtzUxGsmeko8l3PLqBkd6utCBJILRGYkTe6BYZfxY7aR7LnyVkIuMoXKcF1avtSJddpE
 dCE8bD6H0qMo3r2oxauj5RmJ7m3pQxDWnJxX8pcX4kl/0lL1ypO8QYwSOSLbbanU9rvSJYgF7Rr
 LvddJeAvWy/2PNwo4fK5Hn9B9rtIIA==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f9f203 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=j9zjN4cs5acD8dv8RPMA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

Add Kaanapali compatible consistent with CAMSS CCI interfaces.

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index 9bc99d736343..9b83ec63e124 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
@@ -25,6 +25,7 @@ properties:
 
       - items:
           - enum:
+              - qcom,kaanapali-cci
               - qcom,qcm2290-cci
               - qcom,sa8775p-cci
               - qcom,sc7280-cci
@@ -128,6 +129,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,kaanapali-cci
               - qcom,qcm2290-cci
     then:
       properties:

-- 
2.34.1


