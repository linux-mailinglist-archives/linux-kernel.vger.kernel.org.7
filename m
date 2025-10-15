Return-Path: <linux-kernel+bounces-854566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DEABDEB7E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED0419C47E6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC90246BD2;
	Wed, 15 Oct 2025 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="azpZgUyh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCC4225A3D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534298; cv=none; b=J+hhjxcI37znhGeQWgrfP9ZA7LHcaYA4N8oawo3VI4x2Gi+iHaA1URPZLt9DW/a2R1uoDNLIgUOgtibMMzcQosvCTyVIrlaPqZKSYIhdaddns3ixaBTOADm+HsbHAafhi9uwfMMzhZaVO0jjKvH3tsDY3Pn1FwHDW1oxf4CLgRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534298; c=relaxed/simple;
	bh=gw6jOBRXvp96kuxuVwkfEFK7rpHtMnm9kKwZNmCz2N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxbrOeuJ3ERjqUt8WksELAi5VSiS123RNGHPkWMZuvjhCJX2lHoSMeFdHJf8NV6zQPvbi5OHJuBbQkVH1aM/uy0WPm5dW2A14Zwi4+18ooPfCHMG7kB+Cr8jdsiCt9BxKeEMCVziOGv72pYVljQCSMq0IsQBXVCJly+3wOTiGXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=azpZgUyh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FBV0xs024770
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=C9C2sc2A6OP
	brM7m6MIVjYsiz10pmNe9evy2xuv6tEM=; b=azpZgUyhP+hcg5yBdlxmqdcyX3x
	ompOsmYcvwietzbHAu0Or419FspEZmUtfJFlV8XGPbj3FetpE4mLgVZKh0zB6wa3
	FtqOEtOnibt0R2Zw32NCD/P/rTXz8nEKwzVQkMkzpHr9KMGrPBgnZjcvNoXOltXq
	IiFlEGz6GOiRTI6ygSYeIZzTIYRNYCMD8+ncPN/m3g8/xnWO7GL0MjNfpbi1Ijf3
	/sxOkYzfAFv18ZO22zcfeygpw2FuYX/MoBAfXX8xwVsH+3+Y4s3vepMNL+wN7fE5
	sFYjDXpuOFghaJeNcfW25VB5qkqnaRAvhP7XV2E/n+w5G6SB5tFlFZtKI+g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0vfyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:15 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8645d397860so1595285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534294; x=1761139094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9C2sc2A6OPbrM7m6MIVjYsiz10pmNe9evy2xuv6tEM=;
        b=B/HtCVCuu3e0vH7JI+76K21GU3Y1nvAHpbKzMyqVaPtHISIVjE6cIKPSeUrzgJLSPL
         e8XqNbDva81MXkmDt1DS33a7nZFkoEuj7Z50JbEKUbavUhtk+fjtD2sdS04Ph8KNsDyp
         tpbKGM1tq5oJtbIXjoIIVLeVpF4qRKw4Mn1fwQ7bJ+7Zscgza+PkUP0wRP+SetF8Fv97
         qbLhIwRC33eKvMCmJsKK3/shXBq0Ah2a9lNJiT2WbxBi/60rD631GOn85rWlr0rZPe0q
         C/BImLq5/6gUfxnOdhBuob+t/WzeHMxPVPpOGG5yag9Y5PoXwVq+7iwHphGN16KHPlTX
         RSJw==
X-Forwarded-Encrypted: i=1; AJvYcCVHbI2o2DsiEmPBUX4MvZtHKDmB/fn4aoo95SfIOP6HqdzIGpKTAiaGGbGJo/cCIeN8WLIIXiurCUWuB/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMeBdmIyImL7r11XEwbR9Mu3pPUR05iYfHrgg4fZ6Q5c3K216t
	3yhKGdQwv1S24JZp21P6+ViJzpBU9Ly46oWAbKkE2tTaj7a/7RlXLLF55fyer9qNhpLzk8fjsdL
	RvdhfqnVefU5a7Dh7gRZvvOambwFiTdU8Tm98qSnZoeuwz8ZEMVMhkn7AqTyE8a7ajik=
X-Gm-Gg: ASbGnctIfQqh/rD1o/kU5QKGDt7+Q8tqMoM84nM9vrMm9cR+b9VJlGKlGXOxqGknctT
	LF6lVOa+F2EHvsrSkjtgqH1OiwnPYcCeMJzHdPM7w++XRdXHTtaLv1tm+GpXQvOtMZCci+3SdiC
	+dkFMS4xb+NEpboF9ylTqAT67jtNGb3y1xIRKrm5ePgupRgVONFQkToAniBbcBSoiTkH4TYnRW/
	NZNeQFS77rZYxT63rhCehm/AOgXdcAXYQdLKPr8Gm7EUU8RfrMgvT8n4s95vJKSO2RFNl1NGfu3
	+PszfCtnlo+lnTAOCkuNFkgZk4WF7x5mz5vdVVK2b1CJLesx8Lx2pQ==
X-Received: by 2002:a05:622a:18a9:b0:4e8:8c91:1d0b with SMTP id d75a77b69052e-4e88c9129c8mr11072211cf.61.1760534294202;
        Wed, 15 Oct 2025 06:18:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0CMlu9MhDFwvPcSu58T/hp5Z9HiQvZdCOtofLyrFvYZAEP6D+IxtDxCV4LRU3c7gZPSgu+g==
X-Received: by 2002:a05:622a:18a9:b0:4e8:8c91:1d0b with SMTP id d75a77b69052e-4e88c9129c8mr11071621cf.61.1760534293674;
        Wed, 15 Oct 2025 06:18:13 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc155143fsm262081245e9.11.2025.10.15.06.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:18:13 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, m.facchin@arduino.cc,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 7/9] ASoC: qcom: q6asm: add q6asm_get_hw_pointer
Date: Wed, 15 Oct 2025 14:17:37 +0100
Message-ID: <20251015131740.340258-8-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXyBw8mKqEI17I
 PnIQ03o9j5wBpY+dNJqoJpd3wqEyf1byn2SdXHfZuA2yIBLybDkFBkDD8YjgwKLEUVGx5I/xpY3
 YENszdrN4LwN/J4se8KHNA6z70lBosL75i9KOjprRmp7LY3bngwQo7aDuGEgO3svLU2KACLu/1h
 Ctg9QTmld8lC/YGZAaMayLjPeLNEbGnOcNzrT7l+WSRiX7FSTwqyFQcTgljGZpZm/o8zrSuugex
 6jnZzkFlBF4qrjYM28Nb9dc4jjPmMR9y7pyCY9xYdVmiNp4iaaLqqxeVREX7c9CwELnBE3JfNoV
 zYYBrGtQSIfK8BkIPX3z3oBbvGZE9RIL84AsrTO+w==
X-Proofpoint-GUID: f2EPjqsbLiXka6AoIrWimhru4H0njS-4
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68ef9f17 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=Xpi1c-eeJLz4SkQ0e-MA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: f2EPjqsbLiXka6AoIrWimhru4H0njS-4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Currently we are performing an extra layer of calculation on the hw_ptr,
which is always prone to errors.
Move this to common dsp layer for better accuracy.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6asm.c | 12 ++++++++++++
 sound/soc/qcom/qdsp6/q6asm.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 371389c8fa7a..643ca944b1b5 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -6,6 +6,7 @@
 #include <linux/mutex.h>
 #include <linux/wait.h>
 #include <linux/module.h>
+#include <linux/atomic.h>
 #include <linux/soc/qcom/apr.h>
 #include <linux/device.h>
 #include <linux/of_platform.h>
@@ -248,6 +249,7 @@ struct audio_port_data {
 	uint32_t num_periods;
 	uint32_t dsp_buf;
 	uint32_t mem_map_handle;
+	atomic_t hw_ptr;
 };
 
 struct q6asm {
@@ -598,6 +600,14 @@ static struct audio_client *q6asm_get_audio_client(struct q6asm *a,
 	return ac;
 }
 
+int q6asm_get_hw_pointer(struct audio_client *ac, unsigned int dir)
+{
+	struct audio_port_data *data = &ac->port[dir];
+
+	return (int)atomic_read(&data->hw_ptr);
+}
+EXPORT_SYMBOL_GPL(q6asm_get_hw_pointer);
+
 static int32_t q6asm_stream_callback(struct apr_device *adev,
 				     struct apr_resp_pkt *data,
 				     int session_id)
@@ -703,6 +713,7 @@ static int32_t q6asm_stream_callback(struct apr_device *adev,
 				goto done;
 			}
 			spin_unlock_irqrestore(&ac->lock, flags);
+			atomic_set(&port->hw_ptr, token + 1);
 		}
 		break;
 	case ASM_DATA_EVENT_READ_DONE_V2:
@@ -721,6 +732,7 @@ static int32_t q6asm_stream_callback(struct apr_device *adev,
 			}
 
 			phys = port->buf[hdr->token].phys;
+			atomic_set(&port->hw_ptr, hdr->token + 1);
 
 			if (upper_32_bits(phys) != done->buf_addr_msw ||
 			    lower_32_bits(phys) != done->buf_addr_lsw) {
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
index 519e1b3a3f7c..6fafda5bd849 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -148,4 +148,5 @@ int q6asm_map_memory_regions(unsigned int dir,
 			     phys_addr_t phys,
 			     size_t period_sz, unsigned int periods);
 int q6asm_unmap_memory_regions(unsigned int dir, struct audio_client *ac);
+int q6asm_get_hw_pointer(struct audio_client *ac, unsigned int dir);
 #endif /* __Q6_ASM_H__ */
-- 
2.51.0


