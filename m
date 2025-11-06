Return-Path: <linux-kernel+bounces-888588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E56EC3B46C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CBB465991
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E973328E7;
	Thu,  6 Nov 2025 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CgbWwG+l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LMcU2Fnc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17443314CD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435705; cv=none; b=PCUf9eQhM9Uq/T8TTm2gDvzFTL4Ghn1kcajRCYBeQj0S4RanAoGkmjraiJnYuqFBW0tnkZd5nB0L0kE9WTFZCtgDwm0GWCJ2GYVf/3rWUF5Y7OLfsLwqldIuoK1o0m6UwlMfrqY06TK6I/Sg0RVr4dgiroLkCpyRE8FBccVLW6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435705; c=relaxed/simple;
	bh=zjb9tpmbXfB/zklirS7RztViyh1HAgilJ5TNU5aP/JU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uIKvoa3sQ21B06FosQvTkJbB7QyCAJfREndOS9JtBY1auH1RhDfHwr9ApSDKFcu1Ygdsaa6orWI8BApFq4S9JY/cPrgDELdjeiQehbesWEEp15VL8JZvPiTP5mC+zkACR8Cpdz+4I2ffZ7onzRazT+ed1rkcsdG/odwYCtqSguo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CgbWwG+l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LMcU2Fnc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6BlClQ4131381
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 13:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V4MSsmd3UWwkH5Io/0Bwy/y3Xm2O074wB4lMW6nBkuw=; b=CgbWwG+lkimCUuzt
	yO2usdpa4wIMKEj+NbEqxovX/CZJJ6FNvGHNQSmZ4CFAiBwmUS/8VJ/+CIm/tr4C
	F4Cd58ZQSH2K2mD6jav8y81GcdMG84Hg8kKC9b5sv91ZJsQS/rAUKjnNLOUexrrg
	OANdEh1fyBPu90mGqw9beCGYraZ4zZyKufiFjgVmxa979SpzevNhvslhhNTEdovT
	n91gumtACJ+mCXqHXodm3l++4+qL8jrsgQ36OHnwbss+bxsSnXzSx6cf+E+J19Yg
	kfnRgtHRKDHm7cmkaGlYx0O5KAMAoMpXIqtAdNgUmva8jgr8UiGOC6THG0qtNEZQ
	7fUdMw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8u3x0864-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 13:28:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-295b713530cso13416455ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762435702; x=1763040502; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4MSsmd3UWwkH5Io/0Bwy/y3Xm2O074wB4lMW6nBkuw=;
        b=LMcU2FncYy+NKIJe52+LFR5rMSK8cQtvk6YzrS2ANBCva3TySBcAsjIwS03svYWiHz
         iKzGA7KLjDS8HJsuV1FWqRYHYv1iythhAiHelnL6DDgOT0nhISjWUuWwsVMYGxg5HGcc
         C/FbYnW6q2IG729C9Ogre8Scw9QKNsLnfiRU6nmAwgyxtB8bteJTn9UL26VOqfbFhz3E
         ZOE3H3oBkN4+5rAOY31oxiC2tcrD8qBVsFMd/6PYFZKtXNCSLyEJVmYYvVY4ItAUpaUJ
         lGlDQkhtv8cCg2pAovmSYh0sTARzekWZvuicL0x6RnaJr72CyMHEJwdY7Q1T3MyN2Gma
         quRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435702; x=1763040502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4MSsmd3UWwkH5Io/0Bwy/y3Xm2O074wB4lMW6nBkuw=;
        b=kaBgFDx0fACtQA+IzBdxwlWKlbUG8jCb4ivkLauyYRVadH2zjewggoSLJGeKQw86c9
         iJiukkLGo9w/oQ7ZxooCQHd9pbT1fVSf3whddtpU4pBwbHByK+LlnW4oTIA8JCHRwFrp
         kkV+8nhRBWlBQHleqDqg1gIrAq8vlAwGp++nTxY+HY3pZ7VhHCDGjIW6Kui6+ajKbHmJ
         Ka6rzrq3QIXLPBAxM+VKsoQTc7oaZiBWbaQK70l7cNJstzbSsr3ZYm/YiQI3LV3nFvva
         YgCIU9NotNZn78FJxIefc65wri09Aa6pp4V/RjXWKa7zuHnn/izhYHoKnLM41x6Yaew0
         rA2A==
X-Forwarded-Encrypted: i=1; AJvYcCV2RUv5jvLPRb6x0OHI71bADI/1MU0w7mfsnaCVVZn9HLWnob0z+JUTxCKMcd2SGAEeTjSyE93E2QrKHnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbowGAgsIxK9VtV8Ga6/025mmADsvq/fC0Yeq9Srz4w9lH2c9B
	OAZ4AoK/qwuEkmmBsp765uSTgqtK2WDe/VxM4Rkxv7cAR8kPkH4ydbcF5U5nFDIumYm45Urp3Az
	CkLi7X1lGZAtkX8KGZZg3I/bniE6j/Bk3+RWI1I2ZP2q9pjvkVxFoqFaY8Uj8HHrESoY=
X-Gm-Gg: ASbGncve6mQOB2IFOcEkLTHYCLgtdW6NyI+m8PO52rJ23oQFg9iVYMP+b5WpN71wiIb
	qSBqKl0C8TFH5eO8xx3+mhW8ZhR3A1YZVmNBux21w9P5kp1UCLg/e3hFzQhWpcw+TnlBGKeAHeP
	3eRA4SL1MkV5uM/yNXkalzWdsg3arJm2L+tW3K7QmOLcaGJe0FKRPeFfdVH2CGCxwoSrScWP+gQ
	EjXdiU/9il1brLVwdJ4tDsW+sVF0wdbJAQPoxhIxtadBzGdY7g9fscWueDzVA+QPw+Uvt9Okd3s
	3WkaRDQGZpSusQlhx7N9CQq4Qqp6/p4V2sdkcYEqZKZIgcNRDyg++aJUt740y5AhRppZqf9DhUi
	DZAgoaa/8l0nJMCym0lYvr39U1A==
X-Received: by 2002:a17:902:ce87:b0:295:2cab:dbb3 with SMTP id d9443c01a7336-2962ad1c7bdmr105067705ad.14.1762435702179;
        Thu, 06 Nov 2025 05:28:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT5xsfSTNuLc2nSZ4GpEr15dF4h6yovVj03qisQkMdnwH+JmRVy14dCEtnLrebh9HAmRH9Fg==
X-Received: by 2002:a17:902:ce87:b0:295:2cab:dbb3 with SMTP id d9443c01a7336-2962ad1c7bdmr105067215ad.14.1762435701636;
        Thu, 06 Nov 2025 05:28:21 -0800 (PST)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca1669sm28770225ad.94.2025.11.06.05.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:28:21 -0800 (PST)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Google-Original-From: Vivek Pernamitta
Date: Thu, 06 Nov 2025 18:58:09 +0530
Subject: [PATCH v5 2/3] net: mhi: Add MHI IP_SW1, ETH0 and ETH1 interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vdev_next-20251106_eth-v5-2-bbc0f7ff3a68@quicinc.com>
References: <20251106-vdev_next-20251106_eth-v5-0-bbc0f7ff3a68@quicinc.com>
In-Reply-To: <20251106-vdev_next-20251106_eth-v5-0-bbc0f7ff3a68@quicinc.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762435691; l=996;
 i=<quic_vpernami@quicinc.com>; s=20241114; h=from:subject:message-id;
 bh=pw3zU7ths4bkk53rm3/2/S8r8KYgg2qmgAalSQREZkg=;
 b=j4Wjuyma4giiSZEJnpIwxg7ydkKHXwm4RvCJNR0SHdD+vHYyWCuTcRlnFSVClsTKpOYiBxsnK
 XvxtcxdW4+eBvLvKtrB/+5j1Br0HQXaRbPup4RwA6iQFoDs1EaYPVgE
X-Developer-Key: i=<quic_vpernami@quicinc.com>; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEwNyBTYWx0ZWRfX92SAtcA+XPBC
 YJrrVW8B/SENNUVBrKNqGDDt1ZgCuEfbO47OroUit8RfafHCGGBBlzpJ2Dr+AIerAYLojBL1Y66
 BPfpstbzMWi4oqBUs98w6qsleUi5uW06J4cXd1boyamUUUQ29zBsl6OYP4Qu3iNW05JNAddZQBu
 GKUFBsjEhKAHwTe1WBkcOp4WzZZwHJ1t8vvwqbDZSt5XbAgzReJB90wYtDzbVcdVAFat4IjhG7s
 1/kTKsNdG6YbwurSQflAazMIuDUGG7xljzrU+MgDcFEM7tByAYlgU4r8v3EwiEf+xwZ1PqPsDwi
 Uof2YfLvXCReG0lh4tWN0F4Ok85dO7UD0NpFsO3mIVKlIzKupBWsjnOgWnzu5Sg/9u0jj02wBeW
 UF7y9PRu4MJbxlCxG32Y3jDU1rNMiQ==
X-Proofpoint-ORIG-GUID: 0m2YNPn72nk_HEKshvApKoi0Tg6R-Xsl
X-Proofpoint-GUID: 0m2YNPn72nk_HEKshvApKoi0Tg6R-Xsl
X-Authority-Analysis: v=2.4 cv=BrKQAIX5 c=1 sm=1 tr=0 ts=690ca277 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=0xxiP8YIG85xZ0q-sMoA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060107

From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>

Add IP_SW1, ETH0 and ETH1 network interfaces are required
for M-plane, Nefconf and S-plane component.

Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
---
 drivers/net/mhi_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
index aeb2d67aeb238e520dbd2a83b35602a7e5144fa2..7fca7b1ec7b8250fca5b99ba6d1be470fed87995 100644
--- a/drivers/net/mhi_net.c
+++ b/drivers/net/mhi_net.c
@@ -449,6 +449,9 @@ static const struct mhi_device_id mhi_net_id_table[] = {
 	{ .chan = "IP_HW0", .driver_data = (kernel_ulong_t)&mhi_hwip0 },
 	/* Software data PATH (to modem CPU) */
 	{ .chan = "IP_SW0", .driver_data = (kernel_ulong_t)&mhi_swip0 },
+	{ .chan = "IP_SW1", .driver_data = (kernel_ulong_t)&mhi_swip0 },
+	{ .chan = "IP_ETH0", .driver_data = (kernel_ulong_t)&mhi_eth0 },
+	{ .chan = "IP_ETH1", .driver_data = (kernel_ulong_t)&mhi_eth0 },
 	{}
 };
 MODULE_DEVICE_TABLE(mhi, mhi_net_id_table);

-- 
2.34.1


