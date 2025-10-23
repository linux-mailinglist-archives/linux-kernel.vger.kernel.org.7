Return-Path: <linux-kernel+bounces-866828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB44CC00C36
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB47E3B0338
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D125530F950;
	Thu, 23 Oct 2025 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GeDdOsXZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386D830DED4
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219010; cv=none; b=DPztS+ZgkpZpO8kVhnquduCkZyW272aNxN5ZAtAU3UwCyDx7ljdXnEJqvaeC6XxlYcqzPxzZYp7ZKOec0GecWpS7Z9RcnMdX9Z0x9nD+Meap7gjyO3TQNNXbukZCLUSux7+hwz8njBJhUOFFMDHI0h6uc+HQ53YRV8itAfNWOc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219010; c=relaxed/simple;
	bh=Z3ZKjce1eNa7cruDaoLFpBeJDrv3LxfBcxi/KFd0kkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F0ge/3gOxAOr9QLikJG6sqlrOhcqQletSDQh62wNcJg+wfwpMFJe90N+3uQe3+XijsPzvVQHoBCnITPv9JIiWw7HNKcOaADf7hmnloro4dj+T/CXwcYy1jkonRBCdeM4CrRx6BwG9DhY/79gQwa69/NHLOFA+wl/1PTfEwTllaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GeDdOsXZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6f7E5032198
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=b8+bYrK48YE
	QxTGw52Zzv2+zkKybAeDpreZ+tSe6PU8=; b=GeDdOsXZ0bWN6rptcPdawZeuklj
	/d4Us3XQAZWF6toxbu7X2EV+U4avFCqt7Q9shrvi7UtvABjqoMdrLtY0t45koKdW
	FAWyZDtJujBd751D0evAXHLXwiuESAaWIlNd0hsttPoYK4GbztFYSFt7RtrHCoyL
	gCGb5CkS1zdNBLngdO1mUSE3DZpO6EBMnbEz5ANYP2IJEmPXO39wI6idTaYx35ec
	DMDej3wAVUMhejyLd+5ISe+1Lvq4bK4EpTrDStMtgbcdu5dSaPYh8roK4eQ2EAFP
	w3YdL4AdymWkR0NQsTLba6bwNdnM/t+f57iD392LSbPP6XFpRUAmJkjZkdQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge867n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:30:06 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-28eb07797f9so2757085ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219006; x=1761823806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8+bYrK48YEQxTGw52Zzv2+zkKybAeDpreZ+tSe6PU8=;
        b=Bia9HZH0L4JxP+KLh0xQORmEfxEHekepWgvta17botfj2KxFUehuZnKfJclSWf+oP1
         gcb5qv2Jk+cNxFwqUMcW0f5UPyVW1GZS1RLzDzRvyt2fCbYCzX299w3JbfHy+QMI31lg
         gYGwKqZG20aIbpJN0KVwsIuRkpUyx3WiXUEP3pP05/1mvpRh2fxFOKymKNiGzs4AXpWJ
         MjuIaqXe1TVGlAT5VWB7Euk9o521+vGd82thczNdgFalSn6CzsAzT7rNUnOKjZMbXsNZ
         tvjY2WVYaYKay0GeQAVeKkkmNT94csERmiCcirMC8fhofS6JrCDWw+b5mnYWLivZsRoW
         PCDg==
X-Forwarded-Encrypted: i=1; AJvYcCW0IPSm6mcLTBefG9ZJpmSwzR7hMn7Rj08kXxc7ZFA+WIv4wLqtHiq2g7qXkMEAFCRxB4mAWJSww74zsLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgVDI3PGk43eA6VDRZ7hQPLGMTOK3XUTLSYD/44TaB5j1RToVn
	Nvrl6/CCzT8wj0DuTGJrA1A4MIvIC+didWTrSnvVJ2cSpVRD3OBN7ork5w+nh3VhTmjnGo+bETC
	dHqSmgIscNJAdNvTXERDGD06Mb2j4ZvR1UW6WKRYuhhR7e36CvLstXS3+x++DEamxAA==
X-Gm-Gg: ASbGncsUhBx9V9wYSVgiDlEMigAN6VhGUN55WtkI00roH61jbhDcMxdRITYtXhT22OO
	0BbkDdURKUoweZCbNcPEYecAl9J26LfDGXqCCDZ/Z76651KBCrMevUotnPANvqD6QfiGZaPr1ow
	fqm3PhEOkACok5itXeRMMeRXH1wGqBRWfC8uOVFPrrHfQka4SUll8QZXAMLQzf8tkL/GBRcTWqt
	f+/cz5Ti2hOKD7ShuGcoHdaXQVxk9n+3Q8UvTp1/ch1A/4x6IxQPpoVTYReBfwJnQ9BWxk0w7kL
	Iyx14mWnO87Rrc8uRjHLO9d9WfzcEgRLaZMAgJBQh7lUypqOX2pv+/vD8RKlG5z6SEg7lnoynBk
	1v0ZqANvq1+iVHQriQgoxADh5+7EIuA==
X-Received: by 2002:a17:903:46c4:b0:290:ad79:c617 with SMTP id d9443c01a7336-292d3e50ee5mr68938315ad.1.1761219005531;
        Thu, 23 Oct 2025 04:30:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMBrkCvTO1nWUE4UYg/s8tYpYtZ7BQ/m0qwKJKLmXmKfeqgrsKE3F73O+O9t1ICmCNO90HOg==
X-Received: by 2002:a17:903:46c4:b0:290:ad79:c617 with SMTP id d9443c01a7336-292d3e50ee5mr68938145ad.1.1761219005069;
        Thu, 23 Oct 2025 04:30:05 -0700 (PDT)
Received: from hu-sartgarg-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e1231b0sm20438815ad.97.2025.10.23.04.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:30:04 -0700 (PDT)
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com, Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Subject: [PATCH V2 4/4] arm64: dts: qcom: sm8750-qrd: Add SDC2 node for sm8750 qrd board
Date: Thu, 23 Oct 2025 16:59:24 +0530
Message-Id: <20251023112924.1073811-5-sarthak.garg@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023112924.1073811-1-sarthak.garg@oss.qualcomm.com>
References: <20251023112924.1073811-1-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX7rGP0GG9eGb/
 aTUvRl69ntY5XHc4buxy+P0qYLQB1jQDRUFwDragiDikSYb/mWwZum6Svb0jlActtBDqDMdPLVJ
 jqvFaqmtKzUPm1AOe8/TNcoVuULl62FNSSp3eduHHucaLT+phQWR7qHDZNuQupFDAMaG6UQCayB
 /Ui6FPgGux/GHNRprAKl10udq/2tw6j9MQS6HOfeTyyEReVrGx5/mBzS5Cr6fezAbxjyWCIQ+Oo
 YN5Q1UPSH9rGhEn8JE4LY2UKSskRW+Y3omP+12xkOmfmQPPKaEs9IGc8DTy8OxzEH/hD0u4su3C
 ZZGtOfsbYoBGEpVWF+4nC6CtR87tPqbL4IxxKrVmQzG0KMQ5PGARRzF5fBurO1fkhs6jGYIpgYl
 6HOoPUffqBtVHv8a8Q5q9jhoEpMfvg==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68fa11be cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=53gy1XDxZ6suxgqcjVYA:9 a=zgiPjhLxNE0A:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: FBYOKmOA-Dp3dhXgyGMxPn6_NcTeP6Z-
X-Proofpoint-ORIG-GUID: FBYOKmOA-Dp3dhXgyGMxPn6_NcTeP6Z-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

Enable SD Card host controller for sm8750 qrd board.

Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
index 13c7b9664c89..8d018eef44da 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
@@ -916,6 +916,22 @@ &remoteproc_mpss {
 	status = "okay";
 };
 
+&sdhc_2 {
+	cd-gpios = <&tlmm 55 GPIO_ACTIVE_LOW>;
+
+	vmmc-supply = <&vreg_l9b_2p9>;
+	vqmmc-supply = <&vreg_l8b_1p8>;
+
+	no-sdio;
+	no-mmc;
+
+	pinctrl-0 = <&sdc2_default>;
+	pinctrl-1 = <&sdc2_sleep>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+};
+
 &swr0 {
 	status = "okay";
 
-- 
2.34.1


