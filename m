Return-Path: <linux-kernel+bounces-866706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8C1C007B3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 176314FD551
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5240630EF7A;
	Thu, 23 Oct 2025 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lDo5gsmq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F3230E0DF
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215177; cv=none; b=FgBdY8JzwFXBPvdZW4UDrLxCwJPo0r4/18tfOkYSV/hsSr6s96nQ1Ksitb8rstJ97gAMATSRhO1da7fY+lZjPQU/eZgOkeEIrLo++3s0ZOfZIfozddhxWFg+iYPxw+I3lKThxnDTjLRszG9WzJGgI5jBah9VXenAmnwS7B1/V6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215177; c=relaxed/simple;
	bh=DqFc1lEyNlYSTnRSRWLFqbyGVZBJ7IJEhAOyAV3lF1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mT3UTc/BtD3f9zwR8RIxbmsNzXkOexYafJGXbxyjiLlRSbDvhasVuhs2YEsCElWwuSx2E9CjbVODTH0Z6in50FDC549CytJzsQaZJiARYXKa7Ark7Moc9Zxfi7EMx1YWP4QaZYuuNz6kiz6wdatsLu7lFlzLdALyhyW1ZWxur9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lDo5gsmq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6sw1w007476
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1mabdmqX3eI
	X6g/fR4x0Rd7F3iIr79oESHYJTHYzAW4=; b=lDo5gsmqju6fplgcndLZxJE8T+d
	f3/hr0AHVs5i7IjMExNfUOWaBdjo69LLl3P3JV7SlYr8IcEx6vA91dQai/MZeSJo
	RGOPW7+8ge+1enQIg3a/PdkqlryFG7q4y+QUOcLJa51t+NA16XNgfcfC+LVTlkVO
	2+Ep5A2k1BvaoNLNTnxKIiRgKcj2jUs9vRn047OEcfCAhCzcdy+ULLgIqhFyRSoH
	KBp7BLgzizT60Qye3cpG2DA+ArP0zJoqAMl6/wsF3SBac6Xw4iVpA9ICBnmtPNLd
	wY55hLV2HzBazBInCP+Eo3uPyYhMxNh+Aeo2XnESJhA1IiJ/o/hR3FqdKUA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v34483a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e892f776d0so33571171cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215173; x=1761819973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mabdmqX3eIX6g/fR4x0Rd7F3iIr79oESHYJTHYzAW4=;
        b=K6rF+ypplgYZgmtlPY2Q1zTiQ00ERhOnsBVg2zm/hqPYTm8lSko8JfnBuqpd51E0Sy
         t6w7egpf2fywlLD0Buq2cKSdv2kZ3Mg046+u1hMPW8rRc1+tQN6gN8Cs3ne7Snb6oVHx
         F9qnUo3IoZfJ3NjqhSoohMjgL4I29cgc/v4u7flv1/YpVQqHJpxtxeOOLvKiRTaro9Uv
         N6EGuy54KGqWpMOl3rkr2XAm7gPQWPJbRvHP2W87Aj26wE89de9ybJ3eP53eRKWWmpDK
         X1j7L3FQkw7hxjRRDbTE6R02m606rHgBKRwTu+8JHGps3ZZIQRCL4+SwtdBGbZfjg+wa
         wtZA==
X-Forwarded-Encrypted: i=1; AJvYcCXDmtDHV6gGoq3wqEitohjRHqhkM9Rf+4JjpkS+vTV+izHtmHUZrmeUg4Se+lYr23Ol8q+62EiDDuaURac=@vger.kernel.org
X-Gm-Message-State: AOJu0YykLXho/wanaHbIgKV/Fo5gA7l82Wp7mnG2/4JLJYQLNsjYKvLc
	lsHlXkpkag5inaX1O9xwrrAlUJR1cgLq5NkRVpXDMWPeRvkWTgjc3tzNKE3NPWJqWnla3LqtWgi
	8X+3RGVHzwE0+MX+ty7XQxh2ds8UfrU+oleCXJnE4t9IcjlTSiUK1QdKTITspce9Rpzo=
X-Gm-Gg: ASbGncvpYtB1C5Qk/K6Sm9i31bBp3iuFxgkcN3OIsGn/xmBT4jHZ09pkCKw2rZmD61X
	l+cegESgnhIEpL49kSPSjMNvrRrVWNAjjRIiCVkWf6+BJ23Zpb3/XiwwrZ+ka3f3Q2md9+xmvwm
	SV7ppz2NV61SzLQCB4FIbdHNQtlyaknP3RYZhuWZBKMXVLWx7ZTIBOSWvJFdM7mMbaBCmmiNYRW
	KS2L3N0jc8TO/IQHbQVVjiXLNe5Oa6n/QMDfIZj4Nleb4yHWO1/5zq+PKc7QPJzldrdbutX+nI8
	qMDUG46b48GjMCGhL3b2g8Qw/1zj1N/8LCcJDhDM6s7bW9eD0xiKMSAEhJY3m5GTg4bJWPVxdKv
	m0TOGQgd9/GSn
X-Received: by 2002:a05:622a:8346:b0:4e8:9dab:2737 with SMTP id d75a77b69052e-4e89dab27cemr239049241cf.56.1761215172881;
        Thu, 23 Oct 2025 03:26:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1r2cQ1Xs6iSILRFVoCL4m3+fRdthOPcOcxyZZCeCH/t6SKBhUh9GZCJ5uRTz69qelDUFttg==
X-Received: by 2002:a05:622a:8346:b0:4e8:9dab:2737 with SMTP id d75a77b69052e-4e89dab27cemr239049071cf.56.1761215172400;
        Thu, 23 Oct 2025 03:26:12 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm92220685e9.3.2025.10.23.03.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:26:11 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 14/20] ASoc: qcom: q6apm: Use automatic cleanup of kfree()
Date: Thu, 23 Oct 2025 11:24:38 +0100
Message-ID: <20251023102444.88158-15-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023102444.88158-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251023102444.88158-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KVUOpXjU_0KEr6VzkvfhSyj51OHzM6do
X-Proofpoint-ORIG-GUID: KVUOpXjU_0KEr6VzkvfhSyj51OHzM6do
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX4NMjlsxkIEH+
 ywIKqHloKIKZZYkyaRcwgzoc4giiu+m3MVqzJtpTZ/dopTPP6BrYf/aurz0MxcvCTUr2SyHa67O
 54oMhem7KaqUxniuqZLl2uk2rQgj5k4eUPVJeijGeHpMsA43JHwsZLsjqj2V658AuwwYYDrsC9+
 wEE+FXieM3dRAEKLeqK0W8xcQbVrXZ0tJ7e9nNivZPgo97IeSBovPPcb55xxKXAnBj2vOXoflPE
 SxDfzw98wvve0WtKbam+ZAzJTVvRCu/J2nvnyJxDxg6zaSNnK5n7prWDaKlz1EOmfq/ylxW7HVM
 VG39lFsSpiG0VwaSTsk9flx7fKTaOyTYcLcRewRbCqhkXVF7IyUXucSH6t8WE3XxuGNiIe7BJxm
 bNRrriNnkCEsQffXTcQu0Ipj7KGQxQ==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68fa02c6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=ORCg8BdZNXsK9r0PxOcA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

Its common pattern in q6dsp code to allocate temporary buffer
to send gpr/apr packets and free at the function exit.
Now this can be simplified via __free(kfree) mechanism.

No functional changes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6apm.c | 57 +++++++++++-------------------------
 1 file changed, 17 insertions(+), 40 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 0e667a7eb546..94cc6376a367 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -99,12 +99,8 @@ static int audioreach_graph_mgmt_cmd(struct audioreach_graph *graph, uint32_t op
 	struct apm_graph_mgmt_cmd *mgmt_cmd;
 	struct audioreach_sub_graph *sg;
 	struct q6apm *apm = graph->apm;
-	int i = 0, rc, payload_size;
-	struct gpr_pkt *pkt;
-
-	payload_size = APM_GRAPH_MGMT_PSIZE(mgmt_cmd, num_sub_graphs);
-
-	pkt = audioreach_alloc_apm_cmd_pkt(payload_size, opcode, 0);
+	int i = 0, payload_size = APM_GRAPH_MGMT_PSIZE(mgmt_cmd, num_sub_graphs);
+	struct gpr_pkt *pkt __free(kfree) = audioreach_alloc_apm_cmd_pkt(payload_size, opcode, 0);
 	if (IS_ERR(pkt))
 		return PTR_ERR(pkt);
 
@@ -120,11 +116,7 @@ static int audioreach_graph_mgmt_cmd(struct audioreach_graph *graph, uint32_t op
 	list_for_each_entry(sg, &info->sg_list, node)
 		mgmt_cmd->sub_graph_id_list[i++] = sg->sub_graph_id;
 
-	rc = q6apm_send_cmd_sync(apm, pkt, 0);
-
-	kfree(pkt);
-
-	return rc;
+	return q6apm_send_cmd_sync(apm, pkt, 0);
 }
 
 static void q6apm_put_audioreach_graph(struct kref *ref)
@@ -148,16 +140,13 @@ static void q6apm_put_audioreach_graph(struct kref *ref)
 
 static int q6apm_get_apm_state(struct q6apm *apm)
 {
-	struct gpr_pkt *pkt;
-
-	pkt = audioreach_alloc_apm_cmd_pkt(0, APM_CMD_GET_SPF_STATE, 0);
+	struct gpr_pkt *pkt __free(kfree) = audioreach_alloc_apm_cmd_pkt(0,
+								APM_CMD_GET_SPF_STATE, 0);
 	if (IS_ERR(pkt))
 		return PTR_ERR(pkt);
 
 	q6apm_send_cmd_sync(apm, pkt, APM_CMD_RSP_GET_SPF_STATE);
 
-	kfree(pkt);
-
 	return apm->state;
 }
 
@@ -270,7 +259,7 @@ int q6apm_unmap_memory_regions(struct q6apm_graph *graph, unsigned int dir)
 {
 	struct apm_cmd_shared_mem_unmap_regions *cmd;
 	struct audioreach_graph_data *data;
-	struct gpr_pkt *pkt;
+	struct gpr_pkt *pkt __free(kfree) = NULL;
 	int rc;
 
 	if (dir == SNDRV_PCM_STREAM_PLAYBACK)
@@ -290,7 +279,6 @@ int q6apm_unmap_memory_regions(struct q6apm_graph *graph, unsigned int dir)
 	cmd->mem_map_handle = data->mem_map_handle;
 
 	rc = audioreach_graph_send_cmd_sync(graph, pkt, APM_CMD_SHARED_MEM_UNMAP_REGIONS);
-	kfree(pkt);
 
 	audioreach_graph_free_buf(graph);
 
@@ -420,13 +408,11 @@ int q6apm_write_async(struct q6apm_graph *graph, uint32_t len, uint32_t msw_ts,
 {
 	struct apm_data_cmd_wr_sh_mem_ep_data_buffer_v2 *write_buffer;
 	struct audio_buffer *ab;
-	struct gpr_pkt *pkt;
-	int rc, iid;
-
-	iid = q6apm_graph_get_rx_shmem_module_iid(graph);
-	pkt = audioreach_alloc_pkt(sizeof(*write_buffer), DATA_CMD_WR_SH_MEM_EP_DATA_BUFFER_V2,
-				   graph->rx_data.dsp_buf | (len << APM_WRITE_TOKEN_LEN_SHIFT),
-				   graph->port->id, iid);
+	int iid = q6apm_graph_get_rx_shmem_module_iid(graph);
+	struct gpr_pkt *pkt __free(kfree) = audioreach_alloc_pkt(sizeof(*write_buffer),
+					DATA_CMD_WR_SH_MEM_EP_DATA_BUFFER_V2,
+					graph->rx_data.dsp_buf | (len << APM_WRITE_TOKEN_LEN_SHIFT),
+					graph->port->id, iid);
 	if (IS_ERR(pkt))
 		return PTR_ERR(pkt);
 
@@ -450,11 +436,7 @@ int q6apm_write_async(struct q6apm_graph *graph, uint32_t len, uint32_t msw_ts,
 
 	mutex_unlock(&graph->lock);
 
-	rc = gpr_send_port_pkt(graph->port, pkt);
-
-	kfree(pkt);
-
-	return rc;
+	return gpr_send_port_pkt(graph->port, pkt);
 }
 EXPORT_SYMBOL_GPL(q6apm_write_async);
 
@@ -463,12 +445,10 @@ int q6apm_read(struct q6apm_graph *graph)
 	struct data_cmd_rd_sh_mem_ep_data_buffer_v2 *read_buffer;
 	struct audioreach_graph_data *port;
 	struct audio_buffer *ab;
-	struct gpr_pkt *pkt;
-	int rc, iid;
-
-	iid = q6apm_graph_get_tx_shmem_module_iid(graph);
-	pkt = audioreach_alloc_pkt(sizeof(*read_buffer), DATA_CMD_RD_SH_MEM_EP_DATA_BUFFER_V2,
-				   graph->tx_data.dsp_buf, graph->port->id, iid);
+	int iid = q6apm_graph_get_tx_shmem_module_iid(graph);
+	struct gpr_pkt *pkt __free(kfree) = audioreach_alloc_pkt(sizeof(*read_buffer),
+					DATA_CMD_RD_SH_MEM_EP_DATA_BUFFER_V2,
+					graph->tx_data.dsp_buf, graph->port->id, iid);
 	if (IS_ERR(pkt))
 		return PTR_ERR(pkt);
 
@@ -490,10 +470,7 @@ int q6apm_read(struct q6apm_graph *graph)
 
 	mutex_unlock(&graph->lock);
 
-	rc = gpr_send_port_pkt(graph->port, pkt);
-	kfree(pkt);
-
-	return rc;
+	return gpr_send_port_pkt(graph->port, pkt);
 }
 EXPORT_SYMBOL_GPL(q6apm_read);
 
-- 
2.51.0


