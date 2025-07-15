Return-Path: <linux-kernel+bounces-731026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A29B04DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E383BCD9D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613A42C3277;
	Tue, 15 Jul 2025 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O3ukXhLZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE90248F76
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752545266; cv=none; b=D43DGdaYvcHB64dYGj2z6a0i1gfvWc0gDlYkR/n6Zwon1Xclxl19cYjdzXBEP8rn1e07GuYTrVg32w4NnbjvkYCO5+CnUGMB1ZSKD9K0cocuP4QMZ8nzoStukZMahFRN5rJpudVTbPHFjS+yIsnAqKjV7e5820S01WKKttmH5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752545266; c=relaxed/simple;
	bh=HThEJMzKwJYDztky44ZA/c1WrXlLoJhAkNszWLwz0Os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F7kO2Jm5uYCsofShavu1U2OboaSO7QP4gUh3dLs5ZhfLwt1Aq1Hq08tX/iB4IX1bCXuofrdN83/TXMYWMGjKDiBDkP/J5buf+Vet7x3CnXeZ4Zyg54zyHxVsF2VuuBczi1OuXpNFmOmobjFY4s+QeoLnbsf6RNWIgxGeLGyFz+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O3ukXhLZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EJ85hC013407
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PSVwncDU6Dys5JEA52xmdL
	uexYAaayc7t0DglVd9hSU=; b=O3ukXhLZxqN3YiATmr03C6jdAR5sbb8uS33RiV
	rCNRTDFsRf/Qkp6J1FTpCntkw6oKwRQR3SsOyBC++4eIqVAWPGYjjJd5iD39s4LX
	K6fzyNx9JbdpUsUpRFUNjzay2zjgex1g6ykqCz5sC7jn1FIWfhrQ14ANCiQ6+e+p
	eMsp6GpBqkhxY0QyyL/3aa0EDw7hr7Txb7VNuzOXu2y3rOkn2di8908qhvcdqC7h
	8Bsuqs18+0RAv49g4DasyP3TN9LsHct3mhbdcYcEcCa2z6s3Im03L93lAC9BHLBW
	UFk+HudJ01u2OrIP4BAZurSKcy7Qe13a3VsfrkPfKPYm+m/A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufvbeeyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:07:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2369261224bso55284895ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752545261; x=1753150061;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSVwncDU6Dys5JEA52xmdLuexYAaayc7t0DglVd9hSU=;
        b=cV5KZCg97y0gjhcD/okqt6XLpVBDXc5RfqP55rF3OJtScW6VvSAiL5OU6gAnkFkCdL
         +5Df76I70wfzXZHeG+oCs8X2uPKeeFAeKeKjrjT4ZbbAwsdZekJmDVn6r+iV0EvsgSj9
         kgH82OkXEOso5v7V/72ZJ8lBO6JCi2PWti2mwt/cGg/It2YOIrWCM5RHNmcmeTVk3YkG
         +0lWkese/RHP0PgHPMPLQdsdDFT52QFaN+HH/a2hRMRuL9uh56J5slVDLj+ioJWulWVK
         G93hu62poHxLUzWumme2n2e9Pc8p1Wjmpi57Ydsi4mRFubW+eNvZHyJG6p+lc/4ur132
         lOVA==
X-Forwarded-Encrypted: i=1; AJvYcCVawzapRq0jxOzhYVl3CngsqNPSMetCj+4/Bpzoi1HA52PXNmq1e8wGvpQ5wI5sx2ACoNNQAtgJmfR7ZRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD00yPopAdHOdKLiML/HRk5P3zhvCklT2mLoMbR3DoODAPsx5J
	X44K+w/uxH76/8WP32K+NH+qOAF5twATEwQ57CEaBctvoeM6fZVmRzRI57hV9v28Shjl05Qtjjj
	ZJS9N4lQg7sVrqs3yYdf0loFRkjHuGIUs8WHIEm155T3f9hj8X2k3qODiBM/bideccqjFnOBHyN
	w=
X-Gm-Gg: ASbGncuSOazJTyFvZDb2fbQbI5PRne9ueQV8+iY41ErmbkNYdRwf1H6jiBPNlxcjU0z
	GYSheqOlaqOZDkJzZoTRmPD0s28sr7gGtIKR8UQfm/dDtLm2yaKp53OUhFP8Jy7oYa5RtuFCnAB
	fn2h4jYdXroGRiihN65p84fNLp2y9CkyY95sRT6GifYn7AV7Aa7JORnwWFyF1z54ebSLaVnjyuC
	QjqSyG2QRSd05Ze54Lh40iVL6W6z4wadWvzFaUKvHr8uAfgi4we1VRQOYK4v9/FTmp06GK05JKW
	G3DBASPi6hD19lYyiGcD+AL6eZ+oM2mdpBBnuww9x9wEXSPqZE4ByahJz87hBjL5RxnsphE+Zu4
	LvPYDE4jk3+ErzjmHCg==
X-Received: by 2002:a17:903:1ac5:b0:234:db06:ac0 with SMTP id d9443c01a7336-23dee264f3emr234356495ad.45.1752545261213;
        Mon, 14 Jul 2025 19:07:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJcKH2/xSIW5sa5dra/KGf3NPul0JNAK8Fy/Ps1y4FVsqv9aC49irxSUQ7qZWB9zBprTyTsA==
X-Received: by 2002:a17:903:1ac5:b0:234:db06:ac0 with SMTP id d9443c01a7336-23dee264f3emr234356015ad.45.1752545260784;
        Mon, 14 Jul 2025 19:07:40 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42abd8esm99760635ad.54.2025.07.14.19.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 19:07:40 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 10:07:35 +0800
Subject: [PATCH ath-next] wifi: ath12k: remove unneeded semicolon in
 ath12k_mac_parse_tx_pwr_env()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-ath12k-unneed-semicolon-v1-1-9972fd4cef07@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOe3dWgC/43OwQ6CMAwG4FchOzvCJgh48j2MhzI6WYRNN1gwh
 He32dlEL03+NP/XbiygNxjYOduYx2iCcZaCOGRMDWDvyE1PmclCVkUtSg7zIOSDL9Yi9jzgZJQ
 bneVNe9JdV1agQTFqPz1qsyb5yqjELa4zu9FmMGF2/p1ORpH2P/UouOCNxg4lAHZFe3Eh5K8FR
 uWmKaeR6Cj/5CRxIPojPYtlDeoLt+/7B1EfIXIeAQAA
X-Change-ID: 20250714-ath12k-unneed-semicolon-896fbb45afac
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDAxOCBTYWx0ZWRfX2Gri/5xp0Jui
 aRh1d4Jeebuz2TdsikdDsDBQCp/kweq1Dh3WyUOSwjoOYI8/TrYkryLaLSPln798yAKaspabwL0
 4Dblu2BoiI7959hL2N8RZRJaB1KO+IC93dkcBaWKdJKV+prwxrN8XNXMHZledk2AKxSkbVD8NAZ
 iBgsz2i3j1IfYP6XZS4pNE2QjVMogAMliPSEIMhLbbn31rgQ9j5nZlwwx/QWyFHks3aole9T67F
 2ax41yCQ6cjAaWYyjx99wuYNY8Cobxc2I+JdlK0Vy9OJs2d27sE8lf+LpXK14vVreVz/qDIVxiz
 XLNBPbVIs3WTNsjMmboGQgHInFIZW2OGQ19h2HaV55JmkjlZjN8Z3s9Ux4jwcgty2k2WPTTfEz8
 KX+NF49+vctS6c7KNtpIo9JY9qtBeb2f1XS8vS/No2Ck3aeokbAun9eQ0o9P8vUn/VGKAvoM
X-Proofpoint-GUID: U69Of6Lb3DTPzbEh5AqpQqtZVe_JJOco
X-Authority-Analysis: v=2.4 cv=RPSzH5i+ c=1 sm=1 tr=0 ts=6875b7ee cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=kzacFtwYidqRY08iEG8A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: U69Of6Lb3DTPzbEh5AqpQqtZVe_JJOco
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=875 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150018

Kernel bot warns about this unneeded semicolon:

	drivers/net/wireless/ath/ath12k/mac.c:9785:2-3: Unneeded semicolon

Remove it.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507132355.ljWuxxjd-lkp@intel.com/
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 5333da9cac1b2cae4a71c975bf927de8182c357b..a5fb917812c1ed2e60a3ceba32d092d7198e6054 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11424,7 +11424,7 @@ static void ath12k_mac_parse_tx_pwr_env(struct ath12k *ar,
 			    "no transmit power envelope match client power type %d\n",
 			    client_type);
 		return;
-	};
+	}
 
 	if (psd_valid) {
 		tpc_info->is_psd_power = true;

---
base-commit: 3a6df1678acc3687d49ce94e23df7b6a289f27f9
change-id: 20250714-ath12k-unneed-semicolon-896fbb45afac

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


