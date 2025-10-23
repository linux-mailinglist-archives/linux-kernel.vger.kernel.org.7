Return-Path: <linux-kernel+bounces-866708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1751C007AA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0FC19C78A3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C0930E0EE;
	Thu, 23 Oct 2025 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AaKUTF3e"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D0730EF7D
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215180; cv=none; b=SA/VlA8Pz8AYoPF36nsQIRrfJtjAi/uXwgUWucr64AXyGUpAfawdfl+3Kah9wisRsUjJmLbwML25iNrtJLcbbLzNhFMA8J7L9RTgue7trbIIaFKuGV4lO/DgRRZadV8sGiPe8l2OWbbKcDGI/ZFtfHIQvj9DlI+YOHphd0+yS6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215180; c=relaxed/simple;
	bh=dLHz5GvCqsmxeiBqKMEL3HcMUOaRmWqxPH16ZJ+zr84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNa17NFLiC12i6dh+ROmddG2OD3U4pDhfc4SJcm2uK2Bq0BqoPP39WqSVkYVA5iA6VkDj1/5t67bYelvNCksIfK1qjf16pFGNe4lioOL99FrevRSRrDGrCk4TymSHUooDHFKphihdmIHGOPmFJk7WwkogvAANTq0LLMvRLJfP14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AaKUTF3e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N8T7lC027485
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JitUmPpOE5T
	5FCzl9njQ018JnbQNGz2uQiWhNK3tWOE=; b=AaKUTF3epbbr6yJaNDjUCsqzLAm
	11y2e6WNB8UIH0mVSKCRRFMKznv1p93IpJS6wXXwKqUnUNbxFlFOG2EQ/OlzxA4c
	9tIAcIsOrIHToT+i59sbKkEbCooFaW0LfPCDclQbIfHIeGNX2K9+C+8Bx966Lqer
	Bm+QfkfGcdrVKXOR3rkyydsG1QyIvGczahYTE2R6yZFeYe+A9810EV9c4oN9m0i0
	ZUr9qSxzY8Dt0kJaCJERKrUM2bdEejoAQl575l/B7Z4Hx5yiVVnchdx48joQRnKQ
	gfsM7PH8mUmztwLPd0Sa7ZJ58TZVJeE0fs+64smAJQBzQgXOgCDVMuuDbEw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y524a760-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:26:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8b73b2f90so22785651cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215176; x=1761819976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JitUmPpOE5T5FCzl9njQ018JnbQNGz2uQiWhNK3tWOE=;
        b=AqFl03QfqHECDiBQCJ9s50lctf7nrJOJxTvYY/3NH+DWsbaitZ9kUqt2KeLJFGfOdc
         5jYRk7tERcw+arMzuGRkMtmKzVF1Wa/2wLcwapu6otSKRA8reFZ7rG1Kjr0TgjzG+waF
         WXzSVE6KRnClZU/28BqHZt8iDjEjDRTw4s+IW3ANT5gX2m39TqAPDs0io/uhiLlcTV0p
         ER//BI+uEKE9KZgeiKqjQZ7GEb+HZ5wgLu5QQUpCajd0uLvD9NdHHqbsFmg9N4HXFj3v
         nMpf7uvzdiAnalh6b+0/fyW826RE+efgoOD7o4t0wPdQrkxYmvfjBf9qe3kPtRmHQuFP
         Um6A==
X-Forwarded-Encrypted: i=1; AJvYcCUTXKYun4vB1yvLNYCH36O40h797sd7qZSwogAYI3RbUJdlTlv0lto/qMR6bkigZrv84COieiUqZ9rPw4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVc2Uw6Zc+iThhZhkKWlzYht2Eae0jDJ00oZQlkRZdSyDTAzQ2
	6DndRAx3/LcbMTCTiG64v+rzH49R/Zf0dolEgARpVx5fQr6Jv/PdyDPmwIQTYVg4HAOEcBvqT4G
	vpin/XxxSQI63rWrmRjDLbiK65OeLIfgGtQ4YJYE70wlRBsxtmRVa9oJCTNTlb+FZMUg=
X-Gm-Gg: ASbGncu26krIUQ4vNft481DKxjlA6XxrXC65VrGDcPCrkq+Ug/Z0DcoyIeD9uEopAr/
	Auh3uJqcw7rmhEyElbm0mtSV645D8yW80MvLMXzYPsOEUAWlTtIuHwt89vFupXODFw/mAEWyJyv
	lwngWjLhJ9ZYV94SsfpjGF9ztkTlnvNlxV6erQtoPSNKaldS5PScRF5Hgb1SHdEBnhkzb0pTW9M
	XoN89wVnUqFzwj59sqI9ocLzu+PbUGQF714zc4F5vzoDRcnRVYfwZOtCsOSxA+tCsQTV3xlbnsA
	sTPtz5FohWHW2lzdATrljI1oSgqZ6BZi7D0YALfxTGkPv/RGKhsvoq66zwm48FXT5BTEIQ/GQpu
	jwdc4EtetTDBl
X-Received: by 2002:ac8:598b:0:b0:4e8:968d:b14a with SMTP id d75a77b69052e-4e89d28295amr268425321cf.22.1761215176210;
        Thu, 23 Oct 2025 03:26:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj7fkh7+VmeztYn4QdA68cJbOaNXQj+xi9BZBCSrDbEh6Oo9ctMku5VaXZ9TTwndXPdbnPQw==
X-Received: by 2002:ac8:598b:0:b0:4e8:968d:b14a with SMTP id d75a77b69052e-4e89d28295amr268425171cf.22.1761215175778;
        Thu, 23 Oct 2025 03:26:15 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm92220685e9.3.2025.10.23.03.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:26:15 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 17/20] ASoC: qcom: q6afe: Use guard() for spin locks
Date: Thu, 23 Oct 2025 11:24:41 +0100
Message-ID: <20251023102444.88158-18-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE1NSBTYWx0ZWRfX01EPZAT4cePe
 RL8H3BAD1CwPaSejOZIGwmctskat2tFUZm92FDvvuzTcHpUQKfSCS7086ra3Ro43btOv+OT97uQ
 dV8LhhY0k5tFSyKYpzF/K7Yak13uZ0xvG5FWM8v2ybUN3RpaxLLKsbwBEVd1XZfhxCSGDpTrmfp
 e/jvM0xqhJ5mPuXeHCJ9O0yftwlTwN8NSTAumUxXl2C2p4KFoUI4deiDjnBbwejv5CiXj6CnZDn
 WpeppIbNQ+6mEbSnaEXnB1DDj29B69W5V8YApb4cV16PF/QkKjLuK8kvnop2Fv9lSaax/acUk/J
 O3eEOxK/N/gvETlBLrmgLtRCWfkPdZ9CqX4K3B/BRHGjcXoq1nbm3CXCw1LmzsWGOkAsf1g+1Gd
 HR7snPqH8amRHNjerQa8XKufZX/umQ==
X-Authority-Analysis: v=2.4 cv=Uotu9uwB c=1 sm=1 tr=0 ts=68fa02c9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=RrrD4pAD4uqPltEmIwwA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: CDTjbr_dnoIDg7oHr4AIsmcNT-D02us5
X-Proofpoint-ORIG-GUID: CDTjbr_dnoIDg7oHr4AIsmcNT-D02us5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220155

Clean up the code using guard() for spin locks.

No functional changes, just cleanup.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6afe.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 56f85f1c2425..980851a12976 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -946,9 +946,8 @@ static struct q6afe_port *q6afe_find_port(struct q6afe *afe, int token)
 {
 	struct q6afe_port *p;
 	struct q6afe_port *ret = NULL;
-	unsigned long flags;
 
-	spin_lock_irqsave(&afe->port_list_lock, flags);
+	guard(spinlock)(&afe->port_list_lock);
 	list_for_each_entry(p, &afe->port_list, node)
 		if (p->token == token) {
 			ret = p;
@@ -956,7 +955,6 @@ static struct q6afe_port *q6afe_find_port(struct q6afe *afe, int token)
 			break;
 		}
 
-	spin_unlock_irqrestore(&afe->port_list_lock, flags);
 	return ret;
 }
 
@@ -1733,7 +1731,6 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
 	int port_id;
 	struct q6afe *afe = dev_get_drvdata(dev->parent);
 	struct q6afe_port *port;
-	unsigned long flags;
 	int cfg_type;
 
 	if (id < 0 || id >= AFE_PORT_MAX) {
@@ -1810,9 +1807,8 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
 	port->cfg_type = cfg_type;
 	kref_init(&port->refcount);
 
-	spin_lock_irqsave(&afe->port_list_lock, flags);
+	guard(spinlock)(&afe->port_list_lock);
 	list_add_tail(&port->node, &afe->port_list);
-	spin_unlock_irqrestore(&afe->port_list_lock, flags);
 
 	return port;
 
-- 
2.51.0


