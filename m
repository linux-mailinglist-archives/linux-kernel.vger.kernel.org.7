Return-Path: <linux-kernel+bounces-743262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0132B0FCB8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A95566AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BB5271A6A;
	Wed, 23 Jul 2025 22:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IQY/7LQT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D83D81
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309673; cv=none; b=FDVdFEdWbRxiRwt/e4alaCoJd95LPzQtB22mz565UO47zoWwRWjAuztpEUeuZnND980sDWMKroq3MJKR5dsVa0KyIb6+iedItnKKF07qcYMCgB83EO7WPkEC26pFau1mThufhHOyc5ytU2BXzArzf9eRoENBSzFY7fzyJ4OpKf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309673; c=relaxed/simple;
	bh=ml/nSyTS4nfNiVoXhTw4+0kOFaq7KatZVFjsGfHaznU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NiY7AjG0XeCrWZ7FgMjq/ixdv/VcsvJM1kgmLhvWy7N2/FkryhS5xKZD6FIiRmiKh1OVXwicq8SksJ+CCFJtpJ+4icCRoMhQKviywKFkz7v2lDGyVLV4SYr0XIOSN/QwLQXIsb7dYvBzDzd8eHpA9FidCX/y+YVmIslabhvy1Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IQY/7LQT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NGmboA010356
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=tCWhBevTdE4kvZRMnxa1E9d5Kc39rrSpZ3A
	+p8Y4ZLE=; b=IQY/7LQTRxJnXzgIJAzOsr67iXJwDvb6tMffxSQj4MlnmV/eOUV
	/SY+EO6dM7wOuEvYrQjD0leZApBG4wSSnFLhmxe+VslSWcDWDd721SYIk/anEvZp
	tLkPwxLF4YztS88R85SwIb3xHQ0fwBedHooxwMeCiUEjEeJI/5shJSlKafN8xzia
	gSFs0hVVsSJRUV9m1K+Hn0B8wyGeo6fyk6noeNCLSL2A2UCibBPdCdduQN8NAm+h
	s3cyTHQQSmm4/aINRqsVujKu94toj34C1hidR7IdAT+Uap4hTzF4GW65T45Y5uTp
	mpGJ8YWrQxCv3sTWlHwBql8oT4EATlOO1Ow==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na552g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:27:50 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-704b4b61d10so8391706d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309669; x=1753914469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCWhBevTdE4kvZRMnxa1E9d5Kc39rrSpZ3A+p8Y4ZLE=;
        b=qO1gTGKISILLexebaEBHuSawN9XLiFsNd/TAw8Y14nuK0FuHIqgMl6YN9flTM2dqIO
         /xvKKrsLSumWZV/lMpq/YvoMvI6Kf/WKSAoJ5b4IBiSJd0jeI8HnJTQF2bjZo3ORlngi
         QFu8+t02iEjaYODG1vb3Za360c3msIptyq8xdgIn4GwsZEvlX6/y7S5m8o8NZGqHnTdo
         ZePmHD3exrfiIiFxSp08AopiKQD/yXiGi+UbLIPACajlIiN+UgAVImxGt2LZlpE2aMJh
         gbuWTYsa7nn0T38HHXxXUe57KWsUpHfdcsb9y3nBgKrU7UY1fqmSX206GRo4pUqhD+K6
         oH2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcqPsNQEfe0wYNB54kVw8tJg81vw3berXhZkIuqZtNzoWi/s3+vY9idlQgbJDSO8eehvwMvcvkDrtKXvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBvKVlVcdU+kDJN0HzNdlEWogBjTuT20Zwo8RfOdsPItvupv3h
	IVgA2WiJtpCiwzt6N49v9l1kx0mKipB+GnotXjMAe7GEMdCx/pqILX9q7S59jRG5FZj6l2LGA8s
	pwMcl65a5nZk2sBSytIr8TwUPwSngYETKCvzfGKGUfEh24BQz1yX4bXIArHKGrBbQl1k=
X-Gm-Gg: ASbGnctTnAtC8sVAZEgeKUqzCXsm9KEoTy44TVdUBolZNrSNvcMkNSSXDO4pDpVhqYn
	B/x9RpILsW98MGS3i0FddQ9PVh+0Z6ar1KKTxlQHqjyYVCdVz8yAwJACDkn9NCQxmNPfS6XRfry
	9anbh6FZVGqO9L51wsBVUwJda8sXVBb+Yekn9fIqyBPxp2XvOQ3YwZ0K+qD1R1Ln9/9yMakdd4+
	5/6n18kN6znQbJCBZSD0lz7Vrqvsuy7Vco39d6fV9gCsXdIf3mjtnmVe2LZ4UcGUbQXc/CGXeMl
	qWeItlfd8TVTBlMKHyRpsql3yAjnUlZkQYJnqlqpY2O+pAnh29bvWg==
X-Received: by 2002:a05:6214:27c7:b0:704:f952:3d66 with SMTP id 6a1803df08f44-707006a3e74mr56004576d6.47.1753309669342;
        Wed, 23 Jul 2025 15:27:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoTPc6rZ3A4sCYOQY6hqoF6vg5g7pJJHVgRIc7sboGdJqU/JZ/MgA0NmBi5HBfF4TKbldvJA==
X-Received: by 2002:a05:6214:27c7:b0:704:f952:3d66 with SMTP id 6a1803df08f44-707006a3e74mr56004156d6.47.1753309668752;
        Wed, 23 Jul 2025 15:27:48 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm248520f8f.44.2025.07.23.15.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:27:48 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org, konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 00/23] arm64: dts: qcom: cleanup DSP audio services
Date: Wed, 23 Jul 2025 23:27:14 +0100
Message-ID: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: L7juKZtKtTL8q4g3V0PyT2QXuWjgoPTv
X-Proofpoint-ORIG-GUID: L7juKZtKtTL8q4g3V0PyT2QXuWjgoPTv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MyBTYWx0ZWRfXzHIpbp8r1P7q
 KqacNcCIafq3wODT9k73PgxJIbgbsUKoa10MFc4Q7LucVnwy0rd0+gEVzQCOEad0kJ0SacTB8Ch
 20ToGhBA8gDSI8KMApYqSbt0YFSR4VeBG5G+Vz6b4dHMzLD32ijgB7txn3UJk6iGJnXxMIGsn0G
 2HlDzkbhezEgO/5j/vShib1Pvw5mbuCYbkfaVHBrqfM7h0c4+JutbIOjY8YeMLPIX3ApViCkj86
 JyDbnBbjnOa1GM6IrcPbQPQtpTChAykdm27anRZo/ogAZIEahLZ4SoULaZxMSdboF2Os9CfyL/c
 0YxXg/8AaycfgNvWN2RWMrYjccxvSU9YSarFvdkVzFEquGR8lIMprjgpIquLjvBKS4TyYoSXUUP
 3XKiYD0EVr1BWB/ZegaHJUigqRvgUIS8sy+rentjhuupPoiiSgvCgDaTgrdHW6GqpsnaBqVu
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=688161e6 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=CqbkFek1id5cHgMPXAcA:9
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=970
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=2
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230193

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

All the SoC level dts has exactly same device tree entires for DSP Audio
sevices (apr, gpr, afe, apm, asm, adm) and its child devices.

It does not make sense to keep copying the same content over and over
for each SoC, This patch series moves DSP services to common dtsi file
so that it eliminates duplicate content,  makes audio dts much consistent
and makes it easy for adding audio support for new SoC.
As part of this cleanup, two common dtsi files (elite and audioreach)
based on q6dsp framework are added and a SoC level audio.dtsi needs to add
the required iommu configuration for the audio stream service.
 
This patch series also addresses another issue found with multiple
instances of wsa codec macro, his can lead duplicate dapm widgets
and mixers resulting in failing to probe sound-card if both of
these instances are part of the dai-link.

Tested this on X13s, any testing is appreciated.
   
Srinivas Kandagatla (23):
  arm64: dts: qcom: x1e80100: move dsp audio nodes to dedicated dts
  arm64: dts: qcom: sc8280xp: use dedicated audioreach dtsi
  arm64: dts: qcom: sm8650: use dedicated audioreach dtsi
  arm64: dts: qcom: sm8550: use dedicated audioreach dtsi
  arm64: dts: qcom: sm8450: use dedicated audioreach dtsi
  arm64: dts: qcom: sar2130p: use dedicated audioreach dtsi
  arm64: dts: qcom: sm8350: move dsp audio nodes to dedicated dts
  arm64: dts: qcom: sm8250: use dedicated elite dtsi
  arm64: dts: qcom: sm6115: use dedicated elite dtsi
  arm64: dts: qcom: sdm845: use dedicated elite-audio dtsi
  arm64: dts: qcom: sdm630: use dedicated elite-audio dtsi
  arm64: dts: qcom: sc7280: use dedicated elite-audio dtsi
  arm64: dts: qcom: sc7180: use dedicated elite-audio dtsi
  arm64: dts: qcom: sm8750: use dedicated audioreach dtsi
  arm64: dts: qcom: msm8916: use dedicated elite-audio dtsi
  arm64: dts: qcom: msm8939: use dedicated elite-audio dtsi
  arm64: dts: qcom: msm8996: use dedicated elite-audio dtsi
  arm64: dts: qcom: sm6350: use dedicated elite-audio dtsi
  arm64: dts: qcom: msm8953: use dedicated elite-audio dtsi
  arm64: dts: qcom: sm8450: add sound prefix for wsa2
  arm64: dts: qcom: sm8550: add sound prefix for wsa2
  arm64: dts: qcom: sm8750: add sound prefix for wsa2
  arm64: dts: qcom: sm8650: add sound prefix for wsa2

 arch/arm64/boot/dts/qcom/apq8039-t2.dts       |  1 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts   |  1 +
 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts  |  1 +
 .../arm64/boot/dts/qcom/audioreach-audio.dtsi | 45 ++++++++++
 arch/arm64/boot/dts/qcom/elite-audio.dtsi     | 86 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8916-audio.dtsi   |  5 ++
 arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi  |  1 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi         | 44 ----------
 arch/arm64/boot/dts/qcom/msm8929.dtsi         |  1 +
 arch/arm64/boot/dts/qcom/msm8939-audio.dtsi   |  5 ++
 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi  |  1 +
 .../qcom/msm8939-sony-xperia-kanuti-tulip.dts |  1 +
 arch/arm64/boot/dts/qcom/msm8939.dtsi         | 44 ----------
 arch/arm64/boot/dts/qcom/msm8953-audio.dtsi   |  5 ++
 arch/arm64/boot/dts/qcom/msm8953.dtsi         | 78 +----------------
 arch/arm64/boot/dts/qcom/msm8996-audio.dtsi   | 14 +++
 .../boot/dts/qcom/msm8996-oneplus-common.dtsi |  1 +
 .../dts/qcom/msm8996-sony-xperia-tone.dtsi    |  1 +
 arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi    |  1 +
 .../boot/dts/qcom/msm8996-xiaomi-gemini.dts   |  1 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 48 +----------
 arch/arm64/boot/dts/qcom/msm8996pro.dtsi      |  1 +
 .../boot/dts/qcom/qcm6490-fairphone-fp5.dts   |  1 +
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts      |  1 +
 .../boot/dts/qcom/qcm6490-shift-otter.dts     |  1 +
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  |  1 +
 arch/arm64/boot/dts/qcom/qcs8550.dtsi         |  1 +
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  1 +
 arch/arm64/boot/dts/qcom/sa8540p.dtsi         |  1 +
 arch/arm64/boot/dts/qcom/sar2130p-audio.dtsi  |  5 ++
 .../arm64/boot/dts/qcom/sar2130p-qar2130p.dts |  1 +
 arch/arm64/boot/dts/qcom/sar2130p.dtsi        | 40 +--------
 .../boot/dts/qcom/sc7180-acer-aspire1.dts     |  1 +
 arch/arm64/boot/dts/qcom/sc7180-audio.dtsi    |  8 ++
 arch/arm64/boot/dts/qcom/sc7180-idp.dts       |  1 +
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |  1 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi          | 56 +-----------
 arch/arm64/boot/dts/qcom/sc7280-audio.dtsi    |  8 ++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  1 +
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  1 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi          | 68 +--------------
 arch/arm64/boot/dts/qcom/sc8280xp-audio.dtsi  |  9 ++
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  1 +
 .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts |  1 +
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  1 +
 .../dts/qcom/sc8280xp-microsoft-arcata.dts    |  1 +
 .../dts/qcom/sc8280xp-microsoft-blackrock.dts |  1 +
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 38 +-------
 arch/arm64/boot/dts/qcom/sdm630-audio.dtsi    |  8 ++
 .../qcom/sdm630-sony-xperia-ganges-kirin.dts  |  1 +
 .../sdm630-sony-xperia-nile-discovery.dts     |  1 +
 .../qcom/sdm630-sony-xperia-nile-pioneer.dts  |  1 +
 .../qcom/sdm630-sony-xperia-nile-voyager.dts  |  1 +
 arch/arm64/boot/dts/qcom/sdm630.dtsi          | 45 +---------
 arch/arm64/boot/dts/qcom/sdm845-audio.dtsi    |  8 ++
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    |  1 +
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  1 +
 .../arm64/boot/dts/qcom/sdm845-lg-common.dtsi |  1 +
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |  1 +
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |  1 +
 .../dts/qcom/sdm845-samsung-starqltechn.dts   |  1 +
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    |  1 +
 .../dts/qcom/sdm845-sony-xperia-tama.dtsi     |  1 +
 .../qcom/sdm845-xiaomi-beryllium-common.dtsi  |  1 +
 .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |  1 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 49 +----------
 arch/arm64/boot/dts/qcom/sdm850.dtsi          |  1 +
 arch/arm64/boot/dts/qcom/sm4250.dtsi          |  1 +
 arch/arm64/boot/dts/qcom/sm6115-audio.dtsi    |  8 ++
 .../boot/dts/qcom/sm6115-fxtec-pro1x.dts      |  1 +
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 69 +--------------
 .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  1 +
 arch/arm64/boot/dts/qcom/sm6350-audio.dtsi    | 17 ++++
 .../qcom/sm6350-sony-xperia-lena-pdx213.dts   |  1 +
 arch/arm64/boot/dts/qcom/sm6350.dtsi          | 62 +------------
 arch/arm64/boot/dts/qcom/sm7125.dtsi          |  1 +
 arch/arm64/boot/dts/qcom/sm7225.dtsi          |  1 +
 arch/arm64/boot/dts/qcom/sm7325.dtsi          |  1 +
 arch/arm64/boot/dts/qcom/sm8250-audio.dtsi    |  8 ++
 arch/arm64/boot/dts/qcom/sm8250-hdk.dts       |  1 +
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts       |  1 +
 .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi |  1 +
 .../dts/qcom/sm8250-xiaomi-elish-common.dtsi  |  1 +
 .../boot/dts/qcom/sm8250-xiaomi-pipa.dts      |  1 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 53 +-----------
 arch/arm64/boot/dts/qcom/sm8350-audio.dtsi    |  8 ++
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts       |  1 +
 .../qcom/sm8350-microsoft-surface-duo2.dts    |  1 +
 arch/arm64/boot/dts/qcom/sm8350-mtp.dts       |  1 +
 .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   |  1 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi          | 67 +--------------
 arch/arm64/boot/dts/qcom/sm8450-audio.dtsi    |  5 ++
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts       |  1 +
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts       |  1 +
 .../dts/qcom/sm8450-sony-xperia-nagara.dtsi   |  1 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi          | 40 +--------
 arch/arm64/boot/dts/qcom/sm8550-audio.dtsi    | 10 +++
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts       |  1 +
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts       |  1 +
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts       |  1 +
 .../boot/dts/qcom/sm8550-samsung-q5q.dts      |  1 +
 .../qcom/sm8550-sony-xperia-yodo-pdx234.dts   |  1 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi          | 45 +---------
 arch/arm64/boot/dts/qcom/sm8650-audio.dtsi    | 10 +++
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts       |  1 +
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts       |  1 +
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts       |  1 +
 arch/arm64/boot/dts/qcom/sm8650.dtsi          | 44 +---------
 arch/arm64/boot/dts/qcom/sm8750-audio.dtsi    | 10 +++
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts       |  1 +
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts       |  1 +
 arch/arm64/boot/dts/qcom/sm8750.dtsi          | 42 +--------
 .../boot/dts/qcom/x1-asus-zenbook-a14.dtsi    |  1 +
 arch/arm64/boot/dts/qcom/x1-crd.dtsi          |  1 +
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts  |  1 +
 .../qcom/x1e78100-lenovo-thinkpad-t14s.dtsi   |  1 +
 .../dts/qcom/x1e80100-asus-vivobook-s15.dts   |  1 +
 arch/arm64/boot/dts/qcom/x1e80100-audio.dtsi  |  6 ++
 .../dts/qcom/x1e80100-dell-xps13-9345.dts     |  1 +
 .../dts/qcom/x1e80100-hp-omnibook-x14.dts     |  1 +
 .../dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |  1 +
 .../dts/qcom/x1e80100-microsoft-romulus.dtsi  |  1 +
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts     |  1 +
 arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 43 +---------
 124 files changed, 401 insertions(+), 946 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/audioreach-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/elite-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8953-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sar2130p-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sdm630-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm6115-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm6350-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm8350-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm8450-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm8550-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm8650-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm8750-audio.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-audio.dtsi

-- 
2.50.0


