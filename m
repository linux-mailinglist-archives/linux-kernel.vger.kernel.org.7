Return-Path: <linux-kernel+bounces-865243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADD7BFC99C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577F5188D026
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21CE34CFAA;
	Wed, 22 Oct 2025 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R9rMDpvG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B074347FEC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143645; cv=none; b=pUQgeo41AD1j2s9y8bkCvjNWXMFMPjEgSK6/Vnhe/eCXaMnIF5xCXJJXiW5cHjjXWqDYkfdgV/ZyLFwOAiX8wyC5GBbaM/xa8bNUaxUxLUdXWzYJQkx5XSkcklqfn/06YKimDljhbPBsWYeGcHK1/rg6bB8AzH9F2SoANQY2Qi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143645; c=relaxed/simple;
	bh=ByQ0z78twGWg1KYZ7j4NhE4+tO/gGgH6slyRYU8eq4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VbF3gNx/YTtmPKbudo87+GQm39tY6GXU/zwFP+QOsK9ldCnWkO1I2JoHMtPtKdynFBiAb4jhD3Wl2U+3mkiPmEdTsBVYMpLlozRV/vZUElEOVuMlmdEFRDcX4cRNI55UkPKoEaJYTzsp7xN9Zrp3rgQejEwDPPXzd8++TvWMyG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R9rMDpvG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M9jAtq018733
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=L6UQFgQJReJOjnGLiJBPDnY9bAoXvAFd3Xw
	aP6LDOwQ=; b=R9rMDpvG1rM5GVjXKfCP5elBKVktl1EP6fWnW/BUXeZWnqbkp26
	0LktdWp7qDWs95y4YvgV7hFIoieneFBc5KuhgfDkhmlEW1hOxfO6pXyZx2TvEwXq
	2CGtoiq8hklaB46VnYtkBqYY3kiSZdmIfSyYAxi5g8xCYbcioAAiEjTvD38tl2Su
	y+cgyJoyAqaJRUYW6x8Zwn7XSiK/5DIxrts63R07XuAA8PN70ZI2m9uJnrbeOLQr
	GDIs35jV77EqMFEICBp2rsupJke34Pg+QnHjX2TQFaYbBVIwuXPDuB/wmaQ7hSjh
	nS48JQG7FcJQ2Daxkd4gg0MgCsd4b8JYLag==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469mxcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:34:02 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e8a9ec4746so65663061cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761143641; x=1761748441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6UQFgQJReJOjnGLiJBPDnY9bAoXvAFd3XwaP6LDOwQ=;
        b=ZzgTinGncTdJFFcNo92m2+4z5ijuz9fsKNEF9v/7epLt8hjotPAo8mXWo58pMME7Mj
         46qpK2aUyiJe2olPiDqTFSjU1csRFCu8q1MyXrzpt3vcqzd3Q5XmCkpagsAXB2mG8btg
         IpfDXd9/N0Cxhd1MaigVJbXTeZchOld45sDjX2m05ZLsRR/+rG5V7jTIG3zzDmHuEzbe
         TW+Nw3h8c2I+uhFGJ6HuiTqLUrEpMYYS1wO4uferRZlIeE/9yvlqz/qLyvLA2ZdLPw4C
         CmZRdeYEYmNcGCo+kk8FVN4YxZOXWfGFCsELswbwFsO5Dbs9tuF1rluVu3xNRJBjRICv
         7p8w==
X-Forwarded-Encrypted: i=1; AJvYcCViWFBarvi1b5fSaOmnZwJElUmrS5AOpei87hxeey/IUncdwXExnACcIVEvlWxWN6bYUEsI0SwGoUYGD40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxImFHgY61JHK7IxH2NHP3LxpOz9Ahgm7d4rdMd17EKp1WrhZ03
	ak/KPp5VbhJFsD+ni+ZIfhBsPSMoPrY+7v6pqzSxTeuCc7kmjiuG32/XAQZ2hl76x+PP3fjf3Lp
	tOG/42Y5luOix8XW60eBlHngj7cw9ZX3gjqC8eIAuJbtkNX+aF84YtA9ZhDzzc39PEos=
X-Gm-Gg: ASbGncsXKqMD9/86TNMToDwvpCRu1dfAFGSpkehXNkyep2jUzzSqR+W55t2EJap42yB
	h0i1ji9r1W3w1Jll6LcPrh2ALXkqrNt76CRjBeIi1SxlfTclGFEKfhUX9hJkWtUfA+8VxqQG9ql
	98ZaNbdcS9DeBFWYwAqptay01bNDeF4MvCfSIx5eiHZQkKspUXI8gp5pgo2k3df+R7ynQnG1N+m
	Fr9UM2tRPZXSbFQt8pXRkZ2vbrMocwDqC/DKeoiIlC2dGj2VWJzRCu/QQ7pnsGT52RFDVhnKQS9
	PbBABy3x25uW56BBdvwrEutFJu78S91HOZ14yUTFKj02gv6avYKlnNcdoQWU3hPihvSFsIMFotw
	xHBObE576WLVR
X-Received: by 2002:a05:622a:1998:b0:4e7:3a2c:6d57 with SMTP id d75a77b69052e-4e89d2633cdmr244271941cf.20.1761143640968;
        Wed, 22 Oct 2025 07:34:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfti4ovqyhNMFPiWFChOJkzXieKbreTpBscjhGXxDDniD4I6sBt1IuD68qD+kCZiFTOmf+pQ==
X-Received: by 2002:a05:622a:1998:b0:4e7:3a2c:6d57 with SMTP id d75a77b69052e-4e89d2633cdmr244271401cf.20.1761143640450;
        Wed, 22 Oct 2025 07:34:00 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a993sm25544910f8f.24.2025.10.22.07.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:33:59 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v3 0/4] ASoC: qcom: sdw: fix memory leak
Date: Wed, 22 Oct 2025 15:33:45 +0100
Message-ID: <20251022143349.1081513-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BP5Y4QJBo2ckBV1dRomT4fZz7pTN3QnF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfX0bQ7QgtBdnT+
 YPzJsLS/X4mDwBMzJcyjOLznLKGRMDU4N5gbFGvEL1g62Um8Yfy23GhbWGMBUuvgQhwRTs7Oi2i
 /9A60JZzNpe+/UxnFWEiJ2xLhW+q5KbqzQQzx59p7mjJPxAq7/IaqBjoMfZZTgk46Ofq0NeKblI
 Dmr7KCP6Z2YbIskzkMAalxBoDLSO5tW59DYYk1Wja711irY5ZyGV133doQKIiyn7VHY7VCmtMlp
 O74+MG3not+hL+kOnsk9SvUR70NQOaIkUwxsDPAZYYrcBNBO6FINW2to81zGc/+vBd0gPTtvyIr
 R44wymFhzLarMA4Kdq2E7NZWagUhCtc1XgeyY27HeR4WKuwpj6tK0VC/ljXCtFG5Gs45XQ3q6Ku
 ddOeKkU3GHooInOdX2J5A8NaQmwFng==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f8eb5a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Tmn-ty_kyiCvGlHJeRgA:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: BP5Y4QJBo2ckBV1dRomT4fZz7pTN3QnF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
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

Changes since v2:
	- adding missing return statement in qcom_snd_is_sdw_dai(),
	  reported by Steev

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
 sound/soc/qcom/sdw.c      | 128 ++++++++++++++++++++++----------------
 sound/soc/qcom/sdw.h      |   7 +--
 sound/soc/qcom/sm8250.c   |  33 +---------
 sound/soc/qcom/x1e80100.c |  33 +---------
 7 files changed, 93 insertions(+), 261 deletions(-)

-- 
2.51.0


