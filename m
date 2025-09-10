Return-Path: <linux-kernel+bounces-809186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F984B509C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853DD441B88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570701E3DD7;
	Wed, 10 Sep 2025 00:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MVwYk8PV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AE41D9A5D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757463093; cv=none; b=havD90inxf8WG59QWOeTZBQOMtO/2i03d+Ck1h/69D3EL4FmyxFt9mcHaykJ8velMvK11Glc6GoLRB+KTcz+1xqYtcRB+zMUDdaJoYUK25So9rr8b5C76EeYGA5rQWDFZL/k2SWsK88vWaXktkOpgUe4nNma3e1OXrf9reLYKTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757463093; c=relaxed/simple;
	bh=2jLp+9owgiqgZBOCKFldUxG3+QmUa/8reLXIFzBTr08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SbBfVIAl5Gzp7jcH+JmGO3p2GdhSwR6hPUIR6LkyZK2WEQvCymE7/3oQNLII3vYV6pDvunBBLTk0TTWysQ3psBFpiEg6kkr0e/SHiBvYLMISH0PM4joc7isTpctwMA/EiU4Vo6oDOQi7Lj0qH9qqxGQxWFuxAqVvTqovlh/Ub6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MVwYk8PV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589HKIJm020175
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	83fAnkrveK9gQC9R/+BmmA0iOQTFfDns/UdMTMdybB0=; b=MVwYk8PVhFe5OTTR
	osJ8zYtkGNaKwQapy00sM8Me340JBh+tbaODTgTWBD3k0+g2v6M8QxKUtoiE2f2G
	LqaDTNrjPeN54eJcCPBBLNNqXIt+01tV6r5Z+1VwB71CTFLHCB+KzzV0N1IXrm/H
	EYI4T9qb3uK/XGZh5zGsqAF7HJ4yJc1n0Dy8Fs0Z8gKYGiyK8tZXvMoeMzg0eKsa
	Vv7AJ/1a+jc7FTS9/YlQ9L9DgGHwg6i3SlfEaX2ugoCy5zJBkIoTJpBsah2OpOam
	6PSDLOJV8BBxfSAH8qxPU+43+dFBPBxUaDwbw/CSuL5SpYXnUROzpcPOuXy49NCl
	E6A31A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc2622a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:11:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-244581953b8so70844765ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 17:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757463089; x=1758067889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83fAnkrveK9gQC9R/+BmmA0iOQTFfDns/UdMTMdybB0=;
        b=Iz//fCKyrmt4/gojhkfjeLvI/eRHkl1vt/MYDZKed0Iqkocxa+K1bmuBPti9RiUfTV
         XmUSm3+3vQVptnCtznv9Iq4y4fmxpvkxWcwbUdr0QBZOWvtjlFbOGDPNtfLrWIgIqa2y
         AkEGKPNIols1dpAOLBzxOZ0hzeq6EPooBjMusSCoirDMpLbox8V0KRi+iBvA0Bn+m47B
         PLWEV0GI+Dok2sptjY/8NPm9DSGGjJLHVe6LC5YRCVm7GRs3l3rYJccNgesTahvErW41
         Yn0XT09iF9rV/uekH/DRAQgeD/fKqiSZzFIxZjAUvqBEqglN3yML2Z2EhyyJFhzTjb7Q
         e5tw==
X-Forwarded-Encrypted: i=1; AJvYcCVLYXhBnoqlwJnEXVPUdwS8Lhum2nwF8WNxL7D0MkXrpCEWaEbxSToYWpDkx6bAMpfkLvpOOm7fd8A4IPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztEMeVuiNSd1ckRehkzK5ZT9opgCoQiz2SMkAX+2de9MIua7D/
	ZvUqeYqxih17GW/eD8TjVtAJ+wftdJZc8X147LJGRqQA94bDU2BrXYZ8cghnA6+LySe3mgpCzfU
	K3boFTqeWqUIWeFkCVFJdfrWXSTxWPHzK7V7fZc5hCom478VbkPwk0dqxJLL5u6GiUg==
X-Gm-Gg: ASbGncuPtevipH43UUZYtaFL7c4q7XooTN2LQjQjezu534kOlL+UTmRfGjK3Y0S5hjF
	2nq+DIgKdKaMZfzjt+eVlPQg0LjojdG+0QVRAXQp0ha5kNAN5FK0VFvNf+nXQqepNqdYcS+dtti
	dwxPjYgxzlraCT5PI2MRfIWzKPg0RJRVBplvYUY0NqZu0RYxdmloRr2smnNel2IwU8/MkmBmotc
	drxbUqkTPAdh+TFiaYCTBc6NpfJAEHnG41hD8buqQgwddSWDba+SXcf6xPe7lI3A9Fy7FtmFFa6
	8rkpgRCsoNSLt2bNq+ftSfdHIX6iZzD0jDLEdzBNlGIkVhFaijme0pEapdAVp4pZIIwZnFkxkpu
	gAoSwJPT2nt3AicujLhTrhfA=
X-Received: by 2002:a17:902:cf04:b0:250:1ba5:b207 with SMTP id d9443c01a7336-25175f6e7c9mr196375695ad.59.1757463088833;
        Tue, 09 Sep 2025 17:11:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwv4U/CQ0DLFLSD+hMaG+/IFah4m6GULCeF3UMTUtfOmP+rVq3Sj4WE3bpGNjpxi71sWc8iQ==
X-Received: by 2002:a17:902:cf04:b0:250:1ba5:b207 with SMTP id d9443c01a7336-25175f6e7c9mr196375195ad.59.1757463088335;
        Tue, 09 Sep 2025 17:11:28 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dab6bb655sm1285672a91.10.2025.09.09.17.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 17:11:27 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 17:11:09 -0700
Subject: [PATCH v10 07/11] tee: increase TEE_MAX_ARG_SIZE to 4096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-7-20b17855ef31@oss.qualcomm.com>
References: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
In-Reply-To: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c0c232 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=JCP0Puskdh6qvuzBaLcA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: bQeNAXkGKihL-q2-Q-LSF4dznXv_hLZw
X-Proofpoint-GUID: bQeNAXkGKihL-q2-Q-LSF4dznXv_hLZw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfXx4ai7JBjW+HG
 sGFwzNwgQRt33fsIdlgGgSwX8IXnJUXM8Vo0NIOQ/Dwqw+KL1z0JrhIIl4nnSQzOcY3IMu1Ol/k
 +5lhXKfP/XoYSC47K8l2MqbEE7YlwZAnexChCsr4YjxbmcT+bUifjEWOIAZ7DVvyW6BoQvzErZs
 brQtrYR10NXjV75wQIyOG4JjbeBvP0wyF1zy5xJfJkuZIfpwXHbAy2otUgp00vSx+ltIGrFDTAM
 BVcLMbYj24OQyD2JdGjxvaEJ0gh+ZBdK8f29EA64/Yi76gLwoef64VPCb8HcbRceNKbf13KhKE+
 E9ypyWyqKszvoRjVsuGSvrTo5Fn5X7bGQNffismYA1LySIJXTUPgtMxhfySFijfi7IfkU+N9lCB
 ub+oyER3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094

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
index ac455683ab5b..5e393080fda1 100644
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


