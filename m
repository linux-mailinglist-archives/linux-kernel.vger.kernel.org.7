Return-Path: <linux-kernel+bounces-787592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D791DB37859
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 953FB7B1D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A86A304BDF;
	Wed, 27 Aug 2025 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H8SqDjrh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A59302770
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756263176; cv=none; b=WXMbzRM3Bu9wzG0mgnpoCs2dlU23hJma7wEUQzdMzRKahH+UXC9D2UCaaw/tVgr97/hCyGKAKiN232S2Q7J/749z2dgrJP8ac5cG3ZMbGwf9rvehIOwbB6g8XC+GQXSx7ptI3wvsGFet46M4Jq5T72xDnKfHzRZRRdtYNpG1M7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756263176; c=relaxed/simple;
	bh=ES0C/eHUJ0vZMSiE7e9k3eopudAsRoEFpDfAJn+GlGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hS1KOt4cf62CGa3CGYwE/a8Qh4zPYiFdIgx31SHllglmd5qLIeGKOrs2qkHKjOfgxTaXPsHk9yC+KzA+F7/Bw3VcgXjuJiK6AvOh1IFvuZ8sk7W5tDwzzFkz/iuQvlVJs/874rKlHDsk6zXv7vVtAfR0uG3OCM+9AIqawxyomvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H8SqDjrh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QHLAbS027871
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jWgEnfKM2T8SN4ZowpfF7xlxhdEVJCQ/+pQl9CKBY4Q=; b=H8SqDjrhL5yxCvaX
	fNMzBUx0AmZNsoPkXo3pSF+fUiealA5nBKOfTN+1kzcpuAaUpsLc4CnkX9vQwRtf
	h8NtSFOE4vtncZcEE/0hq4Qmdr5zXhXz017+hDtqq7fKl0j8c666VQuq3MsdMcCP
	gdF7D6LhE4Y2UfIymZTtMAG12zQtPgchF3geSGyaHclAA6dcvTPcWAArFlxzCQ5J
	zicJ1Z/bhV5oLYFXHn2TzFUPe/LBg8cm1YVuKxDzFr405UfiO/bgz8lu4HHK1gFh
	dzddD648xfXzPfhmHr9gLRfGLBdiSZ1iWYV1C4GF8qemtEySG2RumaZUnc83dDmZ
	BwROoQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48sh8ahdk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:52:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-246088fc25cso69962675ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756263172; x=1756867972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWgEnfKM2T8SN4ZowpfF7xlxhdEVJCQ/+pQl9CKBY4Q=;
        b=LUg6BJWZxrc+2Ly47JV3G9r7l5YiG5y1dRYWrJYSv4+B0rUmZ89Jt56WmL9UrdMAb7
         8uLdPFsNz1ufTLRzUYOJBzt5W6yo4AQKHril8/yQg3LUO5nue680AOmUliRCpGEQ/Sk5
         UWGFLK1ZKVwXGKSlfBF7VxtvKQwpRoguk0hGNDj1dGYQTok4iU7n31Vm6JtjO0wKytXW
         5YHB/bXChUiaL6gokJNrBwQxxr3fOiiHjXXww8Iz3L/IH+5PNiUIulupHgTVlgbMwYCS
         NxkRki/XETg13UWdXxcaeksYwnGvpFaSZRSKgwco9ztrI5EWPYkvLRNgFI2K8vfzeoqQ
         If2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQhxuE0xjJPlWFsPM6KpL2BFuyUtGyppaPJt1PsWR55TI07DmhGvNNhWGlhw/COifuBiLCwuX18B5pafg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuE/r7lNnv7IvhITLFDhYB85PqrqfD74ufavAO7SiMl1xaQ9Tw
	urMIHfdiG8mFnww4VNw2jxPtg2uXg03i4myigtx+mq4Zm90k/27OrWL0mIku1fPOeDXm8KAI9lb
	nKnL7ZP9iZQ6Uwm7LrmNqbc4ubOdLmLpTHlxYQUqmscwP3xNoNh7Trqrb4BTYB9pPyuY=
X-Gm-Gg: ASbGncsosI/YbRVZyNIHFGufWd57xcSy1U6g7OitBNzMp1ZyeJgt64o2kPMvdgLSB3J
	9QjWrIwj4NtDMv3DdAiKTant8BCJNqwaWdONYu+yYj6N3NBEWt99PDwTSc7/15sQgCgoWCeKW86
	IjH5kFLyv90NHH1Z9VJr5oJ+dshTxYyLO4QHVzEa9/Gr9DuTjedHTgSYyqrSUeOjwchV/2bABCF
	KnZ/ylgcbqRt+qz/MlLiXPvjgX+y1QZrdmWPTt/KG55VGeljOrdNZ8j5WnVOyo1SiyidwSVjLET
	6RLxJzqWMSbayGsuW1aIH4PICU0LSLCcWlEQ0Y8HBYFayUHNZyTatpClYxblA76sJAKDO9si1Km
	qxG/tEPwL2BmV7BzSshD6JYNmEv2n/HQZbQ==
X-Received: by 2002:a17:902:e94d:b0:246:e3eb:83eb with SMTP id d9443c01a7336-246e3eb883dmr89472245ad.9.1756263172125;
        Tue, 26 Aug 2025 19:52:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqqqn79vouwlZO4KNux7qzyUJSjXJNybPNeCuIpEcgF8TZwWhnREv1xmYBLaQ9KJnXBXsGSQ==
X-Received: by 2002:a17:902:e94d:b0:246:e3eb:83eb with SMTP id d9443c01a7336-246e3eb883dmr89472095ad.9.1756263171724;
        Tue, 26 Aug 2025 19:52:51 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687a661fsm109337585ad.43.2025.08.26.19.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 19:52:51 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Wed, 27 Aug 2025 10:52:18 +0800
Subject: [PATCH v7 1/3] dt-bindings: arm: qcom: Document HAMOA-IOT-EVK
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-hamoa_initial-v7-1-f9b81d564bb2@oss.qualcomm.com>
References: <20250827-hamoa_initial-v7-0-f9b81d564bb2@oss.qualcomm.com>
In-Reply-To: <20250827-hamoa_initial-v7-0-f9b81d564bb2@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-5bbf5
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756263163; l=1177;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=ES0C/eHUJ0vZMSiE7e9k3eopudAsRoEFpDfAJn+GlGw=;
 b=I74cHyOAQ19djbA8fWCU/jxqgxV89TL229KhWU2N+T2CedFkYml4WtmqKIelGJiD+UnMFh+Ma
 HxXDJac9N7ECQlxYG3hIu3a6V3CHN8rKLAskOGLWTxNLADGbzE885i7
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Authority-Analysis: v=2.4 cv=cLDgskeN c=1 sm=1 tr=0 ts=68ae7305 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Bh1HEMNN3wmc11-eFpoA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDE1MyBTYWx0ZWRfX9uhfW00RZR1a
 LsuEcOlJW/EAKeJUOOEELaXf2HBba4Z/VyXsUmzG81Um/7PE7grPzXkw2Ic4xLc7o+TIiBaauI1
 LSO+QRejpMKTjs/oQSVDz4td7waIS1NCNt3NlBTJkG6IhLimvfFPiKIBG1QwUer9GDWnHu0DYLH
 oppqgy6Iu0A21yae3tEScI2mjGF2ObKEnY9ck+saZvwMKDg/rRx8Ip6gUKEOJ+8EtS9U5k/j1oJ
 zn8mo8sGxQGImtC2jKd0IAMnIbBaSdK2uhksLAjpRhs7GDVwOJ7T8FtbWEtzJpiab0cHCkydfoj
 /XAw3d1TYhU6NbWrnVfvUk86UpzGEzHCVU2s5hsRWj+zQnYIt0KF1+1URamF4Q8gxOxzWKLYZp8
 8ECCpaIn
X-Proofpoint-GUID: dl6UYLd96-5uW29PvHeNAe96iqvxApbj
X-Proofpoint-ORIG-GUID: dl6UYLd96-5uW29PvHeNAe96iqvxApbj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260153

Document the device tree binding for the HAMOA-IOT-EVK board, which uses
the Qualcomm X1E80100 SoC.

The EVK consists of a carrier board and a modular System-on-Module (SoM).
The SoM integrates the SoC, PMICs, and essential GPIOs, while the EVK
carrier board provides additional peripherals such as UART and USB
interfaces.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 55e5eb75af89..6b6503181ad6 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1069,6 +1069,12 @@ properties:
               - qcom,x1e80100-qcp
           - const: qcom,x1e80100
 
+      - items:
+          - enum:
+              - qcom,hamoa-iot-evk
+          - const: qcom,hamoa-iot-som
+          - const: qcom,x1e80100
+
       - items:
           - enum:
               - asus,zenbook-a14-ux3407qa

-- 
2.34.1


