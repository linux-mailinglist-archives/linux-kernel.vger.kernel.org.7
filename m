Return-Path: <linux-kernel+bounces-759080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CA7B1D82D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 551207A59A6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D0E254B03;
	Thu,  7 Aug 2025 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L10Vzkzo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2C27DA6A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570729; cv=none; b=DTXKGZAOdVMli8UA+XrmASx9Aiifeb6/+9xHAkXDKd9/HeMdhEYFXfdhIcgbtWn45qlzupIZ292peqkUVRl5I+8Koe4Et12E6ZaMXaAHpSgnMT4SZoS0K/ezv8NswWmfD0wPW0kQfR/fDh9AjouB4H3VtZpFy6gMHDsbnnDq6YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570729; c=relaxed/simple;
	bh=Z8yoGArUYT9SNrHBSHLq3OP2pZRmhTNjDq6ZaFHBZSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kxnst+wnPYXByl8s1i26HAdotXcKri2qN39u9OrJ5FgxAixBE4EjocVwezQkJADxPWDhaypHa+fatOlCPZj2u1DmDrJ6lNyl3s9JeSMiWjDHq44wWEkUjDovBReMMo8XnPmqwAY/j8kcSfS9WDtLfK5K1gxFjQbYEu+47VWQ6uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L10Vzkzo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779DA4E025036
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 12:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=wrHOKVSICyQX9AnKwsmyhYUmWE9fXEnMJYQ
	W5r4UgOI=; b=L10Vzkzo/wSulMw99SebqPLntv1M8JgFaptK8y2bQUggSjG4xbr
	hdD7CcxJVKvaxijwCjIDA4XvzDzORjL9vQ6U3+olE5qhvTvHEZnSbx1YWmKZK8im
	fJKjCO6JklXEMuq1Gb6F+nypWGnGYAFNJrIz08yRF5RgEqtq3auly+3cB64tBaxn
	D0+FmJ0ffCorP8K4KxLCKnV0/4XGAe6zrX0890x7/kiQw7haRfsYIVNhRGaSg/N7
	nxO/DV6LGviQToxWSspQaGRtAE+uDU0ikzRQFgirN2lnAfRQwL+tOz8JPEh17zO/
	VtDx/iiOmb/Jk6J84bGguXkNPGzpECv806w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw1e8dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 12:45:26 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2400a932e59so13554705ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 05:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754570725; x=1755175525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wrHOKVSICyQX9AnKwsmyhYUmWE9fXEnMJYQW5r4UgOI=;
        b=WdLDastiLCKeX1sQuLfeJ3AdXTAaPkNfUs+4B2FOZ2v4H9jRPsEIQW7BU/K7U948WV
         0WYLdNmXEZSU4IjlcWjGKwn9R+bfRjwgaO6PVpLaEuISBbU1DPar2Ud0t37vbMfk2h7b
         /vXZcgBtUtpRXeaGEjQs/3HeH7HW8wR4aV2BsqcHBJ49JU4kV93NGaNCEpWNOLCXo2kG
         Jd/TTKoYcudCZLSbrU3lYS0EcY/V8SErVfYXkcy/navOELmeHmq5vp8QO72H578pWqio
         daSPSCk1hHPb1Ru9Fd0C6YI5dksC6ZgyF2w1f7Z1STcaiNOdkDbGBeAGAbBPTyVfv00Y
         x4ng==
X-Forwarded-Encrypted: i=1; AJvYcCXDVtYavTQoSBiPAF8S+8jJy/v4SySzCc4ZzBBCx13dmOu8PI5kw5m/v17CT63Ih3RLO0Qq64F7Jddbs0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgF74mmQ43i+hNAtfqZPE1Sl1zroe5MlVErqI7YMpxQG0cMlUd
	CByfqdJkmA1zriqKOYKqmJ4sG6WLCID3tbO8ODGd8PzSs+gvQmcodBkzNXebb5SVl1qVs7K4iBL
	4/P2iNrwG+1AOTyeda5r+qAIATXiiPHpE/RJ7JHx52GnblCqCFSEfuexHTABoUoFcV+w=
X-Gm-Gg: ASbGncssGnl69sg9dwJxl0CL2EfxW0j0IO01xS0AaZq9Y+vcZCfXV2a/CXOUfG8Q6VY
	48Wr0FMAWhXQqvSUVmJXUmR8ZC+WVtJpANRu642JAITVu/sIkjijQPO0IuuKc6ClMIdquTDperM
	+8u3dojtOCJpiQJJnXXLJ5st+WjatBbFSdFjrxAGezRzHHc5xPCOkZno5ek8Lf7byStulGt5gM0
	tPlVj6CJDQsyEfebXlKJnYljKI7SaAFJLxRlVaYZMbuKhn6lMdCgdH7geoolOLk5DkMlWNLwJpt
	ES6yjRqi+rP/d3rcLLtj4c6qM5No+qHDlx7VPfa9grx2/qj1OryEii/djvjG3CaYhKI=
X-Received: by 2002:a17:902:f552:b0:240:1441:1263 with SMTP id d9443c01a7336-2429f575d69mr95195475ad.50.1754570725400;
        Thu, 07 Aug 2025 05:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxQ1r8hY5P++ie8R3gvSD9SBl5jDxZUrFQJHSk2ZVhsSUgMYMrnz5fDl2TFO/OyalX7WPLiA==
X-Received: by 2002:a17:902:f552:b0:240:1441:1263 with SMTP id d9443c01a7336-2429f575d69mr95195055ad.50.1754570724921;
        Thu, 07 Aug 2025 05:45:24 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32160ae5eb5sm5526914a91.0.2025.08.07.05.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 05:45:24 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH] firmware: qcom: scm: preserve assign_mem() error return value
Date: Thu,  7 Aug 2025 18:14:51 +0530
Message-ID: <20250807124451.2623019-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX+c9tnXvdX/KX
 L+ac2krXGHijLoLSNzr6pjweU8Ys+D9N58jUVPr1WmxnmWswZNySBuWyzAfKR4D2mYyk1nXd9gX
 /8n7nNJ+osD1YZHVzgDwSLeKu855gR5mya5wR4YPBsN2nBMvIK5BmWi+6tC1tHKoqRYd7ZutJpd
 O4abFgQSEIQxo54Ny2meaQ6ZILX3KNHyazzWfXIQEuHFXRr6TJh5Zliped/Xt+cZJt53RSeEvKF
 DdHwDPSqbplmeUEHO/x+Lp7sGOKywaeleeEGecseIQO5OwwWn/Z1qWwfaHs5joocykyLAlz1Y82
 5E0SB0m+6nN98sBbXEcGmxs8WQvbvnxMcv8qdcPhqoMzPnqQsu2I+XpvJY4+Zlzfa/knmibyGXd
 WEAoFmP/
X-Authority-Analysis: v=2.4 cv=Ha4UTjE8 c=1 sm=1 tr=0 ts=68949fe6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=D9wtebwzRzpNM3HYBSsA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: u49wxORN9ssEk2sZfaIyTI0qB6qv6wFj
X-Proofpoint-GUID: u49wxORN9ssEk2sZfaIyTI0qB6qv6wFj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

When qcom_scm_assign_mem() fails, the error value is currently being
overwritten after it is logged, resulting in the loss of the original
error code. Fix this by retaining and returning the original error value
as intended.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 26cd0458aacd..5243d5abbbe9 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1119,7 +1119,7 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 	if (ret) {
 		dev_err(__scm->dev,
 			"Assign memory protection call failed %d\n", ret);
-		return -EINVAL;
+		return ret;
 	}
 
 	*srcvm = next_vm;
-- 
2.50.1


