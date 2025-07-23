Return-Path: <linux-kernel+bounces-742325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F77B0EFF7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91AE67A988F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D7B29A31A;
	Wed, 23 Jul 2025 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KeeFg4o0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F5B291C0C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267026; cv=none; b=hfSuGkk2FUcTLgWnCzinMTp7YLc/usXCo/h4RtrtTz9ki55B0nvEupAYFjbf2oG/9L4DPwwiB39X8E+JTzZLkxWQP2cT5T0Ha+EMcrB6ZBzkjk29f05oCCraumOaa1cGkLopcF/rDlLBm4QTE1YFdBJC9OpKWVQEhIuI//VHmgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267026; c=relaxed/simple;
	bh=SBkpMsGrGahLmvK5mXf7uU4yJc9wzbgowThkMVVAhc0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FIyuTH8XiOt5nrQRndGKznGWBtWq/wVq/TeI/kcjDovVOGYco+VSgS8XL7mhVKoETiA8yy71NKmuwOE9ugyvkTScea0TNN3pyFms7qYLRmN5a/E0NTatE1mYg/4pqTH83gGwYepJEpUv/WuIk0Oy/iHoQG9yvx9hrvNfOdrAVBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KeeFg4o0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9ini2019487
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=BZahhtsdxwSGeWMV/+xeQGiaLIv/GIPmtHC
	4taip/PU=; b=KeeFg4o0Nxj8dwDTIKJBNa68K8fXqATd6h4Cpl9NTbJ7ta2g3Hu
	W01t4A0OF545qB2UQFJOLW9/y0cW1SrLGdvzzKCrSbLYa2CSHF4h7V9zGWr8M3Vl
	DefTN7dS8n4he9FYoKYEq+QaskfegakFPyaIHW3gg4CKsSJ5VRwXBkIKz/guov89
	8QCBdR3PlAq9Rg1HQ2aUPld94YJaXW32MQKwUCQcis83Q80M3xWDhTlKyS3MV+/Z
	jlQgUyiD+XhDCdZUUdmqgelnIw61QZBVJfa+ufiv3HudlqIWAh6mqTYOd4vS+p90
	aG5tv+qTpvWh/TuwTzTaiNfdkSwro2jzl1g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6q0nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:37:03 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74ea7007866so6158116b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753267022; x=1753871822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZahhtsdxwSGeWMV/+xeQGiaLIv/GIPmtHC4taip/PU=;
        b=f74XglXmVacLkYg8kezxtTIKogttnFiOecxd4m5ZbKsR/5Q/+4eiNFLOMTKW3WxSAY
         2UMo6SUFMlQ1z09wDaW9d/BdS2dPs6SPgrOQEIBLeQXHr5Q7HpC0Vg6PTh6Oo9gjQ1U7
         bmpZdJugE0/e9DYoM0ZNrgxzq/+8UqCmzN0OoTdLwe8MhGW2wD8BgTH7dyBktag84oWR
         p+2+vQgvTm0ljf2caSa9XfGUVlZqwRkts4nl2P5HmQsLH1lyRTZ1T7mPrUx+dQ/g5WpR
         UrqIoNWc1j1Vmzjy0XiojAP8Kr8xYPRzxNq8P+6VoD2KmqphPa7+87Q/ZQ7tTOhrXSW9
         Cu4g==
X-Forwarded-Encrypted: i=1; AJvYcCXGI+wwqNuISpqGdmFRsLaVb62zSo2DfzgXzpBnOGHGtxfGY3Kee1MDGBkB9wDpZLoIq+nwppqmmuPGu6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz21s/PWOzTbNIw9Qz9lXR4nVAylbnFIYB1lmYXla23lX8ej2R
	tLdVhlItIdkeJKqHEYQN9IxNi00urdrzvorp3DBzh6O4supc/u1GZbU6BWshXBm9uSmjwcrWiVR
	ZZ9KvtGjuPLDiEOjGeNsIJeSnXaNsYmRXWyEcfZ2YfcHlADibInh9aSX5bgC4/ziCoZQ=
X-Gm-Gg: ASbGncvhRu93TRUI79I8IWvR8VAdFLY7XQ5jX+YoiHKvSo7Dh3tgggDOJlraFEN6xC7
	vFa2pCM576k4FCKnq+fzyFQsaozdfNy7ZrtJyCRsip/bnkML5IwJbPSVJsZ3EASyBqK5bfsfYfl
	Ad8oRREa+b4G7GOB9TaInvI7U3Zsw7sBdXPxcMa1kFuJ5YIjlqNeQydVHP6XvKYCPkOsqQyEP8Y
	4nH4aoKVHXfiflCkVjSUEVZF0juIx+LTAaZf4OV/yviyYtrnFw5Eqr1chXJ0Z8T9uHrgoz/llGe
	wPaO0DomhvYpNKL3gAX89HHCPOmh8EqB98UTvePlSLYsjlUbLqASk1gtrZVfPy1BE2lNtyghu9R
	O8VMSKT7BGNUXhpDRpB6+Of47brfE7o+QUf8qqApQPgpR45su4V5iS9HVIVhD
X-Received: by 2002:a05:6a21:6da2:b0:220:ace9:193c with SMTP id adf61e73a8af0-23d491698eamr3826503637.38.1753267022177;
        Wed, 23 Jul 2025 03:37:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh3iuia7Fnxs1Vjrj7taJa5vrWEz92sHlkDtEQDGIqy8QOF964j+qi8wTzRtiCyAMxDjkHNA==
X-Received: by 2002:a05:6a21:6da2:b0:220:ace9:193c with SMTP id adf61e73a8af0-23d491698eamr3826473637.38.1753267021743;
        Wed, 23 Jul 2025 03:37:01 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb678f21sm9458954b3a.104.2025.07.23.03.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 03:37:01 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: andersson@kernel.org, linus.walleij@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] pinctrl: qcom: Introduce Pinctrl for Glymur
Date: Wed, 23 Jul 2025 16:06:42 +0530
Message-Id: <20250723103644.4058213-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=6880bb4f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=epAnejISswTQ0IiE-JAA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: wNvSG2-vPDQVEf2c-AI_A2b28rSd4CUM
X-Proofpoint-GUID: wNvSG2-vPDQVEf2c-AI_A2b28rSd4CUM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA4OSBTYWx0ZWRfX186S2yNcPVlJ
 MHZHv3aNoeM1ACY5Sk4M2EueX7pSF9rUhMSXIAg9LV3KQ5p4m1IGNaDsbNyuLU15Zsh7AjOaWYz
 NIYSpm5zxOG68jJKc4lmW8gAm5+KxTBWqFh7hKEgk2u8yO05wHvnvk4mp+BCvibu8KDFlt7R+fK
 5JHqlPgotBMf4QpOIUeecE5yzU43W1qvUIZQ+3Ec//lgkrTDvlW8mn2j8ABf0uQNa9sTu1YxHS6
 HQBtXm9x4gqNrNwsVx8WcyYv8CXLw5O57/SEVQ0CGfFONooxYi33jpV8HMlsID4gOs7M6eaX+en
 4hE++JW46KgoxO9N4GMK9oDMKVpyxGKp6aq3EorWzAsHuzNUpXuw0Nr8SSpb60rwMSolbzeO0NR
 nd+FWoCSsBz8OgH0ZXcH8EwgHLqtl7aMkAyFUMnnReVgRevgmAH+Goena47FtmJVnNvYhWFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=972 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230089

Introduce Top Level Mode Multiplexer dt-binding and driver for
Qualcomm's next gen compute SoC - Glymur.

Changes in v4:
Updated bindings to column length of 80 char

Changes in v3:
Fixed indentation for example tlmm node in bindings file
Fixed s-o-b and review comments in the driver

Changes in v2:
Fixed dt-bindings error from example node's reg propery
Fixed gpio-line-name maxItems
Driver UFS_RESET macro updated
Removed obsolete comment for pingroups
Updated ngpio to include ufs_reset pin

Pankaj Patil (2):
  dt-bindings: pinctrl: qcom: Add Glymur pinctrl bindings
  pinctrl: qcom: Add glymur pinctrl driver

 .../bindings/pinctrl/qcom,glymur-tlmm.yaml    |  133 ++
 drivers/pinctrl/qcom/Kconfig.msm              |   10 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-glymur.c         | 1777 +++++++++++++++++
 4 files changed, 1921 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,glymur-tlmm.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-glymur.c

-- 
2.34.1


