Return-Path: <linux-kernel+bounces-796705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B836B4061E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E2D1B26552
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44D82DAFA1;
	Tue,  2 Sep 2025 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nolUCwk5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91676305E15
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821668; cv=none; b=hjKqvu35IoULudGAXcBLqxAxIiTSO8SGsTrniEl3H6rckH4TPhAVPC67/4wsTZSTqbV5MBiG1YhrzPDms3OICi7gH8YcpIjY7pF0Ki0EkVUvt048ffRa7oVOCHJELfvJPnnSpjD0HxnwhN/lUjXWwkekb8FG0IdStPlpgUJPLgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821668; c=relaxed/simple;
	bh=lzi7PjmrbdiTIxDM4q1qCQWpTdwTH0ya6B+wcBwilSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O48KZSTvnXuXwH85glTWTtwpI6mbRbEWNk3c4gh3QmhwCydV+TH7rh0rjOF8xSyyxyY8bltJ0uvPG5Efn6Spe/OFsxOGh8WJ2J4uW3Y8AqaSvyZurc1JPj8+IjphHxq4++kfQj2Woy2RzRMpBn6Kru2A2nUoRj0G/lObJIqDytQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nolUCwk5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Ap32X031520
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 14:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4elZEAGxUxZ
	vEJD8DID/5RqvZhZy/oGpNYortaWIzhs=; b=nolUCwk5gI840TZbsYE9bsSF2so
	/8qyZgP/r0pDHDc8qE1TamUJx/C6Tin+c578ghNPCzQu5Bpc9sVAs8Az7VSp4AoS
	8pIsV7maTX5gp0lqlcFd9cGqC3qKhtRDgHrWP8jsXWpONMPsGLtKYLj0chIIX+dW
	/2L9VVEQZpfMQJIAVL0ccpzoxUrwUdPtxdEeuet1eUwiUQqwXoQeREzclF0dZEmU
	XKSjUGwXAoVJFRUBH9H2Uw9duEHkKOwv0u1RRTCUmslkHsh5zhlF4GyADB3nwohz
	OkzrGiYcX2iOIivK5rkfDr+dObxP9Ve2k4ufAk+SQ2sJlAWGQfDwATePL7A==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48wqvw9s0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 14:01:05 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-544a1c51a98so1000452e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756821664; x=1757426464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4elZEAGxUxZvEJD8DID/5RqvZhZy/oGpNYortaWIzhs=;
        b=vUZ7TzTPrJs2Qf60+wAVWnxFl1rllxrHZh9UghnUGtjVm1ROvQEDifp1hrZ38sEkSx
         ePRCwEZhIF7BlbqzUFngwiN0FNDXmenKpKdJDUhn+9Fo8/yRJexcK/1aOyNh/dSY+mzi
         LX6VlMuwYvNZzTaVyS68MOyzg3V0livkVUrQjBmjIIkxvo3U3hNQhFe2NJs8xBzDhSjq
         5Na9G98Su4qi79CYBH+LkCWTiZQc0EQ4VRs8R0htd2LxDQvzzz4WEpEo/fTYZ0rkydHJ
         jqNsOXQAeY1nXNzpmxBAOaaUttaEW7PWV2Wykzx6nxc+BgjtDpvC94HR1hMENI4jk6ri
         cJfA==
X-Forwarded-Encrypted: i=1; AJvYcCWyhBDC0Bd8sFp1if0I+hTwxBUdbigY/AiN7a0XCCXLLzMOkYQ5AGeGzLaL4ku63QXeDcTHY4f2mJ4MVUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWRN0KiURAkpOsQTSjRnxErOom3y7obdI4Tm9U9U5sNRiM1lgd
	C8M+zMZ7oNNDtOgJ6vBeSotmRMcHhv2GFZnmgCx4m+jo5q8kpYOOMEsoBk3uv4sx7g3P6/LNTNO
	RHbh5IeBfcaKqpq1KEM5p95vMeLRGjwjXuatuSluoe1dLhrtN49UwIWmwudY03wQVlcc=
X-Gm-Gg: ASbGncsiR+QrXoTRrlD555Qz0/y6NlmHEEPeSsr2mOOM6msPadUvQi5EVuQwRyw8kO7
	RjAI2ZcfU34iITc7BCMRe3NfnScTjcN7hknBZIzP2+TtrcSxM8jCCuWgYmo4Vpjwnu4pAfeXsa3
	brYU5bTn5+5TBYfbagYvLGaIhm2ek+a1XACP/GX/86//L6kBpGRpq22bsqr38IFN8BcCepq42fC
	NfmrAqEhp+5mCPEA2Vj+lbbs5BfixCogtwn2MK5gWhO2B+MyE0drrnUpYMNS8x/xQuymR7R6XiO
	dE2lwKP5Q4lbfXTPk0eNTxvWEHJdmJmbkw1pvjhYaJGHMz/zKnYxRg==
X-Received: by 2002:a05:6102:685b:b0:530:f657:c1c with SMTP id ada2fe7eead31-530f6665444mr447391137.0.1756821661534;
        Tue, 02 Sep 2025 07:01:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4XanQI+P+HUm3egZOKx9hQOOG0P1c24g9VEwtKc0I4KsM/LPaQOP0PJ6Mb77+ov0hpW2oDg==
X-Received: by 2002:a05:6102:685b:b0:530:f657:c1c with SMTP id ada2fe7eead31-530f6665444mr447186137.0.1756821658795;
        Tue, 02 Sep 2025 07:00:58 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d2250115fdsm14381196f8f.40.2025.09.02.07.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:00:57 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: srini@kernel.org, broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org
Cc: conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 3/6] ASoC: qcom: x1e80100: add compatible for glymur SoC
Date: Tue,  2 Sep 2025 15:00:41 +0100
Message-ID: <20250902140044.54508-4-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDAyNCBTYWx0ZWRfX01Zam7wJlqa7
 aFAygITd1ptnQiz7WKzTALSXIKH76nWyi2PCVAxvjy8dEKQu+C/N3LN9+tD5nDO7H5iNMRMTBTy
 sGfAfFBIAtfwTjxkwT2C4Yf5QHJT6vL3/m+cAb2Pg9oNoEIxXipJO1JEftw4w/Q+vvPd0aUjIjW
 yXXro87Z8piY/RRyPJc90Ffffae7T4DxJWnmRgl6Bnq/S+AfIRMBsjE2jQRNWJcqszjgNy8cJdc
 13L89B+53comUaD6MO6xh0NL5qmlS145+e+Tg1SqMgQ/GHX+VDbpzDPhBT4SWV0mV0AjgDHQjD0
 C472Zg6RWpIfSX+5Qx1yUl4kGfT3XFWbZYiRu85mwbPPSQlMigFOPuCgZfKXKrF92Og+WYiqM5j
 YHGUdH9E
X-Authority-Analysis: v=2.4 cv=WKh/XmsR c=1 sm=1 tr=0 ts=68b6f8a1 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=eB2jmeKzBhuYpaM94Z4A:9 a=zgiPjhLxNE0A:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: WHFAC881YSOABstdfv9dReVKQYDp8K7A
X-Proofpoint-ORIG-GUID: WHFAC881YSOABstdfv9dReVKQYDp8K7A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020024

Add support for glymur SoC based sound card support.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/x1e80100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/x1e80100.c b/sound/soc/qcom/x1e80100.c
index 322010d54af6..444f2162889f 100644
--- a/sound/soc/qcom/x1e80100.c
+++ b/sound/soc/qcom/x1e80100.c
@@ -218,6 +218,7 @@ static int x1e80100_platform_probe(struct platform_device *pdev)
 
 static const struct of_device_id snd_x1e80100_dt_match[] = {
 	{ .compatible = "qcom,x1e80100-sndcard", .data = "x1e80100" },
+	{ .compatible = "qcom,glymur-sndcard", .data = "glymur" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, snd_x1e80100_dt_match);
-- 
2.50.0


