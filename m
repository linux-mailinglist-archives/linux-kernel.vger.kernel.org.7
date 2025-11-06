Return-Path: <linux-kernel+bounces-888589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFF3C3B3A5
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3C618C084E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E0D330334;
	Thu,  6 Nov 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hhxd9tg3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aWLftNQS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C24D3328F4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435708; cv=none; b=mL2K61q6SN2pprccaNFnjoUWc8pIZov4zy8J3i4kglvD8TICk8BtyhKzTF1LaggIN78lO3SLXcg0iHNt5P+fyZxNQLg6LXew6MQRECOrp3YPmauJlXRLLLuNXIlbUN9DeoTdjG+S6iyiyqBajNRhRQo+LHZsC6I0fwos9EuudTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435708; c=relaxed/simple;
	bh=uTPUynvEcw6KdyQKFRCWP++7wpSfzU3ZtWnOxsXH5Hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KS8M/IA1Yh46IFGyA0rqpZ/HX7/t/P9SX0vdPQjmvBgyw9cEMcgFqK41Y9VcR6xkNwbTeVbuxTom25D8M4I+67cLMpzxloByggT1IkhpB05pxVGq3ZvZ/4umIGa3Br8QbxmKMHZKhNmbWAQOX5HhKCU2hZ5jqRxGlN0EYaI1I0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hhxd9tg3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aWLftNQS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6612FZ1737478
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 13:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K6Uln7viSoIgV4FeL3cGSMSD52CLesxi81fBrMA1F2g=; b=hhxd9tg3e0RMQImA
	13EGTQTYI0cDpPbFrOBvP9yjdtqTTkfZeoDP0BtemuHcNPEU1yzJrzbor8JwT0u8
	G+mmVwiLUN1i1T87i33NnEe4ITELZll1fru74+zbGhS9hvZX3m8yIh1Q2vTL8cWX
	r4/iJ4GL0x1IGXaeNMKov+/ppyYFAmg3l9Wi8PDxPM3CtT+PtYQ7WgX9fLkf2c/w
	p4iW6kXUdnNG0VP/BqN+7/5URdsAnevwDeM0h32H48ga9tv5UgZ/+AL4ESAdVHJn
	jRBW8qbOxI7ehcPcQxlLMHDMX6ZNpcTPW71DijnMmdpBOgmsxq1UOS0PFnLbj4D4
	DYRBxw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8an3u65j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 13:28:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290ab8f5af6so11422535ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762435706; x=1763040506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6Uln7viSoIgV4FeL3cGSMSD52CLesxi81fBrMA1F2g=;
        b=aWLftNQS281Can3DNyUlKbIq0v4PEfvv2JE2c4HD50F0MHTVE8Il2k7F+ZGv/3AkQU
         o6MlnSOHO8wXM6FqE40sZqso6tydGUncOfRShLgzjQ7L2UzHsl4JmdKNWNRYjxl1UDNQ
         o+6b8+Q3IRmoEZ+NkCMtjYA3duQe9dA5tHqVluZTdR57FNdO4y2CuwAtXmAO2V5vA+LN
         qWVBsRIydPvtq+eJbL8H0JIVoyppMiStSM/jrlI4Sbv/QMWToheh7VV5fWsreJBYzKDo
         aEXvcDSEl3KNwvyVfjPXWFhESObfyg6co5bn02FfPIBHGrmoXNwDuljSGfEPIX+okGK2
         vMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435706; x=1763040506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6Uln7viSoIgV4FeL3cGSMSD52CLesxi81fBrMA1F2g=;
        b=Glch6bOCNjPYymOuN6h29GAMsYbmWycsAYWtm+vs0OkY9q6ha7tV1TlLj4KzI8biST
         C7Qvt8DXxZXn9M8p/Rf3hegZxZo7I8i5c52NN2RbFuk0DJMJ2ZG3fs6vs6nhg8ta7MK2
         ApVBqe4XHiGzYNOFitJhMIK1YOQljceuInZ39K4elqIK2TiM8evgm74P38/axu1X3JUd
         ghvnmc0bpo/vsTo5nqWNO8c5E5XSQ8A5n3LNxiWdXBK0MWF7cL0eJnzGAKfjEq3FpZc+
         cd/yE4ndZlyGo9ELHfqroZwLYJLFmKkbFrtfsqrHpgSUNGjyl40eg6AmyIKwJnJcGtCR
         0dAg==
X-Forwarded-Encrypted: i=1; AJvYcCX0NUOujtOduN20G5nveL/s3VcIYkYTnKoObt88PhCXTVyOIJKuWWRBlwN2DD6/oUaRwH9sCGk/TUIjFmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOe7btZumf12Qp6upiX8uAyJ/QwRsvaAREMBPZ4c0plNcg9SHL
	mZaKBDizvjqPf+AvjEzVJ0kUpivX9jk48VFBn1ThVB9uL5rOiFlDh9azi+usB60nwWfNJcLHwsY
	QzOF2QaQeBp75UiXmWILRNDfN+gUG5heX7UEJGajQ02QjA3ztgIGnSU3bN1qARE6lIsQ=
X-Gm-Gg: ASbGncu5JaFMkeHM4sU9ElQVcqlh02q209VTMTiqqgpaF6oJW6YH5+6nuJx97kZd/66
	jFoCvPx+rlXIORbyGISnd1iQOQHZDAlmYSWa06yRQux121diaHJjzKoU1N9V/F5Sibo6c+noRRc
	MrtNGPkiGVH9S5LQSA8ba7/TS1diull6SM4bT+aFD0ft8S7e0JPn6Wip9LlGc3WmXbN7cbzdHBA
	t6yLRUlIGJ4oMdTDaGqyiC0DrBbfD+EENtW1cXcfo+32chSgeU8kOiszL76EJFWepB/pxo7eqiO
	P5NE8gAOnfUaUYco83soNQ2AvjqNF0KZSgrRDws2H8yneh3aatVy9FB/OR7Er6IUyJibdeD4+oi
	k2Ic7bxEjcvjMcKluG+pWDevoJQ==
X-Received: by 2002:a17:903:b90:b0:295:6d30:e26f with SMTP id d9443c01a7336-2962ad1aea4mr84378595ad.22.1762435705627;
        Thu, 06 Nov 2025 05:28:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEH5wlKyQgfPrvVMcvI9YDewl2pp4uhag48hOeK/UPGzA9fBI7LtxtQdulJ/CTlS0XS4PBYQA==
X-Received: by 2002:a17:903:b90:b0:295:6d30:e26f with SMTP id d9443c01a7336-2962ad1aea4mr84378175ad.22.1762435705074;
        Thu, 06 Nov 2025 05:28:25 -0800 (PST)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca1669sm28770225ad.94.2025.11.06.05.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:28:24 -0800 (PST)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Google-Original-From: Vivek Pernamitta
Date: Thu, 06 Nov 2025 18:58:10 +0530
Subject: [PATCH v5 3/3] bus: mhi: host: pci: Enable IP_SW1, IP_ETH0 and
 IP_ETH1 channels for QDU100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vdev_next-20251106_eth-v5-3-bbc0f7ff3a68@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762435691; l=1454;
 i=<quic_vpernami@quicinc.com>; s=20241114; h=from:subject:message-id;
 bh=hVsENnFNyiwEUKV4o8qHH64MADCXodAIn37DvsarU7A=;
 b=iKzNM9tlyU2l3rDwYcTOubaB8VZjoj1abicD2JDlL/PTPVLIcfYtHVo0Ll6PmqkhhuNna5E2n
 VpnZexmrvb3C1H0wYtVN3s+NfWlsVIc8AAo0Eymiibx90C7JMj+3/qq
X-Developer-Key: i=<quic_vpernami@quicinc.com>; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Authority-Analysis: v=2.4 cv=W981lBWk c=1 sm=1 tr=0 ts=690ca27a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Vo5YzJSDI_NEo2NC7oIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: XXkD4gNQdB_q9WFoanS-U8wquuP43foc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEwNyBTYWx0ZWRfX7mf7HY99F4r+
 sjGa1oonqBd1+bIU/sDP+UgYUnUKPlTdt08ehf/c91qBxRgjc4ZRNgkZyyTZlR//9K+CMBPyO4j
 WjPWpBhlQQ4qdW8bbEkvCdJisWTYltk0MAVu9N2+9fKuWQ+pgGrQVQFqrX2R9nWiIsaggRIpRaj
 GpBL0poUcV2Qcmp/oL7CwBdnV4q9FYYp5pmfVB5rX99oxUKbOh4QzOitojG5e4cjYOzTn86gvAr
 84BWSf6ClzG5nYrxgMH45+o+pNPDOP1/bMQ8isbHyMmsuvAy6E/DGdQ5TYGVrP//KMr6M+fq+As
 LdTTA1GNSC9QbVjOpTAkKzru8Um81Uq+HbH3Q4XHqq4be+xAv16S+Rj2oEc+5sV/2xUyPeXFliX
 PEfAQ0Axq9FkuRUGcGWQGmJeDhFXjA==
X-Proofpoint-ORIG-GUID: XXkD4gNQdB_q9WFoanS-U8wquuP43foc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060107

From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>

Enable IP_SW1, IP_ETH0 and IP_ETH1 channels for M-plane, NETCONF and
S-plane interface for QDU100.

Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
---
 drivers/bus/mhi/host/pci_generic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 3d8c9729fcfc57f38315d0386e2d2bdf8b7a8e1d..eace36054af9d04ac24538c8b9beeaa37c15b84d 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -269,6 +269,13 @@ static const struct mhi_channel_config mhi_qcom_qdu100_channels[] = {
 	MHI_CHANNEL_CONFIG_DL(41, "MHI_PHC", 32, 4),
 	MHI_CHANNEL_CONFIG_UL(46, "IP_SW0", 256, 5),
 	MHI_CHANNEL_CONFIG_DL(47, "IP_SW0", 256, 5),
+	MHI_CHANNEL_CONFIG_UL(48, "IP_SW1", 256, 6),
+	MHI_CHANNEL_CONFIG_DL(49, "IP_SW1", 256, 6),
+	MHI_CHANNEL_CONFIG_UL(50, "IP_ETH0", 256, 7),
+	MHI_CHANNEL_CONFIG_DL(51, "IP_ETH0", 256, 7),
+	MHI_CHANNEL_CONFIG_UL(52, "IP_ETH1", 256, 8),
+	MHI_CHANNEL_CONFIG_DL(53, "IP_ETH1", 256, 8),
+
 };
 
 static struct mhi_event_config mhi_qcom_qdu100_events[] = {
@@ -284,6 +291,7 @@ static struct mhi_event_config mhi_qcom_qdu100_events[] = {
 	MHI_EVENT_CONFIG_SW_DATA(5, 512),
 	MHI_EVENT_CONFIG_SW_DATA(6, 512),
 	MHI_EVENT_CONFIG_SW_DATA(7, 512),
+	MHI_EVENT_CONFIG_SW_DATA(8, 512),
 };
 
 static const struct mhi_controller_config mhi_qcom_qdu100_config = {

-- 
2.34.1


