Return-Path: <linux-kernel+bounces-798408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16171B41D7C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2D547B4E08
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601FD2FFDD2;
	Wed,  3 Sep 2025 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H8ElKYNQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2842FFDD8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900095; cv=none; b=MTx5K1WxBI/caCbYyUcuWBmfZB67+v/MyTE4uBTESz/aXYQullvyi1By0SBW21BT3mjUzaR7U0J2QKSIluYrns6MOxU2xZ23BYi+m0iVy9H7KklUnSIf3hoXiFCaE7ti1O+Lv2pqP4sh8t0/PvUYjSto2XiODZem886SdAo2n1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900095; c=relaxed/simple;
	bh=d/8KcN+OgREoal5l5Y/MZyinEyOohKBfCQCl2h9LqwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eB8OY76y2MCvAROawp3XIrOsk9UY4yTkPF0QSbQyxL824DhqdclP/FuyOaxs9jdKRAotcDQ+g+NYnwjyaXTo6Erdk2QX6SycktagYNJVakJ1VgHSwNfEtFeFaH+xw8JL1dTzoBRJhHQJ/MnN9kL+VhHrvgclE4iMJaAs3ulrkrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H8ElKYNQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEs72013985
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 11:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BGCKdyi9/G2sO0XrDIQXa/zPVi43JbEno1jV9pbfWBk=; b=H8ElKYNQ4w1OS2SY
	cRjRfLQNXhGZiIT++U+Rj2qGBb9E5/ulQqhy5WBiIY5iWF8F2hmUhcM/rQHVeDe+
	nWssRucKJypAwezIhYKTmmLcFQeo+Jzp56nfQ3f9oEtJxmf/hEms6ceLHyisDpXz
	XhNy4DskGSvOW0IPoYnaHeyKPE57rh60we20aMtvXgOWAqk9dTRWbF3yuGgFMy+S
	heyLA6NhhVQWvCO5lh+/k/8ikAohrif4vmQdw6yg2B13FWQMF5iar7lLMg+6Kszo
	4PmJH1h9C1ENdaBnFtrF4fO/aFRHR63bdEFg3j1Rc7EMAUBRumL0O05t1ngteZnb
	tzWYYA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy7cu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:48:13 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e395107e2so6400212b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900092; x=1757504892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGCKdyi9/G2sO0XrDIQXa/zPVi43JbEno1jV9pbfWBk=;
        b=Sy0/wONXXK/Qu19nEIgO+cnwO2CVDkTHREOLhYP5siJbJfH5hJvTdVRkM6VMPHR51E
         iAByPviSRgiEp/PFMKXFyt7jptRL7KVZKTzdX8RXVYCJ1Coqyk0bn70irCc7b5UiNg3m
         hBFJ3PCCGJGkspJ54LD6KrdUOtXjE0Vj/50Jxb+PTeHUtA8HGeq3+HOACTYtbqgNMBtq
         GZO7fAn6YNa2+cd9Sl9fVM3hjj3/T6Q3pFwTI8LW7yjhvqJkvXkAvyPHWNePCI9qT+78
         NoMQGp7HaN3FqwwIfQFf/zLdcpcVysD5neXqd+PU5xH87v704fzXJcawlNxkLM2IOdL8
         LD7A==
X-Forwarded-Encrypted: i=1; AJvYcCXPoRekxvUX6MIf+WX5Qg797jX34s6UPv+Na4SzP2ypmfgn32kQ0bh6lFHf2iHK3I0FbNaRSvWfwvkwFrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjvL6lVdkj1Vx2kjBcN4XLkfaHLMu2yAtTdPQnl205TqVa8uUL
	KyIQLppdvo9SQGFZz89C1I/nxxXyNT+jVND9ZutRoOG6OO6QAUmkRoLWDUj8xj5d3s4Euo3JMMf
	BPNwMka+8krCkL3P4ovaGXgSTIS2CBnmmbyCvcS+AA+d4tE0mitb6ksDqYRXHirk/ILeBprIO0j
	k=
X-Gm-Gg: ASbGncsBW+LVm+QFg0iGVA/JH8NfWY+Ig6YlP++eUsDgXtld4h3YI7AXfbwSTYzAw6p
	DzK6XNf0zvcIAUlgV/eZhCTn+evjSIhq16PPtWatLOMn/8wf+iPUUuzNZ1XUHKE7einN/u1NeOq
	PJA9ojA7+h8nUdxkqwcOlqH2PLXB89ywI00TdADMcsvtWcOZ/oITs6KqT5krYhxxvnyMQfUza6y
	L9ImKVlG1KQo/wCBD6CtmQDEyYVza3ITSmiL7kpcJKBK6qmXM1AGeL7DdrRenSxWTHsvbxMKSqR
	NxyVAsyLW/WlGTBm8vXoWICZutrSX1aFGfUjMoM9oYMj6wDR1+ven2tEmFJa3QR8AK53
X-Received: by 2002:a05:6a20:3d91:b0:246:9192:2789 with SMTP id adf61e73a8af0-24691922d9dmr3770168637.49.1756900092009;
        Wed, 03 Sep 2025 04:48:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELpa4Dqb/ri4sikbh2/35FUCgGSrLzAq9vhNEPG8ilfsdeKswwyiLmoPL40YnRVxfbYYh9wQ==
X-Received: by 2002:a05:6a20:3d91:b0:246:9192:2789 with SMTP id adf61e73a8af0-24691922d9dmr3770107637.49.1756900091220;
        Wed, 03 Sep 2025 04:48:11 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:48:10 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:09 +0530
Subject: [PATCH v2 08/13] arm64: dts: qcom: lemans-evk: Enable Iris video
 codec support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-8-bfa381bf8ba2@oss.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=865;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=Lwi6TRjPF04O/1B4XCSUMzPV5zfW+xGiP2gdnJ+he1c=;
 b=iKATISuLMw0sB5ZAmFurgIKPxiRrhFzj4GxgOd1LLCa9pPqVxB+oD4RcAcuMndX8Z2sJ5j93b
 Iu5LRYW2UY3CjLniV4Y7XKG505xiJsX6jBly/7LCNpWVf5DXAO362en
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b82afd cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=9guL5b7EFFMc6jyTlUkA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: puVm2IvE3-x3PlAn_npKbpO78626d-ok
X-Proofpoint-ORIG-GUID: puVm2IvE3-x3PlAn_npKbpO78626d-ok
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfXwd575JFznnVo
 5ayYI6IrJLEfJkAATRe62mmVHEH5X/B9K8JYEEAutEYmw6AWGNteNhB2gnsTtAnuhESkxkQtgBp
 JRgLwFHMDRC8Uc0vXdXvjGezruRMPw/zL0A6Ad4VreSvz0VGM0nOf8poROdBClZ/sETyWqYu6wY
 l+JLYuabU5FLnSHdxXO6ez7IcxBdg6UmhrAoRfrl1IGWlhyzd53xFaxN8C0py03Xa9In1kpV9W2
 kVceEOM7BADkqDxm97HkmLzBJfGFimiM31uwbbXAJsx8wczoSWQoB0dBbacfXbTaB229oknDOoX
 kUjUZJF4Ti9MTIh/E7a1SkIn0BoPWSe3zggemb5PwIqnrn+lVANSTBBsYfYscUjXlBHcB8UQ1ck
 NKXMtu3L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

From: Vikash Garodia <quic_vgarodia@quicinc.com>

Enable the Iris video codec accelerator on the Lemans EVK board
and reference the appropriate firmware required for its operation.
This allows hardware-accelerated video encoding and decoding using
the Iris codec engine.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index eb7682fa4057..d85686d55994 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -333,6 +333,12 @@ nvmem-layout {
 	};
 };
 
+&iris {
+	firmware-name = "qcom/vpu/vpu30_p4_s6_16mb.mbn";
+
+	status = "okay";
+};
+
 &mdss0 {
 	status = "okay";
 };

-- 
2.51.0


