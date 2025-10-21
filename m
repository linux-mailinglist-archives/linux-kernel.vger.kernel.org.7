Return-Path: <linux-kernel+bounces-863712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F40AFBF8E75
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86E104FFFD9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CCE286891;
	Tue, 21 Oct 2025 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KrxcpZug"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FCA28640F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080948; cv=none; b=qQGkb+r9U5nL6kAu7iF0VKA5H6F+iYX73xjFoc4WdNv7OZJpj8SgHTlIsND+C7n+p8YbV/n/vKv4wGF853s3dc68UxWqw4bWWGzcBxtiClrF+LQn0ogcL8zZmpRu9PGbopSxZkDVf6eTDMaI8EOVSr3e4ldzekPjgeNZH7TPlPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080948; c=relaxed/simple;
	bh=C+tkM31LHQwx5rXjve3N0QzxSt8/3cY/SYv5ANIxZgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MYp/cfqB2o4A9QZ4oZl+cgW4WJ6yD5zxvsq6oeJ9P84gItsSN6qZsW568+VIO2GCYnD/4N1vHryHlaaEx39SrFxIUiC/aDNcwgBX86ExsmTlXKib+bWlL6W3YCnrML/amjQ2Fn1z8fV75Us5xOsMHjQUb5jG67sqGmhh2pAdG1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KrxcpZug; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LFI5a3025477
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zuiw9MxlaUMJ5WPI1xlT09kBhpRPx+9WZaClKq2hKfk=; b=KrxcpZugMDpMegok
	4Iwsqxufok5+UZXmDUfu9tjJoaxPqRsB30DWVDygw2nQ1wCuva3j32h4MIZzRA1o
	MFGAVXpTtIBFMAPzW1DS4kRv/1DUwuWMdZY1Rqos87s91QMDwZq58nTh1pf7LMEA
	5Krt9S/ev6ATgBbXz1luBS5zPW05dmcLON531OivWiJD2RXEOHUhac4GdI9ZqVhY
	4UDUYLW+/j0r+s/8Ut876cWa/eeZlTKKOwdmtZblY9VoEMBjD4SExNZJqDSHQ1/9
	6n6DkcbIgCh89XRQI7Ui+48iVZE0ObPIkdros13V2YhmBXXkPd0bjsqd5i9TbJVx
	7hEMFg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w829kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:09:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33bcb779733so5256070a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761080944; x=1761685744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zuiw9MxlaUMJ5WPI1xlT09kBhpRPx+9WZaClKq2hKfk=;
        b=dBE+JvshanPFeIS9AceeOZmzA6oaRGj5A7KF/fcw2BaTTOe0isbhF+59x+EJk7Eu7v
         xDyHMeNAA0p9X4n1JeFrPvKOf8w9miM04fohF1ZvBxYKoDb0S4YNZZDlONkYdDY4CzYW
         YFwHst1Bl3i9UNAq2qSeA9Af1iUbd58MJj4diw9C8WTAuSzrR2+RTfvyuNHVGRrUt6cl
         dwO9dWYgYiU6XhrQ5SHGd8DdOtTYiJWfOu2fwp7zxHNmGZIyBWLA2r8miMqHF/Qz1TB3
         A/xFTSaqyn81eCuugMXAvCYSG6NrdFPLGCr/Ud/nTd/34diizL7ED+0zgRZ2Mt3Ns/as
         PzHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq5/TTdkBnpl0LrdKPbqp4b2dkKXKeFCucfN4X42YmZozfCY1974JO4Z2BDVuPRVEnWD5NLq5UYfHs72s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc1cT2A+GrnfVVwZCQY7dWKVXiau4dCFzfeY6UmPvrEIfR0OcS
	4sOdV9CfUoT0U0JVoS8p3VKi/J/CO6Ik6sN9S/xoiCTEPd58O3/CDzRgkbXU5hmljhwVOLmtAk8
	CvR5AZ/K1hqac/4M9UWO0wXyqY19Jr7lTRgapsWP26MjZgkGoxf3mt9P5emLtEOydrAk=
X-Gm-Gg: ASbGncui7TjU81BRUfUBRwnDQQqFPEPsqeOUw+LImhkkJ/FeQ4OFiU/aOKxWyC78hba
	RZUWZd6E7wkYc/BmgKnZS8U9bAo/qmpM+p42nJsDyFWfqh7xIMKdmHk3pDOSrI4VQ6PqDbYT2qW
	at1tSngp1G4G+HHVKvIMbxSzuFWDB/d6CKcVFwyoYrBema03Y+ZZgsgzmmBQ87iVaqsqqvwKShL
	lea6G9BNGk0IwtiS8bLJgL2oeK+nqSoKrzIiyQm+71xyElNMWCDDsO07SaCTEMbjhio1R+F1Q1A
	e+Yd33RcirYdLxWA12uiSGuGm4ylYVzbduLxWt4exT1n2yBQwfWwcCHslKKK97XVoOaaRdEwdzo
	N9a3E4FUfV7TmWowaRANGobSzBMi7edVBA/1imKIPkops5WdbuHKu6fA3c/p2
X-Received: by 2002:a17:90b:2b86:b0:33b:a0c7:9ea9 with SMTP id 98e67ed59e1d1-33bcf85aabemr20406694a91.3.1761080943634;
        Tue, 21 Oct 2025 14:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfu+Esq266nfpDemo/Hu7oDDiP+Bc4u7LvOrdIaLaWlmGz5cns41MqdH0lKo4PH/hKAHJgDw==
X-Received: by 2002:a17:90b:2b86:b0:33b:a0c7:9ea9 with SMTP id 98e67ed59e1d1-33bcf85aabemr20406665a91.3.1761080943132;
        Tue, 21 Oct 2025 14:09:03 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223c813fsm489833a91.4.2025.10.21.14.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 14:09:02 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 02:38:53 +0530
Subject: [PATCH v2 1/4] regulator: rpmh-regulator: Fix PMIC5 BOB bypass
 mode handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-add-rpmh-read-support-v2-1-5c7a8e4df601@oss.qualcomm.com>
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
In-Reply-To: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761080935; l=2890;
 i=kamal.wadhwa@oss.qualcomm.com; s=20241018; h=from:subject:message-id;
 bh=C+tkM31LHQwx5rXjve3N0QzxSt8/3cY/SYv5ANIxZgY=;
 b=mGIOOy398WUZlhh3Y3+Rd3MKy5gP2BRCgnMs54Xx2ZX/rRoVp1BZz8zw7wcE0P5lGyRQ1GXDb
 WsNPd3Ms12vBXK+EfqcKJCeK0Qgooi6kZ1qo6I0twUejbom4oRCZ9r+
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX86OM9X03hs88
 ipZq1JGp+8OX58lzeKJGsiUw41RdCBzGi2y6uL83t2H6LJDgTpIjOEj+LdwgxhL55XmHNZiaGPP
 9y3LY6uCMA0zRI+HcHHEZj4vs4jHO2evLtL+Iyt0H7N4ha3ZRAmlqs98kszpraUpZd742pjlbD6
 cVEeXhODAV+wnkC1PVO8fHlixMFnUhdCMtCiETGhJO1zohNtrqjml9E2NPXhdTMJV7vH1M/lVva
 VwUMWje4gsJzmiEvPiFYyWc6sfmhcvrEcnI9XwgDmzzMYbII3aF+mCXuTENHKoiraTptLT5HScz
 EjTXr9fWzAF1vrkXLasahrOUfW/i4ta8GYKmcjnrSGVGB+FAvH7why2BMDY2inLq6n43/QcfEwq
 iBikwMC1anzR9uvEo8OplGQIDNK1Ng==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68f7f670 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=l6s6GTuuRFQeQcd2MEMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: TQBGf7TzERXyhc1UmgiujnbQGXHGAfAY
X-Proofpoint-ORIG-GUID: TQBGf7TzERXyhc1UmgiujnbQGXHGAfAY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

Currently, when `rpmh_regulator_set_mode_bypass()` helper function
is called to set bypass mode, it sends PMIC4's BOB bypass mode
value for even if its a PMIC5 BOB.

To fix this, introduce new hw_data parameters:
 - `bypass_supported` to check if bypass is supported.
 - `pmic_bypass_mode` to store bypass mode value.

Use these 2 parameters to send correct PMIC bypass mode that
corresponds to PMIC4/5 BOB regulators from the helper function.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
 drivers/regulator/qcom-rpmh-regulator.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 0a561f1d94523bf479f48e8c2062f79cf64f5b5f..947fb5241233c92eaeda974b1b64d227d5946a59 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -111,6 +111,9 @@ static const struct resource_name_formats vreg_rsc_name_lookup[NUM_REGULATOR_TYP
  * @hpm_min_load_uA:		Minimum load current in microamps that requires
  *				high power mode (HPM) operation.  This is used
  *				for LDO hardware type regulators only.
+ * @pmic_bypass_mode:		The PMIC bypass mode value. This is only
+ *				used if bypass_supported == true.
+ * @bypass_supported:		Indicates if bypass mode is supported
  * @pmic_mode_map:		Array indexed by regulator framework mode
  *				containing PMIC hardware modes.  Must be large
  *				enough to index all framework modes supported
@@ -125,6 +128,8 @@ struct rpmh_vreg_hw_data {
 	int					n_linear_ranges;
 	int					n_voltages;
 	int					hpm_min_load_uA;
+	int					pmic_bypass_mode;
+	bool					bypass_supported;
 	const int				*pmic_mode_map;
 	unsigned int			      (*of_map_mode)(unsigned int mode);
 };
@@ -310,10 +315,13 @@ static int rpmh_regulator_vrm_set_mode_bypass(struct rpmh_vreg *vreg,
 	if (pmic_mode < 0)
 		return pmic_mode;
 
-	if (bypassed)
-		cmd.data = PMIC4_BOB_MODE_PASS;
-	else
+	if (bypassed) {
+		if(!vreg->hw_data->bypass_supported)
+			return -EINVAL;
+		cmd.data = vreg->hw_data->pmic_bypass_mode;
+	} else {
 		cmd.data = pmic_mode;
+	}
 
 	return rpmh_regulator_send_request(vreg, &cmd, true);
 }
@@ -767,6 +775,8 @@ static const struct rpmh_vreg_hw_data pmic4_bob = {
 	},
 	.n_linear_ranges = 1,
 	.n_voltages = 84,
+	.bypass_supported = true,
+	.pmic_bypass_mode = PMIC4_BOB_MODE_PASS,
 	.pmic_mode_map = pmic_mode_map_pmic4_bob,
 	.of_map_mode = rpmh_regulator_pmic4_bob_of_map_mode,
 };
@@ -975,6 +985,8 @@ static const struct rpmh_vreg_hw_data pmic5_bob = {
 	},
 	.n_linear_ranges = 1,
 	.n_voltages = 32,
+	.bypass_supported = true,
+	.pmic_bypass_mode = PMIC5_BOB_MODE_PASS,
 	.pmic_mode_map = pmic_mode_map_pmic5_bob,
 	.of_map_mode = rpmh_regulator_pmic4_bob_of_map_mode,
 };

-- 
2.25.1


