Return-Path: <linux-kernel+bounces-802632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99929B454E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 172C17B7470
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4925E2D5C6C;
	Fri,  5 Sep 2025 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dJP4jSIu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396E02D7818
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068846; cv=none; b=qHXaHOPmFtQY8P9a+IlFbNsYu+tPNDJjsmIu+7yVaJvP7RC7pznza2cqO1z9qk+8Q4ITg56seAWguzVPkmIgEsziMNqluoprZWbpcrO/Ff5t1n1L+O1QeyPJycwyk3+hRL4le2TVgRBFVO83Xbbj0OTv0p5vfnJEwSlk46Ri86I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068846; c=relaxed/simple;
	bh=DHutDMB1AlF6Zj+BlaAR1mMwCOp39dMu529S9tVIn4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AG5jA90sjcEn5aUO4UDmMAcQEHM5+I9ZtROaQ4mxrfreKX2sR0D7MNEbGVGVK/aX+K2LyMjfc7Zx+mfhvhCWSHfQgLlLnWE9D8USNsm7ZcMQ4aqWwUG/CGs9Q9+44LnqwEKG9vPRk0DcCZObqSU+xs3MuB5IChChN2aJCmkYt7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dJP4jSIu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856vVuX007616
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 10:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=KTOjmQ5YZcnfoxX/wtE01OBjnG7ULxjk3k9
	cqZBH8gs=; b=dJP4jSIu6c3uON0HzdfCG0a+5pCTjSo1FfK89E6u8+n6lx+mIDX
	5SooKQuMNZ+ZmXjRfk/cTKmQ8PN/dQ5ZEsVtQzSc3MjBEG3J5mQceDjyob4fpZ8Q
	Uzhyx4XRbUdHD8lrEz1zgUa4l7+SB/IyDeFaHZT6Y2XZT1KE4ehTUJoJTT0lWhDg
	YN7I3YJrsCGj5i3PVN4JwA1HedAUkf4vO4+VtqRG0IOY+AkhgfAUCA4p3u4RwA4z
	TFeKOBhVFsHHGOa+sCeU3FvQGUVELOlx5qbtpmcCJMOEYgbxyJh3nG+709yfgG8Y
	cM5DQT4EB8yPOF+htYMckvTzE6xLP8FrdzA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura92q4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:40:44 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7724bca103dso1713829b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757068843; x=1757673643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTOjmQ5YZcnfoxX/wtE01OBjnG7ULxjk3k9cqZBH8gs=;
        b=JC+TDoGDlNSXGhmhWvoZU9qmcHbJDmjZFhzTrNEZQEonRC797INjd1yW5c1X/O0piC
         dNMmEY+UOhncS8UL/cw4ri5Pp/mLca4Vjjj6N0go+vMuerNUfKYxXOcz656UGfCl3Id4
         LnTR5heEQSSW5fgl2tn3UKL06w4IIns+REIeyKRpfS+mUpB+pAhg8J+szrWb5Hpt/X3q
         Ub4v7QrVVY2RnSLsO1oqQJqtyDBkdPg6HFEKdEu1QPgeKvNjfHnBPbMOZY4xWKn6tUgi
         Vr/XA/ti0Dutf1h+nEVZzTevKe+64q4vPjkGM5cf6ICAXC0n21hWdCCArIxjIvxAX/75
         KglA==
X-Forwarded-Encrypted: i=1; AJvYcCUmIFtK/lGGm13gqIqc0ysdSSX9lFdN6O/+xU2Rlm5B5YwYpK4HBPYHCC+ox65pAMqlHaekPzkKZ1IKJfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Bf5AJ6gn9yWwb+iLNTU6CUbr9jhDr+QbGDzanwKBmQ71Ro4k
	qT6Xl47YFyuQxEznP2nKrh9abdExSCS398vG7HqopAGxX0MbX8URFqiuenrM3jzC3LTp86iGzpX
	eV66PcVQWgQ42P24aP2o14RrhDwfkR/+s5c35OTZlpzwZOVr5yv016JH3YyKs+8pTpLg=
X-Gm-Gg: ASbGncsYjc+32bap9D+IxHFBuEv0cFjVn0cXipsoymn2xOOu5TILpeGgbDA1qLN6STe
	VCO7swBByDCn2karnB5pg+hJJbZnazSV00c+8DHnOPOB05DCjfZJZA6ciIur2DFRcrxVQETRVnV
	9ybmWcWizM42N9Ld+q5dsyK3Um6OKtN35zQHAtqWNqBF0/RBPbRmk9oXQrdfCi1NhxryudD0wNU
	gh9tQG0AZqqekTDWc9s+3EVaqdQ4UIQqUzv/jkXayd4biCfFd/hynbyb3h2lN6v/OJiQE2uiLpO
	ER4xl8BLDUVU2T8omeBg/DPG1l4dc0dVn25tD1iOO56f0hD0L0/qf8eslTnlfb5v63Gt8cHaoDE
	R
X-Received: by 2002:a05:6a00:b81:b0:772:301a:fbb6 with SMTP id d2e1a72fcca58-7723e342758mr26414378b3a.19.1757068842633;
        Fri, 05 Sep 2025 03:40:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+kvOTKtPmkE+qtmPs0DrM1pO5RsX4xLOd6KiyukaWHCJEsYx5miSGaqT9A7ydir/6LOnzww==
X-Received: by 2002:a05:6a00:b81:b0:772:301a:fbb6 with SMTP id d2e1a72fcca58-7723e342758mr26414356b3a.19.1757068842221;
        Fri, 05 Sep 2025 03:40:42 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a269e9csm21993859b3a.17.2025.09.05.03.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:40:41 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com, ajay.nandam@oss.qualcomm.com
Subject: [PATCH v2 0/3] ASoC: qcom: Fix lpaif_type and DAI configuration for I2S interface
Date: Fri,  5 Sep 2025 16:10:17 +0530
Message-Id: <20250905104020.2463473-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0Xa9JQ37pSJbP1C8kwM67s61renvbchL
X-Proofpoint-GUID: 0Xa9JQ37pSJbP1C8kwM67s61renvbchL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX6TtYrMVS+ppt
 kUlaM0nQz9BJOy/wgp8+IupBsO2lkf76CdWENXg9hCDN9H8EHZ0Dtfzw8Ch4nh71bVG2FtJBCTu
 89vy7PNCGi9BOve/VRlUrRxi4C0hkEyRURj/AYUfRO2PcQFD7Vo0cAAoAqxJJIFArWRYULhQnez
 QuJDOSLkgsD6Re3CBB9Yl01NmRHmj+RmeKB0rfQE7Bl/N79jBvoNOaYBUSfgqxgQltlaoOQtcT6
 B+ud8qgPWiV4UIzdoeXJM28CccZiDOxq1IuVD5GYQLCy3sBjDHBa9/Ta/bbvk1PLIplCpiqFanK
 ieCwHhjmATo5UjBBN2B10UdkdmOjEscUK1IeQ5j7xhDHdXL/UMStngLWx5wI4GeJ+weVCqs6jj7
 Cq1Tc9iI
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68babe2c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=KhSO6HZblKlzq0T7JtwA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

Fix the lpaif_type configuration for the I2S interface.
The proper lpaif interface type required to allow DSP to vote
appropriate clock setting for I2S interface and also Fix the
CPU DAI format misconfiguration encountered during I2S
stream setup. Tested on Lemans evk platform.

changes in [v2]:
	- Used snd_soc_dai_set_fmt() API to set the current clock settings,
	  instead of the default WS source setting, as suggested by Srinivas Kandagatla.

Mohammad Rafi Shaik (3):
  ASoC: qcom: audioreach: Fix lpaif_type configuration for the I2S
    interface
  ASoC: qcom: q6apm-lpass-dais: Fix missing set_fmt DAI op for I2S
  ASoC: qcom: sc8280xp: Fix DAI format setting for MI2S interfaces

 sound/soc/qcom/qdsp6/audioreach.c       | 1 +
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 1 +
 sound/soc/qcom/sc8280xp.c               | 3 +++
 3 files changed, 5 insertions(+)


base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
-- 
2.34.1


