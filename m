Return-Path: <linux-kernel+bounces-722819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C44AFDF5C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 949FF7B38F5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A61F26B2D2;
	Wed,  9 Jul 2025 05:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p09eu+kQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3F826A0FD
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 05:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752039720; cv=none; b=gpQFdE3oS5X5XiYwAK6nTjxJByZeN67kF08PBKVLS5rqW3RFgyG61jA9b15BrYi6/O/ZX/P4tFzZ9DGerPMdz4g7nI43ayiWwSuCnQGS1/7rAl7pOIQ1pRd7hsk0FozEEczbS3kFBpZpdabSuNPgErMIEt+jMEkQLPzIYSofswM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752039720; c=relaxed/simple;
	bh=6Dn/G8ocYQZcqzia5brF+fTdgLlsfSj9YN12hK5WBqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JLnQN+SYU/LfPoPBS2xgT81dN28HwEfROYnB7D4JIYUyYe2UkSAVnRsKUsL8tqSy2OuWeUF7NyG6UK/eMpPbKrVK3xCouZF+Gr5wcOJJtmiQO4afUObjSW/UAoxgrLVNzd2cxp6rnMDNPaK7H+dkvZ6opvi5deO33pgP2kNB4nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p09eu+kQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568KJanr008265;
	Wed, 9 Jul 2025 05:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lyixqr9YqOYoL6jDScrpG3DBUKgTsjKzKNAVtIbReXc=; b=p09eu+kQEJ3S6jIl
	IxHcyx1PDDkl2DYab6YPYNGM6oithgxxLUUalFtypCnc8ET9Dwou7CWcs5nTnUFB
	H61yZ7BUST/MwTBQaLCI1tweeiEwNHzV8by/7cbMA2kc2KM/aGlfsZyfyslx54Eb
	P9Ug6JVC4+6tKPYvc60H10gp2jxrWO2cIK842VOFoStnjGD6XYT5fc7ELBXxqATA
	4sN/Pwn4T9ubJ53CgPxGm7H2GDCyxKobL0+UQR9gx9lRcV297WFfozoItU5gu2VF
	BB0kj/mNCzmsKayGbxK3noN2iPAqnqKIzn2lX6CaLb2BV+bN/wWJWUZTd5Chylmf
	Vn1ztQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucn388c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 05:41:53 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5695fq4t032141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Jul 2025 05:41:52 GMT
Received: from hu-achillar-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 8 Jul 2025 22:41:50 -0700
From: Aditya Chillara <quic_achillar@quicinc.com>
Date: Wed, 9 Jul 2025 11:11:10 +0530
Subject: [PATCH 2/2] tracing: Prevent double unregister of tracepoint
 probes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250709-fix-double-perf-probe-unregister-v1-2-2b588b3c0140@quicinc.com>
References: <20250709-fix-double-perf-probe-unregister-v1-0-2b588b3c0140@quicinc.com>
In-Reply-To: <20250709-fix-double-perf-probe-unregister-v1-0-2b588b3c0140@quicinc.com>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
CC: <linux-kernel@vger.kernel.org>,
        Aditya Chillara
	<quic_achillar@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752039707; l=1633;
 i=quic_achillar@quicinc.com; s=20250630; h=from:subject:message-id;
 bh=6Dn/G8ocYQZcqzia5brF+fTdgLlsfSj9YN12hK5WBqg=;
 b=9ds5guOGDxAqmP10+jy+ZqofJEbSs5zGIB3urry6KEuI+IarAessND6tgX+p9fBVr6S9TFZtH
 VyAchw40gelCd2H85oA/znrJx/JGXDe4C3d/+eRarT+V4kiFGkxQC7L
X-Developer-Key: i=quic_achillar@quicinc.com; a=ed25519;
 pk=n9YdZ9C822pphDmKHNwLKAFOJBiDCIOL/n1Mzy7/lg4=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=686e0121 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=hwwHtc20ys68fjZb6JEA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5OKcICdwKe7be5vaL3OkjtzsamfWvxdW
X-Proofpoint-ORIG-GUID: 5OKcICdwKe7be5vaL3OkjtzsamfWvxdW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA0OSBTYWx0ZWRfXxUvkfyBa+y5m
 C+Sxxo3zBnMImpxMGck4V4uwoF2AqZcA8cC+194RCVfj/gIHqENROCnQJO/iZB85CP48F9ytiU0
 aJiLdqkjvz0/64AIbV8YqtxbMeG9nZf//y/xEKcBuvu7ZRyVQ0lzZTLiMe3kNu8VsdsOuj2E8nl
 7qJx3CJmWSc3kwyYCC6Drvk8bTiHNe6f6cI17O4tfNt/xsm3nZj68FrOJwVX4zOKUKjh3jkCdgN
 O/+NpDCroOssexo9Vfu1tGVGNFPsskrENrkkktZSTbPNLLoCFQXIyV/RtEndLE7J9oHDzEVRRp5
 At8iM1F8hWjt8qaaUgaqVE7KuUikbcUKFMDk11MS4+hTJ2dEe5mRDXX6G48VMljML9pD0NFfjE6
 JdnXqEs0G5hZ1NRoqBJUJ29q3EP8LrCHB40MtyltjTfwVwGhYFTK+Xzt7ajnm2PK9ULsffy6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_01,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=696 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090049

Prevent tracepoint_probe_unregister from being executed multiple times
for the same probe, which can cause issues with perf due to the lack
of error handling.

Return an error if the probe is not present in the list of probes.

Signed-off-by: Aditya Chillara <quic_achillar@quicinc.com>
---
 kernel/tracepoint.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index ef42c1a1192053cc05b45ccb61358a4996453add..e6eee7e44a9d6f4f19114fbcf8fd9e5c85075324 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -232,7 +232,7 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
 static void *func_remove(struct tracepoint_func **funcs,
 		struct tracepoint_func *tp_func)
 {
-	int nr_probes = 0, nr_del = 0, i;
+	int nr_probes = 0, nr_del = 0, nr_tp_stub_del = 0, i;
 	struct tracepoint_func *old, *new;
 
 	old = *funcs;
@@ -246,11 +246,18 @@ static void *func_remove(struct tracepoint_func **funcs,
 		for (nr_probes = 0; old[nr_probes].func; nr_probes++) {
 			if ((old[nr_probes].func == tp_func->func &&
 			     old[nr_probes].data == tp_func->data) ||
-			    old[nr_probes].func == tp_stub_func)
+			    old[nr_probes].func == tp_stub_func) {
+				if (old[nr_probes].func == tp_stub_func)
+					nr_tp_stub_del++;
 				nr_del++;
+			}
 		}
 	}
 
+	/* If there is nothing to delete, do not allow */
+	if (nr_del - nr_tp_stub_del == 0)
+		return ERR_PTR(-ENOENT);
+
 	/*
 	 * If probe is NULL, then nr_probes = nr_del = 0, and then the
 	 * entire entry will be removed.

-- 
2.34.1


