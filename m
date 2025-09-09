Return-Path: <linux-kernel+bounces-809132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A92B50901
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295095E6EBD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E85271475;
	Tue,  9 Sep 2025 22:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UdoVy+P2"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6DF24C077;
	Tue,  9 Sep 2025 22:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757458288; cv=none; b=bQ5DDC454cIrakykoxvSM9nRMkzO+Yiv/5Rz6HAeVOeAUKCNIns+D6RiHjp3Z6I5rRrPBwk15v3RPryWbHpKKSfuVdJA6WgsC8cSyxybMy4FvftOnm6/fqvNoP6NAAXztIxHzE+d8Cp1Ay6zjd51ooyLM/qQWVcwyf7r4XTsMbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757458288; c=relaxed/simple;
	bh=hVkbApMjSIvOcQPTbhTfbGDhsk7uuR0NkY2ZCWwukDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E9ZMxD9pxnl3hU2exaGfMa2lHjP2O3dC5sHADQ5WWpJRlPszzGvL+Gun/P/n1dprCPRLAMbSI8OH5lPYQ+724B3RZo9UM+fsJOlBmQnAgoxS+aOx/fz+CKrv1wrbx+tjTVqqWG02kVEzyF6s9SGrBFcIAqYjqCxWaHflG8eCPI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UdoVy+P2; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589L0XYK030992;
	Tue, 9 Sep 2025 22:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=R5/kwEtBv6MTG8QxbIi61njmmPO+O
	S//mRuQfHWca5w=; b=UdoVy+P2j8q2+G5QqOP27sNDZMBD6oSmauiFdAXJidAi9
	FF+pGO6LcgWpIkEp7J450itXC4rI0nDCOea5NVAS0Yq5wCQfYJ/FG4DuPWX2VOso
	qJIpI1qxk1tcHmIld/cvHFP9Nk/knRRcTbxWugzu3CgYWrzVTxiAHP1rQlxTmQop
	8nLiAF+G9SnURoFSSnWYg2T5QOPCKYsIEDx9YuMut33JWl373jRjCgCSdM7K2QOn
	T5Y1ITjlze+9ZlcaHXs7EGidF+VE2NSnocol5su/5JvQ0CkhThk9iM6y6KfLMeOk
	INfIO4swdFWvs6cbzh/JEnoMoyi8geEgaABKGXxpA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921peb2en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 22:51:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589Mb1n4002987;
	Tue, 9 Sep 2025 22:51:13 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 490bdgrsyb-1;
	Tue, 09 Sep 2025 22:51:13 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, broonie@kernel.org,
        linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org
Cc: linux-kernel@vger.kernel.org, lgirdwood@gmail.com, daniel.baluta@nxp.com
Subject: [PATCH] ASoC: SOF: ipc3-dtrace: fix potential integer overflow in allocation
Date: Tue,  9 Sep 2025 15:51:11 -0700
Message-ID: <20250909225111.3740029-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090223
X-Proofpoint-GUID: KcywZnWSITHM6LfDXmryhOSK9Aq_v1Fy
X-Proofpoint-ORIG-GUID: KcywZnWSITHM6LfDXmryhOSK9Aq_v1Fy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfX6hwg8mXDOpd2
 aFbw+LhEfVmJZ2z0kKVgvuNnJ4oBkRQ/3HcV+L2FLi9JuTsQ86VD+cTeWDNB1iEVI3YaPBeMNVg
 jg9KlP3fWGA6AoCiwY/rvKlS7tAgZfh6TVUvB4tmn0LN/yNjsoNCub+PzlJQFVPdxgrnSi/zA0Y
 CoIvyuFvtZETQ1LCs4xpG1dUa+TtH54Kzibw4CxXz3rgne3Tiz9EtMKwMv7Y+Vr7CmYFR4xQQV5
 cNJIV3/u4KoNK2HoJqOW34Pz1WpLeC141uttaquANuc584inmgyGt60DmDwIRDygMLUMwLmO3KE
 shWjYgtlDwnSGGP6SLTyWqpCHk3ev3nwUVNu31NmUJB8+MkaHNqBL8DDdT/qv59vyLbLmNeT8WX
 qp2ddQDrjfamfGsRejz6un8ssItotg==
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68c0af62 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=mtaZG1nP8qNN4-AM54QA:9 cc=ntf
 awl=host:12084

Fix a potential integer overflow vulnerability in trace_filter_parse()
where the allocation size calculation could overflow.

The issue occurs when:
1. capacity is calculated by adding TRACE_FILTER_ELEMENTS_PER_ENTRY in a
   loop for each entry found in the input string.
2. capacity * sizeof(**out) multiplication could overflow if many
   entries are present in the input.
3. This results in a smaller allocation than expected, leading to
   potential buffer overflow.

Replace kmalloc() with kmalloc_array() which provides built-in overflow
checking and will safely fail the allocation if overflow would occur,
preventing memory corruption.

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 sound/soc/sof/ipc3-dtrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc3-dtrace.c b/sound/soc/sof/ipc3-dtrace.c
index e5c8fec173c4..6ec391fd39a9 100644
--- a/sound/soc/sof/ipc3-dtrace.c
+++ b/sound/soc/sof/ipc3-dtrace.c
@@ -126,7 +126,7 @@ static int trace_filter_parse(struct snd_sof_dev *sdev, char *string,
 		capacity += TRACE_FILTER_ELEMENTS_PER_ENTRY;
 		entry = strchr(entry + 1, entry_delimiter[0]);
 	}
-	*out = kmalloc(capacity * sizeof(**out), GFP_KERNEL);
+	*out = kmalloc_array(capacity, sizeof(**out), GFP_KERNEL);
 	if (!*out)
 		return -ENOMEM;
 
-- 
2.50.1


