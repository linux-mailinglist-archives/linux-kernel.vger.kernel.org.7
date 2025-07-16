Return-Path: <linux-kernel+bounces-733852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C9BB079E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C211B1C43331
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480FD19DFAB;
	Wed, 16 Jul 2025 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pMKWZ2Dg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6DB28CF40
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679699; cv=none; b=OxHMiWzgzpcnlonGFXcEVeqyC/+TlALR6vA8vOqW9ESUGIE8jMAdKlh4P6v9IqFBQnQaZcDHhWrrjCOgG/jZH0Q8E0X2VaTtJsRteN+++FoXQ0pf7B6BZTui6IfqhJAL4EBe+VYKNj1FaF7JrHsIzusSqBFsJX/7MZnfwaUVJts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679699; c=relaxed/simple;
	bh=HwJpo57RFu4YKFi1G/WbvBeaj5ntOXvHLOhM/OG4UqY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hGiAE+NpcCbbakThrZFBUftorHOxmghjpQaEuSpsLWKv5nCh6EDeomakntpSFTOoXyR1oLnxKsvzCSXoMf5/EXLXNpsKTo3eszCgVHW7l1PUrARSqxG2l5tLbikE/8AKJSmeKWKWZmjqFzWwknF/Abb8MsoVa0SZOZr7JWiASBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pMKWZ2Dg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G91HEv012368
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=VZKMCsHazxjdkqYHSetpbR5/PKn4CY0xIoo
	KMOHaHjA=; b=pMKWZ2DgSADpm8HEqZuibDX0UBDDw9AST1FpgKSwjj2Jy+95/dP
	2NOQQMe0iNEtHHSEbSh81azFQUpxNV6zwu8hZMJTusGiygCOwVl0i5J/mjiRewY4
	CNmQWEXPHz2aPXV8xTEsqFPFJSKQLaTKixIU1HkEZoaeDpuxhAJfkhPlBOW4pvEG
	QzOj3qfpixBxJsbJw7jiS2C6iOFadoSo6s2XQIV46Hv0RF5kQcAaXVfSVAR0QAGY
	Mhn/X2XhSI+9HY/QaF4vYMGlaJO412Wt+fLw77k+u2Y74tJMDlQe1cUhCqU+am2W
	oMX6vhRWGgSdB2okQax3i0rgrN95bYZKWHQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47x8x7h9bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:28:13 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so44883a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679692; x=1753284492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZKMCsHazxjdkqYHSetpbR5/PKn4CY0xIooKMOHaHjA=;
        b=IboB37zYsHUcBMaYgeNh7zE8pWK68csXjait2KnUGert43+1cAG+xeLzbbtRixhOfj
         uT3jHEX3rxlal2yGyRaP8QU5DthcATfO7yHgF9xh7ZSKrbydGGSHijhXsdSdoX/YhtZs
         4ln3pRYHDwENIbFfnhg9pKpx0CYvnsErdLmYynQjCcmCw36rxDpOF+OzqjjfVOoGaMMX
         hxZVbGj66UgKsFMBUTIDRJdzteCVKXBfhh7fjU8Xcii7wKQSDgda0jA/cdF5yzXsNJAz
         vgO9RuBXaye/hkcrKs3FArdkx0GHdl3a+4RW/m0VoYdGFUvb899URTxQEEDryjLQhf17
         5jyA==
X-Forwarded-Encrypted: i=1; AJvYcCVeUc+n7CNHCS+uVhMVpezCJExWddGLi2qUr5+sR+4zfqVcc96RUfItHVLBByTuCGUX0kJCTPHEj9XM0Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLSiB6zoBx2AdAonsxjQ9ZZADj6ioTCtWG0GLOPv3eEFTF42Zu
	soFDd/mOlz+Sd2Xw8ku/oWSYZGAlSrgjLAaE4/QjZl51bxh065K91RaOCwsm6BrvfBpW6+CcyfA
	iRGhQa7E9J2ERz+TCiXl0Ud9kL4f9PTkE43annTRwNEjomTiZTnKg6W4lXQ5uHpvaU9k=
X-Gm-Gg: ASbGncvACvTyBA7wLzuCCPEYZsAPwsptjpxxxMfkJcsxSr+IYhQQ2kWW4jq71QVLZF8
	wlWKmW/5nQM2E7YvXB5KtoHA+ByU1BtSrobLGC7e9x9AYlaeG+xCUQmSe7bJvdB1S2EOpRLHadr
	2ZG8EHO3hGW5L+agdj1syrdfjniWZ6eG711ICzxzZk+fO08n9xyz4SJzmWhBiVn/i2TtP54felu
	WGpiISsAf0UnSL4gelklXgp/pf2VcGGzFRsQpPxmUvuu19OzUz1wyuNjaJ47RreJxbnWLTtc/uZ
	XI97AdAkgqZZ0YQ6/P+QflpJOi2/DgOzwk2EqTMotShHKE/aqK12RahGcXjVP1HgItmQsMuXLwt
	uslIrUkjvQzSvlM1H/B+GtL592y5CpA/1K/cOSSjOLzOzFDp3zDR9wzqxG/Pd
X-Received: by 2002:a17:90b:2ec7:b0:312:eaea:afa1 with SMTP id 98e67ed59e1d1-31c9f4389ddmr4109797a91.29.1752679691816;
        Wed, 16 Jul 2025 08:28:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK4dc/pwGVIwFcWXELIY47gNpp4QXWUC2QB+vNktvv5F/caCsYlOFCAErMO4+m+GGA3ZhrXQ==
X-Received: by 2002:a17:90b:2ec7:b0:312:eaea:afa1 with SMTP id 98e67ed59e1d1-31c9f4389ddmr4109750a91.29.1752679691396;
        Wed, 16 Jul 2025 08:28:11 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f20e87bsm1688563a91.35.2025.07.16.08.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:28:11 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: robh@kernel.org, lumag@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, konrad.dybcio@oss.qualcomm.com,
        quic_tingguoc@quicinc.com, quic_rjendra@quicinc.com,
        kamal.wadhwa@oss.qualcomm.com
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add support for RPMHPD on Glymur SoC
Date: Wed, 16 Jul 2025 20:57:56 +0530
Message-Id: <20250716152758.4079467-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzOSBTYWx0ZWRfXx8NcNvx0Ly64
 gi/qwMitGiV+jWBDv/xsth6i7lD1AVeqb4K9TxeWby722wvw5oSP07yelIabUy6dNQVEJE7jk46
 7ixPHAaFkntwOCv567TxX1+xbNVVbe9yqXPI5lEzBfBVbkEN40N0IbjCED4OMyGcnP2NlMpEoMs
 6clNa86oKFC7piV74jc5T5/A2hmO7zy+Jobea0M1tVUvU73Gn8U0G1kbjCNpJg6/T/sE0tv0gL3
 mUASU9iHRvC+FOxFad5UZy8oyerHhpUZC2LHv767NkDhno9Z1wUP8ibemKSxvDGHsAZ4KZd9k9H
 7hnfv8fyV8nXpV/pQgYwCRnaIGJRXbaatvVfpYwJLNjf/WTSqFhMY/PkcvXSqTDZi0zOyMh/YA5
 LLsZf0ibBr25U4Qk8kE6FxCQ54Yhyf4bTY7GHz1oaLTZvU4B0piZoUPmxC45rLwTCj1OaU8K
X-Proofpoint-GUID: CUnfybp9ddJRIuJAVgioEhXhstd3Nv2Q
X-Proofpoint-ORIG-GUID: CUnfybp9ddJRIuJAVgioEhXhstd3Nv2Q
X-Authority-Analysis: v=2.4 cv=N9YpF39B c=1 sm=1 tr=0 ts=6877c50d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=76G38qL4IpClrheZAL0A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=891 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160139

Add support for RPMHPD bindings and driver for the Qualcomm Glymur SoC

Kamal Wadhwa (2):
  dt-bindings: power: rpmpd: Add Glymur power domains
  pmdomain: qcom: rpmhpd: Add Glymur RPMh Power Domains

 .../devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.34.1


