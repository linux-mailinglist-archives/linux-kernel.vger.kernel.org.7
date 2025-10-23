Return-Path: <linux-kernel+bounces-866214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB763BFF316
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BEFC3AA1FC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51B525C81E;
	Thu, 23 Oct 2025 04:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VHgGZLJZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0D825BF13
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761195476; cv=none; b=GTbRFjMkyx8EVbUnXwwImFyq+wBs66GfYIvYw5ii3zC+ZmHiDI+JvsxM9K85O2Vl85Qmnii8u+iHUGLujOwlu9/lhekdvSzRbhdL67GiZo6YuXQ30lVEVnim7n/DCFWVkBl3NVbxcVdrdt5SjTFZ5860as8kcEppV2Upjww4MVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761195476; c=relaxed/simple;
	bh=BWJCkcRPP96Xh9dkql3wSobHLig10eB1qb/PHKQyTNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qW1ZSX1X03rlHRaJXBUstaOeYSVMHzssc4AbFmZeaiT4wzYJ1pgKdnejxWoD+i5nEasJRbeWkIQDRqa9B/4XaEpImomfsAfpu33M2HiDlC0eFvFSyvVaYRbEhAPDV845DNkS75mnREeH6POzbUx1tqFqxpgMCRaIq0yTRQWHCFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VHgGZLJZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MKLadm019109
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EcjwNkGfwMCJnD1Qj6xY6Vd/84dcedItJ+DPktXYc3s=; b=VHgGZLJZCnr1XMwy
	mgtTMdtOgssMxTHyOFAHb2w65mP6DtUoCvNdu82qAs8GdLMEFfF/KbPM2tmSHGOV
	isySwCUVZLSc3d3XhoPK8b5RgCoBDcRMw3e3TxhasKnUVWQPaZGD188lUWeT8c6U
	Ma77gH1Rmd66UNlywmDkPTYVQk6HQRM+clqWvtF3t8ourjl8ROADfW+yJilbvP7v
	/i5/kgBCpLoa48wAABxJ/4ve6gHFsEM06Xa++vftNmaE07CzEDdcLFVGAlocmJfR
	vE059nkl9EiQJ/CRhHTlVeHlA4Fo1YNUPgy+fupBPvqAsiR8IZXdBVndYnnVuRPD
	VTq/hQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y67qh145-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:57:53 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b63038a6350so1182323a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 21:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761195473; x=1761800273;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcjwNkGfwMCJnD1Qj6xY6Vd/84dcedItJ+DPktXYc3s=;
        b=NeuuUREaMYB5ZHm7bMBouU537Nfm4PdlacKEFLMqZOlGaMmJCkQXlhxsWaknRb0M8H
         DQuypBr0iVoPFPU+prEYb0nVJyPJPoOBDU+yAEIYE6F1irdFy7iQ5Cbq/IdZlVICuHMI
         M/Vc5xWoinV3R4gVPQts+9343g6S7clxmEoOkAOr0B/2CWmTZwgqr9tM8jmqhzG0ponZ
         g5KTpzsd1w5CqP31X1gSwdRP8RZeR+4+C6EplqUK7/bYA+DPgv7CNG2tT8tPk0rovEvW
         ZOFPNyjAEuLUfwpc1ZJeBaF4TcJ5bMLBTr19ELb5poijahjEnLwX2Z1Q+OdivGWM8aZe
         cIEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEdE3DzGtj1affku39Yr9RG5iPKY/Dh8X+4aFCOFzg201NyilsdWJWKK477pY/CEeLsy/QfSlKiput+rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoFKs9ylvWzrmQ4lyDEw1RvBTeNhweL2IK5OmimV7eySrwjItr
	S5WB5vrg/YVVViM4LjSrNEI7mZGZOtc1RAnQwS5NhN5+3JYgW2FuJqHKiuVX4MYGMdcBUM9neI4
	tjwmK89eapTcD3h6Jx+xvWfNqodY0G8mc/NV6eLdeK95vL7hmIGHHHeMxJvtJRaPIwR0=
X-Gm-Gg: ASbGncua9zVzaEaLHF/IjIBZ8LLWFJRClXD8ELogSdpNFWifBzKhcCJyF3uHcXWhMhg
	WMo9qH7CtHeT+lLEhtWv+UAYb9zlon5Tkde63Eg6avHMmSNndI5NrgNW9AzQ9bKKYTBlDPDw1MW
	FGMDOh1aLdIEOWDCeDbgSxjv4LgyhJYlLLmaQvFSH6gCueuq9GDidqDN64c76NzCm390TcY01CZ
	Icum8Rb1Sao5O6FaZakGPR+190mQHvaFm73l2u8Op0P2Gt5eBmPrrj8X37GEcnYYXYXAoPJng/W
	EjVWqwU5VFpLXquzC64m8+yNK03ZKuHGrmPce9v3nnKPmZCOCkiG5idvSrv2/SU8vSuAijTcXZL
	1OYEE41X1hq+2qsUewO+kgovzlFuq8Sa45fwqG7sFX4O8gQnjLA==
X-Received: by 2002:a05:6a20:d088:b0:334:ad99:7e99 with SMTP id adf61e73a8af0-33b6a5dcf35mr5241415637.17.1761195472703;
        Wed, 22 Oct 2025 21:57:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMTxhqhL+ktvwqE/YLE0iG/l3G2teVCl5Mj3JLXQrTPp6ntWIdAjtA5UiZSlixP0cbKprHZg==
X-Received: by 2002:a05:6a20:d088:b0:334:ad99:7e99 with SMTP id adf61e73a8af0-33b6a5dcf35mr5241384637.17.1761195472265;
        Wed, 22 Oct 2025 21:57:52 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb86cbsm814289a12.7.2025.10.22.21.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 21:57:51 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 21:57:37 -0700
Subject: [PATCH v2 2/2] soc: qcom: socinfo: Add SM8850 SoC ID
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-knp-socid-v2-2-d147eadd09ee@oss.qualcomm.com>
References: <20251022-knp-socid-v2-0-d147eadd09ee@oss.qualcomm.com>
In-Reply-To: <20251022-knp-socid-v2-0-d147eadd09ee@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761195468; l=680;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=BWJCkcRPP96Xh9dkql3wSobHLig10eB1qb/PHKQyTNM=;
 b=k6289RchbVm3PRam54CCkf+f1qp+jhTz2xYwJ7heEtyLgCLOuGoYSqHiiVQ6ROzjdExGR5SVE
 WhEB+9s5/UQDQaEINLMmfjhZ855lSCb2lCiyZSojsltmjwuodwJ6Glt
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2OCBTYWx0ZWRfX6fAuwg3YALVB
 u9fYjVTUWuDLD/VU2IsZlP/aInRhz60hvu1YixkmInHTEsSUXUvkqeGzGCEfep6alKmKGnhHJFD
 80sBvqfeY+RtL8gr1+dF+GO2jR7aFpjQDL5tILISfDa/DXyXzoBgqEMPmR0tuMId+5b04o4eXEJ
 MkLNAcURu+PNFngO/qGpcCTQH+bhNJxO1bIZMOh79Xav/RHTApEnr9HK8FY0GVtaQMBIMmIkGZD
 amZiM2z+VwFhq6r/g9QOKGwkLcmpF+vOTcbBMfYkMpr0L87cFvIun7JNvAw4YqYhItSI+Cbz2eL
 qG54mz8Okdb8BOmSkTVzyBuGiLOB2TsdQCIsK4GdpRj5rDHOgq+EextC+mU3cUYO52QMd1OjgDj
 IbgeSnh9sotWxN3Zm+GybDhFU9o4mQ==
X-Authority-Analysis: v=2.4 cv=LMRrgZW9 c=1 sm=1 tr=0 ts=68f9b5d1 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=SCjz2f6kJreciZqEAHEA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: tFLqdJiZsE6q-spcAZ_SUeKjIDZax-Hh
X-Proofpoint-ORIG-GUID: tFLqdJiZsE6q-spcAZ_SUeKjIDZax-Hh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220168

Add SoC ID for Qualcomm SM8850 which represents the Kaanapali platform.

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


