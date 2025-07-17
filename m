Return-Path: <linux-kernel+bounces-735394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5196CB08EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859563ACEAC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142872F6F90;
	Thu, 17 Jul 2025 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ScNdyLux"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99FE2F7CEB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760907; cv=none; b=THhLKpY8nPchMR9DQPCvMhGLXgj2rA20UChmzYUVN/Ss4Q1O3XnPFCDjK/2lMBCGDxVfshcKTgnftGAqU8gEWP8hEQJk80gSGjl3cAPaydjpt3xvEsEHOYy2F0JqW04ib/1SNwL/sXA2jJaimSsAGrPk5XxJDiyWQfkLkZIeFuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760907; c=relaxed/simple;
	bh=jlhIkx6diq9WlRmojrtBq8F4olsP5GXgTjT8OL+KpEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YBfx1ncNaCI8hFpl5IjV6qaoq8R1F+QLcArq5LbRhMNBca74VyXRpq+VwmZVV1OfZRMQBL20BNN0FhmQRbLw6LAxmdYhYeERbYv2SJ5X2qlFUZapeh2Gndr9PATzhSkytko9hKYVboRRlkA2Z4ZNlr+oXl6OUFxAgndtB1SiHaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ScNdyLux; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCp07Y025441
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9xig2HXHx1to3G55gqdUrKeettuTHUX6qKmlk40XTRM=; b=ScNdyLuxbmGAmpdM
	sG93gdqNLlQp7MmCogYHk0kSg9xPyiuyTIGPN44LCoMtT84ubJ2vNOk/+rfkb8f9
	ezjNNe7/nKXqAGo0aw6lPKR319ZyV7CJxAXPqJHPZ4ZaMUmheNSuk+3IehWSPT6Y
	M5fp00NWMj4An3wBEi6QM9I/qC1Yva8bWD46KHcUkJ3BDF/JQeyAvISgwHkDr69+
	kLg8f5ENrM8vJqEaYNilodMuDv9SUfFqbkUbPq32/gf7caJftAsoFT0CUrrdITjx
	xk8Sq3L4NuaooZeYA9VwQNwMnGHENwnWJ+dk+71TWL2EWw/osB+4/CMJwLcgITfj
	hHPfQA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsqc3pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:01:44 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-748e6457567so1384362b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760903; x=1753365703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xig2HXHx1to3G55gqdUrKeettuTHUX6qKmlk40XTRM=;
        b=hRT9VjKFGzBdvEMgLYygVDPWn9FesH/Wd4dbNr21kTMjcCg7sr1hZoTpjxI8J15SXq
         +b003ewAuWVjsk3VycpDloH291PIdqnzqvOUOD/9bz3xeTUDw/p8L5PPSB1fkTYcfHUd
         lhSdMaXy7WfUrGQQ67UHqj5ACpKOC0MXjj4LD1HO8hz85nlWBKvY6lHt+8vJH4WO9OyS
         LiyoE5G1oGdeBFlMoo5yYTFkhu80D/Mds/kLcnWtdINbWgIZuvZWxuiMVpYgZM/qnvSu
         VP82LOx8ZGOowLpvxIkih/GlRUYRWfgTwoQrlj8Wd5uVjT2Sdd4EKFSToG7/e6M24Yq9
         j73w==
X-Forwarded-Encrypted: i=1; AJvYcCUHC190gOSbrEYCvVPkE6u9sruA02aJFlTtbU2ANXszgYawJuhK0E5C+X/d42y77HrGVM2F6FlyHqlyAV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2/RcWyKW/JoiK+3bhoZ+H8v/iNW/t/nHd8RjiLKklsrF4dcUx
	J3ZduUDYEJj3C9I3WUMJ6DgimVW+syrHWauyegIqOWoQILh5Q+a7hQ/npLIzEXQvfcSAU/ZMWDe
	KjTMhBaJrbLVMwpzurFnlmpURKrDVCXFndm9tu9p1omzenUtxgb6oROJC5XpLWLfFaZg=
X-Gm-Gg: ASbGnctC0rJgdhZE2wbj71S0AwVDgABRYRazia1OZkU3LJz1B5Spg9HS0zbgmCjvTrZ
	excEcEvv3yAX7GSVkU9b3mDeziV5ayVP2B/sUoCEnyIN7CxS2sM21AWfx4poNF2ripQ58vlQ8cE
	YboCZMSCSyJylkv1wNtG7rxnAQz2cUGndAw+sOB6PSTxlsMdBm7cKOFPMZixHLvflEBLJOAVr7b
	V7Wu3aGhBbHxpOQBIX/bmytifCgJTV/SCkATYz7Gl3otFVQCc9PUBQlza5G6tRivfCHYzu/FM9+
	zr9+7XQArstjcy4GvEOioM9CHBkmO85KYZnjvcxr2G8OeaSjz2bu6hFR0+dRn2NBoVxpKgVoNxo
	=
X-Received: by 2002:a05:6a00:9445:b0:736:4e14:8ec5 with SMTP id d2e1a72fcca58-758380738a0mr4957760b3a.11.1752760902412;
        Thu, 17 Jul 2025 07:01:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4xyAX6GCHnhDHyeS91ZUNXI9BnUzD+Nm9EIHYAe96nb/taBHl9/Onvn9mLeuEMU7u8nwmkA==
X-Received: by 2002:a05:6a00:9445:b0:736:4e14:8ec5 with SMTP id d2e1a72fcca58-758380738a0mr4957591b3a.11.1752760900999;
        Thu, 17 Jul 2025 07:01:40 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7507a64b57dsm10311986b3a.14.2025.07.17.07.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:01:40 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 19:31:16 +0530
Subject: [PATCH 1/3] opp: Add bw_factor support to adjust bandwidth
 dynamically
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-opp_pcie-v1-1-dde6f452571b@oss.qualcomm.com>
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
In-Reply-To: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752760888; l=5030;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=jlhIkx6diq9WlRmojrtBq8F4olsP5GXgTjT8OL+KpEA=;
 b=5uEe6o72g+JGjtsw48Rq1U6YmW/Kid72G3Sf6e7D19WkLLo8wVq/qYnZwwFbd4wbuewEvcLIn
 xBUqCgEkUZWA24PPKj5eY8E6NjeUNuFzWpk0YEiwpwW853T4ZriLRSI
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=68790248 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=fQ16MQn1BotIw16Uv_wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: ALnqATlPMMNl_lbm0kx5mLV57e5e6SSJ
X-Proofpoint-GUID: ALnqATlPMMNl_lbm0kx5mLV57e5e6SSJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyMyBTYWx0ZWRfX0031OuTJ7zyc
 7V7dgvQibNYxrDxkooQ2zAjHgGC7/yz0RD4Dyhh9S8VYIdmR6BvAEY/wEoptGG+ETR/Gt/wJYvm
 XYYwDF1FM46yQWnPq5JR5vGqXWU+Rtl1R9Z9EFURkKp0Pcp6HayfMJYY2Itd02LZCMWHWnE7/Xe
 LoYB+NiZPuiWBH5T5HtKNEshdDDe3HWda/AfvOn6P6DQYO0TorTACJyDVXJU6M8ca/6/FfDgYux
 0DjnjSzOVFAUsQ6lAO0CIARdiH7ypY9cuytfK7YexfaUdQ0AUkirfDtcw+G7f/ADAkASbdCeseT
 vPf0SucOEfdD35sjp5XUvaxSosXe6+tIaoF0wygynwtBPAFIsfdATPSCAtsSXU70mf+gfrt8+Dt
 VHwEVe9P34r4g6VIKpi8554q1auj05f6kUpNNwor/4WdOgvAUbQ8Xd55R1LlRuo2D9Bw5AxE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170123

The existing OPP table in the device tree for PCIe is shared across
different link configurations such as data rates 8GT/s x2 and 16GT/s x1.
These configurations often operate at the same frequency, allowing them
to reuse the same OPP entries. However, 8GT/s and 16 GT/s may have
different characteristics beyond frequency—such as RPMh votes in QCOM
case, which cannot be represented accurately when sharing a single OPP.

To avoid conflicts and duplication in the device tree, we now define only
one set of OPP entries per table and introduce a new mechanism to adjust
bandwidth dynamically using a `bw_factor`.

The `bw_factor` is a multiplier applied to the average and peak bandwidth
values of an OPP entry. This allows PCIe drivers to modify the effective
bandwidth at runtime based on the actual link width without needing
separate OPP entries for each configuration.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/opp/core.c     | 37 +++++++++++++++++++++++++++++++++++--
 drivers/opp/opp.h      |  2 ++
 include/linux/pm_opp.h |  7 +++++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index edbd60501cf00dfd1957f7d19b228d1c61bbbdcc..bd618fd1a36fa9c252408beb35ac2e39bfb17ee5 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1060,8 +1060,8 @@ static int _set_opp_bw(const struct opp_table *opp_table,
 			avg = 0;
 			peak = 0;
 		} else {
-			avg = opp->bandwidth[i].avg;
-			peak = opp->bandwidth[i].peak;
+			avg = opp->bandwidth[i].avg * opp_table->bw_factor;
+			peak = opp->bandwidth[i].peak * opp_table->bw_factor;
 		}
 		ret = icc_set_bw(opp_table->paths[i], avg, peak);
 		if (ret) {
@@ -1461,6 +1461,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 			 __func__, ret);
 	}
 
+	opp_table->bw_factor = 1;
 	BLOCKING_INIT_NOTIFIER_HEAD(&opp_table->head);
 	INIT_LIST_HEAD(&opp_table->opp_list);
 	kref_init(&opp_table->kref);
@@ -2815,6 +2816,38 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
 	return 0;
 }
 
+/**
+ * dev_pm_opp_set_bw_factor() - helper to change the bw factor
+ * @dev:		device for which we do this operation
+ * @bw_factor:		bw factor which multiples the supplied bw
+ *
+ * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
+ * copy operation, returns 0 if no modifcation was done OR modification was
+ * successful.
+ */
+int dev_pm_opp_set_bw_factor(struct device *dev, u8 bw_factor)
+{
+	struct opp_table *opp_table __free(put_opp_table);
+	int r;
+
+	/* Find the opp_table */
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		r = PTR_ERR(opp_table);
+		dev_warn(dev, "%s: Device OPP not found (%d)\n", __func__, r);
+		return r;
+	}
+
+	if (opp_table->bw_factor == bw_factor)
+		return 0;
+
+	scoped_guard(mutex, &opp_table->lock)
+		opp_table->bw_factor = bw_factor;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_bw_factor);
+
 /**
  * dev_pm_opp_adjust_voltage() - helper to change the voltage of an OPP
  * @dev:		device for which we do this operation
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 9eba63e01a9e7650cf2e49515b70ba73f72210fc..f52d8582b705f1dcf8b5c8279716d38acb273a6c 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -192,6 +192,7 @@ enum opp_table_access {
  * property).
  * @paths: Interconnect path handles
  * @path_count: Number of interconnect paths
+ * @bw_factor: Multiplier to the supplied bw
  * @enabled: Set to true if the device's resources are enabled/configured.
  * @is_genpd: Marks if the OPP table belongs to a genpd.
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
@@ -240,6 +241,7 @@ struct opp_table {
 	int regulator_count;
 	struct icc_path **paths;
 	unsigned int path_count;
+	u8 bw_factor;
 	bool enabled;
 	bool is_genpd;
 
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index cf477beae4bbede88223566df5f43d85adc5a816..4b090fd7391975ab3fa9a94e939325de946cadfa 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -170,6 +170,8 @@ int dev_pm_opp_add_dynamic(struct device *dev, struct dev_pm_opp_data *opp);
 void dev_pm_opp_remove(struct device *dev, unsigned long freq);
 void dev_pm_opp_remove_all_dynamic(struct device *dev);
 
+int dev_pm_opp_set_bw_factor(struct device *dev, u8 bw_factor);
+
 int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 			      unsigned long u_volt, unsigned long u_volt_min,
 			      unsigned long u_volt_max);
@@ -371,6 +373,11 @@ static inline void dev_pm_opp_remove_all_dynamic(struct device *dev)
 {
 }
 
+static inline int dev_pm_opp_set_bw_factor(struct device *dev, u8 bw_factor)
+{
+	return 0;
+}
+
 static inline int
 dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
 			  unsigned long u_volt, unsigned long u_volt_min,

-- 
2.34.1


