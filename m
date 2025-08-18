Return-Path: <linux-kernel+bounces-773149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D204B29C02
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83B71961AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8543002DE;
	Mon, 18 Aug 2025 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FLSNhchZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686EC30147B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505398; cv=none; b=JJs25Gvpu/061eTNjmUymDc46qunS91vxqk7+X6rRHc5eDki9JuYMglmF6yVoBJaZcpSELcmVtPnO6J/NdwTzFF8kX+7jbcUyQE9rETm+SqG0D0dnl94yMJQzGvvpx6xdlGMK3LmP/iluitvQHB3M7EJvtkaGQ982Vug/QCu1MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505398; c=relaxed/simple;
	bh=3kVQhSMZncIoSbo7nH2qJTqRNDCOFdRv3QEYdUHeSlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q7Paz5V0DdsvHpB54M+rnGMc2EEfrN9Vax3LcWPJRLEZo58A0tLuVPWuY5QIeHW7LU6bqHtZRWHno4JQLjkxLd9QtFxNaoB/WUc2KWDuqKcC5EAXwIM4guM6hbfRAoLIK+6i8Hdc2uASypy5fumLGgrV59X7hJ3uzlZTCsSOBsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FLSNhchZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HMvAou016840
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	klAiFTBcRJfvFZL9ijQNcijA32Nr8LZgSDlbBt2W7m0=; b=FLSNhchZ/9aU6X8s
	sfyoHfsJd4914VXuGSZ4Lk0wNNLeTuwN3cje7rE/9+XowpK5MsdoenqFwRS8KFOF
	VvSESsOmuXicfU14hPQ/7f3Ne6yuMsPPG7RsnasyWOkw9No/b8TP/fFEgPJGM1Eo
	7ivwlfjIbwFuvlLxM8y0PyT0mJ5LyIzAQL+jmvn1HIkvpjv2xgjzW1m4s73ZEzpb
	GnB4Q6OKhLOeznqUmBFSVKiomF0UwtbTWUr+2uZZ2sLyaJ/rYFTmCWkCqmkxv0Hw
	Tgohmgpcw9NhG+l/E5XS4bnSQtcn9HdfwA7mTyvKC/PyCTC2QVSUfvdVkSIUY41p
	7OOjoQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhjybwva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:23:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24457f59889so39868285ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 01:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755505394; x=1756110194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=klAiFTBcRJfvFZL9ijQNcijA32Nr8LZgSDlbBt2W7m0=;
        b=Xq2aWN53e81CpzY4GUfX8xAcmeXgWhX+BouLmqCyrnP+73/CbU6WPVYqA1zA0s0I5/
         bjsVFNfrPspyXeqd5sk2bDbe40tStWRH+hMehTG9D6s90npJurOgOGkULZ5Uc29ULsw+
         7rd50GFafvJ1lVezyS7MNJTfdpx4QfEc6xiQh2c9QCi+EoksE9Cgim9j1qsDU/wWUWYQ
         Zt4GVPX7N4AE9MGg8CEiLlCVmMK4LbFVNvWhUv9Fc9kR59sT31IZyBLcK3IC6JusVs67
         OGJu83RzCW2sd7gfBVGSB/qfa741dZfxkCBl0sutbJDlNF9fT6qTJckId+KrALdaS/E9
         Ez+g==
X-Forwarded-Encrypted: i=1; AJvYcCUqGiGM0ZEmnqK9ccuZOVQ6VhGaB4ziJ/NSzQQyKTlPWlIE6snA+/6BCvn2QjlftplRCSKwRsphsS0biPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHFoWNR/OEEFDLCJnZdtyhNBkv5+ERNu8P9dKD27smOhfm3HZA
	zF6KMBTUIGgdye9U6NizOrWDbcniuzELSyrnTnq0kVxpFjFuye1FtVIZ9k/9DH3XyHHk1vTCCCC
	PHeboDW8jjGAvwoV1xDeyOur7SplB7pwGtFk0yvcc6e/ttEWkEyyWwRgfpFgEmxvfoxrkg8OlnS
	k=
X-Gm-Gg: ASbGncsiLCPTGoIv6k3YxWqnW5xHZdsY7ED8lmXW2w5ncOizHf7SBlOSEnTMoGRm+We
	1jcXuF1cpB8Yrgj01aj09Tts4VT3dYXvMm7CSHxn5rJF5L745+/CaqNgtHT+j3pP70AUCzgzM+e
	SfqXbN77YVyZvywCNoIzhGMHhfPVl9Dcs53Xrv10JpJN3FaylfvaXXsE9Dj9CmaEEpMnqM7huc/
	+RlKBZLUsbw6y53I+4UldAaSlQj0XE/CnO1xqoqesJspZAxyT2QoAWciYS4Z1WwqTBjh97GXf+S
	JxCHdVPZQNDoXEt/+zUI8lGHTiduXj+Zbtj21eSTwhe+8pcd96NZ5zzbpA2DrKIDrfGZB2BN6Yk
	=
X-Received: by 2002:a17:902:c951:b0:240:22af:91c7 with SMTP id d9443c01a7336-2446d71db3fmr137303335ad.14.1755505393513;
        Mon, 18 Aug 2025 01:23:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEQ4OLfzKDCynU5NX13S90adlyz0mKnEDg9lAHh0oyawGQNe7zcWlBFZqEe/U/0n2KsOjSOw==
X-Received: by 2002:a17:902:c951:b0:240:22af:91c7 with SMTP id d9443c01a7336-2446d71db3fmr137302655ad.14.1755505392641;
        Mon, 18 Aug 2025 01:23:12 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5536c3sm73225155ad.137.2025.08.18.01.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:23:12 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 13:52:53 +0530
Subject: [PATCH v2 1/3] PM/OPP: Support to match OPP based on both
 frequency and level.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-opp_pcie-v2-1-071524d98967@oss.qualcomm.com>
References: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
In-Reply-To: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755505382; l=7541;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=3kVQhSMZncIoSbo7nH2qJTqRNDCOFdRv3QEYdUHeSlM=;
 b=egiIbtEkxg4AJc1GNbqSrjFEc5t9ay4p51jScc4BJHzTdUALgaTbpg5zBkn0ZcohfbL1xyD0L
 6xgPz7bXktkCG/Wzw2LvfSIkvFn07iPkKZ4aQ1SLxlxVwJI1z16cTbu
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: xwxh23guivWmUnqrjT7I7cUvCo64PNGB
X-Authority-Analysis: v=2.4 cv=ZJHXmW7b c=1 sm=1 tr=0 ts=68a2e2f3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=x3cnzf2s5ip7nYLkZs0A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: xwxh23guivWmUnqrjT7I7cUvCo64PNGB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyOCBTYWx0ZWRfX4T4+BqA0xj6J
 2v9znUk+5tU9yEe/7XpAiRzH5zujhgyGBRKb476HOd/fpGSI0JVVkrnSfCnK1j1gN6lk1jz9rFq
 aZTD80tqVMrukVkPztniQKPh37AinbK1IwSbCmPGwQH4tb1BxarNMFd6wwoIY8rqha3qVe6J+1+
 F+TfgfpkRgdwm7UxW3+Lcq9uEBjb5fHGDYKKUIj8GyC4HEvXG8bRIfwg6a+/Ukld6G2F6J4D/Pn
 2yVs3S7h4N2/1q/QF1f0KfUetqwYjNe0o9OdzEI+nxmayjhUZVDTCjSaZ9qkcKVLx7Ms9eLke8c
 ggN1P1/uechUYl/+AUyWK0ZPIy4qQZ+1XUpDR5AQ6bob70Lb4y+JWbtAYTldD/TYqP3tkB+luUd
 EiJcqU3m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160028

Some clients, such as PCIe, may operate at the same clock frequency
across different data rates by varying link width. In such cases,
frequency alone is not sufficient to uniquely identify an OPP.
To support these scenarios, introduce a new API
dev_pm_opp_find_freq_level_exact() that allows OPP lookup using
both frequency and performance level.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/opp/core.c     | 103 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/opp/opp.h      |  13 +++++++
 include/linux/pm_opp.h |  13 +++++++
 3 files changed, 129 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index edbd60501cf00dfd1957f7d19b228d1c61bbbdcc..4aeb394dcd73a1ca70899a887f8a8c4282ec6d57 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -461,6 +461,14 @@ int dev_pm_opp_get_opp_count(struct device *dev)
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
 
 /* Helpers to read keys */
+static unsigned long _read_opp_key(struct dev_pm_opp *opp, int index, struct dev_pm_opp_key *key)
+{
+	key->freq = opp->rates[index];
+	key->level = opp->level;
+
+	return true;
+}
+
 static unsigned long _read_freq(struct dev_pm_opp *opp, int index)
 {
 	return opp->rates[index];
@@ -488,6 +496,21 @@ static bool _compare_exact(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
 	return false;
 }
 
+static bool _compare_opp_key_exact(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
+				   struct dev_pm_opp_key opp_key, struct dev_pm_opp_key key)
+{
+	bool freq_match = (opp_key.freq == 0 || key.freq == 0 || opp_key.freq == key.freq);
+	bool level_match = (opp_key.level == OPP_LEVEL_UNSET ||
+			    key.level == OPP_LEVEL_UNSET || opp_key.level == key.level);
+
+	if (freq_match && level_match) {
+		*opp = temp_opp;
+		return true;
+	}
+
+	return false;
+}
+
 static bool _compare_ceil(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
 			  unsigned long opp_key, unsigned long key)
 {
@@ -541,6 +564,40 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
 	return opp;
 }
 
+static struct dev_pm_opp *_opp_table_find_opp_key(struct opp_table *opp_table,
+		struct dev_pm_opp_key *key, int index, bool available,
+		unsigned long (*read)(struct dev_pm_opp *opp, int index,
+				      struct dev_pm_opp_key *key),
+		bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
+				struct dev_pm_opp_key opp_key, struct dev_pm_opp_key key),
+		bool (*assert)(struct opp_table *opp_table, unsigned int index))
+{
+	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
+	struct dev_pm_opp_key temp_key;
+
+	/* Assert that the requirement is met */
+	if (assert && !assert(opp_table, index))
+		return ERR_PTR(-EINVAL);
+
+	guard(mutex)(&opp_table->lock);
+
+	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
+		if (temp_opp->available == available) {
+			read(temp_opp, index, &temp_key);
+			if (compare(&opp, temp_opp, temp_key, *key))
+				break;
+		}
+	}
+
+	/* Increment the reference count of OPP */
+	if (!IS_ERR(opp)) {
+		*key = temp_key;
+		dev_pm_opp_get(opp);
+	}
+
+	return opp;
+}
+
 static struct dev_pm_opp *
 _find_key(struct device *dev, unsigned long *key, int index, bool available,
 	  unsigned long (*read)(struct dev_pm_opp *opp, int index),
@@ -632,6 +689,52 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
 
+/**
+ * dev_pm_opp_find_freq_level_exact() - Search for an exact frequency and level
+ * @dev:                Device for which the OPP is being searched
+ * @freq:               Frequency to match (in Hz)
+ * @level:              Performance level to match
+ * @available:          true/false - match for available OPP
+ *
+ * Return: Searches for an exact match of frequency and performance level in the
+ * OPP table and returns pointer to the  matching opp if found, else returns ERR_PTR
+ * in case of error and should  be handled using IS_ERR. Error return values can be:
+ * EINVAL:      for bad pointer
+ * ERANGE:      no match found for search
+ * ENODEV:      if device not found in list of registered devices
+ *
+ * Note: available is a modifier for the search. if available=true, then the
+ * match is for exact matching frequency and is available in the stored OPP
+ * table. if false, the match is for exact frequency which is not available.
+ *
+ * This provides a mechanism to enable an opp which is not available currently
+ * or the opposite as well.
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *dev_pm_opp_find_freq_level_exact(struct device *dev,
+						    unsigned long freq,
+						    unsigned int level,
+						    bool available)
+{
+	struct opp_table *opp_table __free(put_opp_table);
+	struct dev_pm_opp_key key;
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		dev_err(dev, "%s: OPP table not found (%ld)\n", __func__,
+			PTR_ERR(opp_table));
+		return ERR_CAST(opp_table);
+	}
+
+	key.freq = freq;
+	key.level = level;
+	return _opp_table_find_opp_key(opp_table, &key, 0, available, _read_opp_key,
+				       _compare_opp_key_exact, assert_single_clk);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_level_exact);
+
 /**
  * dev_pm_opp_find_freq_exact_indexed() - Search for an exact freq for the
  *					 clock corresponding to the index
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 9eba63e01a9e7650cf2e49515b70ba73f72210fc..60bb0042e30f73a8e31c1688e0cb3842cdea09d5 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -249,6 +249,19 @@ struct opp_table {
 #endif
 };
 
+/**
+ * struct dev_pm_opp_key - Key used to identify OPP entries
+ * @freq:       Frequency in Hz
+ * @level:      Performance level associated with the frequency
+ *
+ * This is internal structure, used to help in mapping frequency
+ * and performance level combinations to specific OPP entries.
+ */
+struct dev_pm_opp_key {
+	unsigned long freq;
+	unsigned int level;
+};
+
 /* Routines internal to opp core */
 bool _opp_remove_all_static(struct opp_table *opp_table);
 int _get_opp_count(struct opp_table *opp_table);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index cf477beae4bbede88223566df5f43d85adc5a816..a93f2670da6c2f10aa7ac5ea020fc3ef14fef113 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -131,6 +131,11 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      unsigned long freq,
 					      bool available);
 
+struct dev_pm_opp *dev_pm_opp_find_freq_level_exact(struct device *dev,
+						    unsigned long freq,
+						    unsigned int level,
+						    bool available);
+
 struct dev_pm_opp *
 dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
 				   u32 index, bool available);
@@ -289,6 +294,14 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+struct dev_pm_opp *dev_pm_opp_find_freq_level_exact(struct device *dev,
+						    unsigned long freq,
+						    unsigned int level,
+						    bool available)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline struct dev_pm_opp *
 dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
 				   u32 index, bool available)

-- 
2.34.1


