Return-Path: <linux-kernel+bounces-796701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3680CB40613
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3D0189720F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD3E2DFF12;
	Tue,  2 Sep 2025 14:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mCMtip+k"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26062DAFA1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821662; cv=none; b=HKyyoflP8CmelV0umerx10JvpSkr7GtxLDqzZs++ji/kzMMyd9+si94DmVvioGxPO2dGUnYmXD4uC5oNuq+Iig0ddx4RjO3G77fCbO8t4SYu2Mf7O/+mol/pB4TbF3OwbwW47MRsEQkxHFQGLaOR2qEC06idWJKnR768gTNGuvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821662; c=relaxed/simple;
	bh=Erpj/ouDd89cAEWDr0McVn7qsX1VY6xCR02OGCP1IRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijfh8+BNsG/jXjbSRnue4VcpEw94ssYwwhelycIRbIR1UU3iHL5dTfWVOiVbbLkRVb4jh21dYzEYWm9uW0TEVtxikEZnOeYycrQTIFRm1A3CgxJ94dzvqrvNH6jz0z4sO5xbO5vyp6mMv3YNLpaLN/Rx8Clz/AR1kkPrjUfRudk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mCMtip+k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582AVEkv022315
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 14:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WzGhnqCbKpL
	vbZMIa75k5x8iAR9+F9/qdnVgwvY1TNM=; b=mCMtip+kQ1QOc9QDMwKOg/Mtb+0
	R2Hy7zIJe7WivVsJZjpXagIpRupYao2OxC8Lf3VHq8bPw0GtJ3J7iIxvBCuYOu4E
	Km/SHhDf5Osuk2v+5diQJ75Ms1jNBPV+zIfjp5Y7bGwqlv6Dfl2pSPvuEMVyzCqj
	EPPk/+GIvSFmdGaQIUdCwnxRqZIGqadEREg8LWVly3SfS0BPjXBS7c5nYZ6QQnRC
	FYYr+dyaMTsiXvvhdgfacuh+WSq+RPQ8no64QbHSkku4tswbmc4SBwHnkoqLvfm8
	mIXa5BHlLNnixgkI7FDkGCH2aQGPjziGUwZe+nUD4MLvcehaHoQy3P1W1kA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp864j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 14:00:59 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-892476e7264so692622241.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756821658; x=1757426458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzGhnqCbKpLvbZMIa75k5x8iAR9+F9/qdnVgwvY1TNM=;
        b=ZhzNVLWa8t6wTneRCA+TBEg4+sVmOcYqBrcI7stHI6a/m1MJ4UpJ4P3MGtm55qKUP1
         NNnAkSQze1CQa+8GPmihjsf3B6u99jtjHZ4ZxngwIkoILWYsfelQxthhzhZVh7trB8cL
         yhXhDfZZcReqhVzsLYtDYi5+uPqAnnOcCR/zzMZmttbOeZauQjhOiaL76kzxIQsG7tlG
         ZmTzXst+1e6WljgFSr4COmVE6pvOAXXzMpGVHzI3f+PWJd43OGenR0kEa64ZvSkErVPS
         OAnZHC6lugCe3HDE4Ufba/tudA3MJujnYEyIoTRdVM3t/WTb4bRMQunRDeD2VGvv1oCM
         gpYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcqpQrQ/gVWjORW5XI7HSVdcDO9/KSpNDCJsOS5g3mEhnjiPekaPesikRKzcNhkT2ztubLjKfSlDKI30I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTveXbUDZmDBqQYTPpg2bObjavUXIU5OcF6loBPYtFwG/6DZLS
	dCtXmFHC7Y9OtyUoCgyKJ2A2kW79OCA6AcEYmVKuIzjqdkpZqmPL/9S+4bKw+L1cFs6uVc2yQ77
	vbHftvIPmorz8r6kFE0D6mzK0kk0lAmg5VNuaIBdvQUuK97phVUWd0QyAQVj+Kw3Xuos=
X-Gm-Gg: ASbGncu0XhnUyU8mZyDmKTWFoao1GPspeaxbXND7gQDp6+OqaSFutX6veqSRRZycXXJ
	kGzV3yS+Sofz1S2KooDcW3UPsz/3NWtwl4kCgLtoDcsIXnnkuXYpgOqOCYRqmIVdNs+p1ziL+mr
	dpgRUR85prYFkfBAmZ4MTf63+/K0+86tF1bsH8MqRqpi3D7ZBLaT8RRmT0WgMQF3WG2bK5zniw4
	vffN7VFtY3sLw3GdGTmiU7dWhUmpcQB+v0Zbt3uGpiWRQXQgp70ih6Bt21Gig9OuK01fAXs1ane
	UCLIE4uxBvyrFmywmPL3LXHQDf9GC/z19niwosdHXagA1WtLBgSVBQ==
X-Received: by 2002:a05:6102:8017:b0:522:194f:fcd7 with SMTP id ada2fe7eead31-52b1a06be68mr3884646137.15.1756821657143;
        Tue, 02 Sep 2025 07:00:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/U4dPnlcOQB4TWwCsU2ajC9mEnPbFZd6rjcAkR2eVla8SO3be+Dd93cVapqglSYKgRBmE0w==
X-Received: by 2002:a05:6102:8017:b0:522:194f:fcd7 with SMTP id ada2fe7eead31-52b1a06be68mr3884529137.15.1756821656042;
        Tue, 02 Sep 2025 07:00:56 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d2250115fdsm14381196f8f.40.2025.09.02.07.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:00:55 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: srini@kernel.org, broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org
Cc: conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 1/6] ASoC: qcom: x1e80100: set card driver name from match data
Date: Tue,  2 Sep 2025 15:00:39 +0100
Message-ID: <20250902140044.54508-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250902140044.54508-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250902140044.54508-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: X17iYVkLs4aM9jnNbzl8-F9ELnw7FNWV
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b6f89b cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=8PtRD21WSkYcRLTV-pYA:9
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: X17iYVkLs4aM9jnNbzl8-F9ELnw7FNWV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX/utAMibAdpmT
 IZO6QkUzgCVeMZc9QIXU9yIYb0YcLlgS3h80KkDCuewFVPavDpsaJJGYq06t1XRR148ti5PXJ/A
 3buPVzehsKyUr8BnhlNiCAvR2ob3XubL9SlrX/nG9N9t/ZhVM+mQcgIzKiaMJMPRV1KZ0qsLULq
 A7WSczfyDy1aw/70OCmdgGDSBUpf3EshEFa/6aIoQBXKupsXEKUkykwxY2ukGTZtFNHJKa5B/kK
 Oi+gcE45LOp8qsE8LFYU2M4aEogmwlMHmJLoXFKa1ongvzBNlZ3Fqx5oLUyeUOKudJ1HvmZBLRD
 a2BbLmm9RJ3DDotxA+4tROWxeG2hZzbXQfm4OGxMFHpkEljnzZ+psu4uJx987EkmVdwNvZjwxy4
 J0DZ0rwn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

Sound machine drivers for Qualcomm SoCs can be reused across multiple
SoCs. But user space ALSA UCM files depend on the card driver name which
should be set per board/SoC.

Allow such customization by using driver match data as sound card driver
name.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/x1e80100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/x1e80100.c b/sound/soc/qcom/x1e80100.c
index 8eb57fc12f0d..322010d54af6 100644
--- a/sound/soc/qcom/x1e80100.c
+++ b/sound/soc/qcom/x1e80100.c
@@ -210,14 +210,14 @@ static int x1e80100_platform_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	card->driver_name = "x1e80100";
+	card->driver_name = of_device_get_match_data(dev);
 	x1e80100_add_be_ops(card);
 
 	return devm_snd_soc_register_card(dev, card);
 }
 
 static const struct of_device_id snd_x1e80100_dt_match[] = {
-	{ .compatible = "qcom,x1e80100-sndcard", },
+	{ .compatible = "qcom,x1e80100-sndcard", .data = "x1e80100" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, snd_x1e80100_dt_match);
-- 
2.50.0


