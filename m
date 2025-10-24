Return-Path: <linux-kernel+bounces-868833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DD7C0643F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DBB71C0588C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0506B31691E;
	Fri, 24 Oct 2025 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O7uGKTtK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD29130E0D0
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761309097; cv=none; b=Bm/7RagugDVSXzapekTAi8UpSeC9TgjYsHGMqIwAu1Yt1o6izMBPyUPW4+7Pks8pc11+SRvJA1HxuRzYExqNjjcfncbwwXpEWx62gfpcZnjko4LQ3zXPrYR102u3Bbyjtb8grJLKyGDYBa4F/OCxHb/dLwLUYKxuRP/Cyb7MNy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761309097; c=relaxed/simple;
	bh=XiTDVkg1kAETpNdGmqCEBuwWFR6IVEd0PECMW0nJHq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kNI1MtbrRAhkhsGiQDQ6BlZj0yTEsw3CLYGeMY2O2b0gfmtaK74oI51VX80I3rA+2M4ECsPgMFFG+MQ0pCi0UuxdZkaJ6JY+2JB2zFeO3aNVufoqdBE6ad3V41nJVJh7biW3NKciYg5q7FMQysdAOYVSEhXB/i82NeY8tHHaTEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O7uGKTtK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OC3i9c000398
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=2bAsfJsMqfmVZMLORayPyE/1jk3wBrKlzyf
	VzHYGp8s=; b=O7uGKTtKODlV1izXE+xekeaagbTBEkBALzCFByC/LBULekqcUMs
	tM4kZCOaiirBv+YkyHFrAHAz5cCbAgVP8jqaRfIg7iS7DAgiODvEGIRsRWNvcnDy
	zbQ2nGnhrfHVsXZGA23LXz6GhJ4FSAV5B8BnLmd+LYZuErzHzrUo4xN3AVKusmMO
	C4QTGyXf/wviu+OfxSrxBnB4XW6CKRwpeJDpl2gBTUGT9tpkOabEoNpImrOogzDs
	mW5bl8NOEyiNSGoulUCf/nu1BC3ci0SEo1cARRPa28o2GO02/PWsNMp62/uFnXcm
	ji0D4Scp9mgfYW2GjMoRnPgUs9Ri+EjSsjA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49ym9j3msd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:31:35 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2698b5fbe5bso27506055ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761309094; x=1761913894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bAsfJsMqfmVZMLORayPyE/1jk3wBrKlzyfVzHYGp8s=;
        b=W6lPZqlligUi62HWjQEqxBVneWMndJA2yUxNT/BJmseWpUgCmrJsnYOE73WXu3DmpO
         vyBaRrrUqY/tX8tVhx8DOboV0y3Pj6XPlTCcrg2bjvEJybcEoYf5QCz7qH91Ozcq89TZ
         J+usl0UkHMQlr/OAJffqUD0Lo2Sq6NRjq2gDZi8oyHit2D+cvwuxyP5ncNXODBkxufq0
         hURAMKvuO98X0YbprZXzHC3yQVeF168YmGnT/Z04jEMCgzStAkRwlaTfKVub+uAynFFp
         C6fy6pRx8ZqIj+BD3itW6VohzF/yRf/VhHxyPHKyHcfcZ1pWcwpqhzPnAI3cZvnlGc3X
         mH7w==
X-Forwarded-Encrypted: i=1; AJvYcCUx0z2zJstp1+yzq+xeoD1PS6epndFi5UM5ZEAzHrPOJVZ8CxAU+wjt86yhDdEGlTO436j8gKn9FXHUUKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxREI+RvRKUreF0PkXwq23rqdV2aDEaEq/1rpPaa9N8OvZI7EYu
	3Doqcxh3jnVP5tm05MEHWgRkYmZ0B3pbqTa4YLrY1nVhQ0BbpORlYHMEKmxj+Q+0+1sVRYApehH
	ltkM+oTUHeQVJffGlFqhG8BKGjz4typJd4hBf2SvkMHQ3moEaHrB7zyPR8u0IFD3pTjG4b1tYgQ
	mdPA==
X-Gm-Gg: ASbGncsSwlzWA99WvFmgl7OsMYVrBD/FSzvC8W+JfmQYMXHVS3G19+3qU11b4Iak3Dt
	xbFGw/bZiEe63ftC9djSOseIbJkvqk+yqfVp5dS2lQucMdj9CUQpE2hncqgFFKuYxVpwXti2saP
	KZqJGxzOnpyAqWHMhkdNFhiIIyu0atgOoIobNdxzWX+irPWqC4x8bpd/TdJMazsx7WDJKkk62Le
	2o+Iw9GpyG+MEodHdKmrTc6RYqUAxlzFCglzZQMP7U4TpldBh0IFxhPnIelak8EcIEQyAP4Inyx
	ptznodXnGsxlzwkutiEGi4di0S+YZIx8RHAW4NXGA7jkRU5v+UNYtNKAX92xEr1Dt3y+p/Lh81f
	6Q8p2W9UVIimf/62jGcApMjiAkqV/qEWHA/R14WKuCO43znqSnkXn
X-Received: by 2002:a17:902:d50a:b0:290:bfb7:376f with SMTP id d9443c01a7336-290cb46bf6emr323434215ad.51.1761309093993;
        Fri, 24 Oct 2025 05:31:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEucBc3iLZLhsl0wh3jp8jpvtimkKB//Sc+M+8IumHk8rQsjhXsplOGeikn1LVFuY+rB3c6XA==
X-Received: by 2002:a17:902:d50a:b0:290:bfb7:376f with SMTP id d9443c01a7336-290cb46bf6emr323433855ad.51.1761309093557;
        Fri, 24 Oct 2025 05:31:33 -0700 (PDT)
Received: from hu-punita-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda72d0sm54981275ad.16.2025.10.24.05.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 05:31:32 -0700 (PDT)
From: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
To: rafael@kernel.org
Cc: lenb@kernel.org, cp0613@linux.alibaba.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@oss.qualcomm.com>
Subject: [PATCH] ACPI: SPCR: Check for table version when using precise baudrate
Date: Fri, 24 Oct 2025 13:31:25 +0100
Message-Id: <20251024123125.1081612-1-punit.agrawal@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CLknnBrD c=1 sm=1 tr=0 ts=68fb71a7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=3rrkCrMOeJKuegrRhzgA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDExMiBTYWx0ZWRfX+TEeLRpCy6DB
 uQG0zwBNrsfJ0HGeKsSriTIcr45IsDgn6Eylv0i27/+pQAX0f0v92MRCuZezfhJiMKJ8LwNLhlb
 /oNaiJZWz9+H4wB9Xt0+FUDywa9DUoq0WBPQgnOO770EYACglWZCEpuSlS3807gbbuxg+W/WsVq
 nIkrWiEOfkKIBGiEDWCHsouLhWp4R6tmYvnpKwS2/8fpdIPqhb2coAwIt9Soui7Ahb3TpyvaJH+
 9NO+Lh0KXr0z6ylmEIS/Hm9/NUSlqlbY4nA4BWFzx3oMgySaD8XPBMvDrEuk6/6W37kFgGcja7P
 kGpn2+lTpP7yzjD1F31/kTEAJ3OMucfxA0TrknIEq2PfEHeduNtyN8FzNetAeCaWPSjoUbCR8s0
 +Zh58PdPgtBRUph/7R9VHGPzkQgtXQ==
X-Proofpoint-GUID: zpBApybNvM8R5Y2BZiC2MZuPUpoY7kEB
X-Proofpoint-ORIG-GUID: zpBApybNvM8R5Y2BZiC2MZuPUpoY7kEB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 impostorscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510230112

Commit 4d330fe54145 ("ACPI: SPCR: Support Precise Baud Rate field")
added support to use the precise baud rate available since SPCR
1.09 (revision 4) but failed to check the version of the table
provided by the firmware. Accessing an older version of SPCR table
causes accesses beyond the end of the table and can lead to garbage
data to be used for the baud rate.

Check the version of the firmware provided SPCR to ensure that the
precise baudrate is vaild before using it.

Fixes: 4d330fe54145 ("ACPI: SPCR: Support Precise Baud Rate field")
Signed-off-by: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
---
 drivers/acpi/spcr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index d4d52d5e9016..73cb933fdc89 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -155,7 +155,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 	 * Baud Rate field. If this field is zero or not present, Configured
 	 * Baud Rate is used.
 	 */
-	if (table->precise_baudrate)
+	if (table->header.revision >= 4 && table->precise_baudrate)
 		baud_rate = table->precise_baudrate;
 	else switch (table->baud_rate) {
 	case 0:
-- 
2.34.1


