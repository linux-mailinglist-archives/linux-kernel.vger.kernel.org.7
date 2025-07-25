Return-Path: <linux-kernel+bounces-745588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C991B11BED
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4B9AE124D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005C02EBDE7;
	Fri, 25 Jul 2025 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dDGqPA26"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A2E2ED152
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438139; cv=none; b=Ck1yoBtwj7xZCMQsIxGGmkbt3MgTiQmqjwhIvNHRZ1otz9SHnONeOpPxsq6fVHA6wa0YP/Vni0dUbEDWgNPvyapaeVoHXR5BbHqhvl48gfZtxKMOS5hZ9aukOYG7oPBF8rjdXtreh/5VB/RJTpUOS5SraR5kugs3xVrJU+Zf7RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438139; c=relaxed/simple;
	bh=fAvEZEfnC0duLlCPJAnL8vIZOsPr1irgS62lUUcRRg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZOUC0vCNIwK3+3c4UIc3XtRzm9Af0zB2+1FZN8HJkQQGoPuVw2wL4eek+nxSlU8XQyR/oEKmJrwHop5qHJv4Hhkp0S58/FT15dN4oCUWajdAoXEt0fukaA3cs8SpwEV6KYPbHys5nSqdIxaiP/I/qczDfCBZif2wGYf59uk6tM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dDGqPA26; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P945FO009485
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DhH78wvVJne
	tmIHm7XhAnpQBOngftYw35LXwtkDO8nI=; b=dDGqPA264qfjWe05++5irJPMsf7
	/7H0+Xmci3J3XTMBFvqsFXljfhVWyOdvyhJ0WLZbQ0Qoq58CHXIJUu1mtlBI5TJA
	TkZIgX3fqVQencKXO9IvnkLswiwohQc8O5eEq9R6Ax8VYQdllqh4Bs+dQ0mOnijY
	My3IBJgTXwOSYDOvHwrTMU2e9Ivh3zqAVoqZ6xFAhPHQBaFH6oW2m7GTYwKiUS7G
	R+8RU7IEEhtn/ove6BE9cySDHd3Os96zPVB+NokU5+u/loxQh8Y2eo4PUzhOYYOq
	91rZEUeuDandHHsZJZZaHNzEZUAMNx4Uy7c60lIJYZ1j1hnSXOn/Qrv+C8w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2t1nkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:08:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b31bd4c3359so1269288a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753438135; x=1754042935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhH78wvVJnetmIHm7XhAnpQBOngftYw35LXwtkDO8nI=;
        b=G3iVE+a3w21S8z/8uCilYvfUHajuENNtvnKUB3FiApjHo2t0ru8vLF8H7Uq6zkkQRE
         KSXSTg00dlaQk2iRrL9HGd3W63/7PvtZqwDsUDOYjtbObFNHYM7cfjXuJBJe1gtkiOJ6
         HShXUtJ/wjwGdDhYqYDFE7LDBcxtkrj4/PXOX0h24i6j1HRlW7iVRVzM+uIIpK64Egt1
         xelcg69jfnckZ2HGAPGKtBbdaxipkVP8Yp5xsj57qFGPZt12oPkncdlzzoj1Vx/5rSKQ
         jbyqBqHouXjuyXHVAtzEzrxWc6cY/xtLtMWwRP0wJLTN6VKQNLOoNGgA/esSGFHY9rqv
         I+pg==
X-Forwarded-Encrypted: i=1; AJvYcCWWMMGvBVJKsrjHP19HcJcg+9xJHaFoEArB9N4RMmFsOhfLuwjl7I13yfexHdtb4OHDONlSgq1gIhhPYg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvFB9tt6OkTciY+HbIAK/c5hp6N76pkEaJz2IoRII0+D4IbaVf
	c9bGLOF/QNJtNKA3lVEFNV+sjbaynTDTHAKhWY35RC8Rq8EfM7gJb3MXMTHaxFYEjJnG8j7GkN6
	pNaOO+VNFt7gOMGUhCjghQUDEms1+MrfTfa/kW4gQuhEwM6IeDgEmbuB2FInwkyAtbmc=
X-Gm-Gg: ASbGncvsVu9qcsTcZLY40CBGhaI3YmpobjLtKwSFrhyJHoAFPtmkTCwLPiI33Th6qUE
	lX0j0mDPTIP6aKcBJED9cYlVDuag5T+oafN2kVQl1MFYDOAx9AIIlnYa0JMsNrq+4T0xABTn9hG
	o9xWF+VUQ9jKkfzDkWwDE0uJQ/2jVGm/RxQ+hZgDxhjsU5ozutWaaERzUPg+zKTbL7VDTBDD/zw
	zSOLWnUipvg/kg4+FRKjeyj/8FViiUrWTmGeBHDOJ1xZIIFYYnLU9K+l7tUw7hlRKexIRXvwfqH
	TZw/suC6uxox8MVa+C2JnvF6Qt6o+YzbKsKD2gA5rXEd4Jx39rHlBvA0bsA05T4Hi2z/6yx76Nz
	wtVHwSQXBJS0VvySka3g=
X-Received: by 2002:a17:902:da48:b0:237:ec18:ead7 with SMTP id d9443c01a7336-23fb31252c5mr25667095ad.24.1753438134648;
        Fri, 25 Jul 2025 03:08:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFemnJCAQcuNiBKQLUNas6+SmLXLoOyi8PGRh2U3ofwYuo4JSUJBC494RK9BYtmkiq21Zv5ig==
X-Received: by 2002:a17:902:da48:b0:237:ec18:ead7 with SMTP id d9443c01a7336-23fb31252c5mr25666385ad.24.1753438134050;
        Fri, 25 Jul 2025 03:08:54 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48fd29dsm33641435ad.176.2025.07.25.03.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 03:08:53 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Gan <quic_jiegan@quicinc.com>
Subject: [PATCH v4 09/10] coresight: tmc: integrate byte-cntr's read_ops with sysfs file_ops
Date: Fri, 25 Jul 2025 18:08:05 +0800
Message-Id: <20250725100806.1157-10-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725100806.1157-1-jie.gan@oss.qualcomm.com>
References: <20250725100806.1157-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BMKzrEQG c=1 sm=1 tr=0 ts=688357b8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Zpm-vmsZ5HaS-asNi4kA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: PBNSwD8bB8JDI0kRYFZS02VRoKgYI3GL
X-Proofpoint-GUID: PBNSwD8bB8JDI0kRYFZS02VRoKgYI3GL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4NSBTYWx0ZWRfXy9wEyhAzhLt0
 k9LZ6MgS8z4qLocgha4ZWXceQKEVrz5uGAtnl0a+Y+Mk4gj1OsaZ9LXX0GaLlLg0kyxmRRStjxB
 mlNhxTCK4PZYHu9QnlZY7AnMR10jYeUrEO12pxnyPPs+jtiJWwpl1aBayD28NaUs58to2IlPmCa
 OAPtpwxJum/B9yXlJF9SWyk/RUHRu1ktDamrusOtY7OleIoPudxly4NIlCF3FQYBfQvejnl023Z
 z+sdUZ11B6nH2ydrigLA/mD5sIjGFGhez1AzUc3KcDNz8NMNrHLx9imqh0hIqoHWNW78q2yImRD
 mOfDxWLhkDCTLKUQ75MJG4JYlnZQAbD5rNeBFsC+x04T/4JfWoOEonVWyJr/q/1gsGq+lQuTB64
 mwZ53hVbEYpzqflZSY44HLcr4d91Kq2hlCisAOv3ZXEPalT+ILdrZRRweA/YdVbXZepk4yhE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250085

Add code logic to invoke byte-cntr's read_ops if the byte-cntr
is enabled.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../hwtracing/coresight/coresight-tmc-core.c  | 48 ++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index f668047c5df4..671ae4542f6a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -228,15 +228,41 @@ static int tmc_prepare_crashdata(struct tmc_drvdata *drvdata)
 	return 0;
 }
 
+static const struct tmc_read_ops *tmc_qcom_byte_cntr_in_use(struct tmc_drvdata *drvdata,
+							    bool *in_use)
+{
+	struct tmc_read_ops *byte_cntr_read_ops;
+	struct coresight_device *helper;
+
+	helper = coresight_get_helper(drvdata->csdev, CORESIGHT_DEV_SUBTYPE_HELPER_CTCU);
+	if (helper)
+		*in_use = helper_ops(helper)->qcom_byte_cntr_in_use(drvdata->csdev,
+								    (void **)&byte_cntr_read_ops);
+
+	if (*in_use)
+		return byte_cntr_read_ops;
+
+	return NULL;
+}
+
 static int tmc_read_prepare(struct tmc_drvdata *drvdata)
 {
+	const struct tmc_read_ops *byte_cntr_read_ops;
+	bool in_use = false;
 	int ret = 0;
 
+	byte_cntr_read_ops = tmc_qcom_byte_cntr_in_use(drvdata, &in_use);
+	if (in_use) {
+		ret = byte_cntr_read_ops->read_prepare(drvdata);
+		goto out;
+	}
+
 	if (drvdata->read_ops)
 		ret = drvdata->read_ops->read_prepare(drvdata);
 	else
 		ret = -EINVAL;
 
+out:
 	if (!ret)
 		dev_dbg(&drvdata->csdev->dev, "TMC read start\n");
 
@@ -245,13 +271,22 @@ static int tmc_read_prepare(struct tmc_drvdata *drvdata)
 
 static int tmc_read_unprepare(struct tmc_drvdata *drvdata)
 {
+	const struct tmc_read_ops *byte_cntr_read_ops;
+	bool in_use = false;
 	int ret = 0;
 
+	byte_cntr_read_ops = tmc_qcom_byte_cntr_in_use(drvdata, &in_use);
+	if (in_use) {
+		ret = byte_cntr_read_ops->read_unprepare(drvdata);
+		goto out;
+	}
+
 	if (drvdata->read_ops)
 		ret = drvdata->read_ops->read_unprepare(drvdata);
 	else
 		ret = -EINVAL;
 
+out:
 	if (!ret)
 		dev_dbg(&drvdata->csdev->dev, "TMC read end\n");
 
@@ -277,6 +312,13 @@ static int tmc_open(struct inode *inode, struct file *file)
 static ssize_t tmc_get_sysfs_trace(struct tmc_drvdata *drvdata, loff_t pos, size_t len,
 				   char **bufpp)
 {
+	const struct tmc_read_ops *byte_cntr_read_ops;
+	bool in_use = false;
+
+	byte_cntr_read_ops = tmc_qcom_byte_cntr_in_use(drvdata, &in_use);
+	if (in_use)
+		return byte_cntr_read_ops->get_trace_data(drvdata, pos, len, bufpp);
+
 	if (drvdata->read_ops)
 		return drvdata->read_ops->get_trace_data(drvdata, pos, len, bufpp);
 
@@ -300,7 +342,11 @@ static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
 		return -EFAULT;
 	}
 
-	*ppos += actual;
+	if (drvdata->reading_node)
+		drvdata->reading_node->pos += actual;
+	else
+		*ppos += actual;
+
 	dev_dbg(&drvdata->csdev->dev, "%zu bytes copied\n", actual);
 
 	return actual;
-- 
2.34.1


