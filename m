Return-Path: <linux-kernel+bounces-882745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC8EC2B4FD
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3FB3A64EC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2512FF678;
	Mon,  3 Nov 2025 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AzmxfDJg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HBrF9U4w"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DE8303A39
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169026; cv=none; b=ix7kIt/dd/7IQsCx7/RDp9UJc8FIHA3lsq80vZUymf+IaANWgr6befSotwxWPiC7o3+t/FGqng6QQzi118pqtfIcfrVFbpXEqKwLLU9tD3zyVhXQlzB4MjAVJfppyVnWlmTs0wdnFtNhi8Engy62Xgj/Aaql3eMaY0mWCK+G7OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169026; c=relaxed/simple;
	bh=kzVzq55hPaZEMMT0bkRyeQXFnMqIF4cICVegscYkqDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Psac4tIssLIzNhAdmNQ7uD+B+hIJzNNXRTSUP7HE3NSMbyk8HCBFekBys1bpThLwTSLeQgi+KX3x9bCGSPXVyKu8oHIklV2CMFZyDUeSmvHVyo4HNw+yFgbk8WEsKxEJ7D7EvwtUk4Xp8/pKfdG8FPEJUr/qK5wGELZj+MpfDcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AzmxfDJg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HBrF9U4w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3ASAFY2891260
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 11:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xPgpBZkcCfc/5yJhPRBclJFGVMHhQ9Fw7lxzGQIus1Y=; b=AzmxfDJglgWecciO
	R72S0QQcBN8ODO0R0cbcpd7fdOkBamJLylkz9ucrvt/mpdGLPfBZuoCtBs8zVdxm
	1c2ZEBO4V92qmom3IY1smKZNrffruL7feg3KUDR73IEy75eLaO9GKm8OgX5GRMn3
	Qg+u7Fl16/g2IJAWE74UaS6HexUqoalHGRqwVneTOCPLXNIbEfjRGsaQC/lPlL/A
	cp7DA1BfEIuo3rciBy+jkxWwBvz11bcUAswdXLpS+R7rzPHdllc6N7ssLzEVkpdS
	KOC0YhybZO0M4XSsBUWYcfzYWF124VfdGA0nL9+zL74u3JapiNhK5q3ahY8PyU+7
	fT0ZjQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6tnrg4yk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:23:43 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b99763210e5so1056755a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 03:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762169022; x=1762773822; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPgpBZkcCfc/5yJhPRBclJFGVMHhQ9Fw7lxzGQIus1Y=;
        b=HBrF9U4wBVH76TRB1/o332HNS2VIo5qdNmY/680wspF/fimTKukewftaNwAs/dEFHQ
         HtcPJo8kUKS7Qkl/KVX/wsf67zNaHnxAOx2fZ5rEhagF+Cn2IlyZmXOHaEVzQUkWdZ37
         wTbGJZekU5ohkOmK223yo9Vo2RsZLfrIVu/rlNrRBxsHVz4K/vUHbhzDrs+s07QyV0mT
         GiUOkiIOadKzMLIN7HinUt/X9cO7pKdH7P58a6rSNUz/u3Gd9XFdUQTTNt02a92jFLoY
         ZtgepF1fmPMPQGak0sdQUC02Bxsz4oiBxJdfMyttmADvXfBHv1e9uoTpbXf6lvitPy3a
         cg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762169022; x=1762773822;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPgpBZkcCfc/5yJhPRBclJFGVMHhQ9Fw7lxzGQIus1Y=;
        b=D8IcaliOLNwXPXib86720/xxCfAVKIgQf47vFsbaBB6hW/A4f+vEodL+Nwf62xqTRx
         p8Ju/f3z4Jp87onmp3M0t6Ldbmy3Ufo22vnrtPLVUYQ0wtD6+gUs9S9UhsmE7rYOMiUJ
         PpAlp+PLWQC3uOwcpReNOQLD+iX6bmLoQvXDMZv0ECjsrSLXHtjsGckkirESIKeqbpHE
         nNVcJA1s7NtawLV4BXc84SYC2LyLfO03FSdMawnIwKY6OVrvP92Bfx6ZGnOEYS95A7H1
         E7OtsrW+bBOK1qCrS0LIBBoy6EwkP4LV7ijdOIQ4ok7EHbad4dotA+ewOEU+vYF8p7Ov
         M6rg==
X-Forwarded-Encrypted: i=1; AJvYcCW0MnHpWasMK9N3ZglD9Yt51tBHaiw+ZHG1SyzpH2gwR64Ikph+xoB8ivRx08Yw3CoqmH2oV3TR5W9K1ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfXssYxVgGC3PNc0t3BLoJ8dKb5ckNxF1m01H8fO4KELELd8Cg
	tDQXeKHRJGjJFXJVP9bBExG6cvApboDIROkfWQQVJqFwaHS/j10p1HtxeFrdNgdnLlDSvtQQgsM
	JuTMmkwOgbaxUpOUEQSeQ/hmNBN/8jjpV9dGp6FMCLZAfDUlwpCeWXIJFhq9BOOlNiTE=
X-Gm-Gg: ASbGncue/llTOCE/+S0Oq5FaDCSBqLbN335IPoUWXZ+exBEU7KhC0mnvyjVkWrEeRVG
	/sptJDlh8BTBCW8Um9YzWkTFJsUg2C9i0nZTUwzAKxzKUxrlAx/LuKTmYa4rb//KKBof5uxWBxH
	IqB5A/10ZVyO1yjFZxpacbcRo2dFHYtvpAF1VZNb+xWjrx2Sn1N/BaBwAfux3PVc7ABkSS4O6xa
	5SzFpUurTypzP06jTyods0hJ1+TNOitxepzwpG60Y6v8LixQxzEAfqx0RZm9XIUd+UKkzTpYzcz
	HUbtJ+Q+5WjSo6eS7brR855DNNafEIBcZd5TkxLaZwz+ncUl9ajOe8UbYSGWtd2X92+HU6X9cv8
	mYTo8rcwAfU6V+teYnFaI56cls+A=
X-Received: by 2002:a05:6a20:3d8f:b0:342:5901:fd94 with SMTP id adf61e73a8af0-348cab845e3mr17551245637.13.1762169022277;
        Mon, 03 Nov 2025 03:23:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/mX8xUMYFZXDWz2ftAuZOGk5grvgULVUNv69UndnUEZ61TGfBIIn4/CSFGIJvQzgUfk8Hbw==
X-Received: by 2002:a05:6a20:3d8f:b0:342:5901:fd94 with SMTP id adf61e73a8af0-348cab845e3mr17551193637.13.1762169021631;
        Mon, 03 Nov 2025 03:23:41 -0800 (PST)
Received: from hu-kbajaj-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93bf078924sm9838762a12.32.2025.11.03.03.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 03:23:40 -0800 (PST)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 03 Nov 2025 16:53:10 +0530
Subject: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add SoC ID for QCS6490
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-qcs6490_soc_id-v1-1-c139dd1e32c8@oss.qualcomm.com>
References: <20251103-qcs6490_soc_id-v1-0-c139dd1e32c8@oss.qualcomm.com>
In-Reply-To: <20251103-qcs6490_soc_id-v1-0-c139dd1e32c8@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762169014; l=711;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=kzVzq55hPaZEMMT0bkRyeQXFnMqIF4cICVegscYkqDw=;
 b=SqT6Sx7xsFCPAh3VWjSHPhsLQpTXN3wYAe8SdedYiYjCBEsq9/uA+UsSMuVabU8Ohd0oQpOcr
 tR/vTBGJqPhDl/qariWCdNngbAPzCsOcRSPv0n/Ls6I36dtkiwijPzG
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEwNCBTYWx0ZWRfX1BPPvb4xrBx+
 QAle9E+YeIxLuM6eC6XQHUtl+cv0jcVTEUq4GKaDyF7odmxUito6OW1elGmBd7VrSyXGLYzEr2J
 ImAFaFLH2ID+DZLsGtcNeSoxOTzuhFaAYjFG/2NoFmTvjLyiIbKkhIbRigbfsheOO77ZuboTOqb
 3HI+HyKYKVJ10/43tEiYsu4OsMrL7XFyS0F2x8zpJ9ZsRitn0SVrUSch1N+rT1s8nW+20E90mb/
 kZbSPzpPNtqqAYPnNPc3RdpizFE2Z4nPRq/ng8pBh2MU/pHsFRtEuQvEKTwuL8Q9dDQuhvU7p9V
 u7pS39dKHk0DuEhXLFuDuM9XAGqZpTOxQ04GawiGd3COO0uT+aLPqHXHRs3fyokh1nVTodPsbpT
 dws4mze2MTmp8Jfelv+qo0F/wD/Jjg==
X-Proofpoint-GUID: qfK7Up3Qlt6zPd71Yiw1qZoyWclwnNwh
X-Proofpoint-ORIG-GUID: qfK7Up3Qlt6zPd71Yiw1qZoyWclwnNwh
X-Authority-Analysis: v=2.4 cv=BrSQAIX5 c=1 sm=1 tr=0 ts=690890bf cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=32hiEKHcz8XmdFUlZUAA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030104

Add unique ID for Qualcomm QCS6490 SoC.

Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 include/dt-bindings/arm/qcom,ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index 19598ed4679e17e6505aa879a4646fb77c146d6f..8776844e0eeb370b874f41063ba057d5ade4f003 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -240,6 +240,7 @@
 #define QCOM_ID_SC7280			487
 #define QCOM_ID_SC7180P			495
 #define QCOM_ID_QCM6490			497
+#define QCOM_ID_QCS6490			498
 #define QCOM_ID_SM7325P			499
 #define QCOM_ID_IPQ5000			503
 #define QCOM_ID_IPQ0509			504

-- 
2.48.1


