Return-Path: <linux-kernel+bounces-803201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD34B45C0A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB2F3BE247
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3CF31B817;
	Fri,  5 Sep 2025 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XEpTXwnz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F9231B809
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085062; cv=none; b=QUy6SP0+ZIQhbtJ9d1EvhBgKYVPyAtxqIfH2qHLk9f67Msmg1hQ7zbRE3NZRwrmHkeJXLm0bvAgwnUSvojKdYfqDGzRybCqoeBGl4XJV1NsLGuAacZwZfAEymmscYwk8msr/g/nB9r5ULhzNL3Yrx+D3SKMwJC7kJc7lgGr5hcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085062; c=relaxed/simple;
	bh=BqHA2KI7+E2wg1IN5Us0LjPUXVJRXh89VEgZqldP01g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZrdAEfBkhZklv3molS55Eo+mc4Y1dVoNhvH6J9+iIGe8QSWa1HItgO6n/JjAOnpqUoBZ5ciYsHbLyGjhCQx2GNLUcqPYDOu5VPOL+pnPkY8upuNqxAMoes26V2qEFpsfpqqM/gAGKvyeQPBW5buglBLttYYVp4PgfP0j1OeBI+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XEpTXwnz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857fxeT012208
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 15:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zCUHK4JFj9/T7BE19qN/qk
	2a+SV8gFmOlRACJ/Kqf8I=; b=XEpTXwnz5PB6w5E3IGR7bKCDisTzDrgig6yQuA
	ON6AdQ65OQQm0RQmsgMuwezC7utsjqe5XUWsMtXOtqjmF5dRLJ7iN5x69tYVawmQ
	bPEKDOxXw40fN2LwchmwpUwRoKJHUADYt4le7jXlZiBMNjQye8OI3eVhkE+V1iWU
	4gH+a1KuzV+6cIGFlC/yJaQpxekusFaSrWsOZrzrHIbE+rZ/WoheZ/tqexuARcDQ
	vdvEnWAgPeOVsgPqaz0hC3+feaj4vj0d3h0Jnr4W5YzOkbdiIA4rCtueREOLiam3
	MJ9yET6jcFJ+Khw/vkKqwVhrf+GhNpWYlwqWub/shxxi9z9Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj7u15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:11:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-244581953b8so26232685ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757085059; x=1757689859;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCUHK4JFj9/T7BE19qN/qk2a+SV8gFmOlRACJ/Kqf8I=;
        b=qpXfqNj7UdZvcWvQPzE9kzAg/vIwtxOsteq6OGJ9L4hKJdMyebCun4dkL16T+M49pl
         MYUaHvfrdrEvwMnVbVz1f5gddP3PIpFse/DgjI3lExiGT8K2B+5rK79Zmkqvi2VIBT94
         xGGwh8gcvFneWT/j69Hh+JoIDIHW93yxjlk+J38VIWfox8mD4s3XN7TfaJ3SNCgqlybY
         SLQZ+BbBmx4jNAztMr0IVKfQ4Ve1toOLNf25CqCEGgDrs+e5mu6butyZeyhW5gZMJRWC
         FhL4J1LwlHJ4O47skB0oUUZADcQUy6mG4GIXbdjw4IA2RYCoZtVCX7F/S8UytWV9nbgU
         YNCg==
X-Forwarded-Encrypted: i=1; AJvYcCWxwE4Qm9zX76hBNdCSBSGltCg50U/yT0ASDpzcrywEPS+96xni3/J/BJiwzlt3GdUQdAmKYeNnwcp8ksA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxyVsAgyAu3G+GI/Ki8XpiGLmj0NlwzevkIMMaj/irouj8C065
	IQ5vM+ywlCBf3nyzHEqNcV18Z176/9DT3SdSRt6KDCn/2/1EtU3awFzdKMh/JRm8iFXSxk+PMgg
	1VfCq06+D/2MUHb3OJut3KY/5ZIcYdU7fHXZGi59sRDxsBI7VVD5GlA6RmaqydBw4b+g=
X-Gm-Gg: ASbGncsXBTPx+A7sQHv+y5FPhW79NOceiK+oENi+T3zsA+QNQRdVkb7G12cRf688mOo
	g0KTtu7Y2gtetTxt47gm5Q4VR7p5a32p/llJgz2JAnnA+6OSNedDxwevON3pN7MfKH5VBYjJmZh
	qv/lG0bGodVghShP3RLqLGy6QyQmX7ZU0k61idi7Ym/PqerX6rxBTfYXpiWbzPvb54IGg2QgerV
	6WluMZmiphfsU38keki6CsoAurrBd7TDVutaVok+pfC7ANAF7jfsvvTc2xZO67otT+OXRD5rTAo
	CAROwUsjWKI/iJ8Q8hbrnLr1JYtW3aGFMQqgxmO3WSwXJx2SG1C+LSbXpmHQgmzQdfADz01o5xj
	cf4XFJicGf4AUzPeiW0yhbJRRF6+U45OcIKD40KjGI5iAbVzHQl4FwxzZNCzM
X-Received: by 2002:a17:902:d552:b0:248:ff5a:b768 with SMTP id d9443c01a7336-249448dfcd7mr276291165ad.10.1757085058997;
        Fri, 05 Sep 2025 08:10:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg4+nMFAS/BPgW9bPSO2Z4RPxKHv0LPQfTZ6rcqDIJDLKIhTOAJ1a06wN5qeR/MIqSzQ9cVg==
X-Received: by 2002:a17:902:d552:b0:248:ff5a:b768 with SMTP id d9443c01a7336-249448dfcd7mr276290355ad.10.1757085057885;
        Fri, 05 Sep 2025 08:10:57 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f5a0bf9sm29279908a91.13.2025.09.05.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:10:57 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Subject: [PATCH v6 0/2] pinctrl: qcom: Introduce Pinctrl for Glymur
Date: Fri, 05 Sep 2025 20:40:18 +0530
Message-Id: <20250905-v6_tlmm-v6-0-1720e5080415@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFr9umgC/2WMQQrCMBBFr1JmbUpMmrG68h5SJNSMDTSNZmpQS
 u9u7NbNh/d5vAXYJe8YTtUCyWXPPk4FcFdBP9jp7oS/FQYllZFHaUTG6zyGILTSZFE3FvcExX4
 kR/69lS5d4cHzHNNnC2f8vf+NjEKKAxEZao1pWnWOzPXzZcc+hlCXgW5d1y/+AXS1pQAAAA==
X-Change-ID: 20250905-v6_tlmm-323fa634a61f
To: Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, rajendra.nayak@oss.qualcomm.com
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX8M+0eU9fnz9+
 kN4mD6NVoKb4rhnuazZLOd/MrpAxivk/Foc8h/Oio2ZaT2/5TePZQ2A2B4KSraXDOS7uCO0fMNk
 fuBg8Cq7bkNHHPLWy1BTBSSXC02vbUKyPtg5vFQcBDYbADO7eGVY1WyOFrI83A3e/ktqRa25jzG
 XhGcMyqPaP7IhFmCbp8QjrOPGPJMuFcvwiRfV66WMUwk3bZTIrQ5tvFHH+5R6yV1PeDXneD6z2L
 Kj5XUKfMzSRGYs10hR3o6MugMmpFLwmyOFRHEi+S0WN1AM/Y/bqszdjy8GPIdNMsuGvFYsVYF9p
 dcT4YsZZcOgxQ+9D3+E23FRx7JzWWD/s4qKw9KvbO7EiSczDdcRpIS/T6F73UDrT3naUvVffn2X
 AkBLSbIS
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68bafd84 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=XKE42yAn20ll-QmRT3oA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: yU-PadjZ3jSBSFIIX8WMAM8igGhe49mq
X-Proofpoint-ORIG-GUID: yU-PadjZ3jSBSFIIX8WMAM8igGhe49mq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

Introduce Top Level Mode Multiplexer dt-binding and driver for
Qualcomm's next gen compute SoC - Glymur.
Device tree changes aren't part of this series and will be posted
separately after the official announcement of the Glymur SoC

Changes in v6:
Fixed maxItems for gpio-reserved-ranges in bindings
Rebased on top of devel branch
Link to v5 -
https://lore.kernel.org/linux-arm-msm/20250813065533.3959018-1
-pankaj.patil@oss.qualcomm.com/

Changes in v5:
Rebased on top of v6.17-rc1
RESOUT_GPIO_N changed to lowercase in bindings and driver
Link to v4 -
https://lore.kernel.org/all/20250723103644.4058213-1
-pankaj.patil@oss.qualcomm.com/

Changes in v4:
Updated bindings to column length of 80 char
Link to v3 -
https://lore.kernel.org/all/20250721163221.310746-1
-pankaj.patil@oss.qualcomm.com/

Changes in v3:
Fixed indentation for example tlmm node in bindings file
Fixed s-o-b and review comments in the driver
Link to v2 -
https://lore.kernel.org/all/20250721143037.20983-1
-pankaj.patil@oss.qualcomm.com/

Changes in v2:
Fixed dt-bindings error from example node's reg propery
Fixed gpio-line-name maxItems
Driver UFS_RESET macro updated
Removed obsolete comment for pingroups
Updated ngpio to include ufs_reset pin
Link to v1 -
https://lore.kernel.org/all/20250716150822.4039250-1
-pankaj.patil@oss.qualcomm.com/

Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
Pankaj Patil (2):
      dt-bindings: pinctrl: qcom: Add Glymur pinctrl
      pinctrl: qcom: Add glymur pinctrl driver

 .../bindings/pinctrl/qcom,glymur-tlmm.yaml         |  133 ++
 drivers/pinctrl/qcom/Kconfig.msm                   |   10 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-glymur.c              | 1777 ++++++++++++++++++++
 4 files changed, 1921 insertions(+)
---
base-commit: 578c9ce6071995e1c2e7ec3ecd2fd2f5498a1dbc
change-id: 20250905-v6_tlmm-323fa634a61f

Best regards,
-- 
Pankaj Patil <pankaj.patil@oss.qualcomm.com>


