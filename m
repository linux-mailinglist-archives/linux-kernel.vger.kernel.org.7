Return-Path: <linux-kernel+bounces-810078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F89B51594
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A983B1171
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7843054CB;
	Wed, 10 Sep 2025 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AhMdYRrB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8344303A1A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503580; cv=none; b=E1uZol/LzDDIFrppYj3Cdc65gFPg9jJqkaWT2qcABJlleSOTHSqlctHGkSiRoMc6msqzRYz99IqMi0LqPpbc36QM0JkpWBsPmbVKxgR9GyKxmbIm4r6hjqYxGxzAUmN4WCSJ9AgopPnOEM+d7WQ9v+M26ndyZ5/0+ouDFczgfP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503580; c=relaxed/simple;
	bh=PL01mJ0RQboPDnIbyuTFQL2+JjE45/PjCXjxeBASbKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dCwWyGLlZscdxv2owC7UT7sX9BCPHiy25HEmvHXCO7KpoGlXDIdr41a69igb6WDt6ox0Pg0TxrqHxpWCnJNtE9MhNNslGEUh7e/Q+0ofGnRL2qQjxYZT+B6OK6TTVW0ju2tdrh1weiufWOTxQMy+48C0FtLw5uFyDlMi3j0mRzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AhMdYRrB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AAFE6T031273
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8xCz4z0Bi/57zqJUn/Mu/aLwfF4knJr/ZgFBZ7thB9k=; b=AhMdYRrBoiwiY/1V
	xEChmpMDD1v90QbkJStq44JDSMtwAiIA8errZSW444pOjGSTp0lDVRqIkqamX+bB
	h2Rfolu5xm5Wk1E/5WAGlQ/VJzODA+7N6oXEb0OazwdyXgkJcmqOrBmr2EQzJw8K
	fMb01O+kLFpyePaRS6JFxPiVZ1rHWia8be550csJqrGqC9S+DUc6+PQz0PoYCOfL
	L+L2cUtWUuso3UfRfYUk1itKgJe8LfReBn3ak0aSvSRrdvIl+CMn64gY2sprwcx2
	aGfNPxwDPr3r7y0sxKWQOUOeeoJNW/hU1xi6LceifgOWbbbu1zFLNziy25vqZ5Xu
	AzgqJw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t3803jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:26:18 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-772248bb841so11366173b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 04:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757503577; x=1758108377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xCz4z0Bi/57zqJUn/Mu/aLwfF4knJr/ZgFBZ7thB9k=;
        b=c/bqTFzAfiF0eHvp9I5K6TcM/k4zq6SPuQSKLVmm/gl/aPwo7soKDLxPkAQ1OXuX8b
         jTuuF76JoDzAoUJjMlA+6ymPx/WY5i4cnyOGhbarCMBzcXrYYA0qBL1omYnGPa8FCFWq
         1MHe0togM9nL1feZpYwF0giF/V+x161d2EHHgRUy+VXT90aEilmyYK+jOJrAbUVvHxPd
         a27N5PC2XC97I0GROXsdG1vxTntmtOLrku9SBNu7AXSHdM/+JxcXGMvf67vYbLU45kZW
         5m5eIciAjg35kTZ9VXOlWBx6URQ0A7mLbkI0WiPELzStOrKRI7nckOwVsG8oyzT4KPNT
         5dnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGQpPfNAnQoJyWCHe6RctB8FuT+aQoLBpJbHlxomeADoMJ7tlKrUNEKw2rSpPpVh0BiEsbJGoTTWluooI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS9bhf3c2vfHpuabmf4o0lXSz68+MzOcDWJ6vpdqA0A1K01ybn
	cV7xY1fFculQB9s03aar2hIWTDh9EH5rZYtiZiBTdmNVhFBe+/3vHx8Hq0sv0faApt0WFlxHLXA
	kv0KT6D2OGkv2cE5X5y8MuPidVPmK1MBcOrBt8Zv7Bbe3gHjiresIqG+eo9/n0EEvI5U=
X-Gm-Gg: ASbGncu67wMKM3RaBR0rh2/a+Z8pp0AGKkOVrESQvE10lHGrEmTtfgqqNrB18Wz3aQX
	oMFDVdUq2kPbKVaNj9j65gA91IHoYfPAgNhaYE+m0g3XHpmaBqcBRd80MXfz5sV9D1+vaNDSCco
	i3xrlBSpMwIhmbn5Bgp98/W97rS4gun/igND15g0A2U/tqJvL7VhwtRZiSzcOf1q1mz0iXk4lGm
	1Y784JCMLmWRccwlmztKM8L06VRDre4J9wGdd5mKQAdYQxFW/5yxAmbsalfiRYVGTM+h6MgO5Es
	THoANI4ceR7YcTXZ4nZRc1PywvhEGHw/5igZydsZqLYUbR/JiNu7ULkwyVbnGOjg
X-Received: by 2002:a05:6a00:4b01:b0:770:4b1c:8155 with SMTP id d2e1a72fcca58-7742df2f3bamr20536929b3a.31.1757503577238;
        Wed, 10 Sep 2025 04:26:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+QDB9UfSTw2dpK6r9PESzhtTxePgwetKm4/3FAkoGJBYT+EgDiwgz5uRPw9lAa0ANlB5rGQ==
X-Received: by 2002:a05:6a00:4b01:b0:770:4b1c:8155 with SMTP id d2e1a72fcca58-7742df2f3bamr20536906b3a.31.1757503576750;
        Wed, 10 Sep 2025 04:26:16 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662c7384sm4862260b3a.76.2025.09.10.04.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:26:16 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 16:55:22 +0530
Subject: [PATCH v6 2/6] dt-bindings: nvmem: qfprom: Add sa8775p compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-a663-gpu-support-v6-2-5da15827b249@oss.qualcomm.com>
References: <20250910-a663-gpu-support-v6-0-5da15827b249@oss.qualcomm.com>
In-Reply-To: <20250910-a663-gpu-support-v6-0-5da15827b249@oss.qualcomm.com>
To: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757503556; l=928;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=PL01mJ0RQboPDnIbyuTFQL2+JjE45/PjCXjxeBASbKU=;
 b=jbHbZpOfOJnlTpNnSBL+ndOzzQcLInmZVQoFwGPwAfCej3VR+/xoFNWKsr/YC7aCrzP97N+4w
 KVWvC5iBnK9AOH+xqLminNazLWF26SM4yGMZR3CsuW/pcOFkMFDYIvJ
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: ojtUAIKS8wLccVhLZOWaPSvj1wDEa47E
X-Proofpoint-GUID: ojtUAIKS8wLccVhLZOWaPSvj1wDEa47E
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c1605a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=TNpnUgr77EDisZP18eEA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX9XsplDiYrGHi
 hvjOTQdABoFboK6TmpKZ8Qva8ofaQ0tO1uDt9eanOPYMNjW24lgl6m4fPPVej0LKNzNBhnBrrFt
 kZknJ9hwrfWz0Zw762inKYPUQHERW9r+W7YROh8wyMZoiHSFog/84ckjeyrNQd/BjreOzVL7BPt
 xs1svZb0ZqzHhXZmo5yNKfpoWR1p4H+xRggMpgaQr5ifus1/iRwL0BgkHEf4LHQSTd8wTb27ea1
 I/GUdnmPdosvIDy1WVV/1IpegEQ2O3zj6cPynFxpJUyJR8RgNl/yTuI+XvMpfhGAZlQyWt4jgdj
 D4NUfqs84FfDw1m4grgNhJO5V0GbJDErQcf/f3jT3PHUujKpLNFJzckTM6b7Ot/KuXu9YuNk1Kz
 dggmpgPi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_01,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

Document compatible string for the QFPROM on Lemans platform.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 3f6dc6a3a9f1adc582a28cf71414b0e9d08629ed..7d1612acca48d24c3b54c4d25fa8a210176d3bb5 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -39,6 +39,7 @@ properties:
           - qcom,qcs404-qfprom
           - qcom,qcs615-qfprom
           - qcom,qcs8300-qfprom
+          - qcom,sa8775p-qfprom
           - qcom,sar2130p-qfprom
           - qcom,sc7180-qfprom
           - qcom,sc7280-qfprom

-- 
2.50.1


