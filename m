Return-Path: <linux-kernel+bounces-754598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5ECB199EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 03:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CDD3B54A4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 01:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DFA1EE02F;
	Mon,  4 Aug 2025 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dVLKa/+s"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0521F29A1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 01:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754271473; cv=none; b=YM8fBN89uBQ5EjasJzJSOefq3/H9nsMUMWVAth03QaOjcimFS8XytDG11KyTD9Ogd0Kvc4pLOVCz80Ve3L0HnyNujEsHZ+xk1OALaTHpZEqzGx0oY159rkHOChwQBLc66Bh47I/JkaJG8ar+gnss50yKdM65J5Ct0QUGaY/qG28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754271473; c=relaxed/simple;
	bh=dpxW8aShh2RYLX9CjF0k/XEH2duG8LnixEBwdfov9eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ST3q5m6DrfScau1hbWwqi4xXx1Fm8SFN/sL+PmHrO+ZV2HsZ4GlXM3d0fv6316eX5pe7zat+H1mZYBhCvlj/P0TpAwXQXg0brUp2F2uWjHw96346bfLABMVouBFb/vetvNLJCvrd/drdZiaXvreYpct2tm840Xt3deReEyIdlyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dVLKa/+s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573NqItw012304
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 01:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+WbtO0JaeN1fhr4oYLduWJfFLHLQ9helHJAYmSQJKos=; b=dVLKa/+sxCcUjiVS
	CVvL/boLzhjw07U03x8zPGT60OITISJnH2Xt3wyCKMUue23nscPGGNJBQ2NMO6VW
	YUmFaZW8EEWVsqK60z7hI8sxklfyEIwzereJQTKqkL0HW7srw2dhjquwl2ozW/pX
	Xw9ybvOxhxrMDN+F2Ku2a6NrK5Cwa4JmYJpEH/JHPmnUA9QcJch+089WJEMQJdlu
	ml4bhd2VzF7brVc9PCPajb0qQ4sW/UQHk2vgVcwlqjH8sLqmTJ06MIi9fvwL/o/W
	HT9GfXRfj42dgzigxk+etp4/Wfkro6XUoa1XPqQMcqER4gpY9oFjDWRZIDgVh8yD
	XrDRgw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489aw734hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 01:37:51 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76be0be9ee1so2248898b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 18:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754271470; x=1754876270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WbtO0JaeN1fhr4oYLduWJfFLHLQ9helHJAYmSQJKos=;
        b=HiHjV+X2SpwtfokDFSuGzHsnqDJSJ5zp6el6CsxH57mYIw7f/QslH0lFPxGBhMsor3
         wjTBXLvgQ41liT+VWL5C4INHIxrqGUsj7MTnMpkc+5QP2OlFIFMiBRMR/WP1ZmTBlPi7
         wLNZlRr8KhqccZ50iLc9Phy9+KyzyJDfOLciCfjK7Uva6uLdsWxQ5MS0TxDCzsPKByGF
         iXBcoeg8GK2bnvAz1uCsitOZeuv/+Dwoe6xU8pYFljTr5nCB1xIQ+/haXEdIlZ6Fne0n
         97zJ/u5SlXigCrsGd6Dp5KmANUnQLjboVgMGEuQ2u4K8blcjQgOVRAld5BXVLrzlCCH6
         JzwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGGdcPnwLlq4HFV7qJof0JUwmEZs3w7GpuJHa4GQtfpazy2R0xDCfRSiYFT/yNJATLhTf/FvtzdlIAVZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6I1a4PZVTqmUA0Q4pBS/00Eh1PgkN9riyCkiZpCUZ2MvQEFPw
	i0Hk0IhDycTzP3iZTAb2Sbg2KGbSIomspXuKMGV/WkgKilNBBWCZJ/JuHhOupPYRBTy0r1/xXaD
	2za0LDXke0Swu+fTOZqhMHMro15+nLNPam90D4giJmW0AHvGDa67TGw82UyTZgai5DjtepUb8VB
	zZtg==
X-Gm-Gg: ASbGncuVibN6kn4NJlyr+V5MWINW8NVDxwReZhK+Q9zcuaywWLDjEzJ20FWAUWMB0QP
	XG9ndEg72+Yhf+l1StHUb07iTLHXuSP313a3NOWe421ozN5hkCrdHMZWjD2CkxNHDlnqlJPvfsf
	ujNtdCWkh5D60cV6tAf+PjVCys+eeANG4gdLZ3fNNAhZplqv1sq9S3OfPMuf+reuxUHvxsuHsa5
	+PkhUxrbyYeD6BTb1X/PZCVSaSwh7kr+MkFq09MIGHCYt75WLarOK+r4J0jHOpLrUCuCsPxoM35
	iSQuEL2DTq1qlfraMjZN9frZ4tq7gvHflv/w0SxRrpMUVMRPM2ynfXVW9u310H33obJpisiskhM
	zLuma1sGsCkBBt2pl1z60RRjGw+BEQratJA==
X-Received: by 2002:a05:6a00:ae04:b0:76b:ef69:1543 with SMTP id d2e1a72fcca58-76bef691a42mr7909222b3a.8.1754271469844;
        Sun, 03 Aug 2025 18:37:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSsQ0u83UmUTk0WlvigtXYMQpcwrYjWvpZCc8dAhXTLDlgebDRDNNZo6m/tpEwTW8cNaMdHg==
X-Received: by 2002:a05:6a00:ae04:b0:76b:ef69:1543 with SMTP id d2e1a72fcca58-76bef691a42mr7909195b3a.8.1754271469414;
        Sun, 03 Aug 2025 18:37:49 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd8ebbsm9208626b3a.102.2025.08.03.18.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 18:37:49 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Mon, 04 Aug 2025 09:37:05 +0800
Subject: [PATCH v4 2/4] firmware: qcom: scm: Allow QSEECOM on HAMOA-IOT-EVK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-hamoa_initial-v4-2-19edbb28677b@oss.qualcomm.com>
References: <20250804-hamoa_initial-v4-0-19edbb28677b@oss.qualcomm.com>
In-Reply-To: <20250804-hamoa_initial-v4-0-19edbb28677b@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Yijie Yang <yijie.yang@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754271459; l=902;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=dpxW8aShh2RYLX9CjF0k/XEH2duG8LnixEBwdfov9eo=;
 b=CI+Akt149+Xf3uKsOe8u1MUuyM7QbzrRCMaqkcccoVB+jeJ1orNwNIl/wPv8tYScRVw73lf84
 zCvOf/wj1i2BNEBYgc7zq+Nwxbe+mYMJk0fqJ0v1t1QVB8tiYfWaa6j
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-GUID: 3yNjUpQnbUoulkfQlk52cNDFGWdH_BXo
X-Proofpoint-ORIG-GUID: 3yNjUpQnbUoulkfQlk52cNDFGWdH_BXo
X-Authority-Analysis: v=2.4 cv=MrZS63ae c=1 sm=1 tr=0 ts=68900eef cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=h7II6S6JRGbW-U2bcKQA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAwNyBTYWx0ZWRfX0WKspMZhrdvs
 FLeUgdEpdTstQ/8+0DImPqg6bRFvU8lXcXi41/hKjvxyFbubyZ8linCtvRGyaRuhX26R9FhfeEm
 84NxweXS9CESkogCNRsCCZbvT0ew3/P359DadWKsaERpH9Wueaskr0jnVCgjHN2R9rSxeEnhLhL
 HCqXMW0JrrfRXyhvTB83EQuw/59oc/yvsD++ca12o+NDmFXGFWy7Z4pC4g78RC4kwYrtdlihepY
 o6Ki9FMM/7NYY0WUip7dlVtCdy1xEYaHdSDnbwc9tBwMv59BmOVAl4ZfEm4IMH8GplmY/ZE5MN0
 3vZZfNp8ue8lbt2c4jNRFrXkYj9OUlSjWbEhBkBKMKnkIc2k93fYWQE+ZA7GZz9AvFSwx0LrrWY
 HnU9k0ezqvs4cHOcFKA2GJ6MtprWdfjBiNEkYAeuahSn13YORXAg4pwdSVQx3OSxFqnozzbK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-03_07,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040007

Add the Hamoa-IoT-EVK board to the list to enable access to EFI variables.

Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 26cd0458aacd67dcd36f065675e969cea97eb465..27c9d4a0912646415efac2df089ddedaf971fcb1 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2006,6 +2006,7 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "microsoft,blackrock" },
 	{ .compatible = "microsoft,romulus13", },
 	{ .compatible = "microsoft,romulus15", },
+	{ .compatible = "qcom,hamoa-iot-evk" },
 	{ .compatible = "qcom,sc8180x-primus" },
 	{ .compatible = "qcom,x1e001de-devkit" },
 	{ .compatible = "qcom,x1e80100-crd" },

-- 
2.34.1


