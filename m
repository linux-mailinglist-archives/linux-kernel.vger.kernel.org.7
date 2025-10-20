Return-Path: <linux-kernel+bounces-860968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A287BF17A2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B97405A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B719631AF01;
	Mon, 20 Oct 2025 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C3Sf+jBa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAFD314A78
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965943; cv=none; b=oUEylR81EQfUI+cs0UXNwAtra0htjwO/l3eUNdmjh4jE5Ba9yreW0BEuFlwr/C36l+ZNPnqNhgaUy80sqIysDSOIKUCkn/4ysTukK9w52TXFXhNCiz1xc3NLBj6yLnOyrQ0ghOa5G0GVf6lx4EeqYdyrfnpnGeGQech8SEdA3uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965943; c=relaxed/simple;
	bh=2huT2+iKEw8tW47rMwo1a4P8i0CzNs73jkjQrrzOQro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/z3fpIM4mHABC625d2PRSxhAMopD2DOupiNMjo65LJBIFwxyH000e+6GVZTSk7iDsmAofuKijviYTp1voywbjzMdfJs+9kPWSrpZfSjD2yljo/t0VP0aqBoDmiL+RtcPKZDdHL+45tNvQjmiWu0XQMyETcS+JzJFRaVTSM02vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C3Sf+jBa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBc58E004642
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=kE6h5t6yjbVzf8RgIauFFD6tv5vVHA/XW4w
	UEUKgjiM=; b=C3Sf+jBaQTW0W8BOFWc4iq7hp/Hc5lr3AiIxJE9LdF29MF9n4K2
	eBP2Ag2FPfpta8u0OVsxisBSZQyY1EDz2KHHgVXH3tCmZdPOh9JQkbvgz5quQkfp
	XfZcVkf4EzzacwuCHuEtnXu7R2pdeyJ9b6YLk3sbq2rzlD4GccH302rkL/S4qwPx
	hJihuXgl2GRKs/pCWhik81+rJc6+NotukxF8UH6p42b4H3k9sjdIhA30GQUzj/VR
	eo2VcQm8cm7DcwcF/RWJhHRft+rUqHM7Oiu7LYfsW4ffhT9F1VhAk60xhAJT7h5l
	EUKNXKZcsWRAiQlyX32Bv6Rz/QKDMyvTs5A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469crph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:12:20 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-86b8db0e70dso184249596d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760965939; x=1761570739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kE6h5t6yjbVzf8RgIauFFD6tv5vVHA/XW4wUEUKgjiM=;
        b=UKgjECUD3iEUubpL0QIpVLMhGwLuJ0YIJXBrASL+MkXRNSszXzcAw4LJgPGyE4CMp7
         NPKiu/Hgaqs4YEQU4x9b+Za5rVBKTiAs7KFmSro7xw8MJ2e8SuN4uV1q3/PeZbgpfwou
         WRGk+XJxsBuxd+Sg/peFIQee+M3E9rBlhF84x4G4Cn2BUgeXrk/bRcbybOWptw9NkYfx
         8i0sNql64LpShwi3athNmFFGZEpXLovZelqbYJbrhSyFPCzLDxW/Mqfq9OnWEnzpiy+7
         vEP5ikuPVXNmRPSl14xCuloNH0XjXkhtnLROrNPS8T1brFum74FYRC1iVceAgQnxlhHq
         g6xw==
X-Forwarded-Encrypted: i=1; AJvYcCU4icAp1RsiSEYTcEWKu6rPStmutEjSdhOnIZXUQGUIB21xRRfgZlmEO9gW78vJBwzAAMa61sQX8ULJ1D0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNAsTiUi4iG62ytVmrYILx70f4SwEiDv/hNuThWf90NTzswOi0
	I8dsc+3Tk/ml6yl6HltEAAEMrEQj67W9TUKBwh4onbSgXoIdz/m4vtT/JUVBUG7exzx8RPgUTO9
	x01AzhrycZlU6COM6MqdCTy6cFYHNvD/zpzTbY86eqn0GpABa77wuMUTuLlki2l17z5o=
X-Gm-Gg: ASbGncuCGNJDsvE9FM1NAnaPLBnkUTGCFAjozDrmoPwasxpCqZ9nBCvlkU7ed0E8F/o
	K9lVqxWFQTFN76bHiNUMk8kDef2+mJyu1CQRQCcs3YEY0X2DkqFIHGwActBKydXHEGNMEfim55T
	2uG9vETG7y3zb/xIuI/ES3LJquPd+H7vbSjes/lYiE6tCpTlSuACX+cbztl5AxGPtGxqsvNmdlD
	LKqSizvXdGGS2kh7t+TqnIGiY29QaVo+/3rniaP66JgIk3mpPXqmAv05ip3DTzUMQteKJ+MLgsy
	IHTKfq2yUEQ7EwTK9i6K932pUWxOXnMZQEWTQwUrC6xPn0JYfJRZeBDGHH77EdvYChbauZgxzaX
	2QziTZ+tJBFqR
X-Received: by 2002:ac8:5f93:0:b0:4e4:9d63:4a9d with SMTP id d75a77b69052e-4e890fdf96bmr207136841cf.28.1760965939360;
        Mon, 20 Oct 2025 06:12:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsPnvRqWl9GSvk2rCHU8mAvynF5S+0f8ghhjGvT3zvjL0DQkU5H3U0yypMThGrIIFNl+39aA==
X-Received: by 2002:ac8:5f93:0:b0:4e4:9d63:4a9d with SMTP id d75a77b69052e-4e890fdf96bmr207132331cf.28.1760965932957;
        Mon, 20 Oct 2025 06:12:12 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710e8037aasm118165505e9.2.2025.10.20.06.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 06:12:12 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 0/2] ASoC: qcom: sdw: fix memory leak
Date: Mon, 20 Oct 2025 14:12:06 +0100
Message-ID: <20251020131208.22734-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: se8BHHdltJZ4n0fikYrRqheU8C0RgRrx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfXyCl1EVY/KF4A
 31X9RWFCrFpnswbDJIWNngK9qWIrt8WBiESJU5BFKGHkbVl8nsX+nwB8qqeHelRTH+gBerstYTi
 ybU/jNheuDYsomAp3zmnlXN+LHX+cJDfinwx7r5GK0iOhiTOvNbPXJfNMx8mlwO7Z91Icuo6mcV
 1Ao+kikQem3+qqnt+KpV+sntdIZJ1sSjTAf5rLpg9SrnTceVnGZ7MSVwHCnLrMNaXGjm+EQ/t70
 KNNOPpjtAYT54123gZFXBJ61h/CLI4BGgls5xO1AqYUOCM7KKnAWD/2r+GLavYb+VWQTLu3+z7Q
 aUogj3JI6Lcxh2bm0XfQmGr7yE06BOvhoa3UTL86gUCKYUEvUVj066to5in0bOINRTMEKu08pSi
 ffqVLPlkz09+VX1rEQhvEXbeGRwSGw==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f63534 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Tmn-ty_kyiCvGlHJeRgA:9
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: se8BHHdltJZ4n0fikYrRqheU8C0RgRrx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032

While testing for memoryleaks on T14s, it was found that the
struct sdw_stream_runtime was leaking very frequently.

For some reason we endedup allocating sdw_stream_runtime for every cpu dai,
this has two issues.
    1. we never set snd_soc_dai_set_stream for non soundwire dai, which
       means there is no way that we can free this, resulting in memory leak
    2. startup and shutdown callbacks can be called without
       hw_params callback called. This combination results in memory leak
    because machine driver sruntime array pointer is only set in hw_params
    callback.
    

This patch series fix the issue, and while we are at it, it also remove
some redundant code from machine drivers.

Thanks,
Srini

Srinivas Kandagatla (2):
  ASoC: qcom: sdw: fix memory leak for sdw_stream_runtime
  ASoC: qcom: sdw: remove redundant code

 sound/soc/qcom/sc7280.c   |   2 +-
 sound/soc/qcom/sc8280xp.c |  33 +----------
 sound/soc/qcom/sdw.c      | 116 +++++++++++++++++++++-----------------
 sound/soc/qcom/sdw.h      |   7 +--
 sound/soc/qcom/sm8250.c   |  33 +----------
 sound/soc/qcom/x1e80100.c |  33 +----------
 6 files changed, 76 insertions(+), 148 deletions(-)

-- 
2.51.0


