Return-Path: <linux-kernel+bounces-766118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDCFB2427C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF09189875B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC002D8363;
	Wed, 13 Aug 2025 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Meg+jr0z"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9722BDC26
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069671; cv=none; b=BC6fxXyWGyqGF1vppd3B8wwCmeiK+EuH+f53TsdPfCtjMLtda0jyOvndfaxNJtwv5dpwTzXSFsHohwaXsTUDyyAo8/pxIDjzsXxjnygyT2Hn1+7qScRsGKP+EwBeWFeOpCmuJbmOm6srVdrLP/PeQzfWdB+cXyqjbGrb7Sscurs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069671; c=relaxed/simple;
	bh=flxveuv+IO94yZwhsUD4RndIg3noDoazvi4UpLM3UZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VHJZNfLDUXFPdv1pWQGfrdxOdnaXzQFPpwan1YsNhi6fcKb1ekFaJNWAA4Hdxw5sTjwq3EC80ZsF0rdgp2OuzyxiQsgnmZEZTKf+6+rU8OIhhkUkDB/o6nKZwm9yThVK6dFadZ8B2mFhtRYfIElLPI8nQPrVeijm3XF0O77HRz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Meg+jr0z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mOTV026071
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iMAgZiZKsY/zy72157yBbD
	BpwMbZReCDi6Q1sd5Rl64=; b=Meg+jr0zOlZJd1PsYoceJqHpAyYvrW7GI8w67h
	kRWQLGD/bVsqqQQjRK8bpBxFv71Q8tJY1QQ1GVXcnJpvINnvSs4LENxGn2tjXzro
	+Zi/yTRxMVGKfFmDA7uJdSS54pMUzrv340eHApNqQ0X2Tcm8qfc1AuTU8pzS/mXy
	Fj0irTUCy6Yi/iHb2i1OXlG6SElJwh9pNPSZhR80Jst16INGSFNKrRelFyWTVPQF
	SoovqgJUENIjSfaCXi075pgkM/bkQRsl1ghF6Yc8fF/Q9D2XU5KHg1q211n0qUgC
	oNaFXdepu6HmrcDbyJQLllWWhYA6uLYdRrEqwE52PYG4Ml5Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9su3c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:21:09 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76bc511e226so6229430b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755069668; x=1755674468;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMAgZiZKsY/zy72157yBbDBpwMbZReCDi6Q1sd5Rl64=;
        b=kiL/XO7k9ITW5SI5ozhufs63875R8886vFeo6bs0Y7ZMI2X4Pp1fqFtMbquM9TAU+U
         HiYvCBLMPRaY9qe6/m95nH4AmyDzV0EBVIfkMH+xopImqrEFY8+Vo1n7JfQaxvZ/IEY6
         cY5LorX8VEdoeD+IcdYqXp7SqoR5RoIgRwOUKfHsoAGw2NqOox1yfydo+F0c+YbSXqzQ
         rNoYxdKy+BcaTabc81LtMqAXZUp9kXWlgXU0IHWhuF8bZrcky5ho1tsjJJpYJlNckM+Y
         FkceDTsSUVlt8FsBBBzDcwdJ+cPZWk4MOzeiObTNnn+VHm4L6FRw0qgErbiq1xB3XQZW
         0r3w==
X-Forwarded-Encrypted: i=1; AJvYcCUopz2NDkzBo/gXtj1ZJliJfer846/lu5Q8S/gtQ3Gl+XxaLgT1TKIO2Ab0Ypwwtbt2HScLYjq2s+q0NSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrs27mCcyd3rHF1O0GUpoQqV7vRmriRoQgHZO90ODdMTw97mSP
	wmhxz81JkqsFY1FO+2uYzqDpVxsFWMOBnPYsW8/x3LrUlEve9GiZ5m9vFfQzCkTUGsQGeJ4Tw3M
	reQe29lEg+AQ8+QG+jLoj+YbaV3QfrtliN9BO6cJQeIAWN2GfbGeJ4dUuuVvGum5IG/I=
X-Gm-Gg: ASbGncuXVbUOrqYjXMenIeHNDLjQwErFnMYHuTVH2F3IUpdnbi1oisGjm4DLW+fwr8f
	8DCBvjuIzkoh79Gw39TMtYK64nNZPrLtboTOnf1m/qmsDWbZ4gggmflnDca683qenQFl3vhHtaX
	9gJExSYoaMRSra25LkGIXAayWCxI3yENU3xmo+pvGpJI+9fT9EjeGYewKHH05SsHn8XPhmq64G4
	z4tS+aRa1Q413OF0fnzfJ1uYSPHZadWnqHV41+OhidhHRiifYHO+DLfzSbt6+flM43KeqQ/Jdwb
	BBw1ixQzza3Ff3JqFgLrmV+x9aHzZK75DKltbh6DutU=
X-Received: by 2002:a05:6a00:39a7:b0:748:323f:ba21 with SMTP id d2e1a72fcca58-76e20cf0539mr2582931b3a.1.1755069668273;
        Wed, 13 Aug 2025 00:21:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTenQZeafqeK17bULskWp3Z66K1603GFcLmEsh80xkPSD7Bq2lIA9XY9Uil+7M2UMNpagcWw==
X-Received: by 2002:a05:6a00:39a7:b0:748:323f:ba21 with SMTP id d2e1a72fcca58-76e20cf0539mr2582899b3a.1.1755069667835;
        Wed, 13 Aug 2025 00:21:07 -0700 (PDT)
Received: from hu-pbrahma-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f9dfsm31235397b3a.53.2025.08.13.00.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 00:21:07 -0700 (PDT)
From: pratyush.brahma@oss.qualcomm.com
X-Google-Original-From: Pratyush
Date: Wed, 13 Aug 2025 12:51:02 +0530
Subject: [PATCH v3] mm/numa_memblks: Use pr_debug instead of
 printk(KERN_DEBUG)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-numa-dbg-v3-1-1dcd1234fcc5@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAN08nGgC/22MQQ6CMBBFr2K6tqQzFKyuvIdxMbQVmgjVVhoN4
 e4WVizYTPIm/72JRRucjexymFiwyUXnhwzl8cB0R0NruTOZGQqshBKKD2NP3DQtr5FUg+KMuqp
 Znr+CfbjvmrrdM3cufnz4reUEy3cnkoADR2MMWF2XkujqYyzeIz217/siH7a0Em58gI2P2T8pi
 URopJaw48/z/AfsNgY05wAAAA==
X-Change-ID: 20250808-numa-dbg-62a8b2092c56
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755069665; l=1381;
 i=pratyush.brahma@oss.qualcomm.com; s=20250808; h=from:subject:message-id;
 bh=c+IKTEzal9kBPA/ADB7y64RVy4hw6SkL+5vIBoo8vsM=;
 b=Phvdx1UAs1Q1EEyp3PktJ9j7+rY+4rgWV+6bOSVScD+G6jDpwhSXQxuudoIEAal3FIZhpAUDX
 0LRg3sU0uapBZyk/PjwEmup3UPRp/7BIor0s6aq8NP7/2oI7Fly2gYE
X-Developer-Key: i=pratyush.brahma@oss.qualcomm.com; a=ed25519;
 pk=ZeXF1N8hxU6j3G/ajMI+du/TVXMZQaXDwnJyznB69ms=
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689c3ce5 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=IjtafaaC1MEc7PSuPL8A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: eiTPFOIz3LL99NbavZ6Cf-COMCj80X2R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfXz1NMOVNA7Dtu
 G4Z3gkFxgD5otRSnSsXCeXs6z0fmGTwobPjk9HxaNrc0afNv/bug1Qe5iGG86JqnZIP6J4ONoIx
 d42U7g4l+aWgDJL0wRl5HzPyc8vyZVqGvdPSyk9YC88xO7UTN9pRl+5OkunnRrrPwWcDggD048x
 Oq+hcvi53pz2tDwi5sqPrTYZMJ582iZlGQeXtf96lxkHYgNZiFIU4EktWDumhj+Lx02Hcg5sEv/
 xRUYnt/vUY6xF94W5ZpzAQ6LGzI3KkqBW2lKSprOHhUCmDCkT69d/fnQcoPAYYnAIdSOD2XdGqG
 zfem2lE0sKDIOXGXJlceA/h5Fv2IiG7iXiZIj8Nzwf55r7qfc1TuAPU4jp1rW+ejo6SIu6bOnfs
 lwjd+kcQ
X-Proofpoint-GUID: eiTPFOIz3LL99NbavZ6Cf-COMCj80X2R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015

From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>

Replace the direct usage of printk(KERN_DEBUG ...) with pr_debug(...) to
align with the consistent `pr_*` API usage within the file.

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
---
Changes in v3:
- Restored printk header as per initial implementation
- Link to v2: https://lore.kernel.org/r/20250811-numa-dbg-v2-1-7842aa2d4c41@oss.qualcomm.com

Changes in v2:
- Removed printk header as suggested by Joshua.
- Link to v1: https://lore.kernel.org/r/20250808-numa-dbg-v1-1-2ddd1ec634aa@oss.qualcomm.com
---
 mm/numa_memblks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index 541a99c4071a67e5b0ef66f4136dee268a880003..de626525a87c3ed54d31695e86f18c980c084558 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -76,7 +76,7 @@ static int __init numa_alloc_distance(void)
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


