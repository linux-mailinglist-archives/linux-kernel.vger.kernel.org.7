Return-Path: <linux-kernel+bounces-889906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72950C3ECE9
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FCA188D93E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF1930E858;
	Fri,  7 Nov 2025 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jcitbyxT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K+cgER4F"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567033093AA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501545; cv=none; b=usHYzbamP2lpu6wKGzEyLDLGI8euBwK+limQWuKEp7J2bbL63hH3Wy3UZEUixncNK0jBHkK75Fp+7o0s/sx7LYwihZ+M2XDahLVFBezVZL3GYOKYunFF9Rs0dBSVBnQx/BTCVwrJ+OEmple6e2UHRpEfCpkKJ04dWchr2c8P2Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501545; c=relaxed/simple;
	bh=iL9jg8JielYKJvltCPaRLVi9XYRF3/bpxORT8vDhO0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qnMBV9JYnh1eW7AQ6tdMJZboeIftHYQj39BqlJcKHIVXngV2w5Bg/w3NqStiNyTICa0loE1BcZUMce92s8urC1XOrFi3mNzVqGBqoHVBXY+p5lF3ZTnbeySNTOqCU3IWvJmUG//oCy381SeobxGe61WCJaZjUs6jRa4UIb6sAlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jcitbyxT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K+cgER4F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A744pC82085568
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 07:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=JAQSrdQnU5b+xEfyyzGPcAxz+3ZD1vRWfFZ
	NNoPawVE=; b=jcitbyxTeiUIeD4Zd7brr/eGbSa921wc1LegkI2wONEEFmA9ISH
	Gz5EVMyOKMv87BjUyspDbipAiLED0M0nTbkeWGmUWrGrut5QvP/0VssQqdlpqWtb
	2aAtigd2fZgrg8jtrQjfX6lOw+5PKTXiljmK4WkmjLpQiA+yMcqhR/9gdBZTejCB
	M9mEpWy6g+I4A9yvR5avp5w7DEKcjldzwwbQNCcKMsW6PdlMPSznp2S6/S/1+hmA
	83wB3jF/MynjmLgvonuk/cdJTvaVjTFDXyxERmaFSq/dddsIC2dYCSVHsLJfZb6E
	NUylz13x0fBu6vj1iRNWPleY1a56v4T/Orw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a99e78hmn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:45:41 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-294fb13f80cso6936585ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 23:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762501540; x=1763106340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JAQSrdQnU5b+xEfyyzGPcAxz+3ZD1vRWfFZNNoPawVE=;
        b=K+cgER4FmPPG+Xxd3QbDJ4se9xpzCQ+ZCyNEROtmdd2ymK1KcPxV4OAVL6djWGumNw
         6gOGufFE5FbguioYoMk8ZZOlntdE6D6Y2s69z4ORmUxaUnTjlDLCVTvuIE/fAe7Yg6a3
         D7839kvP98Apwf+unYSCtagnJQiD0oW4VdN2Hpp5hbEd1kIAdvQ1R3WRP7smDZ/1lv/W
         PgaCTvrWecWLNDUtyw4SU9h7N3wlq1N6WjgZCHgDK0Xxr1xcQbSPuVAIH2tyLWs07FFn
         kiP2hUMdlw0zKRw57DMSwW6zdNsvgcqcUnje/jL+1+XZSAo5+IypOKOrHz/XmS4HHraj
         wjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762501540; x=1763106340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAQSrdQnU5b+xEfyyzGPcAxz+3ZD1vRWfFZNNoPawVE=;
        b=WHwsjaTZdKKYT+LpUEUg4VB706NIpOPlaZxYbQpsuoWgPyLz3CLKAJQO2+/jfeRCDC
         PfBQ8q1W+7PFAIhwKZ6uk/Wb5W0mj1WwqEGiE8eK+32WFHCARm+OZHGnAo3BKPZsZd+F
         g5gFlPGIlxNayQH76TdMgvz4FTrHDCZ+VJZK3TYs3NIwz95Picc9bAFsF/Mwes0r6iB4
         oG0Y9POb8f2MMUZ3U9OKNjYBcnUN5fVL0XZb6i4XAr7Y5KYi51mxLpg66Vy86KYXuGcn
         QTDA7U7GcZ22LmkOJt13M/WUK73M/oJdE07nWJ4qVtRzfBflt5K/i6BFEYTv23J2XiUV
         p9XA==
X-Forwarded-Encrypted: i=1; AJvYcCVuvETYFBmCgJkdqdUJMCfKXhGUC8DCGaa4vcJgeaSSh5rgJI029Aou3M3meZsCNODi56U1yhhh2z7LUvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWbHVOtL+HzvyqRrxfVUV65zRMc9QipO57Rmp8fiKwxGbpYp0O
	3Pf6BwJchd5Nwrih4pEBjKqLbpNfBlRYY4GF8fEm2iu8+3yvY5jXm2kbSqxxpIfKXkcQugNCrfe
	WydfeX5JCYnjmI/5nsZGL0/9h2rsMlo03Mz9SzXbbuNu40+TXR3C8njxpT0nAh3AfVaE=
X-Gm-Gg: ASbGncvj3bCunGNX6oQL6Z5PJX0mOYiShOd9LOQwEbE+dXbR1KAqIoktDjAPFoN8GER
	nD3/9jL0t7zxJDVuRMQhKetheDwMDGq6m++spbeW5iIZBftGhv93B2NBuDLtO6QV3th7EbuxuLQ
	tkj5mVoBL7H5pmwaJ07UHl8ME1SDkCZGbW9iPy+MXgCbeV21oJxTH0nVvVL3U9eIYfQ+Jg2xU/J
	ZRzDGgrChHZuRJ+IQQwQPxw2CV+4HM9gjS8c1DJY5Eyxr2jpGO86dFz+EkddFknAcSakUN7TVRb
	jp8ZEufCB+5fOGTHy+v4vu8NwBWThD+Nnb0wswvhfGB4CUNTRVKY2wtN0GrnswwyCPjg3HiEpgs
	qsDliCSQwXux32Zah1i9GOKDEaIssNJxVBM1nGvEHqn518kS9XO0KKV6TUmJUZKm6Tg==
X-Received: by 2002:a17:903:b43:b0:271:479d:3dcb with SMTP id d9443c01a7336-297c0395192mr28621795ad.6.1762501540134;
        Thu, 06 Nov 2025 23:45:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKeLzOMREliBO3SqmoQQ2j3ltfEsJ0J2WpMRv3VjriUjF30BWJ92SOqCEY+shDXYfmeUtCwA==
X-Received: by 2002:a17:903:b43:b0:271:479d:3dcb with SMTP id d9443c01a7336-297c0395192mr28621335ad.6.1762501539539;
        Thu, 06 Nov 2025 23:45:39 -0800 (PST)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cd2418sm50884275ad.109.2025.11.06.23.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 23:45:39 -0800 (PST)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
        richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
Subject: [PATCH] ptp: ocp: Document sysfs output format for backward compatibility
Date: Fri,  7 Nov 2025 15:45:33 +0800
Message-ID: <20251107074533.416048-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA2MCBTYWx0ZWRfXwT4R4yUpgaFY
 UhATkbhsMU+D4kTw7A6FZVn2rxjBBcs/R2FGzQgLwbUddZZmkV+RnLQIPiDK5rbetFhDgi4yS8h
 jdSJZ2tYJ1WmW7qBZXvK96/+H52k+k6ekkqOzdUVe75kPLSVeTFm98MSunINFoG2YzXP0UogD7+
 bSAEC1GP8zaZBN2/JTGdsl6nefByIXNzscRe4ohJ5wIHzRRkHnMXrIqyyZ0hhw7Qq4bUPAAxD5S
 YQYVbzCFZfXJn33EAeaNm2wPEwXDQDh0yVV7+kZkfBIpOBxTOXd1wgq7c2YsCZgr9vijrG5sm8i
 MERxYrQFEq8eAp+Wpza/UXSBOWpudya2EMSW8ctfD/COo5AvM4KtFIXkTra0tVWoOUunjfODDS2
 fgRtFDhMlItNZNXVmxgQUV8NMXHAHA==
X-Proofpoint-ORIG-GUID: jULUF9MXihyO8yaQgJK94oMF9StBX3tz
X-Authority-Analysis: v=2.4 cv=A+hh/qWG c=1 sm=1 tr=0 ts=690da3a5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=P3xlrWuPvaME_hMzoIMA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: jULUF9MXihyO8yaQgJK94oMF9StBX3tz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070060

Add a comment to ptp_ocp_tty_show() explaining that the sysfs output
intentionally does not include a trailing newline. This is required for
backward compatibility with existing userspace software that reads the
sysfs attribute and uses the value directly as a device path.

A previous attempt to add a newline to align with common kernel
conventions broke userspace applications that were opening device paths
like "/dev/ttyS4\n" instead of "/dev/ttyS4", resulting in ENOENT errors.

This comment prevents future attempts to "fix" this behavior, which would
break existing userspace applications.

Link: https://lore.kernel.org/netdev/20251030124519.1828058-1-zhongqiu.han@oss.qualcomm.com/
Link: https://lore.kernel.org/netdev/aef3b850-5f38-4c28-a018-3b0006dc2f08@linux.dev/
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/ptp/ptp_ocp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index a5c363252986..eeebe4d149f7 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -3430,6 +3430,12 @@ ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct dev_ext_attribute *ea = to_ext_attr(attr);
 	struct ptp_ocp *bp = dev_get_drvdata(dev);
 
+	/*
+	 * NOTE: This output does not include a trailing newline for backward
+	 * compatibility. Existing userspace software uses this value directly
+	 * as a device path (e.g., "/dev/ttyS4"), and adding a newline would
+	 * break those applications. Do not add a newline to this output.
+	 */
 	return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].line);
 }
 
-- 
2.43.0


