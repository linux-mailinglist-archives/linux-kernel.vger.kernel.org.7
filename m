Return-Path: <linux-kernel+bounces-831397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B72B9C8CD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 568EF7B7D08
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C975E2BDC15;
	Wed, 24 Sep 2025 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E9hvidxu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FD7283FEB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756397; cv=none; b=bZXgjm7qopeMjtJibpUTvSNhgjvJYJni+im+O7xw3i689wfEEdnnHfrgl8h7aLa2HHvMwmrgM2Afrb+Er8gcGV943FBK3tfX3QrKP/3xzI+m1itpf2g2qWyIOdwx+cKsc1QpkY0DHlsLd95UhLcOeWZYdSWVZG5NPkwvKaQJ4gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756397; c=relaxed/simple;
	bh=A52ROh/Md8E/l7pDVKt3JwMJSU6DehcWufqvmQgZXsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fbqmow202LXhUKdH7oIIOB3Vt623gE07fiiOw4ZWjLn/tcFqDKXfMpH++fJIYqLV7Hu5e7klBVeKjaPE8GD54H8stmlULApa/kqp/+VpEufgqajjeVzmKCR3IOyp/vxsP91A2gEAuUzH6FfXhMEN+H34YP9Zwb8SPNe87Q6/gjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E9hvidxu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODBckn029604
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uBL+fRZoVJd
	0EnYHl7fL+1Rjn/9hbw2Gf19pU1BpfeA=; b=E9hvidxu+rY1CsCN45h/7J09W3v
	y4ByyRj548wRNOsiAV/E9I/ttJ+IWBNX8WkEk5GMcIq+odj2U6Z5Qd+EjqkRQI09
	0gRdV2loGW5JxcKVhplCgu0Qs2PNY7DA3fFuFQXxXsORl7c61T4ON3UNOQd7qY1/
	WQ0ok8eLpFuEJYsbX/BdKItQBgFzl6YXzIpJTDjpRf01QFtVnxwA0cNmPnGthWTD
	adW1LnR/GiVlVNEai+JRlHbAqCyamxobgBIwAvJ8dy2ZCvP+57jbkSx+coqlUVfk
	eQTvSCMm8PdF56BmKks1t6Vj0um3w82beREm2qrXmI88E8o6YOyokYt1Yyw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fnwch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:26:35 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-268149e1c28so3146675ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756395; x=1759361195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBL+fRZoVJd0EnYHl7fL+1Rjn/9hbw2Gf19pU1BpfeA=;
        b=Pr+/pMJsMEuxleiz8me7YIZwxnwBjPZ/vl7dGEFrShfz9o1uvLaGmS9ZXsIOoz1jG5
         nChMAREGIlc8bNOQulCSOUvNxbevGzfeiWD7MJlAyepnVhinYXsVIP1iOPwPAg9cjVaC
         1TQ0kj6cgSWBMkeyfyWEFk2WECjVqkr5MwJGXrZDXE6agaLr9U6cOX86zm032GOYh0g2
         01WX17MH0dDMBhVpdDmgozYbeohOBXGRNnpgCs1TgAIvcDPIuyxWfy/kX9xKZRoXVeSm
         2Vkh5s9pppQICT0c4jPcUCIsqmCzwvPVdxvqa7nzxuo+B+kGL8j4q+Pd0kh320Wza0oc
         GzTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXehZgNBuzi6m3dfpUNFevf2Ed9S7r3X6ZNlci7jJnocaXsu91wRvQso1U9XSx1IelYFIsWVUtST6GEk60=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGFoFtl4gbn24DOVKYCuRqK6NUTsolrgKUJI9ZFGXHWqhzikbO
	i+1fJoibAYB1TlgEJ5EJIG5SQ49SMuQvoLwQMQ3+bqu07z7SpZF2q1Tw00vQoiz/2yUP2FJv0G/
	UOt15hB8QnD4pNkHcX8Alo9j2icYvxypw8w3QMo/zvL68i9jRr5G3VoOQfuW/49POA8U=
X-Gm-Gg: ASbGncsFssxTImYGwDl30HvHbArSujDojMhhRk2guhD+PDMxiy6v7a7ILqMkJA+4u1P
	dOtumF8bAcCpOCrdssYmA2Caw5b27yA7ausoupI4rTBBJ291aZzDn3k1mZDMaUS7hHgGKWKC4ZR
	ABlC1zfbliHCLLVUnASi1RK7lI3eNZDEP2zNchJIW25w8emyvJVwyxev4bugwIg999Me/9WNNar
	Nf1hBNeIiHDqnnWXM8GOKiQ9S6dqHJLsbSMHHEdIvc5RgqtU7X7n147V8SVQ1QRW9cq26w0+WTC
	gqg6z//bLjv6STgJYPa8kiGIPe7xH4IZsD0sMFPKa+Db2LPvyJEIzdhgJ35k4S3bOl1kNnL9pKe
	kbUMR5fcKlEBrbcRRsKt4mKx1zRk=
X-Received: by 2002:a17:902:e74b:b0:24c:caab:dfd2 with SMTP id d9443c01a7336-27ed4a7aef4mr14903335ad.61.1758756394983;
        Wed, 24 Sep 2025 16:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJEScj3N7017e1VxtcyNk4O5EUgwv1v9frS+qgd/Wrq1/qSDc6Y7tgNA0T1wmE6TpBQUbcGA==
X-Received: by 2002:a17:902:e74b:b0:24c:caab:dfd2 with SMTP id d9443c01a7336-27ed4a7aef4mr14903135ad.61.1758756394583;
        Wed, 24 Sep 2025 16:26:34 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821ebsm4005735ad.84.2025.09.24.16.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:26:34 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: lumag@kernel.org, neil.armstrong@linaro.org, johan+linaro@kernel.org,
        quic_bjorande@quicinc.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 1/2] usb: typec: ucsi_glink: Update request/response buffers to be packed
Date: Wed, 24 Sep 2025 16:26:30 -0700
Message-Id: <20250924232631.644234-2-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924232631.644234-1-anjelique.melendez@oss.qualcomm.com>
References: <20250924232631.644234-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YVEmhImBehlS77jIclyu5X02Qp3P5p7g
X-Proofpoint-GUID: YVEmhImBehlS77jIclyu5X02Qp3P5p7g
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d47e2b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=OI1EoHIFZYFGuZb9aTAA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX7qmPEnSBS1HS
 Y0bBJyTknpmGEL3gshaX99gbn4OtQoU/Ur+3Vs4me+0fVhS3L5xIL3n6fN3Ir2PiV0UOTGnOB45
 p6i3UYhqpJk2IJjJcuN9Gt2WSNGku77SFwCjw0z2zYZsEEhBcXczvzt/mbLlSd3X3B3T+BgfKhg
 e3rZShg+11NxphvawjtWPdTwEUsBkBVJqdgyxUkmEJxy2I+9THsLsPXKdg8SmdnblUMK1v3gyQL
 1/08umQP/R11ssPjC2IhRiFHin9wB42siaMma94vOQy1viBEiys20uEzEHLSotUroEmfRkoC2pb
 s2JBGvlvaOG1KaRKDIhmKOqTmD3AR12UiKyh0yJSqE2WZKOc30WEM7M/zeqKzuE7E2flEUQxjP3
 CgCQwWar
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

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


