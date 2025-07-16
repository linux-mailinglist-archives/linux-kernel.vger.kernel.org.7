Return-Path: <linux-kernel+bounces-733515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AB5B075B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0D9507C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB272F5097;
	Wed, 16 Jul 2025 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X9WP+4DC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345942F3C31
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669212; cv=none; b=qP7lMK9wZszpiSXad1UOkLJ6xlOMIJWFJuM5ShLbjJ7G/KXzZDJSi2Tfd7cKYfsn9uoRKo3hw5y4Urcz/X0q8nQG8gi09hA6W35/kY+3RcQvZE6W8G6wON/MbNjn/PVIJEcGmqMbr7sIQUbsdCvBGwXfB5zW4R+2hSLl372U83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669212; c=relaxed/simple;
	bh=js0Yh7zWjepjcGAJhsG6IlvWE80VSXdh9uM5B/1KfIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rTQXoUetmfPznVUbi8vypO6oShUGvkbVZ8VwoIS8O9LrQmWKd6gmr09iP54SeemgWgggZybdEFhG81pDe2kczLGa/iP5/02EsubezNjFW9xd5n6N5BOiP+cxMKWVh/uHsvaf5DGrO0bBF8IJvrW599wIb1LfXjvz0NAfm1WiXaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X9WP+4DC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G67Bbo007291
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=6dl8L70xm1HlStY566wq1OfeEIWB7ioldI4
	dZagkJzA=; b=X9WP+4DCcgGkip/bAqz8I0+P4m7UMaiz2rhRBxny0b8mahUe5xi
	TqcPlaT1oHCh1mVhM/+6vxuVPkVQxqw76myMjfEZ/PbBDd1gbYdjwKY8Iy5bDeNm
	HBQMTmFMXqDlqevTOrrf5ViIN3xncXr7M1Jk8RJgNSxDkSDJh9G1QvRrV/bhBIW/
	Gu1E0X2ECljAM7KrtSQWO1esMkLTTEpNeFa3HtH0DSd4oSwhNRm+GeW10giQVO/r
	ldQwjjIMR63+2L9iOcOlmDulj7v9ut+MLI0vNgXQN8GPva6p8vyi5KeqtywSUFEI
	ugOZmHbUR7iBgDKrHisWmZEGaa4WXTbuZAA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh5v2a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:33:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e333fae758so562767285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669209; x=1753274009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6dl8L70xm1HlStY566wq1OfeEIWB7ioldI4dZagkJzA=;
        b=tluoAvPnxbQ2ufdMGGGKzJfMBlKenWhc+D3xE0yN3qteWzaJnwJMG9GymRKsdLLl6W
         GPba3ruDnHD6cTNYZSViecyx6Bz3v/9+HPl45AdP11myz1qkzQmbNNZcQYx2kLizqvco
         /vXabLBQQ/PWkiKDKJbNF3w98QVAL0e25BQjLQyR/zhPkIlumhpLGd/nuztfLDinDzyS
         wEB+rqGQApsqnf4Csr/ZfvbcnXZOQI+eZI0mE8WtPnRZTW5CBPqZGfJ31ILag4tXs1lP
         WtXqKbfM3pu+v8nLwMwE4m/lsgkquIFf6I1jTCu2YdASr1OZ49nnKYhOzJv2NLRwc3w4
         0y6w==
X-Forwarded-Encrypted: i=1; AJvYcCUhUWaAJFWR79R91z3AkaBdDwbPqxNPUB/NjOyC5+L/5UlGPTpHt4AWlOitTuwHeIRov7I0dSP/6+NI26M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRljnNuX+g9nSg3Bt9Hu9gQsdLCbxQseGeUJnmGnqckp3zaGzj
	GgfN7bLafGjCIYsEbn5rxviJE+SdrKjjwSH08mBbTreunjEdb5H3fzaniCZWBcbVgD855vYBlks
	w3JRSSERXzUBm3+NENrAYdIhbsapHRuDzI45tQZV4L2w/F2kepRLB801BgRMWkxZqR4Y=
X-Gm-Gg: ASbGncs92D9tDBA0RqEt/qTvp3DqqUSNERvZof150ky457Lu/87IbK8VqxX0WDEtzqO
	aZDAhCUNvNxMjCrTUetiOGw7fd58w0Mv+wyT1DTyZD09ZioSylP82vEbqFPMmwIfwbzN+RjuJ39
	P+xGZ03h59WqcE5zTUlDkk3ejqzDIhuGxYOvWlj5bc3afvkzXuMGTqO5W/vzBmeFdWx7IODxnsr
	rwJwV2y7uE7D6oW4QcwTlQ0nH09TDP+ZLDYkBF3gXvUwBjwAfiXLEN69abKe9+wchSi7PaZwp4Z
	RjPmOLSO8+SnxxUKveNzVhVIF6tuPqhwpjViaS/q4PEfABfa5td8Wg==
X-Received: by 2002:a05:620a:2681:b0:7e3:16b7:bf26 with SMTP id af79cd13be357-7e34334b831mr347069485a.4.1752669208855;
        Wed, 16 Jul 2025 05:33:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6xtwwfW8AddMhJZGFRGstSkga85qp3uQ6/xodWuP1paQp/Pn/v4wA1DQuvRudLT9g1U2RYw==
X-Received: by 2002:a05:620a:2681:b0:7e3:16b7:bf26 with SMTP id af79cd13be357-7e34334b831mr347063785a.4.1752669208186;
        Wed, 16 Jul 2025 05:33:28 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e89c739sm19453335e9.32.2025.07.16.05.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:33:27 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 0/5] ASoC: codecs: wcd93xxx: remove code duplication
Date: Wed, 16 Jul 2025 13:33:18 +0100
Message-ID: <20250716123323.5831-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=68779c1a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=OLL_FvSJAAAA:8 a=EUspDBNiAAAA:8 a=DXjLId-kC2nHtiOjzpQA:9
 a=sPFwb3Qtu_UA:10 a=kl_IBrakYWIA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=oIrB72frpwYPwTMnlWqB:22
X-Proofpoint-GUID: jWdLg_Kr0J42HMU5tr9N1lKRCinZi3RG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDExMiBTYWx0ZWRfX7kGeKJg233IE
 7EwaXcSgbK87UwjfVbZNf7KDIdqnx3mrSlzwwDRtxWk69OsFfI1iWXs9RitMcJUN+ptbjnSTFT7
 dn38A9vS+xb459Pe4asD65MlGzy4ipn0bSnhyv6PpWPg93PDMhatlwzaqEum/g/sm43QYjj0eTw
 cdGyNujk+eHxu9cWrnunJREyOIew6Q/A/K2eTm/8JW1EtG2e3RpGZoafev/a1/HqfPkpaYRAj+V
 x09NK1SIt/JWa2yR0gA661QKhALZcxixH7POGwbcfTvkGwVxtnjsFtpMaL8LujJUgqDe+JgPrQR
 qqmQ8Mjq0NXpWeIN1DGaYHyoKKQssuFj3RnCikfuGuCpt4q8TyTsrS++DXs/LlP6GN4eFu/U2ur
 dRcmRq2yATiQ5looe1bOR4LfLBKMLjARKwQR4pASaFxsq7mwZBZrPXPH9T9XVhvrAui12ng3
X-Proofpoint-ORIG-GUID: jWdLg_Kr0J42HMU5tr9N1lKRCinZi3RG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=547 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160112

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

All the Qualcomm WCD codecs and WCD based codecs have lots of code in
common, resulting in lot of duplicate code.
This series is an attempt to clean some of this by moving the common
code to wcd-common library.

Currently I have done cleanups for 4 codecs wcd934x, wcd937x, wcd938x
and wcd939x, however any new Qualcomm codecs can avoid this duplication
by using the wcd-common library.

There is still a some code that is duplicate, but this is just a
starting point for such cleanups.

This patch depends on the other cleanup patch series 
("[PATCH v2 0/4] ASoC: codecs: wcd937x/8x/9x: cleanup") that was sent few weeks
back: https://www.spinics.net/linux/fedora/linux-sound/msg25202.html

Am happy to merge both of them if it makes it things easy.

I have tested this on T14s, any testing is appreciated.

Srinivas Kandagatla (5):
  ASoC: codecs: wcd: add common helper for wcd codecs
  ASoC: codecs: wcd-common: move WCD_SDW_CH to common
  ASoC: codecs: wcd-common: move component ops to common
  ASoC: codecs: wcd939x: move to using dev_get_regmap
  ASoC: codecs: wcd-common: move status_update callback to common

 sound/soc/codecs/Kconfig       |   8 ++
 sound/soc/codecs/Makefile      |   2 +
 sound/soc/codecs/wcd-common.c  | 139 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/wcd-common.h  |  46 +++++++++++
 sound/soc/codecs/wcd934x.c     |  82 ++++++-------------
 sound/soc/codecs/wcd937x-sdw.c |  61 ++-------------
 sound/soc/codecs/wcd937x.c     |  75 ++++--------------
 sound/soc/codecs/wcd937x.h     |  22 ++----
 sound/soc/codecs/wcd938x-sdw.c |  65 ++-------------
 sound/soc/codecs/wcd938x.c     |  89 ++++-----------------
 sound/soc/codecs/wcd938x.h     |  14 +---
 sound/soc/codecs/wcd939x-sdw.c |  84 ++------------------
 sound/soc/codecs/wcd939x.c     |  97 +++++------------------
 sound/soc/codecs/wcd939x.h     |  20 +----
 14 files changed, 303 insertions(+), 501 deletions(-)
 create mode 100644 sound/soc/codecs/wcd-common.c
 create mode 100644 sound/soc/codecs/wcd-common.h

-- 
2.50.0


