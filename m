Return-Path: <linux-kernel+bounces-729470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59A5B0372D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E9D3B3E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07DF230BC3;
	Mon, 14 Jul 2025 06:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CIAP/AVi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1CB22F77F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752474707; cv=none; b=RNOx4mUny95eQKIlbyb+qj1CLkc7xT1PE9MXGHvfiJJykKQmCZ8uERac9ADcoiIZ8KXWARYH9ZM3eEAs/JFav1w3M2nNe/kGnFYLH3aXwUWpMjcAbyJjNos8iV+mMqs9Ns4nn2v8rrK4PrhoqjGb9hajg/6IQOXmXx/546guGyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752474707; c=relaxed/simple;
	bh=Anj3jVW9a+Pa1dgOxWLH7M4Crke2Y/IpR115q+9YWQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CebVtH41yUAbycpjwB9Se0Ft2NtLFqEJhI4OSOAEhZNMSVNfqgwnW4XK19i/eIfxKNmIKn+TyRRypUS292Smp/5+Cc+LBc7ysuhZbjKRNiUUGtPhB7BkprYwRcL9dS/+gePW69N3V+NUwF7Y5CunrSJlhqBPLOVyyD7WgtbrB1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CIAP/AVi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DKUxFD001550
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CaPwqYvTVd6
	rYAiU/xir9maSYh3Xig6TJw800PT+f8A=; b=CIAP/AVibwwaQKo/HPypRB6/1v9
	Bcwr0AVerASWL8pYyylS9NYngBOCCqsyfnOiJdHeaHgCHkpKN1fAVHViHTkdhfab
	0Tl96Rxt3rYN+NxBz3P83rTqVNP4kf1uPrOcix/nQ6yXWOTzfSOnsEmO2zgPvvaR
	4Mfa4kF0S7xqb3TUl2txRsld+0E6TMZSWQAgUeOFe8Q+WX15skVXYGWTUVnBk/l9
	XnGuQnUVUFiic4qi3H24Djcibm5xgo0tec0og9EPHyU2Q/hll1aLz1omOUPf/lMX
	GPZYbkSnmp2/Vs/H1E7jbUe50JP6B9CvuGpNccrpaCJteyfAOgMMvtblfMQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug37ufff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:31:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235196dfc50so39808265ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 23:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752474703; x=1753079503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaPwqYvTVd6rYAiU/xir9maSYh3Xig6TJw800PT+f8A=;
        b=bnfz3QTv7bCFhYqWNr5qrw2D8LDrzMXoOpTJQY1BQjpSw6n/6yFqv6b8iFDEjIjv9Z
         QLXUVoliXrSojWHOYVZ/ICe91q0jehCpN9woZQqanCCibMiD/ckzC9g2Xt5bzMfpCJNl
         nSTq8xR19D6E69VGQHJ6ETG+YdWtcw58DWCFffZy5s2PdOogqCk1FmMuI/tjUAm7mALu
         JBVuKe/EZoE/l/gmm24vWpAVRN1QpgJmssvZYfsaN6eLOGuj3S6ZnA+WTqBgri80rKga
         B85GMV857dlrNG+qVYj6gGGJOBS8oARta1UzZ3rJJd+MvZ6Aw9FEelHJfD0EwRMDDMl6
         WZUg==
X-Forwarded-Encrypted: i=1; AJvYcCVq8ajFkBasdcVX3B4wmVgfKIhRsq0TTiRcUCYYTwZOmbAFvUyTGsei9J7YhDM9XWkjowxN5JdfDTO8LB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBb+Nno+F5XVbnCucwvfiYeN+L/fZKMzqi6U2PFhqBngz7RV1W
	HCDYgFM8LXhcGxqJcbZLgtUisbjJuisWud7HLg6vb5nbPlDP3/BapspStGiT8LuJa5J9eRWRizW
	eE4WHRp0OSEVYqeF/hpEeLYoTB/K78SKe7hBr9/hAPCCZ3an+jsJdLgZo/CBusefIzb4=
X-Gm-Gg: ASbGnctNYZtDf3ZMGTbIE4+5yQqpbBOZC9tEOAAmnT9eL8CJGFnMmg5E8VXRhqiO8PZ
	RFKmUhyChcNwqoe4GR4AhnZs2H3Sm5OfM8NSTf5cqUxXEw0eDYP4DfflEhBdDGc6OElMUEeAPWa
	ZJ/nVJ7UqLkzI7bvFrno+ONA6J75HNUYmwiLA+R2LgXXzm9RHsAY59hrBnPgVZpZO/BLvhGE3lO
	qDmFdqgM+Ug4+EsFCmYy5oNrTn6yLXpwaph18CjyiF4NKpIsvJzliJqBbDlUtIswRhpf8QkyGqm
	V0lVn4bz3jQ2AR8mdlirndkois+touZtqP3/ZrS7I9BElX61YCijuO59lqe34/Eimv4+pzTUWzW
	/q8U11UwsWhiyH1TGyVDX
X-Received: by 2002:a17:903:5c8:b0:23d:d290:705 with SMTP id d9443c01a7336-23dedd025ddmr105838915ad.3.1752474702538;
        Sun, 13 Jul 2025 23:31:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIkykQ3WqecYjDRbZoeEMeEsOtdC8V/Wbi6Wo9FUj1R+TiKBYdYSUZ6wn5yvJawhfA1R2lWg==
X-Received: by 2002:a17:903:5c8:b0:23d:d290:705 with SMTP id d9443c01a7336-23dedd025ddmr105838615ad.3.1752474702091;
        Sun, 13 Jul 2025 23:31:42 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4334005sm86138255ad.158.2025.07.13.23.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 23:31:41 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Jie Gan <quic_jiegan@quicinc.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 RESEND 05/10] coresight: tmc: add etr_buf_list to store allocated etr_buf
Date: Mon, 14 Jul 2025 14:31:04 +0800
Message-Id: <20250714063109.591-6-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714063109.591-1-jie.gan@oss.qualcomm.com>
References: <20250714063109.591-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAzNyBTYWx0ZWRfX4NSgq1K3GvYx
 8jfRzaQgLpvzjBedBUSRFUWsjb3ADnKfBhIDzFXEGciVLOoDT93f390W3RiXQk9ak1elg96c2i5
 yZh180AkMOTmaFieT0czUUFEk0cor4zI11M/HLoX0/txJjoFtHhAgHTqOBQt3Kef+6qPzliplzv
 er6DlLBIE99BVZiWewqlpJueJhJPhBhaqmPaV2RQr0hG/xwQWFRKYFyZaZPx9YvGThu4sDqlJeG
 mH/xaIArruSIKD/Fs86o9Byx34TVf61Plz6utMHVOdRPECbMqbTeUczQOPJf41B2v5zYlwF7hPU
 Y3VezzuJzhIyxk4PuMaxy4PV4lRPXWt1XW2FBlyGdmI19U/fkzz4esa3D7pGLWHPFEfPUbzHgtw
 WiM8QQkPuLnHn+p0BMhF9B/m3etBkLO30VE6ioB52hFdZ9gQKWg7RVx11aX8QR6eg6XrC76T
X-Proofpoint-GUID: B2gedCh3n3Bsy2Qli0MuI7GZcK_4-OdX
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=6874a44f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ORm1qb0EFYpRwVLUulEA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: B2gedCh3n3Bsy2Qli0MuI7GZcK_4-OdX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140037

Add a list to store allocated etr_buf.

The byte-cntr functionality requires two etr_buf to receive trace data.
The active etr_buf collects the trace data from source device, while the
byte-cntr reading function accesses the deactivated etr_buf after is
has been filled and synced, transferring data to the userspace.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../hwtracing/coresight/coresight-tmc-core.c  |  1 +
 drivers/hwtracing/coresight/coresight-tmc.h   | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index be964656be93..4d249af93097 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -830,6 +830,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 		idr_init(&drvdata->idr);
 		mutex_init(&drvdata->idr_mutex);
 		dev_list = &etr_devs;
+		INIT_LIST_HEAD(&drvdata->etr_buf_list);
 		break;
 	case TMC_CONFIG_TYPE_ETF:
 		desc.groups = coresight_etf_groups;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 6541a27a018e..f6b05639aeca 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -208,6 +208,21 @@ struct tmc_resrv_buf {
 	s64		len;
 };
 
+/**
+ * @sysfs_buf:	Allocated sysfs_buf.
+ * @is_free:	Indicates whether the buffer is free to choose.
+ * @reading:	Indicates whether the buffer is reading.
+ * @pos:	Position of the buffer.
+ * @node:	Node in etr_buf_list.
+ */
+struct etr_buf_node {
+	struct etr_buf		*sysfs_buf;
+	bool			is_free;
+	bool			reading;
+	loff_t			pos;
+	struct list_head	node;
+};
+
 /**
  * struct tmc_drvdata - specifics associated to an TMC component
  * @pclk:	APB clock if present, otherwise NULL
@@ -242,6 +257,8 @@ struct tmc_resrv_buf {
  *		(after crash) by default.
  * @crash_mdata: Reserved memory for storing tmc crash metadata.
  *		 Used by ETR/ETF.
+ * @etr_buf_list: List that is used to manage allocated etr_buf.
+ * @reading_node:  Available buffer for byte-cntr reading.
  */
 struct tmc_drvdata {
 	struct clk		*pclk;
@@ -271,6 +288,8 @@ struct tmc_drvdata {
 	struct etr_buf		*perf_buf;
 	struct tmc_resrv_buf	resrv_buf;
 	struct tmc_resrv_buf	crash_mdata;
+	struct list_head        etr_buf_list;
+	struct etr_buf_node     *reading_node;
 };
 
 struct etr_buf_operations {
-- 
2.34.1


