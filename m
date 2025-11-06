Return-Path: <linux-kernel+bounces-888586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EA1C3B40B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA567423E04
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A5A330318;
	Thu,  6 Nov 2025 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I68URC+G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ijG9ssyF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D599E32AAB3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435698; cv=none; b=AmqyY80IJq2hxwG5+jZfDNTXKm6FuX/sZJ2DM5WUG1Q1gFZ3K3OkPAFAWsQL0g5+hjhL71m0xfjpSVm2Vtj+PbtyeTxrNmCk++jQNlT62m7c6HCKj9RweWFTTt6x5mAnsfU7KBSvS1magwT0i3hxbsYnscmJ8WqiXJbMHLX318Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435698; c=relaxed/simple;
	bh=2h1I5+IC5FJduxoWNinXYw0aN3SdJu1DaG7hWWK8DdQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r0IPSbWtT+x0vdJHS9QCo6VXfjZqsdExewgrrF0bWLfdJzCOok4Ppuhda+SZ3ZS0NBO+GtggJRGOeOQR/PheAwrVRlmRUlv8oanoulWtw3XvuiZOV0rFVQYddihKvCzAIGeoIZCo6T4CZna8AxXF3J8QT22chIqGh7rtA27eQ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I68URC+G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ijG9ssyF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A66Gqm71739096
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 13:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=o6mzQWJ7nU2gb68GlaeuTy
	m+gIZLvymtrF4X9C3SVhM=; b=I68URC+GaXWmwqL66JIfNanDe1iPj6smB/MKc1
	XbY6MwXTbIdpQ7u2MXpKLAhKeyFJ05cCzpDTRkC+ukaOJGd1CJ27QDRKSwHYLy+g
	ajioTRtj0quxs9BPp46ZcnWy2dTTR3PLXoQ/ypXT21IF/Flf+r2C3iSXFCypKdnE
	mo/cDkFx3MSo8/VvT01IcTiH/hC1M/i9Q4Z6nYdWQglJgXNDXJEiEqqy4nCGVRz6
	GTPUmUCwRhBmA4cG0F7Zs3TnBlcytdCgMstNyx8fR2XmY7uT4SYYHfMxh/fg9TdR
	7a/hUjixoGJqbkTCaqPy6pDf6JWG97I/zXEfm+l372zgw1qw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8an3u64y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 13:28:16 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b9d73d57328so746892a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762435695; x=1763040495; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o6mzQWJ7nU2gb68GlaeuTym+gIZLvymtrF4X9C3SVhM=;
        b=ijG9ssyFDBWY7dBarMTdgMq5JRtfSm+Lmpjksx3nVvl33+1W8qci0zG0CngWb/aKa6
         31/uNb/PPLOj2fAb/Y5UsRPz81YQRw82Ebu8nnHuuC4MjQsIGeUq7vx6X0XUtCa+T0n7
         i9VhN8gpT2KNxr02+yQkXPOOH79924ShhuxXja6+ytTcrSrzG8VFZEXLaLbzA9Qx0wsl
         NNkkLGXzWhVr2JIjnkClFPXDI2tFI7WOHOp3Cu/aiMbdCNd9Xkuwf/gOPOiPyMueykPq
         GY06VbcZ7QiikRq1+iBzCB7BMv4LsmMIao3amFbtf3jjfHyC4+Doe4I/kAHAyv3gqqWu
         /kTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435695; x=1763040495;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6mzQWJ7nU2gb68GlaeuTym+gIZLvymtrF4X9C3SVhM=;
        b=my8e9+usW4HoxxtlW7MuW420IpziCs2m9MkTe5OduDM6KRnftdFBs/vVQ7BiaHxglv
         unlvUUt4h2nYpzYpB0fJfqmauxZIMe8YpTIBORI+Uq6sANTLX6mANscfVvkOysCsNB6t
         FQteWB52Za1UBRXD5TqAR6lCsZwXbQxs5Eb/ix45whRRp2kZbUcYe7/7rzgrE0vL8Lv3
         0c9705dwqYFFAqfZ75Wd/paEpRFnFNU+bGchRSmm75t7M1V+/nRzvr4k6RunDBz/RI2D
         QmpTqcaYsp5JvHZ8Rs73Ygqy26Bn683azS4PQ6m55OGL4VFaAWPbFYQfYm7IYtuMoExm
         NlOg==
X-Forwarded-Encrypted: i=1; AJvYcCVLoWW2fXzTBvuYvY/Xpnet9XkOr+gMlpR/v5vnEtoQViYHVfLbf8wuys9lk/8LCM8dt8akt2MUPuuff6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YygZ7rXY/C4bRET5byIUsA8SZLNwvRm4RzUBIye860QrTHd1Uir
	6TaWEkgdVHJ9iOt/FnTa/DjINY2ydjhHF12TaiSIWxqXETesf2VwDuPSh2JqSCibRgdsUkAKAaq
	MnPAdivsHJf6XjQdede198hZ5Ya0kI7zBvbAbHWyKKAGjAtxGHxOBMDKLYX0elSwnSqU=
X-Gm-Gg: ASbGncuipMlZkdK8AIZlvyKEq6acDIE8ZnunbYEnrkcq3bNK9RK7d/uqW3gaDy9oWjH
	X5ryILn9yQJB5o3sclfrqGbRG9b9YMz5yguubcAQFhomYLu2bFWStAlKck/EZnsU7VQHRIMnOle
	A7ee+pWyRlQvNKbV82x087Hpl2bUCxJ2ZX0w60tYjchC+99spF+lkn3B99LVxnlcPrXOzGOnN4z
	q1ReRmhLgcscNMC90rY+6DhSt/IR1XZdAadaNBuD1qe9GAIqYWGJ4jDFb/qGr5/3Fr9PYMbA9cm
	D95kMbHGCV3EE70PihlLOxWRg+E/SJEOcSF9n+88h0lyQYl2NHUB+948Q2fgdkgkULCfsKPW4/P
	mCZnHTTFtyPRugGIdk+yqqCIm7g==
X-Received: by 2002:a17:902:d584:b0:294:fcae:826 with SMTP id d9443c01a7336-2962ae9e353mr96453055ad.59.1762435695303;
        Thu, 06 Nov 2025 05:28:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSFxsiJ9uoiJUwbYs+c1n6AQH0+KN6pf7n2+/tZuBDDoIN/SDu6tuMS3691C9fjWWe+K+SGw==
X-Received: by 2002:a17:902:d584:b0:294:fcae:826 with SMTP id d9443c01a7336-2962ae9e353mr96452765ad.59.1762435694673;
        Thu, 06 Nov 2025 05:28:14 -0800 (PST)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca1669sm28770225ad.94.2025.11.06.05.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:28:14 -0800 (PST)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Google-Original-From: Vivek Pernamitta
Subject: [PATCH v5 0/3] drivers: net: mhi: Add support to enable ethernet
 network device for MHI NET driver
Date: Thu, 06 Nov 2025 18:58:07 +0530
Message-Id: <20251106-vdev_next-20251106_eth-v5-0-bbc0f7ff3a68@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGeiDGkC/zWMQQqAIBAAvxJ7TtDKoL4SIdputRcLDQnCvydBx
 xmYeSBSYIowVg8EShz58AV0XcGyW7+RYCwMjWy0UrIXCSkZT/clfmXo2gWi6vTSOoeDhRKfgVa
 +v/E05/wCfzajDGgAAAA=
X-Change-ID: 20251106-vdev_next-20251106_eth-dd145c3bbd9a
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762435691; l=1362;
 i=<quic_vpernami@quicinc.com>; s=20241114; h=from:subject:message-id;
 bh=2h1I5+IC5FJduxoWNinXYw0aN3SdJu1DaG7hWWK8DdQ=;
 b=ZwpGqEXZUQmUg6ICYqqWCw9x0Kokox8JXNsLBX1vf2dZG4LAgl3f8PKnrOe11Qr31Ydc4dqAK
 lXB7mcsCjtCC8eNC1Cfp4x8bgHz5dxK2yApUZ62b/XdBoyevAxj7Ser
X-Developer-Key: i=<quic_vpernami@quicinc.com>; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Authority-Analysis: v=2.4 cv=W981lBWk c=1 sm=1 tr=0 ts=690ca270 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=veql4nHwU9hKf8MHYCYA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 3e61IaoIl3htLl9wGF5cOmd6Q62Uume4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEwNyBTYWx0ZWRfX4jzUPLquK4na
 kaMXP+kOuKMABbUNjm2Zy3Z4QG4Wzd+l37cJkhYIXEk1B0arZHZNP1NuG0HZ61xDYKaf5FJLcNL
 0BVQcLuToQJw43lAtHL1ATZ1FdoHpof6eRxTg398AMv9QMKfSuQPBjsv9Fj4ZD22EGcTiJ5tZh/
 aNMCNoGcr5f21UOdwz+WGGVkXPWc8OZvZletwJLmONXX4I6Abi+GtU7QylvkWiM2a6s92/B4H2B
 mpwQrmKjjD58QQ6vLjGqA7RlTm/Z7b5TdO0fhKHCzKmEjBSh4ldTuH4cIWeACS7ziTLuhUzNvgI
 SKxP3Mk5GMFsRGbqIafHSLt3+l5iCQ3YONEfZ4OavnOWKIovysXCLc1lQxY2zWIiOm7RltNQSL5
 ucLPScU+9c8iB62tAc5SjaFs8FT9Vw==
X-Proofpoint-ORIG-GUID: 3e61IaoIl3htLl9wGF5cOmd6Q62Uume4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060107

- Add support to enable ethernet network device for MHI NET driver
  currenlty we have support only NET driver. so new client can be
  configured to be Ethernet type over MHI by setting
  "mhi_device_info.ethernet_if = true"

- Add support for new MHI channels for M-plane, NETCONF and S-plane.

Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
---
previous patchset link: https://lore.kernel.org/all/20250724-b4-eth_us-v1-0-4dff04a9a128@quicinc.com/

changes to v5:
- change in email ID from "quic_vpernami@quicinc.com" to "vivek.pernamitta@oss.qualcomm.com"
- Renamed to patch v5 as per comments from Manivannan
- Restored to original name as per comments from Jakub
- Renamed the ethernet interfce to eth%d as per Jakub
---

---
Vivek Pernamitta (3):
      net: mhi : Add support to enable ethernet interface
      net: mhi: Add MHI IP_SW1, ETH0 and ETH1 interface
      bus: mhi: host: pci: Enable IP_SW1, IP_ETH0 and IP_ETH1 channels for QDU100

 drivers/bus/mhi/host/pci_generic.c |  8 ++++
 drivers/net/mhi_net.c              | 87 ++++++++++++++++++++++++++++++++------
 2 files changed, 82 insertions(+), 13 deletions(-)
---
base-commit: df5d79720b152e7ff058f11ed7e88d5b5c8d2a0c
change-id: 20251106-vdev_next-20251106_eth-dd145c3bbd9a

Best regards,
-- 
Vivek Pernamitta <<quic_vpernami@quicinc.com>>


