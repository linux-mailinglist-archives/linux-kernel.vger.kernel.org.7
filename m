Return-Path: <linux-kernel+bounces-797640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D70EB412D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E660B1B23F1D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0A22C3272;
	Wed,  3 Sep 2025 03:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bvorOExb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973AA2C21DF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 03:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756869207; cv=none; b=DGUhG2MJJiEEnzhi5ijpd9zIsUaVIHj2rmeD8VmYpIJHfjJHv7BZpQA8U1g4hzA7IZGhHW198gb3RvcvItombgcviivnXcZh9mHuglCp22XUZ7UYC9ax5AApEiJcFwBx0f5CjaUaQPLE4ja56N1BfN/J7oTZp3/bEWOrx+A0lKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756869207; c=relaxed/simple;
	bh=Hi3MYKU9XwQ73CdlHU3y5LnCsyr0aAH+phzG3kS5xVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E68FwdCFRAySdUUfuUrOhuE2C329+BNYgFsj/XFkABkO9sbfctA4w++APTKoh46rm8XjWm5e7Iu1inOT0iFjYrMjyvPCOuMMobS1vzNYJOAn6oPOGVEkwZ5192uq1bitqxixqn+s0xqGW2ikyrBfhvmJ/maXyZRmGh5phLtkVDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bvorOExb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5832CMl9032378
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 03:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MWeAl6vczD5ydCI8AKopjR
	HLRBQzPmVJvBwaxT17MyQ=; b=bvorOExbae+0JLZrrbpi5CO0W59eRoQeNSlxmH
	OcZodtPRFVvo8OTQb/VlCp/G9s5ogkvWTkVTYW+mNB1Eo26pKoNt6NxDNuhcW2nH
	eLYgeItqT7uArIJ+g29WvdHg/k16ScJbMciaKkSh2A+xL+CWCz/V+mK/peu+yjST
	i8NEJQ7hCxe53ClCpK/HTHAM6xlhN9Ohll70DwTEwRIiDdFI7555ph3u+cQLCY8a
	2QsdbWHm6Wquw+U7wfGdYrxgng4bt1iKhDKGQfxPyddE/4NJRBJisig/3NApbJzq
	qZXhEh5BCYPAyTADRiJiCcwfgXp+glBONfe1Jdd6ttyryxWQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8syf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:13:24 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77250c660d3so2979410b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 20:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756869203; x=1757474003;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWeAl6vczD5ydCI8AKopjRHLRBQzPmVJvBwaxT17MyQ=;
        b=p6Zu3vGdXPGkCZS5GcgQv1jeXem27rbRPCU0BlhCpTf4UeGNRinAWSs/lUeqker/qC
         p+6iExnjTbCVgSt1IvGL/lofukC05IAfawp1PS0KcnTFAs0uIp3rTjoSzfQ8oCE0nDV/
         AYH/uv/Wwh++YFtnxx04IFudgxCthrNhfa5kHBzdkBLFz77I7+fyx7fPsDBVKvyP9GnT
         un0VCRaHyiiMxNtHQbeasa4wgJliYVN/Xm5pRtgDTKmD2rFc3/XdqRNwsK03uHoGyJd0
         mEldkFxpvMWLjsv6+hhxG69EgDGRrl1hlXV9lhzL2eOClC7ZV3BSLij9DMmFxRf43IDH
         6Ivw==
X-Gm-Message-State: AOJu0Yz802Xir8fAULvfQQzo2QKBSZ60VV6fKkuPf3zsP6KowfOATG2X
	1NiQocGZenxsCZc0Lzq2t8YXVIXrCiHx7kHQvNzNdBp1LC4d6ZwGCBX1caI61fo6tc0qJdceUBq
	64JuT/A2nG0ky/AWifc3MWWn46PUNHkNdy+u29eCI33j5XYhvamuiDNGRQSMPaaSBHbldUWXmUr
	J9fQ==
X-Gm-Gg: ASbGncuZkMJz6Lzc/0xjM/sijH05DgeXoXpuu7H2T2G36Ks8Lm7+0kgasdMJkeX/RrY
	wrMRBVcT7wYVc7a9V4xShq3WDgpfzEMPc+OcsFTCSGlWJEYI7ZKC0CgNEyPG4wLMzFAiMUV2Ngy
	Udv0LR97VCqqaMnsjHO7kDA96w6LNumJ5OWHGkYuFySkxF28/f6m10ycT42uHz+YOMaMHM75ld5
	3mXVh4BOSktFXHYxQRtFGu7LD4lgwj4QbrPeRuF0i7aLwE5d0D4Zc0oM1JEkfCxC81xFEeVUrI7
	D8AxtC3qynrrVrFb/z8sPDk221xIO1jHb8l9k+90JqHlZ9D73rdky6DPGQ==
X-Received: by 2002:a05:6a00:4fd2:b0:772:736e:6574 with SMTP id d2e1a72fcca58-772736e6732mr4534321b3a.1.1756869202943;
        Tue, 02 Sep 2025 20:13:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy698QMLSb5QYBAyCkNDtpt7tfz0dgNJX53eZVWncTA9+2ypRg3zNlOyb/gePSJtX91VUrzw==
X-Received: by 2002:a05:6a00:4fd2:b0:772:736e:6574 with SMTP id d2e1a72fcca58-772736e6732mr4534300b3a.1.1756869202416;
        Tue, 02 Sep 2025 20:13:22 -0700 (PDT)
Received: from luoj-gv.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26adf7sm15064598b3a.15.2025.09.02.20.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 20:13:22 -0700 (PDT)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 11:12:55 +0800
Subject: [PATCH] MAINTAINERS: Update Luo Jie's email address
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-maintainer_update-v1-1-2183fd2a3c44@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADayt2gC/x2MQQqAIBAAvxJ7TlAh0r4SEUtutYdM1CKQ/p50m
 MMcZgokikwJhqZApJsTn76KahtYdvQbCXbVQUvdSSuVOJB9rlCcr+AwkzDW0NKjdD0qqF2ItPL
 zP8fpfT87uSA4YwAAAA==
To: linux-kernel@vger.kernel.org
Cc: Luo Jie <jie.luo@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756869200; l=905;
 i=jie.luo@oss.qualcomm.com; s=20250209; h=from:subject:message-id;
 bh=Hi3MYKU9XwQ73CdlHU3y5LnCsyr0aAH+phzG3kS5xVY=;
 b=2Ls/TlECoUu+XaSCuu94yQYgmRw4LPh9pjdqhl2ethbyuwzO3nFWsBkrM9kPVJ+phFB4VziaB
 vl8I+fShonFAz1YR/F4Jy4pulWckFag7rBJ2nbYmp+aGGlJHWQdhbmH
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-Proofpoint-ORIG-GUID: jdSAVfYfYPysW_mdrB3NPGrwox-n4Gxt
X-Proofpoint-GUID: jdSAVfYfYPysW_mdrB3NPGrwox-n4Gxt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfXxMCzgcf0ZDCV
 Ygw3dDgG6vsQTsDCUym8xEn7sghRe48ckLQ8nDzCrJc0+cx5oAS4NzzJytHr5UDQoae59kMfx33
 3j3FRY3ZZuM5X2uelGMh9zAfHcKROJdXn+kFhLYjhO17/rERNTGxP0rjB4YWcLe83LhDDwFGAc1
 ijFTM9PBgbMhvjAUp1/dbj/n4knt60wY5c8Xm7yInHs9fHxYQlFmw7fuC2UgcJeyf8AtLTj8eue
 QlpnSL9oJJldXWd5HaTUMfmVh3j2CfcCdOP0ur1ryw5W1qp+dbB2vNMzTjWDN1s2EktjLSYc9EU
 YxTdUYjNIjilnMf7p+l3GoSz01c+YGtqj0M5vpn+Pc+9VbsKML6mIu11vWSSF/YOBvQ0P2I1pMb
 W/8wn+G0
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b7b254 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=VwQbUJbxAAAA:8 a=Nua0MkNpqm9SeqlRuHIA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

Use jie.luo@oss.qualcomm.com as my primary email address for kernel-related
work, as quic_luoj@quicinc.com will be discontinued soon.

Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27811a24573f..296c44931ec0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20952,7 +20952,7 @@ F:	Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
 F:	drivers/power/supply/qcom_smbx.c
 
 QUALCOMM PPE DRIVER
-M:	Luo Jie <quic_luoj@quicinc.com>
+M:	Luo Jie <jie.luo@oss.qualcomm.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml

---
base-commit: 33bcf93b9a6b028758105680f8b538a31bc563cf
change-id: 20250901-maintainer_update-898ec7a0d7a1

Best regards,
-- 
Luo Jie <jie.luo@oss.qualcomm.com>


