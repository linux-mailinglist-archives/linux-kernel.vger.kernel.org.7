Return-Path: <linux-kernel+bounces-811439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E6DB52915
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081721882C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3BF280A2F;
	Thu, 11 Sep 2025 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nd27h2G/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F3D2727F4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572605; cv=none; b=imRcCjBEXMuS3H4HWOapq9jhuBz8ZlzzdKcfkRBw/GgrutT2nrxHRHi6pzv2H/xZ4FCFwsxzjhDHMh7inXknNKuwTn4g4xw9g7WyFNlSm49Pk8ssxBXFIwI4shm+sil8ekGph5itUEZc0te3SmJYcUJpcF+9BCRJiAFU/9WHn4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572605; c=relaxed/simple;
	bh=RhOFMO390kD6vVPQk+wsaIHxpEh7Rl6s/uQ6K6nB+Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FggFKH5KV5zMXAyXq+UZyReIZ0nwLNvgXRPzpErAz9hcP58uBssXmpvKjfuqXz7jVuFD38dQsA3xMCNQLwR/Y3aU9zZ+UZfM7ECWcl/wkSNm70BkUnxveq+nNvac7Y+MSFQlG9rhllzjPdijYS9DJFq6jpTCi3RynzqiF9N6czw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nd27h2G/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2J3mR003255
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HWX0jsMcz+X
	znw8DUFwCpjh9opKGeTSObz3aq0hQzb4=; b=nd27h2G/WdRY0aTMKSaIH9KhQbN
	QOrIe8F7m+di12OOyT7nEXM8i5lZ2STbxnPSLDsR9iXaF3tnvCNk8eX6z+fMxHrb
	3x5bSPVRgNMwAvjxgFdNWwszOplU/P7C1hwlpQ2ygNb5Bt87Zvon3Llu/Q+yzYsq
	8Fgq6IJ+lpbjtzGL66m/wbme7IJrYZ5CyQrFQvN/fEm7b1wtAZC9Bk8ywi+9Shpr
	8vjcL2rK07zNAlgddRYr70hWh8yA1Ur7JqAa09iRd2bDuDUMv2n3gq56WIE53LCq
	SLoE24Hm37w3vfjOo4D1CctroAjK2+DTc+7sUBk/3xQR/EllA0sL4KAaL1g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8pjgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:36:42 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b521995d498so341085a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757572601; x=1758177401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWX0jsMcz+Xznw8DUFwCpjh9opKGeTSObz3aq0hQzb4=;
        b=spuqev1hLtPdmEhf60XbB1twAaD6htgXWe9OrMBVLpWMeYgYyGXtcDMlRXtEjrErj/
         G5qD1t3t+SJo7N8RbF03IOGpD6s6RhipWeYgVpAR7M1JUuXsDZ3zbxlOfMv17fPD1euc
         xLEq4clqn48SVdUkGs1m+u5SgWmeY10p4dv435rDV8CBX1yE7pPSbXLW4rHZBbkg7k7u
         hnYpeTeXMju+t24o3DG+9bqvT3t8cwu9DaS2/RQDWtTElSniMdTXVUWmjshzKG0cugV5
         64s3YIWus3gOwcnkpFh+hvocZqcCpQj6E5rrm7KNzUzrHx5fKro9UWCZDl/kT21oRLKG
         Qc5A==
X-Forwarded-Encrypted: i=1; AJvYcCXtzNBf4BtKEzGiV2FSSYmBPmVNcSKYhDQ2kA+P4t3I39/G0YO2OBCvfIgqdFJbr9JN3FOccoUMPZVgDFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz/wbxQN/ZLrdfT+fX1Ak/Amn7fQtkKSWjI/mSZjcGavlCKPuj
	xVpQh1Sh51jYgn1+hSERwOr5k8LNukuHQ7RGyPs29wlJaQclVJsp5ZfwV3bQIuEWDqXJivy0dAl
	t9juxtnApl3jiTyqMunauSgEB4GK/VRq7gG9gmMRRMgkHMD/Veeo3R+1JK/zXUrNK+M4=
X-Gm-Gg: ASbGnctVNY70aErT/CqaXfQYNf2LzKaWYS862TfCwioqtPXVHtMk4ABzrgIiiLgp5O3
	I03E6RYT5Gds3adgaSTv6yVDOvOEm19N48Tc7AQ+Kv9EEdPgqGmU1MId8pNA3G6RlainpI9pLXI
	kG1hCjtt7dBmPwjiE5a1uastf1Era2FvmoNufxsEDrCxfWVPhi8njt+EQT+K3sgOZi3UYNGFX/g
	VYppDYburfc3oPdMCD0vrhoorPJXuAJekjiYHxAJrZLlg9yLub2nnvLdswLC+QpLidvz6g5YSRl
	icpPoLp8WryMLfdpcbfx0WPQKpnrxPzjRDpml7MI/PiE0prBwfiZJ11HHv1vVBnOajuyC2Kn7hw
	1
X-Received: by 2002:a05:6a21:6d8a:b0:251:5160:f6c5 with SMTP id adf61e73a8af0-2534347f671mr26157978637.37.1757572601476;
        Wed, 10 Sep 2025 23:36:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ+PJd2BseHqXuEekWx1mlj2LglhTy48gVjDdZnPnheJmB4iWw19sNj3aiXoyLJBORiykMfw==
X-Received: by 2002:a05:6a21:6d8a:b0:251:5160:f6c5 with SMTP id adf61e73a8af0-2534347f671mr26157951637.37.1757572601004;
        Wed, 10 Sep 2025 23:36:41 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84f72fsm7739125ad.72.2025.09.10.23.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 23:36:40 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com, ajay.nandam@oss.qualcomm.com,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [RESEND PATCH v4 2/3] ASoC: qcom: q6apm-lpass-dais: Fix missing set_fmt DAI op for I2S
Date: Thu, 11 Sep 2025 12:06:11 +0530
Message-Id: <20250911063612.2242184-3-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911063612.2242184-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250911063612.2242184-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX/Qt3Gz1gvIQr
 gQcbCJvOJlU/xqs3Vuj4klvKpx4+JYmCXTfaGfA5mGTWmP0rQdIz91x0MdUCqpnVZMSTSnmz4Aa
 yy2Im4kHGiDYlgU23fzrBNfrlUi90fPN3k3uzSAiaUjYM/ouNNaYq0TDx+7eWrzoKfgKPUps2Ks
 x3flAA95Ibkv4xVbD78yOC5UZ+Gc7cC6iOxjTOEGs0My8BeNFuS4duhuwgDLkvwiIwj6WTti2Pk
 5gMd6H1wlp42a0P740etz84XLTCHzfI9upPdcidb13ZTDGjlMrfLTSfNmfNREqiPLAGp8s6Vq1G
 S/lKkUUJwGZRRNXPK0cg1TOd8PHUc7J0wtcdC0/rSWI8kwdhV6io7qkdKs8sths9f6qJZWq7YDX
 YBuCFWpX
X-Proofpoint-ORIG-GUID: KQqBLbEpcezWx28mzDE-2m013102pMgn
X-Proofpoint-GUID: KQqBLbEpcezWx28mzDE-2m013102pMgn
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c26dfb cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VUbThP3hI7wIHPtXhhgA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

The q6i2s_set_fmt() function was defined but never linked into the
I2S DAI operations, resulting DAI format settings is being ignored
during stream setup. This change fixes the issue by properly linking
the .set_fmt handler within the DAI ops.

Fixes: 30ad723b93ade ("ASoC: qdsp6: audioreach: add q6apm lpass dai support")
Cc: stable@vger.kernel.org
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index 20974f10406b..528756f1332b 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -262,6 +262,7 @@ static const struct snd_soc_dai_ops q6i2s_ops = {
 	.shutdown	= q6apm_lpass_dai_shutdown,
 	.set_channel_map  = q6dma_set_channel_map,
 	.hw_params        = q6dma_hw_params,
+	.set_fmt	= q6i2s_set_fmt,
 };
 
 static const struct snd_soc_dai_ops q6hdmi_ops = {
-- 
2.34.1


