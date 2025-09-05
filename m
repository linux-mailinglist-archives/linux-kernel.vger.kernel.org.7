Return-Path: <linux-kernel+bounces-803193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBECB45BEC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF2A1887CCB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF1031B81B;
	Fri,  5 Sep 2025 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ha3gWJbS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4953231B800
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084733; cv=none; b=KDZykIAsHKDCZfz3KZv2FhqIKvBEuAHWtVM1KAaWyUvyRdiUTK+9fIKTNxIc1lLpZLvyblz/pwhuy9jVTkDnc3bWHpTVmR6q7ClPxEUY4JsaI/WpXlc+LiYIIwk26DhUEk+9diB4WoKMHQPIeYHQD2pPvanxxl7PkKgB9sN4I4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084733; c=relaxed/simple;
	bh=WC0wC8Q7sdcnE55UR77nZ9YhFbz8kmathVHMq557/fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lUgymURlzija/tXsEtNZH/H++QC3Ex43K9WuLPKKwn5kLtlZJGtOXKPnY0eeKw2h0CliqW9E4l6cyT1XlFPl9JNGw5XcYLXLE6fKwrZTGJhm6Td7KFW0mXVeQwOHWuUFXYSb4BVpcmssVpQKa4D61H/H/0sN+mhuBemPv2TD3EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ha3gWJbS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857BlKj008117
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 15:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=dfLc5hoIAeVv0LRPfL5wwCPsZeYeR0ugf52
	QpVAesm8=; b=ha3gWJbSz1VNvSmS/04o8DaHtDA28rx+/tSSudxsp9MH14BCbB+
	BExvOxFlV3f5VmpVQ68OacA0KytJzP93Q5C9emaM0DcS3fN/XCBjhz5nhg5fjrK9
	jU3+NYm1mmycDFp35Sa6BS8GYW9PweW4khuRziyvg4IWQjw6orNKAoxFYtm24SGg
	6y3xGixxnKdtPT8vtpOd9T5JDd6waobe9FZuX/70TV98V2Tf5VKcXqWUqv5/E8Cc
	UNcKcMLkhmPlRFsGrWPezk9ukMvMWPSZo+Hv7Wv/i/Ht65HpqzQaQ37ZSnBg2lGO
	5i930w1VUqPPHgFJs+exPp2wytNMnA4IZHQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjuf8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:05:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24b2336e513so36131495ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757084729; x=1757689529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dfLc5hoIAeVv0LRPfL5wwCPsZeYeR0ugf52QpVAesm8=;
        b=QZDZIOTpJ+qloKV30t7LSavtvm2Lc1hEygXktgnucF76fjyvzF7szsj1rKcj5u6ELc
         7DbqPakRHREwEl2wgAsiv9lOuX/qvDI5FH99M4w0LfbMqINZwZMtDFCoX4BFNWvOZzpx
         r8w2CBlUTyQOSMCgdQZmPrfuRvINffkdf8z/TuBk/4y42NUjfv7bby6wLHWuOFhiJEqr
         hTQCw1aRiAsdxH2XFneUr9ixFgxGEa2ojj28qhE7sOGm5YIHQRTzxoC6BHtK0Aa6fhNH
         r3ZBeKCF+jAGJ5V5V6rQhU/kZMUSNJ7oVI6jDZFEaEZi0cQchNWzh9FyRTB9o76SBNBY
         0Qkw==
X-Forwarded-Encrypted: i=1; AJvYcCV+5cPXtmeIk9U0xxQeOZOJNo0oqeLp0RW0lzDyk1SdzPTDEaMCkAZrt90g1vvGO850YHx2FJJFfJ3erEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdj7KLxqB1hZwIlydIGciB9cMguMAK+evGjbfCcApNLOv0EaeH
	QXO+0uuHJhJkHFloaLtQXPinfniDVZ02B7a4la3wjvzk2Iv1lygsVTEvwMLTB3PQtH774IQSsdH
	ruHMUXqOO33yCYpDuZXGXflys3aa2rkPIUFLwbUpXsBi3rtjq5Kb6mDWpJ1Av9dhHO3Q=
X-Gm-Gg: ASbGnctS/5vjK0He/zNZV76YRPtgKxXwlnThe/lvGFDmHEmDrBn8/pmRR0aHnPlB1Nw
	FGWS3cI70Bx0ijhKE+Oe/9V66whA8aGfxzWVWavpNyUS7SeISsiPSXtiJ0ZsfpMsq82WPZSRHi9
	uFqOQjYINB9mhSsp3Cnmk9qYsIR/5I7EJsSxipDWEXTJgPkw8PsMDxeUl3entZS7GcsqLPwDrGQ
	w08ghi7ne+wmcRyBde1tn2ME+CDPiq5qcIgtdWsYBsaxvCsn9Jg1SHjLE7sEix8AtbgurU8NxVi
	f5nytkMkwJDIUOeBgAoE6b50aDcklPZoqiywF2LwvcnLpcF6dCWTNwYgMTTLvGBE/RthTAWz1lf
	w
X-Received: by 2002:a17:902:c949:b0:246:edc9:3a80 with SMTP id d9443c01a7336-249448dce41mr332440525ad.5.1757084728366;
        Fri, 05 Sep 2025 08:05:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEur4fImbfHnLpDXHW5l9lSq6IXnaOlfb2z9L5MzDU+HmkU7aw7yrqcmOlzzf3CXuFiwl+f9Q==
X-Received: by 2002:a17:902:c949:b0:246:edc9:3a80 with SMTP id d9443c01a7336-249448dce41mr332439615ad.5.1757084727663;
        Fri, 05 Sep 2025 08:05:27 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcf04b8sm28882840a91.26.2025.09.05.08.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:05:27 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com
Subject: [PATCH v3 0/3] ASoC: qcom: Fix lpaif_type and DAI configuration for I2S interface
Date: Fri,  5 Sep 2025 20:34:42 +0530
Message-Id: <20250905150445.2596140-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68bafc3a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5HF5tzHaENt2U_M8s7UA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 1AHE3kX5fIAfYm0RGKeSz5L8aYRiOmK4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX/RH2kXbcrWeR
 B0nPSKBfdIXEZEd6dlF5AMCtT0IqIK5J4N5Bag+IS8olfftTwZroi3ziOgflhx73DXusZ3TXdr7
 5TcUC7u5i4F68J4N941tIhhd4GrFZKDGa8rtszWyWke7SE+m/eQug/ihKTAPxWqzQTDhDFjuUgJ
 iBczJ9C4Vp0h6zhF5eHyaUpIQrkRQSaLUnhS/T7UhdsEhRa4jVBa0YIP7uI0W3pIqH59LJgwjax
 4gkPncN58wgfawaVDc/FJMhj3qi4oTqMYyFKP072u7PMyJ8mO6JiY9bX2fmcoQaU7lOyCpU7A+6
 OmY/3Jze1E/es/yi7n0Snf1k6FhOb6KikIgwyUQbbQnp42KzXZus7jjmroBB60MkJJSNzYsViH2
 eIaUIPDq
X-Proofpoint-ORIG-GUID: 1AHE3kX5fIAfYm0RGKeSz5L8aYRiOmK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

Fix the lpaif_type configuration for the I2S interface.
The proper lpaif interface type required to allow DSP to vote
appropriate clock setting for I2S interface and also Fix the
CPU DAI format misconfiguration encountered during I2S
stream setup. Tested on Lemans evk platform.

changes in [v3]:
	- Added Cc: <stable@vger.kernel.org>, suggested by Srinivas Kandagatla.
	- Added QUINARY MI2S case in patch 3, suggested by Konrad.
	- Link to V2: https://lore.kernel.org/lkml/20250905104020.2463473-1-mohammad.rafi.shaik@oss.qualcomm.com/

changes in [v2]:
	- Used snd_soc_dai_set_fmt() API to set the current clock settings,
	  instead of the default WS source setting, as suggested by Srinivas Kandagatla.
	- Link to V1: https://lore.kernel.org/lkml/20250822171440.2040324-1-mohammad.rafi.shaik@oss.qualcomm.com/

Mohammad Rafi Shaik (3):
  ASoC: qcom: audioreach: Fix lpaif_type configuration for the I2S
    interface
  ASoC: qcom: q6apm-lpass-dais: Fix missing set_fmt DAI op for I2S
  ASoC: qcom: sc8280xp: Fix DAI format setting for MI2S interfaces

 sound/soc/qcom/qdsp6/audioreach.c       | 1 +
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 1 +
 sound/soc/qcom/sc8280xp.c               | 4 ++++
 3 files changed, 6 insertions(+)


base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
-- 
2.34.1


