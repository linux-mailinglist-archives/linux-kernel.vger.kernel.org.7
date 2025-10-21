Return-Path: <linux-kernel+bounces-862654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6934FBF5DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0848A3A1616
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2572332C939;
	Tue, 21 Oct 2025 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SXJfatr3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFA12F068E
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043218; cv=none; b=Ihjte9DSYhB+w1FksQ98HyAyD+RvqHKzK8LYW0mMeA8i0vPhCsN9X3YBGzGc09QNw/5H287GtXpwxjYkJup6/Uhu7VNCjvMgqX/WzMUaErSSv1CimTmC+36WAu+KJPdbbJZEB9qVDfWriWvrEkb6BQfkYaRjS1lBLP/hJ17wVY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043218; c=relaxed/simple;
	bh=0U8hAB45yH8EGsTy3EJNkB+JbnjcAFL7FugSc4yQ26c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H1Hs7w7MDGsA+uPSt2g22JzO4Xd4Etc/mBlXweMNxUmdMFqW4AAgx90jWdpfRTd4IFwL7agiqi8t9TpijznSMN0Pg2nk72Y7jzPNNIr/9uREI7CBhu+J7Vs9VonzGTlJC/xCidiHIjaAiJiiPvb/NBaJtks6kO70TKiEu9IAI3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SXJfatr3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8NCSJ018763
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=EbXFKjfP9YV4IPAFXNS5yLFyAT4bZfexbjP
	y0N72g9w=; b=SXJfatr3apnPlPBnqM8wKB0PoiyDlgDFs09jgJ2elDGlV/PTeqB
	vK8qBrm+1bPX0AdzYNCMXzPU4KXl9UVQQiwm+n9OxutRPfwWidOdDKIY8a65ckhZ
	7a+iyrVy3QmixHEpg1+WeyB57BeJNQXgiNTXbXdrkjM4Ho0cVSToBaf84vutvTfa
	l2h/rou3aeRxnBTv7Tf/hDkvt2FfrNhg4nqk+Ebm0g69XI5hJcqcbV1zDXW2HLG8
	HYm9EgrmGKB5o7AEYPF3lj0jRP+vdCXnWPs8goDGHwMBL0nVR3UtgKPY7fEuS1U0
	JEMB9SmF2ZlqGHzwHsHg/cQwyop2wX9voEg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469g9ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:40:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8908a248048so796092385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761043207; x=1761648007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbXFKjfP9YV4IPAFXNS5yLFyAT4bZfexbjPy0N72g9w=;
        b=ieRjscueV4klVlTwrKh5Gu2B8idwmBfd4ztVVznaPyQ9pP32cG+BHIFQH/lnDDCCUK
         GNbhFXdStWifxxgaKh9tUUCTQCDsKVXpfDcmy1Yf+FGdzx2c7ee9hU3ULUrFvArIXwJN
         bOH8vJBFBVYlDibpAUGjuPdWJPqh8DX1aMqx7Um2hcakKD37ezeyuNP9oPwOhbElP45w
         idktuIvuybMOkpR7KwEd5jNHOSds21NjaoKpxCNaZzuPqC94BAF5zlDfCts7Cbeax4rw
         VSprS66RcHRnlEL6QZIVZ8pjNWWk44DVP2TibiifR+YUXzLq6kThaxCp14EWKhxx/kHs
         ZwFw==
X-Forwarded-Encrypted: i=1; AJvYcCWeNsHPYs3y80HRnEPCQ6A2YUCdaEIDwjruZi7vHZrr3yTPhbfrqH2X+ByHwUo79wk6UUE1jlhchlanLzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmtB2brxK2Ezj2BrbqwSMNwBCfplbSE96zpHPERioN9oKOCQ+g
	gjKLnwatWatBopWA6WJm/d+vq3wzHwzhNGsgxAd6AYTSAJxuZr5vElTfv1nujPELYmxyYZcxlwR
	rssYZxOgRBzGryskpnLRMEAbbB1n093VF1J76UlRpCuHBS/w5dEbUDEauCg77254y+10=
X-Gm-Gg: ASbGncsULKKeaHwk1Vw+AkAKr7etMeiB29cPV9ubVPbmvoBuqrm+X6BPmz88Dsmiwxh
	sMR7VJAq4Q1nil4jQisyG5ypiM+dL6thlHMjXa7VVDSQT3DKLtq//+Awl+5pI5r74gEisGRIISq
	tAI7O1aF26e5JalL5+XFdJk9nl9cTiaEhB86VMj0scPKsUfw4QGzbiYxybSWaku+3oTkpkDWlbR
	EgbLHCykPbN5M1gkXq7Gp6unZBNxcRwgKGJZnkwbgwIAAfcB5aQzue0tHXK7Pg61wLINAe3QqvM
	LstTAhbJ5N766sb+Yuk9pt1ylEe9Dm74wd/zRUVYR7uH5Kc4LDwmXwvb2VqXegJwi/+VzqoqWiy
	1BA+qzE735AyK
X-Received: by 2002:ac8:5a11:0:b0:4e8:b55f:af22 with SMTP id d75a77b69052e-4e8b55fb2d4mr121141781cf.53.1761043206564;
        Tue, 21 Oct 2025 03:40:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK7ENmoHQ2RT/4VjoSrYVZ4wOzzLy46jV66xunwwgH1MxVbYZONvkuQCmOMnkT2v/D3Mvg2Q==
X-Received: by 2002:ac8:5a11:0:b0:4e8:b55f:af22 with SMTP id d75a77b69052e-4e8b55fb2d4mr121141551cf.53.1761043206041;
        Tue, 21 Oct 2025 03:40:06 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a976sm20087938f8f.32.2025.10.21.03.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:40:05 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 0/4] ASoC: qcom: sdw: fix memory leak
Date: Tue, 21 Oct 2025 11:39:58 +0100
Message-ID: <20251021104002.249745-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RL9F47AQd6299yqnbnUvq8LF5IPwcoq9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfXx51Z4iX/YZJN
 Wc9KxIC3b+02/0O2K/jQrOmiSa83viS1v3xeRydkrjeqrbq4FIwCnIxVmqM3Icz1DINaS1PT805
 EmU0O6CDzhKrdxAguIprkYUNISkb314F+fdeGyTsMyHW5IzlnCY5V/DDVRvBOXL4rz1ET8AyOIK
 5fkzJOUI7t0zsxU0o5AFMyXL4uXUeNWz1CcmXnQNYW8r19ukhfFqcWeoaKV4kZ53QYPcNeWHUc9
 pI1xOU1kEwCLi7epxhTAu42DEtep6pCK0VfAAhNhflx8ncfURXJFTk9etRlQOSJ3Iknv/5KRnqq
 VliiVLxGYf3f2xLXbK2AkXtxbDN8mup0hdnYRccx3nfwWJt/IQEfdZvpR3YWphl0mxFGsuWAKpf
 0NdWBl1Y9xIER+DY0wqP8IJbNIT/5w==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f7630f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Tmn-ty_kyiCvGlHJeRgA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: RL9F47AQd6299yqnbnUvq8LF5IPwcoq9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032

For some reason we endedup allocating sdw_stream_runtime for every cpu dai,
this has two issues.
    1. we never set snd_soc_dai_set_stream for non soundwire dai, which
       means there is no way that we can free this, resulting in memory leak
    2. startup and shutdown callbacks can be called without
       hw_params callback called. This combination results in memory leak
    because machine driver sruntime array pointer is only set in hw_params
    callback.
    
All the machine drivers have these memory leaks, so cleanup the mess and
make them use common helpers from sdw.c

This patch series fix the issue, and while we are at it, it also remove
some redundant code from machine drivers.

Thanks,
Srini

Changes since v1:
	- added missing dais for sdm845
	- moved all the machine drivers (sdm845 and sc7280) to use
	  common helpers to avoid memory leaks.

Srinivas Kandagatla (4):
  ASoC: qcom: sdw: fix memory leak for sdw_stream_runtime
  ASoC: qcom: sdw: remove redundant code
  ASoC: qcom: sdm845: make use of common helpers
  ASoC: qcom: sc7280: make use of common helpers

 sound/soc/qcom/sc7280.c   |  67 +-------------------
 sound/soc/qcom/sc8280xp.c |  33 +---------
 sound/soc/qcom/sdm845.c   |  53 +---------------
 sound/soc/qcom/sdw.c      | 127 ++++++++++++++++++++++----------------
 sound/soc/qcom/sdw.h      |   7 +--
 sound/soc/qcom/sm8250.c   |  33 +---------
 sound/soc/qcom/x1e80100.c |  33 +---------
 7 files changed, 92 insertions(+), 261 deletions(-)

-- 
2.51.0


