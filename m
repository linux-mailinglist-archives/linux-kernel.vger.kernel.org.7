Return-Path: <linux-kernel+bounces-733187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44424B07148
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4E51AA1966
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69EF2F2C6D;
	Wed, 16 Jul 2025 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IfIhBuBP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DF02F271E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656973; cv=none; b=QYVsVs/K/woQX8Tfsof79QBOEyck16k6r+/OyQo2RKsRmZMhnvbOrnwicSsZE6BzlAbHT4e+WeWn+2uoo3NIzIQNwg6PC9b3jLqybp9Aj6OoFmv6A6O2gIcw57gMPf/0DMCCXRY63EmUA+ll5J9Y+OkwawLHnrQWf8XGglULveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656973; c=relaxed/simple;
	bh=meDbdQ8jfv6MzJ5QqjKeDn98P5b+BWThT05OUsC+Mpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F3742/EpnIeX5rkGBaHQ5oTKCYUFHLPJNQQgH4ar1OJNeBHf4uQG6onnwXHOYX9Ltamym8c4rwhnFyspZp5ie6FjNtwnVpV/OF9AXPnV8WivoGWO0Nb0bGcW72MxTCQckskfSbfl3YkfUpROIh2nmopxtA5/kKltUeWbwIAKgpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IfIhBuBP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G5KgVH022755
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F9sBDUWVBLweXSo5nrw26qvUJlKDueBdo3VuMvvD44M=; b=IfIhBuBPHQ4n+KsV
	gePm3ASakyphVJwcncRLHtz3OgUsaaBmv5uZO6Yqt2ovcfEMl98efwGA4amBnTPC
	xnZJbm6CaJUnLxuXOiCY8aEGa1jb+ouXZXRFikbVlQiZ/Gb0T5L6iiyCBxUvsoTl
	DN9g1m/q7DsDv0r+YKAOEIwtRxm4XaGR2VcqijrOU+qnL/gPJ3Cgk3aNPifzYiDh
	SzCDHr1b15RhsmPZSwP0+U4AIX7GqIx4aKHXSTb6qUI/OqO75LyPj4mrmj9VZ5jh
	7Z5IvSMieyr5wG40OF0HQVPL6cn6UdTwWoLnAQnUu9UM6EaIFEnMRHrEzc+prAQ6
	b8/b9Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wkruky3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:09:25 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74d12fa4619so5435996b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656964; x=1753261764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9sBDUWVBLweXSo5nrw26qvUJlKDueBdo3VuMvvD44M=;
        b=Q5DMexwJ/x0Ly63xxfg843X7Ilv/cQjIur0AD4GZoP/JP8xuobEd5A2AbPin2g1LZX
         CxrALnTKr97rB6/0iNSHg2glzMRdmshPCsgxtRAmR6Y83UmHAEobAfWsvkkd8nY8JqN3
         yMeOUEBoBwr4lHpl6Dtf25tkJkuduHb6dwwC0bhw1gDBFo3ab35WkM3AKDLfqmMz+VK4
         ZbSaWdSBDCuMxLyFsj5b62wr+8JfA9rW5n8kQmtA2lmXPPcZh1L0t5rQ3DelVej4MGGO
         fS1dRLEmyTNvPtbMcy/X0UZ85H+xzw/mjhB7j9EjT694C2Fxbxa5MsudMMOfcaxmBPc4
         0TBg==
X-Forwarded-Encrypted: i=1; AJvYcCX3Wkq1/9pN9/9C/XbcXrXaAhsitecvczbjRiQROSlWWwiz5TzRXTOsN/Fg1n/WQkdX1cSnZbaTm3aTTlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfknRcdIQUOemgOOKE4/x15mbdfni0tYbUvmUxiiqHskI6q7tD
	xp5WpUBs8Oo/BjzYdZO7d7ChUhEzcv+1enlcVPZfsD7dC5TXkHzA3H5yBeiBH8ojx0jsbYhujaA
	1kjzen0Bjxmwz5i8cDBOtg4yxN/Ja8HVevhTYt+MuvkldI4yU5MWhOhbmIrJPuA9cTcY=
X-Gm-Gg: ASbGncvv8fMg0IfiWfPZr06Xs9oCNuqY/VhZLmDPvbnlgObJC5cPB2J5ectplJmml+v
	Ymfg81k7iZqMC2zB5+nx43ZA690cfa6xaiXJKfGAwdIm9B/kbsvs7RKsf4WzqItabBDAzhpGkwr
	1knOcypUnlSA9cHX1ZxKEN+8q6b4ppadvXuMi/3lQdaThaq3rZuFQ0T0B1jSPWyUQWFNnw/I6FP
	dpzdNzCAoUKHc7tKvcchN/QDrzwtN23gnc0i9uSHML84w9o4GafXDe84drIxHO7KxB5MOmeiPA5
	gCSz5CKjRGhfZO7k9zZ0bOICA/b2AkbOCfS/nl6JPHLfdnYqIK+IoXJKn1qs+FMG9pptompudg+
	0XQUPv2Lm8wy+llBz1ambRNQ+4hCAbEu6Tg==
X-Received: by 2002:a05:6a21:3299:b0:222:c8c4:efae with SMTP id adf61e73a8af0-237d702180amr4519943637.27.1752656964306;
        Wed, 16 Jul 2025 02:09:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7t6+L98+hLfQDY+8IWtibwBKpLYwiTzbTLrDEk0AhFbJAbikqrvlc+LNPuZ89eLrBW2tn0A==
X-Received: by 2002:a05:6a21:3299:b0:222:c8c4:efae with SMTP id adf61e73a8af0-237d702180amr4519906637.27.1752656963914;
        Wed, 16 Jul 2025 02:09:23 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd6022sm13926375b3a.8.2025.07.16.02.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:09:23 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 17:08:40 +0800
Subject: [PATCH 2/4] firmware: qcom: scm: Allow QSEECOM on HAMOA-IOT-EVK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-hamoa_initial-v1-2-f6f5d0f9a163@oss.qualcomm.com>
References: <20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com>
In-Reply-To: <20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Yijie Yang <yijie.yang@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752656953; l=902;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=meDbdQ8jfv6MzJ5QqjKeDn98P5b+BWThT05OUsC+Mpo=;
 b=mmItxzJfygAR0embjO+9OO2+VLpXVON1rV/DlAQgefJHWCDXgXIQNH5sEzYDVTkN674lVm2mD
 3GDRARPv0NoAdfsS1/zT8Bc/Ef0asCSdcRTgMorpfRlqAoxwaFKCOQv
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-GUID: ldiVg8Pq3UrkQ7Wdo4j6ZVKpAV8VQH64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA4MSBTYWx0ZWRfX+XqI5Kbwc97g
 acG3QnhgI+BxcdiGGhnxBGJfWSUGLMxiPwe+pyvF83m+ugdF/ZNr02dVClwDLg+K4BQq56b1P0G
 CU9LgJHwg8Q+3Juc7LDhe7AFrwgtrMjl7DcYy9kIiaVRa9jo2gyKnfO17OG+6F7aTC1wY5Agujn
 AQubJp9FmJ51gIeV/+5WmbErC/QCDdrs7i06FJeTpphWXpdOOtG593BT+LhAPAgBZ2XYIu0hg2h
 zFqIPqQ9JrkzyuzdkuhB8p7qogb6ywbn3KYsOY/HNTggzAOsgL2JV/ysYJDTJq2WZOrr5WXepzm
 xD2wkkgkHkLQvCJ/c8ZEwANGj5jgjm65/w4gPaNXe7VKCbyHtqKiMiBAYiPBiZ601l7tyo2hR7W
 jdcKwxI/EPyHSDhrxuG+1Gy7uuqbI02UsAIHbodAIaGMPKAAKm4tUqOSC1D/xcQ1ylZHjwJi
X-Authority-Analysis: v=2.4 cv=WqUrMcfv c=1 sm=1 tr=0 ts=68776c45 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=h7II6S6JRGbW-U2bcKQA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: ldiVg8Pq3UrkQ7Wdo4j6ZVKpAV8VQH64
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160081

Add the Hamoa-IoT-EVK board to the list to enable access to EFI variables.

Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index f63b716be5b027550ae3a987e784f0814ea6d678..0473f563700db72333495dabeec59cc482b717f6 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2000,6 +2000,7 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "microsoft,blackrock" },
 	{ .compatible = "microsoft,romulus13", },
 	{ .compatible = "microsoft,romulus15", },
+	{ .compatible = "qcom,hamoa-iot-evk" },
 	{ .compatible = "qcom,sc8180x-primus" },
 	{ .compatible = "qcom,x1e001de-devkit" },
 	{ .compatible = "qcom,x1e80100-crd" },

-- 
2.34.1


