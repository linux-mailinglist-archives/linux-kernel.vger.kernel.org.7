Return-Path: <linux-kernel+bounces-728159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D155B02403
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B631CC510C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCB02F3C13;
	Fri, 11 Jul 2025 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DFdzF1Fl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1FA2FC018
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259140; cv=none; b=m7ad59fU0EARq4hr/FiPJMjgNt4VQDNrnYMGdnHghe3ZRX0kTPN+IPE14yG1eQCDfzxqYaIH5gIqvqY7xTA8Mg2H+XchnJ9W4C/D2ATwj86k1BtgEaUFr1JpGsNSmy7FosjNlvmTr6M02OUKCPPGyO9KnIsXoWWg+G1oVtIOJ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259140; c=relaxed/simple;
	bh=oRcfnyZvrV2VkZH1U3gf55zJWHhtns3VEqkXw6uHOTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BOliFwhStlc5xbFy0D3GxE1stbWhGJZ5MclaiUbc597aWQmhNMrRE/n/Ehv6LXwXWYBCJKIATDBCE+sZDmHCHxKS6pXv06lgyDxLCtBZG1OKdVSaz+jOBup91ZQRUZCDgKn6lXSFlMUylKlBWEFshVV7XuHujwSGwQqNOHdvw/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DFdzF1Fl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAYatP018395;
	Fri, 11 Jul 2025 18:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hgGEbyKbUqvSoQQtfL6Dyz1Bh0Bad7htneSu8o6XWQY=; b=DFdzF1Flqqa6Jsb0
	acSKoe3i/MNlLQohjztEXmfJbB0CrB+AQMcNp6mYhyZl1IRMei1KZvx2I2yUbciT
	1dQAwQ2JZOd8zWbxe6R+uLNg2Pluln8EEeNWtxD4ssv81SZzfAClDT6ad+49cl4T
	2SkUURFkamJNwL+hvX6BxVEgfjjTEgWVVNcr8IZ2gK8xyMgBAfWnLsH3zFjcaAJi
	2gJaeMOqQo5pATaIDLH5MYLrzIE70x/ThXbS3HNs5mf53ZC0XnnCfl0JGjgorGUk
	/dvuJx2rfEdSZipfPTWMRYOU5A6aHt2yYOdgJaMpKrewAwSrUOCS1d7o3xUgzEyW
	13MV6Q==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47tkf33g19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 18:38:52 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56BIcqd7010984
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 18:38:52 GMT
Received: from hu-achillar-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 11 Jul 2025 11:38:50 -0700
From: Aditya Chillara <quic_achillar@quicinc.com>
Date: Sat, 12 Jul 2025 00:01:49 +0530
Subject: [PATCH v2 2/2] tracing: Prevent double unregister of tracepoint
 probes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250712-fix-double-perf-probe-unregister-v2-2-328b275672c5@quicinc.com>
References: <20250712-fix-double-perf-probe-unregister-v2-0-328b275672c5@quicinc.com>
In-Reply-To: <20250712-fix-double-perf-probe-unregister-v2-0-328b275672c5@quicinc.com>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: <linux-kernel@vger.kernel.org>,
        Aditya Chillara
	<quic_achillar@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752259126; l=1759;
 i=quic_achillar@quicinc.com; s=20250630; h=from:subject:message-id;
 bh=oRcfnyZvrV2VkZH1U3gf55zJWHhtns3VEqkXw6uHOTM=;
 b=lNt2qYRsrDzUJvJlPuvUyN5ovXbpDra78UPEP3bF7HBgsr6dWHwpHtK1cVg843uyGqAKATJt3
 8N3OKqpYcKJA9R0jOwqnFDeEa9B6fWzUPGf9Gu/DS4qlPSBrEe04Dht
X-Developer-Key: i=quic_achillar@quicinc.com; a=ed25519;
 pk=n9YdZ9C822pphDmKHNwLKAFOJBiDCIOL/n1Mzy7/lg4=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEzOCBTYWx0ZWRfXz2qUi3suyKL+
 vzzEh+kHqvOzMospGOs6ZsWNnHaQHEAvlwhwho825ixuHMGwqSKQUhVM/LTpsurfulpqP9iXGOG
 Erbwe1BMIwIG63/ZEwRJwtxXv+aLjXQe1Fn1K+Gpjv0dllp60kRlojJ9mvENZ58EpMnryV2oJrg
 lL91tJLh+aZ9b1OeWvWC8wVMfbaMyBwQiUl0/VaID9epdR5au/FRwxQf5+LFJLGKxUvG+rjxKN1
 vALL7+hMvp2oVZInDXZ1loiJGNqRa+PKB0VXmeR8N6dZGzqO4b1/bS3R7W6IZD5/gCiQ7cGJ+ez
 FJrT/2Wh/1ZSN1FW8nTk+D6iXjdGawMxG1ZLGVPeit1xy7FuytD3ArMem7q96ZsfjMmbYrwaNVA
 gunD7zBKKjcNWU6tFAe17LxL9n+VfBWT02cVxr0w6VGOY0hFKu82zJce5IOLI3EdzQ/ce0h2
X-Proofpoint-GUID: SPXTINe4Iw6N4Uub13QS5ucT0sV3Y_x5
X-Authority-Analysis: v=2.4 cv=Xuf6OUF9 c=1 sm=1 tr=0 ts=68715a3c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=12tNh57-wRayZMwsPSUA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: SPXTINe4Iw6N4Uub13QS5ucT0sV3Y_x5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=691 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110138

Prevent tracepoint_probe_unregister from being executed multiple times
for the same probe, which can cause issues with perf due to the lack
of error handling.

Return an error if the probe is not present in the list of probes.

Signed-off-by: Aditya Chillara <quic_achillar@quicinc.com>
---
 kernel/tracepoint.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index ef42c1a1192053cc05b45ccb61358a4996453add..6e7b6dd3bdd5eb0ae92b2fd43767e8da942f2c18 100644
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
@@ -244,13 +244,20 @@ static void *func_remove(struct tracepoint_func **funcs,
 	/* (N -> M), (N > 1, M >= 0) probes */
 	if (tp_func->func) {
 		for (nr_probes = 0; old[nr_probes].func; nr_probes++) {
-			if ((old[nr_probes].func == tp_func->func &&
-			     old[nr_probes].data == tp_func->data) ||
-			    old[nr_probes].func == tp_stub_func)
+			if (old[nr_probes].func == tp_func->func &&
+			    old[nr_probes].data == tp_func->data)
 				nr_del++;
+			else if (old[nr_probes].func == tp_stub_func)
+				nr_tp_stub_del++;
 		}
 	}
 
+	/* If there is nothing to delete, do not allow */
+	if (!nr_del)
+		return ERR_PTR(-ENOENT);
+
+	nr_del += nr_tp_stub_del;
+
 	/*
 	 * If probe is NULL, then nr_probes = nr_del = 0, and then the
 	 * entire entry will be removed.

-- 
2.34.1


