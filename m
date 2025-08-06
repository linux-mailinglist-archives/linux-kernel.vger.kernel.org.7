Return-Path: <linux-kernel+bounces-758088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8155AB1CAB0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2E1163336
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566CA29AB1D;
	Wed,  6 Aug 2025 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VD9wmOYD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A96192B96
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501152; cv=none; b=FGnDrwMBQjrDVcMGuTDt/XNnUlcNuBmrVpxxO/rHGTa+ZlgaJiLM5R4JsdBQ0eVDuIe9j+J9FNrTb/F0y4p3mrGoxgaRnuecMH97ziUHC6F3MdvU9iFih5AxBzi0XH98stguj10DS/6A9vFTDy6XhOSmsHrcNcXIcF3tYbsjBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501152; c=relaxed/simple;
	bh=Cnfe81ebyCIk8w/h4ZV2DZyd5yj+BwIO3eFpimyJFZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g6lB8G6ZL5GEnWxGesUVDSwMatXoQjjt75iLCcl9i48sb3jtlFPgK9DWHQx6oKOBG97wT7vn/RWTXJAM8PBM7r81+6fH+Dn8uMUDM27N4VyhGVp3B1nVbBkoK1PolFoRe053T3mHZKsjGiCkh/RQ04bjUmRd0+F32bFEKNt8zZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VD9wmOYD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5769ek4c032246
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 17:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=eVYjI3rygCGwLfBirqa4CEGJ+oQnrEt/kpH
	x3wnKFJA=; b=VD9wmOYDlZZ+wc29v4hP/QvVEoydomsDECUYB5Y1zl0BtGGRDkJ
	P+YAyEndBnMQ8OHhYtRBrutJ3y1n7Vg2c9VVg9zodZSMZm2lS3gOB702edLcEwhV
	E2D6zOV7TNDtfFiqe2UfHIWSc6cCQ64SK0Jm5kRXvjDncqBYfROTPdVWFicJpIpk
	F66Ul9V0uOENdBAjNAu/Xfm3jAacB5wcA3g9UP5P6asEGd6bNeW01uO3GcV/F11i
	9RMyMZUIucIJ9rnBNGT5sKR7kWVN9RA11ng2t3qB0R1RJdh6JGnlT8AyxuPCZ1h1
	YIeMkReASIUPcqxqd7h+QObQIS6nD23A2qQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw2ukt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 17:25:48 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b38ec062983so26184a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 10:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754501147; x=1755105947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eVYjI3rygCGwLfBirqa4CEGJ+oQnrEt/kpHx3wnKFJA=;
        b=VwhlrsdrfdNbLEVG/SutK0AG5nu7WcXgYmbhzv97cNyGafC+swdpIUBIdBwXXlXXTY
         TufVpPwOFnPqXwhiAHb/67GxradW2hHi2DLa4Fz4VghwwCgDpg5936Ok6iA0D9wpGOE2
         ZnbEH6Vlf6bzozQ8rCoZvNNQlShoiHCOwEPTBAgnXW2Y1cfsyRKEI8hij2bf3BacAVoZ
         ELjwEuGs3YQSdXAoiEOQ/3RTK1a9ZnKB6IenvdJEYU6mA33KNMlw7Wkjpw6Chbkvuiji
         VFElQvk4cdpylxIYDxJbmDm9CPJmPqk++aY6ObfTsv9UZsNvYcmCkEQAN26UXfetZqwK
         DLrg==
X-Forwarded-Encrypted: i=1; AJvYcCWl6dXjIN9AbTdydigBt7f1hCK2Wb1IXoOxAErgJiolrgDwQBFoOpJEglsT/Hm/ur/pEqBN1FLthlplKH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX2OFo/lvlNub5L0mFvT3Fr/rEZENUurK+CDHCb/9/EXtRDCp9
	AQBGgazAElmcfnS5U2HD665NaE8Av6IHt/2mODL9vTiTpl6XmYMX0FN8Z08HnUKrX8XqlGV6PgO
	Aztvo6dUYuuzBIGsN3dkTFieOeTXSbFGzi276IqDCiQ5urt/mOnYoPod1lKCtPBOni3E=
X-Gm-Gg: ASbGncumi2FHXlrpSgECdLIX8KccNKf+i1iHpUPqt2/Jl+LG781EdLuuw8BRAVoFkJz
	WIdjiBuY64i/X56Zmw0ZLPLSsSkxiHMv6JlF0pm3AyjCzBJlJJjgpZmF+uDLkO4iiMZxni49NYg
	7pTTIya+T2vcjveCYYaDKE96dCMN7scCJuDO+pcLxD3dI4KmL6OTihI6yv8OGVwZp/EAsd9HXAf
	SUR5jvjnixsuocdClnpURdSdGihXByrRtpIk/lcUYDCZxgaFcMp7+0yGb9mBOtJPydfGwK/Zhl8
	+MhNtIgjRDz8djKULPVMyhiUn19f/3FTEIcYijYNs3He3LbvMT/N/4yZgucUD2z0CS4=
X-Received: by 2002:a05:6a20:6a26:b0:235:2cd8:6cd1 with SMTP id adf61e73a8af0-240314f8cc4mr5563448637.34.1754501147505;
        Wed, 06 Aug 2025 10:25:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu+nPMT7IIoSPFhOuYdFJmJMRBwrZH5TbAT34dZUvgIdZmjKpP2Xiim6bvjiybrcOPhuzQjQ==
X-Received: by 2002:a05:6a20:6a26:b0:235:2cd8:6cd1 with SMTP id adf61e73a8af0-240314f8cc4mr5563397637.34.1754501147071;
        Wed, 06 Aug 2025 10:25:47 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f417sm15866210b3a.44.2025.08.06.10.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 10:25:46 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 1/4] soc: qcom: mdt_loader: Fix check mdt_header_valid()
Date: Wed,  6 Aug 2025 22:55:28 +0530
Message-ID: <20250806172531.1865088-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vbz3PEp9 c=1 sm=1 tr=0 ts=6893901c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=o9fwi_DDGJO2X54_KKEA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: we4MLJrXClV_Ud05z5wEzMj02EH6WCeM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfX2Jv9qwJ7oN0c
 Ish+VlpqktDnQg7CUcmXTkrvJ7EwuFqxrbzpXzQWdpXURYp6OhrHHDmce9+3Ki3nmT70JauWS5E
 cIUq4orXZRniCojN9cC1BfN4gYOmuq9Dhn0WKO0dWt7jJCHo0QLEfGfE+4XVfB+O936mXzpIevl
 rEUrEU0Cly0xsll2CUpmIVtBWO59O63gA7oRlRWQsyYouNn82r2tYTdaaZrNgkv/dcQTq9A3rqt
 ZJjHLoKqp0TtjUklaWmpf2jLwvs6Oqu3yFGxa3QSOf9VoVRRcheqBbEqrKvLLQIGNDuc6uExO25
 xgtlgMvCR1PsL2Ue7zP17Yo15MGS9wcwKUCVysQrlkk+zuripLoESC8s6yK/1hX/wrtuRLPn/Gf
 692bYG+/
X-Proofpoint-GUID: we4MLJrXClV_Ud05z5wEzMj02EH6WCeM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

Firmware binaries may lack section headers, in which case
the e_shentsize field in the ELF header can be zero.

Update mdt_header_valid() to correctly handle this scenario
by adjusting the validation logic accordingly.

Fixes: 9f9967fed9d0 ("soc: qcom: mdt_loader: Ensure we don't read past the ELF header")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v2:
- Make this patch as first patch of the series.
- Added R-b tag

 drivers/soc/qcom/mdt_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 0ca268bdf1f8..2a14ba9b0fb6 100644
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


