Return-Path: <linux-kernel+bounces-857630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E143ABE74E4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951E5621887
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34F025F984;
	Fri, 17 Oct 2025 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TQA/E1Mz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC88F26F44C
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691384; cv=none; b=czT3BQXUrFCSHB8pPMnqDEyFH8JLNrOYBvwouLP6b0Dklua+fCWMt0Ylw+9irYI2N9ddExCGCuOJGUQGybTdd19QkQIiKL4HDN+xoSPZwLBDiXT+pj8p1J2Dt1T0cKFOEBsaRC8mo2oNWCbzClCjzDzPIgpGooNG7eSYMfeOlG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691384; c=relaxed/simple;
	bh=QHBpsKbpDzuuRtkESyqE06ii+O7O5OYSBw6m4JT44II=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dkIyyWEZA3EZPpyFFxLzbZP7Nz/oF68YDY367mwnf55931h7jXeY3fKuVo2xU9reGn18xt1bRHDP11Jdp5j6OiJG1Nez85Uetztmm16xAEADetZL/27Kl/j2cQ7UulhJzXs4SlOHHPHnuzK8FkKhob0apEbfw4fubuNOP+W9Jnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TQA/E1Mz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7qu4d006824
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=GgKHoqXT0qjE288x+uapHdxBiaCQzLjnRUN
	NopeAlSA=; b=TQA/E1MzQ0IhJ4JKwA1t7t5JDNLfkd0/4o8vFZiN5/EtmvIVsOg
	ab57IwU6BOGI2naOeK09x8GRZp6WKDeg4B0MnN2uPu60QS89hwxuL48qYy4n9z8k
	HzhJdzTO3fwFWFOonrSrGmMrkItH7qC5PAlTxyOe6b/goLBMeVae4j6WMco4/+3+
	/Ti2lqge3j4y5Za7HU/1u5I3cRR96rhI973zizXI1A2oqMNGBJTISHRGer9rb6aa
	hrieAZcfum0/5u0BuMyXqDq3Joo6AdI8GeeGwTF+fzwfNft57afSmE630mOLreWA
	fv0Dev5p+NUXN89dpIrPl1FHREOpVHHR3HQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwwvmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-890f1090e44so145549985a.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691381; x=1761296181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgKHoqXT0qjE288x+uapHdxBiaCQzLjnRUNNopeAlSA=;
        b=j6ilPiOniJiiu4pfjrOBHTeLKAsH5b0CCww5Ik27ecdVSJotI49QIE6Uyvo2VBcqz3
         abXBTpv1lXyczvEPmXHiPlpLanpxc7jmcYALdbWOP2Hyqgi7JopIt+6IvcRW17cXHFrY
         rw0W9nv4C/1/YWVhcUqxP8gioGCUR1wf5EeHR+UdHpdOs0INPJq55QTwDP9edPNGOhH3
         y4S/Dpsa9QpZOOhfDZBKOGGC4fTbGnj5xklozZi2jhyjxD8EK4ga91Tu191hUTc41NcE
         NL88GWxRcke2aSwYbHXKgYitnntpUg4HKKbIgnpnyJvtcbjHNbmCwpRTJVy3WvO5E8bw
         HCeg==
X-Forwarded-Encrypted: i=1; AJvYcCVc997NwQeRjSaFMQQyKkIFH415zQTaW78DXHmvotVV5LWG7CTp4zwHst5mVbjWYrAyk+8d0vn6GICTfaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr6UBZBl70syjcE2MC1XKAcOsqF840T6Vbdl7afXe21GcC7BRJ
	8IulM9cc7xBpJkoaNThDHoM2kWW1bwbT3SXNQA5kNe86m1q53XGESdB6cvaxRIgaNWVX4lhLWbL
	fABBerHxzSe+F6Qd1TY95gWaEoiswBGl/Mwua943PjH1mIbB94dzzJu0oVxPjnt4ivc8=
X-Gm-Gg: ASbGnctv8q2dPkh/B5KIW1igxO9q/mKto99NngeGHj1BQJzs2AxjxIPqqgROLrmTnHG
	P+YdrRyNTXNYYuOMUOkosvyqY/HKGDssFgOQfiH9vc+HxPyK4NpZI7yubr7WGTVOAKZEVOG4m++
	hVODmXSZbDcmOoJibNIUvoqHmtG0xYnrK/GxRnAWdh1Z7KxMcW53pvow1dbFxv2XYzhob+Co5VD
	fmY1nhCBTm4hKa+bRzXrE/6RMO0o2Cdrz7GE4r+rQ286spQ7K0VESqJC8DvtHw2ibSRYRhtwD6W
	jEGIVr6AfP823t/NT8cMeQvumgpp3QMTEH5FfFn6zh3jxnEJWBqYSmeyMFk4+3XTalhSRjCANsr
	p1WsVO7tt7rcu
X-Received: by 2002:a05:622a:1791:b0:4e6:d87a:280 with SMTP id d75a77b69052e-4e89d3a47d3mr35994191cf.55.1760691380715;
        Fri, 17 Oct 2025 01:56:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC4UOU4CztdtiviPzgPboziVO3y4fuMgxWeeOy7auZ+T//H6htzc8sa0xc+JXaw3/TGhF01Q==
X-Received: by 2002:a05:622a:1791:b0:4e6:d87a:280 with SMTP id d75a77b69052e-4e89d3a47d3mr35993981cf.55.1760691380214;
        Fri, 17 Oct 2025 01:56:20 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711444d919sm70764985e9.14.2025.10.17.01.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:56:19 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 00/12] ASoC: qcom: q6dsp: few cleanups
Date: Fri, 17 Oct 2025 09:52:55 +0100
Message-ID: <20251017085307.4325-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX2431eGDs6/I8
 ONVq52r8n5XqHW6I+5G//+kTBziDQgLAGCNlTrd5Lxj9OfUUHxl6dTBa8XxNSYb4T+7q+MAToDU
 dGAKiNDJC3Tk0+TapxYZMrK/4Bdbiipo+Jfv6FyxIivc9XXVNO0Pl+ukfP7YEgqOHlaErTISzWV
 vrvYTnADFPMbPp+jegiAreDlp9Jl3P+ykGP5bH/VdVMhKa3uMX1YjSDf7UuJqqqrQFZJZp9ZfLu
 v7/xnb7KFB8T7wZ3iDemSv1XMuptBzcg6vBM/4jIlVOnbx3JteQEJfRu9DP4MChcpwoywpt5hUB
 BuNZRUrVHYWj7LYCPqmm4MkDyozzyoNzKb4jUhTaepb7FFtdeKF4vUaen2JfLKOF3Z8E+jGCOMU
 0za4JBqzYCkguP25dYf1deJelsE5Qw==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68f204b6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=WpVtij-2m0Y91tUO0AgA:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: maaLKa0xIjneP6-z7QjtJSjHHZ16VVuC
X-Proofpoint-ORIG-GUID: maaLKa0xIjneP6-z7QjtJSjHHZ16VVuC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

This patchset does 3 things.
- simplify code via __free(kfree) mechanism.
- use spinlock guards
- few cleanups discovered during doing above 2.

No functional changes


Thanks,
--sirni


Srinivas Kandagatla (12):
  ASoC: qdsp6: q6asm: do not sleep while atomic
  ASoc: qcom: audioreach: remove unused variables
  ASoc: qcom: audioreach: Use automatic cleanup of kfree()
  ASoc: qcom: q6adm: Use automatic cleanup of kfree()
  ASoc: qcom: q6afe: Use automatic cleanup of kfree()
  ASoc: qcom: q6apm: Use automatic cleanup of kfree()
  ASoc: qcom: q6prm: Use automatic cleanup of kfree()
  ASoc: qcom: q6asm: Use automatic cleanup of kfree()
  ASoC: qcom: q6afe: Use guard() for spin locks
  ASoC: qcom: q6apm-dai: Use guard() for spin locks
  ASoC: qcom: q6asm-dai: Use guard() for spin locks
  ASoC: qcom: q6asm: Use guard() for spin locks

 sound/soc/qcom/qdsp6/audioreach.c | 234 +++++++++---------------------
 sound/soc/qcom/qdsp6/q6adm.c      |  33 ++---
 sound/soc/qcom/qdsp6/q6afe.c      |  49 ++-----
 sound/soc/qcom/qdsp6/q6apm-dai.c  |  23 +--
 sound/soc/qcom/qdsp6/q6apm.c      |  57 +++-----
 sound/soc/qcom/qdsp6/q6asm-dai.c  |  23 +--
 sound/soc/qcom/qdsp6/q6asm.c      | 189 ++++++------------------
 sound/soc/qcom/qdsp6/q6prm.c      |  27 +---
 8 files changed, 170 insertions(+), 465 deletions(-)

-- 
2.51.0


