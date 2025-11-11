Return-Path: <linux-kernel+bounces-895789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AC7C4EEC6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647F73AA814
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26A77082A;
	Tue, 11 Nov 2025 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BOVk0AgF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TGswAheL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D2436A012
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876978; cv=none; b=uu9q0AQm+uUXVSwUhN+h5ZJntFvhLBbiP4kINq39bd5Yd0q0daiprKGAeHX99bo/fPNz28DRiekWBULF2471xq8hBf5IHqh96to1BBsmeMUVsRG6F1o23iUb9p3rSSlLK0xEC+ig25pqXHkdO95MVQdYA4u+WKFYGV8gFbIBYWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876978; c=relaxed/simple;
	bh=Szl2H3XbsTdN5Hp3bW7dxEgQFIDzEkvs6uk8oNOn680=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UHqGwKz9tzmiNh8t1jKGB5fU+2rUly5h+UCH+Q/xz5HZQSjY7yLVERcqjrxnyX3rObeKiucGYd/6HGqfYj3tmv6Vq9i7GFLy2zwggZyvQ2a+YRaBosT7FoxqBC1x1P8Umx3ccajzalox9YULBVqRUAUYewh+LK857A9e5D0KENQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BOVk0AgF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TGswAheL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBHN1E2118997
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gEfAh6rp9MQrdIl36CEViA
	ex1/8JADzaa0H1cCy8km0=; b=BOVk0AgFFoLyOKRL4VZ+PQrlRjq6nAAnI3yv/8
	IC5lriuqI076jj+oMmU6AEiDDePtgCcO9XAL6PpeGuzzpMsUraBhVODh/5R8+VP1
	WUx7hAZUIC7svqS0yBzXQcX0EPiXK7wsTeL0u7WM1Ol6CnR4sLM8+zXerKvHp7+W
	BN/nUSum+Pa7adnPguFgbAnA1oPThI2zR5WQrlb+QyrApP5U3DbOrAWfpxhy+tCH
	sjoG5QOUzfHkQjNFPieQSPXidvH/7JEfhGrLEl5IKngcVGXAwlAXYp2udepVZtrH
	R9xymnzcC4gYTC1a2JIOYKd7S4JqHl4QtzMzE55lUzXMjnuA==
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abpy8k03w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:02:55 +0000 (GMT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43373024b5eso30103025ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762876975; x=1763481775; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gEfAh6rp9MQrdIl36CEViAex1/8JADzaa0H1cCy8km0=;
        b=TGswAheLulhJSA7MqkZa90AgFtD9Plu+5sIDEclJxn1vzLPNvHmJ3LNeBDhcsaxN50
         oIlTq7CEPFb7hcGiaONSce7cvkEvDiXsT6avP1ChBVcpis0WZjQauJjTHWkj3GWS3Ozt
         Oklv/GpRhIx4GN3MnziS15y7EZ/jiy5zCKBdFcL47rCM2g+yp64acFnj4S8wDxYiki5G
         HYEooAsRtvgfVHSUt3TawSHW1gCK1mUP0/oA2R4ecvEyTf2p3iSwKg5FMF2rxZL9FO6y
         eq9CG9+Tc7OkNtPhIKg87WQ4BAAlxW2wAQ8OfxHTINE2GZDhHTw+Y4PaSRg5L5FxxANV
         BNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762876975; x=1763481775;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEfAh6rp9MQrdIl36CEViAex1/8JADzaa0H1cCy8km0=;
        b=UXyYe6zzO1V1lR2+PPFbIXIuAx5H/uYirlvy2AToNlqwFRjgHgLO5QuYH2K4o7ji7H
         kL07LoI01s9zozk/34lRjQOsDPEAgF8QsN4i2BYh3gBNupV1oN2GsJn0/HZgGpRiPXiN
         nWL8cKp8HvnpNJrt2ui2jCKjQM5RfwtsV+n9V3W0Ax4xuD5euo/BEsoG2XxsjCBRcbj1
         I2Ms+GgcUAZfTn4bOZ8xytAHWukHe5orLWPTbV17ubY7a19XoKKiRO7KBUWdSIjOylOe
         PrTh5q4wAAd72Ty+b+m2yDh/GTBtO8XCr/vMHuBB3OrMq+j7QuD29gcwGL2x9+JRBD3k
         sYYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbz4V2qGQE3QXxRfJCyB6mZmoggePKWftvHXeNYApekwB2WsCk6DpiuNczCn3WPoZXWQXA+5Gyff93JCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCzNvlQ1EVEtP2qI3Ple3zEIzUY6uhlx1IrOvVcuVV80rnjS9e
	DLnu6fiPY4yE+mJtZvOMJG19XYVQKkWna2dLqHs1Yw0Lzz6AwTX4KdwpMKt9DWY+ca5ChAjPpoh
	5OFn123tHAPcok32hViUqtMIKAtGAMPFwvmY/FM4VY+ipnIJYsB0bvQ4iaE4JMvJNqXk=
X-Gm-Gg: ASbGnctFoRvSkFHutSt45l1tTk873dZW2IU1rbjLFDEioXZ24K/Ms7wP3QXI5t8jD/2
	nt/mAApyGu11Yw6iu7jSApSWKIE0HPHUe/isJeKmKmlaO2BQlG9S8jWG8jGe7nv+5KWhgejgTz6
	fPkuIh4yvmMqHv8mvuGLfITNGEEGdvc0qa0NSUp2GUNMdyGHZAh231u4ifeBT17rwR7sGRVNt+y
	9QlBr6mD8qqiBL79fxrX0TACKhJFENImcYL8Wl07O9Y6kwrmh6qsIhdCUHjmn0lbbWCsIseKN8I
	FTUohbL+0WuXU1LfnXf49KBPPxX+StmJNs14d0V3ugWwIPHKU9xWChlFSkgL7reoqAOId9iqVrB
	/krcI0DVIJl+mAG2VHj3WxNZ1jHo+luzf/pGxkeLCAM7dTjAO9zOOL+yFdrHzLZVqOud8VF7Kf6
	TStwQ6zQKNoTF6
X-Received: by 2002:a05:6e02:741:b0:433:2341:bc13 with SMTP id e9e14a558f8ab-43367dde525mr202694925ab.11.1762876974715;
        Tue, 11 Nov 2025 08:02:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMeGuxuvNqNErBimtBnxbPGOE63puNynCAr2CwRbSYpmZTYmk56G2PXxE/3b2KkI1j7a5EoQ==
X-Received: by 2002:a05:6e02:741:b0:433:2341:bc13 with SMTP id e9e14a558f8ab-43367dde525mr202694035ab.11.1762876973884;
        Tue, 11 Nov 2025 08:02:53 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a1b231fsm5149139e87.74.2025.11.11.08.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 08:02:53 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/2] arm64: dts: qcom: add AP8096SG variant of DB820c
Date: Tue, 11 Nov 2025 18:02:50 +0200
Message-Id: <20251111-db820c-pro-v1-0-6eece16c5c23@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACpeE2kC/x2MQQqAIBAAvyJ7bkEXBOkr0cF0q72oKEQg/j1pb
 nOY6dC4CjdYVYfKjzTJaYpZFITbp4tR4nQgTdZMMB6OdMBSMzoOkTw5S5phBqXyKe8/2/YxPnk
 xIJ1cAAAA
X-Change-ID: 20251111-db820c-pro-8ecd2a28520e
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1029;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Szl2H3XbsTdN5Hp3bW7dxEgQFIDzEkvs6uk8oNOn680=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpE14sngE6ezmNymcaCodRsu7ZVFgpxesv7SzLC
 yz18p4mGuOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaRNeLAAKCRCLPIo+Aiko
 1cGuB/9oW3olB+FSLNMWpFbbJTIz9oIMflBJ+LnyvqHVon4BgeSy5JA5lXCeXrhN6A/DdE21g2G
 nR8C8d9euGSc7EdoW68MhyHIIYKlzDMjKCWP3Z2yn53OhG6LjShTQoZQ4rL3gecifl+7ueAXvN/
 BRQRzPEZBRmF+rfw2204hLhPDDyie3lQrFA4j6y9Nn8Beur1yq6cxUq5eW5tBTflQZPMtJNjY3y
 M2kL2glrSd/Vtb/tForC5N5WOwJeukMsaPI5DdT3Rd/dFJSg4tJU+g2Ydc9ObGZdmpKDjgdx0+6
 3zAgp4QHoutwYK8bQnV5iiTt10Y/xvKRICo76vVpWWH9MCnx
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: oq27_2NqFgQAql_7_oFUsRL9PLrP6lO-
X-Authority-Analysis: v=2.4 cv=AYW83nXG c=1 sm=1 tr=0 ts=69135e2f cx=c_pps
 a=vy3nvQW9C2dqy/lMnN3IYg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Hd9naEU_5ldSTe-YsNsA:9 a=QEXdDO2ut3YA:10
 a=mHQ74H5e8mo-RpSg_uaF:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEzMCBTYWx0ZWRfX1Cx178lNOEgt
 A4VzqYOPLNhqRbJg/F+G5YKe7JKyuFywFZkwBc+HMWM8sPcK5ahXXUj63PPrwixwT8c0Ma5daZO
 E/Q+z+wf3kDdFY/wgc2ki3PA2qHF32tOJ+rHi4rc486VX44kjx6GWlDIY0HrQCJxutf7FgOcvbK
 hS4sZlXKPwwOteX2krlKMcn/zfryAnzHJeUOe109+l7FQFS7cxYuWYei2CP2u55zROqHKUNeBGX
 Jf6+IgQCcOkQZVEcNfmoOerhU90FkuevyltWyZoh+sy+o4mLB9lME45l/jDetdyQhD/QrwTeZWg
 u0RcXI1j2jF6fi7PHcuSbGoHL2xVOiek1KkmYdrSLSjsLL+R/B4FY4A2ro3riGgUkhk/Vj36nCn
 YyP8rRKpWMKrLTi2Ik8onwNcEwNCyA==
X-Proofpoint-GUID: oq27_2NqFgQAql_7_oFUsRL9PLrP6lO-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110130

While debugging a crash in the DRM CI setup I noticed that the kernel
warns about the unsupported hardware in CPU OPP tables. After a small
research I found that board indeed uses APQ8096SG rather than APQ8096.
Add DT file for these boards.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (2):
      dt-bindings: arm: qcom: add Dragonboard 820c using APQ8096SG SoC
      arm64: dts: qcom: add apq8096sg-db820c, AP8096SG variant of DB820c

 Documentation/devicetree/bindings/arm/qcom.yaml    |    7 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts        | 1126 +-------------------
 .../{apq8096-db820c.dts => apq8096-db820c.dtsi}    |    5 -
 arch/arm64/boot/dts/qcom/apq8096sg-db820c.dts      |   15 +
 5 files changed, 24 insertions(+), 1130 deletions(-)
---
base-commit: ab40c92c74c6b0c611c89516794502b3a3173966
change-id: 20251111-db820c-pro-8ecd2a28520e

Best regards,
-- 
With best wishes
Dmitry


