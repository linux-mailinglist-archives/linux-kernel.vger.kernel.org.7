Return-Path: <linux-kernel+bounces-831470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DBFB9CC1E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1F3382DCE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03B82C11FE;
	Wed, 24 Sep 2025 23:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sg7vkLDK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18E0283FEB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758302; cv=none; b=Yyh8pAWzIYs3uebvITcs+eLVREUOtL4bCiutpyUgFohXP4M26dnVutuu85QTnjQVTfboCsGePFizn0yL2BBgAHC94HYH6YenZcTAgiIU0F7R/XygiXbFI5Kqql4+pFz2RPF/lL3Ghg+hkYkzWChtYGqzRW5m5AwCQJfDzD4X8y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758302; c=relaxed/simple;
	bh=JQHs85eAoQvA74JUQANSuBDlypyyegzPW98566v4RcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GELZ8PNkQsDtdGo9zIO2ZVxFo7dp1e+nf0BLzc1P2K8hdFTwIMTDqqQQsJ4zexAZMZKYGSsR46VaQAUAmXNLTifodNE5hKBtVmTu90YoVYrtQlO9x+LQinKi8Fl0d7xgb6nQrrNtNH7Xi9tukvP6r+Xi9rkovLTrXwWmBGPdTN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sg7vkLDK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODSQvF019919
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+OI2myA/HDJvzEyeSqpMmJ
	BCPyy2/yWqJYYoALmzipA=; b=Sg7vkLDKThmJcS7bG3mIjbQbUrytGvgNZsoI4b
	jV+s7vmzKQCw+dLbciHzOCItkBTpJbNRAD1M5dRZWqPqZpEkIYpiSrrjC/hVmeH7
	B9KsIZyJgadneD7zO+izigPTGQibX+q5Ca6MInehnd7wLClv8INxdMaO1WA/+vMM
	KIMC5y3cV0bL7RrWs+r2n23dgQZCjqab8MoV2IF91ewr1o/p4P+hjnqZTDPtI73U
	0IjFu2qQacFa0cKmI/1qOHc+wAlBr0ETaw1UZYO4nlHCC5VMZXQUMhBVi/n/D9nu
	agt3EYUNhK8MEzEY7gNgj1OfPM/0eqSXMW36qldbApuvniNg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdyapr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:58:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24456ebed7bso3567695ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758758299; x=1759363099;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OI2myA/HDJvzEyeSqpMmJBCPyy2/yWqJYYoALmzipA=;
        b=BwdnrIMXZ6+L4LmGzilFWv1H8qnO1tIVX9PSBtUKYYH4Iu6m6WxcKOal7avnndLnF2
         zAfxk2csPPWgf2Z/Fbq+sKJYGG/EXSC2q2EXZI6CyQQD/ISOK6qJ86KU6iLlDBPsEB2V
         B1Hh0HcmMil27hTgisvS3dMsC5dutm7tC3Ebt+rkrSTVIMM7hs3KHcW490NQv8hJ7XLt
         oZakunZhdksrHWb9wM3yxIqwbyfg3Urdwnyls9/jKpgMbNg0oetER5ih1yOycjAxA2hs
         P3iEMonaUhmYNfhj0EBv1F++Egjz661XEhkRyuupCJjoAItRdm4qOqmXGHvBFlhcTYaR
         3c6g==
X-Forwarded-Encrypted: i=1; AJvYcCXwF9Q088hqtSoAIfGNqxtrIfXL4JBKzd5URlpn7mZoDvDMWzIIytxGCo8oss35Minev5/nVC3j4LSfY/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqcsg2SjmUv2Fl4Dr4RRWKbkgASjkIiucIYcyCLifuyQooGceN
	w84CYAH4J/fg1PFqpL7NtXggWbxuDZAD+7OP4QUNfRYvqRXdJ1k3G5NeKVv6eD1A+N0WCkFpV/M
	VS65nmr4I6e2g/oQ/oY/hh1HP/+xw3JfxEV2TvUdrSnjClvWLW7qtV8LXd8OjzcD+ais=
X-Gm-Gg: ASbGncsz8VDj/JbspPpuLltJe/hyOFXXdObZhcwRHP5Mlwsvy1d2bAY0n1VsZNjAIzn
	acQBil0nOw2QIHxeiSM/R78t60aBh4OU95/mywhxqW9s6gGgxXC3VdNbS69lnddIR8ivgaw+jjr
	5Fm3VMu18YNBW8kPH1dtw2Wj6jwPZkxWbDUXzrvBdSYnRUC9KL5kszO4rkJfpaLge8pLFVJHZOj
	lr4HyrvZWXAj44pWUnfrMAFNXwYgeT/uyh/cW7KxxVNOxtvolrD6cPYQPD8Q7Y+gU8BDAEq1XwH
	04uzOhz2tpcSSsbVWt4mWHwbzChl3Bv29iDg9RyqrSyD1I2SXhdPtr2fOZbfobTqWzgfhhPBiZo
	sVq1XbioC2jjR8kk=
X-Received: by 2002:a17:903:388e:b0:264:8a8d:92e4 with SMTP id d9443c01a7336-27ed6ac9815mr7120965ad.2.1758758299024;
        Wed, 24 Sep 2025 16:58:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk35ASYn/t3dEBZvcuLtGXClEqWal0BIggBPBQcWamgNIDKOc7AZ9WF01T40wkQfuEPCw/AA==
X-Received: by 2002:a17:903:388e:b0:264:8a8d:92e4 with SMTP id d9443c01a7336-27ed6ac9815mr7120675ad.2.1758758298613;
        Wed, 24 Sep 2025 16:58:18 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69a9668sm4402965ad.112.2025.09.24.16.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:58:18 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:58:09 -0700
Subject: [PATCH] soc: qcom: pd-mapper: Add Kaanapali compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-pdmapper-v1-1-fcf44bae377a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJCF1GgC/x3MQQrCQAxA0auUrA20USl6FXGRmUltkI4hKSKU3
 t3R5Vv8v0GIqwRcuw1c3hr6qg3DoYM8c30IamkG6uncX4jwWQ2tLGwmjmMa8pHzNJ4KQUvMZdL
 Pf3e7NycOweRc8/ybLByrOOz7F8eKvrJ3AAAA
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758758297; l=1261;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=/U3G/f/oGqJBr8L7mX6FX3eckh2FYEjzKCL810qS2CU=;
 b=kyYLW5Pcu46Z7Q8gy0zgOL7v96F+APpLJS/fHx7xwbSvG5ofAv2fKtVpI6BgG5rjOw5k8HMQs
 h0aOQR0XWTEAFEOuGyvtytPdg9+CC/K2GMvAvGfhcUSR7w01x+uGtGh
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: ViR-qdfdPW04gkqXiW09AShd4Y3XoZD7
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d4859b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=X48u0K_GNqLc3HHWDA4A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: ViR-qdfdPW04gkqXiW09AShd4Y3XoZD7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX4YIXaxgGB5Hp
 KrN9jgtqtUSBrWUaMM0pj2Z3w0gCYr+sJv6WK/q5UsxXwuKX/MG90//83xpbkdb0X/odqBpTp1K
 gNMoYLRoIE/d+O81ql/y6r0PtEgdHBJuTjqwpOXq2L4+BsZipmQSGwh4NthQWWo9+KSFSdec+zf
 5rn+XkPzEWcnwwgAd3R5GQqpalM3FjNbPv+JBOg4WsNqzXb+hKmKJhPbaiD/BkjQT+1ChcqURQj
 UX8gq5ySLhfCJ6H25fn5BFRYM1LhlPgAzVw64ZCRgoNjj0w7iQOfkpXaNQUmJmYnRgqvnBkLS/c
 94/hirEB4vZRFdXZBuy63Y5QngCxMukOyRHM2+adl9ivbzaCUINrgH7eRPfUNgPi74Cffu1X9hF
 Fqmt5C+M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

From: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>

Add support for the Qualcomm Kaanapali SoC to the protection
domain mapper. Kaanapali shares the same protection domain
configuration as SM8550, so reuse the existing SM8550 domain data.

Signed-off-by: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom_pd_mapper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/qcom_pd_mapper.c b/drivers/soc/qcom/qcom_pd_mapper.c
index 6384f271953d..bb2eeb955106 100644
--- a/drivers/soc/qcom/qcom_pd_mapper.c
+++ b/drivers/soc/qcom/qcom_pd_mapper.c
@@ -552,6 +552,7 @@ static const struct of_device_id qcom_pdm_domains[] __maybe_unused = {
 	{ .compatible = "qcom,apq8074", .data = NULL, },
 	{ .compatible = "qcom,apq8084", .data = NULL, },
 	{ .compatible = "qcom,apq8096", .data = msm8996_domains, },
+	{ .compatible = "qcom,kaanapali", .data = sm8550_domains, },
 	{ .compatible = "qcom,msm8226", .data = NULL, },
 	{ .compatible = "qcom,msm8909", .data = NULL, },
 	{ .compatible = "qcom,msm8916", .data = NULL, },

---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250922-knp-pdmapper-7b1c3acf74d2

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


