Return-Path: <linux-kernel+bounces-736724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D65EB0A0FB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F6B7BB459
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9871D54EE;
	Fri, 18 Jul 2025 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N2Km+4oP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03CD1B21BD
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752835614; cv=none; b=iGVvN+8mCzWVtBsuW2x8Qabu5zRxp5zU04TPwG2u03H6Z+vlCXcDxiHBh8n89GVhdgDAU0t50pXVj15Y5x1Jymtk67kmIbtfo7Iu8BBrX33YltgzRLuPQ0qtPtl7p2jN1XICL9iiD+i+t9qfCgiVhGzGxWKKqt/a5bh8XAZ4PQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752835614; c=relaxed/simple;
	bh=ZCzgqQ5wClK+CpOspY0xkNzERE+nZ0OAJ4Bui5yuNYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IEd7VDqxtksFUOqk20eP72XtooSTr3EYWhjK84cM0mD8FpFed62pVcTelOE87L9Rzw9Rwj0SAjRdhQaSZ0ZpwZ5+NYlNSht783MPX6RzBAO2JuDqWOp5Cb8fDKjevnBnJtzqxmfHpNu62Yz9w0+8CcNw8JsHG87fPSz3gXzil5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N2Km+4oP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I9NicJ015963
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Ii7gkbQDsBKlsIJbbjCqaJyes15tBplO58P
	17UvUF84=; b=N2Km+4oPwfjpujrdM2mZ5jUpTNJuE0rWP6QSfUbBFuau6XKkLwc
	nG8KQ16CcGbpEwVptjno9cwKyk40YkDjgQzExwu6MW4qCarwbhABvOOPojVwlZnQ
	ieuOtDe+98BL78x58lW1NdVexVM8XB/hWzpqfaYt1KWyECZfUPrpXqifqPghOovU
	8+VER+xCszmMJXwaNR46NW0a9yjc4znlpLnlq0JbjnM1/mXYkn9WyRsRJon32m4W
	8FvFBfIN08vHnpp9l8LrhaP/oKBmQsJQvdphm6YSvmc7oyae5hkJtXmDiT5F10jU
	Fr9sChhiYHn5p1S4wSvfZKZ/6nchUY4l1Dg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47y3tc3293-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:46:50 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748f13ef248so2053247b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752835610; x=1753440410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ii7gkbQDsBKlsIJbbjCqaJyes15tBplO58P17UvUF84=;
        b=Poqdf0os1hJfObxEXwkJPftbVOiPZjb1vBp7bVb/iWmcw8cvMTLALIw5igkQ0zZu1d
         UcmvmlLugtmDLM7XbNJRiTZX7g84C8zRtBukdlJKMyVSjn7i7D/t80E9zlZxkTbPSfXK
         RfFGcaZHwwSe9lB1ngpKXz9yRNl0B3FK+IlMcRCS1JC6N+tHBNGpG9rRHo66pkA8FdGv
         fp8tLTgyf4FnY/dZGRLoJx4txZFnAFMkufVPlBlgNwXIXRk8uIlqyzHFZdjBa9LWz/VH
         YgLfhg8XsUy/JEuJCUw5nDdiNBxai0xMsqpNhkkg0IpJgL+lNg4wQynTb71sNfixLooD
         PNEg==
X-Forwarded-Encrypted: i=1; AJvYcCVs5uPiBBomhm3b7S17n6jm7POUJ4PjfhqxjM8oj7mOjOl8xCt6OrT2uFgaHqirnixmy1UGvAUUWQBpTYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiC5m9BHODNac89hrWdRaWkHVX2U36G7PZjGDkntUJotqXhjsM
	BLI8gJ8OLcbM/gInnlGkwJi6Wzj9Kj95KpdIQkmgWZkjeKhwtzRvpK2rsgA7uGulQtb/04+1jJg
	7v5nxAHnifZz8NYUb48Q0CDN3ULFcfqOygsCOLuQtaLWRtd2uN2vPotGe14MXNex7nh8=
X-Gm-Gg: ASbGncvPx8doU7GBxvqKoxq73xEVmV9DTZn6+KfNSB7NSyREJobNIQMoIOG1t7uilRL
	ktM2JrsbOatbZoQBhc+nC2WWqMHVf2Je/hQZQMc+uKANq3iFSH0xTHt21CEmMd6QecZ3x+WzlCT
	Yt0dzszjDz72KsCdbvZLb43POjd3bY04mYKLlHgq/McGQcH6vp1I3Da+4a8qXyUVRc089U95s7N
	8xjVVcb1EE2HYVIElO6Cfl8/KxSiHI7yrCieZW1Bvc3nXqkMJCdunsEJySeCBLbey4KNRGcizq5
	FkFWZeOzLgA59U5kzMfh4wcS1B8lKQb45qSW5n49pjjlzdqBiBYQPAY7NnamCZ7WuY8RUb1u9ns
	a
X-Received: by 2002:a05:6a21:648d:b0:231:6ba:881c with SMTP id adf61e73a8af0-23811d5b72fmr13279538637.6.1752835609908;
        Fri, 18 Jul 2025 03:46:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+oIQZv7zeP2XrajyPNGsv0HOcYRrzrBPX4o99YzxCFVD8DkN7dyHzSjoLscfcsLRkcELSfw==
X-Received: by 2002:a05:6a21:648d:b0:231:6ba:881c with SMTP id adf61e73a8af0-23811d5b72fmr13279503637.6.1752835609468;
        Fri, 18 Jul 2025 03:46:49 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb678cdbsm1028989b3a.108.2025.07.18.03.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 03:46:49 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, quic_pkumpatl@quicinc.com,
        kernel@oss.qualcomm.com
Subject: [PATCH v2 0/2] Handle shared reset GPIO for WSA883x speakers
Date: Fri, 18 Jul 2025 16:16:26 +0530
Message-Id: <20250718104628.3732645-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Z5PsHGRA c=1 sm=1 tr=0 ts=687a261a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=sKMTf-CTBu6bTl4tlAcA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: RWGEk9nbOmtIAWzaEsLilDolkoTkQGBF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA4NCBTYWx0ZWRfX1apRSgcEcf62
 JbQDQjTNbiXswKHcicPPsqB/J7x+ARQZVBgNCqdeOiOu4O9JhipB4Fx1b1uSUgeyNTtDytN+OlM
 74+uMAbBHCxD+B6VX84jNnBIF0VmiG7DaAJt0ZXwaQlfQ78/T+PYi/l5771zJA7TyVyXJkOh+l6
 vkWccFoHzgBMq1qJzIKQKMm6xorj8wUhjFTXGa5MFNppGJrWezbraR4CsmmF8l02LaHoC5AwSKz
 sEuQphNIw+CW3Vvbs6sO1hM2NjVYC06Dv5htqzFF80QCOZou+hSheio3dTkpHl5Lswun2okAs+i
 IlH2r7gV+WGDbJp42ysjkrClGZNiyqO5qjWXLfxk454cS8N6gGWZ/8a1y/OORh6zmjGfssVA2V4
 b/17QOH/JORVwd4DpNV15IKqzurQKN5R9koi4RCudyDN7v2Ld6BAAYAx8NBi2zxrALnzI99m
X-Proofpoint-GUID: RWGEk9nbOmtIAWzaEsLilDolkoTkQGBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=913 suspectscore=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180084

On some Qualcomm platforms such as QCS6490-RB3Gen2, the multiple
WSA8830/WSA8835 speakers share a common reset (shutdown) GPIO.
To handle such cases, use the reset controller framework along with the
"reset-gpio" driver.

Tested on:
	- QCS6490-RB3Gen2

changes in [v2]:
	- Addressed the review comments from Krzysztof, Dmitry, Philipp.
	- Used devm_reset_control_get_optional_shared_deasserted() api.
	- created deasserts/asserts functions to handle reset gpios.
	- Register devm action to safely disable the regulator on device removal.
	- Link to V1: https://lore.kernel.org/linux-sound/20250620103012.360794-1-mohammad.rafi.shaik@oss.qualcomm.com/
	

Mohammad Rafi Shaik (2):
  ASoC: dt-bindings: qcom,wsa8830: Add reset-gpios for shared line
  ASoC: codecs: wsa883x: Handle shared reset GPIO for WSA883x speakers

 .../bindings/sound/qcom,wsa883x.yaml          | 11 ++-
 sound/soc/codecs/wsa883x.c                    | 93 ++++++++++++++-----
 2 files changed, 81 insertions(+), 23 deletions(-)


base-commit: e8352908bdcd2d0bcf0aca8c69fae85fd5ea5edb
-- 
2.34.1


