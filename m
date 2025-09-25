Return-Path: <linux-kernel+bounces-832273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CB9B9EC9B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B1D2A6581
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009692FB97F;
	Thu, 25 Sep 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nRkrYaX0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A652FB60D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796981; cv=none; b=EPsf6PirBDwndpQkhZtJiEJBqWW7/2hu9/1+EJPYnKaosuCWcRF5riKIrB3kNQITaqlEgMB96MnUBWYvlvbD/FlMLm6rSNg+vHdA2Y524wyfsvxTpBOk2ezCQYGsikWzK7XSjbfuU+jw3PcHVEUzrwZdHuTRHgBdyq6S9Ox91CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796981; c=relaxed/simple;
	bh=/5pkXjPpN0sngp2+34OymDrtqBNoNX+U7d/io6qp5Es=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+uJgoszKow8duXbZjMgL6Xh4JG0Q8LF901rNrDDtD1eldA34ru4FGgZy6qwE11KrWzgd7ELoqGc0rzdsrYMnRKAZxyxnpu6tGxvhUtaN+OLSu4bDbz49CDXFE0BkU3tGs9Gf3biEP8BlpJej/TrJh5Rt1VwZdxXsVO7eGq86j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nRkrYaX0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P943Ee018678
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iydgY1LUDTo5t6BA4ObGI8R41OpdAyNguw2a/tO9Pqs=; b=nRkrYaX0ccm+54Gc
	xR009GHxidyIx+sqYaaV8OCNgLJKyVp7yyS6spKnGID/LTtNgbbi9WMOf19sQLS9
	0UtSri5YorUNZqKjA6efgsfCj2tWXKbSs+cGjLvAnJjKuKng7u58sOyk3YpyIYRW
	DBSTNbZzAzKlCnf8fj9Ok34j3yy71k/JrM+0dHJyZAIgaH7MtjxRQ5k6sDy5V+7i
	LEknfjsbx/sIw2tFedPl06VqKQu9XDX4IwYGZe8i7HZtm3IVaBGkp9gTaWTp5ynp
	C9BV2NQMEZ884DP0dzBQBKXp2CWcJhLQhaobHoVo2wxyjW1x8cvFwq0YsMKZoslP
	qUfjAw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kkbre4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:42:58 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-26985173d8eso14592305ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758796977; x=1759401777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iydgY1LUDTo5t6BA4ObGI8R41OpdAyNguw2a/tO9Pqs=;
        b=o1K+Az2CNs8w2WmSyBdnq0++AOG8V5AhszZoUCxUjbZWsIaPeYsXQ3KppbCABdoQ39
         4Yy+MZFhb9qEp3AlVG9QtBHWnjKhVZjfE84xfp5bR4gpz4Cs35l880JHR1P0UpJEbSkH
         6FiUUME7rutDYPjlEZQ0XsZ5tMzJuZA0zrJK9umOzTdUNK1j5TJwOyylAq1TgrxsL47a
         Wv3V4bXaerfnwvqfSPWXE8hOXD5aMx/4sJtSJ2Qey49StCFpRm7ak5PaQq31Dgst0GIz
         n8l7lVnYVIHPBZifhQocSroLYIUpnB+Af/xDIQR1a0pt3d7/4zIFIDVCAtIF4iWVb8aG
         FQAw==
X-Forwarded-Encrypted: i=1; AJvYcCVbBpxPWA9ou36PMRHINO4n4yG73r3ZkyF9J8k9KNt0EwJCbLrrGkmIniYwghzo3ystGxINP4U0bSWcIeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcijLptInjdjFErRCYLNX3MZlfKpDROyA5oIAluwG6Bx+jN6o7
	TesY4VJNQihCrU4JPdDuoVAztRWC42dFdL8hTNH9peUF/zMNMbtenT83FgVA7d1RGsDPy5uzS8S
	dNuOgnycA+URIXUfkzaRimMzrlIhquP3iiEGsbxH9Uv5DVcohpHuRTS1e2xqW/uxRp4k=
X-Gm-Gg: ASbGncsXpBd4Rv+qt3uyuIBT1rpB/4AONPYr4CmvPgMQNpXH6cWxBc5T3R+1oW2fRQI
	97SGuLXoD3xXlQqZ0vx3/KvTrjUzR4es76iJA9EDPVP1X4ScIdiVpZABTsEbs1cd/wZ4UtMFe2n
	SE4P11olUVJrrc/RerqPaeeuXsQiIhECp0bUZsfZnC7UAYV3PpBtGhH7Y8E1ODe0TGmHyQjVCIq
	0kF985ngvRK3+iNkmEDX6nGPhjudhSjnhr7NNusKnHqMYIGHiyWrQJoV/2KhKMJpygMfV3L1TwP
	yIR1YVJS7QnUWUTN6Im6GVS5TL7YN/Zz9nvKNMhkeX0ru6TYDAkEnhAX1D7A6CrV2nmntvskLDw
	RT988dms1uvitD8g3IiSdYBT01w4=
X-Received: by 2002:a17:903:b43:b0:267:776b:a31a with SMTP id d9443c01a7336-27ed4a3de4emr32276685ad.29.1758796977376;
        Thu, 25 Sep 2025 03:42:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxKVDsVMPULyZ/DU5Ie+q6w5upoknAYNtCbzBGaI7SzJWJ9721tGfRbvvNYwecSStc7+vR7g==
X-Received: by 2002:a17:903:b43:b0:267:776b:a31a with SMTP id d9443c01a7336-27ed4a3de4emr32276355ad.29.1758796976753;
        Thu, 25 Sep 2025 03:42:56 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6727ea7sm21046845ad.61.2025.09.25.03.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:42:56 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 18:42:32 +0800
Subject: [PATCH v2 2/3] coresight: change helper_ops to accept
 coresight_path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-fix_helper_data-v2-2-edd8a07c1646@oss.qualcomm.com>
References: <20250925-fix_helper_data-v2-0-edd8a07c1646@oss.qualcomm.com>
In-Reply-To: <20250925-fix_helper_data-v2-0-edd8a07c1646@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jie Gan <jie.gan@oss.qualcomm.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Carl Worth <carl@os.amperecomputing.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758796966; l=10066;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=/5pkXjPpN0sngp2+34OymDrtqBNoNX+U7d/io6qp5Es=;
 b=MsffQBQWUdHv31AvMS22ul6FI3b0OlhsBajjXz/doH874bxtxhasuYMtcKNlFmlWiF6xuDUNO
 KcGTMe63BuFCIVyFUvUbbz3YcHdaEJi5F/UxjgVQjlY/INrSJadb3RW
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-GUID: KYFUh_1T7e-fQ1BkKIJSYfoujdi_SXps
X-Proofpoint-ORIG-GUID: KYFUh_1T7e-fQ1BkKIJSYfoujdi_SXps
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfX2dH+QTkVGD4Y
 N5frhqdglGDEcZOmJx47j8KfjgHnuEELVA3hpEwSpuzcIJ/q1l5wCMsMPodj8GJ5SGi0Ox5iWrl
 MYRzeFWMVXZG8XaY+/fjkYjPvoLhh27e3TyFeZE4Gtc2STzIHb8hurXSPwBvRKBSVzu/iFAFcX7
 lKtCLSQdgJAly3o8fr+2b4Vflol0Af1+deYf5ZI7j63O/WiW9BejOaNjcIct+Ezop0usu7ZPI2p
 0VsYC1s6gGO1bL5w1H6szC8pUSMIUQWLnkXmGmAZ5TvWXEAcfHD5ySSFEdRlzdrYvI3BeY0Wlow
 ba+XxvXXLhFxfKMiYZvNMbZ04jGpsQVOu8Q8vl++sgwwpjXHJcA8JzFZHy7TE1fLqXywBP9dqCJ
 6d7RFHQ1
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d51cb2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vzhER2c_AAAA:8 a=7CQSdrXTAAAA:8
 a=EUspDBNiAAAA:8 a=Gv9EIBWDmE4dLvOUe8gA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=0YTRHmU2iG2pZC6F1fw2:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

Update the helper_enable and helper_disable functions to accept
coresight_path instead of a generic void *data, as coresight_path
encapsulates all the necessary data required by devices along the path.

Tested-by: Carl Worth <carl@os.amperecomputing.com>
Reviewed-by: Carl Worth <carl@os.amperecomputing.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c      | 10 +++++-----
 drivers/hwtracing/coresight/coresight-core.c      | 20 ++++++++++++--------
 drivers/hwtracing/coresight/coresight-ctcu-core.c |  9 +++------
 drivers/hwtracing/coresight/coresight-cti-core.c  |  5 +++--
 drivers/hwtracing/coresight/coresight-cti.h       |  5 +++--
 drivers/hwtracing/coresight/coresight-tmc-etr.c   |  4 ++--
 drivers/hwtracing/coresight/coresight-tmc.h       |  3 ++-
 include/linux/coresight.h                         |  5 +++--
 8 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index a3ccb7034ae1..69b36bae97ab 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -397,7 +397,7 @@ static int catu_wait_for_ready(struct catu_drvdata *drvdata)
 }
 
 static int catu_enable_hw(struct catu_drvdata *drvdata, enum cs_mode cs_mode,
-			  void *data)
+			  struct coresight_path *path)
 {
 	int rc;
 	u32 control, mode;
@@ -425,7 +425,7 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, enum cs_mode cs_mode,
 	etrdev = coresight_find_input_type(
 		csdev->pdata, CORESIGHT_DEV_TYPE_SINK, etr_subtype);
 	if (etrdev) {
-		etr_buf = tmc_etr_get_buffer(etrdev, cs_mode, data);
+		etr_buf = tmc_etr_get_buffer(etrdev, cs_mode, path);
 		if (IS_ERR(etr_buf))
 			return PTR_ERR(etr_buf);
 	}
@@ -455,7 +455,7 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, enum cs_mode cs_mode,
 }
 
 static int catu_enable(struct coresight_device *csdev, enum cs_mode mode,
-		       void *data)
+		       struct coresight_path *path)
 {
 	int rc = 0;
 	struct catu_drvdata *catu_drvdata = csdev_to_catu_drvdata(csdev);
@@ -463,7 +463,7 @@ static int catu_enable(struct coresight_device *csdev, enum cs_mode mode,
 	guard(raw_spinlock_irqsave)(&catu_drvdata->spinlock);
 	if (csdev->refcnt == 0) {
 		CS_UNLOCK(catu_drvdata->base);
-		rc = catu_enable_hw(catu_drvdata, mode, data);
+		rc = catu_enable_hw(catu_drvdata, mode, path);
 		CS_LOCK(catu_drvdata->base);
 	}
 	if (!rc)
@@ -488,7 +488,7 @@ static int catu_disable_hw(struct catu_drvdata *drvdata)
 	return rc;
 }
 
-static int catu_disable(struct coresight_device *csdev, void *__unused)
+static int catu_disable(struct coresight_device *csdev, struct coresight_path *path)
 {
 	int rc = 0;
 	struct catu_drvdata *catu_drvdata = csdev_to_catu_drvdata(csdev);
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 3267192f0c1c..f44ec9e5b692 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -355,17 +355,20 @@ static bool coresight_is_helper(struct coresight_device *csdev)
 }
 
 static int coresight_enable_helper(struct coresight_device *csdev,
-				   enum cs_mode mode, void *data)
+				   enum cs_mode mode,
+				   struct coresight_path *path)
 {
-	return helper_ops(csdev)->enable(csdev, mode, data);
+	return helper_ops(csdev)->enable(csdev, mode, path);
 }
 
-static void coresight_disable_helper(struct coresight_device *csdev, void *data)
+static void coresight_disable_helper(struct coresight_device *csdev,
+				     struct coresight_path *path)
 {
-	helper_ops(csdev)->disable(csdev, data);
+	helper_ops(csdev)->disable(csdev, path);
 }
 
-static void coresight_disable_helpers(struct coresight_device *csdev, void *data)
+static void coresight_disable_helpers(struct coresight_device *csdev,
+				      struct coresight_path *path)
 {
 	int i;
 	struct coresight_device *helper;
@@ -373,7 +376,7 @@ static void coresight_disable_helpers(struct coresight_device *csdev, void *data
 	for (i = 0; i < csdev->pdata->nr_outconns; ++i) {
 		helper = csdev->pdata->out_conns[i]->dest_dev;
 		if (helper && coresight_is_helper(helper))
-			coresight_disable_helper(helper, data);
+			coresight_disable_helper(helper, path);
 	}
 }
 
@@ -479,7 +482,8 @@ void coresight_disable_path(struct coresight_path *path)
 EXPORT_SYMBOL_GPL(coresight_disable_path);
 
 static int coresight_enable_helpers(struct coresight_device *csdev,
-				    enum cs_mode mode, void *data)
+				    enum cs_mode mode,
+				    struct coresight_path *path)
 {
 	int i, ret = 0;
 	struct coresight_device *helper;
@@ -489,7 +493,7 @@ static int coresight_enable_helpers(struct coresight_device *csdev,
 		if (!helper || !coresight_is_helper(helper))
 			continue;
 
-		ret = coresight_enable_helper(helper, mode, data);
+		ret = coresight_enable_helper(helper, mode, path);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/hwtracing/coresight/coresight-ctcu-core.c b/drivers/hwtracing/coresight/coresight-ctcu-core.c
index c586495e9a08..abed15eb72b4 100644
--- a/drivers/hwtracing/coresight/coresight-ctcu-core.c
+++ b/drivers/hwtracing/coresight/coresight-ctcu-core.c
@@ -156,17 +156,14 @@ static int ctcu_set_etr_traceid(struct coresight_device *csdev, struct coresight
 	return __ctcu_set_etr_traceid(csdev, traceid, port_num, enable);
 }
 
-static int ctcu_enable(struct coresight_device *csdev, enum cs_mode mode, void *data)
+static int ctcu_enable(struct coresight_device *csdev, enum cs_mode mode,
+		       struct coresight_path *path)
 {
-	struct coresight_path *path = (struct coresight_path *)data;
-
 	return ctcu_set_etr_traceid(csdev, path, true);
 }
 
-static int ctcu_disable(struct coresight_device *csdev, void *data)
+static int ctcu_disable(struct coresight_device *csdev, struct coresight_path *path)
 {
-	struct coresight_path *path = (struct coresight_path *)data;
-
 	return ctcu_set_etr_traceid(csdev, path, false);
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
index 8fb30dd73fd2..bfbc365bb2ef 100644
--- a/drivers/hwtracing/coresight/coresight-cti-core.c
+++ b/drivers/hwtracing/coresight/coresight-cti-core.c
@@ -799,14 +799,15 @@ static void cti_pm_release(struct cti_drvdata *drvdata)
 }
 
 /** cti ect operations **/
-int cti_enable(struct coresight_device *csdev, enum cs_mode mode, void *data)
+int cti_enable(struct coresight_device *csdev, enum cs_mode mode,
+	       struct coresight_path *path)
 {
 	struct cti_drvdata *drvdata = csdev_to_cti_drvdata(csdev);
 
 	return cti_enable_hw(drvdata);
 }
 
-int cti_disable(struct coresight_device *csdev, void *data)
+int cti_disable(struct coresight_device *csdev, struct coresight_path *path)
 {
 	struct cti_drvdata *drvdata = csdev_to_cti_drvdata(csdev);
 
diff --git a/drivers/hwtracing/coresight/coresight-cti.h b/drivers/hwtracing/coresight/coresight-cti.h
index 8362a47c939c..4f89091ee93f 100644
--- a/drivers/hwtracing/coresight/coresight-cti.h
+++ b/drivers/hwtracing/coresight/coresight-cti.h
@@ -216,8 +216,9 @@ int cti_add_connection_entry(struct device *dev, struct cti_drvdata *drvdata,
 			     const char *assoc_dev_name);
 struct cti_trig_con *cti_allocate_trig_con(struct device *dev, int in_sigs,
 					   int out_sigs);
-int cti_enable(struct coresight_device *csdev, enum cs_mode mode, void *data);
-int cti_disable(struct coresight_device *csdev, void *data);
+int cti_enable(struct coresight_device *csdev, enum cs_mode mode,
+	       struct coresight_path *path);
+int cti_disable(struct coresight_device *csdev, struct coresight_path *path);
 void cti_write_all_hw_regs(struct cti_drvdata *drvdata);
 void cti_write_intack(struct device *dev, u32 ackval);
 void cti_write_single_reg(struct cti_drvdata *drvdata, int offset, u32 value);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 1040f73f0537..b9bdbc745433 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1325,9 +1325,9 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 }
 
 struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
-				   enum cs_mode mode, void *data)
+				   enum cs_mode mode,
+				   struct coresight_path *path)
 {
-	struct coresight_path *path = data;
 	struct perf_output_handle *handle = path->handle;
 	struct etr_perf_buffer *etr_perf;
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index cbb4ba439158..95473d131032 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -442,7 +442,8 @@ struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
 void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu);
 void tmc_etr_remove_catu_ops(void);
 struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
-				   enum cs_mode mode, void *data);
+				   enum cs_mode mode,
+				   struct coresight_path *path);
 extern const struct attribute_group coresight_etr_group;
 
 #endif
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 2626105e3719..2bee2e3bb1c6 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -424,8 +424,9 @@ struct coresight_ops_source {
  */
 struct coresight_ops_helper {
 	int (*enable)(struct coresight_device *csdev, enum cs_mode mode,
-		      void *data);
-	int (*disable)(struct coresight_device *csdev, void *data);
+		      struct coresight_path *path);
+	int (*disable)(struct coresight_device *csdev,
+		       struct coresight_path *path);
 };
 
 

-- 
2.34.1


