Return-Path: <linux-kernel+bounces-761871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92388B1FF79
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5BB189A824
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC06C2BCF4C;
	Mon, 11 Aug 2025 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b6N9SLQ1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9171D29B8D9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754894646; cv=none; b=VYcbVMmYSp3DyHyHte3K5+HASX9RTXquI8cOxlZWIe4HK3RDd7YYzg/F8+UEAHf5vICnfhXFFUZ1kWvbKrwpEikvfcifW5rG+SNR5Mp1Hx9yLS6qE5EAnfTwXDpvcinV2vUQKuJ22NWxfIXImPatGxNGSHi/JRRsDo8uXKFz4u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754894646; c=relaxed/simple;
	bh=s4GwXirPmnwrklqgYlPGqqWKTessuE7pGoxS/5U8V+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WebX6TyfbmGsteYfi9HNcMWyJxdiFi2bbhTKduWzrHtHaK1QSeD0DQr6pEI0eWitczwmnB3h/4Kxub3xxLuFm/Ag3AFZJvjAbosjoxydU6GIGbZNl3kFhNn6vz1Sl3Bvlzcif6ngqN6HKFagR8Kpv/m6wzPMTnxbG9vZeP7Fvks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b6N9SLQ1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ANbiun030684
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bFBd420UAE7CxBgVRf9/Ts
	qxiqblPzn7tE6jkz4N9SE=; b=b6N9SLQ1NW9erumHBiUHIT0XxytfKNaiotwZ3C
	Nx1niZraa3hNo5hryrX9qoQvHJEmhZm364fThroFjGE+12QxyJ7BSUg+GtJv7AXA
	XqsNivuQd/zW8pPia4UOZ8VgJcgyeBe7KfV+StxQO3S1qqtRdVMorGgI9n6WchX1
	T5fJb/PCR9MyWhocrl6LOe9sjo0ck7haaenPYVBvSvwefLqSwn+PYlOpb56sAhtj
	9Dlu9WMtMuOyXu4UYD2p/BWXX/Y4iIMV3FySZPtACXP14sJb1F1NuFT5KtQzwu2J
	36SilO+c+wE0o4JqjQNLCR21IcpVrPmJ7wsrVivtMTIsytNg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxq6u9pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:44:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24011c9da24so36750005ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754894642; x=1755499442;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFBd420UAE7CxBgVRf9/TsqxiqblPzn7tE6jkz4N9SE=;
        b=rkXpt20UNhoznoyAzjBKOqAvEnw019u0dMtR7634V3wDVIkAgAXL6EGQkG1805UD6I
         2GrRR4pgZ7YxEJ3flhgqG64w5rZAqcT63X+/76mc92GZ7YSFCwh/Q/7dg4YJBp4Ea55g
         yyxlaAM3PH+AZjaLVGs6fQ7rsk1vcm7+RpbhTZMX7luGPrEJp5GxswL+hOUocilkUG9V
         kFDoTLycC4ADJIdkVe4nrJa5IGIz3S9/brlmGbnUvnx0Japb98kOUPH+LmouCK6akWrm
         CIVe2yvXwTxAAVSJ0JcAwtByoBgqp/bOrhiBEgGP4k2zzK03UeUGiiGAQuXGjnlNm7hv
         gkxw==
X-Forwarded-Encrypted: i=1; AJvYcCV8LNP5VGkX2Qu5mfGyrst7g/C3If3rizKQcdndwLCRVzaRO+Th61d2vhM6a7UzkG7X1uw60AcQl40LW9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YypaqSnAitiFOzwn2BvY4t9QxIQulgTvUtVpG6ej1H8NFzyUuTP
	xOPDgwifVjIsClLxjZhPcWvBrlk3K7HCViDJLqNXitXTyb9gwq+f34D4WCMFsIY6qXcp6uFfTCo
	x+nZR7z1c13Cwhqrm34r9v8iWnk0zaYFmvU1KsRpQ4IQZiAOImH8M7aIs4w++02E+ecZao9Ijf1
	o=
X-Gm-Gg: ASbGnctU8o1g6ixCWQSQZOvC8sxIjnUjVuRKvvVqiAn+nNP/duXJ+jj9pUYz4WeE9A1
	cBu2s8g+r970fCy4u39UbhoQOGykZAspFInhoznCceIknkSqvgFY2gcyDhnNjPovMtC7yXGLNOE
	svIXcj8zw8nzsWPnPzx8kPCwIBWcqarqd+lkqSODgAioq7cezNRQfgtACN9NE7AFS+4RyDte8Bq
	UZ/zgevREvIMLjW8y0rEDTekQyKbXzAuxulf7UWNz7cVO5AsBonDHj+WIukazGn3qGT0Q6ljk+f
	OSeHiD2hD6wX9KnKaBImXGUdOREef4pEuR91ChQAixI=
X-Received: by 2002:a17:903:3c30:b0:240:86fa:a058 with SMTP id d9443c01a7336-242b060dd8amr256923725ad.7.1754894641923;
        Sun, 10 Aug 2025 23:44:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6lctQcOCf7in+SnIAmNq5lt8hSwjdCO8aLBQuwt02LQOpDXfrzrlYBrmu9dI8CIjvROvR7A==
X-Received: by 2002:a17:903:3c30:b0:240:86fa:a058 with SMTP id d9443c01a7336-242b060dd8amr256923415ad.7.1754894641405;
        Sun, 10 Aug 2025 23:44:01 -0700 (PDT)
Received: from hu-pbrahma-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89769fasm262632215ad.107.2025.08.10.23.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:44:00 -0700 (PDT)
From: pratyush.brahma@oss.qualcomm.com
X-Google-Original-From: Pratyush
Date: Mon, 11 Aug 2025 12:13:54 +0530
Subject: [PATCH v2] mm/numa_memblks: Use pr_debug instead of
 printk(KERN_DEBUG)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-numa-dbg-v2-1-7842aa2d4c41@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACmRmWgC/22MwQ7CIBAFf6XZszSwWoKe/A/TA4W1JZFSwRJNw
 7+LPXt5ybxMZoNE0VGCS7NBpOySC3MFPDRgJj2PxJytDMix44orNq9eMzuMTKJWA/Izmk5C1Zd
 Id/feU7e+8uTSK8TPXs7i9/6JZMEEQ2utICOPJ62vIaX2ueqHCd63daAvpXwBO8EE3KcAAAA=
X-Change-ID: 20250808-numa-dbg-62a8b2092c56
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754894638; l=1411;
 i=pratyush.brahma@oss.qualcomm.com; s=20250808; h=from:subject:message-id;
 bh=eXcNlthP7dcrojBLukgQ670kaZ2NUSxXkL5fjwqYTes=;
 b=AgrMEJScKwRgsp0tCJx0v1RMIG9QI8In2fp6iIwqQua7TPixOyY0KmdiW1txqhyoCJCfXi5Ut
 AmelaLjEqu8BEmgO0nsVDXf0y23iqo7B0bZGJk3Tk0E4xHLliOgS99c
X-Developer-Key: i=pratyush.brahma@oss.qualcomm.com; a=ed25519;
 pk=ZeXF1N8hxU6j3G/ajMI+du/TVXMZQaXDwnJyznB69ms=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyOCBTYWx0ZWRfX9C9KsE44o18P
 l4CTheNpx9nTDnpJYnQHb9BJoBuDCJSLke4iP6pSBpJQJcAqL13IshI2HMbrG8OqQPs1SR+LOIX
 1UKeWavd+IzNVoh0exyRuG3lbSt3B1ArgZ+Fs319qc0gx/TtBv1Y1YrxR+qDaiwWRi29wzTns6K
 kCA+6ulQUlrPBG1xbLBPnYXdEbzIvIPu4ZQqPC++6DNTMYIRXsCBOlRWNFcJuhX3P69TRZXR/OY
 tBgdiEItDGhN1PWRbUDe9+IfT7251wRuEpgVR0ib5EA51JTDzGu8MBlZ+IOt5UnGCAKI7fWdE2A
 uWxsNBHr9Y2WEx8LmnJHBdlUEepufgn3v+mo62WP5yn4MHKvK6Iy6rvv1Wr21QtYWSZi8qo72Xf
 9nrgOV2h
X-Authority-Analysis: v=2.4 cv=QYhmvtbv c=1 sm=1 tr=0 ts=68999133 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=IjtafaaC1MEc7PSuPL8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: s0ff5gtsflWIj_uxpk0Sfxl7ctTLqloV
X-Proofpoint-ORIG-GUID: s0ff5gtsflWIj_uxpk0Sfxl7ctTLqloV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_06,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508090028

From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>

Replace the direct usage of printk(KERN_DEBUG ...) with pr_debug(...) to
align with the consistent `pr_*` API usage within the file.

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
---
Changes in v2:
- Removed printk header as suggested by Joshua.
- Link to v1: https://lore.kernel.org/r/20250808-numa-dbg-v1-1-2ddd1ec634aa@oss.qualcomm.com
---
 mm/numa_memblks.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index 541a99c4071a67e5b0ef66f4136dee268a880003..ed6fcfca057ab4c9a8aa26cd1929551b4ded4a5b 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -2,7 +2,6 @@
 
 #include <linux/array_size.h>
 #include <linux/sort.h>
-#include <linux/printk.h>
 #include <linux/memblock.h>
 #include <linux/numa.h>
 #include <linux/numa_memblks.h>
@@ -76,7 +75,7 @@ static int __init numa_alloc_distance(void)
 		for (j = 0; j < cnt; j++)
 			numa_distance[i * cnt + j] = i == j ?
 				LOCAL_DISTANCE : REMOTE_DISTANCE;
-	printk(KERN_DEBUG "NUMA: Initialized distance table, cnt=%d\n", cnt);
+	pr_debug("NUMA: Initialized distance table, cnt=%d\n", cnt);
 
 	return 0;
 }

---
base-commit: 479058002c32b77acac43e883b92174e22c4be2d
change-id: 20250808-numa-dbg-62a8b2092c56

Best regards,
-- 
Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>


