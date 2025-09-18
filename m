Return-Path: <linux-kernel+bounces-765828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CDDB23ED5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529DC565928
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDA72BD5B9;
	Wed, 13 Aug 2025 03:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VA8EnZNh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7646B2BDC0B;
	Wed, 13 Aug 2025 03:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755054454; cv=none; b=OgiblNyNeCsX+cYJfN4Kc+jS0MNxDv8edsofDnfnsp5xdZc8iGiDzJqwV7/FBWCRpVKql5LM2S0wSUpyd4IMTn1Vr+OZBivOx6jYCcHASkv8QI3x7eejD6POQ9uv7cu4+qOTRE6ziJuCbSEyyDecH5kHXxiqCIKC21BJXSJOWC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755054454; c=relaxed/simple;
	bh=8Vglun/J9JxuRkbsyDVeU3zDZ2Kec2PO7uev+VxB14U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iiEFScY30+dFJchUrcFFePQ9Ubzx1TZQQPC0geNd8vR6XbeFiMihmhSWaOwR+C8ZV3G/b35VzepYMy7qLLdSpDeglwS0ByIhhRcLJluJ/X0hgX7zuNuf+C1LXeMhgan5N/hGbmTRREeHCObv7sGX/N04NoFjATpZTMM/eC1NB48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VA8EnZNh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CH6U9p010804;
	Wed, 13 Aug 2025 03:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mitqp2S0km2xrpzeQ4ZUDagOv4HpeKqLCHGW2C8hpsQ=; b=VA8EnZNhXmvoH+e3
	ytXQgwoos+hoIDhuXKDSfgKzmqjx9I5b/pbrgMEkVrWakOQwlmhSOEXmKvrhjuMO
	8DVJAu0a+ZlxH6wv8/AX8QKJ1N/Ss3oeR+fJpNh4duFuMiFIY8ldZmvTpQCJR/+T
	IEc77CIe+UWIUQyRvdsQopvw+RW8arcV+7PtMcl2L6mF4GaamkDj9sajuwNnGgC0
	YzcrGlWS89da5hjtbtqeM1MKA8W8omAv1T83N9pScWleTp/HfvDH+OqlU088+z8T
	4TBYjUIfJt7ZUyCxIcfsH9Ke6C84Wo887LuSugSPzrmTuVpdIsQLMRgxP6xb14i8
	vVx4UA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g9q9sakf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 03:07:28 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57D37RkF028432
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 03:07:27 GMT
Received: from hu-lxu5-sha.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 12 Aug 2025 20:07:24 -0700
From: Ling Xu <quic_lxu5@quicinc.com>
To: <srini@kernel.org>, <amahesh@qti.qualcomm.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC: <quic_kuiw@quicinc.com>, <ekansh.gupta@oss.qualcomm.com>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Ling Xu
	<quic_lxu5@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v10 5/5] misc: fastrpc: add support for gdsp remoteproc
Date: Wed, 13 Aug 2025 08:36:38 +0530
Message-ID: <20250813030638.1075-6-quic_lxu5@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813030638.1075-1-quic_lxu5@quicinc.com>
References: <20250813030638.1075-1-quic_lxu5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=CNMqXQrD c=1 sm=1 tr=0 ts=689c0170 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=VHSkhjcgKWVwXbDC_XQA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ILp4ZGVfUbTGNbc0tLNQJzGvB7q1-m_e
X-Proofpoint-ORIG-GUID: ILp4ZGVfUbTGNbc0tLNQJzGvB7q1-m_e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfX3r+j3c9m+cIq
 ofxZRw8JoMWfBJko+HHMY1OslS4C3+lxFanq2r5IWaFNajIJWSQcj6bZYk5u0EW0575DjG61OIu
 3tAACHaO18nCXxRU5lAMo3VlvY5eRdMh3ajHjDDFW2T3ik0jTmjC/TvTtctzF4rMJ1esp+mQZN+
 7MbUd1Dy4/dxRqHwRv7pgm2Z13CuPmfY0UJUMitu977IfpzNyQrXEtlR3tV1KLwyJAXHV5gvZXc
 ufpd0UxXpB3UNavgovWP3jlAS43zqVM9GGIVVqucerlNFmh4U1WpocNMXyrzoA+tB1lVHLRXclr
 NA7Uoqao/9zxW5iyuP66LxX0LTuUYO0a0rGVCszaCCcR2TzENxqnX6+7VFZgOLHxVdKeN5SQHJq
 fxQgpqXz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164

Some platforms (like lemans) feature one or more GPDSPs (General
Purpose DSPs). Similar to other kinds of Hexagon DSPs, they provide
a FastRPC implementation, allowing code execution in both signed and
unsigned protection domains. Extend the checks to allow domain names
starting with "gdsp" (possibly followed by an index).

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
---
 drivers/misc/fastrpc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 5fc7dec65ed8..8e1d97873423 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -27,6 +27,7 @@
 #define MDSP_DOMAIN_ID (1)
 #define SDSP_DOMAIN_ID (2)
 #define CDSP_DOMAIN_ID (3)
+#define GDSP_DOMAIN_ID (4)
 #define FASTRPC_MAX_SESSIONS	14
 #define FASTRPC_MAX_VMIDS	16
 #define FASTRPC_ALIGN		128
@@ -2249,6 +2250,8 @@ static int fastrpc_get_domain_id(const char *domain)
 		return MDSP_DOMAIN_ID;
 	else if (!strncmp(domain, "sdsp", 4))
 		return SDSP_DOMAIN_ID;
+	else if (!strncmp(domain, "gdsp", 4))
+		return GDSP_DOMAIN_ID;
 
 	return -EINVAL;
 }
@@ -2318,13 +2321,14 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	case ADSP_DOMAIN_ID:
 	case MDSP_DOMAIN_ID:
 	case SDSP_DOMAIN_ID:
-		/* Unsigned PD offloading is only supported on CDSP */
+		/* Unsigned PD offloading is only supported on CDSP and GDSP */
 		data->unsigned_support = false;
 		err = fastrpc_device_register(rdev, data, secure_dsp, domain);
 		if (err)
 			goto err_free_data;
 		break;
 	case CDSP_DOMAIN_ID:
+	case GDSP_DOMAIN_ID:
 		data->unsigned_support = true;
 		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
 		err = fastrpc_device_register(rdev, data, true, domain);
-- 
2.34.1


