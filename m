Return-Path: <linux-kernel+bounces-877937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7E8C1F635
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FC319C00C1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E837334DB53;
	Thu, 30 Oct 2025 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nT34+Q1c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="em6VTQPy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D238F34D939
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817846; cv=none; b=Dfib5OFUIzIMMdC8fXjI5ue+ISJiUxedLRm0py+FGqL+dS/Spa6mZu4v7doWgsgYFhkG7nxxJddhTSSbBPz15/oIcj5zcV7wUPC5eroy3oehOjydYbiPFmOC4TUHT3ceWcWYSJAbpgBhRpE8SVfZvtuslA2RnMiLdSojYtN3JTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817846; c=relaxed/simple;
	bh=0bCr4/wnV/HW3BBCIuwyR4gn2MCKsZrGArTvwCNdTgc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qKtSAaMh/7HKaQhGCqqQTkKNJq1J6/rIO+xXRECTzh0NGcg9x+j7L7vslnAjnMb/6pyYKrwOlo/5GwHaMs45wjsjIXYg+ZHoGwGipLYGFTlEzOlDR8+3DToYyCbsZdhFjn3UTkJkzrC5jvOIuinRbdTero5ZJwIrmmQV/vlNu2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nT34+Q1c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=em6VTQPy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U6wR3W1504048
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=K5HucAoMZbV/tahaTphfW6
	YCK45m5+kty0FraJp/7QQ=; b=nT34+Q1c2gJdqmGH96h/MZJ8GjTlby9V6uJNgZ
	9VzdTZVG7n7HquiUNGSe0DOLfhwEg5AJyqzETSM+fPxa9r5HnEWKnRu/AZCdrki5
	zYjwDfFTlupT2TQKNeUmylbtH0GkGaSVpWApDfqXfpkLzCqItggQek+U79q+efFe
	7yQYIvTxz0SgPbkKvfh3EmFSfiQ8bzZriv9OSuwCaXRBAFHWWPgKF4ShmjVsdCLr
	ZwAngOBhAzSnkC5i1PGf7i/pDEamRaaZ1ImPkl7Uqa8FOd5t7LGv/NEVrc483ngF
	3BoZuOImd4hyf6udW3Cyg+Vp7OAh5Hb2xZ7ZaNIEQq0sUbqg==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3t1jt12d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:50:44 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7c52c6ddeb4so2504364a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761817843; x=1762422643; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K5HucAoMZbV/tahaTphfW6YCK45m5+kty0FraJp/7QQ=;
        b=em6VTQPyznBZ45ckSpaCIEQZGgy11oxP2SRf7DhX50WTXuz0NhlSlH/9QmOo3qI0U8
         gq5ir0MoYhGIb6CLuO2nq0rqzORSCZ57p1iJH6SOmljzKb60JOr3JGSAFk0qGtXVP+QP
         qqJ5uV90DChtdf7cv+eKTvMyJgCUkXlP7PLn9KQ4VbNeL87O9Jv7oQr4ZET5ROu9K07W
         qm4+Hi8ZwmA2I6npCaXcQihfle0e80zXHZMX2FGCdT+WltKj3QoKwQ/JbCpSMQrW5Bhh
         FcX82iLp4hDghlT+hDHFqHIc4g7Bs6dLYMlSm/jCcZcmUaInqkUNP0WjX3xN4XhfLqLV
         02/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761817843; x=1762422643;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5HucAoMZbV/tahaTphfW6YCK45m5+kty0FraJp/7QQ=;
        b=Us/TrjXRUj3MdvMqUhJWvY5c+UwLD4xNuuLKN/zvoQ2Or3Bf0SJlfCuFJeJc7RmGJO
         yorH4aE9kjb5Wq9cGo0iJr2PDgexjMZc7rgD2TNlhO9fZPjLIkWcXhxklNCh4WVrZ7u6
         jmWN5S/RK9hRpneoZoKlSiAzG1wCzn4+rYKG0OtvtUeBHY+rhFMmfP/Em1ggXAXYzDcs
         nwC375lJjryJuEoKSUU4alBCG0LODigJIZtMaGRQaViZc1qP3s56puGv0QaEG6DSaG8K
         Fw3GIRcnnZ/QA1tE42q3Br67GA9YHoKyE+mhP7OfWxHy8ZvQsN/6j7lSrNm/89jrGFym
         nkMw==
X-Forwarded-Encrypted: i=1; AJvYcCUXUAy0YYa3mjOuA8Mr+9CmmbZQw9PKnRO+IY8k7UnQZz4UED73ATA3hJox2ZJKFggZij3OPgdzVOolvGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkwDBt2ZXV2L0VpvKSNz9Nk41AO81pHpql9cJR56J3z4yLynj1
	u86cpeHNa0WxD9ji2hQx9bPzPX6lgFpNPWfVqELUc6Uoif6FakPFXORIen9yydhBJnDEtD6X890
	ngaMmGvcZ9/VRu2Yeq++Pexw6kJ9eOkx9kxvgjqIEaCj26ZFzbyDkwBtrtXxZR3MzHR9v57oDzN
	Y=
X-Gm-Gg: ASbGncv1qGLZ1q/55pghCneI5nCSp+inqM6QQH/2tBHUuxq3ugov1vw/HjL6L0pIajP
	BG5Q9yCS82iwHEYVc8DgNDyGXJo45njzLfqapIvvAjfEnseB5JnYtWwGgObHDiC+OMFypE7QG8+
	HCr4F6SxRRKS1CHCWcMNtfnMrXKnRBlPjGB+jJ11gT8VnG3UVQqXZJYL2kUC37mMY8/s6g5ugHC
	0olAYllXOCI6m5qelQoCyb2GwutxpXJVIw06qg5j6YCLXOweFT6uWXCls6JPsPZagxk9QRjHwKJ
	cfkejQlnb4F6B7DJqx580jBYbJa9xdvl37PWEYMqIWF7kRu6CXgfELbh6S9hBRfTMh13OL2Y/FV
	LqQzlesovsLL17CQ53Eo5r/yDr1Fn+39oDcD96K1lXrqa6EiuIuS04Jyh8DXJYPxekW8/YOCZ5v
	LVJHxSqh0NEo7Wj3nFDjU7fcNCPcTSTYFWKA==
X-Received: by 2002:a17:903:230f:b0:266:3f63:3500 with SMTP id d9443c01a7336-294ed0c53e4mr32533955ad.12.1761817073168;
        Thu, 30 Oct 2025 02:37:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+HkN8fcbuCFP0TRBlNMyxmDyXoXm1ORN9ABgATWIptEfXxENAROgfHGDyHKHOJYkE0z28YQ==
X-Received: by 2002:a17:903:230f:b0:266:3f63:3500 with SMTP id d9443c01a7336-294ed0c53e4mr32533545ad.12.1761817072579;
        Thu, 30 Oct 2025 02:37:52 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-294e3ae4ba2sm49350335ad.40.2025.10.30.02.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:37:52 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Subject: [PATCH 0/2] Add support to extract the image versions beyond the
 first 32 images
Date: Thu, 30 Oct 2025 15:07:47 +0530
Message-Id: <20251030-image-crm-part2-v1-0-676305a652c6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOwxA2kC/x2MQQqAIBAAvxJ7TtCFQvpKdDBbaw9arBGB+Pek4
 wzMFMgkTBmmroDQw5nP1MD0HfjDpZ0Ub40BNQ5Go1UcXZNeorqc3KhMGNeVAjncLLTqEgr8/sd
 5qfUDrWCwemEAAAA=
X-Change-ID: 20251028-image-crm-part2-1f6bbefea2d8
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761817070; l=1068;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=0bCr4/wnV/HW3BBCIuwyR4gn2MCKsZrGArTvwCNdTgc=;
 b=/2qNN5zadQqilnck8TxEhlZxyaX3ZSn7KgJhASALRJPcrzJozo4LdsNNqc5xCZ9r5ubo/4w+i
 uOU/D0M3ceECGBSV0w8vULe9ZQH30LjKV3tkYkH9lSaxHXLRPo6FlG5
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-GUID: mJEmMl2eDvJPMGuwf0oIGCYz063fxrHW
X-Proofpoint-ORIG-GUID: mJEmMl2eDvJPMGuwf0oIGCYz063fxrHW
X-Authority-Analysis: v=2.4 cv=M/lA6iws c=1 sm=1 tr=0 ts=690334f4 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=yCE4tiJ5SOckIsVVh2YA:9
 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA3OSBTYWx0ZWRfXxPk8kMDNcjAB
 KBAuhqOlylJ5OgUL/jPj3yJk9tZtmrxy/KJHtme7IA4SDg7+BGtRMJhFkp6dJx2F1FD0t3BPrXC
 hOVO3o6/BL8GQPHhullP+OhNldyS9QoQOuHZ6cVZqrQF5af4lenPym8+bOycLXmvHnFUdHcOl0P
 EBu9uw/eWaSPzzOiCRNbIsfc+MCTqJRT1+jBu5k2o8MQhHypcYu0T/P5yMBfmYGYlzeDVlDiGKy
 ecsveUmHKkRd2s5MtHmTmq+AjH4XhVsOpvU1rax/IvqYRcZF25+aEjKckbLYdS6BcomfXEqUPAY
 +O4eOe4iZ8G5bf902vjYV+e/JFPwqGgaQ6otOnnTYCrrL0vUX1P7O9x1qG0oxV24zScr2rdCz8l
 qqJRkZS+kD/4rhVEl76EY/6VxVlR9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300079

SMEM item 667 contains the image version details beyond the first 32 images.
Add support for the same. While at it, introduce the new API
qcom_smem_validate_item() and use it before getting the image version
from item 667 to avoid the invalid item warning.

IPQ platforms doesn't have the SMEM item 667. So I couldn't validate the
image version details from SMEM item 667.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Kathiravan Thirumoorthy (2):
      soc: qcom: smem: introduce qcom_smem_validate_item API
      soc: qcom: socinfo: add support to extract more than 32 image versions

 drivers/soc/qcom/smem.c       | 16 +++++++++++++--
 drivers/soc/qcom/socinfo.c    | 46 +++++++++++++++++++++++++++++++++++--------
 include/linux/soc/qcom/smem.h |  1 +
 3 files changed, 53 insertions(+), 10 deletions(-)
---
base-commit: 131f3d9446a6075192cdd91f197989d98302faa6
change-id: 20251028-image-crm-part2-1f6bbefea2d8

Best regards,
-- 
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>


