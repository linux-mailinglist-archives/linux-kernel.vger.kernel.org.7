Return-Path: <linux-kernel+bounces-735406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53559B08EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39AEE3B7F70
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3266B2F6FB1;
	Thu, 17 Jul 2025 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U556DEdu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1192D9ED4
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752761424; cv=none; b=VfDvAqywSpsHXA1lH7Kcj75Zrd1KoEVK2BT744h6QmnACGOUQhnpyDMvORixwVc+wkfNXPo/3uy5paYEM8CWXujeFHch5bAkHJ+oyVi47omZtpvFGHpHV2Y9WRnZNiF0NLTSug5ENMPgBClFXU7Mw7t6TgKV+vW0GRg0MXjudEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752761424; c=relaxed/simple;
	bh=Hn6xp41CG8R9jLKdMzrXoDdSoG3dKzhDMIecMB8nXho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kS9x1SdRSGduNkpLDKEfnmjNuVUVtC5PxMjNRgI9hbVvCycXcvkedC/9Ne8nGe3OCPtdNbl/vdSiicMLDrDJ1SWmVVlwLXvc1T7TkPU0B73ZYCgpP6kLRku4UGL7SHQpZspSQNiZfyAeLGcE01NOIvlzGgdWtj+/B/HeWWl1fqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U556DEdu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCLvxD028099
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Hn6xp41CG8R9jLKdMzrXoDdSoG3dKzhDMIe
	cMB8nXho=; b=U556DEdul47+c8LrFA0hHZ1/MRM688BpmpxOPkNNmF96rNa+tC8
	sHzehphmv8NB/cJftt9nF7yd/e98tRCL+1Vc5l0MvJIrviMYsiWQ5TpJ+7A8Inzs
	G5Z2oNGReaG81ypWgoTLWMsK/bUtRfJVVpqScJEwmQhk2/ft3QLWLWsGcDzgWNJg
	qaV9hPM40dx327RM1VKpzhG+RoPB3SzhDqNqNwUw7O5fWMSGAAowCgfaxIVAIhK7
	hArOGXPJmQj2oaK8hzABiyTwVaWryiknPWRHdHGqPiMCCVoIPoi9Qs9NM7zbPqKd
	I7KMCOSMgwcHbNi4Cj0H8oSEP60laMdhXqg==
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh6067m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:10:22 +0000 (GMT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e172e68440so10212035ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752761405; x=1753366205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hn6xp41CG8R9jLKdMzrXoDdSoG3dKzhDMIecMB8nXho=;
        b=o8j6kztgcVi8O8deAJsI1Y9Tgx9oEiP9ELefGzGYoCFYhuHFm5qSseMwfIqYwH+REZ
         ULWygWTazztBeQ84fa/LArk2mM7X4o4+yP9seDfck2BzsVXWiO4ISJ1m65SKTJwUHU/y
         Dsq1D7oCKatDk9juOVIHMZK3IJI0rqEYaQd6U01SbYe1nxg8u3LOES1vgwJWiPBVKKqR
         gOkxzRM4XVj/gWQlqZ0QuHKu6iIxfgqPJqpLSR2g68TwrenMK4htYTRhpRvnclEDs1Lc
         Pt1ThogaSuFRuIoQgqgDIJm9W7I+RR1lOWqwVZJab0j6LiXBtf0D30CPZOTcGWwmr9w/
         4Tog==
X-Forwarded-Encrypted: i=1; AJvYcCW6JVLC8iqR4Q0I/TPo9031szUseli0s9ZSzC4r1FDEiPo70FOmyQVzjiYnI2uiEAVVv8cq2WUSTpJaCZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8590t3QZoG9NigWBIaP3zHzh4bzhhbTXto9BVEZ5gfbkuj83l
	6g6XnEhRyPkSiWI8Nva4jG2uLrVYSMkToau17tYn9S8be8PEYjpwNmqUembes/+QHRsjJoBgQPc
	6FVUajo+cdQaDhmiB0zcpXHwu8f89OxEgs25GtZVm3JkD8nBkfgKYHDgZQmaw0zWwswY=
X-Gm-Gg: ASbGncuTBGu7RLu8dLuXYp0MxKSIxdLt/DixI9MQ0TVI6c8Q46Q/0Lsa+zEzY1L63zJ
	zSh0IPfAnaq2q4kp3qbCPW0GEWb8dbRjdLSUpkyVq54RWIpr6yfFh4NTOty4HAMI8BheT+JYp4k
	gBHEbHxJyXaqyaf8P5gdlNBR6TKCS+nXLt7iX9eIeYoHL7GlPP57oY7W6TaeRNxxwS1k68Tvy+S
	Nazd+0dc66nu0QX5EArU/mANxoqDiaAC8FQQmAVVs3LprzCxFEnJ4veXul3O1AIbSDodGf4KubE
	7CxIcrtn7ZoKFW7jzf9zLlvNITpDYPW/RufFb8NtN9q1LT/4pumnXdAXlbai+ZJ2yw==
X-Received: by 2002:a05:6e02:18c8:b0:3df:3ab2:cc7c with SMTP id e9e14a558f8ab-3e282e2ad3fmr59716255ab.13.1752761405258;
        Thu, 17 Jul 2025 07:10:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwHhw4sdYXg/rxc0xk2whzgzOEpVwWmRJcX6HXtNCTGUO9L3yjAp/57Q94d0ey9RuG/gR99Q==
X-Received: by 2002:a05:6e02:18c8:b0:3df:3ab2:cc7c with SMTP id e9e14a558f8ab-3e282e2ad3fmr59715725ab.13.1752761404826;
        Thu, 17 Jul 2025 07:10:04 -0700 (PDT)
Received: from HMOMMER.na.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90c4dsm1391452366b.19.2025.07.17.07.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:10:03 -0700 (PDT)
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
To: Enrico Weigelt <info@metux.net>, Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] gpio: virtio: Fix config space reading.
Date: Thu, 17 Jul 2025 16:09:09 +0200
Message-ID: <20250717141000.41740-1-harald.mommer@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=6879044e cx=c_pps
 a=vy3nvQW9C2dqy/lMnN3IYg==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Wb1JkmetP80A:10 a=OcK3cvsEmbn26l3-tBAA:9 a=mHQ74H5e8mo-RpSg_uaF:22
X-Proofpoint-GUID: Z4I6KpnWxGpKb9PBChrGHvZBb4O_m23g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyNSBTYWx0ZWRfX/AfW3xcrUlXB
 EhnCppj1JRn7WXAWKoGaKAcSwCXvqEKd9y9TAwfWxsFf5E3SmwCA29c5bHqkUPR2dvrGLm0GfdK
 wc1G9CKJgsfD1FADWFtxaK/yx4Vb4qj3BSZDXrZT45oTQXdxMizIZmJ5IKv/s8MgrhQZ7nSLSLT
 Be3naDYQO1NJIOYLf8+N9UZLOGrt60ysFMS8bf1tvp+G0KW+PFBVlgE4rEEySqx0BHORhgUWhN7
 0ml9TyPzJjRdletn3Fztni6OBZHJCpIeNgua92c2V7yaX5ycPPQh8sz2qeu59Ui1sWAcNBp37ni
 dAfc2S87LETdc9pu6lcR3LaTyv4xyUVvVFF0w92SwN2LG/duSQrRz0C0zBipqCxoxETmAude4zC
 MlB23IFgS+yTUr6nlahGV7WO9oCh+40mJZeU9Vi7m27PGIH0Svakulf8x2waj/+CkfmqAhDv
X-Proofpoint-ORIG-GUID: Z4I6KpnWxGpKb9PBChrGHvZBb4O_m23g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 mlxlogscore=801 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170125

The Virtio GPIO Linux driver reads the configuration space in a way not
conformant with the virtio specification. The hypervisor we are using is
strict in what it accepts so the current behavior causes a problem.

Builds on top of gpio/for-next, tested on Linux v6.5.7.

