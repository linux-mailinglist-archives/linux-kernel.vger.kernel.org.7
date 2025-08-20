Return-Path: <linux-kernel+bounces-778682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA1EB2E8DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01F6F7B8EE0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2211C2E88B3;
	Wed, 20 Aug 2025 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PCWZUO4a"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8407B2E5B17
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733155; cv=none; b=L4XgJ/TIIeefuZ9O9SK9O/pwBUyT92F1XH02cVl8/400Gr5Wh7kM642eA3iYTtOcZqQBzp/EvAlAwbYNM6Dhjl583vnMQncwRTSggK9Ez+aEx7XUy6296JTceyyb8XZ1rcGkGE8hyY5KoCbDPW/QxrDmsPiQ/5uui7H5BCYkq2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733155; c=relaxed/simple;
	bh=nhZDUeOuEBpe4gtZaFsCxHLG2a7kWizgihFMSQLXv+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NLdvLxIaebidiMPSsTRyHitYDfM207aHkmrISs+Bedxl5t6yQPO5FqY82zLPKyOP7dwQu9UkJIez1J1zOFc4cwsJQIZ3JSblNinNwe1urSdGZs9A25zI7Yj2qNDLGMhxtyF4AzMScqTmAJCAimNO094VCWTR0Kj6g+6zLTBrlt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PCWZUO4a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KFCapV007320
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pvcGflOb4oHfrwRpsgfYu+5cxv3Vb3K+8uRpTdLXgHU=; b=PCWZUO4aCsixtpoF
	ZFGaRiI/6mzDtjoEH40urxBiBbP6+XNt3WvN4/qYQsr0fqBATlGs6cJR1+romPz0
	ZSHD9uWkf8dQeqx7lef6lfm4tn/VqwZPFqnoHAr2zjvtMmN0srjxjmxQDwW1rK2M
	YfsXkmo2edya5VKqK90hmv3Ews9/uixj7AguCvnrt3k+Y9Zi+MyHZbZo+CiuS6Q2
	NwIfZ80OyNi3rOn3CnM+IOLEGoeXD5fceAWlDqohdSvOTCMo1M2Zdfg5ALM+RwKU
	zfCtSOwoEcVuUQitrXscftqWHOkiBOK6s8PZMHZiq/o3/oSRfXybseTb02YY4wBM
	aATMBg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngt8968f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:39:12 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-244581c62faso4800545ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755733151; x=1756337951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvcGflOb4oHfrwRpsgfYu+5cxv3Vb3K+8uRpTdLXgHU=;
        b=xCdt9BRkjfYajUYMTt1O6SFOUlW8OlW6CBriNXXDKBCdniSoswmJBZZ1/34HqBOd41
         DpMba2YPkbTrggZMbPWK7emWJHgS8hbhN3Fcd73tHezc9bqR33eX6y1GiWSeNwu2VZu2
         BASe5QK2oESxvkgEv8ehMqaeLbtw6FLKOJC4xQl7dum0VexmYxEjHrvHeIRplQYN/JzN
         AYLDXrm3BBg835zSP2ALchn/xlecI4P3W9bFnPppd52whGOCH7r4bC/57jZj0+Uytui0
         CLzhQ4WYHMhnUpmEiz/B0jfPk7+gcac13HHbrK6/fKzMlnsjAdZ/gKVBYYoRhfmF9VE9
         w4HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeQVtg8C0Eo98wFY4UFkNIYWBUVKBkGk7AByVsRoYI38P2gQSaqSU2CEbGdj9K9Kbj8qJKFEa+1o98x04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX7/IDqiA6PVs1EyIBANTDKpt8QDwWjvxyIheVDueTmFPnS+qd
	/3pw2p5+8k1i3idMlLcSoRkiYVudeMogMOW2T4HmE8L3LnJpb6PP8D3XDBbMJ9GenflcQQZFk5e
	qHM1eO8W6vEllEL94jClpt+O1qPRTN7rZ4mzvgx6qiuzltnW+/LtW/3cTqW9oCzwHXmhLMf+gBC
	7J
X-Gm-Gg: ASbGncvsdCVfThTFHKgbUxfs/OkTtnshHbQcGSX/LiKhEmdj1tDcf8u0SHGn1k+lGbZ
	lFYO13FU53JrNqgeAlq3uN2sEYHZK+IQtpPg4/eNi36eijrAj+B7o+s4sfEuMygvNB+CyXEFgwK
	Wj7LTOEb8FymuLO1Va030hpUBEJCpq/JLKV57zKmYFEUQoD6SCSktk5WPNgR/p+CiOQiJlpgIts
	ACWBpthEpyud7+4MOu/yKqfk7GmEkIY6YhTpbfZTNCS1vJiZPmLMnevFSGs/1YfHMXLakaWq037
	90gVyZCNvkI5eBWiKGylEI2JgR0T6E8ZNZWdzzWFE2eAgs+63XM8F5Q/NusX6vYbVdzs5neaLJi
	l7zCD5zTyrX/Q/c6LXncvid0=
X-Received: by 2002:a17:902:db0a:b0:242:c66f:9f87 with SMTP id d9443c01a7336-245ff87a0acmr5982605ad.51.1755733150819;
        Wed, 20 Aug 2025 16:39:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJciBVPvgUAISLnaeCIDM3TBinhx3jI5VVAs1yjKKv+IWNyYEVSSEyv5G7WBqrbl04hMo4gQ==
X-Received: by 2002:a17:902:db0a:b0:242:c66f:9f87 with SMTP id d9443c01a7336-245ff87a0acmr5982475ad.51.1755733150316;
        Wed, 20 Aug 2025 16:39:10 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fbc711sm3233028a12.2.2025.08.20.16.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:39:09 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 16:38:52 -0700
Subject: [PATCH v8 05/11] tee: increase TEE_MAX_ARG_SIZE to 4096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-5-7066680f138a@oss.qualcomm.com>
References: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
In-Reply-To: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNCBTYWx0ZWRfXw68mwQvtMy9T
 ILvVPoJZU7b0bCcNf/VUdrDlBtAMtmfKzQhswb/GWNAODSouyJRmQ0kh/sou17kWmiqDd3MCd8c
 EMlYvRbiArt45/gGAEwc67IIBYJMs5ZyZPdux/+EbNrCxMH7gYaQCoNoC9GLetAbwzGfxvuxwgK
 UppGOS2bAllZ4OABO/qRKoE6qfza6xFzpoYl+mTB73GsgvX9L0gxTJrmFfw5yZHMhBqC7WLZb2r
 688DCM9rso2rpgWf7NhwJqhEKhhSsJDY1JxoxRL9zifzlfa+GygTlTKZtflqoCPURq1UMd/i2Yj
 RCaKeCnm5MGyG2dLtuN90zh5RPfRCgP1uvxmXuLFo6Np+gYfYdLfu2RyfCyJKuxISVw754Qw3Zf
 QfyP7Kn78VHhxYzcT/bEtCTxceWCZw==
X-Authority-Analysis: v=2.4 cv=c/fygR9l c=1 sm=1 tr=0 ts=68a65ca0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=JCP0Puskdh6qvuzBaLcA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: y1Nh03kuC87bP-v78kZYuvLm4gs2I9Yh
X-Proofpoint-ORIG-GUID: y1Nh03kuC87bP-v78kZYuvLm4gs2I9Yh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200134

Increase TEE_MAX_ARG_SIZE to accommodate worst-case scenarios where
additional buffer space is required to pass all arguments to TEE.
This change is necessary for upcoming support for Qualcomm TEE, which
requires a larger buffer for argument marshaling.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 include/uapi/linux/tee.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index 441d97add53f..71a365afb89b 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -42,7 +42,7 @@
 #define TEE_IOC_MAGIC	0xa4
 #define TEE_IOC_BASE	0
 
-#define TEE_MAX_ARG_SIZE	1024
+#define TEE_MAX_ARG_SIZE	4096
 
 #define TEE_GEN_CAP_GP		(1 << 0)/* GlobalPlatform compliant TEE */
 #define TEE_GEN_CAP_PRIVILEGED	(1 << 1)/* Privileged device (for supplicant) */

-- 
2.34.1


