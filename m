Return-Path: <linux-kernel+bounces-831396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E9AB9C8C7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5BB3B5576
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B86D29BD83;
	Wed, 24 Sep 2025 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TcP5LqKx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBABE17B418
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756397; cv=none; b=RoH6lOzSu/2SkOyBZeV1gTpBvcY8E1ZhX6fXvSplLrdpCaRVYpGu11+dE5/S20fv1sFwg31yB+QnoNViU/6mL+bp1RUlMdVa9G1wgsMHe1CGySyk7EnbFX3TuADukdIc7B42nRgjSFHeJXr+zKOxteI0e6slmADzf7EanptwX0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756397; c=relaxed/simple;
	bh=KT4ShPMIXLANybsIW6VxtTuV7gN4jM7B2/hI9Y0zV7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=grYaH2eErAoB8iv3Nyyb3iiExTMul1tKpCzCKG0k/lH7zyKt6yeQEwBeM+2kv6/yZIbxR1lifLSsltns3pZ0upCBZvfw5eNDRFzQJM0JBpKYQHCqh5pYo5uHTVEsgT+gooD5v843Kw21ByAyvel86iXST7IT56kkvTj17LGgE1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TcP5LqKx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCZomF002789
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=GQjtDrodqm+kp1P7e5GA5rJcackIeBkx7Xt
	o8W4z+sM=; b=TcP5LqKx+6Nd7i4JuclQORnrpoMg8Jq1/c4fGfhO8bOg4hn+8uv
	ONolC/rtN5x02hC5MzM7HFfl/HCkdwP7Pxu3/hqbF8pbz1QvU6y+a3TSlDl/jHmu
	mGzjsykSXjFyPmXhcYBX625WWQENNnmqGqDDKUbAerM/Z/i2CoBg3FKpxbb5Wp8z
	BC2f/s9qehtAiGcvnFov0aRzu8+VMSJ1IXWgeIjX8znQZkj2YvdK7NGuapPlbxmz
	0n9HrfylDEujxM7NDDIbfQ6ZzSoJ9TUdlGdPY++u9PjHWGtueIdTAGtzYOcdaBPg
	eI1xbDbwmd6AtQ3llNnlTfKGV/4NmeYjCbA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf0k3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:26:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2699ebc0319so3084295ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756394; x=1759361194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQjtDrodqm+kp1P7e5GA5rJcackIeBkx7Xto8W4z+sM=;
        b=ciwLvUsR2Ctq+21TXl+BxMmmVeHChcEstW1M1UQAYFAAQfwVwb6ZrKB4lO7Jf1SlI5
         /zZhcYH9gzpnQPBtG+tGABsXuqKX8UNN9mBttw8b4efLIELT4qXxmiUvwo81S+XsQBnB
         wU+v88VwKhUGzgSqVeU7SkhF0oykjTeJ1wNXpRFijCckkrpoiDW+339DyLzVbuENN3Ko
         t4SNAmnb2igZGv/ng93mOCvn5+8+ug0/vI3YFsknQE6PwMUjfa+Zcv0lQ25bEXbb6VwE
         cQW4ldOy6dixvSkTISCPqdXbRpYl+p1ou1+PDxyWZB42P7wn5LT9jIwJc3u/5ZYuKI/w
         y0dA==
X-Forwarded-Encrypted: i=1; AJvYcCUM3zYxbLcmSGxuA9TPPTcdZ14mzoJ1pBX5abkb02KjqffTkZp4BqRD7nVl2uASFj1kEmsfVfszpO52EUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0MQy3aKiGW6MTp2c6LQlRL/xEpX6S6rfFHR9v/bYPVWM76lN5
	e9N9TdSKfxG6Q7vKFr3/EioiWQ2C5Iwp7DwB/jB8g/iV2bebay4I0SU9CatKQaqbVYk/u4ZZlNk
	ULTWeuLmdGPL7s7jCoqJoiI+88JQnYmYDAXOFbO11K4//7Ehrug3bn2LpGj9MB3zuo7g=
X-Gm-Gg: ASbGncsqkQ9FT/Cu6z6sMGqDlpOG+W6zXpYTNiS7MXSCu5KG1Qp8ZzAbf+rbg/LyYPV
	Z3vnlaxvwvQeMlVv3VGV4RLGFqFXqEi9QoS8El75Qo1En0G2sN41gSnqFbqhUlVcBpxvdLbybEs
	BUzSfddtIVuCyLasKITvtoqQHFT+5/P/1vTgL5bs1v/x6KgY5sFB9G6v4JFY9MdBV+tcaw/TlNo
	91l4OpaOwy4G/XoFQheHdMMs0549xcS6pr4697PW09IxuNhiM5q9FsmPCa4+zgZ2o4qoAoL1N0d
	HSCvuU2IyDmZKjBngW96e1GR7YKjADailxSskaCyWw2yoZF+4YvLV3q9KB8FkNv10sJ6q3XD1l6
	sFs8BAPwFXRlabuJBW41gw68X2Cw=
X-Received: by 2002:a17:903:41cb:b0:267:ba53:8bd3 with SMTP id d9443c01a7336-27ed4a7f36fmr15577845ad.28.1758756394051;
        Wed, 24 Sep 2025 16:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXuz6NROEJCCwAfaZjwUd/ObLojVp7gbPqPbI5a4jnc0lC0U/zZvVWy96pgUlXuOuy5c3Ung==
X-Received: by 2002:a17:903:41cb:b0:267:ba53:8bd3 with SMTP id d9443c01a7336-27ed4a7f36fmr15577555ad.28.1758756393584;
        Wed, 24 Sep 2025 16:26:33 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821ebsm4005735ad.84.2025.09.24.16.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:26:33 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: lumag@kernel.org, neil.armstrong@linaro.org, johan+linaro@kernel.org,
        quic_bjorande@quicinc.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 0/2] usb: typec: ucsi_glink: Add support UCSI v2
Date: Wed, 24 Sep 2025 16:26:29 -0700
Message-Id: <20250924232631.644234-1-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kVZBc5wcgwyGgjqoCoPU9zx9B0-8sCqq
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d47e2b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8
 a=AXDibm61ZLAIF834zmQA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX3VPQFrfAPUdK
 KuF/6OCIHT2rFkA3cLUOacaykNRMC8+MgCfuCdxM5zE15ssCp+mO08zXDz1U6pf95dUIVXZ4HNY
 OySQH78iJd2fpQsedDsRrnrLv9SMOWozKNk0xfQpfyLZmOW85Gy3eKLOQV0ub/ITKAOSHBG0AeM
 S7utoykmDtiDSbETuwT+41t5PKcHwm5S2J+kJZzUtlEJTVIJQyMQAXHA2H2CfTVD1oWR439BvqY
 f/BhlUjUEGpjBzdMATxN+NTl/nnd7l+z2QsxDzy1bpXzbXZiMy0CQe0QAZTGHFYGNeufTDASidY
 qF/4zXEnWSpk3mbYl3I8VHQUWg/uznFVzf8zNwRQ6IFd6j2bSWY3jo+cmMPwOmrxDpLYc1xA1qa
 lX3ju1jX
X-Proofpoint-ORIG-GUID: kVZBc5wcgwyGgjqoCoPU9zx9B0-8sCqq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

UCSI v2 specification has increased the MSG_IN and MSG_OUT size from
16 bytes to 256 bytes each for the message exchange between OPM and PPM
This makes the total buffer size increase from 48 bytes to 528 bytes.
Update the buffer size to support this increase.

While at it also update the UCSI read/request buffers to be packed.

Changes since v3:
 - Added "Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>" for patch 1/2
 - Updated 
 - Fixed if-else if conditional in pmic_glink_ucsi_read_ack() in patch 2/2
 - link: https://lore.kernel.org/all/20250827201241.3111857-1-anjelique.melendez@oss.qualcomm.com/
Changes since v2:
 - Added "usb: typec: ucsi_glink: Update request/response buffers
   to be packed" patch
 - Added length checks
 - Updated version checks to use UCSI_VERSION_2_0 instead of UCSI_VERSION_2_1
 - link: https://lore.kernel.org/all/20250716005224.312155-1-anjelique.melendez@oss.qualcomm.com/
Changes since v1:
 - Defined buf size in terms of other UCSI defines
 - Removed UCSI_BUF_SIZE and used the explicit v1 or v2 buffer size macros
 - Removed Qualcomm copyright
 - link: https://lore.kernel.org/all/20250624222922.2010820-1-anjelique.melendez@oss.qualcomm.com/

Anjelique Melendez (2):
  usb: typec: ucsi_glink: Update request/response buffers to be packed
  usb: typec: ucsi_glink: Increase buffer size to support UCSI v2

 drivers/usb/typec/ucsi/ucsi_glink.c | 85 ++++++++++++++++++++++++-----
 1 file changed, 70 insertions(+), 15 deletions(-)

-- 
2.34.1


