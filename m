Return-Path: <linux-kernel+bounces-777189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF27B2D65F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FEF17A6CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A682D94AF;
	Wed, 20 Aug 2025 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DhSXmS1D"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228B12D9ED7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678552; cv=none; b=suO3UqT2d0lzTuttPzb6ylox3UvaUMXq80m1i743/wXkeYAmkaz2WGTciZjJy5pOB0BLpLBx/8Wz4cIGC9J7MECfwBx0IcbpsAIsbTFq3IKIcEQTokqNSqpM8E2SzcPvQ8qR6cBXmdvIvlrxRjbsT6gdl2X/VyCpKm838uErY90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678552; c=relaxed/simple;
	bh=qbiTA97ecG75CN8dtvPjbRcNXFdrEC8SJKen2afmr8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VKsysA1xxjZAlMwen3hTJLCsAxh3TqWX/355fGU3Bt9FLuMksgaxNhgpKdR7xcGbqzSFBYJ+7TFcenZc4tV7sAzo5RpjPH4XNGP7hshumHPChV7kfcLf9bI3+2ywAnEKuoNiKqnQ43WKYi5FOe7glXFleKAG/QVn5sesVmkpv5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DhSXmS1D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1od2M027713
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wWW4BGFpCWnZEZLf1V0C0XICc4F6I83lE+aOEu8pGoQ=; b=DhSXmS1D2tEcfEs+
	0F1dr8C9vF75Db1WZpcBehjJyqnZDzAmxIQ/2eeLoQGP3x6SaOX9iU1elAFGoZY3
	Pd787xDJ86WbgVE8OhdGxRlX+Xt4F6zGna6qkpocWZNJ4s0BjNSxlGG3MCxP1mmt
	jwioZudGCfVFco/FfO6AqEi7BpmFOVrdoTRbA8FncN/Dvg7ScApr6WwtPnf/S++l
	Zq+BHogpGSttwdOaZWk4hY1IydOIi2Is880jq365zlQ0o3OWbOdlBkBRA1otn8wa
	fvaRxnSk/vG+TKCkCNqzgO+cWBXmy5sIwl/Ii/hdtSNUhi5Ka40LJYFtGlgRNnFA
	K/lB4g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52arxtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:29:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-244581ce388so142171405ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755678547; x=1756283347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWW4BGFpCWnZEZLf1V0C0XICc4F6I83lE+aOEu8pGoQ=;
        b=p/Ovz1aflp4Ikz9LEQNjaa9OZbe1ywtJzh5/JEwB6hUx2KPFGm81ZZJkjkHOfsuKRG
         zktQkEtsKb/YA3FoD6o7So5SUzFQ3YhoOPLEhk9u4yC4WMjzfJlgLN6wg5bWHek9JUnB
         OCBHMvkTUdPQYVxrl+3/7qb/O8KjhoJrFbVlvLn11W5iATnMTKLZG6yZ74HrN36pxwBj
         P4E8osGT8aOwrC7Y1MNViuBIhnf5dD72KBZghRAhJGn4oOp/Kmq42cPUUQN+WKSoPZ1B
         aGos1ym0Fy65oABu+8GJVsFlnNOcUsoY+n7chK6BgXy5jloVYfOXk/DIPWNuEgT+tO8l
         d4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM99UgBwDB36x5JBx6mFF+3l+Rc4kyUGwWX5MakdOa7cdeJqkLbetKjOyYgmnEcnTbw7QkLRyo+bgaWyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPEBseSwVLPEBJU60Mk4fX+BEu2NvXj7UFuM9MDpmLNR5q4WD4
	YjWNUcd8huiCby0F3NRcMgQ60V5kd948cSTaknh0bHuqdvLgsTdk6erBmeLv/S+T9+jJpJlQJ+0
	baVdDd9HEy3hw8BdUf3Uoiyv6PqbWKlOSYhu0Hz77V6sbJ1hYtDCuTDQF/QfS9rEAJD4=
X-Gm-Gg: ASbGncv7JwoeOWhvj9MAmkE5jnRMt/pyXSi3W/HdP6ZIvrOh5jyJtkGX4/lxDn1JUa6
	bqT6SHvmqKkb8TOMQj8Sy+67cqUj2LG+EzFXnOy5VHZTAHyyeL4CGdY9aJ3VOf+GebC/Id7qoE1
	Pt2URbOAxYirkztORuax9YdqCv07LRJx7hNMLKj/QjFMQe8P3z28GHNf4UUxGfiNXMcyzjA8PCX
	zgvHj6WSLK1aymI0JeQzf0VxzOpwPRFFIn/ddcbqQyy/ewMnLs1GlYU6OC6RqGizct7fKFb3qzQ
	h/zHb/+BuUV9xIsEXZl4L5Evo0MTDy9abgQBMhobPansNEf/HYBkJZXqZXtu2lwVaEYC3cSdgU0
	=
X-Received: by 2002:a17:902:ec88:b0:240:a430:91d with SMTP id d9443c01a7336-245ef0d5915mr22618685ad.10.1755678547495;
        Wed, 20 Aug 2025 01:29:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSJ1H1k68/Z9d58rrQY87Pvbazso9gHhcBZnMUte8gdhBHonHKpDa9vvaIPOQgp3qW13nehA==
X-Received: by 2002:a17:902:ec88:b0:240:a430:91d with SMTP id d9443c01a7336-245ef0d5915mr22618395ad.10.1755678546826;
        Wed, 20 Aug 2025 01:29:06 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed53e779sm19037735ad.160.2025.08.20.01.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:29:06 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 13:58:48 +0530
Subject: [PATCH v4 2/7] OPP: Move refcount and key update for readability
 in _opp_table_find_key()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-opp_pcie-v4-2-273b8944eed0@oss.qualcomm.com>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
In-Reply-To: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755678529; l=1497;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=qbiTA97ecG75CN8dtvPjbRcNXFdrEC8SJKen2afmr8Y=;
 b=Y2kKzNaAKkSTFkX+ee44JG1EL0b6zaOZsUtgDls6JWW7HqrCg8Dons6oSWblDqtIqytD7X1iJ
 PylRDO/5ugsA96VHM0f7uTAOTYikgrV1LorOMCRMWAuPEYWHOKoTpC1
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX+I6WD6N5WK3l
 L20mk2ostcLLnGtyjVbyaK7UpJIaxh2U4dIRTE+MwNHytCMs+N+CgfhF8VAYo4xd0MFhQ0zyo3b
 3A3oDspvex9lZciIKaZVOzWTt0MaY5uhVaiJeNskghajKoP158qoISboAux7AsFryazyKG9kEVW
 P62Vgyr7ztxnVvRewt27u3izGTgs6DdM3zZUf2V9KySqj/sGmD8PGWBKWk6vRUnmzaF42HDHKTV
 ZuDTgspOTTqGKEEtEZ2qP4Zc+pNPnxtpMJ8Y1crNj4kWHO7E1HyihU18EJcJQbLd5ona5giPOdA
 rLq10NgPhIGQTnbDgkGrPNCEFlhdY+T9Ff56X27UiE2gdroYiZsYsB/zNC1p1LIvBw4mjNKrWt5
 hSSySmor3jkCS1M2Ts6H8amgt/mXbg==
X-Authority-Analysis: v=2.4 cv=TIIci1la c=1 sm=1 tr=0 ts=68a58754 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Zg3aejBZfcS9hqUhyUQA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: UpTCJYfziduBuoJPQw26VVSXokhlojHd
X-Proofpoint-GUID: UpTCJYfziduBuoJPQw26VVSXokhlojHd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Refactor _opp_table_find_key() to improve readability by moving the
reference count increment and key update inside the match condition block.

Also make the 'assert' check mandatory instead of treating it as optional.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/opp/core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index a36c3daac39cd0bdd2a1f7e9bad5b92f0c756153..bf49709b8c39271431772924daf0c003b45eec7f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -544,24 +544,22 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
 	/* Assert that the requirement is met */
-	if (assert && !assert(opp_table, index))
+	if (!assert(opp_table, index))
 		return ERR_PTR(-EINVAL);
 
 	guard(mutex)(&opp_table->lock);
 
 	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
 		if (temp_opp->available == available) {
-			if (compare(&opp, temp_opp, read(temp_opp, index), *key))
+			if (compare(&opp, temp_opp, read(temp_opp, index), *key)) {
+				/* Increment the reference count of OPP */
+				*key = read(opp, index);
+				dev_pm_opp_get(opp);
 				break;
+			}
 		}
 	}
 
-	/* Increment the reference count of OPP */
-	if (!IS_ERR(opp)) {
-		*key = read(opp, index);
-		dev_pm_opp_get(opp);
-	}
-
 	return opp;
 }
 

-- 
2.34.1


