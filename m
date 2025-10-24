Return-Path: <linux-kernel+bounces-869082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C9AC06E97
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90FD4043A9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADE5326D46;
	Fri, 24 Oct 2025 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TFZFzzRV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6368432548D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318947; cv=none; b=RPQ8ngasJ9mfiE32oYFZzFOq1v1P/Eqneo0h5I8HuXeovP6JQ/cP9dNyLjin8iuQxnWAeV4Z0m0Ev/+DbrHjD9tJTXN7kq+fGDB5A/8shytRk2ZiBy21cNMYrdkS8H7H000U1MPUztObYuz+kAbRlYXaCNNdOxWMsPlbbxR2t08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318947; c=relaxed/simple;
	bh=2JxH3SAb5I5RjNeUkzq/LydH+ScowPF8cKoijPFvtTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=teEkpEa7MujTWwEfTHu+rjhRAsdDIBchbq0f6wjmRA1bDH4u4w3CfhXmfVfuy30xSSdEw2cPq8ZR7ZQEbkldS6gftbe3mtci3M7AbYqjm6Gih6c+NMhSp5tVSCg+fo0MVOeOmYvsgm/H2b3aZIEl1R12eo+t8XQ9x3O5BSAVCro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TFZFzzRV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OCnOcQ021480
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IuNGrA3HI88
	okECNz5zskMA9+Az9f8glbFMv0KeN/Q8=; b=TFZFzzRVtHTfM9bU9OSmRYGziff
	7bTFra1Th+L93t0E1+xQTj1dnouGRLZZks4wmKBjlLSOqwI17xkJBaLw8fhnblCa
	yOdnEa5jEkyWOr1xOQGJcSkXtqMqr0aPAhtt1rVECKCE4LxLyFpuKHZLjo6x61NM
	Ai/92X3tYK8YKSgeI9LuVEHkIE+8/SRsFGKRLLxamPuHc6PKekreIXHkuZobWfGX
	eXHuh4lFcmanJqsr9JnszFpUaACiFLnyXcl7iuFGwYITxFNw/CbMAOBWzb5JI05W
	q1N783/yeJ4p3GmDPvzSJlUn7134T9+J74RuES1/OVfNQBpIMOfcMhkbUSA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w8cd6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:15:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b63038a6350so2278279a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761318944; x=1761923744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IuNGrA3HI88okECNz5zskMA9+Az9f8glbFMv0KeN/Q8=;
        b=ljVzR3rkzQkD1lCaFNvw06CzJcqXS2xYVCDFTSv/81bfxp8U/Ow50MF9GdBDWdtqOV
         +gGNqUUyhA0ULy9NlRn2z1oqHBFbXmFOSR0T8A0CAyrNNrgx746afXIhQDU4RCln58pl
         o76TpEi1Q6Ex2ZdlOe5ouYPicv7NdFhujTj7gXGTcyc8KpVSyR3mGgJFfAKX6c2jr4pm
         khkg1O/1cmBnax6j1XJTtNQwO7z26lF7SNfDFwZeWJdsxL5AA+Nx0XzZ0B14ze9dRR8N
         UXv3WAK/R5PXliWWPYW2/9+1VMkBn+DoTZVIuCiiOgxvuG+rY0s0LAbY8K2TE6JLCX93
         WZsw==
X-Forwarded-Encrypted: i=1; AJvYcCXEEq3Vt0wmjBtbTdzbh3s8RfXrJlfzsvMEjrJTGZ107H9u5cNdmgQ8f+B6CUFEUlsX3+Ph/tHsqGwau7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj8pdlOF8uBaExVBYOKTqLjlVuQvM0WyR7Kk9lhkl/j1i+RH6E
	ulEoi0+vE6M1eYCEAPu2WrDhqbRU3TaX7cL8OdG/JWnoT6B6AbkA7p7VQcoXYTCe7wl7vdzIY/Q
	jPpU4bp3yNg2WAyOFOIazOuTACqVR2fEPN0rZ+kuNxAdVOKKbQgV3AL4g7IT7JBRTSpk=
X-Gm-Gg: ASbGncuyfaZUv+V8GiV39OEBl/uo7+N8oi1xRrHFa2Pkh+3zo2m3vSh5PURnV1PvKHA
	2DlwY3jNs4I0mOcbg8SejaDZgDkYgLkeuANf6gyIvoIU5nCSZwH/YZHjoCtXrJYEIfmqiJvWzMN
	TpKk2/TYyMyhrRdeWZWnKopkHifWEgUx7IPkR6DJyLcO6n44J3W/kKfPbwrshYAqrfmbfbHc9au
	Sw8PeYxEArNk9sTM8WE89QEbek5VTw5V7voMM0Li7AqBOUqqZMfgEv++b5G8im5mVTeLcY4WWat
	0+JdaJwG9wIbxFAKk1cnpysO6n/iFm7A+axhrKSEXqxRWMEquHFkMvDvCm+QiCLKCHE4PoCbjqU
	wb6aq+WrhWAi6+sMlsyIee84YtxLd7MMkyInN
X-Received: by 2002:a17:902:dacf:b0:269:8eba:e9b2 with SMTP id d9443c01a7336-29489e6c09amr39043565ad.29.1761318943684;
        Fri, 24 Oct 2025 08:15:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS2HlK5lfQnZw/weCGadNiGz6AZhTCUJ88fvYxAvoGDeVcOR3lzXeFAjSFc96bPrGPUiJYxA==
X-Received: by 2002:a17:902:dacf:b0:269:8eba:e9b2 with SMTP id d9443c01a7336-29489e6c09amr39043055ad.29.1761318943099;
        Fri, 24 Oct 2025 08:15:43 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddddc34sm58758885ad.20.2025.10.24.08.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 08:15:42 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v9 3/3] arm64: dts: qcom: sm8750: Add USB support for SM8750 QRD platform
Date: Fri, 24 Oct 2025 20:45:21 +0530
Message-Id: <20251024151521.2365845-4-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024151521.2365845-1-krishna.kurapati@oss.qualcomm.com>
References: <20251024151521.2365845-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX+uErBuj2QnN9
 itP3r2Uc6oUR5nRjlJa5mPctV4WxcE1J8LKe4lelrdIZAXLl9Yx8m6kC6ZdyLmoP8CquLXLJMZp
 scEs8vmf7pIDkjkvFs5Xsuz2lV0L9Uv9VbwRclLFU3vNgGfIcLbH8v8N3AAbzd7BsaelEio5AYs
 ri8iajU4wvFxzIqAboBMxrMeCZGDUxsMaYyziKpj5elpwiePgu/NJv6RqpztQY+Nm/6nXJTNrqt
 dH5MQhUXuDj9a5CQcPnq7aAu8GWQCKdWxs3cwf+2mkvLwHln+gBmLtN6HsRQiZnxJZHf04+G5PH
 zQiovlbvP56njWxypC2Y/qX9/STO1SEcnJFFCiP9AnN5Dd/bU/fsE2teBm04inpjaj2YR7+ia51
 PzG9SO/FkjzgMesFReO09MUlXT6BHw==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68fb9821 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=EoOMd-xwxZjzz6zYUw0A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: ZKWYv4_HxgpJ22NvE71AD5-YRJuzD1--
X-Proofpoint-ORIG-GUID: ZKWYv4_HxgpJ22NvE71AD5-YRJuzD1--
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>

Enable USB support on SM8750 QRD variant.  The current definition
will start the USB controller in peripheral mode by default until
dependencies are added, such as USB role detection.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
[Krishna: Flattened usb node QRD DTS]
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
index 13c7b9664c89..fc5d12bb41a5 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
@@ -1054,3 +1054,25 @@ &ufs_mem_hc {
 
 	status = "okay";
 };
+
+&usb_1 {
+	dr_mode = "peripheral";
+
+	status = "okay";
+};
+
+&usb_1_hsphy {
+	vdd-supply = <&vreg_l2d_0p88>;
+	vdda12-supply = <&vreg_l3g_1p2>;
+
+	phys = <&pmih0108_eusb2_repeater>;
+
+	status = "okay";
+};
+
+&usb_dp_qmpphy {
+	vdda-phy-supply = <&vreg_l3g_1p2>;
+	vdda-pll-supply = <&vreg_l2d_0p88>;
+
+	status = "okay";
+};
-- 
2.34.1


