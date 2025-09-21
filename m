Return-Path: <linux-kernel+bounces-826037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2218B8D61A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 09:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBAB317F000
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C093A2D47FB;
	Sun, 21 Sep 2025 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pu5wsuXW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B452D3A65
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758438704; cv=none; b=RZYMjRNOvv4DZG0pg0hJyvXIrAwjz4vzn5Py8tIHzK7LuWibt8SswaJkaND0aIEOpdLpleaN1jTNHvzhnDBeuSqCj6f3SHikQf1OcE3y/hKh9C4nHOf53wsprV+TLdfSF98i34ijCgy/Mjsk/aNemM6eoAKlu+ftleGaum8YEwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758438704; c=relaxed/simple;
	bh=1RoAFURhJrvly7ZLvTZU/OkE9NnQj/ClSoO+/ODqWqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phN3JzmXTDUblrhGbT1Wf6BxYDWFD8MYUzLTA3Ffrt/fSeClYQztJXcLDLQKvOW0B6PLcGofVZ4kaTBbSPZfdRw20NuKI3KzG9Pvz03c6WAgmp1bGbHC3MZKp6nI6R3Nw6UJm9JYwWJMsZbHz9qGh2TC6wnfTDPdX1aX9YKC9FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pu5wsuXW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58L3hYvg028827
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ejKCJjXaWa+4Btg2sDOmh3RzkdRjnyELJjjh7uxooLA=; b=Pu5wsuXWV91TvvFH
	mi7vISt3JRX+HX1X4G6qbgrtQ9Zln+gSoRqrdCMuef1gfEjN05mRYBH274oR4fC4
	EivC9oIvEVoi6bRd+SrQttgDwMnc5KV4mKRyDVjlsCvtCzJaNq4mg2ByxvmfjdYq
	p877KX9JVF4ue8/afEcVC0d99pp/DQCKboIRPCE7oJWOT/TazAZ+/zEVFloOtpL0
	W9WgZpipn4pU0BHlLWIComEOOdxxxfS7TLXAWy06c2ZWTNXrLpTyhNze1SGGUeKn
	aGQP9zN/zjAMnDq5yb/UTMa90AiogotQj1Ar1GLz2S/rox8nPQTfrSf/HZaihScC
	oPpd5A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1f9qwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:41 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b7a5595a05so72182061cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 00:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758438700; x=1759043500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejKCJjXaWa+4Btg2sDOmh3RzkdRjnyELJjjh7uxooLA=;
        b=vlcggBTB9HMgz+CSdru4vwReQTBKNUY3dvrSvRnwf4GDEn/Bp9porIYCiu1I3IhD8e
         b/SZmd5FuUI3nN5cJOUxCcyNtrz88i98GUtb2a2MedpIVXk9oQh6Bd0OdkA6ryEcZLne
         G7Wbgu6MM0gEC/SSrFkntziRdpT4S8lf1+aWIx65PIF394MwLn2UTgAWbotV8w02LUQm
         HZb/XoE3kEfT2ErlTsfcd8QH+EcV20+P2GV92NcEJlmD52jB6Bx3+LU77Cqq3LwAisiU
         xyLnEUJhauS5h2qK7EfyO3gd+o82bGT9BLsayKY+hOdY3RlBrvwvBoMlZhSBjDQJLmtx
         BDHw==
X-Forwarded-Encrypted: i=1; AJvYcCVOmc0sODzbZWzo9vLFjg7NVZIIfwBn+Hf9RExsi1G4aXmDuQrJVFQD9kk/8b1r2zx9g5R/BnZ32GZfYIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhIAtoAKrnlynK4nZd68KkpKFWQtbstS7DR+pMFDXiNKVAOxr0
	T+9M7ZXI/XWAteOzBxyW9IcM/cXO2UlR8j2zHJdtF8S0CBkVsrUCC2Iq/PBmNWmXCv27iCQf5+Z
	1ziUDi9i/n76hiJKiGd0RKETrkk0Mf5yRhp5CmLSw7Jdbijl+f+4FEb3/Nsw8kxTzleU=
X-Gm-Gg: ASbGncuAjpmsdyA9cj7CpeWIZvS4TV4ZyDwlTQ3WdHCCNZu5VEl8mWP1l9u19Tb8CaZ
	hE9wCKXdJGqc8bClDcW3WyFRoJAw6ThiuLZ83ZWCGTw3EPShSXdh51a/3GPwl2bltdocPI/c33x
	4NxcYa2p/NMjTN1F7Q32HFTUfGonUXtCVkG918ZHYXptf8xubYBLU091q5xgVZKgJ3tXdgbrLa2
	gzUaeesmg9Vx2/KVmqDS16QPhza5T/Ov/doODWpeB2WJv4d14fb5jU3wkcZBwflJ38r9UPOeJon
	xnWEwHLnjuJAQfpcCN4ioWTtalIg/F3rmk/7hByTQbQh0iDn71/7aP2jn+ZeFFuM18BXvOz5aXs
	CfmGzI3A434StEyXKB+cdIYGyoTeg28BrjH9int5k9wN4Dinus+8T
X-Received: by 2002:a05:622a:8c5:b0:4b7:aa99:5449 with SMTP id d75a77b69052e-4c06fc182d1mr114448091cf.2.1758438700533;
        Sun, 21 Sep 2025 00:11:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbEffiODdDcEV6/sySy7mH2Tl7Xwz0TgRlTuJxwJiCt9ulkuemj3hCOkK4O6r7hzICYNQuXQ==
X-Received: by 2002:a05:622a:8c5:b0:4b7:aa99:5449 with SMTP id d75a77b69052e-4c06fc182d1mr114447931cf.2.1758438700131;
        Sun, 21 Sep 2025 00:11:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57e06875c2csm144031e87.4.2025.09.21.00.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 00:11:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 21 Sep 2025 10:09:20 +0300
Subject: [PATCH 04/14] arm64: dts: qcom: sc7180: add refgen regulator and
 use it for DSI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-refgen-v1-4-9d93e64133ea@oss.qualcomm.com>
References: <20250921-refgen-v1-0-9d93e64133ea@oss.qualcomm.com>
In-Reply-To: <20250921-refgen-v1-0-9d93e64133ea@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=1RoAFURhJrvly7ZLvTZU/OkE9NnQj/ClSoO+/ODqWqo=;
 b=kA0DAAoBizyKPgIpKNUByyZiAGjPpSGhU3kG+04h8mDK7HnW5wHScIkebZ3SE0c5PWUmnJaWV
 YkBMwQAAQoAHRYhBExwhJVcsmNW8LiVf4s8ij4CKSjVBQJoz6UhAAoJEIs8ij4CKSjVCtAIAIVm
 6/Hf6HGfB33mXPfDhnnBwrR/6PmBMneksnlEduC3h7QdfGL8t0RHQsAjoTM3CgbGVK/I6UPiHRy
 typkj1suNShGktdYCXxR3bgGgQ7yhUKooU/gVZ2ETgwbJipffo86TdHu1tjRSrFGF+U4IBTmTFd
 mwiBJBnGdwMMINEpFmle5SjJDUa8ORm8vMqcuqYBQ8S/dJDDUuhYWCkpfS6kHOpqq1jb3W1LRyU
 r0PU5OLe4AUMLLtCtCmAvcZSfP5MCONG5HEtT7scLNrl++USYfW69e6n/ZiIzHWzLcdd3o7Iqg/
 SmIkthKvA1ccz0Jz2ZAF8ZD5GnVLLfxV2tmGB1c=
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: -8lucusnfOK29BGvpsfGpW03HC7LJuID
X-Proofpoint-GUID: -8lucusnfOK29BGvpsfGpW03HC7LJuID
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68cfa52d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VWJQ3tB3OeTIR7vIxygA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfXzDcbHDPLfUgY
 witcTcPqwpNMecrVXBXVcqQ5+PkFsM1vzdMeRBTuN1aW8CtwadofmgSFUXtBui1FSTlYqTVZ2wl
 XySxhxss9NhvpWVBhzB+/s+IaBvbCnvD8gFuQCIAy88dLRvl3tqDi5NQ7odol8VjDh5/kfd4axy
 f1t5H0MATg/1RAs99Oa+sWHmFwF0mtgwWrfC5jpzmiQYCK3pc5oNjglfTW3tzxQxQdtgFG/ILPI
 KBQbWdMPZdsLTG+g4JaN69BzH+5MjN8dM90mNfLY56IHwRCEb+AiWilExwOZSQHF5nnqeeJkxbG
 6o7biYdaBgWQ1b+PrMUkid6pt4QvIbYwfisMM2+zzufr8mdxfWlnExBX0dNZKyKhLMQNrrYLbWv
 06D23Vt6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

Add the refgen regulator block and use it for the DSI controller.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index a0df10a97c7f8aa5cd468c8983e74256490d1d06..a47182994c564e036dba25c772454320dc41cc7c 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1474,6 +1474,12 @@ uart11: serial@a94000 {
 			};
 		};
 
+		refgen: regulator@ff1000 {
+			compatible = "qcom,sc7180-refgen-regulator",
+				     "qcom,sdm845-refgen-regulator";
+			reg = <0x0 0x00ff1000 0x0 0x60>;
+		};
+
 		config_noc: interconnect@1500000 {
 			compatible = "qcom,sc7180-config-noc";
 			reg = <0 0x01500000 0 0x28000>;
@@ -3332,6 +3338,8 @@ mdss_dsi0: dsi@ae94000 {
 
 				phys = <&mdss_dsi0_phy>;
 
+				refgen-supply = <&refgen>;
+
 				#address-cells = <1>;
 				#size-cells = <0>;
 

-- 
2.47.3


