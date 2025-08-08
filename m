Return-Path: <linux-kernel+bounces-759725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D63B1E1B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67CB0189C435
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 05:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22A91FC0F3;
	Fri,  8 Aug 2025 05:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="loOboYIY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A775C1FBE83
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 05:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754631024; cv=none; b=TauyX/unybBfeoECj8SZ3uam+yXk+amq2Whmhb3SLQkoXQAEBoCBoYhhAXwqdtToe8QP/80cRScgdaYkxC1fHket2/YX9p8NsCIKzFb9WkJr0sYUbi04EK6o8/lASHkYW2n8EYL9bekxixorekR1KS72lawinoLJU7bnTUYYk/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754631024; c=relaxed/simple;
	bh=Jd76TxLJDO6ktnTVki7hB04b124OqwCvlvXm+sVtsuE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KAWkAC3jUyLsSaRGtlFGpna2kJLXipOVt5bDktdHfw98PQDB1MDXzyTKfS1rYCO1vXrYnpgYFEVSX1EK+jbuAe3GhKicuy2ITjGfgk/MziUw3mRWuvke9Jd6N6UJ04mqCTCJE7SwTNn6GXAOx1TOwc/neI5jYijjZBId+9PI3zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=loOboYIY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577IAq7V018061
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 05:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8Car4PvODcLhqhbydD+z1uxMFD8WOqlwfDy
	1GI1vIzo=; b=loOboYIYcNiY4EYj1NpU+mpoGcaaQntaHilmAFXH2NpeyP9lDbs
	wqcnd6ZdF14ktVtV7b6kzD/A7KgpwAuCTTVjg07fIKtUF1Mctmq73bF98HG+MIvH
	3bafSzfLQw7cpH06rzhk/minn4W9fNr5jcCXJVaNcotYNn9TPMSUsFOoa8sgjh4u
	Kr6Oh3Fx3c7Pw6IUklGU+DNXTkFHoi9e6L4SrkO2sCpPH/yWkzClgKktyUuvUgYm
	ZVf++isdZEa+VruZaMtMrlh8RJqlm4SaB1UoY5a1HrySCja/YB0cTPg+CL7/t4Eg
	nBH7/4zOXomkd90rTR793lXZdPi1ePYteWA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48c586ea1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 05:30:20 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76bcfe2a8a4so1964079b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 22:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754631019; x=1755235819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Car4PvODcLhqhbydD+z1uxMFD8WOqlwfDy1GI1vIzo=;
        b=USEVIsJqurPJ9tGuuUzw7GjbJYL53U7xStwYii8i01LtniehENKFEWso78EeWjdAse
         9Acu35+aQ0GTrU5GjccnCqhccr/1SRnW9Dj8a3VJcOx7j5srb6DtQQzmsm2c132KRQEm
         NzcqphidKcOEd+2+b6vEDXCuMx1pijSqrU4cFFK5p36Ci5GNXUtfXFJ+1jwtFZRZot+O
         CNWTO/EPYaEbtniuVOg3UdTMk4BbMcFpF4dYnOLR/QlPF4SBfHc8qvvygKSwwb8c+Lbg
         L3gymv5EEdaKhCTwp4hiMXJ4zOM0vLUCYhWO4VUK9q9P1dYTL5QIMQsm66bBu6ZyB3ul
         16Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUyz1iGhFkssOFYND9OBl6CeXCOQGSmZYH3SUlb3GM2srnbF92sizrVaTbew3wfl4YEKl7gTr3tBNFVMsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXGiGSTt97lJnEzH9bZa/mxEXfY1QDdtHBWpZdB2MBsCF1VvlF
	1qjG9wFRdc1PSBHFZhLjk0GR95zGfW1WBAaUfeyGjpphjx/xOY57M4pLrllfYnMv4KcQZuGIWXW
	WRtjzaPdMXYh8zkrQrtxMAx7dEMX2Nh9qlH+MEjp2V7f57HPnJX/mTCjpH4xudgdy2I4=
X-Gm-Gg: ASbGnctlf1kup8lqVyAY9OHBnhO40AV2auzIEa0/2U8M8KrnUlT0OTHlDdaDl3FSxdZ
	Dbs4ToM3ZJxTdDFpe4fAzcaNe28yNisN6dKzfJiyM06fpZ4N4MeBmvxMU+wU53n0NM5Vsx0zN5z
	iKjMk2yS9WrVoD+w69ylL87wlLqU2urO0ULbY6gDxQJw2jvCghdi7lZNcSQMdujMDezK/0oyLGw
	meftVjSxWA8TA3uPKpLO0NMEfOD/gFTO87vsxSkcsTNpM3eKkXiH/Z46n+IqQSur4DbS/zYnaBk
	QS6036Wt6mGl3x3QCr7qlA94Dzu/H0iL1D72ZJ4uF9l6S9HsXWlzZXRz84Ksx7yw1I93ATdQEF7
	T
X-Received: by 2002:a05:6a20:7d9f:b0:23f:fc18:77af with SMTP id adf61e73a8af0-2405526b3d4mr2604488637.44.1754631019268;
        Thu, 07 Aug 2025 22:30:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2AX1odTQ7pYbDdG+vscDveuCfUt/q/c3s8e8DDzLhI/9qs3snSGEcgCMTUUe5hjWo6pSeVg==
X-Received: by 2002:a05:6a20:7d9f:b0:23f:fc18:77af with SMTP id adf61e73a8af0-2405526b3d4mr2604436637.44.1754631018849;
        Thu, 07 Aug 2025 22:30:18 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f483sm19278662b3a.31.2025.08.07.22.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 22:30:18 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com
Subject: [PATCH v1 0/2] Add sound card support for lemans-evk and monaco-evk
Date: Fri,  8 Aug 2025 10:59:37 +0530
Message-Id: <20250808052939.1130505-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Sa80F4nBk-FbT4pxmxt1L8WSSkkGcRKM
X-Authority-Analysis: v=2.4 cv=MZpsu4/f c=1 sm=1 tr=0 ts=68958b6c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=XcHJyV3jQw5NWJaZqmMA:9 a=zgiPjhLxNE0A:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: Sa80F4nBk-FbT4pxmxt1L8WSSkkGcRKM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA2NCBTYWx0ZWRfX6djY8Yxbibg5
 y29fbqI7spQ7QErQn2I6M0pdx19iMdKALzv2EHPq9CNl3xY78gztPVsAaZnjIKZhdphxm7PxLAh
 LnWrxX/2xSx7aVISoNshcBiJFrp1bV4/3lNpsYLTV1RzMSbxdRrp/QJJFeu0AkfWDTGaHIWO0WL
 3IYZ68ircpd7TQY4X0ZngzXf6GeV3otb13CUFsUHa3bGk3YadIxWppnOZK1o+2r4tOZkOf/zzeu
 JDkMObPeCtsZNhidafSn07ImNU0rtvhlAj5wFfM1xmAWqdBRE6ufyENUa9QRZ95FM3VfGtz0kRe
 h/1/W0x5ch/p1lmm97GNC+POKlb1mjmGoE8b+o11C3GPjb+gMVvxgkV9GsXY7p9H2N4/0F/cUGf
 LYW3t8yo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060064

This patchset adds support for sound card on Qualcomm LEMANS-EVK and
MONACO-EVK boards.

Mohammad Rafi Shaik (2):
  ASoC: dt-bindings: qcom,sm8250: Add lemans-evk and monaco-evk sound
    card
  ASoC: qcom: sc8280xp: Add sound card support for lemans-evk and
    monaco-evk

 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 2 ++
 sound/soc/qcom/sc8280xp.c                                | 2 ++
 2 files changed, 4 insertions(+)


base-commit: b7d4e259682caccb51a25283655f2c8f02e32d23
-- 
2.34.1


