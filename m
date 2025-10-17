Return-Path: <linux-kernel+bounces-857639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596D5BE7523
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B973A6241BD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733222C1590;
	Fri, 17 Oct 2025 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MbRHWv50"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA0F2C029D
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691398; cv=none; b=ZJ3tT8FvhMpINW3IIED0WL1MiL1mTwi2xsgjk3Ko0a9LXiQvLr0H9hhHi9b9sw1kUXExUw9HUBtx6Log0SlP2BjfTwCdIggQFOQPCEEzIHmSQ//B+7HWhaYHpmxJtKmnNfeiyQwFrTGhN9kFkAHPuYx4IbtabHtvdE2VNMmqgTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691398; c=relaxed/simple;
	bh=dLHz5GvCqsmxeiBqKMEL3HcMUOaRmWqxPH16ZJ+zr84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+uu4679rWOLrsCVtFdzHLbNdRyjp9yaBQM8Mwo7DTRf27KPpjYJeUKeJhoZSP94q0vNclnqZplVt2DOKchAPKyzVlwJSJX5iqSWH3TAGcEr1rij8CTFIKKG/GqgmY6DFeOAPUiqTwpuGM7uKDtmZcWNCovsvTEU9KXhb4bqBvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MbRHWv50; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8Igdx006342
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JitUmPpOE5T
	5FCzl9njQ018JnbQNGz2uQiWhNK3tWOE=; b=MbRHWv50ntKOGmN0X9n6fxfL2ml
	35Q9vv4Fv63oV4svLmEMWsGOyDNvScWj/RyIKtA4Upsd4qPcXHQQZqKIs69hojcZ
	rVinsqfYqmoAibeFmErewScQWjS+cgsG0K80HQyJjA/7HFINUWsmmqQBYz9oJtoc
	JV6GsGsAs+YdFwusKIY3xGH2xIpEC6edM+HaafKEMc7r1JuqkWEGVf7UIjfeJHoS
	jLZnfkQlaJm3gz9aigaoP2id2cnVy2lhif3JUKOwlOuFdgFUq6e+NodwHCO7DmQL
	MG22/grPjnsVxT/Q2vNjO/OTyOJzYH8Ur3cmLLDDj0hRoxc4Ts0M+BpyfGw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwwvns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:56:36 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c1f435b6bso20331626d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691395; x=1761296195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JitUmPpOE5T5FCzl9njQ018JnbQNGz2uQiWhNK3tWOE=;
        b=RM+/RcYkUar5qgfZlfqoJYswiVWhGHZLv1KdjIqCzp7vaf+sbf+wefoQeAaDxKPmNt
         PSSma9h1to5P+fpTdVzyNGAQ4LuZIb3wbMpq+bBojqzZtx4PchyLVF3d37726GAU1Yxj
         B0BMzsESdVOoDfxnvdvsxQMFpj49bfC4js2CzfWo7mmnjY+ZSMFFWhsM38aAbUdqvo4m
         Oevb+pTYOYJXdEorIF5GDm4eOobFVY5Gaz1I9BJYEyTwf/ck1bkttRvGIeRXww4MXis4
         gejQRoL6Le5qoRFgk0Z865swjCIe46ltZUC+Wg1uEQjDA3YUNhg677D8a2udVqJJNlrP
         Vw1A==
X-Forwarded-Encrypted: i=1; AJvYcCWx48WY0zdyeYoPDLDq5xao8NMTHgkQw3vg+FeGwJPu40CDs4rW8DjkIOq2oXZm9fWKu5cEmpAKjQIsfHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+t8dxrJrCg08xse+5GBVZPTmdFhOAg1iOspH9uoA409GIpbDE
	Vu+9XurW3wVsfAPu/H/WVm3D4D/pNUvay13I0V5rJnWqW88lsOywW7iGUlU0t0deoAqBH94BwO3
	cwnw+sJU3WZcQ6iTR8vom/uXllEsH6CsipLFtXcjTA2+S5nGBYAJlxCCKQ8blfYyLwS4=
X-Gm-Gg: ASbGncuMYEI4gYAC7nFDlu2QUznQw/ejV3EurYlCePr87uBQtjGU0Dkjziyo9JUkAHn
	mDrUhGIVJRwBi8PiaMXu206MDf87nMpKuGuL4V7l2PEMI6HZNpPBGJDi99zXAzXl45Nvj8vbpg+
	r63hApH6ALGdpIwKly1ZP3HuBhpMtOh+Af9EBXjTEA6ripfaTLwKakTEo3gRHwYKmGyE+w2kSpY
	6XAtyPYjIJ9Ik870kMyV9ejPiP42JFOK5VXXx7CnP2rcJaZ17wwUCv6eT47Vcb848Jp7JZPFSJG
	j1CxBk8lv6sOMMBLGwepefobPWLrSxucZcsLmF1DVGukywdxRz4J2/9rUn7tScCFaGQ5K8uSgqM
	fSc0EnWZsYjIa
X-Received: by 2002:a05:622a:134a:b0:4e6:ef26:3152 with SMTP id d75a77b69052e-4e89d415399mr41172621cf.80.1760691394759;
        Fri, 17 Oct 2025 01:56:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECLncEtQ/xMqZowWNexF5mITfqx6IZzM+n9Z8TxJParb7CY65kZ74qpDXSRgl56uflB/Cpyw==
X-Received: by 2002:a05:622a:134a:b0:4e6:ef26:3152 with SMTP id d75a77b69052e-4e89d415399mr41172511cf.80.1760691394323;
        Fri, 17 Oct 2025 01:56:34 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711444d919sm70764985e9.14.2025.10.17.01.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:56:33 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 09/12] ASoC: qcom: q6afe: Use guard() for spin locks
Date: Fri, 17 Oct 2025 09:53:04 +0100
Message-ID: <20251017085307.4325-10-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017085307.4325-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251017085307.4325-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX/LMu5dga6HS4
 rhCIRicxnaXYrW1IPJUXj93GmesnSdbtMwfEgllvEN1KV98iaDmgb7i6SGmH/SCEGcTtkxRthF5
 foRoBnF/TXZPsq1yGBLoEmhv1SevAGIZRTjuK/F0aHZL++s4K+xhqBcMMZKbeNc2YPLZVEhRxpg
 mtqXggREkRrcmGU7qTocAKt9S2nX7/iLRlBABBdZnRvr7qkYWyUnNr8ThwDCFmpjFMZDqV2KfD0
 /hP0W07YttOlqjr8LnTCGiQvTfjixcP+BoQUJv5NeKafg6hxE2b6gVPb8w2ExMXZn9jLT/rDLv8
 +nJDRblmT0i8DL1cxs1MJfpQPF5nu6vHNAHUxt/KB/IH6KcIvqY+GVxbG1glTOjZGb4WmcESfkX
 AaDX6i2Fo4ytqNpN0O2Ji/It4XzxKQ==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68f204c4 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=RrrD4pAD4uqPltEmIwwA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: ghy5rkPyPdVImKA3pu7RWDXKipp7GRoP
X-Proofpoint-ORIG-GUID: ghy5rkPyPdVImKA3pu7RWDXKipp7GRoP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

Clean up the code using guard() for spin locks.

No functional changes, just cleanup.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6afe.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 56f85f1c2425..980851a12976 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -946,9 +946,8 @@ static struct q6afe_port *q6afe_find_port(struct q6afe *afe, int token)
 {
 	struct q6afe_port *p;
 	struct q6afe_port *ret = NULL;
-	unsigned long flags;
 
-	spin_lock_irqsave(&afe->port_list_lock, flags);
+	guard(spinlock)(&afe->port_list_lock);
 	list_for_each_entry(p, &afe->port_list, node)
 		if (p->token == token) {
 			ret = p;
@@ -956,7 +955,6 @@ static struct q6afe_port *q6afe_find_port(struct q6afe *afe, int token)
 			break;
 		}
 
-	spin_unlock_irqrestore(&afe->port_list_lock, flags);
 	return ret;
 }
 
@@ -1733,7 +1731,6 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
 	int port_id;
 	struct q6afe *afe = dev_get_drvdata(dev->parent);
 	struct q6afe_port *port;
-	unsigned long flags;
 	int cfg_type;
 
 	if (id < 0 || id >= AFE_PORT_MAX) {
@@ -1810,9 +1807,8 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
 	port->cfg_type = cfg_type;
 	kref_init(&port->refcount);
 
-	spin_lock_irqsave(&afe->port_list_lock, flags);
+	guard(spinlock)(&afe->port_list_lock);
 	list_add_tail(&port->node, &afe->port_list);
-	spin_unlock_irqrestore(&afe->port_list_lock, flags);
 
 	return port;
 
-- 
2.51.0


