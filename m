Return-Path: <linux-kernel+bounces-786661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C0DB360F0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC158681348
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FE713957E;
	Tue, 26 Aug 2025 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l2QtiTXB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279B1481B1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213277; cv=none; b=kzv4oZXO9zF2wjgQXTxuH8VlpGpGSXgw/+2/JZVvPOWCQGIv3XcEhdkOWCNabGpje3OQ/jC1X+y/GE57x7nN5X8KXFfO5vDmGkNLkbJnYeupIjiaaSZzu2jUsaocOX2vowIgb1Dx67XG6asG1Iu4oSXrB3ZW63UYRwrcCV4w1+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213277; c=relaxed/simple;
	bh=WiFIVlhta9JercJY9EmcUaUisd+r6zjNrGKcf5WuE0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3GDu09r9NAVel3Cm+/Er/Rzkt9myyJrBG2vA6jM8a0cOonmift9Gp1z8uJ986qUerDQZI39wYaErre3QmIqmXtubthPU6kIQZT5od8YhNLY6m7/HGrEfCBiKzGQ0Ehs+CJdg2ZjR/Yq7BpzuYhYj9L3ExbL5E5+ZuSV6TxdkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l2QtiTXB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QBoIMN006172
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mWchJMmbNPHLwCbrwvJV++oQysNbAeqpc0B
	0OSiGaXI=; b=l2QtiTXBVvxcp8HgXyPKJdK57eSgAU7Z2NWx2e3sledtb9/pdzb
	V6sHhzwVdfE2W5FSEY+yf5gN/k0OQk/D1N2T4q4yyG4SdaNOL2huOQE29SOrE4gq
	nTA+I12nnduXFuG/Fak9P8P2pa53akKvss+Erbm6pws5kdQbZ7nr+rW0HDul7f1v
	/bUEKiiA69tY7Uo32ohOos7q+yCKYJcM50sFEASiKnEKpolFZ3J1/FxGGHcCEOX0
	dL2JGRZEBS2sdGBXgL2yKECLDcGGfqY8u3USN+UteJ2hP35N+IF12j2+02RI+Rks
	ll+7YMOaKPq09IBTyfPzzwtVH/oAc4D4VPg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6tj0u5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:01:14 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-53c8a312193so2316729e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756213273; x=1756818073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWchJMmbNPHLwCbrwvJV++oQysNbAeqpc0B0OSiGaXI=;
        b=AxjxuEcEee02gB9ZdUcXYWJVK+nQR48VQ6eI3iXgRH5cTDm18A0PZ5ogghQ5KlOoW0
         9S2K6Q++BqHIsf69VhwCQ4aJLbmHpONZ8QZ/Vi0dIusWKI7yOwkiz2mBVkbv7YPqCM7t
         CDUUwMekMsOQTTDaMU5MMJlBzPy3QXbCHtiDpByoSBzzDu2PYvmUTaB2gOvgMXfV+boT
         qlJFgdY54sgwTnWIMkolG3bYWpcVMG/KgzYZdrLX4DKDrlRsUAKrH3UKChjWz6DQ5gSY
         glPhaxscefifjyZVkSlXd2b29OBKpHOJVZ1hUI09Hpg8pOEc1XUQA8C7RUh/uwL14aJm
         iTjA==
X-Gm-Message-State: AOJu0Yxu5GMaDMqlo3a3hcpaqutwaiff5VoW1AD/9hep9TsMAPoQOuGu
	Q0/Syiby8uC7cL2rzqDhcUzxU0RBk5AkLOEbmqKAHdN+bzXT58x0p04nihCgeM79dpvFHrb+jq9
	9QXYFybX37Odk0kuhfM3sg2i9X4Bz0EOKtR+t+8HpG97nlMG4JTHUtZQZAadnz1p0uh4=
X-Gm-Gg: ASbGncue+XEglIz8g9GTjxXpmhsnJCYx2I0tsMXbb/dFYLIvxFwTozAwFkan06fEGwp
	G6PCXSImXuifI8PTgxVnu9ql621O9/9ZrpThyBThRpUd5m3t3capdUvSYatVJYUPPDN0wgkfQtJ
	El2sQVLql1WT7OgdLQQi/67+/g+vVAq6SdwjAvitx768464UocoOIsMdN1024K0wQXRSYiLmecy
	vM205pipjSmMJeyNZHtK4+waeHAkYkuvqnfDa1ym1R7aBM5yfLLgj2RNFywKWwL70H4Ln0AQ+dS
	Uf0FJcYilauzoxR82WjWsilA7JueP1MFdkVcycNEgL6sGZYqlNyky/BLY4VxizDF
X-Received: by 2002:a05:6122:8c9:b0:531:4041:c4c7 with SMTP id 71dfb90a1353d-53c8a31e39amr4122186e0c.7.1756213272225;
        Tue, 26 Aug 2025 06:01:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhdJnTxwNhsMQjYmr19zw8wvmfe8LTYAip5JKv0wVmarkiaQpzy9+sRlZHf0eULP/s0XNZEA==
X-Received: by 2002:a05:6122:8c9:b0:531:4041:c4c7 with SMTP id 71dfb90a1353d-53c8a31e39amr4122141e0c.7.1756213271475;
        Tue, 26 Aug 2025 06:01:11 -0700 (PDT)
Received: from PHILBER.na.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c3119ffd4sm7020978a12.6.2025.08.26.06.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 06:01:10 -0700 (PDT)
From: Peter Hilber <peter.hilber@oss.qualcomm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Peter Hilber <quic_philber@quicinc.com>,
        Peter Hilber <peter.hilber@oss.qualcomm.com>
Subject: [PATCH] MAINTAINERS, mailmap: Update address for Peter Hilber
Date: Tue, 26 Aug 2025 15:00:15 +0200
Message-ID: <20250826130015.6218-1-peter.hilber@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0MyBTYWx0ZWRfXwmpjvb+aCTO4
 WAjc5uWwiDoTtMbgCFfkWyg4DDvMKCg5pUX4qKO5pSGdDb8tTG7/GIgp9wqhpO6K8sEBpgJ/XP/
 hy0yPzy7UyWn4NFoRiCK0DVj64ecmxibhk0jdTS+h8CoNR3BQRM2mMwO2b6hN4wajT0bE4VPtjP
 +X6NevIHJYYswkZ6AtZtV/MlhrKoN5hMwIoZ6evbNifb0UN8tr4UDS/JVXkGh2K34Tf9TOsIlwu
 JjcWgSqWBPP9MIDHHQ4y3FFyM3l87FHkv0u2fvhBTeqF4GSGERMaqpEhVLG3GISJEQuSJrc5jT3
 y8Xx4C5DGF8u7VfC4XcaFReQaGds3Tbb8ZSQzT1eJXhGQN1HH+YtK4YqCJmjAGfDSrBl1eOUECJ
 2aiWbEx6
X-Proofpoint-ORIG-GUID: 8-OM4vlutFZyMkEQx969VM3rmKq0sU5g
X-Proofpoint-GUID: 8-OM4vlutFZyMkEQx969VM3rmKq0sU5g
X-Authority-Analysis: v=2.4 cv=W544VQWk c=1 sm=1 tr=0 ts=68adb01a cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=tAGQbYHnAAAA:8 a=iox4zFpeAAAA:8
 a=Li1AiuEPAAAA:8 a=COk6AnOGAAAA:8 a=LpQP-O61AAAA:8 a=zd2uoN0lAAAA:8
 a=QyXUC8HyAAAA:8 a=fef9ZFAnUNnnEvqdXjEA:9 a=hhpmQAJR8DioWGSBphRh:22
 a=lXWXidlrYx5KKt6n-8sY:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=qGKPP_lnpMOaqR3bcYHU:22
 a=TjNXssC_j7lpFel5tvFf:22 a=pioyyrs4ZptJ924tMmac:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1011 suspectscore=0 phishscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230043

Going forward, I will use another Qualcomm address,
peter.hilber@oss.qualcomm.com.

Map past contributions on behalf of Qualcomm to the new address as well.

Signed-off-by: Peter Hilber <peter.hilber@oss.qualcomm.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a124aeed52a2..523e6e672790 100644
--- a/.mailmap
+++ b/.mailmap
@@ -622,6 +622,7 @@ Paulo Alcantara <pc@manguebit.org> <palcantara@suse.com>
 Paulo Alcantara <pc@manguebit.org> <pc@manguebit.com>
 Pavankumar Kondeti <quic_pkondeti@quicinc.com> <pkondeti@codeaurora.org>
 Peter A Jonsson <pj@ludd.ltu.se>
+Peter Hilber <peter.hilber@oss.qualcomm.com> <quic_philber@quicinc.com>
 Peter Oruba <peter.oruba@amd.com>
 Peter Oruba <peter@oruba.de>
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev> <pierre-louis.bossart@linux.intel.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index fed6cd812d79..8340dde41aaa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26775,7 +26775,7 @@ F:	drivers/nvdimm/nd_virtio.c
 F:	drivers/nvdimm/virtio_pmem.c
 
 VIRTIO RTC DRIVER
-M:	Peter Hilber <quic_philber@quicinc.com>
+M:	Peter Hilber <peter.hilber@oss.qualcomm.com>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/virtio/virtio_rtc_*

base-commit: c67e16d30dcacb135bb34a354b7d5e27c731b49f
-- 
2.43.0


