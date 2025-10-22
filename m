Return-Path: <linux-kernel+bounces-863921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7448BF982F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 659454FD951
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4786C1E492A;
	Wed, 22 Oct 2025 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e7pNnJMe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7FA38DD3
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761093962; cv=none; b=J9/qwww6k0WqzAxKBGPcPRLRN7gSf6Zi1gJ/Svv0b5nOfL/HNd9a7aqBer390NZ0mad17P1b0CuVJ9a5AqRrynuE0L3LguORQIejhVJ53qoueeA5wbpQbTWySDFq0pBgJHLxFw7giNsk028UasTGklugmgNGkTgk9O8WKPqaV+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761093962; c=relaxed/simple;
	bh=A52ROh/Md8E/l7pDVKt3JwMJSU6DehcWufqvmQgZXsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ir/qzJuahDmoo9aqC/PMw6tsEZYSV55LHoUeEbNscKkVTw/dVG3oLd8hCvKOFHDIPPOztBoUXpAavhXMA0qZA5oHKJoD1fuF26sgKHIxjACZ3AKAPViFBLXprOGTjf/OppvxbZbwtOfebHW0a1to5r5iRW4AHbQlXB6MqIbsQjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e7pNnJMe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LEk6YE030207
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uBL+fRZoVJd
	0EnYHl7fL+1Rjn/9hbw2Gf19pU1BpfeA=; b=e7pNnJMekYEGtkXQbHG8yk4j2OE
	h+Osd2AsyklSBeAj8uCAiHKEnqNauHA+jQByDH0WcnoLATdtHBdqZq5TaB4QcYeG
	cl2VLu+6ZLbhYoSUcEIdRNq7WgIHv+007Y/ZGYRnIlSZ5JJm4eIZq2omiCAhVmbI
	L0GynrSdApOPWuRWHFmhs+112wmu+rlYjX/wluDYm5KW133YHhqYUMcSKosgr+V9
	kh83px9RK8JeF4RdD7hTyzpakwlQGq5CGGj+N3cwSpN5CLQQBITeyt59Ccgl4PxV
	JPANh07pkRADMHmleZDlmbIXDaVZeQfqEk8IrW5UQUDlfzFgtlLyD/nP7Nw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge2pmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:45:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2904e9e0ef9so121068045ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761093958; x=1761698758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBL+fRZoVJd0EnYHl7fL+1Rjn/9hbw2Gf19pU1BpfeA=;
        b=gnvez+VH63YMq7kPBx9yvWl5fgALbBfgTYwtl61CsLHm+7bGj5GjTT3enWpGQRA0L/
         dTocziV7svbUjuJ3Z6UJO2lLpLpgtV+5Eg/6jwpw4Ml2fedqWfHLqtjJj69kDwCAheZO
         IzRqstA00v6zY32FHhOpA6y2M3vgwZi+TcLoKzqG7H2QHRG9xKgRLTz9kmpTE/2Fh6Zk
         soRPuwUMH7XmOYUiEr9PI1oM2BOjMCjxMWtXj4JrNkGQXARaMGE6cejnggA4HjHjS7Qh
         lA4hRJgm4ZdIguNlO7zOcssyKhZpAIxUBaJPFP+UM0vvT54rI8LT7cmjZALnc0kIPAJx
         yXRw==
X-Forwarded-Encrypted: i=1; AJvYcCUAMmEB1AymQU4EDYYfvNAPtqxGur1sEk5NNJwznzOoOBxggP2WjzY3SAlNPlrYsqCxs7srZ0ZL1n49arU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxa639AUaX6KOtYkwaLFxyXCOPpgYJwFTa+s+aeqNf0DM8yO6b
	ktKRk39NnqYZlT8Fx3OzPcVmealH3TluEA8TlB2KmsFgIuq1xMQkvqqzvcFOFNU8aIleF5CwuLl
	lu0GbRZke+DZ0a+ImKko2M+uXzAAJgLftJEZqXNnHo2nbzdwi593wo+wJKNX0YVU0syY=
X-Gm-Gg: ASbGncukv+Mi2mmjDefMcrRbZZm+ucEkemw8hVWoT24rsXfik9Hvk8sUVD7xbxARTnZ
	JNMEbSYU31YyUN1ZkiiiCOVsXJxLa7vYqiS9P6z8O28pH2BdLTKEIoJJ+G5+yQX4fifPrVjtI02
	92uHMRE1OaaiO15HEkTbeJfvlESFXcFXPnHpH+mX0RfU50vc0MZOYVXt9wxj0UciJmdNKYnWDnx
	Y4ZigbA5Ea4v/Hhd8QlERzqr+WCK6BirU25ikX11cGgC05mr5x55Zq/K3A9d1b3lVeVLknTdSXl
	Ou2PoTIIK/Pn0eYok0dj6XpY0fw4U39oIyROV6GJlliVTlDpLNrCnBhd6kxInAwJgDliMUG6GDy
	sHt0uHjwk3oH5KQZJ5KMQacBBWv7eOyFURENaZWsMNj8eaRnmtRhYkTH+q1OS8w==
X-Received: by 2002:a17:903:15ce:b0:273:ab5f:a507 with SMTP id d9443c01a7336-290c9cd9f34mr223087905ad.21.1761093958478;
        Tue, 21 Oct 2025 17:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFecZ5N9CY9Li0/dfJQAVy9O0/8BZE2w5QKSyPywvMXAXjd7XtWluXcbSuBxe1gDtRVplB+TA==
X-Received: by 2002:a17:903:15ce:b0:273:ab5f:a507 with SMTP id d9443c01a7336-290c9cd9f34mr223087655ad.21.1761093958016;
        Tue, 21 Oct 2025 17:45:58 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcf67sm121913045ad.15.2025.10.21.17.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:45:57 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: lumag@kernel.org, neil.armstrong@linaro.org, johan+linaro@kernel.org,
        quic_bjorande@quicinc.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 1/2] usb: typec: ucsi_glink: Update request/response buffers to be packed
Date: Tue, 21 Oct 2025 17:45:53 -0700
Message-Id: <20251022004554.1956729-2-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022004554.1956729-1-anjelique.melendez@oss.qualcomm.com>
References: <20251022004554.1956729-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX59SlFDQxK9qY
 T5HPvHSUiYu8qPvOGnPqwLlY/PfIU5uEDfBfHf4cFbHN9ECkt9YQ5WGNOkeCOm0dSYaBVQVH+a3
 D+al+rKI5N7CFqPUQLJRqy5dkyPdy/ZYNzvCYxzKLxVDo3vEIRGWO7kbBp5Lx6L6iAsva6JwkgY
 EzYBajJ7kAxMVYcDoJOiOk/mJW8/Cn52RAHKboAjKHcDSCjiLczU+r1kFUQk5fTrN0jmRGenshf
 QZ1RnFfN342R1X0fboBF6ZYabg9Tv96Src25ANmrWaabZhkUofIxrAfzOVYy7oiwzJjrQrQZMvH
 2YP6lojVz6/GIXX3OoUlD5j0pO2XxYdQqELOClnoSwA1dghN5OdDDATbbeRjhLQ7UJfr6IhVnsv
 7PTgVuZAdKr6ccA+Mlas+kJ9wKiFpQ==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f82947 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8
 a=OI1EoHIFZYFGuZb9aTAA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: bqCB-1JYlWSiaYRVONGB39MUQEdhSBd_
X-Proofpoint-ORIG-GUID: bqCB-1JYlWSiaYRVONGB39MUQEdhSBd_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

Update the ucsi request/response buffers to be packed to ensure there
are no "holes" in memory while we read/write these structs.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 8af79101a2fc..1f9f0d942c1a 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -30,24 +30,24 @@ struct ucsi_read_buf_req_msg {
 	struct pmic_glink_hdr   hdr;
 };
 
-struct ucsi_read_buf_resp_msg {
+struct __packed ucsi_read_buf_resp_msg {
 	struct pmic_glink_hdr   hdr;
 	u8                      buf[UCSI_BUF_SIZE];
 	u32                     ret_code;
 };
 
-struct ucsi_write_buf_req_msg {
+struct __packed ucsi_write_buf_req_msg {
 	struct pmic_glink_hdr   hdr;
 	u8                      buf[UCSI_BUF_SIZE];
 	u32                     reserved;
 };
 
-struct ucsi_write_buf_resp_msg {
+struct __packed ucsi_write_buf_resp_msg {
 	struct pmic_glink_hdr   hdr;
 	u32                     ret_code;
 };
 
-struct ucsi_notify_ind_msg {
+struct __packed ucsi_notify_ind_msg {
 	struct pmic_glink_hdr   hdr;
 	u32                     notification;
 	u32                     receiver;
-- 
2.34.1


