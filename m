Return-Path: <linux-kernel+bounces-884786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D60FC3123E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361FE18C0B67
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9582F7AD0;
	Tue,  4 Nov 2025 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pTIYGCDz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LPzud6i3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B8E2F3C01
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261768; cv=none; b=AqjkUWGPmoLBKAah83YVSsDBam7SIiP1fG0e3oI8UfQiaYnJRsdehcqI6/fu8MhEASc3kLbHm3tYMubghTkBnZnQpwLzp+rMI8MvwUKRejfnDFMJmzEfGTHhuQSUAC0xHDw38/I+ptg2h/2wWlq988xzpwuXoHwN06uO2ASy6tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261768; c=relaxed/simple;
	bh=Asg/iJSgjm3YQTmWCSn8+JiYS2W2rTC2HwWxNlCxi3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k1QhDJqfaxKmEEjJjVwEMsVCjP59Ru2YADeJoUwywbrMsOpadRByYwtUpcsDzxkbXcSMdFg1AFwbsuA4xHXCaXSrFaW0zchlk2UvOX17C4U2DF+LjqCtidYwXokrTW25Uly7eo0Xza2+Vgp8ahVH82G+QJ9NU/UVduSeCmEsdDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pTIYGCDz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LPzud6i3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Cg0Y21937143
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 13:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=d0I41zXVausv5x03E05uNhQb3YiVj1PVmvz
	BDI/6lN8=; b=pTIYGCDz4wvxRohUf9X+tNAzA0yKxKFsz1fM/CLkzQWWdOnkV41
	QLD9yHzUNFZKcDB6/GGaXDcTc1AvSY/POVszZQy6CFOBOz60Sp46VrXv/E/tkQRr
	t7qaH6nhTulD0T9JlTdPp0gJe5TVhIePWUpM8pBAeHDfGZNnf225u5OXnCA9WD5X
	SqTG/axSgjle/p9Ps7rXugWf4e38wogOd5WfY/E1Mnu1GWT0c0u9Vj0bYwZpjzzE
	mt74hMC5KXxI5rryzFcNxcZto5CD7ujeH/EZqzwQ6jrOGD1ob2p63Ml6pY5K8vd+
	Hv/soYJ+Ygxo350K12DdRi+/U1MR4vzTvQQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70fhu05t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 13:09:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2958a134514so32031425ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762261765; x=1762866565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d0I41zXVausv5x03E05uNhQb3YiVj1PVmvzBDI/6lN8=;
        b=LPzud6i35SCKK2V9Ysex62HsdeO2VW/GcL/RytVj26UYfsry1Nhky3W3/U3mWRGj9J
         ob2Wy6yYE6rT+W4RzKvzoBk+sEJPBKi13onXvXqwL44+1ITPzgQmOPkuTo7ES9lrgj1s
         Pli5TJNXqK9sZu5rxvUrPhGEF1cWUE7FmFZ53n6PYmBEahiOqOM2d3CBvtMNDDKdmMi1
         0zNPLMQiHj3VyckmRgIyQVKZ95NvRjNUvGdX4qV35zTB9xUSTjCPIAxbsGPlfHyvDKaC
         i42XjxmQNzHTo7atcTTm2sRpI7DyZbwiozcNFJ7zped61TTh+z6eI+BebCwB4i5e+NNk
         1NZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762261765; x=1762866565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0I41zXVausv5x03E05uNhQb3YiVj1PVmvzBDI/6lN8=;
        b=vlFMs/kGS9KidhqcE2nSB9EG+OLlRrFo/feitr3+OWH55SwfHDwa6RCH8e6gJLZOef
         F+Mguo38HFmJ81suivAksETraWNHCzo+ijE3K+qr/GL3HdjZLMdF0UL1dvMgGO07f8ir
         Q7oXX+a6Z1a5X5T7XcZ8eu16WlaF45sDdcKUFllpSNN5Rq5tiV2pP+aR95FWSEdAxtpj
         A7+H+2IG7e1bI2SB1zRfufi6h0PZNsPLgk8tjqgw8YzYX3HZbBtzPkAHnZ2wOHmyKSDl
         ELslmshx0wS6FEh9htm/sNbEcdHqihQSSQk+rfsP2/abnJlvcl6JOFOpLLDN426L5nb/
         mIaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnlRZ8EdSt1GRB2huConaiCRhSA2rpld/Hczwxvbr91NCKPqOEvTX3DLGCgSmVOLqnb28Lv6BjBUwtCCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8jcQuj9JGIBkVMTWqlFSrK5y5/PxnOUZuSjjxPJQ3ihvMQLZJ
	wMGl/Zl9zgSwfnHU9ldSEzCeTkSNUd/O9f1xKM563E0sfYxUZkMgkUu4RgaWC7x5zvH1JpBX1Gq
	2v2tseuKJ6Vn92kDlleiB67t7QjqrN7W1lILKMuI2VTlQOTS4sncgFy6Bpkyk6d1DE2s=
X-Gm-Gg: ASbGnctJXB5CJ5NfdKIlGGaSu4JsX3ni5Tc5l8ZOg3wl3LG4uP2Wgh4598iS4LlowLb
	1+byjTLY6xfGe7odkXYvT0aDBssJd3PV/c7tjvAkEczKdVeiWa011ilt6dmsUZJcZKEw9aH2b3F
	kkSkW1a/R0ukls1rFtE9WYkYOuDFPZcDTeWb99utbpDHeoWijbHxb4V9WP/d4k19h7Dq1BAGRzu
	IdL7uSuzTq/R+0UhQwuLgrryoIrgHlIXEDFvwaHa56iu8YlKJXZbd7dkgjClKfSwEiHCo1Dq7C7
	dH9cis6X8VL6RCRx5A2+UxGLmzlRGHpVnfeFe2Y8O7bM5Hkqn8dFHFyd7BHYJwy8CXBlZL5pzWt
	kFr4OHQCa2HxCDssHfntsFBX1Tg==
X-Received: by 2002:a17:902:f60d:b0:295:ed6:4625 with SMTP id d9443c01a7336-2951a477a1cmr218785725ad.47.1762261764886;
        Tue, 04 Nov 2025 05:09:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhX8EMTM4gxgs+EOabroVGqDSuGRkIfqyGoxq9BUvt95tGdZNhjuQqp//BMHsw57uSUC7kqQ==
X-Received: by 2002:a17:902:f60d:b0:295:ed6:4625 with SMTP id d9443c01a7336-2951a477a1cmr218785145ad.47.1762261764237;
        Tue, 04 Nov 2025 05:09:24 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998c3esm27105855ad.41.2025.11.04.05.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:09:23 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v4 1/2] soc: qcom: socinfo: Add support for new fields in revision 20
Date: Tue,  4 Nov 2025 18:39:05 +0530
Message-ID: <20251104130906.167666-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEwOSBTYWx0ZWRfX3oqdqoTRbBpx
 2Kkillwyr9S/IhEn95VVAu24i6014YZHoOUOz0JRnIM7SF46ImYNSNP1TDyg+91e4r6MN7dK5jv
 W+UhWvBQK/71FziXRIUF6k+mKagNrlCCjIyGHc7BdsekG7LMRI660vGMjoxUd9Vl+RFTR5F1RbQ
 s7oN8vTL8hyGWXH0LDc1b2GGqEP/NOyy1dDdw9ukgkB1zIUsJT1HLP8BWt3fONXCgVgXqP7fT4v
 Wh21otjq45oJqZ8FIIH5wvUfBNuk3rXQUiK0ft12Z9ddXr3nFojk4SKR0+WnoWA3MFp/8W5eTo9
 Z2qYERdAXVSBgEYnI3acJqKphf+LQ2Scm7ZVjsW0ufVkrJe0v06ubIJgysecRnwcHvWSgXcytZc
 6dGPzO60tTfqWxb5nruuTFWO2zGtkA==
X-Proofpoint-ORIG-GUID: y829RfXyK2xxppdQL2QW1xbdLB9LRmaR
X-Authority-Analysis: v=2.4 cv=CbsFJbrl c=1 sm=1 tr=0 ts=6909fb05 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=zoRWVKxRGUSOgPgIeVcA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: y829RfXyK2xxppdQL2QW1xbdLB9LRmaR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040109

Add support for socinfo version 20. Version 20 adds a new field
package id and its zeroth bit contain information that can be
can be used to tune temperature thresholds on devices which might
be able to withstand higher temperatures. Zeroth bit value 1 means
that its heat dissipation is better and more relaxed thermal
scheme can be put in place and 0 means a more aggressive scheme
may be needed.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v4:
- Added Rb tag.
- Rebased it.

 drivers/soc/qcom/socinfo.c       | 6 ++++++
 include/linux/soc/qcom/socinfo.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 4fd09e2bfd02..77d0b8062208 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -195,6 +195,7 @@ struct socinfo_params {
 	u32 num_func_clusters;
 	u32 boot_cluster;
 	u32 boot_core;
+	u32 raw_package_type;
 };
 
 struct smem_image_version {
@@ -656,6 +657,11 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 			   &qcom_socinfo->info.fmt);
 
 	switch (qcom_socinfo->info.fmt) {
+	case SOCINFO_VERSION(0, 20):
+		qcom_socinfo->info.raw_package_type = __le32_to_cpu(info->raw_package_type);
+		debugfs_create_u32("raw_package_type", 0444, qcom_socinfo->dbg_root,
+				   &qcom_socinfo->info.raw_package_type);
+		fallthrough;
 	case SOCINFO_VERSION(0, 19):
 		qcom_socinfo->info.num_func_clusters = __le32_to_cpu(info->num_func_clusters);
 		qcom_socinfo->info.boot_cluster = __le32_to_cpu(info->boot_cluster);
diff --git a/include/linux/soc/qcom/socinfo.h b/include/linux/soc/qcom/socinfo.h
index 608950443eee..c4dae173cc30 100644
--- a/include/linux/soc/qcom/socinfo.h
+++ b/include/linux/soc/qcom/socinfo.h
@@ -82,6 +82,8 @@ struct socinfo {
 	__le32 num_func_clusters;
 	__le32 boot_cluster;
 	__le32 boot_core;
+	/* Version 20 */
+	__le32 raw_package_type;
 };
 
 /* Internal feature codes */
-- 
2.50.1


