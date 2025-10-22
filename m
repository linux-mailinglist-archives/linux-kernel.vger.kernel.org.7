Return-Path: <linux-kernel+bounces-863920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F97BF981D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC1D42674E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C121D5CF2;
	Wed, 22 Oct 2025 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VqtfG4sN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9186543147
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761093961; cv=none; b=mtFpMHWypI1nbxetCzzXi/o19EDypZUAKzewROc4jBJ5j0jy06F5vhhOhhn1VuFKuNd7qEAdNMW3ORV3i8mhRttki6OaVHJU4dCGKHzUUhu0Cd7PeICbR3wjC64aoBNi5tuGRFQtmx6zVUZ3MUuUNRn1oqzFHEibeR1hMG0ZAiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761093961; c=relaxed/simple;
	bh=Ff3ly7OYBgQF203NlkpnJPPzsPGuYU3vghG0scfKJUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vAKrW9dpCo1bhJSyT7hibn4FxBhooGGq9FM1QByGVaGk3WpU33S15hruZKTCbb3+L3Lk4MQfbghtDBPNXKr/EnVcpGIz+BCgP9ngQ/VawQHQ8MF0Pt5ZjjdK7qEyj+TbVI1xOrCeLBn5rwDsNrtZrGmN84+zKENMKbAvO9vJRIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VqtfG4sN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LETHQQ024737
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=EoVdk+R2177hR21peGq1tgmUNMOo/3hzUkC
	rdH8m2TI=; b=VqtfG4sNaBlmeoy4ynrChLaMeRlVGXz4H9wT56xbzAz+zMF7u72
	qfcpNPiapLKhcpEQxkNHiLQlHuIR4bdhKG8gqweXQnG6ZmAra7NRhODKSJtjxktS
	pGj5CsSgWylYieSn0IRis/E6oCGPevFEGuFQq4Fo7beFOjyAP8bu5sWSzKwUuRuC
	FszeCD++gxAfuoME0LCeN5Kis7Z5qCdWpTPSAYRrHR+xQ8hcwKIMlNTtLa5sZNqJ
	Z/CCvBBbgf9KsbpG0qY1A7q5bzf6HBjA+/mWVdyfIMTpDJ9946m5AEJlKayzji2E
	cSntZ7w5K1MYVSI1OEJkteKoBZR+tfIggow==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49wsws52n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:45:58 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-27eca7298d9so149989575ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761093957; x=1761698757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EoVdk+R2177hR21peGq1tgmUNMOo/3hzUkCrdH8m2TI=;
        b=MvmaKfEyRKXsk5PvB9DCmr8IDMmiTu3nf8SyZDBOQoi5wJwpMGQOy516RoAHc8bSBq
         yzURhlNip9Fu8vmnbPfje3sBKDZi0HNoWV7N0u33mBTvdtsLKw4Euqyp/AuDxtBL3tJT
         3qUEDd93lLm049PK/J82Blx8w1Yl8JlgfsuBe5nIE3EM67cktXQHontMq2VR6bH+qoK2
         Qsl6/XyhaNR/1ZGC/XlC3IfmbF/RLEi8cZ+04tJrZjRvn/B+hWBAGriXxNRgSs3zGWnq
         khTDfyTApm2Sa7fddI/0XSYxY+sX317god1+UNZM188AHd9FOpimjFpQRoorudnUG+i8
         o6jA==
X-Forwarded-Encrypted: i=1; AJvYcCV6BebnVrEUcX4/kwyZMOIX8qD6Wjbk0Ob01pylgvEnSfILWv0ZmCVJra24S03M3xBAinx1Ja6qPHmm9+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtl3bEHLKhXWCKCokstvp6a9Vb/2pJescQtg7VVwCcLGIg8m9L
	bfkVUz6Rl1D8V01E9w7CjpoXXLAL6ZyFJyWTNBa+yIhfAW23nSFvu1HEIeEUshPKxosCEz8KRUO
	xLffkijz4Y65AZWRaBmzsSB/JGnQF5kkS3uedWLuOsrYJiVKkyllcFh2xPfGvCGYveZg=
X-Gm-Gg: ASbGncuJyw3bRNYOdY3nMicQXbwcjOYiM8+oV48cg6HQlH3/QjxLVKs8Y5k+XTUVwM4
	oZVAI+uCqNR1LTUbTlKyKsnd51ZlpKDibKgX18UiQASolNqov+w2SBWeFm8zI6Gayob2LGZeU6k
	TgtF8d5+/VEmRmvoJsjNE8J5ezHw5UcSmJWpJs51Hjn3Fmpmyc0OHbFvYICgLjZclrlXfV0UIph
	7pmLPboMkFU3/fCKtQ/v7pwtFzubykjdDdjSBxTihEh+SQl8qDWj+IgZa5V8t7//WeTkdiqQxQi
	jq0jnHkM5wcw9Ie74ejYVhwy9g/f+2OmFPkDHBE+regoUjkViwPeHuiiWp6C1LuiflUlR0Nti6w
	rXsFTqk3beMvVYaEjA+Ex0Ej0i58Qy2DApLFKw7Ywp5sca9iAT28aTFWHkLbSjg==
X-Received: by 2002:a17:903:1106:b0:27e:f07c:8413 with SMTP id d9443c01a7336-290c9cf8f3amr209465595ad.9.1761093957082;
        Tue, 21 Oct 2025 17:45:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAil/FD0eyE9wxbuEjh9p2COtE3nPDA77TDJ8rM4VH2xnt/n4RjQN/WjfhsGu8C/XoxIsf+w==
X-Received: by 2002:a17:903:1106:b0:27e:f07c:8413 with SMTP id d9443c01a7336-290c9cf8f3amr209465335ad.9.1761093956642;
        Tue, 21 Oct 2025 17:45:56 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcf67sm121913045ad.15.2025.10.21.17.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:45:56 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: lumag@kernel.org, neil.armstrong@linaro.org, johan+linaro@kernel.org,
        quic_bjorande@quicinc.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 0/2] usb: typec: ucsi_glink: Add support UCSI v2
Date: Tue, 21 Oct 2025 17:45:52 -0700
Message-Id: <20251022004554.1956729-1-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE0OCBTYWx0ZWRfX2eqXyull5utx
 +C5jbPsjNuwPziivPm8nUWyJECtSqe0o5XNK6L0bdlQ2traCmvEFkYNMQT+mjo2+L0PNSEb4R59
 FUPmPYdoelH14k75z5KUW85H5zMjCAEYjBibcaesMqGWW9IeyhqbIj3mQuVGgKBS76JEyBF0oBk
 5fJFb4MpXEN72qTYl0bgmCc1UePxcy2GwzZgBPh9G/F12xqQbeJrrj0nACEhxVhaCDOd0MBBsnF
 G24xRj3pTr9OkU1N+C6xFOPDwK6ZUTk0Fi94xSQfDBMPr18umACr0DMSvLoJn6yGSvQubvf1wqY
 mokO+l4JEAgNHARmhc/GW2o1objinRaIAO6mYfWDMLqErbaT6Ss7x/334rdNY+Vs9kESBfLkjqQ
 ptKFFkB+Z8S+z5k/yswRHExH82Ff0A==
X-Proofpoint-GUID: Tu8TdtN_hnjOdEpYrusaUvS9MqUCWqe6
X-Proofpoint-ORIG-GUID: Tu8TdtN_hnjOdEpYrusaUvS9MqUCWqe6
X-Authority-Analysis: v=2.4 cv=a+E9NESF c=1 sm=1 tr=0 ts=68f82946 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=QyXUC8HyAAAA:8 a=AXDibm61ZLAIF834zmQA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200148

UCSI v2 specification has increased the MSG_IN and MSG_OUT size from
16 bytes to 256 bytes each for the message exchange between OPM and PPM
This makes the total buffer size increase from 48 bytes to 528 bytes.
Update the buffer size to support this increase.

While at it also update the UCSI read/request buffers to be packed.
Changes since v5:
 - Added else statement in pmic_glink_ucsi_read_ack() in patch 2/2
 - link: https://lore.kernel.org/all/20251003002044.2944497-1-anjelique.melendez@oss.qualcomm.com/
Changes since v4:
 - Updated the read/write structs to use a union for the different buffer sizes
   which depend on UCSI version in patch 2/2 
 - Added a clarifying comment to a size check in patch 2/2
 - link: https://lore.kernel.org/all/20250924232631.644234-1-anjelique.melendez@oss.qualcomm.com/
Changes since v3:
 - Added "Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>" for patch 1/2
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

 drivers/usb/typec/ucsi/ucsi_glink.c | 88 ++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 14 deletions(-)

-- 
2.34.1


