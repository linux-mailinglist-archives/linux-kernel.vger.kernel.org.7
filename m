Return-Path: <linux-kernel+bounces-733185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79150B07142
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71CF97B4F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3F62F272B;
	Wed, 16 Jul 2025 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gWBFx4kw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7A42F2705
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656970; cv=none; b=sqQ+wqgfL9RfVV5Hrn/9gLefKd8xeqpmPBZtoLBdEc8hzvOXEGXRdfTSRJRx3OEqZg2LTFvOKBRwK61mrhsj1KgvuSEPNIMMDzq3ONnIFuI4108L00AwxzLgCSXSFl/0m5zAf+ZYj+e25ccFtKL5zmA1aqI33DXQdjdQwUjR83E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656970; c=relaxed/simple;
	bh=Fly8KKTzJ7CWD+LVdqYCrxjMnt8d1gn0I63K2HEHwgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oYy9vxEGggNGG3EGeJQMS7HsuhYG6hJqTORbfd9anfgBi5Xl9UXAHp6kcwBJELeNMxOqUsF0fIaJ1J497K1krUgoSaP6pHO0ErlHgi+mPLkq4wYTxZnWclY7iN+LT+4wKgQKuKUvwU8NO2szJp1a5jnDcJY4JjVkaenG/iyGykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gWBFx4kw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G6HwOJ007841
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+ZSsnmMLXdvjAOfPiKvJiJHPk4pPjVmM4Mc6ZjXFXlE=; b=gWBFx4kwYIXr28Fm
	nWaFxgwPsuhwyg8PqFkxo3OC0AALOv5UeIqYG9kQCqlYtNycFTWWe+vx4rlT7V9z
	WIMIBiMfTZ4kMgPh2szU5BX/0QsgH3OiyX/nPEZRYlIEO9howtMD8n+yasoqw8LT
	5IWN4fpLLo+3/xFaZG16ntN/7G+AySAKsX+KPLEm/6fKmrfQU0Zof7CwFcifmqAu
	KbLvdqijLqUP4sRpznfytyXML6wlbzgWDocLjZfsYLuzU5WLC+S/X2Re5mDtMH6X
	HC0cEaB39ksSxIJgkDo3IHWHEDxhqeM3l7ZhoxlaBectXb1fV40DoyToHCS2wCDX
	GYU0KA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh5uejr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:09:22 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7489ac848f3so9656287b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656962; x=1753261762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZSsnmMLXdvjAOfPiKvJiJHPk4pPjVmM4Mc6ZjXFXlE=;
        b=O3Fe5LDN+WGc8zZy+2J9vndWbT/6PiStAfBoZN/++JYVZPrvicbiEccdxViHUgcZU7
         1NxCNcUz//7VXL4L4tXB7AZYmXsr3cb2TNli4mOQCvtBCTQDyQvrNEoRW0p5CAPGoBRx
         iv2nw+hGVun26xAF3pqJHkl6qOFPJUxyzzGPdRhvfmewuA4uDGbktqKmkSMPniQO17Zy
         L9UynUlkcug4YPdZHURKzz/Qf3vrh4C+Ps1Am93wecDR8WwaCdB151Y7W/uQCIa30tZG
         k9xzNAeepFMlr4VoPQJIVgxbpEWn222xBhg/TAP+FMNnLlu8vTlWWdgn6WLvx+62ZZi/
         3C+w==
X-Forwarded-Encrypted: i=1; AJvYcCX4a4E+hazaxQHt6/ir+Bm21rZTRJ6qq7QVcvvXckO1DOgLEFdudQDgCXmdnj3/Cu3UAMuLlj6Kl9NeobA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7T3AyI6kEKNJ0ekkzIHvfgS+BAqguNHnMXoZD+PwnIOvEmISE
	i1AyJxDC11l9i4JcXXiGoa2rIhdJAM9dpIRsXXiwtJnN5D5VzJQ63UxI2GhCvqjUutng1CJBSwY
	OaaFg11SwpjJ+T6zIwnMb1xWBXna/6kzNEhQ2gr35nOjP+emZlDwgJE8vJog09shp1P4=
X-Gm-Gg: ASbGncu8L6ibssmKcVFGF2KHFWCQP4WbHJIoGfWDJZWhc7RXPCmiuWZ6UbgT4dCq1pQ
	DTnjgd1M0YCwNG332xzMNGrY+Ou4LveeOcorqRwB9SmdFlk0cAF1PsLTAsX17d9AeUWe9zFg23C
	iFetT9kwmwfahsZjh7aWpHEJofDpW3/8B+fdlwRz/4YbXqAnrMIlMRfUFtIdVgcHWu0QwfAGN3r
	S+bsQYU4zBOQSsKy1WxRZf0nt9bLe35MGKYa0Rbx5tsF96VyLpeY75JyF9aIR3RlGOj16gHJX9H
	CTdU1xBkG6cBeYtjzR757S+8GsLlDtw+trVyQ++qaM2fAXT6/BpKOWuZhkhea8dOgkN5S+FE6fL
	j/jnLcJLLbHN4acfCg81jiZtMN2eYEWntwQ==
X-Received: by 2002:a05:6a00:10cf:b0:74b:4cab:f01d with SMTP id d2e1a72fcca58-7572508125bmr2534849b3a.12.1752656961619;
        Wed, 16 Jul 2025 02:09:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEZ5DQcZo62SqHIKjvUivRsKY84ejDfrmA/WQiIfHCdGmDowGSLYTWARk4UVwnc9gfYsuwZw==
X-Received: by 2002:a05:6a00:10cf:b0:74b:4cab:f01d with SMTP id d2e1a72fcca58-7572508125bmr2534803b3a.12.1752656961134;
        Wed, 16 Jul 2025 02:09:21 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd6022sm13926375b3a.8.2025.07.16.02.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:09:20 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 17:08:39 +0800
Subject: [PATCH 1/4] dt-bindings: arm: qcom: Document HAMOA-IOT-EVK board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-hamoa_initial-v1-1-f6f5d0f9a163@oss.qualcomm.com>
References: <20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com>
In-Reply-To: <20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Yijie Yang <yijie.yang@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752656953; l=1644;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=Fly8KKTzJ7CWD+LVdqYCrxjMnt8d1gn0I63K2HEHwgs=;
 b=S3euloBUvf6vGs39Jz7hp61Q+/lvXntgfNlGRqr/f2q3IlZ0HIlLOZdmX6IadZdQOf6CBZNRn
 di9Nd/MIndhDIsIg0SW9eDV0TN9X3zVATswL2FdRpmRipONRiaFqzRS
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=68776c42 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=X4CchLBkMRYhfesQTxMA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: bfCM7lkzJjGMOVkUD36ez2GN2uPm-F7i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA4MCBTYWx0ZWRfXxnXxphRxggzq
 99HKEEFUQD7u1wCSduWKao6KQzILZOTGHHia1GnvawsnRSEIbyYKl2iCI3lM4p2TsbUa+xmhVfb
 RgOVt+122aQEKvUgv8iB/zRn3BmEUvROZ6ifNGhxpH2GQdJeE8Ff/WReV+qKk7Xde0SNOn/vGPR
 MaIgBlkR0Vgtkf2bPlN+C1/RW9Jj3xDiiKhxYHYpBCRC/ABKCcV93CgwlAX5jKj2MDa2CI+jENY
 6mZ3ZCmEj3uStjO8J7a524VdthUb4bOGjfklaNkVodQA6hAb5OgT7hGGbt37oO8t/uCyfykCmaX
 SI4603PYLzmfFbfW/JpNl4HpcpTfYZqgL4tamp7hQzPll4z7l1OA+yA/fBZ+w9S+KquV7ONUSO4
 pDNjbumHKgvjlaPeWgZziV4+9Mvh8Z8YDxcZTe0rqjjW83mI2nClI7qK2mp7lG0xRGObpoAr
X-Proofpoint-ORIG-GUID: bfCM7lkzJjGMOVkUD36ez2GN2uPm-F7i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160080

Document the device tree binding for a new board named "EVK" based on
the Qualcomm Hamoa-IoT platform.

The "hamoa" name refers to a family of SoCs that share the same silicon
die but are offered in multiple speed bins. The specific SoC used in
this board is the x1e80100, which represents one such bin within the
Hamoa family.

Although "qcom,hamoa-iot-evk" is introduced as the board-specific
compatible, the fallback compatible remains "qcom,x1e80100" to preserve
compatibility with existing in-kernel drivers and software that already
depend on this identifier.

Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index ae43b35565808ed27cd8354b9a342545c4a98ed6..83b09ec1100ca03044c832212a99e65cc1177985 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -100,8 +100,8 @@ description: |
         sm8550
         sm8650
         sm8750
-        x1e78100
-        x1e80100
+        x1e78100 # hamoa
+        x1e80100 # hamoa
         x1p42100
 
   There are many devices in the list below that run the standard ChromeOS
@@ -1162,6 +1162,11 @@ properties:
               - qcom,x1p42100-crd
           - const: qcom,x1p42100
 
+      - items:
+          - enum:
+              - qcom,hamoa-iot-evk
+          - const: qcom,x1e80100
+
   # Board compatibles go above
 
   qcom,msm-id:

-- 
2.34.1


