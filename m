Return-Path: <linux-kernel+bounces-764272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19019B220C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106FB3A7297
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACFE2E2644;
	Tue, 12 Aug 2025 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cFFloetj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8654D2E0B6D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987095; cv=none; b=h2iFeq+jToOEFYn6xu7WXU8HmHeHXcbncZPWmthTD5Y50qp3Mx8LZF3XUk7MdWCysrmKP4iLmRt1bc0B1y92394LsA3Pqdi7PlaGM6UmJuSYJpZRbu6Hfmr7q9HX+urgT5rGVTTSCKSh0sRXCkM9qN+sFvMhnJQbo0PH+R02Iqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987095; c=relaxed/simple;
	bh=Ls5J9aUoaeG1NcoX+fHr/jtlfS9IVMicVL6C022zjn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fGdznZG1us0Yetvr//pupbxQ/RW3SRon1R/vhfz9jO1T1sDD9Hb0x7Qy4cZAIqjsoDf807FuHESGiX+uavx1nOazDejfSZCT5iZQ18+QD6DZPFkCaAdIxMyIThaziz6XGZwjmHEwnGZRCNrD5S8hoYGX9m3gsle51ENkIwGZJDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cFFloetj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C4525M013107
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CvvFVEBAadFWgjLlbo5X8O
	Vvt+9c6CEAJCOkS71be4w=; b=cFFloetjzxbMfzxTJqyUzEGMbz0jrS4LFVtrhH
	QnqBbEIAk5vPf7SvgtsNQ/nmTOHZuBMp3Sdpa9OPPrbTHpoPiAoElw2IRC2ZsdLp
	dA9wKzPjBXIbLCcE2nAtGhJN3TBsOE7o5fJ4Ubpan/tA93C2UBMcDRqJsfNfuW1q
	irlm5ewCVMgpmcnIym1a15eErRzA4dvSs5c239U0qZb8O4T5ZVRJnlCd7CWtN4f+
	bkUgnS6VxYdGfgz7+tuZ7Fl9hcMIShgEwoba5ubC9CqFLTJSwaN/jL9uPGbSj8+1
	UZdiSDPVdkSR5GO6C3j1q9yupu0hHGIk02BqG+XZIsV7farA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dupmqgw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:24:52 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76bc9259f63so5217715b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987091; x=1755591891;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvvFVEBAadFWgjLlbo5X8OVvt+9c6CEAJCOkS71be4w=;
        b=R4ifJoL4RSRObmy7Zu7jqsBcN++J0gteKE7s3c3jpuEATnaP+Q5aIxrmqF9JGd8qPg
         ZM85/+W6BIlfLQ09HOu+CYT3FkJUdMIrUXotl1xRtnZnaH7gbLvapVRp+mOlWWB4BA4y
         F62XsqduK7pMGkAW+ZRuyfS+MjSXIWXq6x2inq8luCO7G6YqzNotsjQAICFj60J5pZ28
         GeeqAPJm03CJZ/wr4Vq/dpYzXl6ZqEDE2zy0r9AmbydJpq0Zz/3Gt1OxCwBGDRFmvDlW
         p/taxJmptJwcjYTKzuIdycGxSvsUO/Jp2401hTCjehq3849Ukx5z18DWuoKHneJdHugM
         f9Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWUkZSWhe10aRHJfS0/vWWu+3wjpTcJ/RKR+joaadYQukvYpovc44QteoJ/HtG64wYSb2C+VI97jfeaUD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBLFsg41RgHFIJIuE2MIwre9W10lhwqZ1fEdrDjeWPSMdRsgtJ
	VmQ8fnJHNb5Yi8v0eUEbkCngzAKGM2yGAjIPQIpHdmew+pbcNYXwhBH3mhQM8OBs+FyikFPy0+s
	KQhgjiaKzaqk/FJkEAltQiUVy+4f0eE1ctRcjexUXYXYA+kwAmURNM3rfNdtVbNDGxxKt2Tze7x
	DDl9fE
X-Gm-Gg: ASbGnctZ/GMdi6OhBitXx8gGnBV2rNy0G+e1LbF5jrmKrctVP5uvBtMYIA6ikg4YfrW
	KNsaW//1BQKaQn/WnsWmoK+80mWXSy6+nkXdFI5VHLnzUPuwbjFxYnF7WZqZcEMIKHqRDnBMB11
	gJPWXPUf1sodmE9x5A6YE1PXpR1H+HvJHOMuSgGvctJPJdoSBBJAWdfnn5Vkhf9gCey1vVkt4oI
	WxrA1SyPr1M6dOtjK5SD2cHtODZLLOcKvn7uqXUU6aqGY4PAc9ZGN9XsM3c6RVuB6tJheN9wYWV
	fwJrt8oOAhUihH9ZhR3YkJ7pboE86gcQDvsYaNqG8OH6Fmt8V8pzjCRiNmNXsmi3kU2GQ+MlJUq
	KeimmE5QRKaMLEpT8piFkYQ==
X-Received: by 2002:a05:6a00:2286:b0:76b:f16b:b186 with SMTP id d2e1a72fcca58-76c461419eemr19972767b3a.17.1754987090699;
        Tue, 12 Aug 2025 01:24:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwQXBR35j59DRJhzNptfgFRmw0DHELJGAGq2oy+ZJTpCDVjfDFKXkVTK8fwhHEmYG8UWf0lQ==
X-Received: by 2002:a05:6a00:2286:b0:76b:f16b:b186 with SMTP id d2e1a72fcca58-76c461419eemr19972729b3a.17.1754987090187;
        Tue, 12 Aug 2025 01:24:50 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbcea9sm28877018b3a.61.2025.08.12.01.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:24:49 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 01:24:45 -0700
Subject: [PATCH v2] coresight-etm4x: Conditionally access register
 TRCEXTINSELR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-trcextinselr_issue-v2-1-e6eb121dfcf4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEz6mmgC/32NUQqDMBBEryL73UiSkir96j2KlBA3dUGTNhvFI
 t69qQfoz8AbmDcbMCZChmu1QcKFmGIooE8VuMGGJwrqC4OW2shWKZGTwzVTYBzTg5hnFF5fGuu
 tRIM9lOEroaf1kN67wgNxjulzfCzq1/7VLUoogX3T+rNWxkh9i8z1e7aji9NUl4Bu3/cvBwyGx
 LsAAAA=
X-Change-ID: 20250811-trcextinselr_issue-f267afa0e5ed
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=bY5rUPPB c=1 sm=1 tr=0 ts=689afa54 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=E-Az336nn5kJS1Kr1xEA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 2OSQEqXkvkRmBR7bVrNb8uurle2GYdHp
X-Proofpoint-ORIG-GUID: 2OSQEqXkvkRmBR7bVrNb8uurle2GYdHp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMCBTYWx0ZWRfX/348GviYz2Lo
 FB7ZMjXLSnNJMK1u+WnmuqhyOaq2UwZwehHphGOEKo2bcPMRY/BpOvqFGasC3y69QylBWG8HnIZ
 agnX1tC+9EKF9vP/sxvTEtRvvsURjbqR8x8UKcWWTfxByfp/bkvjnpdgUtBzTIVrWjEqigTIim4
 lpTExqiaMSsWCJWAnIO6uENR3SDozf1fLgjB1Xhrrsx8iptgj2B9JSelnAlpAKUJViYhUTCt4B+
 D2BEImLw0BOPBbwmDoqdjGeea0eN5MG6ATOdhMJufyffRAPKNXFL9e75ehBgDLJdVZ5ly9UU4LG
 muCI122cgfaebGpmLxhGQdpjs4C3cIqJl2/qbfg6nlGtHh7l8CHXKPo96BNR2PU/b+seWAqfyGu
 Va47+LLs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090000

The TRCEXTINSELR is only implemented if TRCIDR5.NUMEXTINSEL > 0.
To avoid invalid accesses, introduce a check on numextinsel
(derived from TRCIDR5[11:9]) before reading or writing to this register.

Fixes: f5bd523690d2 ("coresight: etm4x: Convert all register accesses")
Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
---
Changes in v2:
- Add fixes tag.
- Replace "if (drvdata->nrseqstate)" with "if (drvdata->numextinsel)"
- Link to v1: https://lore.kernel.org/r/20250811-trcextinselr_issue-v1-1-ed78f3215502@oss.qualcomm.com
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 11 ++++++++---
 drivers/hwtracing/coresight/coresight-etm4x.h      |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 42e5d37403addc6ec81f2e3184522d67d1677c04..4e411427303981104d11720d3c73af91030f8df3 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -528,7 +528,8 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 		etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
 		etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
 	}
-	etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
+	if (drvdata->numextinsel)
+		etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
 	for (i = 0; i < drvdata->nr_cntr; i++) {
 		etm4x_relaxed_write32(csa, config->cntrldvr[i], TRCCNTRLDVRn(i));
 		etm4x_relaxed_write32(csa, config->cntr_ctrl[i], TRCCNTCTLRn(i));
@@ -1423,6 +1424,7 @@ static void etm4_init_arch_data(void *info)
 	etmidr5 = etm4x_relaxed_read32(csa, TRCIDR5);
 	/* NUMEXTIN, bits[8:0] number of external inputs implemented */
 	drvdata->nr_ext_inp = FIELD_GET(TRCIDR5_NUMEXTIN_MASK, etmidr5);
+	drvdata->numextinsel = FIELD_GET(TRCIDR5_NUMEXTINSEL_MASK, etmidr5);
 	/* TRACEIDSIZE, bits[21:16] indicates the trace ID width */
 	drvdata->trcid_size = FIELD_GET(TRCIDR5_TRACEIDSIZE_MASK, etmidr5);
 	/* ATBTRIG, bit[22] implementation can support ATB triggers? */
@@ -1852,7 +1854,9 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
 		state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
 		state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
 	}
-	state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
+
+	if (drvdata->numextinsel)
+		state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
 
 	for (i = 0; i < drvdata->nr_cntr; i++) {
 		state->trccntrldvr[i] = etm4x_read32(csa, TRCCNTRLDVRn(i));
@@ -1984,7 +1988,8 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 		etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
 		etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
 	}
-	etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
+	if (drvdata->numextinsel)
+		etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
 
 	for (i = 0; i < drvdata->nr_cntr; i++) {
 		etm4x_relaxed_write32(csa, state->trccntrldvr[i], TRCCNTRLDVRn(i));
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index ac649515054d905fa365203bd35f1d839b03292f..823914fefa90a36a328b652b0dc3828b9bddd990 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -162,6 +162,7 @@
 #define TRCIDR4_NUMVMIDC_MASK			GENMASK(31, 28)
 
 #define TRCIDR5_NUMEXTIN_MASK			GENMASK(8, 0)
+#define TRCIDR5_NUMEXTINSEL_MASK               GENMASK(11, 9)
 #define TRCIDR5_TRACEIDSIZE_MASK		GENMASK(21, 16)
 #define TRCIDR5_ATBTRIG				BIT(22)
 #define TRCIDR5_LPOVERRIDE			BIT(23)
@@ -999,6 +1000,7 @@ struct etmv4_drvdata {
 	u8				nr_cntr;
 	u8				nr_ext_inp;
 	u8				numcidc;
+	u8				numextinsel;
 	u8				numvmidc;
 	u8				nrseqstate;
 	u8				nr_event;

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250811-trcextinselr_issue-f267afa0e5ed

Best regards,
-- 
Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>


