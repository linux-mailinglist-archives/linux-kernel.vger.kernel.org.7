Return-Path: <linux-kernel+bounces-831381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F92B9C828
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D8316D19C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DEA2D12F1;
	Wed, 24 Sep 2025 23:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bXlfemCm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B22C21E4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755890; cv=none; b=GNs1qrfS51OzShsPV35p+bR+04FTdVwER0IEKKFTyHfAlhtTTuHUbQHmpFllmjnX0RbZw+y99CmN555WN6KSUcbKzOqPdze+DoWe+PBEygOIYAfzh442c70Bc7kL3c9wdXIFBDuEu+bNfXAsiF6qFUz2CfpSM7nGL+Y1YTtE8Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755890; c=relaxed/simple;
	bh=ZEV7aGV8kcTDQaybr4hw0p9WmY5zSMtxQK7hwQf80Dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NE6qWFc0TKb+pdEA2eSTGzGZJorOnpJmCvsnnKaOsK+myBWE+fDk24MW44PNXWgCrtAyYVw65XhxgID6SwI53Z8Giwjxr3a6+5bvV0b+pJKvipw3SN31fWr5f00CNcnCw/02zPORJUm2uPvYGNAloNcERHH2Rfr5eZL6eLTZ/QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bXlfemCm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCx2nR016659
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CMpKhbxvVWoQ8TSL+vf5qR5STP8Ly5l8MGKkJsWdz7g=; b=bXlfemCmJFyxDs1p
	Ej4cEEvHjnWVmvMNxU611PRef5xJnfgFRRA+BSe1Vt7UqQ+XLLG49J8hB2M1QU6m
	e6JAiR8t59I3k+giSLwEepv5Ah0gPfPMcAOs41Nbx/GnslNsTd6YBr4s1SsRyjii
	5iMygr809f4KqKEDo/CGYPlPSLYgjloih5xgTCo5XPf/LDrsGmJSxpKEUv5WfPWp
	KUJRtkGAj49SsKrSTPaQZDars0vvwyxKK25WWKj5m9WaR1M3wzdv1uRwXX3gyA31
	wRNjlsotznFYxPzO4C7KQPjaE+1g7eTvx+4w8tFPpEHrFCwHJM5T0/GwfpuUi2jD
	WcdQNQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nyhtws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:18:07 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-25d21fddb85so5030605ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755886; x=1759360686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMpKhbxvVWoQ8TSL+vf5qR5STP8Ly5l8MGKkJsWdz7g=;
        b=sNbIMAI+VONHklmiSQkaYdvQIt478vywfaM1ty4YRFBxv3t8nT6dH6hvo3oZHzWDgU
         nGsEobpD/Qh1KG5AtxAswgbdlUeS4LfZ5eaWPVGfGyGLg3Ry6sdZesFtld7dwYXxiBZG
         upDMo5Uz2Z2M7JZGg90A32QvEHCPnSj7uUGIggEPg+58iaK3T1TXyg3Ak2mNdlgN6jUW
         5uO/E0dLVipk6F74+4ZtOhyfzHVjkFEB+IRBdiu1fgLu6fU/5WfO4T9bYOloExWOytfP
         qMXEDxFjvBo9Vtv/jJNKuklGIKpRUPXEqpzjy/GCGvDFWunmHEyDJRW8+VsN6IwiPYcG
         C7qg==
X-Forwarded-Encrypted: i=1; AJvYcCUtlzqpueIiZRRzvieKR/az1B8esG+eNgfNrwNjq10bj0FDJrFCrqk0B+dwyDAMhtVduDLKkujxBFHJ6+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEx8ZAF8tjJ7aoeLsehclqVVNIM5Q8dUn7uOOARLAe/cVmn3/F
	jOA8U+Ws18E8Q74mQixDju/gpYLbw5MnR/HMfA2OPt8AE7tLuOE4e5DkqJrUttwbB3Qt3buwt/d
	fxWfHnlKSVuWbRltLir1bB9RBNO711AtzW3bjjkTIUxKTMnMfwVIYBwpblbir7y1SCns=
X-Gm-Gg: ASbGncswfZHEx2tHDBqxcqbnEUHUvxmF3LJsRYPtWVHBraNvh9G9ouDmVaXcODDIu8n
	G50wg2Xw1xdQ5QE3Q7dWTRbTt0cIXeOED0vMoXMFL/AgkC3aQdzvTf0Ojvqnj27JXoLW7RSv7k5
	jRVJGxPNwdyg/rjfnayLN94qOoukHwrY4dFBTab01UXKhDE46erTa5scamxJPB6SfYTNwqzTS4h
	+wTHws0ztcG6Crf6LCPsPac+NGoGfmagggRvA6OcrEA0Z4j5yXNgLNeE3WYKgY8uPOWQrgyr7ge
	JKhXwuZkam5YeTeyR2I4mZnzJTkH9N0OwiTiGdQUU+IWATJPkih9C4fA8Q/xsT4sjOYg48OyYa3
	UwikQd4BxKEHr5N4=
X-Received: by 2002:a17:903:19cf:b0:269:7427:fe37 with SMTP id d9443c01a7336-27ed4a30e5cmr15294345ad.29.1758755886478;
        Wed, 24 Sep 2025 16:18:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/ebc2nsMmiv2HiRq+pX9LoY8aL3IaOeMJamEwP6YOIDPpr1NOVTR9Kz3Lld5O8UMyUW1n5A==
X-Received: by 2002:a17:903:19cf:b0:269:7427:fe37 with SMTP id d9443c01a7336-27ed4a30e5cmr15294185ad.29.1758755886088;
        Wed, 24 Sep 2025 16:18:06 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cda43sm4321385ad.25.2025.09.24.16.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:18:05 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:17:47 -0700
Subject: [PATCH 2/2] soc: qcom: socinfo: add SM8850 SoC ID
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-socid-v1-2-fad059c60e71@oss.qualcomm.com>
References: <20250924-knp-socid-v1-0-fad059c60e71@oss.qualcomm.com>
In-Reply-To: <20250924-knp-socid-v1-0-fad059c60e71@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758755882; l=640;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=ZEV7aGV8kcTDQaybr4hw0p9WmY5zSMtxQK7hwQf80Dw=;
 b=zth5W42Al/7f1Okdmuxog3S3+pBB1bVznskBCvO0ksH8KHnsqnyTkBRv71HYL5DcipSv5Tryn
 AgndvSTEu4KBlY2EGBfC1/oooKqQ88QBlNu6amlRhyNw+//g+krP3pI
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d47c2f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=SCjz2f6kJreciZqEAHEA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: m3oWR7oo2ws4naHSMK5ZveEjr8q1feHq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfXzL03LlK9tbrZ
 wu9tGTXZOjuohikWjeSqDUymm8gBGCCeAFxmyEM8OYdCloDjDfNZDjSJ6tfbl6rJCGi+ReDL6bO
 dQpByfYVWzfyHKvwztWL4L4mklCMU8zJVzYRKAH/PDs45KLrRZzxOzH953vyZX7crV+l+/2DcGd
 blI1gFc0GAlgMYseqTKNmY3KBB6cT2h2d56nD/c9eMZ6DpAy3qIehQE/7C/yQkXQg6nN7XXhLZG
 dI/PgR8KgZgRnUCIJnCRDN3a2v6I0SFfT05GPTihVxfgW6ZHI9doHIFkyy5gN4PRMxGHu/hfPt6
 YFId2ODrLk7GZVvTSHVgYNgVfsGrknnyA3IU1kabTsoHpKzLHmus9GbN74k5qxXDosajcMwksdo
 Q3aI5Ry+
X-Proofpoint-ORIG-GUID: m3oWR7oo2ws4naHSMK5ZveEjr8q1feHq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090

Add SoC ID for Qualcomm SM8850.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 963772f45489..a2e2e15b840c 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -461,6 +461,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(IPQ5424) },
 	{ qcom_board_id(QCM6690) },
 	{ qcom_board_id(QCS6690) },
+	{ qcom_board_id(SM8850) },
 	{ qcom_board_id(IPQ5404) },
 	{ qcom_board_id(QCS9100) },
 	{ qcom_board_id(QCS8300) },

-- 
2.25.1


