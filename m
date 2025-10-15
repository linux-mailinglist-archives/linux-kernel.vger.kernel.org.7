Return-Path: <linux-kernel+bounces-854318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40171BDE181
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4601927F50
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9AC1E285A;
	Wed, 15 Oct 2025 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jUcA2ciG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797CF31D38C
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525591; cv=none; b=OIVdehzuiZKrGc2S/6ja+Iu75AM0ZwHDu9Dxeaeg1eaY0EnCTUYCd541f7vK4tdro7ivD1Rc3da6MWCbBLhWCgBQM9lcuFZd7OVxCB1DXCHKJ7pCCCZt8trRIHXqudURgY8LmCCIsljSHaqz5+ba10M2zbPKWumpD7Q3AcEkllg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525591; c=relaxed/simple;
	bh=FiZWKtwOY9Jr5BZSeyKiibtBbBMRoJPxKcH+WMAHIwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KJvPk+o8n3NsL+o+vGUbRt+NStXyuFKDnvS97HT28MqW+MK76RiYanfsDtbmmgk/yPJ8lx06p/qq65jW+TbWpaXvsdcmV5PCeKP77oJKHzad+/zd+o6CU2PmcwGedTzBFGYbP9gGjBtir4kZImfZgoum2wEGJa+4zGPIBmtKEqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jUcA2ciG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sAPJ009185
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=mrkw9gI6cWU
	Jhtm17vDeWcRDNXPNLRYq7s1YQ5mZw3I=; b=jUcA2ciGot8kohRGVeJIsTFDwIM
	5oefWSEdpA1jv+ErOtzGc48ubsd9AqWlM1G+CnM/NaE/z3PpKYjOAak49u9VsljX
	wIUOz5qDaJeUO3yo5gP5ZvE1HXtbHkjBWhGZodi6axQEucHcIUzsSZCDcI43prnx
	YNO8HbYaiXaTU5eK4RuEiJwWd0juY+FIuuhpmlsHXQL/ub7pfWWFeEg3ZkT8sEMJ
	YAlT7bJAf15uhQJBio1qMfEMm19KAG1nqY+IXMZqX+iyeXmfCYaihlqRMHgVa9Vq
	C8ue8+8YKvsdEVdwOQsEivsUrItEO9RqEXTnSZuayFCfMn2bLEDeqVnq15w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0c4255-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:53:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-277f0ea6fc6so224480115ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760525587; x=1761130387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrkw9gI6cWUJhtm17vDeWcRDNXPNLRYq7s1YQ5mZw3I=;
        b=E8/kGvuiMzq+gIPF8lyu04QRtDhIEltVXxoZN20uUbRdsNmd62x4hBiGbxVNepn6dh
         NHqYZkz/y65ItfIGN7V6a7hJvrTMhw3jMRxStFfcBOssdKubHBnZ9B1PIHafj2I6bTyi
         zU7Hef2sFXv+BqQGYp7XBCrCxwF9+gO5PKQ24f1XyGsN185fjW/2FM8DF6PovieUDxMj
         W1LtXQB/TMlmuY+RhwebOguiYMGIZCjpSAK9DGidpsBgkOsUiSO5Hoc26k5t4wkSXP+I
         9r0FhZsoozeM3rA9V+e263BczpRf2o45Z2QdsZasopEbfyEZ/u5G0Gt4L3g7FkHPMRyU
         LcQw==
X-Forwarded-Encrypted: i=1; AJvYcCUCesmCB9MLzKUM3bokmrkSQ22julOiiB8nBRB9rb0OvT9ehZ9aw/ifzqk8EK+OqfrcL1CeSaRXEyBRPwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBVnuxdWMelX5j5qBNcZcs918yuxNny+CdFWCHW2idX649IoB+
	YUYrtnc+TxJVNGvsfjAxzLsh0amF9opW5QHPWCPJaTyywlih0eDBhb6aiwl/1SfZTeJ3/old526
	cWcI1IWOeJLWadhlvPqT00Nb7/v/8hjheyhpPgvTwJYoFDm99sLvgMsGk0bpDXdRL+d8=
X-Gm-Gg: ASbGnctWZrkUW7dgLd8DLEjU+1lI8GR4MWyDnxRPKDNx/Pr9aPk6AuBV4DnOZOyZxvf
	QudjiCOEhfqmPHY6/Ziwnz3jFVKObhcgWipa25osuk9Rqo7vyOnTrogBj3tXeceA/1tmAbbGU+n
	djfDNlXiS+p8ZVVVg9c3GeOrhN6qFSYUbUTJU/EjcrsFOSK+FU2GPmBzJMZVuqGB2xRBlUDDEFC
	RDZ7dIWbFfnYUvdh0Wnl3dMlX/lYkXXW6LxUpJuaqZgYH9+kR858F3rP4awrytlFT3MesOIFtze
	5vzgGH4V1VvL3WNM+98lm6KmgTqE+TSbJJPYdXgq1e24s2omLxcUusnsQJFSvT6CGFmSh5Wf36i
	jWg==
X-Received: by 2002:a17:903:910:b0:258:9d26:1860 with SMTP id d9443c01a7336-290273ffeb7mr386954085ad.40.1760525586799;
        Wed, 15 Oct 2025 03:53:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR8xjz/k5XFLLDdMqPKDjnU+itUdO0fqH6mjDSaolwg56TKlZ6p9EGiaz6+5/FZwrM0jZ0zw==
X-Received: by 2002:a17:903:910:b0:258:9d26:1860 with SMTP id d9443c01a7336-290273ffeb7mr386953665ad.40.1760525586281;
        Wed, 15 Oct 2025 03:53:06 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e20f8csm193698385ad.49.2025.10.15.03.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 03:53:05 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
        Eric Biggers <ebiggers@kernel.org>, nfraprado@collabora.com,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wesley Cheng <quic_wcheng@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Melody Olvera <melody.olvera@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v7 3/4] arm64: dts: qcom: sm8750: Add USB support for SM8750 QRD platform
Date: Wed, 15 Oct 2025 16:22:30 +0530
Message-Id: <20251015105231.2819727-4-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015105231.2819727-1-krishna.kurapati@oss.qualcomm.com>
References: <20251015105231.2819727-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: D2A5PH2CWUlN92z8ESB7jTGcadcxuxhH
X-Proofpoint-ORIG-GUID: D2A5PH2CWUlN92z8ESB7jTGcadcxuxhH
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ef7d13 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=EoOMd-xwxZjzz6zYUw0A:9 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX0zWGZcua9BRq
 MPwHJq3HF6D9A9SfhALyxuRBRd2GSHFpntKNfv/cgVh+JYdEGXfbexnPxcqB8TrshHQ0ugRwQxp
 hA27pyyq5y31oMnyg9CdFGgLBIE2elaUh8o6xjAL1IC4cl0FUftrWy7BYfkt0vpDEJYi0sz+6SS
 bkJeKL+2DeWMicT47B56GA1zp+c8FdzWOqS7zdt55KW7qqxSFlviFlyQf3wm1TYbeTJ4ZrLyuLi
 7h3ZhfzvbNrk/VVFujnaqU0HJYTh7ANodNSBvstkK3CNxbLNvOGZ1nwmIUv+WKUaHkmWIsEJo8/
 0I0fAt65AEI4IuLuC0aCXsiWK2YpVQRz1iBK1Zwrs/JnlqSGuCHWGzfdq5F62+6CnU1f8ghQOJo
 GnchgVYqPDTJ4OXBcq+uQJK+lAOj6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

From: Wesley Cheng <quic_wcheng@quicinc.com>

Enable USB support on SM8750 QRD variant.  The current definition
will start the USB controller in peripheral mode by default until
dependencies are added, such as USB role detection.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
Signed-off-by: Melody Olvera <melody.olvera@oss.qualcomm.com>
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
index 13c7b9664c89..1949b28c90d0 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
@@ -1037,6 +1037,30 @@ &uart7 {
 	status = "okay";
 };
 
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "peripheral";
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
+
 &ufs_mem_phy {
 	vdda-phy-supply = <&vreg_l1j_0p91>;
 	vdda-pll-supply = <&vreg_l3g_1p2>;
-- 
2.34.1


