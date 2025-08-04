Return-Path: <linux-kernel+bounces-755129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 036DEB1A1BC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FD817AE6C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D893E261581;
	Mon,  4 Aug 2025 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QrwY1oeF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6A226056A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311369; cv=none; b=EsKupJEQk3l4Z94Io5BcQoUqI2sKjI1hHYCjPMH9mHnpiSaSmXxSezTgJxUKTaLGgieEwDtkO3zSF74Vlc33Z21woIUyKijV94TCUm0F1gvj0TUftYdPknEZiylosWlBLtv4nxIRsCBHtI7VHpAHkBFb3MqEnTb/gOsAPS2ggMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311369; c=relaxed/simple;
	bh=ZD2cfNOpHxwkRMCN7+js1vyBb1FTVU2dFAlUapNz9qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BwyFMoBO2XakgkyIYQ8VWdYORSC6uUmwQgwTp3+83KSkwEkw5kDweRRgMhuuWTwCxS1VBhITBUNBw7qvQAOvm+RBE+ktSWJ0T1h7uw1tGIZGQuw+YOIhz+scSFhjx2EB4W7+MPCuB0LhbpON3eqzngGSFI2O/9EAy7+VvUL0Hac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QrwY1oeF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5749Doq4029674
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 12:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E7khlvNNDuoulE+J6oEwv77nicTb/IEKyXaurbG6alM=; b=QrwY1oeFsDIdUUZt
	h+veGqFgX2T0df+pc0yih0yBxRl8y1jGxqQ/NV5o04cHaybiU5MCubmOddioLmkL
	mDGn1KsoDGSPT4iLTXY1fsEiJxkuoWF/KCZBeTvppJv0LL27S5+BNj2bGHgMQChB
	jZM5GVJcL6/68lc6LKdY45Vy5iB1qVpB3SKiCBImC0Db1MJUxZwnQBTpHQ7h8RgY
	I3BlVHQua+S8sDEeGPu9Wi2nxjw3JGyM3Hcgo33Bv1G8HYdNKzibG8K6Vn4xuDHF
	ucWOuAQgJv7E75Q1bSsEzgNQwcoMgaxGgU89Z9Ej00/OCoGsDGb4hXBkXpX+/cjH
	7TE+Wg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48981rn7u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 12:42:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2407248a180so32901235ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 05:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311365; x=1754916165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7khlvNNDuoulE+J6oEwv77nicTb/IEKyXaurbG6alM=;
        b=hgPj+W2UjmsnWmsZvzERtD19c9urw/VLNb8U2tcBhYePUl+SYW2beklt605Hjk9pHM
         CHxj+ieQLAH8BVTCFuefR2E9glzVdOazFiuQ/dtAxsEHezTyHjVv+az7iXbUQwkj6Oy0
         4MRjoDyt/cxSZHXk4B+JGp3RIXULjZ/AbMgjv6uxwvi0+LaWS2Vx7KYpitD3sRrtxXfw
         TzjzWx+GHJ/CbUcijdo3vNPWhf5UBhg+MFJU18jk64mt3xbKZK2rVpk0MjQ6opesNf1v
         jhna6SqS+SdNvKYlGSbi/pSA/oAMAyfi1LnVv1X6f9ibSNlWd3dcI6HPWvke6YL81HhP
         UOLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+Sh0AW49gNbnb26liuUbQX5tycX7KaI76+lo3zSqPHko3ysj5jRTVn+enHulgNVoRyqGVaZxCKcF6gCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDx8X29m7MgtF2dglXuekh3ve9d1Iitot9RW9oRwgs/fl97gZq
	9EypASvdzuFbk4iThVBNUv0lObJ9QQqpJDv4HcUAvQ/zhcTGKOV7HI3r1Y4Z7KVYwNuV4rX9Ryr
	PR7ZH65JAQU2ogf2Neing4FrQakf3dxdw2AnXY6iYjjcPOR3FfJJaGWfixmNW6BojBz0=
X-Gm-Gg: ASbGncsVxI00geiGSZdcUxIam7ThV7DRoCUW5/M7QtIM7UvMGUCb7a602WdXkm5ksAI
	mf4h4zJ97+Hs7FxSNNcSS6a5S0YJhKeQkgJIPrp0LRWCCvFbXANoYinJsu4ksTgeizsBcsKsCc9
	3NAVYv0QuzrWU3Vs9e/0xyKeXkAVrAxmi2GJ+/hgAjK+JTcTD4fR+3umB93JyIcJDjJjAmJyH90
	yA3sK0HWhlq7rU4UEu6Dfppixv8EvQnFv/vDbeYdZxGNOo8nJMXcNdDFPLbQWG4ifd78HURBh52
	3CpwWxbjGcwTIpAOp2gUYgZByuVzpBaOumjx1QOnzrLly1qLmOmAcRN3EUmBelBhomI=
X-Received: by 2002:a17:902:dac3:b0:240:6ae4:3695 with SMTP id d9443c01a7336-24246f461e1mr130978895ad.4.1754311365203;
        Mon, 04 Aug 2025 05:42:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeOucmT72G4obyRlN+ZWNcH5Q2iHFWuRsaszukVqVSTemP28S1LdiDIliCYgYSEqOFKiYRGQ==
X-Received: by 2002:a17:902:dac3:b0:240:6ae4:3695 with SMTP id d9443c01a7336-24246f461e1mr130978495ad.4.1754311364777;
        Mon, 04 Aug 2025 05:42:44 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef8204sm108876365ad.34.2025.08.04.05.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:42:44 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Mon, 04 Aug 2025 18:11:51 +0530
Subject: [PATCH 3/3] soc: qcom: mdt_loader: Fix check mdt_header_valid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-mdtloader-changes-v1-3-5e74629a2241@oss.qualcomm.com>
References: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
In-Reply-To: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754311345; l=1035;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=ZD2cfNOpHxwkRMCN7+js1vyBb1FTVU2dFAlUapNz9qo=;
 b=mtBwG5naW5sNpYeSB0s+MuWu8v5N3eNWKJQxjUkuVslBWPyqweBsrkgRKZIKRu6ocioTpjV+E
 38wGTOcs9trB0+XJueeCQ+8YMfYUL4Njd8SL8xUVCDRnhbU8P0YfH6V
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-ORIG-GUID: ItU2uFHuE0oMF2QnEFw0sEN42TAZJKmh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2OSBTYWx0ZWRfXxMd1uotMXJkU
 wHKKIJwgugum92cL67ZkbJ+TGY2zHwJYYMnUv2QAUhply3lOEiWRxPlwkj9OLZ0J5lel9UA6Dlp
 vqF4Quj6twd0Sib00sFU85Y7wnvlGeAyaVUGLo9rV+RZHkOru79BhHBoTWVjCbt/DOIhLA8tE+4
 RY/cq3nVb7JFNdBkKyOOHJbC0Cw6hIowb1siQ8MWR83O6ZWLT4XRZ2f7Iy3uCEAw/GFMRJ7dZzz
 P1FI3r6spqOcbLc/EnC+80h13o58EUH3098kFooq/ZhbbAAblnMJakXNjWbMlg5hA1dJkLntCIt
 p7MOPj5K0j0Lnrt0PTs6yP+G1fUDIi1YBKdVGT4779f66BTuHbgwP9AzQwfee+fYCAHqdf70xWk
 mic1QnGfKyX43cmEnuq+cTzTp03I9VHxiEsYYR9NEPoyfvI17bmZt5Ehnzif02wpuV0APa2l
X-Proofpoint-GUID: ItU2uFHuE0oMF2QnEFw0sEN42TAZJKmh
X-Authority-Analysis: v=2.4 cv=a8Mw9VSF c=1 sm=1 tr=0 ts=6890aac6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=o9fwi_DDGJO2X54_KKEA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1011 phishscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040069

Firmware binaries may lack section headers, in which case
the e_shentsize field in the ELF header can be zero.

Update mdt_header_valid() to correctly handle this scenario
by adjusting the validation logic accordingly.

Fixes: 9f9967fed9d0 ("soc: qcom: mdt_loader: Ensure we don't read past the ELF header")
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/soc/qcom/mdt_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 7522223835f5..8210fb3dd51a 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -39,7 +39,7 @@ static bool mdt_header_valid(const struct firmware *fw)
 	if (phend > fw->size)
 		return false;
 
-	if (ehdr->e_shentsize != sizeof(struct elf32_shdr))
+	if (ehdr->e_shentsize && ehdr->e_shentsize != sizeof(struct elf32_shdr))
 		return false;
 
 	shend = size_add(size_mul(sizeof(struct elf32_shdr), ehdr->e_shnum), ehdr->e_shoff);

-- 
2.50.1


