Return-Path: <linux-kernel+bounces-784611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEDBB33E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A2454E3045
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92532EACFF;
	Mon, 25 Aug 2025 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y75BQMgk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8C32D0C88
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122742; cv=none; b=X3PvR6kbKHsnRFs6r4Q6Y2ExjSp9OgFNHUUuyaDSjrSEflqXfcsAnC3+0wYR0tgApLaK2TPMazqcdeysd9H7OJtTV6hUvCqHZvCsDb4J+xwDo+ElA8uWQW914DXvU0cXGgo9Ahnjk/YcXASXqQYc7bOfWvkdX+jugC4fEWf5fq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122742; c=relaxed/simple;
	bh=QRUHF590CJTXODjs7DSRBmvWmre1qQeoCo95qiT9cFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TZtsm8CB/yJ/TdQt1P8jeaIpGMjQf8F4vc4czDa/lxvSmIx/MrE/Hz5+R4hdI4hC+V8TocPrN3E6Xg0lpwyblAmR77tIw2T7g9a8a7UpOgSZ/rAXs5dKAqbzspZIbo8weArk8ka4kBVOe7WizHKS3FOvLmGqu4hk3voGyiW8+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y75BQMgk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P5nJEv021344
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SXrtefYV/rer8ZU996F+Maf3mwsdsfGt4Sxy4lj7V/0=; b=Y75BQMgkquYZ+pgg
	F2ynAc8+RMPiKmquViVF2QxHh70CDJXLrJzJ86Y3bfXYQUtOGypUjMLrc7/zVgFv
	qlQpEj48Y6FKRm7QF1h+vgQniFpMRjJASqPsE5ex9MXfjTjO0mhgTG3C92uNrxvu
	714JBAhq/dgicuPZhNbVSHqob3gRxydW7Atcnk89vRF/hZxNb0pgJntqKew876Wr
	bKtELG4f3A/fCQaD8mxHzaQ+GNhmyQwAcM4VRIvmgPjxDhjMI8t4SGeFf/NkFGCj
	0K/Pt+iHn7i7G92LccGN/F92mK+0gaIh1gZxTzSrZqA6h9POdKiLWhn/7J3zeW+M
	wUj7Lg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615cvw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:52:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-246bcd0a112so8673965ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 04:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756122738; x=1756727538;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXrtefYV/rer8ZU996F+Maf3mwsdsfGt4Sxy4lj7V/0=;
        b=nXWJawtcESMcMnw0IpUT3RtiV8QjDCNX34ko4a6TaIqNi7e9efOAvaZDzQNffydlKJ
         r+l+IJogfQw/bOAyAtA3Klq0oasvjRF+lJBu7qpNvb2XQ2UUTMmFTDofrYzF+IojP3Ud
         oRZsdv8uz3XShdZKhaiSk5eHMpL6UPfQcsC0z9RsR7ZGCrMCqdGHk22qUljogwxaIdVi
         RYpd2wB9KRaOmEkQ7kHI0BmoY7foKdaI464gPXiuV14BudjAtAHtOKXk6DU7k4csFUqG
         v3s2GTe0JFDVL3Hl99a45Dhej85+jiEX1pf3EOxtSeAneyXEJcmzVOJgC9Fm5bgWVpPx
         vMYA==
X-Forwarded-Encrypted: i=1; AJvYcCWocxFvjm6o6kbV++HlD4P+3PoztwYGh3wqJvbnQaNXDVlR4iy4hoIoYCpY/c2ADYQhZioVerzGTJpRmpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQLzvTOygNBb+sxObYr/Cw/rY3Pm1slG1QGgMkC/ydD3KlH0Ew
	BA4EvuRGZ1278tRFVdrwouWBOwFg9p9lPzPQAoOZSbgO8R7T6Z9BMlm7IQlJXvTYK5qh4/RNI81
	MZr7ZI4cDRLbrVfMLkqzVe/mJL9zXgT2e9x11i4KphG76s0sBF/3hC6QvuqjJN4Wla/5Syjvjyi
	I=
X-Gm-Gg: ASbGncvzjFWjXv1EFDfL8IREiHvWhrtFIHKaSeyfmnqhegXB8ebKnlWG4+WXJaqTgVF
	QB3RjiRFzr7oojN91VCRKWIk3fSeNtuUCBhgq0lzGGGUm/k7xmcB+mnyf5prgkgeDOWUdTFtJU3
	uWudcNeI/yCWOLFq4buMYrp+KKqCq6ENAhqGpdRVeVxnG7mvzoyndYtpF1Nh6nwBU+O8ksodhIu
	wv/cZj+4Y7uDP7iKCKZVcS8a7KMg2HwtZ1gvbiWD/mtF2HSOZdMs3rRsW5G5It+RMJXXa36DbU2
	kzbgwdTwhh3O7ndIZi0ios4lW1BYoJocZ9r6W4gqygwmKeWhwn+6Sw7qnWCC2pJ2j5wS4VB0BCI
	A1kneLfqU6V4z04VCPgSNEEzhgL9hJQXwKjeQHWqnxddp/e+/17/EvSLgxTZdVoNMncCzz0EVso
	4=
X-Received: by 2002:a17:903:3843:b0:240:44a6:5027 with SMTP id d9443c01a7336-2462ee86251mr166388065ad.15.1756122737946;
        Mon, 25 Aug 2025 04:52:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZOHnBfa/nKEGaRv/PuhU1McCgGtecSv7aj2G8enwYdVtrs96Wb/j+o1Dlu9hGwpL3t7LJBw==
X-Received: by 2002:a17:903:3843:b0:240:44a6:5027 with SMTP id d9443c01a7336-2462ee86251mr166387635ad.15.1756122737478;
        Mon, 25 Aug 2025 04:52:17 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b521bsm67081015ad.60.2025.08.25.04.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 04:52:17 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 17:22:03 +0530
Subject: [PATCH 2/3] phy: qcom-qmp-usb-legacy: fix NULL pointer dereference
 in PM callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-qmp-null-deref-on-pm-v1-2-bbd3ca330849@oss.qualcomm.com>
References: <20250825-qmp-null-deref-on-pm-v1-0-bbd3ca330849@oss.qualcomm.com>
In-Reply-To: <20250825-qmp-null-deref-on-pm-v1-0-bbd3ca330849@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756122727; l=1673;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=6HKGGM9psY0kba5AoS6bL64REDMzFHyQyl4L0oj0wGs=;
 b=t9gbOuOWuPqyzh7BJf8Tkb8XTnTkURC0r0G+IhLlOAg1S8ZTgM4215mON2iWWPFN0bRGo3D0s
 QNu3E9YWadHBLCgGCGnNoYtvIMzJK02K+1zZ+Way7rxOPfGgKP7DGPj
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX2zR3UzDzVfqL
 7OnoleSJQrrE87f1c0sI10hTOmELrcoqHWgoDuzspB35wQvgg5UGvM/bTlh/d3uep72YifzzQSJ
 6lpH5UxEk9M6F2MmseBERnuMVy76rQAXWYnRa63mQWEi7K6caU1QTQzcDDWfD98mrtjj+cdY9Os
 oaHrsrP9GR1UKMkYNSpzLCEovZBwP9SUwz8gGYxjPiPJAJbWBoQs347k0e1KvWpsJELnxb21+Sm
 HUwMjIpsl2E/8UyeOwPIjGtMUoKsuJIFe15s0bKQZKNr2oD9o76UQ5Zb1KNad1k1AfzOq1Nq8hV
 7vgm5WsYw+T9VVpgMnMGVj0q/MblPjnDSa51K5C5Qjd2DmDU2C6bTDTAogO/Z7+Gbh8dUawWRMv
 G6bwVnU7
X-Proofpoint-GUID: 5Fx-FBrWDjW0YnEC4lcNyptu7oJ7GzE-
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68ac4e73 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Jvf624gE4dKDwD2Vql8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 5Fx-FBrWDjW0YnEC4lcNyptu7oJ7GzE-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

From: Poovendhan Selvaraj <quic_poovendh@quicinc.com>

The pm ops are enabled before qmp phy create which causes
a NULL pointer dereference when accessing qmp->phy->init_count
in the qmp_usb_runtime_suspend.

So if qmp->phy is NULL, bail out early in suspend / resume callbacks
to avoid the NULL pointer dereference in qmp_usb_runtime_suspend and
qmp_usb_runtime_resume.

Cc: stable@vger.kernel.org # v6.6
Fixes: e464a3180a43 ("phy: qcom-qmp-usb: split off the legacy USB+dp_com support")
Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
index 8bf951b0490cfd811635df8940de1b789e21b46c..ef28e59ffd58a12d6d416a553a3a478e9691b8c5 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c
@@ -988,7 +988,7 @@ static int __maybe_unused qmp_usb_legacy_runtime_suspend(struct device *dev)
 
 	dev_vdbg(dev, "Suspending QMP phy, mode:%d\n", qmp->mode);
 
-	if (!qmp->phy->init_count) {
+	if (!qmp->phy || !qmp->phy->init_count) {
 		dev_vdbg(dev, "PHY not initialized, bailing out\n");
 		return 0;
 	}
@@ -1009,7 +1009,7 @@ static int __maybe_unused qmp_usb_legacy_runtime_resume(struct device *dev)
 
 	dev_vdbg(dev, "Resuming QMP phy, mode:%d\n", qmp->mode);
 
-	if (!qmp->phy->init_count) {
+	if (!qmp->phy || !qmp->phy->init_count) {
 		dev_vdbg(dev, "PHY not initialized, bailing out\n");
 		return 0;
 	}

-- 
2.34.1


