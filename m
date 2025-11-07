Return-Path: <linux-kernel+bounces-889817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D0CC3E9AD
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 07:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7621888F86
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 06:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8AB23E32B;
	Fri,  7 Nov 2025 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XYpgYmgN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IuF3739b"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6911228E0F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762496231; cv=none; b=MSFAQYfvmRhlKrIUUfzvUTePExWwyO6BVV+lvXLc3eH60b8QQFJia3bYTmUCGRazgqDv+O7alQ/X+zogcqUiEY0MGp/09hqiGBMlSD2cJHev5DpPNKD/uQOxAFyrXLOnKupDYDdzCNHtNp4/4rOJw/+e1hpaKGmf9t8klu9Jvbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762496231; c=relaxed/simple;
	bh=70JJQiQ4uehLBIJN0Q7wS4J6JTtu741G1HFu1yDqauU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uqB0Z5/K+LzVpr9c81/c2SB9UFKVxYCq8xEZk3I1PoqJRMNmHifrZmceQcB9pJfIfU9KFdkDu52kLrdsw9JIQPcNlVuKOWmZI81SFXptvNSU3YxU1tbapDwKThMmeTIBGK5hYAnFZCVHU/84glVaxGVAKn1gjpQtuR01onwtzug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XYpgYmgN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IuF3739b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A753x292281828
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 06:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PmIP5A7OZZcTYCc0rIwjJl
	GlLMyg1W4I5vENm4WWsO0=; b=XYpgYmgNEf+FHHbIQHX+K597xuSgUDrfjFuCu6
	b2xYckVsGxBj9XIeCE6q4hRzc3HVyCQ7HJ1Ou380eWNUvJkNnOLHBsWIiUaxXCQc
	IvwoxAlwef9XrtfOdokD3kOt27M8Hk6Sv/BFV9WVwMRJusCUKOjowRHtLuslPKA2
	gMfX+FFdF1S0v1RkcvxYgHbDmpIFZNL2C4hD9MpSE/QrqOmzIaLZdQT4DbUxkmbQ
	G6Qx+TissIrsZD0vRiGsp4Z/2bGfZbu0JptWpPlL75sqymo8oeha32RT8n56HkAT
	P/xVgn+lbyzyHglC/87QKq2mErK2WSjoB3rut9UA/b+d5eVA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9a9sg5b1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:17:06 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a440d38452so920204b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 22:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762496226; x=1763101026; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PmIP5A7OZZcTYCc0rIwjJlGlLMyg1W4I5vENm4WWsO0=;
        b=IuF3739bN8ekDTEKuasvFFHgR1t3kfVD7EkdxTZ9wafyNtfXk+lbfp2R/SNEnEuxph
         LeTnaAUAdg2lUv58Qe/UEWMHmg27rXtftuzGwNBXgiQDLT8TGocUO5AlPiEyg+WZevHA
         CPiaqJrnlatSieY9+866lQKWKmIiHjBWq1AFYmMsDBT+CPDQo/ApZnHPT72MZx0zKMhs
         8VjcV5F3/h0KOmkQ2s8hPcsTina9zd/u0Bu+wk+IM+4Ntx+zoLqTEGe5UlThdaPFq7wM
         BEfcQncWs4nJ9G1cB07/Kdpap6Q65ztXtCvUvSyHfZnPb33p9V0kcMCvtPnZicJo+Uh4
         80ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762496226; x=1763101026;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmIP5A7OZZcTYCc0rIwjJlGlLMyg1W4I5vENm4WWsO0=;
        b=P2R41uj442mjWo08sdWgX7JNsdT/E9/4rNt4AOzQIKwfW6GtWvwMoQoCvEIN7CXX+0
         JjRHZLjK5mzQSANmbEm9wkIiB/OhWN5NX/C5+8zg23lxEgknWidSesiQfcm2O8U0moO+
         VzBmBsSMFfi8+y2vAj7MS4okQ76+4dUDv1bw1jlEfke6YT9xRPXodnuP73eWngIxM+pV
         7rhfuXGaQHNjOTRhPgdTs3T5ak0sho8CuGxGcqIwFeV4d1uX86Mn9SE94/TYqIF1JChM
         ToKorJPSvbxZiJF/FXHcqE1uDTJr6gUohlv53eWx3vDBgPCwHTcPVYsTJFUqQw2JfuUu
         URDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnIqPELYmo2zJYFjOohA1s/MTLsEvQN8UBU1R8B8zCNd0uJT/Yw6/LOwqC+4MVaDRhslmP7cw9RKjJKb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoNh/QVnglPICNr0sg55SVdv4aol2BdXnAdB6WIxOFGqvAOALN
	tlS4hLCbS/ixGvteGaM8i+MTQsT6RJhHbUFU4xinb7jm9exfmRPW8C6mGYpcqyY8mtWsFuE8EQj
	eWOxGJYP16tdD0c3toAUCs7vvmJ/GHfCttKSfQbWpnIoOF3aPE/5cNr07SJMO67DX97w=
X-Gm-Gg: ASbGncvuK8wNa4nTA9WvV6Lsqk/8UtE8dugaE9MzMZ9qHYmXRTGK8VCnwYoEK4nauaX
	tE+OL9KEpQTilnsHjVFQxA2W0O/UiMQtTcEnNZwp+wi8lL9r8IIDL6qvSDQKHJMzy+lSAz7JWO/
	ZgDwgXJ1DykV7tcgLiZqw5kbNvz4PUO0JMMVW9oI27eKJc2aa3/0MMnSEA1fjEvKtuu3E8rSyAX
	IXpBdlRn7gXN2ES96VWPPJKKWURJXQk2yYMeuT5p9XFh0e6RaXGlGjQOFfrezoUk9+6z0RK/gtC
	RqAooCdYes7TsRikTTb2VShf7TcDtmGMbqhib7E1ozQ/6eMHTq+keDgzZLu49/AlIofvClW93Vh
	yG2+WJ6RZuRsrzB+1E/HyUZtvSbigvCnJIxDpSqghHdOAjCtymHd1qIIDEBzQ0Q==
X-Received: by 2002:a05:6a00:2e25:b0:7ab:4fce:fa1c with SMTP id d2e1a72fcca58-7b0bb537e77mr2836076b3a.1.1762496225616;
        Thu, 06 Nov 2025 22:17:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELyEQVccztdB2stF8xyIaaG0Tq4Fwuh0GqLmntX+pCk+5UO6Hh/eju816NjTCfJ1x+21E8Ng==
X-Received: by 2002:a05:6a00:2e25:b0:7ab:4fce:fa1c with SMTP id d2e1a72fcca58-7b0bb537e77mr2836041b3a.1.1762496225081;
        Thu, 06 Nov 2025 22:17:05 -0800 (PST)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccd5c75bsm1614833b3a.70.2025.11.06.22.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 22:17:03 -0800 (PST)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Fri, 07 Nov 2025 14:16:39 +0800
Subject: [PATCH] coresight: tpdm: remove redundant check for drvdata
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-fix_tpdm_redundant_check-v1-1-b63468a2dd73@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMmODWkC/0WN3YrDIBCFXyV4XUEl7ti8SglhdMatlPxUTSmUv
 nvd5mIvv8M553uJwjlxEUP3EpkfqaR1aaBPnQhXXH5ZJmosjDJWawUypudUN5qnzLQvhEudwpX
 DTaJF8Ei9h+BEm2+ZW/d7fRkPznzfm6Ee4b9g6L73yjiJRFOpWFM4LGXftjVXqeOP6QGcBTbDo
 /8TeCwswzrPqQ4dRUtwBqO8toYhRmVd1JoJ2Dmy3gZHBlUQ4/v9AfCMZtr1AAAA
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Tao Zhang <tao.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762496220; l=1652;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=70JJQiQ4uehLBIJN0Q7wS4J6JTtu741G1HFu1yDqauU=;
 b=Hxb34bvSmjTUWt4yZ8DQLxyP/cG2dPdjYqlm3KGUPEFavcV0jlkMkZy2DxkMpoYnaVt8ExLfV
 nF+kMt8+N2AAqiTMx7T+vgE5h9hXBUNIb9Sz9+WxXyaOMFd8ttf1aKH
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Authority-Analysis: v=2.4 cv=CdgFJbrl c=1 sm=1 tr=0 ts=690d8ee3 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=zFN5lriQbSSrU5DE2BcA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA0OCBTYWx0ZWRfX8qEj8ZREPKq5
 zy3rdI35DCuVpEKME4/w5nEiDfuS/YiHRqQ6clqpGbt6YAecItMS11qlZMIC9m5LIxqI9HZUj1w
 c+bNC0DrMQA0S3IvCL/oehhTFpgrPS4xdKlgwg4pfsjtT7EDzCdeKrTpvE2qEVLeKli3TbVU9WZ
 BWB4bRtQZXFXfdaX+kQv6CEYp7iyD347+QF1WENlUEZDrj1stsskHh7yh3lESAxOJSOp5R5+x5j
 CjH6bDZ07/O8y1WwpbeGW770qLI5m87YDIPLByMi83agLYcNXQi4ydoXnahIXqqKVNske+QYisJ
 u0c0ap4Xjeijp3KitG1VIfGly22fPt5zKxg4hpdNb4QNSStb5OlpcrCW2su7Wrlts8LHQSvp0IS
 H2j5A6F6OyAFLnc9Y6gIn9GvafMxMA==
X-Proofpoint-ORIG-GUID: Q4k_iN01y1g_52uVs7hn3Cm3Wd-RDnSm
X-Proofpoint-GUID: Q4k_iN01y1g_52uVs7hn3Cm3Wd-RDnSm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070048

Remove the redundant check for drvdata data because the drvdata here already
has been guarranted to be non-NULL.

Fixes: 350ba15ae187 ("coresight-tpdm: Add nodes for dsb msr support")
Fixes: 8e8804145a46 ("coresight-tpdm: Add msr register support for CMB")
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 0e3896c12f07..06e0a905a67d 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -1402,11 +1402,11 @@ static int tpdm_probe(struct device *dev, struct resource *res)
 		if (ret)
 			return ret;
 
-		if (drvdata && tpdm_has_dsb_dataset(drvdata))
+		if (tpdm_has_dsb_dataset(drvdata))
 			of_property_read_u32(drvdata->dev->of_node,
 					     "qcom,dsb-msrs-num", &drvdata->dsb_msr_num);
 
-		if (drvdata && tpdm_has_cmb_dataset(drvdata))
+		if (tpdm_has_cmb_dataset(drvdata))
 			of_property_read_u32(drvdata->dev->of_node,
 					     "qcom,cmb-msrs-num", &drvdata->cmb_msr_num);
 	} else {

---
base-commit: df5d79720b152e7ff058f11ed7e88d5b5c8d2a0c
change-id: 20251107-fix_tpdm_redundant_check-a5a7bad4b7c8
prerequisite-change-id: 20251028-add_static_tpdm_support-1f62477857e2:v4
prerequisite-patch-id: eda8dd6884b831cb10affc22477aece39c78b408
prerequisite-patch-id: 7beb8b17d54ff21bc57eab10b56e6ffcfa4d1963
prerequisite-patch-id: f6f1e78dba3f1d3b1191ab827adab5a3b7b2326a

Best regards,
-- 
Jie Gan <jie.gan@oss.qualcomm.com>


