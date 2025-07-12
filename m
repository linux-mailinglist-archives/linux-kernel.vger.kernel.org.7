Return-Path: <linux-kernel+bounces-728470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 933C8B028AF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFEA0A605C3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DBF1E520D;
	Sat, 12 Jul 2025 00:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dY6KEZ6Y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77251D5161
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281922; cv=none; b=W6CotrOm0PY+Gn+z/L0YUrGQSnONW+r2b0u4f3avMo5wH+g1h/RLRWW+LXbyEo9CiyBhzAAdR0bKJsFV4kZPAKYL1Ru38uvJGJXc1c5HSu3FwrU8HEJ2KWo8Wu0j5npMTfWkymfDClpsP+zH3ea0HL+S12AP8IHRK6WXp42W1O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281922; c=relaxed/simple;
	bh=PV2gItPOtD2ro/W717vvW5Rzvp3X4mFntv6qSdc7eTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UnW1nitMC4IFJ6t8POEuH4cJ1GXBbuZVmJFyFUm1CY2fx8Do9LptGrZsl2MFTmYoQ2Ab9PumKTYBbRIcM8DwKdEzAJL2RDXVo35k4pdLzBjPZUTri8b93PkbUeCa9VflYfbux3tJQFzT72xOCGfBvRAb1HQjjtbhHPEd0EqLhfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dY6KEZ6Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56C0n6Yn013269
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kFsYkMbbCPAVSW7u1O54kFwQDkZ7UfY3rOuddf3un7w=; b=dY6KEZ6Yyok8JzlS
	MXMes3w4hOlFs5R5zvCfENItM9LnmWWI9vCf1v7XTcuhLV9ZqMozI0xMoI+tYWsi
	Qj8n77spMD8wQ9rDmbLIDp3QFg1PInx20KX0JGBh9nV3Z/r8zf54syIMr+RCNLXJ
	DBr/LH3044abTyvCQWhbn4Mlnvqs6QyNmFvLA29mvAPAU59V7g/+UOc7ufnDZzq6
	q0L8Es/4x3mpWDabV4JR6OW89uL1PEwzJ+0GV99FqPTS1/DrTz+tDSLLijR5uCma
	Im8ZECshZRj3J5AV2xh79u7kX3gGFgoQJ4ouesZiaPR2Os254zLiKJElxymJtso5
	yQUyMw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47tkf345xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:40 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-315af08594fso2888357a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281919; x=1752886719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFsYkMbbCPAVSW7u1O54kFwQDkZ7UfY3rOuddf3un7w=;
        b=p/2Hq3SXFhsXyw2ZFUTMzt2/xFcp/4TIZyVCBgM6lRnxTeepsbc/GJtvButeBt9aFE
         MvoR0NBALvPDFSoyViPyI4cI9BKuAX3DnWd4wbOl5ngsdgYX7UtpBTiVd8lyErCYjIt/
         7KxEXIHZmtTdSVSUZ0sGvA0dhGfYNaJmIZ9yvWKnwoRp66jlgZepDLnCLYp6CbWgfGwK
         MjKHSj8EshDJBAuLkb1iMnhTu4sqWKXqeEt4TIx+tbgIlfBysusZXrO/qfLXXZ9jZiUy
         WltMixyYYpmqty15xBxhgK1TgpRtffeJcfcRnYQAasghtonuW00AnsRyTWeBN4lZ/ljz
         vrLg==
X-Forwarded-Encrypted: i=1; AJvYcCWVZmuhocTQ4Ft2atgRpmc9Sn/PffJ+CM8JU0S0GMVlMKTt6r/S6Z+oQw1YVNXHVPQpvIgUFUpRVnR8+5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxemlK1vBrJLD7+lxmIyJJBNvtK6G9qnUwaD610aXlRX1YxTKpI
	1YmTtkItXEGGylknJRofdSDwV78k97JuD0H3eWBs5MtJbz5wDu7lrEn3+Vcd+0QRB0+G3ZFhpuR
	dyG7FUWgfL+7dcpxCmS2Y0MfLk+HYLyPkhuZPq16TEA3G2G83jvEIUluCtUATAXeikmg=
X-Gm-Gg: ASbGncu6kiLxbpiAEnlWKiHsmAkmqsRFCQyn5/Tjd+i6RwpvDt1TLtrILXnKeSMBxER
	UnyK4DFweeA3UOfmZYSmSTOqybtXhJ2LEJljxWxXr99MzycwrDLumaqyU/nXHgy4uXY3R2WA2XK
	TzcV1QCew/8WLqldYvlZgjEAFRXmuL0+fsyKPWr/bhxTUOJ45Ac9ljiQu6+3QVcOSCl4ts2syAp
	MxroY3KMNhVWp43xLpgi4+/2V2ik0C5mM+nGsvvIiTipboBnHX7pJ6RskFZs/3E2ISzJPm99OSv
	s/3p2ru5GzsodglV+cTCRD9tLv2lDIXbHKIglAuQj54W28Rqe1EMsNaoeigulYZBS1f3c7gfTST
	/EeN0KcC9QC78Qd2pz0n3wC/Z
X-Received: by 2002:a17:90a:da86:b0:313:f6fa:5bb5 with SMTP id 98e67ed59e1d1-31c4f512810mr7999172a91.18.1752281919140;
        Fri, 11 Jul 2025 17:58:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG02TDuoELfDpFVSQMxOzUgTbAOCMzQhtQ1BzktPdQH5UUzku4oC5I1fmsVdQV81JzCvjjFiA==
X-Received: by 2002:a17:90a:da86:b0:313:f6fa:5bb5 with SMTP id 98e67ed59e1d1-31c4f512810mr7999134a91.18.1752281918722;
        Fri, 11 Jul 2025 17:58:38 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c23006d72sm5202274a91.1.2025.07.11.17.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 17:58:38 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 17:58:13 -0700
Subject: [PATCH 08/19] drm/msm/dp: Don't delay plug-in handling when
 ST_DISCONNECT_PENDING
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-hpd-refactor-v1-8-33cbac823f34@oss.qualcomm.com>
References: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
In-Reply-To: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752281905; l=1204;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=PV2gItPOtD2ro/W717vvW5Rzvp3X4mFntv6qSdc7eTA=;
 b=VML5o3LiZxvvLZFWgUSkZY0+K/ladfTLPXoxspXXguFKL4U2pE48BScPgV8l7YOhWVCer66r0
 /K5AxoiYvXuARwR5PkxRx2hKkxakVMScUQFz5NnmG6IJjQoT3UJZfKl
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDAwNSBTYWx0ZWRfX/0YpLDzAuSOa
 65yxvVEf0BfzMgSpSQP2/Nril4glazLzJRSqtgYDFvTOtWXeG4fkXY0yNEF0V/VdqUFLG1YthUN
 nr2QcNC3H3oOJzvcEqq7uJpJMJP5+NThT58FGNhpWpdOw58PP/bIplN6qcvv7azzPLHvmJk/l4r
 y/6BT7gG5nYqBH+ke8IhtpWWqLUXnAdJkCmUxPobsvBvkCSq21gxbj9ZaQel9kOQH/YXtayWhQH
 ik6LWnzcflUJhyDr61GUIZZPWvF50OilnRFLpUF7QLPpt9+cV6oBK2pgy7QGihNKboDDxTro2og
 8XeUfa3xkcgX4QSaG0mc+ZOZ8c1weVW5x5p6V2DBscOVn5nMkTsDrz9eEj4iL87OQv/kIVWbYV2
 3phmLLSVJqFrJtPIdXvwva6+qBHxh0MaeLjh6YFCjF2c4eI/Lu2uvDdPstUFilmh7S/c1Ia0
X-Proofpoint-GUID: 6RQkiEyN-tdrXVPE-DT1taRvyGsmR8vp
X-Authority-Analysis: v=2.4 cv=Xuf6OUF9 c=1 sm=1 tr=0 ts=6871b340 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Yywnbx7U6RLlrUaFA7wA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 6RQkiEyN-tdrXVPE-DT1taRvyGsmR8vp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=951 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120005

Since there is already a return early for when the DP link is ready and
because link_ready is only set after the DP is connected and link
training has completed, the DP will already be disconnect for plug-in
handling to happen.

Thus, there is no need delay the plug-in handling until ST_DISCONNECTED
and we can drop this ST_DISCONNECT_PENDING handling.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1ce8051b116a..98f5274f123e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -602,13 +602,6 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp, u32 data)
 
 	dp->msm_dp_display.connected = true;
 
-	if (state == ST_DISCONNECT_PENDING) {
-		/* wait until ST_DISCONNECTED */
-		msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 1); /* delay = 1 */
-		mutex_unlock(&dp->event_mutex);
-		return 0;
-	}
-
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret) {
 		DRM_ERROR("failed to pm_runtime_resume\n");

-- 
2.50.1


